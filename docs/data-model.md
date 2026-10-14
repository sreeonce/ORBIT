# ORBIT: Firestore data model (draft v1)

## Design rules

1. Firestore security rules work per document, not per field. Anything only some people may see (the exact table) lives in a separate document from what everyone sees (the venue-level pin and emoji).
2. A rejected request looks like an expired request. The owner sets `status: rejected`, and the requester's app shows it as "Expired". The word "rejected" is never shown to the requester.
3. Both phones read time from a server timestamp. `startedAt` is a server timestamp, and each phone computes its own countdown from it.

## Collections

```
users/{uid}
  createdAt            timestamp
  over18Confirmed      bool
  fcmTokens            array<string>      (push notification tokens)

  users/{uid}/blocks/{blockedUid}
    createdAt          timestamp

venues/{venueId}                           (seeded by me, read-only to the app)
  name                 string
  type                 string             (library | cafe)
  areaId               string             (e.g. "uoa-city")
  location             geopoint
  active               bool

beacons/{beaconId}                         (PUBLIC: any signed-in user can read)
  ownerId              string
  venueId              string
  venueName            string             (copied from the venue to save reads)
  areaId               string
  location             geopoint           (venue level only, never the table)
  emoji                string
  activity             string
  seatsFree            number
  status               string             (live | full | ended)
  createdAt            timestamp
  expiresAt            timestamp

  beacons/{beaconId}/private/details       (PRIVATE: owner and accepted requester only)
    tableNote          string             (exact table, e.g. "Level 2, window desk")

requests/{requestId}
  beaconId             string
  ownerId              string
  requesterId          string
  status               string             (pending | accepted | rejected)
  createdAt            timestamp
  expiresAt            timestamp          (pending requests lapse on their own)

sessions/{sessionId}
  beaconId             string
  participantIds       array<string>      (owner + joiner)
  phase                string             (confirming | focus | intermission | ended)
  focusMinutes         number
  breakMinutes         number
  startedAt            timestamp          (SERVER timestamp, source of truth for the timer)
  confirmed            map<uid, bool>     (who has passed the proximity check)

  sessions/{sessionId}/private/code        (owner only)
    code               string             (short code shown at the table)

reports/{reportId}                         (the app can create, never read)
  reporterId           string
  reportedUid          string
  beaconId             string?            (optional context)
  sessionId            string?
  reason               string
  createdAt            timestamp
```

## Feature check

| Feature | How the model supports it |
|---|---|
| Map with seeded beacons | Stream `beacons` where `status == live` and `areaId == "uoa-city"`, newest first. |
| Create beacon | Writes `beacons/{id}` (owner, venue, emoji, activity, seatsFree, status live, times) and `beacons/{id}/private/details` (tableNote). |
| Privacy tiers | Everyone sees the venue pin and emoji from `beacons`. The exact table is in `private/details`, which the rules let only the owner and an accepted requester read. |
| Request, accept, reject | Owner inbox: `requests` where `ownerId == me` and `status == pending`. Requester status: `requests` where `requesterId == me`. |
| Rejection looks expired | The requester's app shows `rejected` as "Expired". The mapping happens in the UI layer only. |
| Push notifications | Tokens are stored in `users/{uid}.fcmTokens`. |
| Proximity and short code | The phone's location is compared with `beacons.location` using geolocator (radius to decide, e.g. 50 m). The owner reads the code from `sessions/{id}/private/code`, and the joiner types it in. |
| Synced Pomodoro | Both phones read `phase`, `startedAt` and `focusMinutes`, and compute the time left locally. |
| Intermission | It is a `phase` value (`intermission`) on the same session document. |
| Block | Blocked users are stored in `users/{uid}/blocks`. In v1 the app hides their beacons and requests. |
| Report | Reports are write-only for the app. Only I can read them in the console. |
| Account deletion | Remove the user's beacons, requests, blocks and user document, then delete the auth account. |

## Open decisions

- **Map queries:** one launch area means querying by `areaId` is enough. Geohash queries are only needed if I add more cities.
- **Account deletion:** a Cloud Function would delete everything cleanly, but it needs Firebase's paid Blaze plan. The alternative is deleting from the app in batches before removing the account. Decide in Week 3.
- **Stale beacons:** a beacon ends when `expiresAt` passes. The app hides expired beacons immediately, and a Firestore TTL policy can delete them later.
- **Blocks:** v1 filters blocked users in the app. Enforcing it in the security rules is stricter but more complex, so leave it for later.

## Indexes expected

- `beacons`: `areaId` + `status` + `createdAt`
- `requests`: `ownerId` + `status` + `createdAt`
- `requests`: `requesterId` + `createdAt`

Firestore prints a link to create each missing index the first time a query needs one.
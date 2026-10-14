# ORBIT: v1 cut list

v1 goal: a working Android app on Google Play where someone can post a beacon, someone else can request to sit, and the two of them do a synced focus session with safety tools. Anything that doesn't serve that goes on this list.

## Out of v1

| Cut | Why |
|---|---|
| **Chat** | Chat needs moderation, abuse handling and more safety work. ORBIT is "parallel play", so people share a table and a timer, not a conversation. |
| **User profiles** | No bios, photos or public identities. Fewer profiles means less personal data, an easier Data Safety form and less risk. Sign-in with Google is the only identity. |
| **Ratings and reviews** | Ratings add pressure and social risk, which goes against "low-stakes". They also need moderation. |
| **Bluetooth proximity** | Needs extra permissions and more device-specific testing. Location (GPS geofence) plus the short code at the table is enough to confirm someone is there. |
| **iOS** | One platform keeps the 4-week plan realistic. The Flutter code can add iOS later. |

## Also out of v1 (extra cuts, remove any you disagree with)

- Multiple cities or areas. v1 launches in one area.
- Photos or uploads of any kind.
- Friend lists, followers or saved people.
- Sign-in methods other than Google.
- Ads and in-app purchases.
- Web and desktop versions.

## In v1

- Google sign-in
- Map with beacons, with a venue-level pin and emoji
- Create beacon (activity, venue, seats free)
- Request to sit, with accept and reject (a rejection looks like an expired request)
- Exact table revealed only after acceptance
- Push notifications
- Proximity confirmation (geofence plus short code)
- Silent Contract: synced Pomodoro, vibration at zero, focus screen, 10-minute intermission
- Block, report and account deletion
- Privacy policy and Play listing (18+ audience)

## The rule

If a new idea isn't in the "In v1" list, it waits until after launch. When I feel tempted, I write it under "Later" below and keep going.

## Later (ideas after launch)

-
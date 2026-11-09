# GradJournal

A one-page website for planning UK taught master's applications for **September 2027 entry**.

- **30 universities** with their deadline system (rounds, course deadlines, rolling or a single final date), key 2027 dates, application fees, deposits and links to each university's full list of taught courses
- **"What's first up" tabs**: deadlines in the next 60 days, my shortlist, rolling-admission universities and scholarship dates
- **Deadline timeline** grouped by month, with anything within 30 days in red
- **Application diary**: dated entries for research, writing, applications, interviews and offers
- **Documents checklist** with a progress bar

University facts were checked on 9 November 2026. Deadlines change, so always confirm on the official course page before applying.

## Run it

It's a single HTML file with no build step. Open `index.html` in a browser.

## Publish with GitHub Pages

1. Go to **Settings → Pages** in this repository.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Pick the `main` branch and the `/ (root)` folder, then **Save**.
4. After a minute the site is live at `https://<your-username>.github.io/<repo-name>/`.

## Accounts and saved data

Visitors can **sign up with email and password** and log in to see their saved diary, shortlist and checklist on any device. Accounts and data are stored in Supabase (project `gradjournal`):

- `diary_entries`: one row per diary entry
- `user_state`: each user's shortlist and checklist ticks

Row Level Security is on for both tables, so each user can only read and change their own rows. The key in `index.html` is Supabase's public **anon** key, which is safe in browser code because of these policies. The table setup is in `supabase/migrations/`.

Without an account, entries are saved in the browser only. When someone logs in, anything saved in that browser is moved into their account.

### Supabase settings for the live site

In the Supabase dashboard, open **Authentication → URL Configuration** and set:

- **Site URL**: `https://fransisca-n-d.github.io/gradjournal/`
- **Redirect URLs**: add `https://fransisca-n-d.github.io/gradjournal/`

This makes the sign-up confirmation and password-reset emails link back to the site.

## Updating university data

All university facts live in the `UNIS` array near the top of the `<script>` in `index.html`. Each entry has:

- `sys`: `rounds`, `fixed`, `rolling` or `final`
- `dates`: `["YYYY-MM-DD", "what happens"]` pairs
- `facts`: label/value pairs shown on the card
- `links`: `[label, url]` pairs

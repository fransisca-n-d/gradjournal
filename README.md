# GradJournal

A one-page website for planning UK taught master's applications for **September 2027 entry**.

- **30 universities** with their deadline system (rounds, course deadlines, rolling or a single final date), key 2027 dates, application fees, deposits and links to each university's full list of taught courses
- **"What's first up" tabs**: deadlines in the next 60 days, my shortlist, rolling-admission universities and scholarship dates
- **Deadline timeline** grouped by month, with anything within 30 days in red
- **Diary first**: the page opens on your journey. Dated entries for research, writing, applications, interviews and offers. Add a course to an entry and it gets its own checklist (statement, references, fee, submitted, decision, deposit, CAS), progress bar, countdown and your own extra steps
- **Shared documents** checklist for things you prepare once (transcript, passport, IELTS, CV…)
- **Journey road** in the diary: nine milestones from research to visa, with the GradJournal beaver standing at the furthest one you've reached

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

- `diary_entries`: one row per diary entry; entries with a `course` also store that application's `deadline`, `checked` steps and `custom` steps
- `user_state`: each user's shortlist and shared-document ticks

Row Level Security is on for every table, so each user can only read and change their own rows. The key in `index.html` is Supabase's public **anon** key, which is safe in browser code because of these policies. The table setup is in `supabase/migrations/`.

Without an account, entries are saved in the browser only. When someone logs in, anything saved in that browser is moved into their account.

### Supabase settings for the live site

In the Supabase dashboard, open **Authentication → URL Configuration** and set:

- **Site URL**: `https://fransisca-n-d.github.io/gradjournal/`
- **Redirect URLs**: add `https://fransisca-n-d.github.io/gradjournal/`

This makes the sign-up confirmation and password-reset emails link back to the site.

## Privacy and account controls

- **Privacy note** on the page (`#privacy`) explains what is stored, where, and who can see it.
- **Account** (shown above the diary when logged in): *Download my data* (JSON) and *Delete my account* (type DELETE to confirm). Deletion calls the `delete_my_account()` database function, which can only delete the caller's own account; their diary and settings are removed with it.
- Passwords must be at least 10 characters with letters and a number.

## Security setup checklist (Supabase dashboard)

1. **URL Configuration**: Site URL and a Redirect URL set to `https://fransisca-n-d.github.io/gradjournal/`.
2. **Password rules**: Authentication → Sign In / Providers → Email: minimum length 10, require letters and digits.
3. **Bot protection (Cloudflare Turnstile)**
   1. Create a free Turnstile widget in the Cloudflare dashboard for the hostname `fransisca-n-d.github.io`.
   2. Put its **site key** (public) in `TURNSTILE_SITEKEY` in `index.html` and deploy.
   3. Only then: Authentication → Bot and Abuse Protection → enable CAPTCHA, provider Turnstile, paste the **secret key**.
   (Doing step 3 before step 2 would block every sign-up and log-in.)
4. **Email sending**: connect a custom SMTP provider under Authentication → Emails → SMTP Settings, then raise the email rate limit under Rate Limits.
5. **Email templates**: paste `supabase/templates/confirm-signup.html` and `reset-password.html` into Authentication → Emails → Templates (subjects are in the comment at the top of each file).

## Updating university data

All university facts live in the `UNIS` array near the top of the `<script>` in `index.html`. Each entry has:

- `sys`: `rounds`, `fixed`, `rolling` or `final`
- `dates`: `["YYYY-MM-DD", "what happens"]` pairs
- `facts`: label/value pairs shown on the card
- `links`: `[label, url]` pairs

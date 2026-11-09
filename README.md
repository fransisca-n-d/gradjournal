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

## Where data is saved

On GitHub Pages, diary entries, the shortlist and checklist ticks are saved in your browser (localStorage). They stay on that browser and device only. Clearing browser data deletes them.

## Updating university data

All university facts live in the `UNIS` array near the top of the `<script>` in `index.html`. Each entry has:

- `sys`: `rounds`, `fixed`, `rolling` or `final`
- `dates`: `["YYYY-MM-DD", "what happens"]` pairs
- `facts`: label/value pairs shown on the card
- `links`: `[label, url]` pairs

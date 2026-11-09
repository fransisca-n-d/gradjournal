-- Diary entries: one row per entry, owned by the signed-in user
create table public.diary_entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  entry_date date not null,
  uni text not null default '',
  kind text not null check (kind in ('Research','Writing','Applied','Interview','Offer','Rejected','Funding','Note')),
  body text not null check (char_length(body) between 1 and 5000),
  created_at timestamptz not null default now()
);
create index diary_entries_user_idx on public.diary_entries (user_id, entry_date desc);

-- Per-user settings: shortlist and checklist ticks
create table public.user_state (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  shortlist text[] not null default '{}',
  checked jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.diary_entries enable row level security;
alter table public.user_state enable row level security;

create policy "Users read own entries" on public.diary_entries for select to authenticated using ((select auth.uid()) = user_id);
create policy "Users add own entries" on public.diary_entries for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Users edit own entries" on public.diary_entries for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Users delete own entries" on public.diary_entries for delete to authenticated using ((select auth.uid()) = user_id);

create policy "Users read own state" on public.user_state for select to authenticated using ((select auth.uid()) = user_id);
create policy "Users add own state" on public.user_state for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Users edit own state" on public.user_state for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);

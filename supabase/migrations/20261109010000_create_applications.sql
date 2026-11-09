-- One row per university + course a user is applying to, with its own checklist
create table public.applications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  uni text not null,
  course text not null check (char_length(course) between 1 and 200),
  deadline date,
  checked jsonb not null default '{}'::jsonb,
  custom jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);
create index applications_user_idx on public.applications (user_id, created_at);

alter table public.applications enable row level security;

create policy "Users read own applications" on public.applications for select to authenticated using ((select auth.uid()) = user_id);
create policy "Users add own applications" on public.applications for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Users edit own applications" on public.applications for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Users delete own applications" on public.applications for delete to authenticated using ((select auth.uid()) = user_id);

-- A diary entry with a course becomes an application with its own checklist
alter table public.diary_entries
  add column course text check (course is null or char_length(course) between 1 and 200),
  add column deadline date,
  add column checked jsonb not null default '{}'::jsonb,
  add column custom jsonb not null default '[]'::jsonb;

-- Applications now live in diary_entries; the separate table is no longer used (it held no rows)
drop table public.applications;

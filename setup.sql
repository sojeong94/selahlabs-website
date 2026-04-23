-- Supabase SQL Editor에서 실행
-- selahlabs.app 이메일 수집 waitlist 테이블

create table if not exists public.waitlist (
  id         uuid primary key default gen_random_uuid(),
  email      text not null unique,
  source     text default 'selahlabs.app',
  created_at timestamptz default now()
);

-- RLS: 삽입은 누구나, 조회는 본인 이메일만
alter table public.waitlist enable row level security;

create policy "allow insert" on public.waitlist
  for insert with check (true);

create policy "no select for anon" on public.waitlist
  for select using (false);

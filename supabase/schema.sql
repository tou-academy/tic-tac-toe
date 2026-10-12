-- Run this once in the Supabase SQL Editor.

create table if not exists public.games (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  -- 9 characters, one per square: X, O or - (empty). Example: 'XO--X---O'
  board       text not null default '---------' check (board ~ '^[XO-]{9}$'),
  difficulty  text not null default 'medium' check (difficulty in ('easy','medium','hard')),
  status      text not null default 'in_progress' check (status in ('in_progress','won','lost','draw')),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

create index if not exists games_user_updated_idx on public.games (user_id, updated_at desc);

-- Row Level Security: every player can only see and change their own games.
alter table public.games enable row level security;

create policy "Players read own games"   on public.games for select to authenticated using (auth.uid() = user_id);
create policy "Players insert own games" on public.games for insert to authenticated with check (auth.uid() = user_id);
create policy "Players update own games" on public.games for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Players delete own games" on public.games for delete to authenticated using (auth.uid() = user_id);

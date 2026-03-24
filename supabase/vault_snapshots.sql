create table if not exists public.vault_snapshots (
  user_id uuid primary key references auth.users (id) on delete cascade,
  encrypted_blob text not null,
  updated_at timestamptz not null default now()
);

alter table public.vault_snapshots enable row level security;

create policy "Users can read their own encrypted snapshot"
on public.vault_snapshots
for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can insert their own encrypted snapshot"
on public.vault_snapshots
for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Users can update their own encrypted snapshot"
on public.vault_snapshots
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

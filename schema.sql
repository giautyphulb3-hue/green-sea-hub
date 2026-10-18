-- Green Sea · Bảng điều hành marketing
-- Chạy file này 1 lần trong Supabase: SQL Editor → New query → dán → Run

-- 1. Bảng dữ liệu chung (mọi mục: việc, báo cáo, số liệu, ngân sách...)
create table if not exists public.docs (
  collection text not null,
  id text not null,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (collection, id)
);

-- 2. Chỉ người đã đăng nhập (được mời) mới đọc, ghi được
alter table public.docs enable row level security;
drop policy if exists "docs_select" on public.docs;
drop policy if exists "docs_insert" on public.docs;
drop policy if exists "docs_update" on public.docs;
drop policy if exists "docs_delete" on public.docs;
create policy "docs_select" on public.docs for select to authenticated using (true);
create policy "docs_insert" on public.docs for insert to authenticated with check (true);
create policy "docs_update" on public.docs for update to authenticated using (true) with check (true);
create policy "docs_delete" on public.docs for delete to authenticated using (true);

-- 3. Cập nhật một phần nội dung (ví dụ chỉ đổi trạng thái việc)
create or replace function public.merge_doc(c text, i text, patch jsonb)
returns void language sql security invoker as $$
  insert into public.docs (collection, id, data) values (c, i, patch)
  on conflict (collection, id) do update
    set data = public.docs.data || excluded.data, updated_at = now();
$$;

-- 4. Cập nhật tức thời giữa các máy (ai sửa, người khác thấy ngay)
do $$ begin
  alter publication supabase_realtime add table public.docs;
exception when duplicate_object then null; end $$;

-- 5. Kho ảnh minh chứng cho báo cáo ngày
insert into storage.buckets (id, name, public) values ('anh', 'anh', true)
on conflict (id) do nothing;
drop policy if exists "anh_upload" on storage.objects;
drop policy if exists "anh_read" on storage.objects;
create policy "anh_upload" on storage.objects for insert to authenticated with check (bucket_id = 'anh');
create policy "anh_read" on storage.objects for select using (bucket_id = 'anh');

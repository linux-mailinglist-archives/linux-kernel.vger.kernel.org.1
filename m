Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF50F2F290A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbhALHjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhALHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:39:50 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03AEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:39:09 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n142so1136802qkn.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IkpJDvtZvGwqRd/bRaUh2mTQrFzSQq4XloN5iGCBFDc=;
        b=oe6gvQi2kx50Gdj9rXjqxy00zU/eiVrSHYgqygwmAfv73Eobya5vse243cmNYjwkn7
         22aDRnG3DfNb016L2G8jATSe8ZY1SWckEUJc+w68MHbnJpsX20liXXksfbf9EXqoIRPZ
         I9iniqUkdCHOxivRndbE9mRHzr1zhOkx4IVzqxHHA+BW1kXt6uxo0qpyJmJExKqY4Irn
         hcowi0DwUAP3JvVj7y3LWCLuLqBxz4QEbBijjx8RUeeUCPvW3vreeVyVJoCBdETxXVgR
         YTMszu+TMhtbGeK6JFGYYgn41ez9V8ylcm1efWrFjMD2+LTlLH3riu1B0h8VZcN7uRsJ
         DsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IkpJDvtZvGwqRd/bRaUh2mTQrFzSQq4XloN5iGCBFDc=;
        b=W1nyGxvga8DIWElExHqxgsqNqrZAlMMbvfIkiFvpPCo/lu3Gcs4iaf8lybEsZzDdmO
         HUoGO31t+GCl32j7DNadGlQm5UHFnASea/BVu4VYMJn31l9oKPb7cwQ+6IqhTTcrpnyl
         gwM1trUDv81JEJQALevQq/EeSGV2Jsrymri4H5CZghCWxpap0lmHzaG50oB2EXoYTE7L
         I1UAhM1zUwsqazjvZPaAe3s6Yr++9oCF7kNGgetZGLOxZBAQy6Bdt71C1KZ/kv5DhL+5
         K5wXmDViBIOcwYxPpwIb9eAmcVUh+A24QfYEppQ2oZhsG8Tnna2FetnYhy0ocuhL6z4A
         FkSQ==
X-Gm-Message-State: AOAM533kDrBaC2B4rec+/X5VRLRgWtkJbX0K04MAFf1mnCrX02h/5QaE
        hT3VI+dhjlktQCxbFUU1cj26fuFKyhYge/Q+upkkrw==
X-Google-Smtp-Source: ABdhPJw8PjUVxmukKhLLywzwNNtbUS0hU45t04cKkDIQqykWKkjp8ZGWVtZxb1Ukkjrw2OWR9RvySzSIk0BEJdDpDDQ=
X-Received: by 2002:a37:70d:: with SMTP id 13mr3138126qkh.326.1610437148338;
 Mon, 11 Jan 2021 23:39:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <ec89a6eef2254602f5134d676242c0da43fb4caa.1609871239.git.andreyknvl@google.com>
In-Reply-To: <ec89a6eef2254602f5134d676242c0da43fb4caa.1609871239.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 12 Jan 2021 08:38:54 +0100
Message-ID: <CAG_fn=V8mfR4M26AGtSiGopCwuawXq8nu4qKTNTXHWQHnMaSig@mail.gmail.com>
Subject: Re: [PATCH 01/11] kasan: prefix exported functions with kasan_
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wro=
te:
>
> There's a number of internal KASAN functions that are used across multipl=
e
> source code files and therefore aren't marked as static inline. To avoid
> littering the kernel function names list with generic functions, prefix
> all such KASAN functions with kasan_.
>
> As a part of this change:
>
> - Rename internal (un)poison_range() to kasan_(un)poison() (no _range)
>   to avoid name collision with a public kasan_unpoison_range().
>
> - Rename check_memory_region() to kasan_check_range(), as it seems to be
>   a more fitting name.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I719cc93483d4ba288a634dba8=
0ee6b7f2809cd26
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kasan/common.c         | 47 +++++++++++++++++++-------------------
>  mm/kasan/generic.c        | 36 ++++++++++++++---------------
>  mm/kasan/kasan.h          | 48 +++++++++++++++++++--------------------
>  mm/kasan/quarantine.c     | 22 +++++++++---------
>  mm/kasan/report.c         | 13 ++++++-----
>  mm/kasan/report_generic.c |  8 +++----
>  mm/kasan/report_hw_tags.c |  8 +++----
>  mm/kasan/report_sw_tags.c |  8 +++----
>  mm/kasan/shadow.c         | 26 ++++++++++-----------
>  mm/kasan/sw_tags.c        | 16 ++++++-------
>  tools/objtool/check.c     |  2 +-
>  11 files changed, 117 insertions(+), 117 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index b25167664ead..eedc3e0fe365 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -60,7 +60,7 @@ void kasan_disable_current(void)
>
>  void __kasan_unpoison_range(const void *address, size_t size)
>  {
> -       unpoison_range(address, size);
> +       kasan_unpoison(address, size);
>  }
>
>  #if CONFIG_KASAN_STACK
> @@ -69,7 +69,7 @@ void kasan_unpoison_task_stack(struct task_struct *task=
)
>  {
>         void *base =3D task_stack_page(task);
>
> -       unpoison_range(base, THREAD_SIZE);
> +       kasan_unpoison(base, THREAD_SIZE);
>  }
>
>  /* Unpoison the stack for the current task beyond a watermark sp value. =
*/
> @@ -82,7 +82,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const v=
oid *watermark)
>          */
>         void *base =3D (void *)((unsigned long)watermark & ~(THREAD_SIZE =
- 1));
>
> -       unpoison_range(base, watermark - base);
> +       kasan_unpoison(base, watermark - base);
>  }
>  #endif /* CONFIG_KASAN_STACK */
>
> @@ -105,18 +105,17 @@ void __kasan_alloc_pages(struct page *page, unsigne=
d int order)
>         if (unlikely(PageHighMem(page)))
>                 return;
>
> -       tag =3D random_tag();
> +       tag =3D kasan_random_tag();
>         for (i =3D 0; i < (1 << order); i++)
>                 page_kasan_tag_set(page + i, tag);
> -       unpoison_range(page_address(page), PAGE_SIZE << order);
> +       kasan_unpoison(page_address(page), PAGE_SIZE << order);
>  }
>
>  void __kasan_free_pages(struct page *page, unsigned int order)
>  {
>         if (likely(!PageHighMem(page)))
> -               poison_range(page_address(page),
> -                               PAGE_SIZE << order,
> -                               KASAN_FREE_PAGE);
> +               kasan_poison(page_address(page), PAGE_SIZE << order,
> +                            KASAN_FREE_PAGE);
>  }
>
>  /*
> @@ -246,18 +245,18 @@ void __kasan_poison_slab(struct page *page)
>
>         for (i =3D 0; i < compound_nr(page); i++)
>                 page_kasan_tag_reset(page + i);
> -       poison_range(page_address(page), page_size(page),
> +       kasan_poison(page_address(page), page_size(page),
>                      KASAN_KMALLOC_REDZONE);
>  }
>
>  void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object=
)
>  {
> -       unpoison_range(object, cache->object_size);
> +       kasan_unpoison(object, cache->object_size);
>  }
>
>  void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
> -       poison_range(object, cache->object_size, KASAN_KMALLOC_REDZONE);
> +       kasan_poison(object, cache->object_size, KASAN_KMALLOC_REDZONE);
>  }
>
>  /*
> @@ -294,7 +293,7 @@ static u8 assign_tag(struct kmem_cache *cache, const =
void *object,
>          * set, assign a tag when the object is being allocated (init =3D=
=3D false).
>          */
>         if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
> -               return init ? KASAN_TAG_KERNEL : random_tag();
> +               return init ? KASAN_TAG_KERNEL : kasan_random_tag();
>
>         /* For caches that either have a constructor or SLAB_TYPESAFE_BY_=
RCU: */
>  #ifdef CONFIG_SLAB
> @@ -305,7 +304,7 @@ static u8 assign_tag(struct kmem_cache *cache, const =
void *object,
>          * For SLUB assign a random tag during slab creation, otherwise r=
euse
>          * the already assigned tag.
>          */
> -       return init ? random_tag() : get_tag(object);
> +       return init ? kasan_random_tag() : get_tag(object);
>  #endif
>  }
>
> @@ -346,12 +345,12 @@ static bool ____kasan_slab_free(struct kmem_cache *=
cache, void *object,
>         if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return false;
>
> -       if (check_invalid_free(tagged_object)) {
> +       if (kasan_check_invalid_free(tagged_object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
>                 return true;
>         }
>
> -       poison_range(object, cache->object_size, KASAN_KMALLOC_FREE);
> +       kasan_poison(object, cache->object_size, KASAN_KMALLOC_FREE);
>
>         if (!kasan_stack_collection_enabled())
>                 return false;
> @@ -361,7 +360,7 @@ static bool ____kasan_slab_free(struct kmem_cache *ca=
che, void *object,
>
>         kasan_set_free_info(cache, object, tag);
>
> -       return quarantine_put(cache, object);
> +       return kasan_quarantine_put(cache, object);
>  }
>
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned =
long ip)
> @@ -386,7 +385,7 @@ void __kasan_slab_free_mempool(void *ptr, unsigned lo=
ng ip)
>                         kasan_report_invalid_free(ptr, ip);
>                         return;
>                 }
> -               poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
> +               kasan_poison(ptr, page_size(page), KASAN_FREE_PAGE);
>         } else {
>                 ____kasan_slab_free(page->slab_cache, ptr, ip, false);
>         }
> @@ -409,7 +408,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cac=
he, const void *object,
>         u8 tag;
>
>         if (gfpflags_allow_blocking(flags))
> -               quarantine_reduce();
> +               kasan_quarantine_reduce();
>
>         if (unlikely(object =3D=3D NULL))
>                 return NULL;
> @@ -421,9 +420,9 @@ static void *____kasan_kmalloc(struct kmem_cache *cac=
he, const void *object,
>         tag =3D assign_tag(cache, object, false, keep_tag);
>
>         /* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
> -       unpoison_range(set_tag(object, tag), size);
> -       poison_range((void *)redzone_start, redzone_end - redzone_start,
> -                    KASAN_KMALLOC_REDZONE);
> +       kasan_unpoison(set_tag(object, tag), size);
> +       kasan_poison((void *)redzone_start, redzone_end - redzone_start,
> +                          KASAN_KMALLOC_REDZONE);
>
>         if (kasan_stack_collection_enabled())
>                 set_alloc_info(cache, (void *)object, flags);
> @@ -452,7 +451,7 @@ void * __must_check __kasan_kmalloc_large(const void =
*ptr, size_t size,
>         unsigned long redzone_end;
>
>         if (gfpflags_allow_blocking(flags))
> -               quarantine_reduce();
> +               kasan_quarantine_reduce();
>
>         if (unlikely(ptr =3D=3D NULL))
>                 return NULL;
> @@ -462,8 +461,8 @@ void * __must_check __kasan_kmalloc_large(const void =
*ptr, size_t size,
>                                 KASAN_GRANULE_SIZE);
>         redzone_end =3D (unsigned long)ptr + page_size(page);
>
> -       unpoison_range(ptr, size);
> -       poison_range((void *)redzone_start, redzone_end - redzone_start,
> +       kasan_unpoison(ptr, size);
> +       kasan_poison((void *)redzone_start, redzone_end - redzone_start,
>                      KASAN_PAGE_REDZONE);
>
>         return (void *)ptr;
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 5106b84b07d4..acab8862dc67 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -158,7 +158,7 @@ static __always_inline bool memory_is_poisoned(unsign=
ed long addr, size_t size)
>         return memory_is_poisoned_n(addr, size);
>  }
>
> -static __always_inline bool check_memory_region_inline(unsigned long add=
r,
> +static __always_inline bool check_region_inline(unsigned long addr,
>                                                 size_t size, bool write,
>                                                 unsigned long ret_ip)
>  {
> @@ -179,13 +179,13 @@ static __always_inline bool check_memory_region_inl=
ine(unsigned long addr,
>         return !kasan_report(addr, size, write, ret_ip);
>  }
>
> -bool check_memory_region(unsigned long addr, size_t size, bool write,
> -                               unsigned long ret_ip)
> +bool kasan_check_range(unsigned long addr, size_t size, bool write,
> +                                       unsigned long ret_ip)
>  {
> -       return check_memory_region_inline(addr, size, write, ret_ip);
> +       return check_region_inline(addr, size, write, ret_ip);
>  }
>
> -bool check_invalid_free(void *addr)
> +bool kasan_check_invalid_free(void *addr)
>  {
>         s8 shadow_byte =3D READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
>
> @@ -194,22 +194,22 @@ bool check_invalid_free(void *addr)
>
>  void kasan_cache_shrink(struct kmem_cache *cache)
>  {
> -       quarantine_remove_cache(cache);
> +       kasan_quarantine_remove_cache(cache);
>  }
>
>  void kasan_cache_shutdown(struct kmem_cache *cache)
>  {
>         if (!__kmem_cache_empty(cache))
> -               quarantine_remove_cache(cache);
> +               kasan_quarantine_remove_cache(cache);
>  }
>
>  static void register_global(struct kasan_global *global)
>  {
>         size_t aligned_size =3D round_up(global->size, KASAN_GRANULE_SIZE=
);
>
> -       unpoison_range(global->beg, global->size);
> +       kasan_unpoison(global->beg, global->size);
>
> -       poison_range(global->beg + aligned_size,
> +       kasan_poison(global->beg + aligned_size,
>                      global->size_with_redzone - aligned_size,
>                      KASAN_GLOBAL_REDZONE);
>  }
> @@ -231,7 +231,7 @@ EXPORT_SYMBOL(__asan_unregister_globals);
>  #define DEFINE_ASAN_LOAD_STORE(size)                                   \
>         void __asan_load##size(unsigned long addr)                      \
>         {                                                               \
> -               check_memory_region_inline(addr, size, false, _RET_IP_);\
> +               check_region_inline(addr, size, false, _RET_IP_);       \
>         }                                                               \
>         EXPORT_SYMBOL(__asan_load##size);                               \
>         __alias(__asan_load##size)                                      \
> @@ -239,7 +239,7 @@ EXPORT_SYMBOL(__asan_unregister_globals);
>         EXPORT_SYMBOL(__asan_load##size##_noabort);                     \
>         void __asan_store##size(unsigned long addr)                     \
>         {                                                               \
> -               check_memory_region_inline(addr, size, true, _RET_IP_); \
> +               check_region_inline(addr, size, true, _RET_IP_);        \
>         }                                                               \
>         EXPORT_SYMBOL(__asan_store##size);                              \
>         __alias(__asan_store##size)                                     \
> @@ -254,7 +254,7 @@ DEFINE_ASAN_LOAD_STORE(16);
>
>  void __asan_loadN(unsigned long addr, size_t size)
>  {
> -       check_memory_region(addr, size, false, _RET_IP_);
> +       kasan_check_range(addr, size, false, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__asan_loadN);
>
> @@ -264,7 +264,7 @@ EXPORT_SYMBOL(__asan_loadN_noabort);
>
>  void __asan_storeN(unsigned long addr, size_t size)
>  {
> -       check_memory_region(addr, size, true, _RET_IP_);
> +       kasan_check_range(addr, size, true, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__asan_storeN);
>
> @@ -290,11 +290,11 @@ void __asan_alloca_poison(unsigned long addr, size_=
t size)
>
>         WARN_ON(!IS_ALIGNED(addr, KASAN_ALLOCA_REDZONE_SIZE));
>
> -       unpoison_range((const void *)(addr + rounded_down_size),
> -                      size - rounded_down_size);
> -       poison_range(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
> +       kasan_unpoison((const void *)(addr + rounded_down_size),
> +                       size - rounded_down_size);
> +       kasan_poison(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
>                      KASAN_ALLOCA_LEFT);
> -       poison_range(right_redzone, padding_size + KASAN_ALLOCA_REDZONE_S=
IZE,
> +       kasan_poison(right_redzone, padding_size + KASAN_ALLOCA_REDZONE_S=
IZE,
>                      KASAN_ALLOCA_RIGHT);
>  }
>  EXPORT_SYMBOL(__asan_alloca_poison);
> @@ -305,7 +305,7 @@ void __asan_allocas_unpoison(const void *stack_top, c=
onst void *stack_bottom)
>         if (unlikely(!stack_top || stack_top > stack_bottom))
>                 return;
>
> -       unpoison_range(stack_top, stack_bottom - stack_top);
> +       kasan_unpoison(stack_top, stack_bottom - stack_top);
>  }
>  EXPORT_SYMBOL(__asan_allocas_unpoison);
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index cc4d9e1d49b1..3b38baddec47 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -195,14 +195,14 @@ static inline bool addr_has_metadata(const void *ad=
dr)
>  }
>
>  /**
> - * check_memory_region - Check memory region, and report if invalid acce=
ss.
> + * kasan_check_range - Check memory region, and report if invalid access=
.
>   * @addr: the accessed address
>   * @size: the accessed size
>   * @write: true if access is a write access
>   * @ret_ip: return address
>   * @return: true if access was valid, false if invalid
>   */
> -bool check_memory_region(unsigned long addr, size_t size, bool write,
> +bool kasan_check_range(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip);
>
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> @@ -215,19 +215,19 @@ static inline bool addr_has_metadata(const void *ad=
dr)
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> -void print_tags(u8 addr_tag, const void *addr);
> +void kasan_print_tags(u8 addr_tag, const void *addr);
>  #else
> -static inline void print_tags(u8 addr_tag, const void *addr) { }
> +static inline void kasan_print_tags(u8 addr_tag, const void *addr) { }
>  #endif
>
> -void *find_first_bad_addr(void *addr, size_t size);
> -const char *get_bug_type(struct kasan_access_info *info);
> -void metadata_fetch_row(char *buffer, void *row);
> +void *kasan_find_first_bad_addr(void *addr, size_t size);
> +const char *kasan_get_bug_type(struct kasan_access_info *info);
> +void kasan_metadata_fetch_row(char *buffer, void *row);
>
>  #if defined(CONFIG_KASAN_GENERIC) && CONFIG_KASAN_STACK
> -void print_address_stack_frame(const void *addr);
> +void kasan_print_address_stack_frame(const void *addr);
>  #else
> -static inline void print_address_stack_frame(const void *addr) { }
> +static inline void kasan_print_address_stack_frame(const void *addr) { }
>  #endif
>
>  bool kasan_report(unsigned long addr, size_t size,
> @@ -244,13 +244,13 @@ struct kasan_track *kasan_get_free_track(struct kme=
m_cache *cache,
>
>  #if defined(CONFIG_KASAN_GENERIC) && \
>         (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> -bool quarantine_put(struct kmem_cache *cache, void *object);
> -void quarantine_reduce(void);
> -void quarantine_remove_cache(struct kmem_cache *cache);
> +bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
> +void kasan_quarantine_reduce(void);
> +void kasan_quarantine_remove_cache(struct kmem_cache *cache);
>  #else
> -static inline bool quarantine_put(struct kmem_cache *cache, void *object=
) { return false; }
> -static inline void quarantine_reduce(void) { }
> -static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
> +static inline bool kasan_quarantine_put(struct kmem_cache *cache, void *=
object) { return false; }
> +static inline void kasan_quarantine_reduce(void) { }
> +static inline void kasan_quarantine_remove_cache(struct kmem_cache *cach=
e) { }
>  #endif
>
>  #ifndef arch_kasan_set_tag
> @@ -293,28 +293,28 @@ static inline const void *arch_kasan_set_tag(const =
void *addr, u8 tag)
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
>  #ifdef CONFIG_KASAN_SW_TAGS
> -u8 random_tag(void);
> +u8 kasan_random_tag(void);
>  #elif defined(CONFIG_KASAN_HW_TAGS)
> -static inline u8 random_tag(void) { return hw_get_random_tag(); }
> +static inline u8 kasan_random_tag(void) { return hw_get_random_tag(); }
>  #else
> -static inline u8 random_tag(void) { return 0; }
> +static inline u8 kasan_random_tag(void) { return 0; }
>  #endif
>
>  #ifdef CONFIG_KASAN_HW_TAGS
>
> -static inline void poison_range(const void *address, size_t size, u8 val=
ue)
> +static inline void kasan_poison(const void *address, size_t size, u8 val=
ue)
>  {
>         hw_set_mem_tag_range(kasan_reset_tag(address),
>                         round_up(size, KASAN_GRANULE_SIZE), value);
>  }
>
> -static inline void unpoison_range(const void *address, size_t size)
> +static inline void kasan_unpoison(const void *address, size_t size)
>  {
>         hw_set_mem_tag_range(kasan_reset_tag(address),
>                         round_up(size, KASAN_GRANULE_SIZE), get_tag(addre=
ss));
>  }
>
> -static inline bool check_invalid_free(void *addr)
> +static inline bool kasan_check_invalid_free(void *addr)
>  {
>         u8 ptr_tag =3D get_tag(addr);
>         u8 mem_tag =3D hw_get_mem_tag(addr);
> @@ -325,9 +325,9 @@ static inline bool check_invalid_free(void *addr)
>
>  #else /* CONFIG_KASAN_HW_TAGS */
>
> -void poison_range(const void *address, size_t size, u8 value);
> -void unpoison_range(const void *address, size_t size);
> -bool check_invalid_free(void *addr);
> +void kasan_poison(const void *address, size_t size, u8 value);
> +void kasan_unpoison(const void *address, size_t size);
> +bool kasan_check_invalid_free(void *addr);
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 55783125a767..728fb24c5683 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -168,7 +168,7 @@ static void qlist_free_all(struct qlist_head *q, stru=
ct kmem_cache *cache)
>         qlist_init(q);
>  }
>
> -bool quarantine_put(struct kmem_cache *cache, void *object)
> +bool kasan_quarantine_put(struct kmem_cache *cache, void *object)
>  {
>         unsigned long flags;
>         struct qlist_head *q;
> @@ -184,11 +184,11 @@ bool quarantine_put(struct kmem_cache *cache, void =
*object)
>
>         /*
>          * Note: irq must be disabled until after we move the batch to th=
e
> -        * global quarantine. Otherwise quarantine_remove_cache() can mis=
s
> -        * some objects belonging to the cache if they are in our local t=
emp
> -        * list. quarantine_remove_cache() executes on_each_cpu() at the
> -        * beginning which ensures that it either sees the objects in per=
-cpu
> -        * lists or in the global quarantine.
> +        * global quarantine. Otherwise kasan_quarantine_remove_cache() c=
an
> +        * miss some objects belonging to the cache if they are in our lo=
cal
> +        * temp list. kasan_quarantine_remove_cache() executes on_each_cp=
u()
> +        * at the beginning which ensures that it either sees the objects=
 in
> +        * per-cpu lists or in the global quarantine.
>          */
>         local_irq_save(flags);
>
> @@ -222,7 +222,7 @@ bool quarantine_put(struct kmem_cache *cache, void *o=
bject)
>         return true;
>  }
>
> -void quarantine_reduce(void)
> +void kasan_quarantine_reduce(void)
>  {
>         size_t total_size, new_quarantine_size, percpu_quarantines;
>         unsigned long flags;
> @@ -234,7 +234,7 @@ void quarantine_reduce(void)
>                 return;
>
>         /*
> -        * srcu critical section ensures that quarantine_remove_cache()
> +        * srcu critical section ensures that kasan_quarantine_remove_cac=
he()
>          * will not miss objects belonging to the cache while they are in=
 our
>          * local to_free list. srcu is chosen because (1) it gives us pri=
vate
>          * grace period domain that does not interfere with anything else=
,
> @@ -309,15 +309,15 @@ static void per_cpu_remove_cache(void *arg)
>  }
>
>  /* Free all quarantined objects belonging to cache. */
> -void quarantine_remove_cache(struct kmem_cache *cache)
> +void kasan_quarantine_remove_cache(struct kmem_cache *cache)
>  {
>         unsigned long flags, i;
>         struct qlist_head to_free =3D QLIST_INIT;
>
>         /*
>          * Must be careful to not miss any objects that are being moved f=
rom
> -        * per-cpu list to the global quarantine in quarantine_put(),
> -        * nor objects being freed in quarantine_reduce(). on_each_cpu()
> +        * per-cpu list to the global quarantine in kasan_quarantine_put(=
),
> +        * nor objects being freed in kasan_quarantine_reduce(). on_each_=
cpu()
>          * achieves the first goal, while synchronize_srcu() achieves the
>          * second.
>          */
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index c0fb21797550..e93d7973792e 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -61,7 +61,7 @@ __setup("kasan_multi_shot", kasan_set_multi_shot);
>  static void print_error_description(struct kasan_access_info *info)
>  {
>         pr_err("BUG: KASAN: %s in %pS\n",
> -               get_bug_type(info), (void *)info->ip);
> +               kasan_get_bug_type(info), (void *)info->ip);
>         if (info->access_size)
>                 pr_err("%s of size %zu at addr %px by task %s/%d\n",
>                         info->is_write ? "Write" : "Read", info->access_s=
ize,
> @@ -247,7 +247,7 @@ static void print_address_description(void *addr, u8 =
tag)
>                 dump_page(page, "kasan: bad access detected");
>         }
>
> -       print_address_stack_frame(addr);
> +       kasan_print_address_stack_frame(addr);
>  }
>
>  static bool meta_row_is_guilty(const void *row, const void *addr)
> @@ -293,7 +293,7 @@ static void print_memory_metadata(const void *addr)
>                  * function, because generic functions may try to
>                  * access kasan mapping for the passed address.
>                  */
> -               metadata_fetch_row(&metadata[0], row);
> +               kasan_metadata_fetch_row(&metadata[0], row);
>
>                 print_hex_dump(KERN_ERR, buffer,
>                         DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
> @@ -350,7 +350,7 @@ void kasan_report_invalid_free(void *object, unsigned=
 long ip)
>
>         start_report(&flags);
>         pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void =
*)ip);
> -       print_tags(tag, object);
> +       kasan_print_tags(tag, object);
>         pr_err("\n");
>         print_address_description(object, tag);
>         pr_err("\n");
> @@ -378,7 +378,8 @@ static void __kasan_report(unsigned long addr, size_t=
 size, bool is_write,
>
>         info.access_addr =3D tagged_addr;
>         if (addr_has_metadata(untagged_addr))
> -               info.first_bad_addr =3D find_first_bad_addr(tagged_addr, =
size);
> +               info.first_bad_addr =3D
> +                       kasan_find_first_bad_addr(tagged_addr, size);
>         else
>                 info.first_bad_addr =3D untagged_addr;
>         info.access_size =3D size;
> @@ -389,7 +390,7 @@ static void __kasan_report(unsigned long addr, size_t=
 size, bool is_write,
>
>         print_error_description(&info);
>         if (addr_has_metadata(untagged_addr))
> -               print_tags(get_tag(tagged_addr), info.first_bad_addr);
> +               kasan_print_tags(get_tag(tagged_addr), info.first_bad_add=
r);
>         pr_err("\n");
>
>         if (addr_has_metadata(untagged_addr)) {
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 8a9c889872da..41f374585144 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -30,7 +30,7 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> -void *find_first_bad_addr(void *addr, size_t size)
> +void *kasan_find_first_bad_addr(void *addr, size_t size)
>  {
>         void *p =3D addr;
>
> @@ -105,7 +105,7 @@ static const char *get_wild_bug_type(struct kasan_acc=
ess_info *info)
>         return bug_type;
>  }
>
> -const char *get_bug_type(struct kasan_access_info *info)
> +const char *kasan_get_bug_type(struct kasan_access_info *info)
>  {
>         /*
>          * If access_size is a negative number, then it has reason to be
> @@ -123,7 +123,7 @@ const char *get_bug_type(struct kasan_access_info *in=
fo)
>         return get_wild_bug_type(info);
>  }
>
> -void metadata_fetch_row(char *buffer, void *row)
> +void kasan_metadata_fetch_row(char *buffer, void *row)
>  {
>         memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
>  }
> @@ -263,7 +263,7 @@ static bool __must_check get_address_stack_frame_info=
(const void *addr,
>         return true;
>  }
>
> -void print_address_stack_frame(const void *addr)
> +void kasan_print_address_stack_frame(const void *addr)
>  {
>         unsigned long offset;
>         const char *frame_descr;
> diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> index 57114f0e14d1..42b2168755d6 100644
> --- a/mm/kasan/report_hw_tags.c
> +++ b/mm/kasan/report_hw_tags.c
> @@ -15,17 +15,17 @@
>
>  #include "kasan.h"
>
> -const char *get_bug_type(struct kasan_access_info *info)
> +const char *kasan_get_bug_type(struct kasan_access_info *info)
>  {
>         return "invalid-access";
>  }
>
> -void *find_first_bad_addr(void *addr, size_t size)
> +void *kasan_find_first_bad_addr(void *addr, size_t size)
>  {
>         return kasan_reset_tag(addr);
>  }
>
> -void metadata_fetch_row(char *buffer, void *row)
> +void kasan_metadata_fetch_row(char *buffer, void *row)
>  {
>         int i;
>
> @@ -33,7 +33,7 @@ void metadata_fetch_row(char *buffer, void *row)
>                 buffer[i] =3D hw_get_mem_tag(row + i * KASAN_GRANULE_SIZE=
);
>  }
>
> -void print_tags(u8 addr_tag, const void *addr)
> +void kasan_print_tags(u8 addr_tag, const void *addr)
>  {
>         u8 memory_tag =3D hw_get_mem_tag((void *)addr);
>
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index 1b026793ad57..3d20d3451d9e 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -29,7 +29,7 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> -const char *get_bug_type(struct kasan_access_info *info)
> +const char *kasan_get_bug_type(struct kasan_access_info *info)
>  {
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>         struct kasan_alloc_meta *alloc_meta;
> @@ -72,7 +72,7 @@ const char *get_bug_type(struct kasan_access_info *info=
)
>         return "invalid-access";
>  }
>
> -void *find_first_bad_addr(void *addr, size_t size)
> +void *kasan_find_first_bad_addr(void *addr, size_t size)
>  {
>         u8 tag =3D get_tag(addr);
>         void *p =3D kasan_reset_tag(addr);
> @@ -83,12 +83,12 @@ void *find_first_bad_addr(void *addr, size_t size)
>         return p;
>  }
>
> -void metadata_fetch_row(char *buffer, void *row)
> +void kasan_metadata_fetch_row(char *buffer, void *row)
>  {
>         memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
>  }
>
> -void print_tags(u8 addr_tag, const void *addr)
> +void kasan_print_tags(u8 addr_tag, const void *addr)
>  {
>         u8 *shadow =3D (u8 *)kasan_mem_to_shadow(addr);
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 7c2c08c55f32..38958eb0d653 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -27,20 +27,20 @@
>
>  bool __kasan_check_read(const volatile void *p, unsigned int size)
>  {
> -       return check_memory_region((unsigned long)p, size, false, _RET_IP=
_);
> +       return kasan_check_range((unsigned long)p, size, false, _RET_IP_)=
;
>  }
>  EXPORT_SYMBOL(__kasan_check_read);
>
>  bool __kasan_check_write(const volatile void *p, unsigned int size)
>  {
> -       return check_memory_region((unsigned long)p, size, true, _RET_IP_=
);
> +       return kasan_check_range((unsigned long)p, size, true, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__kasan_check_write);
>
>  #undef memset
>  void *memset(void *addr, int c, size_t len)
>  {
> -       if (!check_memory_region((unsigned long)addr, len, true, _RET_IP_=
))
> +       if (!kasan_check_range((unsigned long)addr, len, true, _RET_IP_))
>                 return NULL;
>
>         return __memset(addr, c, len);
> @@ -50,8 +50,8 @@ void *memset(void *addr, int c, size_t len)
>  #undef memmove
>  void *memmove(void *dest, const void *src, size_t len)
>  {
> -       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_=
) ||
> -           !check_memory_region((unsigned long)dest, len, true, _RET_IP_=
))
> +       if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) =
||
> +           !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
>                 return NULL;
>
>         return __memmove(dest, src, len);
> @@ -61,8 +61,8 @@ void *memmove(void *dest, const void *src, size_t len)
>  #undef memcpy
>  void *memcpy(void *dest, const void *src, size_t len)
>  {
> -       if (!check_memory_region((unsigned long)src, len, false, _RET_IP_=
) ||
> -           !check_memory_region((unsigned long)dest, len, true, _RET_IP_=
))
> +       if (!kasan_check_range((unsigned long)src, len, false, _RET_IP_) =
||
> +           !kasan_check_range((unsigned long)dest, len, true, _RET_IP_))
>                 return NULL;
>
>         return __memcpy(dest, src, len);
> @@ -72,7 +72,7 @@ void *memcpy(void *dest, const void *src, size_t len)
>   * Poisons the shadow memory for 'size' bytes starting from 'addr'.
>   * Memory addresses should be aligned to KASAN_GRANULE_SIZE.
>   */
> -void poison_range(const void *address, size_t size, u8 value)
> +void kasan_poison(const void *address, size_t size, u8 value)
>  {
>         void *shadow_start, *shadow_end;
>
> @@ -90,7 +90,7 @@ void poison_range(const void *address, size_t size, u8 =
value)
>         __memset(shadow_start, value, shadow_end - shadow_start);
>  }
>
> -void unpoison_range(const void *address, size_t size)
> +void kasan_unpoison(const void *address, size_t size)
>  {
>         u8 tag =3D get_tag(address);
>
> @@ -101,7 +101,7 @@ void unpoison_range(const void *address, size_t size)
>          */
>         address =3D kasan_reset_tag(address);
>
> -       poison_range(address, size, tag);
> +       kasan_poison(address, size, tag);
>
>         if (size & KASAN_GRANULE_MASK) {
>                 u8 *shadow =3D (u8 *)kasan_mem_to_shadow(address + size);
> @@ -286,7 +286,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsign=
ed long size)
>          * // vmalloc() allocates memory
>          * // let a =3D area->addr
>          * // we reach kasan_populate_vmalloc
> -        * // and call unpoison_range:
> +        * // and call kasan_unpoison:
>          * STORE shadow(a), unpoison_val
>          * ...
>          * STORE shadow(a+99), unpoison_val     x =3D LOAD p
> @@ -321,7 +321,7 @@ void kasan_poison_vmalloc(const void *start, unsigned=
 long size)
>                 return;
>
>         size =3D round_up(size, KASAN_GRANULE_SIZE);
> -       poison_range(start, size, KASAN_VMALLOC_INVALID);
> +       kasan_poison(start, size, KASAN_VMALLOC_INVALID);
>  }
>
>  void kasan_unpoison_vmalloc(const void *start, unsigned long size)
> @@ -329,7 +329,7 @@ void kasan_unpoison_vmalloc(const void *start, unsign=
ed long size)
>         if (!is_vmalloc_or_module_addr(start))
>                 return;
>
> -       unpoison_range(start, size);
> +       kasan_unpoison(start, size);
>  }
>
>  static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 5dcd830805b2..cc271fceb5d5 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -57,7 +57,7 @@ void __init kasan_init_sw_tags(void)
>   * sequence has in fact positive effect, since interrupts that randomly =
skew
>   * PRNG at unpredictable points do only good.
>   */
> -u8 random_tag(void)
> +u8 kasan_random_tag(void)
>  {
>         u32 state =3D this_cpu_read(prng_state);
>
> @@ -67,7 +67,7 @@ u8 random_tag(void)
>         return (u8)(state % (KASAN_TAG_MAX + 1));
>  }
>
> -bool check_memory_region(unsigned long addr, size_t size, bool write,
> +bool kasan_check_range(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip)
>  {
>         u8 tag;
> @@ -118,7 +118,7 @@ bool check_memory_region(unsigned long addr, size_t s=
ize, bool write,
>         return true;
>  }
>
> -bool check_invalid_free(void *addr)
> +bool kasan_check_invalid_free(void *addr)
>  {
>         u8 tag =3D get_tag(addr);
>         u8 shadow_byte =3D READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_res=
et_tag(addr)));
> @@ -130,12 +130,12 @@ bool check_invalid_free(void *addr)
>  #define DEFINE_HWASAN_LOAD_STORE(size)                                 \
>         void __hwasan_load##size##_noabort(unsigned long addr)          \
>         {                                                               \
> -               check_memory_region(addr, size, false, _RET_IP_);       \
> +               kasan_check_range(addr, size, false, _RET_IP_); \
>         }                                                               \
>         EXPORT_SYMBOL(__hwasan_load##size##_noabort);                   \
>         void __hwasan_store##size##_noabort(unsigned long addr)         \
>         {                                                               \
> -               check_memory_region(addr, size, true, _RET_IP_);        \
> +               kasan_check_range(addr, size, true, _RET_IP_);          \
>         }                                                               \
>         EXPORT_SYMBOL(__hwasan_store##size##_noabort)
>
> @@ -147,19 +147,19 @@ DEFINE_HWASAN_LOAD_STORE(16);
>
>  void __hwasan_loadN_noabort(unsigned long addr, unsigned long size)
>  {
> -       check_memory_region(addr, size, false, _RET_IP_);
> +       kasan_check_range(addr, size, false, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__hwasan_loadN_noabort);
>
>  void __hwasan_storeN_noabort(unsigned long addr, unsigned long size)
>  {
> -       check_memory_region(addr, size, true, _RET_IP_);
> +       kasan_check_range(addr, size, true, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__hwasan_storeN_noabort);
>
>  void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
>  {
> -       poison_range((void *)addr, size, tag);
> +       kasan_poison((void *)addr, size, tag);
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
>
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 5f8d3eed78a1..5b2a22591ea7 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -576,7 +576,7 @@ static void add_ignores(struct objtool_file *file)
>  static const char *uaccess_safe_builtin[] =3D {
>         /* KASAN */
>         "kasan_report",
> -       "check_memory_region",
> +       "kasan_check_range",
>         /* KASAN out-of-line */
>         "__asan_loadN_noabort",
>         "__asan_load1_noabort",
> --
> 2.29.2.729.g45daf8777d-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87BB2AF21A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKKN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgKKN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:26:56 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AF2C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:26:55 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id q5so1536858qkc.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=git/upxaSD7F25cH4gGsmk9vaU3cNp3fT7vsVqWmnEg=;
        b=Msdbb7HraU9Tm9Pq9ieTMxcLhsdy0OnQHSqtUBfzrcpalPmXaSOAG/11GGMTIom/a4
         SzgBSQvm6JBRN+mJdt01osxHxgdVcogEx1EjubIjv/pg7hso2rixetZvMPluVyZkVBr+
         ebTgyYNnTq0SYSF3p0JTtA2MtUJrDCByFtZV82+fLCwzVDtYJvWcwhMDfQrrC4Akolx5
         u4dkzLS3J77uEOq+h9WZz1T1CeO1SRxcx8+Jqu9ZDLbz+XSn9HGSJe4QB052i9A4yY9O
         U1bSQ1TjiNNYDwLff3xw+6gd5OYBghaSz1TJwv4UYAv6O9k8OSfn+c1hQxtlDfSLyr99
         /3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=git/upxaSD7F25cH4gGsmk9vaU3cNp3fT7vsVqWmnEg=;
        b=h4ZBOqk7e30IaUByZkHEz1fZgZX5c2Tpm61STrRHpDEVjzBiOZerFVEAJwU7bKUTg4
         4eFKIYUJ/hsBl9ZitFREBt1jbnvxohSho9BIyQpy1mYktGCw5bwzPDvGROKCBDJ0/Qo8
         QrD+s3n37tcv0Vn5lszN1Ngnc+jgEKNdsUexeeBOxuk52kO2oBQbUVyXA0rrqkvBmn2i
         NoNTE0QUx66/oT8oAPshyG3DOweqef0HHlNeLSfR4V1R3YopAbooK2zKAqwhwm25ny80
         0heKyApsR9I1x/UO89TJvQrubaiK7o4mlH4dIjfkRU1NxRFa8Ck3dhbKgGss8sTbK/3x
         8+bA==
X-Gm-Message-State: AOAM531Ux1LDzDryO0GoBMKzWb+DxDFgmyKPSCrV6Vq0lVsCAXf5mNUY
        rgJGfs3gpa8GQN+4UuwNvZ+3yRunK/dK2Qeh43SmFA==
X-Google-Smtp-Source: ABdhPJw7+FZXw5TTjeoRDEKaoRklz+BvmLIbdae4h3vJYR0tThurjzmLTFB6WcIUBOR2Ff3ai2u7APOsYS2aP+m8S6o=
X-Received: by 2002:a37:4552:: with SMTP id s79mr18890206qka.6.1605101214604;
 Wed, 11 Nov 2020 05:26:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <f26e54bcfe216118762632ecde260a5f6c605594.1605046192.git.andreyknvl@google.com>
In-Reply-To: <f26e54bcfe216118762632ecde260a5f6c605594.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 14:26:43 +0100
Message-ID: <CAG_fn=VVNQAsoGQ78yuT9XERZDwu1sD54SqVx4K1oyHBHPfb3Q@mail.gmail.com>
Subject: Re: [PATCH v9 06/44] kasan: rename (un)poison_shadow to (un)poison_memory
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> The new mode won't be using shadow memory, but will reuse the same
> functions. Rename kasan_unpoison_shadow to kasan_unpoison_memory,
> and kasan_poison_shadow to kasan_poison_memory.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: Ia359f32815242c4704e49a5f1639ca2d2f8cba69
> ---
>  include/linux/kasan.h |  6 +++---
>  kernel/fork.c         |  4 ++--
>  mm/kasan/common.c     | 38 +++++++++++++++++++-------------------
>  mm/kasan/generic.c    | 12 ++++++------
>  mm/kasan/kasan.h      |  2 +-
>  mm/kasan/tags.c       |  2 +-
>  mm/slab_common.c      |  2 +-
>  7 files changed, 33 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 26f2ab92e7ca..f6435b9f889c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -71,7 +71,7 @@ extern void kasan_enable_current(void);
>  /* Disable reporting bugs for current task */
>  extern void kasan_disable_current(void);
>
> -void kasan_unpoison_shadow(const void *address, size_t size);
> +void kasan_unpoison_memory(const void *address, size_t size);
>
>  void kasan_unpoison_task_stack(struct task_struct *task);
>
> @@ -108,7 +108,7 @@ struct kasan_cache {
>  size_t __ksize(const void *);
>  static inline void kasan_unpoison_slab(const void *ptr)
>  {
> -       kasan_unpoison_shadow(ptr, __ksize(ptr));
> +       kasan_unpoison_memory(ptr, __ksize(ptr));
>  }
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>
> @@ -117,7 +117,7 @@ void kasan_restore_multi_shot(bool enabled);
>
>  #else /* CONFIG_KASAN */
>
> -static inline void kasan_unpoison_shadow(const void *address, size_t siz=
e) {}
> +static inline void kasan_unpoison_memory(const void *address, size_t siz=
e) {}
>
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {=
}
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6d266388d380..1c905e4290ab 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -225,8 +225,8 @@ static unsigned long *alloc_thread_stack_node(struct =
task_struct *tsk, int node)
>                 if (!s)
>                         continue;
>
> -               /* Clear the KASAN shadow of the stack. */
> -               kasan_unpoison_shadow(s->addr, THREAD_SIZE);
> +               /* Mark stack accessible for KASAN. */
> +               kasan_unpoison_memory(s->addr, THREAD_SIZE);
>
>                 /* Clear stale pointers from reused stack. */
>                 memset(s->addr, 0, THREAD_SIZE);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 89e5ef9417a7..a4b73fa0dd7e 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -108,7 +108,7 @@ void *memcpy(void *dest, const void *src, size_t len)
>   * Poisons the shadow memory for 'size' bytes starting from 'addr'.
>   * Memory addresses should be aligned to KASAN_SHADOW_SCALE_SIZE.
>   */
> -void kasan_poison_shadow(const void *address, size_t size, u8 value)
> +void kasan_poison_memory(const void *address, size_t size, u8 value)
>  {
>         void *shadow_start, *shadow_end;
>
> @@ -125,7 +125,7 @@ void kasan_poison_shadow(const void *address, size_t =
size, u8 value)
>         __memset(shadow_start, value, shadow_end - shadow_start);
>  }
>
> -void kasan_unpoison_shadow(const void *address, size_t size)
> +void kasan_unpoison_memory(const void *address, size_t size)
>  {
>         u8 tag =3D get_tag(address);
>
> @@ -136,7 +136,7 @@ void kasan_unpoison_shadow(const void *address, size_=
t size)
>          */
>         address =3D reset_tag(address);
>
> -       kasan_poison_shadow(address, size, tag);
> +       kasan_poison_memory(address, size, tag);
>
>         if (size & KASAN_SHADOW_MASK) {
>                 u8 *shadow =3D (u8 *)kasan_mem_to_shadow(address + size);
> @@ -153,7 +153,7 @@ static void __kasan_unpoison_stack(struct task_struct=
 *task, const void *sp)
>         void *base =3D task_stack_page(task);
>         size_t size =3D sp - base;
>
> -       kasan_unpoison_shadow(base, size);
> +       kasan_unpoison_memory(base, size);
>  }
>
>  /* Unpoison the entire stack for a task. */
> @@ -172,7 +172,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const=
 void *watermark)
>          */
>         void *base =3D (void *)((unsigned long)watermark & ~(THREAD_SIZE =
- 1));
>
> -       kasan_unpoison_shadow(base, watermark - base);
> +       kasan_unpoison_memory(base, watermark - base);
>  }
>
>  void kasan_alloc_pages(struct page *page, unsigned int order)
> @@ -186,13 +186,13 @@ void kasan_alloc_pages(struct page *page, unsigned =
int order)
>         tag =3D random_tag();
>         for (i =3D 0; i < (1 << order); i++)
>                 page_kasan_tag_set(page + i, tag);
> -       kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
> +       kasan_unpoison_memory(page_address(page), PAGE_SIZE << order);
>  }
>
>  void kasan_free_pages(struct page *page, unsigned int order)
>  {
>         if (likely(!PageHighMem(page)))
> -               kasan_poison_shadow(page_address(page),
> +               kasan_poison_memory(page_address(page),
>                                 PAGE_SIZE << order,
>                                 KASAN_FREE_PAGE);
>  }
> @@ -284,18 +284,18 @@ void kasan_poison_slab(struct page *page)
>
>         for (i =3D 0; i < compound_nr(page); i++)
>                 page_kasan_tag_reset(page + i);
> -       kasan_poison_shadow(page_address(page), page_size(page),
> +       kasan_poison_memory(page_address(page), page_size(page),
>                         KASAN_KMALLOC_REDZONE);
>  }
>
>  void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  {
> -       kasan_unpoison_shadow(object, cache->object_size);
> +       kasan_unpoison_memory(object, cache->object_size);
>  }
>
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
> -       kasan_poison_shadow(object,
> +       kasan_poison_memory(object,
>                         round_up(cache->object_size, KASAN_SHADOW_SCALE_S=
IZE),
>                         KASAN_KMALLOC_REDZONE);
>  }
> @@ -408,7 +408,7 @@ static bool __kasan_slab_free(struct kmem_cache *cach=
e, void *object,
>         }
>
>         rounded_up_size =3D round_up(cache->object_size, KASAN_SHADOW_SCA=
LE_SIZE);
> -       kasan_poison_shadow(object, rounded_up_size, KASAN_KMALLOC_FREE);
> +       kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
>
>         if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
>                         unlikely(!(cache->flags & SLAB_KASAN)))
> @@ -448,8 +448,8 @@ static void *__kasan_kmalloc(struct kmem_cache *cache=
, const void *object,
>                 tag =3D assign_tag(cache, object, false, keep_tag);
>
>         /* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
> -       kasan_unpoison_shadow(set_tag(object, tag), size);
> -       kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_=
start,
> +       kasan_unpoison_memory(set_tag(object, tag), size);
> +       kasan_poison_memory((void *)redzone_start, redzone_end - redzone_=
start,
>                 KASAN_KMALLOC_REDZONE);
>
>         if (cache->flags & SLAB_KASAN)
> @@ -489,8 +489,8 @@ void * __must_check kasan_kmalloc_large(const void *p=
tr, size_t size,
>                                 KASAN_SHADOW_SCALE_SIZE);
>         redzone_end =3D (unsigned long)ptr + page_size(page);
>
> -       kasan_unpoison_shadow(ptr, size);
> -       kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_=
start,
> +       kasan_unpoison_memory(ptr, size);
> +       kasan_poison_memory((void *)redzone_start, redzone_end - redzone_=
start,
>                 KASAN_PAGE_REDZONE);
>
>         return (void *)ptr;
> @@ -523,7 +523,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>                         kasan_report_invalid_free(ptr, ip);
>                         return;
>                 }
> -               kasan_poison_shadow(ptr, page_size(page), KASAN_FREE_PAGE=
);
> +               kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE=
);
>         } else {
>                 __kasan_slab_free(page->slab_cache, ptr, ip, false);
>         }
> @@ -709,7 +709,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsign=
ed long size)
>          * // vmalloc() allocates memory
>          * // let a =3D area->addr
>          * // we reach kasan_populate_vmalloc
> -        * // and call kasan_unpoison_shadow:
> +        * // and call kasan_unpoison_memory:
>          * STORE shadow(a), unpoison_val
>          * ...
>          * STORE shadow(a+99), unpoison_val     x =3D LOAD p
> @@ -744,7 +744,7 @@ void kasan_poison_vmalloc(const void *start, unsigned=
 long size)
>                 return;
>
>         size =3D round_up(size, KASAN_SHADOW_SCALE_SIZE);
> -       kasan_poison_shadow(start, size, KASAN_VMALLOC_INVALID);
> +       kasan_poison_memory(start, size, KASAN_VMALLOC_INVALID);
>  }
>
>  void kasan_unpoison_vmalloc(const void *start, unsigned long size)
> @@ -752,7 +752,7 @@ void kasan_unpoison_vmalloc(const void *start, unsign=
ed long size)
>         if (!is_vmalloc_or_module_addr(start))
>                 return;
>
> -       kasan_unpoison_shadow(start, size);
> +       kasan_unpoison_memory(start, size);
>  }
>
>  static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 37ccfadd3263..7006157c674b 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -202,9 +202,9 @@ static void register_global(struct kasan_global *glob=
al)
>  {
>         size_t aligned_size =3D round_up(global->size, KASAN_SHADOW_SCALE=
_SIZE);
>
> -       kasan_unpoison_shadow(global->beg, global->size);
> +       kasan_unpoison_memory(global->beg, global->size);
>
> -       kasan_poison_shadow(global->beg + aligned_size,
> +       kasan_poison_memory(global->beg + aligned_size,
>                 global->size_with_redzone - aligned_size,
>                 KASAN_GLOBAL_REDZONE);
>  }
> @@ -285,11 +285,11 @@ void __asan_alloca_poison(unsigned long addr, size_=
t size)
>
>         WARN_ON(!IS_ALIGNED(addr, KASAN_ALLOCA_REDZONE_SIZE));
>
> -       kasan_unpoison_shadow((const void *)(addr + rounded_down_size),
> +       kasan_unpoison_memory((const void *)(addr + rounded_down_size),
>                               size - rounded_down_size);
> -       kasan_poison_shadow(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
> +       kasan_poison_memory(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
>                         KASAN_ALLOCA_LEFT);
> -       kasan_poison_shadow(right_redzone,
> +       kasan_poison_memory(right_redzone,
>                         padding_size + KASAN_ALLOCA_REDZONE_SIZE,
>                         KASAN_ALLOCA_RIGHT);
>  }
> @@ -301,7 +301,7 @@ void __asan_allocas_unpoison(const void *stack_top, c=
onst void *stack_bottom)
>         if (unlikely(!stack_top || stack_top > stack_bottom))
>                 return;
>
> -       kasan_unpoison_shadow(stack_top, stack_bottom - stack_top);
> +       kasan_unpoison_memory(stack_top, stack_bottom - stack_top);
>  }
>  EXPORT_SYMBOL(__asan_allocas_unpoison);
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ac499456740f..03450d3b31f7 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -150,7 +150,7 @@ static inline bool addr_has_shadow(const void *addr)
>         return (addr >=3D kasan_shadow_to_mem((void *)KASAN_SHADOW_START)=
);
>  }
>
> -void kasan_poison_shadow(const void *address, size_t size, u8 value);
> +void kasan_poison_memory(const void *address, size_t size, u8 value);
>
>  /**
>   * check_memory_region - Check memory region, and report if invalid acce=
ss.
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 5c8b08a25715..4bdd7dbd6647 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -153,7 +153,7 @@ EXPORT_SYMBOL(__hwasan_storeN_noabort);
>
>  void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
>  {
> -       kasan_poison_shadow((void *)addr, size, tag);
> +       kasan_poison_memory((void *)addr, size, tag);
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f9ccd5dc13f3..53d0f8bb57ea 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1176,7 +1176,7 @@ size_t ksize(const void *objp)
>          * We assume that ksize callers could use whole allocated area,
>          * so we need to unpoison this area.
>          */
> -       kasan_unpoison_shadow(objp, size);
> +       kasan_unpoison_memory(objp, size);
>         return size;
>  }
>  EXPORT_SYMBOL(ksize);
> --
> 2.29.2.222.g5d2a92d10f8-goog
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

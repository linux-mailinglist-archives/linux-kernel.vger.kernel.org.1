Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CBC2B808A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKRPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgKRPa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:30:28 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD01FC061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:30:27 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id v20so1195385qvx.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wonpByTzbuJxA+M2ARgOF+/g8Val/wioKkFNzzsy6gU=;
        b=Rx3USm/EF/+xzXJ3dItOEJTB5qqQxP2Bp+5E6BDeVmQUmuyXjg2dtFMCGlq3oB8B4k
         9N8bBvMJiAHRFOtjuPCq7jGUb/18cJv4ZalX00BQbblcX4MXB9tWk3qOC3P+rKlTzaQ3
         VLJPFJo/V9bAA6oeh/HT7tcmovDyItVsev9cBUPBZmKlt9df/9RTeWO8S8xfY/mKOZ1n
         KBjxSS9wq1oArwhOhDvrRtzjIYXOCU5zZ/Iz+XKRcsN/1vJP59xcIYdnyT+iRPVz9PEf
         XqDUR+8daz0CINYLjsROik5nOdPp+S60Nl3rJ0UEifkBuUpJmOYBCi1YW1IxVmGTeKU6
         rIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wonpByTzbuJxA+M2ARgOF+/g8Val/wioKkFNzzsy6gU=;
        b=BwthoTjgy35z0Wszl435Vk/uCeLMnmcbBbdWtPG1GeAlMYLZJtGXvLFlt2EDZ7u/M3
         1Q9mUvfZPzIERhgSpJSXt1eF1kTk9TjVgWYba/QjrOtmAKDXe5n5a0EY9xgAQutdNKZr
         VEPuOiZBAZnxyiSuRB20vqdE/7z0rZvfWqtWIA7/GifYGky8x6UPmUVHSceE074YQqJi
         CtLKHsTRiZ1WR6ILx4YjLDlpSithzF+cvxPfQN0KmGErCnXBLNN84ScJ7q2MWxm+NGrP
         ga8AgEdyK2iTyxxX70pc72FXBJ4M3Ica6irhHdXRn/N+VsbFMSViPGH6WIPCjfQyJ5VD
         aVKw==
X-Gm-Message-State: AOAM530JYhsxIgJuzmhRCd/N/YcaBLQniowL+vdc1kgZqjALtIm2xPHx
        g7gJxJNbwGovl0D/sjcOpRn9oQqRzx5v4e9g2lQlFw==
X-Google-Smtp-Source: ABdhPJxK5Pg90c0+JTtmWbark/tL3Qlyr/DRIZ1JSHln2ehMftzFJstYHoGeuu5x3dUyK0eJCWTOCBOKuZDmD3Xamgk=
X-Received: by 2002:a0c:c583:: with SMTP id a3mr5176021qvj.2.1605713426500;
 Wed, 18 Nov 2020 07:30:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com> <c305a433db6fe8ef194cddf8615db0ef7a3b0355.1605305705.git.andreyknvl@google.com>
In-Reply-To: <c305a433db6fe8ef194cddf8615db0ef7a3b0355.1605305705.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 18 Nov 2020 16:30:15 +0100
Message-ID: <CAG_fn=Wy7fLJd46=N9U-yQAQreioEf2ny+CGNmhUVYpbWiXA1Q@mail.gmail.com>
Subject: Re: [PATCH mm v10 05/42] kasan: rename (un)poison_shadow to (un)poison_range
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
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

On Fri, Nov 13, 2020 at 11:16 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> The new mode won't be using shadow memory. Rename external annotation
> kasan_unpoison_shadow() to kasan_unpoison_range(), and introduce internal
> functions (un)poison_range() (without kasan_ prefix).
>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: Ia359f32815242c4704e49a5f1639ca2d2f8cba69
> ---
>  include/linux/kasan.h |  6 +++---
>  kernel/fork.c         |  4 ++--
>  mm/kasan/common.c     | 49 ++++++++++++++++++++++++-------------------
>  mm/kasan/generic.c    | 23 ++++++++++----------
>  mm/kasan/kasan.h      |  3 ++-
>  mm/kasan/tags.c       |  2 +-
>  mm/slab_common.c      |  2 +-
>  7 files changed, 47 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 26f2ab92e7ca..d237051dca58 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -71,7 +71,7 @@ extern void kasan_enable_current(void);
>  /* Disable reporting bugs for current task */
>  extern void kasan_disable_current(void);
>
> -void kasan_unpoison_shadow(const void *address, size_t size);
> +void kasan_unpoison_range(const void *address, size_t size);
>
>  void kasan_unpoison_task_stack(struct task_struct *task);
>
> @@ -108,7 +108,7 @@ struct kasan_cache {
>  size_t __ksize(const void *);
>  static inline void kasan_unpoison_slab(const void *ptr)
>  {
> -       kasan_unpoison_shadow(ptr, __ksize(ptr));
> +       kasan_unpoison_range(ptr, __ksize(ptr));
>  }
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>
> @@ -117,7 +117,7 @@ void kasan_restore_multi_shot(bool enabled);
>
>  #else /* CONFIG_KASAN */
>
> -static inline void kasan_unpoison_shadow(const void *address, size_t siz=
e) {}
> +static inline void kasan_unpoison_range(const void *address, size_t size=
) {}
>
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {=
}
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 15f189bb8ec4..bee52236f09b 100644
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
> +               kasan_unpoison_range(s->addr, THREAD_SIZE);
>
>                 /* Clear stale pointers from reused stack. */
>                 memset(s->addr, 0, THREAD_SIZE);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index f5739be60edc..6adbf5891aff 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -109,7 +109,7 @@ void *memcpy(void *dest, const void *src, size_t len)
>   * Poisons the shadow memory for 'size' bytes starting from 'addr'.
>   * Memory addresses should be aligned to KASAN_SHADOW_SCALE_SIZE.
>   */
> -void kasan_poison_shadow(const void *address, size_t size, u8 value)
> +void poison_range(const void *address, size_t size, u8 value)
>  {
>         void *shadow_start, *shadow_end;
>
> @@ -130,7 +130,7 @@ void kasan_poison_shadow(const void *address, size_t =
size, u8 value)
>         __memset(shadow_start, value, shadow_end - shadow_start);
>  }
>
> -void kasan_unpoison_shadow(const void *address, size_t size)
> +void unpoison_range(const void *address, size_t size)
>  {
>         u8 tag =3D get_tag(address);
>
> @@ -149,7 +149,7 @@ void kasan_unpoison_shadow(const void *address, size_=
t size)
>         if (is_kfence_address(address))
>                 return;
>
> -       kasan_poison_shadow(address, size, tag);
> +       poison_range(address, size, tag);
>
>         if (size & KASAN_SHADOW_MASK) {
>                 u8 *shadow =3D (u8 *)kasan_mem_to_shadow(address + size);
> @@ -161,12 +161,17 @@ void kasan_unpoison_shadow(const void *address, siz=
e_t size)
>         }
>  }
>
> +void kasan_unpoison_range(const void *address, size_t size)
> +{
> +       unpoison_range(address, size);
> +}
> +
>  static void __kasan_unpoison_stack(struct task_struct *task, const void =
*sp)
>  {
>         void *base =3D task_stack_page(task);
>         size_t size =3D sp - base;
>
> -       kasan_unpoison_shadow(base, size);
> +       unpoison_range(base, size);
>  }
>
>  /* Unpoison the entire stack for a task. */
> @@ -185,7 +190,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const=
 void *watermark)
>          */
>         void *base =3D (void *)((unsigned long)watermark & ~(THREAD_SIZE =
- 1));
>
> -       kasan_unpoison_shadow(base, watermark - base);
> +       unpoison_range(base, watermark - base);
>  }
>
>  void kasan_alloc_pages(struct page *page, unsigned int order)
> @@ -199,13 +204,13 @@ void kasan_alloc_pages(struct page *page, unsigned =
int order)
>         tag =3D random_tag();
>         for (i =3D 0; i < (1 << order); i++)
>                 page_kasan_tag_set(page + i, tag);
> -       kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
> +       unpoison_range(page_address(page), PAGE_SIZE << order);
>  }
>
>  void kasan_free_pages(struct page *page, unsigned int order)
>  {
>         if (likely(!PageHighMem(page)))
> -               kasan_poison_shadow(page_address(page),
> +               poison_range(page_address(page),
>                                 PAGE_SIZE << order,
>                                 KASAN_FREE_PAGE);
>  }
> @@ -297,18 +302,18 @@ void kasan_poison_slab(struct page *page)
>
>         for (i =3D 0; i < compound_nr(page); i++)
>                 page_kasan_tag_reset(page + i);
> -       kasan_poison_shadow(page_address(page), page_size(page),
> -                       KASAN_KMALLOC_REDZONE);
> +       poison_range(page_address(page), page_size(page),
> +                    KASAN_KMALLOC_REDZONE);
>  }
>
>  void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  {
> -       kasan_unpoison_shadow(object, cache->object_size);
> +       unpoison_range(object, cache->object_size);
>  }
>
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
> -       kasan_poison_shadow(object,
> +       poison_range(object,
>                         round_up(cache->object_size, KASAN_SHADOW_SCALE_S=
IZE),
>                         KASAN_KMALLOC_REDZONE);
>  }
> @@ -424,7 +429,7 @@ static bool __kasan_slab_free(struct kmem_cache *cach=
e, void *object,
>         }
>
>         rounded_up_size =3D round_up(cache->object_size, KASAN_SHADOW_SCA=
LE_SIZE);
> -       kasan_poison_shadow(object, rounded_up_size, KASAN_KMALLOC_FREE);
> +       poison_range(object, rounded_up_size, KASAN_KMALLOC_FREE);
>
>         if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
>                         unlikely(!(cache->flags & SLAB_KASAN)))
> @@ -467,9 +472,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache=
, const void *object,
>                 tag =3D assign_tag(cache, object, false, keep_tag);
>
>         /* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
> -       kasan_unpoison_shadow(set_tag(object, tag), size);
> -       kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_=
start,
> -               KASAN_KMALLOC_REDZONE);
> +       unpoison_range(set_tag(object, tag), size);
> +       poison_range((void *)redzone_start, redzone_end - redzone_start,
> +                    KASAN_KMALLOC_REDZONE);
>
>         if (cache->flags & SLAB_KASAN)
>                 kasan_set_track(&get_alloc_info(cache, object)->alloc_tra=
ck, flags);
> @@ -508,9 +513,9 @@ void * __must_check kasan_kmalloc_large(const void *p=
tr, size_t size,
>                                 KASAN_SHADOW_SCALE_SIZE);
>         redzone_end =3D (unsigned long)ptr + page_size(page);
>
> -       kasan_unpoison_shadow(ptr, size);
> -       kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_=
start,
> -               KASAN_PAGE_REDZONE);
> +       unpoison_range(ptr, size);
> +       poison_range((void *)redzone_start, redzone_end - redzone_start,
> +                    KASAN_PAGE_REDZONE);
>
>         return (void *)ptr;
>  }
> @@ -542,7 +547,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>                         kasan_report_invalid_free(ptr, ip);
>                         return;
>                 }
> -               kasan_poison_shadow(ptr, page_size(page), KASAN_FREE_PAGE=
);
> +               poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
>         } else {
>                 __kasan_slab_free(page->slab_cache, ptr, ip, false);
>         }
> @@ -728,7 +733,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsign=
ed long size)
>          * // vmalloc() allocates memory
>          * // let a =3D area->addr
>          * // we reach kasan_populate_vmalloc
> -        * // and call kasan_unpoison_shadow:
> +        * // and call unpoison_range:
>          * STORE shadow(a), unpoison_val
>          * ...
>          * STORE shadow(a+99), unpoison_val     x =3D LOAD p
> @@ -763,7 +768,7 @@ void kasan_poison_vmalloc(const void *start, unsigned=
 long size)
>                 return;
>
>         size =3D round_up(size, KASAN_SHADOW_SCALE_SIZE);
> -       kasan_poison_shadow(start, size, KASAN_VMALLOC_INVALID);
> +       poison_range(start, size, KASAN_VMALLOC_INVALID);
>  }
>
>  void kasan_unpoison_vmalloc(const void *start, unsigned long size)
> @@ -771,7 +776,7 @@ void kasan_unpoison_vmalloc(const void *start, unsign=
ed long size)
>         if (!is_vmalloc_or_module_addr(start))
>                 return;
>
> -       kasan_unpoison_shadow(start, size);
> +       unpoison_range(start, size);
>  }
>
>  static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d6a386255007..cdc2d8112f3e 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -203,11 +203,11 @@ static void register_global(struct kasan_global *gl=
obal)
>  {
>         size_t aligned_size =3D round_up(global->size, KASAN_SHADOW_SCALE=
_SIZE);
>
> -       kasan_unpoison_shadow(global->beg, global->size);
> +       unpoison_range(global->beg, global->size);
>
> -       kasan_poison_shadow(global->beg + aligned_size,
> -               global->size_with_redzone - aligned_size,
> -               KASAN_GLOBAL_REDZONE);
> +       poison_range(global->beg + aligned_size,
> +                    global->size_with_redzone - aligned_size,
> +                    KASAN_GLOBAL_REDZONE);
>  }
>
>  void __asan_register_globals(struct kasan_global *globals, size_t size)
> @@ -286,13 +286,12 @@ void __asan_alloca_poison(unsigned long addr, size_=
t size)
>
>         WARN_ON(!IS_ALIGNED(addr, KASAN_ALLOCA_REDZONE_SIZE));
>
> -       kasan_unpoison_shadow((const void *)(addr + rounded_down_size),
> -                             size - rounded_down_size);
> -       kasan_poison_shadow(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
> -                       KASAN_ALLOCA_LEFT);
> -       kasan_poison_shadow(right_redzone,
> -                       padding_size + KASAN_ALLOCA_REDZONE_SIZE,
> -                       KASAN_ALLOCA_RIGHT);
> +       unpoison_range((const void *)(addr + rounded_down_size),
> +                      size - rounded_down_size);
> +       poison_range(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
> +                    KASAN_ALLOCA_LEFT);
> +       poison_range(right_redzone, padding_size + KASAN_ALLOCA_REDZONE_S=
IZE,
> +                    KASAN_ALLOCA_RIGHT);
>  }
>  EXPORT_SYMBOL(__asan_alloca_poison);
>
> @@ -302,7 +301,7 @@ void __asan_allocas_unpoison(const void *stack_top, c=
onst void *stack_bottom)
>         if (unlikely(!stack_top || stack_top > stack_bottom))
>                 return;
>
> -       kasan_unpoison_shadow(stack_top, stack_bottom - stack_top);
> +       unpoison_range(stack_top, stack_bottom - stack_top);
>  }
>  EXPORT_SYMBOL(__asan_allocas_unpoison);
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ac499456740f..42ab02c61331 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -150,7 +150,8 @@ static inline bool addr_has_shadow(const void *addr)
>         return (addr >=3D kasan_shadow_to_mem((void *)KASAN_SHADOW_START)=
);
>  }
>
> -void kasan_poison_shadow(const void *address, size_t size, u8 value);
> +void poison_range(const void *address, size_t size, u8 value);
> +void unpoison_range(const void *address, size_t size);
>
>  /**
>   * check_memory_region - Check memory region, and report if invalid acce=
ss.
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 5c8b08a25715..c0b3f327812b 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -153,7 +153,7 @@ EXPORT_SYMBOL(__hwasan_storeN_noabort);
>
>  void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
>  {
> -       kasan_poison_shadow((void *)addr, size, tag);
> +       poison_range((void *)addr, size, tag);
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
>
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 479d17b90155..0b5ae1819a8b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1179,7 +1179,7 @@ size_t ksize(const void *objp)
>          * We assume that ksize callers could use whole allocated area,
>          * so we need to unpoison this area.
>          */
> -       kasan_unpoison_shadow(objp, size);
> +       kasan_unpoison_range(objp, size);
>         return size;
>  }
>  EXPORT_SYMBOL(ksize);
> --
> 2.29.2.299.gdc1121823c-goog
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

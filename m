Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F272AF1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKKNWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKKNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:22:05 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC648C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:22:05 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id q7so823914qvt.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+bz5ZIdNzpU0ai7uZOTCO8K/nvk/MwhwV4tVntYFBxU=;
        b=I8TMNct/OSdKmpCOZ3HD9K/tKxJD1ALDaOzC8e/kyKSXEbezfBMmhXlgFNEgKcQgO7
         0q3ZMqUHniCGv7KpPfamJDyg+yOJqEETrhZw5X7OaqowclTbLzp2ZerMUmMFmIHVGXPC
         FUauCeETbbipXOU9j29RkqxQPiU+rIvZO5H4etJjIA4VUKnV6yfTZGH/NaZZvX2/s9EQ
         cvM6Bz8aW1UWw0owW1hjmbMA06tAUreB+WH+u6FZlvNdO+cZsi2ulbecrXKyrxG7KK4B
         rlyfOF90AtXOuE9zeNms7c0DzfM0UN+IFUvEZedz3Ij9/NrWIfHK4N6YVSYstJpCc+g4
         Qzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+bz5ZIdNzpU0ai7uZOTCO8K/nvk/MwhwV4tVntYFBxU=;
        b=lGak/69KZ1RhQVoRJNMAXR8JeWCneV4olQocnFUdzm6Qvzb+sT+6ctuXMUw+QGwgWU
         7B4GtpvdGLrPM1OrnOllBzbIr8GcvPT8imWMRZK3DXfs2LNYLQNAaWjkcgBKwKEn9gMX
         ITbXVuA0moasFPkwxErnysL9XQAj0D+U08/1htRfRQ43whf+PhsJODQF9R81a7DDBTHC
         VVI1c5iAl29JBNNyZJXmbOmG4AL9bsSecgvtMDo3Hzbtg4xXiFVwPywP8lS4gAS+wc6i
         a2IxbaUblwvC4DEeFwZFaJfW+1GIqrgv/WlvTnUtn4vplLHX2gWRS5IVpByPO9D/4nnl
         9XhA==
X-Gm-Message-State: AOAM530NtlvRlynemYQ2+Gg/BHNB2l71qmd7hZyE2iWSnNi7g79Af/12
        7/SzkKnRHbU/9Eu+NPsS7F+x48X+AWp771n9LCuF9w==
X-Google-Smtp-Source: ABdhPJwe8xPs0etNN1pHXsV4nXiqxllXHt2B3lVDekaoqd041s/GEY/SgbNHtKb2osgsT7DLYBjv1i2wkRgxVmIyELQ=
X-Received: by 2002:a05:6214:d43:: with SMTP id 3mr3584715qvr.38.1605100924596;
 Wed, 11 Nov 2020 05:22:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <4d261d4cbd9842c51cb6f9b36cadc9054cabe86b.1605046192.git.andreyknvl@google.com>
In-Reply-To: <4d261d4cbd9842c51cb6f9b36cadc9054cabe86b.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 14:21:52 +0100
Message-ID: <CAG_fn=VseeYfkzogUaqj6hqSjZzaEGe=0jkQYRu=2S0m7Vrd=g@mail.gmail.com>
Subject: Re: [PATCH v9 03/44] kasan: group vmalloc code
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
> Group all vmalloc-related function declarations in include/linux/kasan.h,
> and their implementations in mm/kasan/common.c.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
> Change-Id: Ie20b6c689203cd6de4fd7f2c465ec081c00c5f15
> ---
>  include/linux/kasan.h | 41 +++++++++++++----------
>  mm/kasan/common.c     | 78 ++++++++++++++++++++++---------------------
>  2 files changed, 63 insertions(+), 56 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 30d343b4a40a..59538e795df4 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -75,19 +75,6 @@ struct kasan_cache {
>         int free_meta_offset;
>  };
>
> -/*
> - * These functions provide a special case to support backing module
> - * allocations with real shadow memory. With KASAN vmalloc, the special
> - * case is unnecessary, as the work is handled in the generic case.
> - */
> -#ifndef CONFIG_KASAN_VMALLOC
> -int kasan_module_alloc(void *addr, size_t size);
> -void kasan_free_shadow(const struct vm_struct *vm);
> -#else
> -static inline int kasan_module_alloc(void *addr, size_t size) { return 0=
; }
> -static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> -#endif
> -
>  int kasan_add_zero_shadow(void *start, unsigned long size);
>  void kasan_remove_zero_shadow(void *start, unsigned long size);
>
> @@ -156,9 +143,6 @@ static inline bool kasan_slab_free(struct kmem_cache =
*s, void *object,
>         return false;
>  }
>
> -static inline int kasan_module_alloc(void *addr, size_t size) { return 0=
; }
> -static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> -
>  static inline int kasan_add_zero_shadow(void *start, unsigned long size)
>  {
>         return 0;
> @@ -211,13 +195,16 @@ static inline void *kasan_reset_tag(const void *add=
r)
>  #endif /* CONFIG_KASAN_SW_TAGS */
>
>  #ifdef CONFIG_KASAN_VMALLOC
> +
>  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>  void kasan_poison_vmalloc(const void *start, unsigned long size);
>  void kasan_unpoison_vmalloc(const void *start, unsigned long size);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>                            unsigned long free_region_start,
>                            unsigned long free_region_end);
> -#else
> +
> +#else /* CONFIG_KASAN_VMALLOC */
> +
>  static inline int kasan_populate_vmalloc(unsigned long start,
>                                         unsigned long size)
>  {
> @@ -232,7 +219,25 @@ static inline void kasan_release_vmalloc(unsigned lo=
ng start,
>                                          unsigned long end,
>                                          unsigned long free_region_start,
>                                          unsigned long free_region_end) {=
}
> -#endif
> +
> +#endif /* CONFIG_KASAN_VMALLOC */
> +
> +#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
> +
> +/*
> + * These functions provide a special case to support backing module
> + * allocations with real shadow memory. With KASAN vmalloc, the special
> + * case is unnecessary, as the work is handled in the generic case.
> + */
> +int kasan_module_alloc(void *addr, size_t size);
> +void kasan_free_shadow(const struct vm_struct *vm);
> +
> +#else /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
> +
> +static inline int kasan_module_alloc(void *addr, size_t size) { return 0=
; }
> +static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> +
> +#endif /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
>
>  #ifdef CONFIG_KASAN_INLINE
>  void kasan_non_canonical_hook(unsigned long addr);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 33d863f55db1..89e5ef9417a7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -536,44 +536,6 @@ void kasan_kfree_large(void *ptr, unsigned long ip)
>         /* The object will be poisoned by page_alloc. */
>  }
>
> -#ifndef CONFIG_KASAN_VMALLOC
> -int kasan_module_alloc(void *addr, size_t size)
> -{
> -       void *ret;
> -       size_t scaled_size;
> -       size_t shadow_size;
> -       unsigned long shadow_start;
> -
> -       shadow_start =3D (unsigned long)kasan_mem_to_shadow(addr);
> -       scaled_size =3D (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_=
SHIFT;
> -       shadow_size =3D round_up(scaled_size, PAGE_SIZE);
> -
> -       if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
> -               return -EINVAL;
> -
> -       ret =3D __vmalloc_node_range(shadow_size, 1, shadow_start,
> -                       shadow_start + shadow_size,
> -                       GFP_KERNEL,
> -                       PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
> -                       __builtin_return_address(0));
> -
> -       if (ret) {
> -               __memset(ret, KASAN_SHADOW_INIT, shadow_size);
> -               find_vm_area(addr)->flags |=3D VM_KASAN;
> -               kmemleak_ignore(ret);
> -               return 0;
> -       }
> -
> -       return -ENOMEM;
> -}
> -
> -void kasan_free_shadow(const struct vm_struct *vm)
> -{
> -       if (vm->flags & VM_KASAN)
> -               vfree(kasan_mem_to_shadow(vm->addr));
> -}
> -#endif
> -
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  static bool shadow_mapped(unsigned long addr)
>  {
> @@ -685,6 +647,7 @@ core_initcall(kasan_memhotplug_init);
>  #endif
>
>  #ifdef CONFIG_KASAN_VMALLOC
> +
>  static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>                                       void *unused)
>  {
> @@ -923,4 +886,43 @@ void kasan_release_vmalloc(unsigned long start, unsi=
gned long end,
>                                        (unsigned long)shadow_end);
>         }
>  }
> +
> +#else /* CONFIG_KASAN_VMALLOC */
> +
> +int kasan_module_alloc(void *addr, size_t size)
> +{
> +       void *ret;
> +       size_t scaled_size;
> +       size_t shadow_size;
> +       unsigned long shadow_start;
> +
> +       shadow_start =3D (unsigned long)kasan_mem_to_shadow(addr);
> +       scaled_size =3D (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_=
SHIFT;
> +       shadow_size =3D round_up(scaled_size, PAGE_SIZE);
> +
> +       if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
> +               return -EINVAL;
> +
> +       ret =3D __vmalloc_node_range(shadow_size, 1, shadow_start,
> +                       shadow_start + shadow_size,
> +                       GFP_KERNEL,
> +                       PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
> +                       __builtin_return_address(0));
> +
> +       if (ret) {
> +               __memset(ret, KASAN_SHADOW_INIT, shadow_size);
> +               find_vm_area(addr)->flags |=3D VM_KASAN;
> +               kmemleak_ignore(ret);
> +               return 0;
> +       }
> +
> +       return -ENOMEM;
> +}
> +
> +void kasan_free_shadow(const struct vm_struct *vm)
> +{
> +       if (vm->flags & VM_KASAN)
> +               vfree(kasan_mem_to_shadow(vm->addr));
> +}
> +
>  #endif
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

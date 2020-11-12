Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD292B0B65
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKLRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKLRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:37:16 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64EAC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 09:37:16 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so6064681qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kJRnZ1K/SsMcONZmbTC+Qa5zVrzQ+5qdaa05c9kyYcM=;
        b=um5dEiJDzmdCEn0lysRTTmQ5twszC0197uKGGc8b9Z67gZ+csuw/ScevXdxkwb57xG
         6gGkAySnv79WvfipRug4cxlXr2PUHshKutHxClLbTfYM0ckvVFXVNBrrMKjz4mIojPJa
         DzMPXG6FQmdJye49gJ79XA75NQGbDcIoGhCJwsBKvTZ/AGP2tGNcb39ULoNEw/4oKlNZ
         N2nPzk4/KJvpjI9VVlhyL4C17oZSLbQI7Hm9nbZPC+CXrUsBu+2E3YrlcxPC6uT/68aY
         ww4IwvbOoM9axz0PkiCOWizA+X5aUK/X87Ce1jnepe5NwOqv8bRiK+GMZ1ioTeIDLzQ9
         NFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kJRnZ1K/SsMcONZmbTC+Qa5zVrzQ+5qdaa05c9kyYcM=;
        b=nd06NJ1b5/aSVEFYuXUHwCSWEoTQrEtTrDheW8YDjdNlr9zIRr+2kqh2C/2O6EYPlV
         g5R/ey4Z2lVvBSuqIDPfBrwcelp6AZfegJkZjWPE2EALEvlwgqpkZZX4ABTrAUtDEvDl
         5HAZ8WiBE6iEMXnEQkTA3rF1HiSFoWEbqQHN9ZrWRSqlMRXhOctufhSMojT4E+6zf2eL
         eZC/632ZCxsrtvgFCWkKww3vKYNo+aqNwtFUItRcLiMb2kyd41xIDvo+LlPS+ySPywDM
         6ITJ4+7kK5IkoBDY79uWjCGUFbmt683bNPQ/xKdINbNMZyMKXaQvs2PSI3Oychsx62mA
         GaDw==
X-Gm-Message-State: AOAM531iZ3OC6fDOfqjbpr7BvRO1sY/8Yk/Z/7rfGVCIABzAgskyecUL
        bqz4tpNQrWhO+RvS3Wfy3dxSnPJBQCcJ4mNT9PjooA==
X-Google-Smtp-Source: ABdhPJxXh8nPoVEd67ermQjq724Rssu6N/6rmkDVNIks/hVZu2CeLlf85Dr+sSKNdsxgKrEfgdlB6m25uKGOMwQ9puo=
X-Received: by 2002:a05:620a:211b:: with SMTP id l27mr924168qkl.352.1605202635455;
 Thu, 12 Nov 2020 09:37:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <9f8119934070b7ffa8d129b64c9d05644ce7d20a.1605046192.git.andreyknvl@google.com>
In-Reply-To: <9f8119934070b7ffa8d129b64c9d05644ce7d20a.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Nov 2020 18:37:04 +0100
Message-ID: <CAG_fn=XOWPVX+Muysqu_u0w4o_rpyb+XuUZW2+pC9T6WG_3-iw@mail.gmail.com>
Subject: Re: [PATCH v9 39/44] kasan, arm64: implement HW_TAGS runtime
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

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> Provide implementation of KASAN functions required for the hardware
> tag-based mode. Those include core functions for memory and pointer
> tagging (tags_hw.c) and bug reporting (report_tags_hw.c). Also adapt
> common KASAN code to support the new mode.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I8a8689ba098174a4d0ef3f1d008178387c80ee1c
> ---
>  arch/arm64/include/asm/memory.h   |  4 +-
>  arch/arm64/kernel/cpufeature.c    |  3 ++
>  arch/arm64/kernel/smp.c           |  2 +
>  include/linux/kasan.h             | 24 +++++++---
>  include/linux/mm.h                |  2 +-
>  include/linux/page-flags-layout.h |  2 +-
>  mm/kasan/Makefile                 |  5 ++
>  mm/kasan/common.c                 | 15 +++---
>  mm/kasan/hw_tags.c                | 80 +++++++++++++++++++++++++++++++
>  mm/kasan/kasan.h                  | 17 +++++--
>  mm/kasan/report_hw_tags.c         | 42 ++++++++++++++++
>  mm/kasan/report_sw_tags.c         |  2 +-
>  mm/kasan/shadow.c                 |  2 +-
>  mm/kasan/sw_tags.c                |  2 +-
>  14 files changed, 177 insertions(+), 25 deletions(-)
>  create mode 100644 mm/kasan/hw_tags.c
>  create mode 100644 mm/kasan/report_hw_tags.c
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
> index 656aaddb7014..5042eef5b111 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -214,7 +214,7 @@ static inline unsigned long kaslr_offset(void)
>         (__force __typeof__(addr))__addr;                               \
>  })
>
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  #define __tag_shifted(tag)     ((u64)(tag) << 56)
>  #define __tag_reset(addr)      __untagged_addr(addr)
>  #define __tag_get(addr)                (__u8)((u64)(addr) >> 56)
> @@ -222,7 +222,7 @@ static inline unsigned long kaslr_offset(void)
>  #define __tag_shifted(tag)     0UL
>  #define __tag_reset(addr)      (addr)
>  #define __tag_get(addr)                0
> -#endif /* CONFIG_KASAN_SW_TAGS */
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>
>  static inline const void *__tag_set(const void *addr, u8 tag)
>  {
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c
> index dcc165b3fc04..6a1f2e3558c5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -70,6 +70,7 @@
>  #include <linux/types.h>
>  #include <linux/mm.h>
>  #include <linux/cpu.h>
> +#include <linux/kasan.h>
>  #include <asm/cpu.h>
>  #include <asm/cpufeature.h>
>  #include <asm/cpu_ops.h>
> @@ -1704,6 +1705,8 @@ static void cpu_enable_mte(struct arm64_cpu_capabil=
ities const *cap)
>                 cleared_zero_page =3D true;
>                 mte_clear_page_tags(lm_alias(empty_zero_page));
>         }
> +
> +       kasan_init_hw_tags_cpu();
>  }
>  #endif /* CONFIG_ARM64_MTE */
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 09c96f57818c..7235b9478413 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -461,6 +461,8 @@ void __init smp_prepare_boot_cpu(void)
>         /* Conditionally switch to GIC PMR for interrupt masking */
>         if (system_uses_irq_prio_masking())
>                 init_gic_priority_masking();
> +
> +       kasan_init_hw_tags();
>  }
>
>  static u64 __init of_get_cpu_mpidr(struct device_node *dn)
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b6fc14b3da53..f22bdef82111 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -189,25 +189,35 @@ static inline void kasan_record_aux_stack(void *ptr=
) {}
>
>  #endif /* CONFIG_KASAN_GENERIC */
>
> -#ifdef CONFIG_KASAN_SW_TAGS
> -
> -void __init kasan_init_sw_tags(void);
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>
>  void *kasan_reset_tag(const void *addr);
>
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
>
> -#else /* CONFIG_KASAN_SW_TAGS */
> -
> -static inline void kasan_init_sw_tags(void) { }
> +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>
>  static inline void *kasan_reset_tag(const void *addr)
>  {
>         return (void *)addr;
>  }
>
> -#endif /* CONFIG_KASAN_SW_TAGS */
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
> +
> +#ifdef CONFIG_KASAN_SW_TAGS
> +void __init kasan_init_sw_tags(void);
> +#else
> +static inline void kasan_init_sw_tags(void) { }
> +#endif
> +
> +#ifdef CONFIG_KASAN_HW_TAGS
> +void kasan_init_hw_tags_cpu(void);
> +void kasan_init_hw_tags(void);
> +#else
> +static inline void kasan_init_hw_tags_cpu(void) { }
> +static inline void kasan_init_hw_tags(void) { }
> +#endif
>
>  #ifdef CONFIG_KASAN_VMALLOC
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index db6ae4d3fb4e..0793d03a4183 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1413,7 +1413,7 @@ static inline bool cpupid_match_pid(struct task_str=
uct *task, int cpupid)
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
>
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
>         return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags=
-layout.h
> index e200eef6a7fd..7d4ec26d8a3e 100644
> --- a/include/linux/page-flags-layout.h
> +++ b/include/linux/page-flags-layout.h
> @@ -77,7 +77,7 @@
>  #define LAST_CPUPID_SHIFT 0
>  #endif
>
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  #define KASAN_TAG_WIDTH 8
>  #else
>  #define KASAN_TAG_WIDTH 0
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index f1d68a34f3c9..9fe39a66388a 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -10,8 +10,10 @@ CFLAGS_REMOVE_init.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_quarantine.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report_generic.o =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report_hw_tags.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report_sw_tags.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_shadow.o =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_hw_tags.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_sw_tags.o =3D $(CC_FLAGS_FTRACE)
>
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_sto=
re1
> @@ -27,10 +29,13 @@ CFLAGS_init.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_quarantine.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report_generic.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_report_hw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report_sw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_shadow.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_hw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_sw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>
>  obj-$(CONFIG_KASAN) :=3D common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o report_generic.o shado=
w.o quarantine.o
> +obj-$(CONFIG_KASAN_HW_TAGS) +=3D hw_tags.o report_hw_tags.o
>  obj-$(CONFIG_KASAN_SW_TAGS) +=3D init.o report_sw_tags.o shadow.o sw_tag=
s.o
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d0b3ff410b0c..2bb0ef6da6bd 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -113,7 +113,7 @@ void kasan_free_pages(struct page *page, unsigned int=
 order)
>   */
>  static inline unsigned int optimal_redzone(unsigned int object_size)
>  {
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC))
>                 return 0;
>
>         return
> @@ -178,14 +178,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache=
)
>  struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
>                                         const void *object)
>  {
> -       return (void *)object + cache->kasan_info.alloc_meta_offset;
> +       return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_o=
ffset;
>  }
>
>  struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>                                       const void *object)
>  {
>         BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
> -       return (void *)object + cache->kasan_info.free_meta_offset;
> +       return (void *)reset_tag(object) + cache->kasan_info.free_meta_of=
fset;
>  }
>
>  void kasan_poison_slab(struct page *page)
> @@ -267,9 +267,8 @@ void * __must_check kasan_init_slab_obj(struct kmem_c=
ache *cache,
>         alloc_info =3D get_alloc_info(cache, object);
>         __memset(alloc_info, 0, sizeof(*alloc_info));
>
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> -               object =3D set_tag(object,
> -                               assign_tag(cache, object, true, false));
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_H=
W_TAGS))
> +               object =3D set_tag(object, assign_tag(cache, object, true=
, false));
>
>         return (void *)object;
>  }
> @@ -337,10 +336,10 @@ static void *__kasan_kmalloc(struct kmem_cache *cac=
he, const void *object,
>         redzone_end =3D round_up((unsigned long)object + cache->object_si=
ze,
>                                 KASAN_GRANULE_SIZE);
>
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_H=
W_TAGS))
>                 tag =3D assign_tag(cache, object, false, keep_tag);
>
> -       /* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
> +       /* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
>         kasan_unpoison_memory(set_tag(object, tag), size);
>         kasan_poison_memory((void *)redzone_start, redzone_end - redzone_=
start,
>                 KASAN_KMALLOC_REDZONE);
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> new file mode 100644
> index 000000000000..0080b78ec843
> --- /dev/null
> +++ b/mm/kasan/hw_tags.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains core hardware tag-based KASAN code.
> + *
> + * Copyright (c) 2020 Google, Inc.
> + * Author: Andrey Konovalov <andreyknvl@google.com>
> + */
> +
> +#define pr_fmt(fmt) "kasan: " fmt
> +
> +#include <linux/kasan.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "kasan.h"
> +
> +/* kasan_init_hw_tags_cpu() is called for each CPU. */
> +void kasan_init_hw_tags_cpu(void)
> +{
> +       hw_init_tags(KASAN_TAG_MAX);
> +       hw_enable_tagging();
> +}
> +
> +/* kasan_init_hw_tags() is called once on boot CPU. */
> +void kasan_init_hw_tags(void)
> +{
> +       pr_info("KernelAddressSanitizer initialized\n");
> +}
> +
> +void *kasan_reset_tag(const void *addr)
> +{
> +       return reset_tag(addr);
> +}
> +
> +void kasan_poison_memory(const void *address, size_t size, u8 value)
> +{
> +       hw_set_mem_tag_range(reset_tag(address),
> +                       round_up(size, KASAN_GRANULE_SIZE), value);
> +}
> +
> +void kasan_unpoison_memory(const void *address, size_t size)
> +{
> +       hw_set_mem_tag_range(reset_tag(address),
> +                       round_up(size, KASAN_GRANULE_SIZE), get_tag(addre=
ss));
> +}
> +
> +u8 random_tag(void)
> +{
> +       return hw_get_random_tag();
> +}
> +
> +bool check_invalid_free(void *addr)
> +{
> +       u8 ptr_tag =3D get_tag(addr);
> +       u8 mem_tag =3D hw_get_mem_tag(addr);
> +
> +       return (mem_tag =3D=3D KASAN_TAG_INVALID) ||
> +               (ptr_tag !=3D KASAN_TAG_KERNEL && ptr_tag !=3D mem_tag);
> +}
> +
> +void kasan_set_free_info(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta =3D get_alloc_info(cache, object);
> +       kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
> +}
> +
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +                               void *object, u8 tag)
> +{
> +       struct kasan_alloc_meta *alloc_meta;
> +
> +       alloc_meta =3D get_alloc_info(cache, object);
> +       return &alloc_meta->free_track[0];
> +}
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index d745a78745dd..21fe75c66f26 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,6 +153,10 @@ struct kasan_alloc_meta *get_alloc_info(struct kmem_=
cache *cache,
>  struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>                                         const void *object);
>
> +void kasan_poison_memory(const void *address, size_t size, u8 value);
> +
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  {
>         return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET=
)
> @@ -164,8 +168,6 @@ static inline bool addr_has_metadata(const void *addr=
)
>         return (addr >=3D kasan_shadow_to_mem((void *)KASAN_SHADOW_START)=
);
>  }
>
> -void kasan_poison_memory(const void *address, size_t size, u8 value);
> -
>  /**
>   * check_memory_region - Check memory region, and report if invalid acce=
ss.
>   * @addr: the accessed address
> @@ -177,6 +179,15 @@ void kasan_poison_memory(const void *address, size_t=
 size, u8 value);
>  bool check_memory_region(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip);
>
> +#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +static inline bool addr_has_metadata(const void *addr)
> +{
> +       return true;
> +}
> +
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
>  bool check_invalid_free(void *addr);
>
>  void *find_first_bad_addr(void *addr, size_t size);
> @@ -213,7 +224,7 @@ static inline void quarantine_reduce(void) { }
>  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
>  #endif
>
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>
>  void print_tags(u8 addr_tag, const void *addr);
>
> diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> new file mode 100644
> index 000000000000..da543eb832cd
> --- /dev/null
> +++ b/mm/kasan/report_hw_tags.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains hardware tag-based KASAN specific error reporting =
code.
> + *
> + * Copyright (c) 2020 Google, Inc.
> + * Author: Andrey Konovalov <andreyknvl@google.com>
> + */
> +
> +#include <linux/kasan.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "kasan.h"
> +
> +const char *get_bug_type(struct kasan_access_info *info)
> +{
> +       return "invalid-access";
> +}
> +
> +void *find_first_bad_addr(void *addr, size_t size)
> +{
> +       return reset_tag(addr);
> +}
> +
> +void metadata_fetch_row(char *buffer, void *row)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < META_BYTES_PER_ROW; i++)
> +               buffer[i] =3D hw_get_mem_tag(row + i * KASAN_GRANULE_SIZE=
);
> +}
> +
> +void print_tags(u8 addr_tag, const void *addr)
> +{
> +       u8 memory_tag =3D hw_get_mem_tag((void *)addr);
> +
> +       pr_err("Pointer tag: [%02x], memory tag: [%02x]\n",
> +               addr_tag, memory_tag);
> +}
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index add2dfe6169c..aebc44a29e83 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file contains tag-based KASAN specific error reporting code.
> + * This file contains software tag-based KASAN specific error reporting =
code.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 1fadd4930d54..616ac64c4a21 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -107,7 +107,7 @@ void kasan_unpoison_memory(const void *address, size_=
t size)
>
>                 if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>                         *shadow =3D tag;
> -               else
> +               else /* CONFIG_KASAN_GENERIC */
>                         *shadow =3D size & KASAN_GRANULE_MASK;
>         }
>  }
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index b09a2c06abad..dfe707dd8d0d 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file contains core tag-based KASAN code.
> + * This file contains core software tag-based KASAN code.
>   *
>   * Copyright (c) 2018 Google, Inc.
>   * Author: Andrey Konovalov <andreyknvl@google.com>
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

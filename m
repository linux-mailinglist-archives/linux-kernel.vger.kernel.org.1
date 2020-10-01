Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8472128061D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbgJASBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJASBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:01:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73279C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:01:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so4116871wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+3KiHTF4QPL9gp8eIxPfICCMyUp098bhGRU4jPixZM=;
        b=LYtcPtyVJztqZMcHU6F6RtYCOV2u0qfUcvD93OIBlf6fAjMBWLF75pZlFVwScbBygF
         wtGh0lo31ipRUT2iyxZCLWBu/8EAum0LTv3glpbDebaQ+Fj87eQEzFHe3sIDVFWustJ4
         g3b0+2X9h4u8L/H5bXQzr1DXysadq8jfTZt1b9gIr9mTW1fZaT4b8I7RSBOTo+yALKH9
         etJV94yZXUTBuo/oZ34547uhPD4yDI0V8Mr9LX4UuXDgxc7bOemXxGGOkAgleCkHPPqj
         KuU/DNSJ9J4jFH4+rHyjiweDGFLJMxZXwh7USSz3+lLQk4H2UqmHdzjT8VuVX2wnwgpJ
         qrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+3KiHTF4QPL9gp8eIxPfICCMyUp098bhGRU4jPixZM=;
        b=p+X62t/WNiJLKPFbzPczvRNUeDGJSrS7/ejdXabnoB+zXieXxHbQ+Rd5X8rhuHfcCV
         EaVzRsy4d0g8T+1YMElMh3Gi5HbQYu/+7KWSlAljb9R70I+UAZG/x3mLgSJ8d7212qs5
         FlU8LqgQpC+XfR4P/XTIkDe6hqSMzmcs/V47RNgloVTWsxDAvPIDWDEIUt1hL32pcnDv
         qVvh1Kfe5NlKkmZjU6jv0eRe+L0u9Q6Aoqeoj/qmVkwee97i+SO4XV/gWDE83uoRpNj6
         lNamCd2ZX3DJq49C2y2IdyVMWt4ZwVqonCa4rmwLuPXH3939/7/htTBiK1JR7ZsU5G5n
         lxzQ==
X-Gm-Message-State: AOAM531H3pDlfz3F8z3u9MrXRpWdYrE00SQaFsW3xJklIqjfCjTUljs9
        Ta4S+57AVpPGSetJx2JPxL8yYw==
X-Google-Smtp-Source: ABdhPJx1IzLh2LzqztKCJY0HMW5YKQnlLBUY7eaYeRN1qHyEMBkI91xdiaGt24QtJKtI3fn378HtWg==
X-Received: by 2002:a7b:c0ca:: with SMTP id s10mr1175512wmh.103.1601575261714;
        Thu, 01 Oct 2020 11:01:01 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id l17sm993389wme.11.2020.10.01.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 11:01:00 -0700 (PDT)
Date:   Thu, 1 Oct 2020 20:00:55 +0200
From:   elver@google.com
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/39] kasan, arm64: implement HW_TAGS runtime
Message-ID: <20201001180055.GU4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <391e41cda292731f310367b04a9ee2bd08dc3b6b.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391e41cda292731f310367b04a9ee2bd08dc3b6b.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Provide implementation of KASAN functions required for the hardware
> tag-based mode. Those include core functions for memory and pointer
> tagging (tags_hw.c) and bug reporting (report_tags_hw.c). Also adapt
> common KASAN code to support the new mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I8a8689ba098174a4d0ef3f1d008178387c80ee1c
> ---
>  arch/arm64/include/asm/memory.h   |  4 +-
>  arch/arm64/kernel/setup.c         |  5 ++-
>  include/linux/kasan.h             |  6 +--
>  include/linux/mm.h                |  2 +-
>  include/linux/page-flags-layout.h |  2 +-
>  mm/kasan/Makefile                 |  5 +++
>  mm/kasan/common.c                 | 15 ++++---
>  mm/kasan/hw_tags.c                | 70 +++++++++++++++++++++++++++++++
>  mm/kasan/kasan.h                  | 17 ++++++--
>  mm/kasan/report_hw_tags.c         | 42 +++++++++++++++++++
>  mm/kasan/report_sw_tags.c         |  2 +-
>  mm/kasan/shadow.c                 |  2 +-
>  mm/kasan/sw_tags.c                |  2 +-
>  13 files changed, 152 insertions(+), 22 deletions(-)
>  create mode 100644 mm/kasan/hw_tags.c
>  create mode 100644 mm/kasan/report_hw_tags.c
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index de9af7bea90d..b5d6b824c21c 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -215,7 +215,7 @@ static inline unsigned long kaslr_offset(void)
>  	(__force __typeof__(addr))__addr;				\
>  })
>  
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  #define __tag_shifted(tag)	((u64)(tag) << 56)
>  #define __tag_reset(addr)	__untagged_addr(addr)
>  #define __tag_get(addr)		(__u8)((u64)(addr) >> 56)
> @@ -223,7 +223,7 @@ static inline unsigned long kaslr_offset(void)
>  #define __tag_shifted(tag)	0UL
>  #define __tag_reset(addr)	(addr)
>  #define __tag_get(addr)		0
> -#endif /* CONFIG_KASAN_SW_TAGS */
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>  
>  static inline const void *__tag_set(const void *addr, u8 tag)
>  {
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 77c4c9bad1b8..b07d9fbfa8b6 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -358,7 +358,10 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	smp_init_cpus();
>  	smp_build_mpidr_hash();
>  
> -	/* Init percpu seeds for random tags after cpus are set up. */
> +	/*
> +	 * For CONFIG_KASAN_SW_TAGS this initializes percpu seeds and must
> +	 * come after cpus are set up.
> +	 */
>  	kasan_init_tags();
>  
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 94b974f15892..80a0e5b11f2b 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -178,7 +178,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>  
>  #endif /* CONFIG_KASAN_GENERIC */
>  
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  
>  void kasan_init_tags(void);
>  
> @@ -187,7 +187,7 @@ void *kasan_reset_tag(const void *addr);
>  bool kasan_report(unsigned long addr, size_t size,
>  		bool is_write, unsigned long ip);
>  
> -#else /* CONFIG_KASAN_SW_TAGS */
> +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>  
>  static inline void kasan_init_tags(void) { }
>  
> @@ -196,7 +196,7 @@ static inline void *kasan_reset_tag(const void *addr)
>  	return (void *)addr;
>  }
>  
> -#endif /* CONFIG_KASAN_SW_TAGS */
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
>  
>  #ifdef CONFIG_KASAN_VMALLOC
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4312c6c808e9..a3cac68c737c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1411,7 +1411,7 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
>  
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
>  	return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
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
> @@ -10,8 +10,10 @@ CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_quarantine.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report_generic.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report_hw_tags.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report_sw_tags.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_shadow.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_hw_tags.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_sw_tags.o = $(CC_FLAGS_FTRACE)
>  
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
> @@ -27,10 +29,13 @@ CFLAGS_init.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_quarantine.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report_generic.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_report_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_shadow.o := $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_hw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_sw_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
>  
>  obj-$(CONFIG_KASAN) := common.o report.o
>  obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o report_generic.o shadow.o quarantine.o
> +obj-$(CONFIG_KASAN_HW_TAGS) += hw_tags.o report_hw_tags.o
>  obj-$(CONFIG_KASAN_SW_TAGS) += init.o report_sw_tags.o shadow.o sw_tags.o
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d0b3ff410b0c..2bb0ef6da6bd 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -113,7 +113,7 @@ void kasan_free_pages(struct page *page, unsigned int order)
>   */
>  static inline unsigned int optimal_redzone(unsigned int object_size)
>  {
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +	if (!IS_ENABLED(CONFIG_KASAN_GENERIC))
>  		return 0;
>  
>  	return
> @@ -178,14 +178,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
>  struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
>  					const void *object)
>  {
> -	return (void *)object + cache->kasan_info.alloc_meta_offset;
> +	return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
>  }
>  
>  struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>  				      const void *object)
>  {
>  	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
> -	return (void *)object + cache->kasan_info.free_meta_offset;
> +	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>  
>  void kasan_poison_slab(struct page *page)
> @@ -267,9 +267,8 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>  	alloc_info = get_alloc_info(cache, object);
>  	__memset(alloc_info, 0, sizeof(*alloc_info));
>  
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> -		object = set_tag(object,
> -				assign_tag(cache, object, true, false));
> +	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> +		object = set_tag(object, assign_tag(cache, object, true, false));
>  
>  	return (void *)object;
>  }
> @@ -337,10 +336,10 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  	redzone_end = round_up((unsigned long)object + cache->object_size,
>  				KASAN_GRANULE_SIZE);
>  
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>  		tag = assign_tag(cache, object, false, keep_tag);
>  
> -	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
> +	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
>  	kasan_unpoison_memory(set_tag(object, tag), size);
>  	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>  		KASAN_KMALLOC_REDZONE);
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> new file mode 100644
> index 000000000000..7f0568df2a93
> --- /dev/null
> +++ b/mm/kasan/hw_tags.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains core hardware tag-based KASAN code.
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
> +void kasan_init_tags(void)
> +{
> +	init_tags(KASAN_TAG_MAX);
> +}
> +
> +void *kasan_reset_tag(const void *addr)
> +{
> +	return reset_tag(addr);
> +}
> +
> +void kasan_poison_memory(const void *address, size_t size, u8 value)
> +{
> +	set_mem_tag_range(reset_tag(address),
> +			  round_up(size, KASAN_GRANULE_SIZE), value);
> +}
> +
> +void kasan_unpoison_memory(const void *address, size_t size)
> +{
> +	set_mem_tag_range(reset_tag(address),
> +			  round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> +}
> +
> +u8 random_tag(void)
> +{
> +	return get_random_tag();
> +}
> +
> +bool check_invalid_free(void *addr)
> +{
> +	u8 ptr_tag = get_tag(addr);
> +	u8 mem_tag = get_mem_tag(addr);
> +
> +	return (mem_tag == KASAN_TAG_INVALID) ||
> +		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
> +}
> +
> +void kasan_set_free_info(struct kmem_cache *cache,
> +				void *object, u8 tag)
> +{
> +	struct kasan_alloc_meta *alloc_meta;
> +
> +	alloc_meta = get_alloc_info(cache, object);
> +	kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
> +}
> +
> +struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
> +				void *object, u8 tag)
> +{
> +	struct kasan_alloc_meta *alloc_meta;
> +
> +	alloc_meta = get_alloc_info(cache, object);
> +	return &alloc_meta->free_track[0];
> +}
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index bd51ab72c002..6661ab4dbe3c 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -153,6 +153,10 @@ struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
>  struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>  					const void *object);
>  
> +void kasan_poison_memory(const void *address, size_t size, u8 value);
> +
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  {
>  	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
> @@ -164,8 +168,6 @@ static inline bool addr_has_metadata(const void *addr)
>  	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
>  }
>  
> -void kasan_poison_memory(const void *address, size_t size, u8 value);
> -
>  /**
>   * check_memory_region - Check memory region, and report if invalid access.
>   * @addr: the accessed address
> @@ -177,6 +179,15 @@ void kasan_poison_memory(const void *address, size_t size, u8 value);
>  bool check_memory_region(unsigned long addr, size_t size, bool write,
>  				unsigned long ret_ip);
>  
> +#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +static inline bool addr_has_metadata(const void *addr)
> +{
> +	return true;
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
> index 000000000000..d8423d1e3b6b
> --- /dev/null
> +++ b/mm/kasan/report_hw_tags.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains hardware tag-based KASAN specific error reporting code.
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
> +	return "invalid-access";
> +}
> +
> +void *find_first_bad_addr(void *addr, size_t size)
> +{
> +	return reset_tag(addr);
> +}
> +
> +void metadata_fetch_row(char *buffer, void *row)
> +{
> +	int i;
> +
> +	for (i = 0; i < META_BYTES_PER_ROW; i++)
> +		buffer[i] = mte_get_mem_tag(row + i * KASAN_GRANULE_SIZE);
> +}
> +
> +void print_tags(u8 addr_tag, const void *addr)
> +{
> +	u8 memory_tag = mte_get_mem_tag((void *)addr);
> +
> +	pr_err("Pointer tag: [%02x], memory tag: [%02x]\n",
> +		addr_tag, memory_tag);
> +}
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index add2dfe6169c..aebc44a29e83 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file contains tag-based KASAN specific error reporting code.
> + * This file contains software tag-based KASAN specific error reporting code.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 1fadd4930d54..616ac64c4a21 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -107,7 +107,7 @@ void kasan_unpoison_memory(const void *address, size_t size)
>  
>  		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>  			*shadow = tag;
> -		else
> +		else /* CONFIG_KASAN_GENERIC */
>  			*shadow = size & KASAN_GRANULE_MASK;
>  	}
>  }
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index b2638c2cd58a..ccc35a311179 100644
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
> 2.28.0.681.g6f77f65b4e-goog
> 

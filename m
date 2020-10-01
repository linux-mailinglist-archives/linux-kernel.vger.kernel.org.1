Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC828052F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbgJAR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:29:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A0C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:29:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so6731658wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2OtA/MQIMRXMsCUop5Uag7KhLiK1JLQolrYfEtsL53I=;
        b=J6jJ7KhGrDqqAXtbEuFrNEfA7ireECtl+bLCZcRhxvBYoAqH8L9923oQfRj9U3Qslg
         qbc0O/DalQj3OdrT6UUouCftL71VDaiy2EV5iMGKi2aUG+Sevd5MdyfyayrHJn1O89ge
         UH77QWfQF1NAZT93sn8DI/F75x9dI0g5ZHW6WDroHTR9uyrnZvb1Aww3MG8pXCBVCXWW
         qD2JIKYE8BaUn0SkDhLqPE3Qpe0gIY4NwN+Ts0DZOaAjRmWvq4IJeSRZD9XitkZEko6V
         1tJAsEZIchf+OnaXWe8UsObB6DOEJwXU7PnOEAw36S2R+dThjs7HQPnh7t3Z11uXlHed
         eIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2OtA/MQIMRXMsCUop5Uag7KhLiK1JLQolrYfEtsL53I=;
        b=Jl8VTV0RTxNtApATdTGlUzz4CVlYYRS8ekIwT/SxbsMFJ82aUnTGHZSeI87+iQv29R
         HV0kjYx1PAflWYT3LH0GPX2GiVBSuV2ffqHKO+Lc/oW7j4Fez4ZRckhUQRGgQLr65H9o
         lwL/zYVQgjTpbQUSEAyt9cEdtvbCFAACxiambkJcMJeD4OnBe1rigJnYYtvw2wILsBsL
         qngm1OBd3co2oefHhfgWH8ln6Qb4aemiQ9ZwLMHU8Brb0GGCaWdPbZKu1QvdRiq2MjbD
         PAvPdZsUZhSttkgDDdQfABc3URATYSkxN5kuNIIdQgc5QYWV1b1Ozl6hgDsBxhwNcX71
         2Q7A==
X-Gm-Message-State: AOAM530x7gFOZcDlvJklmura/CCYxN3zV2h5VXjE+wG+sRFDZwnPktCt
        s/LIgPMqQ1Fr+6RSJLZnUz3dtA==
X-Google-Smtp-Source: ABdhPJyqX5c3HrXq3th/mhiLvuclXCVS2NAFigTf7rvoGzIcyQxIQ06T+TAybXHs+AwP6GTvBHU8EA==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr10012247wrm.375.1601573378859;
        Thu, 01 Oct 2020 10:29:38 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id 63sm11662851wrc.63.2020.10.01.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:29:38 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:29:32 +0200
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
Subject: Re: [PATCH v3 05/39] kasan: rename (un)poison_shadow to
 (un)poison_memory
Message-ID: <20201001172932.GC4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <b19896256a15051346c87a25d01cc73a7bd999ad.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19896256a15051346c87a25d01cc73a7bd999ad.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
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

Reviewed-by: Marco Elver <elver@google.com>

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
> index 44a9aae44138..18617d5c4cd7 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -60,7 +60,7 @@ extern void kasan_enable_current(void);
>  /* Disable reporting bugs for current task */
>  extern void kasan_disable_current(void);
>  
> -void kasan_unpoison_shadow(const void *address, size_t size);
> +void kasan_unpoison_memory(const void *address, size_t size);
>  
>  void kasan_unpoison_task_stack(struct task_struct *task);
>  
> @@ -97,7 +97,7 @@ struct kasan_cache {
>  size_t __ksize(const void *);
>  static inline void kasan_unpoison_slab(const void *ptr)
>  {
> -	kasan_unpoison_shadow(ptr, __ksize(ptr));
> +	kasan_unpoison_memory(ptr, __ksize(ptr));
>  }
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>  
> @@ -106,7 +106,7 @@ void kasan_restore_multi_shot(bool enabled);
>  
>  #else /* CONFIG_KASAN */
>  
> -static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
> +static inline void kasan_unpoison_memory(const void *address, size_t size) {}
>  
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4d32190861bd..b41fecca59d7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -224,8 +224,8 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		if (!s)
>  			continue;
>  
> -		/* Clear the KASAN shadow of the stack. */
> -		kasan_unpoison_shadow(s->addr, THREAD_SIZE);
> +		/* Mark stack accessible for KASAN. */
> +		kasan_unpoison_memory(s->addr, THREAD_SIZE);
>  
>  		/* Clear stale pointers from reused stack. */
>  		memset(s->addr, 0, THREAD_SIZE);
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
>  	void *shadow_start, *shadow_end;
>  
> @@ -125,7 +125,7 @@ void kasan_poison_shadow(const void *address, size_t size, u8 value)
>  	__memset(shadow_start, value, shadow_end - shadow_start);
>  }
>  
> -void kasan_unpoison_shadow(const void *address, size_t size)
> +void kasan_unpoison_memory(const void *address, size_t size)
>  {
>  	u8 tag = get_tag(address);
>  
> @@ -136,7 +136,7 @@ void kasan_unpoison_shadow(const void *address, size_t size)
>  	 */
>  	address = reset_tag(address);
>  
> -	kasan_poison_shadow(address, size, tag);
> +	kasan_poison_memory(address, size, tag);
>  
>  	if (size & KASAN_SHADOW_MASK) {
>  		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
> @@ -153,7 +153,7 @@ static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
>  	void *base = task_stack_page(task);
>  	size_t size = sp - base;
>  
> -	kasan_unpoison_shadow(base, size);
> +	kasan_unpoison_memory(base, size);
>  }
>  
>  /* Unpoison the entire stack for a task. */
> @@ -172,7 +172,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  	 */
>  	void *base = (void *)((unsigned long)watermark & ~(THREAD_SIZE - 1));
>  
> -	kasan_unpoison_shadow(base, watermark - base);
> +	kasan_unpoison_memory(base, watermark - base);
>  }
>  
>  void kasan_alloc_pages(struct page *page, unsigned int order)
> @@ -186,13 +186,13 @@ void kasan_alloc_pages(struct page *page, unsigned int order)
>  	tag = random_tag();
>  	for (i = 0; i < (1 << order); i++)
>  		page_kasan_tag_set(page + i, tag);
> -	kasan_unpoison_shadow(page_address(page), PAGE_SIZE << order);
> +	kasan_unpoison_memory(page_address(page), PAGE_SIZE << order);
>  }
>  
>  void kasan_free_pages(struct page *page, unsigned int order)
>  {
>  	if (likely(!PageHighMem(page)))
> -		kasan_poison_shadow(page_address(page),
> +		kasan_poison_memory(page_address(page),
>  				PAGE_SIZE << order,
>  				KASAN_FREE_PAGE);
>  }
> @@ -284,18 +284,18 @@ void kasan_poison_slab(struct page *page)
>  
>  	for (i = 0; i < compound_nr(page); i++)
>  		page_kasan_tag_reset(page + i);
> -	kasan_poison_shadow(page_address(page), page_size(page),
> +	kasan_poison_memory(page_address(page), page_size(page),
>  			KASAN_KMALLOC_REDZONE);
>  }
>  
>  void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  {
> -	kasan_unpoison_shadow(object, cache->object_size);
> +	kasan_unpoison_memory(object, cache->object_size);
>  }
>  
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
> -	kasan_poison_shadow(object,
> +	kasan_poison_memory(object,
>  			round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE),
>  			KASAN_KMALLOC_REDZONE);
>  }
> @@ -408,7 +408,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  	}
>  
>  	rounded_up_size = round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE);
> -	kasan_poison_shadow(object, rounded_up_size, KASAN_KMALLOC_FREE);
> +	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
>  
>  	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
>  			unlikely(!(cache->flags & SLAB_KASAN)))
> @@ -448,8 +448,8 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  		tag = assign_tag(cache, object, false, keep_tag);
>  
>  	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
> -	kasan_unpoison_shadow(set_tag(object, tag), size);
> -	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
> +	kasan_unpoison_memory(set_tag(object, tag), size);
> +	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>  		KASAN_KMALLOC_REDZONE);
>  
>  	if (cache->flags & SLAB_KASAN)
> @@ -489,8 +489,8 @@ void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
>  				KASAN_SHADOW_SCALE_SIZE);
>  	redzone_end = (unsigned long)ptr + page_size(page);
>  
> -	kasan_unpoison_shadow(ptr, size);
> -	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
> +	kasan_unpoison_memory(ptr, size);
> +	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>  		KASAN_PAGE_REDZONE);
>  
>  	return (void *)ptr;
> @@ -523,7 +523,7 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>  			kasan_report_invalid_free(ptr, ip);
>  			return;
>  		}
> -		kasan_poison_shadow(ptr, page_size(page), KASAN_FREE_PAGE);
> +		kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE);
>  	} else {
>  		__kasan_slab_free(page->slab_cache, ptr, ip, false);
>  	}
> @@ -709,7 +709,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>  	 * // vmalloc() allocates memory
>  	 * // let a = area->addr
>  	 * // we reach kasan_populate_vmalloc
> -	 * // and call kasan_unpoison_shadow:
> +	 * // and call kasan_unpoison_memory:
>  	 * STORE shadow(a), unpoison_val
>  	 * ...
>  	 * STORE shadow(a+99), unpoison_val	x = LOAD p
> @@ -744,7 +744,7 @@ void kasan_poison_vmalloc(const void *start, unsigned long size)
>  		return;
>  
>  	size = round_up(size, KASAN_SHADOW_SCALE_SIZE);
> -	kasan_poison_shadow(start, size, KASAN_VMALLOC_INVALID);
> +	kasan_poison_memory(start, size, KASAN_VMALLOC_INVALID);
>  }
>  
>  void kasan_unpoison_vmalloc(const void *start, unsigned long size)
> @@ -752,7 +752,7 @@ void kasan_unpoison_vmalloc(const void *start, unsigned long size)
>  	if (!is_vmalloc_or_module_addr(start))
>  		return;
>  
> -	kasan_unpoison_shadow(start, size);
> +	kasan_unpoison_memory(start, size);
>  }
>  
>  static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 37ccfadd3263..7006157c674b 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -202,9 +202,9 @@ static void register_global(struct kasan_global *global)
>  {
>  	size_t aligned_size = round_up(global->size, KASAN_SHADOW_SCALE_SIZE);
>  
> -	kasan_unpoison_shadow(global->beg, global->size);
> +	kasan_unpoison_memory(global->beg, global->size);
>  
> -	kasan_poison_shadow(global->beg + aligned_size,
> +	kasan_poison_memory(global->beg + aligned_size,
>  		global->size_with_redzone - aligned_size,
>  		KASAN_GLOBAL_REDZONE);
>  }
> @@ -285,11 +285,11 @@ void __asan_alloca_poison(unsigned long addr, size_t size)
>  
>  	WARN_ON(!IS_ALIGNED(addr, KASAN_ALLOCA_REDZONE_SIZE));
>  
> -	kasan_unpoison_shadow((const void *)(addr + rounded_down_size),
> +	kasan_unpoison_memory((const void *)(addr + rounded_down_size),
>  			      size - rounded_down_size);
> -	kasan_poison_shadow(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
> +	kasan_poison_memory(left_redzone, KASAN_ALLOCA_REDZONE_SIZE,
>  			KASAN_ALLOCA_LEFT);
> -	kasan_poison_shadow(right_redzone,
> +	kasan_poison_memory(right_redzone,
>  			padding_size + KASAN_ALLOCA_REDZONE_SIZE,
>  			KASAN_ALLOCA_RIGHT);
>  }
> @@ -301,7 +301,7 @@ void __asan_allocas_unpoison(const void *stack_top, const void *stack_bottom)
>  	if (unlikely(!stack_top || stack_top > stack_bottom))
>  		return;
>  
> -	kasan_unpoison_shadow(stack_top, stack_bottom - stack_top);
> +	kasan_unpoison_memory(stack_top, stack_bottom - stack_top);
>  }
>  EXPORT_SYMBOL(__asan_allocas_unpoison);
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ac499456740f..03450d3b31f7 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -150,7 +150,7 @@ static inline bool addr_has_shadow(const void *addr)
>  	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
>  }
>  
> -void kasan_poison_shadow(const void *address, size_t size, u8 value);
> +void kasan_poison_memory(const void *address, size_t size, u8 value);
>  
>  /**
>   * check_memory_region - Check memory region, and report if invalid access.
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index 5c8b08a25715..4bdd7dbd6647 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -153,7 +153,7 @@ EXPORT_SYMBOL(__hwasan_storeN_noabort);
>  
>  void __hwasan_tag_memory(unsigned long addr, u8 tag, unsigned long size)
>  {
> -	kasan_poison_shadow((void *)addr, size, tag);
> +	kasan_poison_memory((void *)addr, size, tag);
>  }
>  EXPORT_SYMBOL(__hwasan_tag_memory);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f9ccd5dc13f3..53d0f8bb57ea 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1176,7 +1176,7 @@ size_t ksize(const void *objp)
>  	 * We assume that ksize callers could use whole allocated area,
>  	 * so we need to unpoison this area.
>  	 */
> -	kasan_unpoison_shadow(objp, size);
> +	kasan_unpoison_memory(objp, size);
>  	return size;
>  }
>  EXPORT_SYMBOL(ksize);
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

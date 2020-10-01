Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04662280537
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgJARak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbgJARak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:30:40 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECC6C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:30:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so250388wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EWktHmi0S1UFc9xy6enxB9/oSV/bmiz83UgiMEly7E=;
        b=NY2eqYRXpeCFQRMg5Ax+umeZoJbGRSj6iTey/DM+IkKpTXEjG7DeCItAe0lf1j+jha
         ofc5GeJzK1A2Oy2WzFpJt2DZnsjqg8799mYP7r6RSGIR7Zn87orWkodJcsJOltCU9Nka
         r6/eKPUxCGKVZ7rK4gRImxB4bclPZWP6kh+bCNW6HoA+9j2/ZhLA4ARt23LFRh0plZeR
         dg4Zfo2BRVmpGmmHt3zr6QXkxbrLr1AbiRsRLMms8Nfi40vLbA1T8SFwl6WbO/Rd9R+s
         v1HYGndDljZCpIo/E89QfKlL7K4sPSzjUhrCeE88tSkWNGA3bEeOx+yewGzwtf+HMwGn
         PO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EWktHmi0S1UFc9xy6enxB9/oSV/bmiz83UgiMEly7E=;
        b=JQfL3KqXqRjSFcoawQdFhbk3JlhX2PjWYXXPuL4hDKNER8p9J2C5NkLREuaCRW8JML
         /wWEZuwBmb3MCKYXMIlg5YXL8z7S1DyQVW3hZpssQ+liAWN5jIMyn790j9el+OX/GO4J
         4mmPlLRRBoaE1F/JVxiUog9bQQK7+/dve/x5fQce9iUNhJ2RmB7p2e3/nJdm2I3C05b0
         vDZZDyeybECtkI0IPulXU0NYG3F3pyx7nCAc0xGn2R9FY4FQq/Y0AoTG2lE+qcWLVmbY
         bhnRX5v3MwerwHPAW3fWkmpaQgtUKuXyutxFX07tw5eSyFvJgZ3AqAo2SVAtzMi58eE4
         7/xA==
X-Gm-Message-State: AOAM533dKqhYB3XCIHL9V6e6SSrnrcRdHAyc7OGMr8G4EauAwPljHMVc
        bn/BO9kA7Hnvviyz3xr9dt+jhA==
X-Google-Smtp-Source: ABdhPJzPfSaEUOQUbBc8fSczIt0QSsS9KxBJ1Nn2Rd7+77+GO8psbKM2OZV2eBzVCotSQCqMlnPT3A==
X-Received: by 2002:a1c:5583:: with SMTP id j125mr1065552wmb.75.1601573438290;
        Thu, 01 Oct 2020 10:30:38 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id p9sm880708wmg.34.2020.10.01.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:30:37 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:30:32 +0200
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
Subject: Re: [PATCH v3 06/39] kasan: rename KASAN_SHADOW_* to KASAN_GRANULE_*
Message-ID: <20201001173032.GD4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <55887ae02bd083138050b1dfc1c599c13da8773d.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55887ae02bd083138050b1dfc1c599c13da8773d.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> The new mode won't be using shadow memory, but will still use the concept
> of memory granules. Each memory granule maps to a single metadata entry:
> 8 bytes per one shadow byte for generic mode, 16 bytes per one shadow byte
> for software tag-based mode, and 16 bytes per one allocation tag for
> hardware tag-based mode.
> 
> Rename KASAN_SHADOW_SCALE_SIZE to KASAN_GRANULE_SIZE, and KASAN_SHADOW_MASK
> to KASAN_GRANULE_MASK.
> 
> Also use MASK when used as a mask, otherwise use SIZE.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: Iac733e2248aa9d29f6fc425d8946ba07cca73ecf
> ---
>  Documentation/dev-tools/kasan.rst |  2 +-
>  lib/test_kasan.c                  |  2 +-
>  mm/kasan/common.c                 | 39 ++++++++++++++++---------------
>  mm/kasan/generic.c                | 14 +++++------
>  mm/kasan/generic_report.c         |  8 +++----
>  mm/kasan/init.c                   |  8 +++----
>  mm/kasan/kasan.h                  |  4 ++--
>  mm/kasan/report.c                 | 10 ++++----
>  mm/kasan/tags_report.c            |  2 +-
>  9 files changed, 45 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 38fd5681fade..a3030fc6afe5 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -264,7 +264,7 @@ Most mappings in vmalloc space are small, requiring less than a full
>  page of shadow space. Allocating a full shadow page per mapping would
>  therefore be wasteful. Furthermore, to ensure that different mappings
>  use different shadow pages, mappings would have to be aligned to
> -``KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE``.
> +``KASAN_GRANULE_SIZE * PAGE_SIZE``.
>  
>  Instead, we share backing space across multiple mappings. We allocate
>  a backing page when a mapping in vmalloc space uses a particular page
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 53e953bb1d1d..ddd0b80f24a1 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -25,7 +25,7 @@
>  
>  #include "../mm/kasan/kasan.h"
>  
> -#define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_SHADOW_SCALE_SIZE)
> +#define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
>  
>  /*
>   * We assign some test results to these globals to make sure the tests
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a4b73fa0dd7e..f65c9f792f8f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -106,7 +106,7 @@ void *memcpy(void *dest, const void *src, size_t len)
>  
>  /*
>   * Poisons the shadow memory for 'size' bytes starting from 'addr'.
> - * Memory addresses should be aligned to KASAN_SHADOW_SCALE_SIZE.
> + * Memory addresses should be aligned to KASAN_GRANULE_SIZE.
>   */
>  void kasan_poison_memory(const void *address, size_t size, u8 value)
>  {
> @@ -138,13 +138,13 @@ void kasan_unpoison_memory(const void *address, size_t size)
>  
>  	kasan_poison_memory(address, size, tag);
>  
> -	if (size & KASAN_SHADOW_MASK) {
> +	if (size & KASAN_GRANULE_MASK) {
>  		u8 *shadow = (u8 *)kasan_mem_to_shadow(address + size);
>  
>  		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>  			*shadow = tag;
>  		else
> -			*shadow = size & KASAN_SHADOW_MASK;
> +			*shadow = size & KASAN_GRANULE_MASK;
>  	}
>  }
>  
> @@ -296,7 +296,7 @@ void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
>  	kasan_poison_memory(object,
> -			round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE),
> +			round_up(cache->object_size, KASAN_GRANULE_SIZE),
>  			KASAN_KMALLOC_REDZONE);
>  }
>  
> @@ -368,7 +368,7 @@ static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
>  {
>  	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
>  		return shadow_byte < 0 ||
> -			shadow_byte >= KASAN_SHADOW_SCALE_SIZE;
> +			shadow_byte >= KASAN_GRANULE_SIZE;
>  
>  	/* else CONFIG_KASAN_SW_TAGS: */
>  	if ((u8)shadow_byte == KASAN_TAG_INVALID)
> @@ -407,7 +407,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  		return true;
>  	}
>  
> -	rounded_up_size = round_up(cache->object_size, KASAN_SHADOW_SCALE_SIZE);
> +	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
>  	kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
>  
>  	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
> @@ -440,9 +440,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  		return NULL;
>  
>  	redzone_start = round_up((unsigned long)(object + size),
> -				KASAN_SHADOW_SCALE_SIZE);
> +				KASAN_GRANULE_SIZE);
>  	redzone_end = round_up((unsigned long)object + cache->object_size,
> -				KASAN_SHADOW_SCALE_SIZE);
> +				KASAN_GRANULE_SIZE);
>  
>  	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>  		tag = assign_tag(cache, object, false, keep_tag);
> @@ -486,7 +486,7 @@ void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
>  
>  	page = virt_to_page(ptr);
>  	redzone_start = round_up((unsigned long)(ptr + size),
> -				KASAN_SHADOW_SCALE_SIZE);
> +				KASAN_GRANULE_SIZE);
>  	redzone_end = (unsigned long)ptr + page_size(page);
>  
>  	kasan_unpoison_memory(ptr, size);
> @@ -584,8 +584,8 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
>  	shadow_size = nr_shadow_pages << PAGE_SHIFT;
>  	shadow_end = shadow_start + shadow_size;
>  
> -	if (WARN_ON(mem_data->nr_pages % KASAN_SHADOW_SCALE_SIZE) ||
> -		WARN_ON(start_kaddr % (KASAN_SHADOW_SCALE_SIZE << PAGE_SHIFT)))
> +	if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
> +		WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT)))
>  		return NOTIFY_BAD;
>  
>  	switch (action) {
> @@ -743,7 +743,7 @@ void kasan_poison_vmalloc(const void *start, unsigned long size)
>  	if (!is_vmalloc_or_module_addr(start))
>  		return;
>  
> -	size = round_up(size, KASAN_SHADOW_SCALE_SIZE);
> +	size = round_up(size, KASAN_GRANULE_SIZE);
>  	kasan_poison_memory(start, size, KASAN_VMALLOC_INVALID);
>  }
>  
> @@ -856,22 +856,22 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  	unsigned long region_start, region_end;
>  	unsigned long size;
>  
> -	region_start = ALIGN(start, PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> -	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> +	region_start = ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
> +	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
>  
>  	free_region_start = ALIGN(free_region_start,
> -				  PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> +				  PAGE_SIZE * KASAN_GRANULE_SIZE);
>  
>  	if (start != region_start &&
>  	    free_region_start < region_start)
> -		region_start -= PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE;
> +		region_start -= PAGE_SIZE * KASAN_GRANULE_SIZE;
>  
>  	free_region_end = ALIGN_DOWN(free_region_end,
> -				     PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
> +				     PAGE_SIZE * KASAN_GRANULE_SIZE);
>  
>  	if (end != region_end &&
>  	    free_region_end > region_end)
> -		region_end += PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE;
> +		region_end += PAGE_SIZE * KASAN_GRANULE_SIZE;
>  
>  	shadow_start = kasan_mem_to_shadow((void *)region_start);
>  	shadow_end = kasan_mem_to_shadow((void *)region_end);
> @@ -897,7 +897,8 @@ int kasan_module_alloc(void *addr, size_t size)
>  	unsigned long shadow_start;
>  
>  	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
> -	scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
> +	scaled_size = (size + KASAN_GRANULE_SIZE - 1) >>
> +				KASAN_SHADOW_SCALE_SHIFT;
>  	shadow_size = round_up(scaled_size, PAGE_SIZE);
>  
>  	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 7006157c674b..ec4417156943 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -46,7 +46,7 @@ static __always_inline bool memory_is_poisoned_1(unsigned long addr)
>  	s8 shadow_value = *(s8 *)kasan_mem_to_shadow((void *)addr);
>  
>  	if (unlikely(shadow_value)) {
> -		s8 last_accessible_byte = addr & KASAN_SHADOW_MASK;
> +		s8 last_accessible_byte = addr & KASAN_GRANULE_MASK;
>  		return unlikely(last_accessible_byte >= shadow_value);
>  	}
>  
> @@ -62,7 +62,7 @@ static __always_inline bool memory_is_poisoned_2_4_8(unsigned long addr,
>  	 * Access crosses 8(shadow size)-byte boundary. Such access maps
>  	 * into 2 shadow bytes, so we need to check them both.
>  	 */
> -	if (unlikely(((addr + size - 1) & KASAN_SHADOW_MASK) < size - 1))
> +	if (unlikely(((addr + size - 1) & KASAN_GRANULE_MASK) < size - 1))
>  		return *shadow_addr || memory_is_poisoned_1(addr + size - 1);
>  
>  	return memory_is_poisoned_1(addr + size - 1);
> @@ -73,7 +73,7 @@ static __always_inline bool memory_is_poisoned_16(unsigned long addr)
>  	u16 *shadow_addr = (u16 *)kasan_mem_to_shadow((void *)addr);
>  
>  	/* Unaligned 16-bytes access maps into 3 shadow bytes. */
> -	if (unlikely(!IS_ALIGNED(addr, KASAN_SHADOW_SCALE_SIZE)))
> +	if (unlikely(!IS_ALIGNED(addr, KASAN_GRANULE_SIZE)))
>  		return *shadow_addr || memory_is_poisoned_1(addr + 15);
>  
>  	return *shadow_addr;
> @@ -134,7 +134,7 @@ static __always_inline bool memory_is_poisoned_n(unsigned long addr,
>  		s8 *last_shadow = (s8 *)kasan_mem_to_shadow((void *)last_byte);
>  
>  		if (unlikely(ret != (unsigned long)last_shadow ||
> -			((long)(last_byte & KASAN_SHADOW_MASK) >= *last_shadow)))
> +			((long)(last_byte & KASAN_GRANULE_MASK) >= *last_shadow)))
>  			return true;
>  	}
>  	return false;
> @@ -200,7 +200,7 @@ void kasan_cache_shutdown(struct kmem_cache *cache)
>  
>  static void register_global(struct kasan_global *global)
>  {
> -	size_t aligned_size = round_up(global->size, KASAN_SHADOW_SCALE_SIZE);
> +	size_t aligned_size = round_up(global->size, KASAN_GRANULE_SIZE);
>  
>  	kasan_unpoison_memory(global->beg, global->size);
>  
> @@ -274,10 +274,10 @@ EXPORT_SYMBOL(__asan_handle_no_return);
>  /* Emitted by compiler to poison alloca()ed objects. */
>  void __asan_alloca_poison(unsigned long addr, size_t size)
>  {
> -	size_t rounded_up_size = round_up(size, KASAN_SHADOW_SCALE_SIZE);
> +	size_t rounded_up_size = round_up(size, KASAN_GRANULE_SIZE);
>  	size_t padding_size = round_up(size, KASAN_ALLOCA_REDZONE_SIZE) -
>  			rounded_up_size;
> -	size_t rounded_down_size = round_down(size, KASAN_SHADOW_SCALE_SIZE);
> +	size_t rounded_down_size = round_down(size, KASAN_GRANULE_SIZE);
>  
>  	const void *left_redzone = (const void *)(addr -
>  			KASAN_ALLOCA_REDZONE_SIZE);
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index 6bb3f66992df..7d5b9e5c7cfe 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -34,7 +34,7 @@ void *find_first_bad_addr(void *addr, size_t size)
>  	void *p = addr;
>  
>  	while (p < addr + size && !(*(u8 *)kasan_mem_to_shadow(p)))
> -		p += KASAN_SHADOW_SCALE_SIZE;
> +		p += KASAN_GRANULE_SIZE;
>  	return p;
>  }
>  
> @@ -46,14 +46,14 @@ static const char *get_shadow_bug_type(struct kasan_access_info *info)
>  	shadow_addr = (u8 *)kasan_mem_to_shadow(info->first_bad_addr);
>  
>  	/*
> -	 * If shadow byte value is in [0, KASAN_SHADOW_SCALE_SIZE) we can look
> +	 * If shadow byte value is in [0, KASAN_GRANULE_SIZE) we can look
>  	 * at the next shadow byte to determine the type of the bad access.
>  	 */
> -	if (*shadow_addr > 0 && *shadow_addr <= KASAN_SHADOW_SCALE_SIZE - 1)
> +	if (*shadow_addr > 0 && *shadow_addr <= KASAN_GRANULE_SIZE - 1)
>  		shadow_addr++;
>  
>  	switch (*shadow_addr) {
> -	case 0 ... KASAN_SHADOW_SCALE_SIZE - 1:
> +	case 0 ... KASAN_GRANULE_SIZE - 1:
>  		/*
>  		 * In theory it's still possible to see these shadow values
>  		 * due to a data race in the kernel code.
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 9ce8cc5b8621..dfddd6c39fe6 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -442,8 +442,8 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
>  	end = addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
>  
>  	if (WARN_ON((unsigned long)start %
> -			(KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)) ||
> -	    WARN_ON(size % (KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)))
> +			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
> +	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
>  		return;
>  
>  	for (; addr < end; addr = next) {
> @@ -477,8 +477,8 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
>  	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
>  
>  	if (WARN_ON((unsigned long)start %
> -			(KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)) ||
> -	    WARN_ON(size % (KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE)))
> +			(KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
> +	    WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
>  		return -EINVAL;
>  
>  	ret = kasan_populate_early_shadow(shadow_start, shadow_end);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 03450d3b31f7..c31e2c739301 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -5,8 +5,8 @@
>  #include <linux/kasan.h>
>  #include <linux/stackdepot.h>
>  
> -#define KASAN_SHADOW_SCALE_SIZE (1UL << KASAN_SHADOW_SCALE_SHIFT)
> -#define KASAN_SHADOW_MASK       (KASAN_SHADOW_SCALE_SIZE - 1)
> +#define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
> +#define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
>  
>  #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
>  #define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index c3031b4b4591..fc487ba83931 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -312,24 +312,24 @@ static bool __must_check get_address_stack_frame_info(const void *addr,
>  		return false;
>  
>  	aligned_addr = round_down((unsigned long)addr, sizeof(long));
> -	mem_ptr = round_down(aligned_addr, KASAN_SHADOW_SCALE_SIZE);
> +	mem_ptr = round_down(aligned_addr, KASAN_GRANULE_SIZE);
>  	shadow_ptr = kasan_mem_to_shadow((void *)aligned_addr);
>  	shadow_bottom = kasan_mem_to_shadow(end_of_stack(current));
>  
>  	while (shadow_ptr >= shadow_bottom && *shadow_ptr != KASAN_STACK_LEFT) {
>  		shadow_ptr--;
> -		mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
> +		mem_ptr -= KASAN_GRANULE_SIZE;
>  	}
>  
>  	while (shadow_ptr >= shadow_bottom && *shadow_ptr == KASAN_STACK_LEFT) {
>  		shadow_ptr--;
> -		mem_ptr -= KASAN_SHADOW_SCALE_SIZE;
> +		mem_ptr -= KASAN_GRANULE_SIZE;
>  	}
>  
>  	if (shadow_ptr < shadow_bottom)
>  		return false;
>  
> -	frame = (const unsigned long *)(mem_ptr + KASAN_SHADOW_SCALE_SIZE);
> +	frame = (const unsigned long *)(mem_ptr + KASAN_GRANULE_SIZE);
>  	if (frame[0] != KASAN_CURRENT_STACK_FRAME_MAGIC) {
>  		pr_err("KASAN internal error: frame info validation failed; invalid marker: %lu\n",
>  		       frame[0]);
> @@ -567,6 +567,6 @@ void kasan_non_canonical_hook(unsigned long addr)
>  	else
>  		bug_type = "maybe wild-memory-access";
>  	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
> -		 orig_addr, orig_addr + KASAN_SHADOW_MASK);
> +		 orig_addr, orig_addr + KASAN_GRANULE_SIZE - 1);
>  }
>  #endif
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> index 5f183501b871..c87d5a343b4e 100644
> --- a/mm/kasan/tags_report.c
> +++ b/mm/kasan/tags_report.c
> @@ -76,7 +76,7 @@ void *find_first_bad_addr(void *addr, size_t size)
>  	void *end = p + size;
>  
>  	while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
> -		p += KASAN_SHADOW_SCALE_SIZE;
> +		p += KASAN_GRANULE_SIZE;
>  	return p;
>  }
>  
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9702B4933
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgKPP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbgKPP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:26:33 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:26:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id m125so12708162wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZbrFpkH90bU7I24oViMYOdMB5nKgrMQIS+EJzssnXI=;
        b=nh04mlG0E5vLKcpeyWrW9PbAKJ9nDdr3kwnjZT+ZRO8jk2pTBkQp+IjApJ9Xe06wFC
         I3k3aS3MNv+S4pLJol5hufh79KbkM9fYER6TuQdWmnawVGQqykfinFTcZgDY5LeYJuxm
         feulJ+vt4BU5+k9O/4bBaStB9F1/+hcy7MwuPoSQrIoUzdXOCBHnk/TCVt82lGIsYUV8
         aSOO9WbEn6muD5iAld6AoX5XrlkwFQqDvWSqirMXiflNcDYg7prUt6ZX4BZgbbqL2onC
         SlE3zTpkr1hAvxojKxo0A+bIIUbIT38zqFi/zN5acFyPH/vwXLVxCikCMK5Yrq7JyLbM
         1n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZbrFpkH90bU7I24oViMYOdMB5nKgrMQIS+EJzssnXI=;
        b=Rb6h2IJD8vfYZLTWRiDAgrEyzFltSRpT+rv9mBZ7tglshAyMhySGk2wx26yKWBe9mO
         nqeoIEh3jHFw2UH9dxlf/RGOm+iHKAABEVjanbguS5zDEs36dagRs113GHc6rPYntJek
         JaQc7pUGhgNhzHk97i0k2hWwoC2Kq8wMiPrCb76NnA8X0qjUg+cPNssjXqWSIuPr2DUr
         9jMWJSFw8Q4m5d7O10lQyR3UbkN1yr+zcgXjA+X9DVr04Ib3tgSU+wMQOLp/+tlNZFID
         LMXlBPTWTMoPTPsDy87Siz0P+YdXys0zsj2UEdv9APk/5Uht2jqJnZKizC7un2cJYLfk
         kPcg==
X-Gm-Message-State: AOAM532jMxWSnWni2I5MQRPpHbBGT5Bf2i4DUQgPP0L6UYfnd5HY+UnO
        jB8A2hKNy9z2FyfTFUFvtFoYjg==
X-Google-Smtp-Source: ABdhPJwC12q7OfcMT+OExg0FXg++Kw4ARS2hIr4Xou2KxA+PtTqEIwPpVVuidZMTPlwi0AmS708bHg==
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr2329451wmb.87.1605540391147;
        Mon, 16 Nov 2020 07:26:31 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id f20sm19243120wmc.26.2020.11.16.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:26:30 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:26:24 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm v3 12/19] kasan, mm: check kasan_enabled in annotations
Message-ID: <20201116152624.GD1357314@elver.google.com>
References: <cover.1605305978.git.andreyknvl@google.com>
 <68b9e818c971a28c4b8082d6dbac52967553bd73.1605305978.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b9e818c971a28c4b8082d6dbac52967553bd73.1605305978.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Declare the kasan_enabled static key in include/linux/kasan.h and in
> include/linux/mm.h and check it in all kasan annotations. This allows to
> avoid any slowdown caused by function calls when kasan_enabled is
> disabled.
> 
> Co-developed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Signed-off-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I2589451d3c96c97abbcbf714baabe6161c6f153e

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kasan.h | 213 ++++++++++++++++++++++++++++++++----------
>  include/linux/mm.h    |  22 +++--
>  mm/kasan/common.c     |  56 +++++------
>  3 files changed, 210 insertions(+), 81 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 872bf145ddde..6bd95243a583 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_KASAN_H
>  #define _LINUX_KASAN_H
>  
> +#include <linux/static_key.h>
>  #include <linux/types.h>
>  
>  struct kmem_cache;
> @@ -74,54 +75,176 @@ static inline void kasan_disable_current(void) {}
>  
>  #ifdef CONFIG_KASAN
>  
> -void kasan_unpoison_range(const void *address, size_t size);
> +struct kasan_cache {
> +	int alloc_meta_offset;
> +	int free_meta_offset;
> +};
>  
> -void kasan_alloc_pages(struct page *page, unsigned int order);
> -void kasan_free_pages(struct page *page, unsigned int order);
> +#ifdef CONFIG_KASAN_HW_TAGS
> +DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +static __always_inline bool kasan_enabled(void)
> +{
> +	return static_branch_likely(&kasan_flag_enabled);
> +}
> +#else
> +static inline bool kasan_enabled(void)
> +{
> +	return true;
> +}
> +#endif
>  
> -void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> -			slab_flags_t *flags);
> +void __kasan_unpoison_range(const void *addr, size_t size);
> +static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
> +{
> +	if (kasan_enabled())
> +		__kasan_unpoison_range(addr, size);
> +}
>  
> -void kasan_poison_slab(struct page *page);
> -void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
> -void kasan_poison_object_data(struct kmem_cache *cache, void *object);
> -void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> -					const void *object);
> +void __kasan_alloc_pages(struct page *page, unsigned int order);
> +static __always_inline void kasan_alloc_pages(struct page *page,
> +						unsigned int order)
> +{
> +	if (kasan_enabled())
> +		__kasan_alloc_pages(page, order);
> +}
>  
> -void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
> -						gfp_t flags);
> -void kasan_kfree_large(void *ptr, unsigned long ip);
> -void kasan_poison_kfree(void *ptr, unsigned long ip);
> -void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
> -					size_t size, gfp_t flags);
> -void * __must_check kasan_krealloc(const void *object, size_t new_size,
> -					gfp_t flags);
> +void __kasan_free_pages(struct page *page, unsigned int order);
> +static __always_inline void kasan_free_pages(struct page *page,
> +						unsigned int order)
> +{
> +	if (kasan_enabled())
> +		__kasan_free_pages(page, order);
> +}
>  
> -void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
> -					gfp_t flags);
> -bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> +void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> +				slab_flags_t *flags);
> +static __always_inline void kasan_cache_create(struct kmem_cache *cache,
> +				unsigned int *size, slab_flags_t *flags)
> +{
> +	if (kasan_enabled())
> +		__kasan_cache_create(cache, size, flags);
> +}
>  
> -struct kasan_cache {
> -	int alloc_meta_offset;
> -	int free_meta_offset;
> -};
> +size_t __kasan_metadata_size(struct kmem_cache *cache);
> +static __always_inline size_t kasan_metadata_size(struct kmem_cache *cache)
> +{
> +	if (kasan_enabled())
> +		return __kasan_metadata_size(cache);
> +	return 0;
> +}
> +
> +void __kasan_poison_slab(struct page *page);
> +static __always_inline void kasan_poison_slab(struct page *page)
> +{
> +	if (kasan_enabled())
> +		return __kasan_poison_slab(page);
> +}
> +
> +void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
> +static __always_inline void kasan_unpoison_object_data(struct kmem_cache *cache,
> +							void *object)
> +{
> +	if (kasan_enabled())
> +		return __kasan_unpoison_object_data(cache, object);
> +}
> +
> +void __kasan_poison_object_data(struct kmem_cache *cache, void *object);
> +static __always_inline void kasan_poison_object_data(struct kmem_cache *cache,
> +							void *object)
> +{
> +	if (kasan_enabled())
> +		__kasan_poison_object_data(cache, object);
> +}
> +
> +void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
> +					  const void *object);
> +static __always_inline void * __must_check kasan_init_slab_obj(
> +				struct kmem_cache *cache, const void *object)
> +{
> +	if (kasan_enabled())
> +		return __kasan_init_slab_obj(cache, object);
> +	return (void *)object;
> +}
> +
> +bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> +static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> +						unsigned long ip)
> +{
> +	if (kasan_enabled())
> +		return __kasan_slab_free(s, object, ip);
> +	return false;
> +}
> +
> +void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
> +				       void *object, gfp_t flags);
> +static __always_inline void * __must_check kasan_slab_alloc(
> +				struct kmem_cache *s, void *object, gfp_t flags)
> +{
> +	if (kasan_enabled())
> +		return __kasan_slab_alloc(s, object, flags);
> +	return object;
> +}
> +
> +void * __must_check __kasan_kmalloc(struct kmem_cache *s, const void *object,
> +				    size_t size, gfp_t flags);
> +static __always_inline void * __must_check kasan_kmalloc(struct kmem_cache *s,
> +				const void *object, size_t size, gfp_t flags)
> +{
> +	if (kasan_enabled())
> +		return __kasan_kmalloc(s, object, size, flags);
> +	return (void *)object;
> +}
>  
> -size_t kasan_metadata_size(struct kmem_cache *cache);
> +void * __must_check __kasan_kmalloc_large(const void *ptr,
> +					  size_t size, gfp_t flags);
> +static __always_inline void * __must_check kasan_kmalloc_large(const void *ptr,
> +						      size_t size, gfp_t flags)
> +{
> +	if (kasan_enabled())
> +		return __kasan_kmalloc_large(ptr, size, flags);
> +	return (void *)ptr;
> +}
> +
> +void * __must_check __kasan_krealloc(const void *object,
> +				     size_t new_size, gfp_t flags);
> +static __always_inline void * __must_check kasan_krealloc(const void *object,
> +						 size_t new_size, gfp_t flags)
> +{
> +	if (kasan_enabled())
> +		return __kasan_krealloc(object, new_size, flags);
> +	return (void *)object;
> +}
> +
> +void __kasan_poison_kfree(void *ptr, unsigned long ip);
> +static __always_inline void kasan_poison_kfree(void *ptr, unsigned long ip)
> +{
> +	if (kasan_enabled())
> +		__kasan_poison_kfree(ptr, ip);
> +}
> +
> +void __kasan_kfree_large(void *ptr, unsigned long ip);
> +static __always_inline void kasan_kfree_large(void *ptr, unsigned long ip)
> +{
> +	if (kasan_enabled())
> +		__kasan_kfree_large(ptr, ip);
> +}
>  
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
>  
>  #else /* CONFIG_KASAN */
>  
> +static inline bool kasan_enabled(void)
> +{
> +	return false;
> +}
>  static inline void kasan_unpoison_range(const void *address, size_t size) {}
> -
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> -
>  static inline void kasan_cache_create(struct kmem_cache *cache,
>  				      unsigned int *size,
>  				      slab_flags_t *flags) {}
> -
> +static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  static inline void kasan_poison_slab(struct page *page) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>  					void *object) {}
> @@ -132,36 +255,32 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
>  {
>  	return (void *)object;
>  }
> -
> -static inline void *kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags)
> +static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> +				   unsigned long ip)
>  {
> -	return ptr;
> +	return false;
> +}
> +static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> +				   gfp_t flags)
> +{
> +	return object;
>  }
> -static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
>  static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
>  				size_t size, gfp_t flags)
>  {
>  	return (void *)object;
>  }
> +static inline void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
> +{
> +	return (void *)ptr;
> +}
>  static inline void *kasan_krealloc(const void *object, size_t new_size,
>  				 gfp_t flags)
>  {
>  	return (void *)object;
>  }
> -
> -static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> -				   gfp_t flags)
> -{
> -	return object;
> -}
> -static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> -				   unsigned long ip)
> -{
> -	return false;
> -}
> -
> -static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> +static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
> +static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
>  
>  #endif /* CONFIG_KASAN */
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 947f4f1a6536..24f47e140a4c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -31,6 +31,7 @@
>  #include <linux/sizes.h>
>  #include <linux/sched.h>
>  #include <linux/pgtable.h>
> +#include <linux/kasan.h>
>  
>  struct mempolicy;
>  struct anon_vma;
> @@ -1415,22 +1416,30 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
>  #endif /* CONFIG_NUMA_BALANCING */
>  
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
> -	return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> +	if (kasan_enabled())
> +		return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> +	return 0xff;
>  }
>  
>  static inline void page_kasan_tag_set(struct page *page, u8 tag)
>  {
> -	page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
> -	page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> +	if (kasan_enabled()) {
> +		page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
> +		page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> +	}
>  }
>  
>  static inline void page_kasan_tag_reset(struct page *page)
>  {
> -	page_kasan_tag_set(page, 0xff);
> +	if (kasan_enabled())
> +		page_kasan_tag_set(page, 0xff);
>  }
> -#else
> +
> +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> +
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
>  	return 0xff;
> @@ -1438,7 +1447,8 @@ static inline u8 page_kasan_tag(const struct page *page)
>  
>  static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
>  static inline void page_kasan_tag_reset(struct page *page) { }
> -#endif
> +
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>  
>  static inline struct zone *page_zone(const struct page *page)
>  {
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a11e3e75eb08..17918bd20ed9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -59,7 +59,7 @@ void kasan_disable_current(void)
>  }
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> -void kasan_unpoison_range(const void *address, size_t size)
> +void __kasan_unpoison_range(const void *address, size_t size)
>  {
>  	unpoison_range(address, size);
>  }
> @@ -87,7 +87,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  }
>  #endif /* CONFIG_KASAN_STACK */
>  
> -void kasan_alloc_pages(struct page *page, unsigned int order)
> +void __kasan_alloc_pages(struct page *page, unsigned int order)
>  {
>  	u8 tag;
>  	unsigned long i;
> @@ -101,7 +101,7 @@ void kasan_alloc_pages(struct page *page, unsigned int order)
>  	unpoison_range(page_address(page), PAGE_SIZE << order);
>  }
>  
> -void kasan_free_pages(struct page *page, unsigned int order)
> +void __kasan_free_pages(struct page *page, unsigned int order)
>  {
>  	if (likely(!PageHighMem(page)))
>  		poison_range(page_address(page),
> @@ -128,8 +128,8 @@ static inline unsigned int optimal_redzone(unsigned int object_size)
>  		object_size <= (1 << 16) - 1024 ? 1024 : 2048;
>  }
>  
> -void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> -			slab_flags_t *flags)
> +void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> +			  slab_flags_t *flags)
>  {
>  	unsigned int orig_size = *size;
>  	unsigned int redzone_size;
> @@ -174,7 +174,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  	*flags |= SLAB_KASAN;
>  }
>  
> -size_t kasan_metadata_size(struct kmem_cache *cache)
> +size_t __kasan_metadata_size(struct kmem_cache *cache)
>  {
>  	if (!kasan_stack_collection_enabled())
>  		return 0;
> @@ -197,7 +197,7 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>  	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>  
> -void kasan_poison_slab(struct page *page)
> +void __kasan_poison_slab(struct page *page)
>  {
>  	unsigned long i;
>  
> @@ -207,12 +207,12 @@ void kasan_poison_slab(struct page *page)
>  		     KASAN_KMALLOC_REDZONE);
>  }
>  
> -void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
> +void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  {
>  	unpoison_range(object, cache->object_size);
>  }
>  
> -void kasan_poison_object_data(struct kmem_cache *cache, void *object)
> +void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
>  	poison_range(object,
>  			round_up(cache->object_size, KASAN_GRANULE_SIZE),
> @@ -265,7 +265,7 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object,
>  #endif
>  }
>  
> -void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> +void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>  						const void *object)
>  {
>  	struct kasan_alloc_meta *alloc_meta;
> @@ -284,7 +284,7 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>  	return (void *)object;
>  }
>  
> -static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> +static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  			      unsigned long ip, bool quarantine)
>  {
>  	u8 tag;
> @@ -330,9 +330,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  	return IS_ENABLED(CONFIG_KASAN_GENERIC);
>  }
>  
> -bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
> +bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  {
> -	return __kasan_slab_free(cache, object, ip, true);
> +	return ____kasan_slab_free(cache, object, ip, true);
>  }
>  
>  static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> @@ -340,7 +340,7 @@ static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
>  }
>  
> -static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
> +static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  				size_t size, gfp_t flags, bool keep_tag)
>  {
>  	unsigned long redzone_start;
> @@ -375,20 +375,20 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  	return set_tag(object, tag);
>  }
>  
> -void * __must_check kasan_slab_alloc(struct kmem_cache *cache, void *object,
> -					gfp_t flags)
> +void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
> +					void *object, gfp_t flags)
>  {
> -	return __kasan_kmalloc(cache, object, cache->object_size, flags, false);
> +	return ____kasan_kmalloc(cache, object, cache->object_size, flags, false);
>  }
>  
> -void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
> -				size_t size, gfp_t flags)
> +void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object,
> +					size_t size, gfp_t flags)
>  {
> -	return __kasan_kmalloc(cache, object, size, flags, true);
> +	return ____kasan_kmalloc(cache, object, size, flags, true);
>  }
> -EXPORT_SYMBOL(kasan_kmalloc);
> +EXPORT_SYMBOL(__kasan_kmalloc);
>  
> -void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
> +void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
>  						gfp_t flags)
>  {
>  	struct page *page;
> @@ -413,7 +413,7 @@ void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
>  	return (void *)ptr;
>  }
>  
> -void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
> +void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flags)
>  {
>  	struct page *page;
>  
> @@ -423,13 +423,13 @@ void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
>  	page = virt_to_head_page(object);
>  
>  	if (unlikely(!PageSlab(page)))
> -		return kasan_kmalloc_large(object, size, flags);
> +		return __kasan_kmalloc_large(object, size, flags);
>  	else
> -		return __kasan_kmalloc(page->slab_cache, object, size,
> +		return ____kasan_kmalloc(page->slab_cache, object, size,
>  						flags, true);
>  }
>  
> -void kasan_poison_kfree(void *ptr, unsigned long ip)
> +void __kasan_poison_kfree(void *ptr, unsigned long ip)
>  {
>  	struct page *page;
>  
> @@ -442,11 +442,11 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>  		}
>  		poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
>  	} else {
> -		__kasan_slab_free(page->slab_cache, ptr, ip, false);
> +		____kasan_slab_free(page->slab_cache, ptr, ip, false);
>  	}
>  }
>  
> -void kasan_kfree_large(void *ptr, unsigned long ip)
> +void __kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>  	if (ptr != page_address(virt_to_head_page(ptr)))
>  		kasan_report_invalid_free(ptr, ip);
> -- 
> 2.29.2.299.gdc1121823c-goog
> 

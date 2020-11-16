Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE92B49AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgKPPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgKPPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:43:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56690C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:43:16 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so19158732wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j36fSUfGBLe2zZxhs7gruCyn6/GmW8bJyNFpN4VZcls=;
        b=jdRX0SraAuuchYRHcK2krZ6WKlv5g1jLwyjILv09rhqdEds/9wm7+FMEQOfMX2JyIU
         evQ1TegY/Lh8//aFZvy/vfTj3LCzQaekFlUTy4D4WjkBD8CYkt4umn88mWiioBENrQ17
         AtTm7fZgVTwV/wwgCGe2gB4drdeqK9zvskovHse73mPfhk/nYSRHVP5BBwy4KyT5EPe7
         +7PODsopbFef/HCYsV9th/6onWZ+aFu4oAhbwRSq34szHIFq4GlzZ4Y0Av8jpHMScMHl
         0jG4Y4eCPEwfDFIL94sISiBaIayslUlG/rb0k5htMGl9THadP0hAkB1d8McDktR59USs
         0f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j36fSUfGBLe2zZxhs7gruCyn6/GmW8bJyNFpN4VZcls=;
        b=DpaL+0HdStxqas5IT2IhZ+83qE7HmWWeviH7graIUpOKMDCnBBOgKjXAe1nDmhO5+E
         7GTcPn4V3OcBO6pBkz18jeVKGP5dtprVHi26giTTOp2IcB5RMUIoxR+DFoK1Xx7TukNc
         111Q4DPvvRCwVQl7aw2qy2+Gco08c7+4JyYhDq6faRkzK2npxaHd3I0bpNsCgmVAOnw8
         Qn+unYf5SR8VdUgj5JRD8wMDdbEH/8RuW9e8wMKbcDjI224tBxYStg+M0haTRj1LpraF
         7mYWEs4oxcXrbSyAiUe+zSsmKOSDGhJMcQyB/+rQf/YkzSZp1MCDOfQWlMIxAzbIAps/
         YuoQ==
X-Gm-Message-State: AOAM531/8EgdkqlgvIgo1ywnzW0GdqETbin8iOzSddJiEsDFz1AxOuob
        Jl2ZNL285BqoWAC2ogwgW+5qGA==
X-Google-Smtp-Source: ABdhPJwUeDk82+5BVUMGjd1cE4QcJRFIgxY4G4gSGMabIPPqKKNMU/FLBZkspt9oy5HuK8ZpdhGLeg==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr20283827wrs.106.1605541394849;
        Mon, 16 Nov 2020 07:43:14 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id a9sm22684197wrp.21.2020.11.16.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:43:13 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:43:08 +0100
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
Subject: Re: [PATCH mm v3 13/19] kasan, mm: rename kasan_poison_kfree
Message-ID: <20201116154308.GF1357314@elver.google.com>
References: <cover.1605305978.git.andreyknvl@google.com>
 <798e1753fafb37151213a0ad0b1b2f08f66c3877.1605305978.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798e1753fafb37151213a0ad0b1b2f08f66c3877.1605305978.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Rename kasan_poison_kfree() to kasan_slab_free_mempool() as it better
> reflects what this annotation does. Also add a comment that explains the
> PageSlab() check.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kasan.h | 16 ++++++++--------
>  mm/kasan/common.c     | 40 +++++++++++++++++++++++-----------------
>  mm/mempool.c          |  2 +-
>  3 files changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 6bd95243a583..16cf53eac29b 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -175,6 +175,13 @@ static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  	return false;
>  }
>  
> +void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
> +static __always_inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
> +{
> +	if (kasan_enabled())
> +		__kasan_slab_free_mempool(ptr, ip);
> +}
> +
>  void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
>  				       void *object, gfp_t flags);
>  static __always_inline void * __must_check kasan_slab_alloc(
> @@ -215,13 +222,6 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
>  	return (void *)object;
>  }
>  
> -void __kasan_poison_kfree(void *ptr, unsigned long ip);
> -static __always_inline void kasan_poison_kfree(void *ptr, unsigned long ip)
> -{
> -	if (kasan_enabled())
> -		__kasan_poison_kfree(ptr, ip);
> -}
> -
>  void __kasan_kfree_large(void *ptr, unsigned long ip);
>  static __always_inline void kasan_kfree_large(void *ptr, unsigned long ip)
>  {
> @@ -260,6 +260,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  {
>  	return false;
>  }
> +static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>  				   gfp_t flags)
>  {
> @@ -279,7 +280,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>  {
>  	return (void *)object;
>  }
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
>  static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
>  
>  #endif /* CONFIG_KASAN */
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 17918bd20ed9..1205faac90bd 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -335,6 +335,29 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  	return ____kasan_slab_free(cache, object, ip, true);
>  }
>  
> +void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
> +{
> +	struct page *page;
> +
> +	page = virt_to_head_page(ptr);
> +
> +	/*
> +	 * Even though this function is only called for kmem_cache_alloc and
> +	 * kmalloc backed mempool allocations, those allocations can still be
> +	 * !PageSlab() when the size provided to kmalloc is larger than
> +	 * KMALLOC_MAX_SIZE, and kmalloc falls back onto page_alloc.
> +	 */
> +	if (unlikely(!PageSlab(page))) {
> +		if (ptr != page_address(page)) {
> +			kasan_report_invalid_free(ptr, ip);
> +			return;
> +		}
> +		poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
> +	} else {
> +		____kasan_slab_free(page->slab_cache, ptr, ip, false);
> +	}
> +}
> +
>  static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
>  	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> @@ -429,23 +452,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
>  						flags, true);
>  }
>  
> -void __kasan_poison_kfree(void *ptr, unsigned long ip)
> -{
> -	struct page *page;
> -
> -	page = virt_to_head_page(ptr);
> -
> -	if (unlikely(!PageSlab(page))) {
> -		if (ptr != page_address(page)) {
> -			kasan_report_invalid_free(ptr, ip);
> -			return;
> -		}
> -		poison_range(ptr, page_size(page), KASAN_FREE_PAGE);
> -	} else {
> -		____kasan_slab_free(page->slab_cache, ptr, ip, false);
> -	}
> -}
> -
>  void __kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>  	if (ptr != page_address(virt_to_head_page(ptr)))
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 583a9865b181..624ed51b060f 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -104,7 +104,7 @@ static inline void poison_element(mempool_t *pool, void *element)
>  static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  {
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> -		kasan_poison_kfree(element, _RET_IP_);
> +		kasan_slab_free_mempool(element, _RET_IP_);
>  	else if (pool->alloc == mempool_alloc_pages)
>  		kasan_free_pages(element, (unsigned long)pool->pool_data);
>  }
> -- 
> 2.29.2.299.gdc1121823c-goog
> 

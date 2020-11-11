Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B82AF896
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKKSxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKSxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:53:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B8DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:53:34 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c16so3299440wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BsqGYO3Z3LmOG3+gEI3hEN4Yp+SLkMxnpyJBNBk4sQ4=;
        b=mJji5oqY1OzEJWl5UZxRmQOZNoPQQXzgVLDrguwlN3KVjusaaRWAIW55bqLaOdTrO8
         8kxw3cgrFCfaLLsOFFp/61ToJUxCIhbKTYlAS7SIOQg9jIjMP1YBpno35r/ktCMAe94t
         GCTR14pyKLAIKWyBusMI9wPH2oxilh0yPLT4awiKGTO1Lw2BEyxk/R/rL1VZYTTtHPAU
         phUaRyeSdFCMkFeg1nZ3Rhp6Lzx0bt9MLd7wHCrO13piwCQ3lmW9zsUc48mjZmhUFqsh
         ep+Dh+x97AfCaJTvgHpIpa4PKlmi67Od3AicLntN9/tdxCudDvTK0f6vR981qSQ613s0
         wY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BsqGYO3Z3LmOG3+gEI3hEN4Yp+SLkMxnpyJBNBk4sQ4=;
        b=exi0kykkrMd1ijcSkH6w9OFv0at2hb+MynXF+0n+oS/Hf9kwELs6i7x98VNvXgpZbE
         wM2skRlEJD2WlAYhSj9aVMQ7AIkisG+q4UUyBeE2rmGgkS9Ad+JZYupng9Nc8BgAVSY0
         YhIDtWLzvzK95wdVc0Vo2SfTObMUABqcos6vA0jrGXTeYVh2wytrcYVqjiDl9vTliDA5
         D+KmU+aMX0p+/Emjc7FD+Hl9JbaN9D/k1ZfdnzgmEJUxWHSpTbuv1+hQtyLI7oBkZ7Kp
         4jPq9vZMlIkHNn1eXYmb3lKPzuZy2vLUGpAWcQ7w3v0J5aVc+klXlC1Z2JoOqkVmrJEr
         GXGA==
X-Gm-Message-State: AOAM533MrgiLOlyS6CC4qbYNw0YZVffoHsbXlWOBP51XVotk/ymqtPUT
        KuuaUEFqJo7dc55e9bp+GKp9lg==
X-Google-Smtp-Source: ABdhPJxHLlPHjhrZhLExbqq4w/IszUCQZ0kyVJhn4iwR+4mytZR8qD9mf3bIoOZO54mtGqE6oZNn7Q==
X-Received: by 2002:a1c:66c4:: with SMTP id a187mr5688966wmc.186.1605120812851;
        Wed, 11 Nov 2020 10:53:32 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id c185sm3646674wma.44.2020.11.11.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:53:32 -0800 (PST)
Date:   Wed, 11 Nov 2020 19:53:26 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/20] kasan, mm: rename kasan_poison_kfree
Message-ID: <20201111185326.GP517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <ee33aa1d9c57c3f2b2c700e8f2c6c24db8703612.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee33aa1d9c57c3f2b2c700e8f2c6c24db8703612.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Rename kasan_poison_kfree() to kasan_slab_free_mempool() as it better
> reflects what this annotation does.

This function is again so simple, and now it seems it's mempool
specific, can't we just remove it and open-code it in mempool.c?

> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810
> ---
>  include/linux/kasan.h | 16 ++++++++--------
>  mm/kasan/common.c     | 16 ++++++++--------
>  mm/mempool.c          |  2 +-
>  3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 779f8e703982..534ab3e2935a 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -177,6 +177,13 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned
>  	return false;
>  }
>  
> +void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
> +static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
> +{
> +	if (kasan_enabled())
> +		__kasan_slab_free_mempool(ptr, ip);
> +}
> +
>  void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
>  				       void *object, gfp_t flags);
>  static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
> @@ -217,13 +224,6 @@ static inline void * __must_check kasan_krealloc(const void *object,
>  	return (void *)object;
>  }
>  
> -void __kasan_poison_kfree(void *ptr, unsigned long ip);
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
> -{
> -	if (kasan_enabled())
> -		__kasan_poison_kfree(ptr, ip);
> -}
> -
>  void __kasan_kfree_large(void *ptr, unsigned long ip);
>  static inline void kasan_kfree_large(void *ptr, unsigned long ip)
>  {
> @@ -263,6 +263,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  {
>  	return false;
>  }
> +static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>  				   gfp_t flags)
>  {
> @@ -282,7 +283,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>  {
>  	return (void *)object;
>  }
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
>  static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
>  
>  #endif /* CONFIG_KASAN */
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 819403548f2e..60793f8695a8 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -336,6 +336,14 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  	return ____kasan_slab_free(cache, object, ip, true);
>  }
>  
> +void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
> +{
> +	struct page *page;
> +
> +	page = virt_to_head_page(ptr);
> +	____kasan_slab_free(page->slab_cache, ptr, ip, false);
> +}
> +
>  static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
>  	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> @@ -427,14 +435,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
>  						flags, true);
>  }
>  
> -void __kasan_poison_kfree(void *ptr, unsigned long ip)
> -{
> -	struct page *page;
> -
> -	page = virt_to_head_page(ptr);
> -	____kasan_slab_free(page->slab_cache, ptr, ip, false);
> -}
> -
>  void __kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>  	if (ptr != page_address(virt_to_head_page(ptr)))
> diff --git a/mm/mempool.c b/mm/mempool.c
> index f473cdddaff0..b1f39fa75ade 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -104,7 +104,7 @@ static inline void poison_element(mempool_t *pool, void *element)
>  static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  {
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> -		kasan_poison_kfree(element, _RET_IP_);
> +		kasan_slab_free_mempool(element, _RET_IP_);

This is already a kasan-prefixed function, so if
kasan_slab_free_mempool() is only ever called in this function, we
should just call kasan_slab_free() here directly with the 2 extra args
it requires open-coded.

>  	else if (pool->alloc == mempool_alloc_pages)
>  		kasan_free_pages(element, (unsigned long)pool->pool_data);
>  }

Thanks,
-- Marco

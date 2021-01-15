Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F042F7C61
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbhAONUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhAONUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:20:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDFDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:19:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 190so7341681wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5KScXesbEjxL3jaiuXSfmiGP49GRLi2XSqWfLcjiqag=;
        b=QXqqruHIZL3TiO4DkGU1qdVNUytHa1R/5tOlaed8VpAb4bi/Ynb9GmTxzYA6KTsGfZ
         IdHf7dFVQepg1TgHfUI/F/A8S30avmU6zTQ6T2r/1KiUDyZwbakpfScHIvUDnUpzI8fp
         CtzdM9SBd20/xz9B0ErH31ZG5Br9RFicZt4qKo9ZFXL/Ar2iiGGcAzwPwCzEwBL9xVUK
         yFEPPaQW5V6mGFDEwJfQwL/ajl2UJjpP3oC8Lm3JwuMNqFxe8Z8njqlNWG5NaGVVSp6L
         iUHQjw9q4hC6our/aTZs2FaiMObR3uag7RI+rU4Tknu9YClSpoUtk8+H8Z/Ng/Bu4hXw
         Aw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5KScXesbEjxL3jaiuXSfmiGP49GRLi2XSqWfLcjiqag=;
        b=c7+N+W0URlAMULRyReawsicHyNTjkGp+CQu7pcB6tBPKOMwrKz9zUlxtlc0VET292U
         jCkbbcfvJ8GwjLHlKfrv/TbJHORltWQmNUquT44swlzCGL7ymlEqT9kzFqWPn0uTteZr
         QRr6IVXWF0KxKwng8TLz+Aym/icKSXw03ubE2BHn0eQn3GOKnShrZA9ew9GQTO/EK43Q
         ol2r5cIwk307u1fD5jE73vdsnwWVpwFLMZUb5fy5t4Ip26EZGg4AtqNnbC7FEMGXh/yW
         G0ik8R3ujmFRHjkpH77azoJlkvQlZN2ZmcMcygQ2Y+rXAaMgsyoW+n5h7hwKti4Yqqg/
         hmpg==
X-Gm-Message-State: AOAM533S+Fqs67wVrHICwd0FmKca4Bhi/JZ0XglQxqKHcburOENMtn1p
        yv81/1BoU42RE6qvg+A12EVR4A==
X-Google-Smtp-Source: ABdhPJwjcEj7RsyxDUitn9zYbJIMTLawVNr46NnQ/snkhHnec+aYiSZCT9AQ+s1XfeYsjPqymTeOaQ==
X-Received: by 2002:a1c:4c7:: with SMTP id 190mr8760735wme.32.1610716784979;
        Fri, 15 Jan 2021 05:19:44 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id a8sm12661374wmd.6.2021.01.15.05.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:19:44 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:19:38 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/15] kasan: move _RET_IP_ to inline wrappers
Message-ID: <YAGWavYGrpZXVF4M@elver.google.com>
References: <cover.1610652890.git.andreyknvl@google.com>
 <03fae8b66a7f4b85abadc80a2d216ac4db815444.1610652890.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03fae8b66a7f4b85abadc80a2d216ac4db815444.1610652890.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> Generic mm functions that call KASAN annotations that might report a bug
> pass _RET_IP_ to them as an argument. This allows KASAN to include the
> name of the function that called the mm function in its report's header.
> 
> Now that KASAN has inline wrappers for all of its annotations, move
> _RET_IP_ to those wrappers to simplify annotation call sites.
> 
> Link: https://linux-review.googlesource.com/id/I8fb3c06d49671305ee184175a39591bc26647a67
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Much nicer!

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kasan.h | 20 +++++++++-----------
>  mm/mempool.c          |  2 +-
>  mm/slab.c             |  2 +-
>  mm/slub.c             |  4 ++--
>  4 files changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5e0655fb2a6f..bba1637827c3 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -181,19 +181,18 @@ static __always_inline void * __must_check kasan_init_slab_obj(
>  }
>  
>  bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> -static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> -						unsigned long ip)
> +static __always_inline bool kasan_slab_free(struct kmem_cache *s, void *object)
>  {
>  	if (kasan_enabled())
> -		return __kasan_slab_free(s, object, ip);
> +		return __kasan_slab_free(s, object, _RET_IP_);
>  	return false;
>  }
>  
>  void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
> -static __always_inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
> +static __always_inline void kasan_slab_free_mempool(void *ptr)
>  {
>  	if (kasan_enabled())
> -		__kasan_slab_free_mempool(ptr, ip);
> +		__kasan_slab_free_mempool(ptr, _RET_IP_);
>  }
>  
>  void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
> @@ -237,10 +236,10 @@ static __always_inline void * __must_check kasan_krealloc(const void *object,
>  }
>  
>  void __kasan_kfree_large(void *ptr, unsigned long ip);
> -static __always_inline void kasan_kfree_large(void *ptr, unsigned long ip)
> +static __always_inline void kasan_kfree_large(void *ptr)
>  {
>  	if (kasan_enabled())
> -		__kasan_kfree_large(ptr, ip);
> +		__kasan_kfree_large(ptr, _RET_IP_);
>  }
>  
>  bool kasan_save_enable_multi_shot(void);
> @@ -273,12 +272,11 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
>  {
>  	return (void *)object;
>  }
> -static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> -				   unsigned long ip)
> +static inline bool kasan_slab_free(struct kmem_cache *s, void *object)
>  {
>  	return false;
>  }
> -static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
> +static inline void kasan_slab_free_mempool(void *ptr) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>  				   gfp_t flags)
>  {
> @@ -298,7 +296,7 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>  {
>  	return (void *)object;
>  }
> -static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> +static inline void kasan_kfree_large(void *ptr) {}
>  
>  #endif /* CONFIG_KASAN */
>  
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 624ed51b060f..79959fac27d7 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -104,7 +104,7 @@ static inline void poison_element(mempool_t *pool, void *element)
>  static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  {
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> -		kasan_slab_free_mempool(element, _RET_IP_);
> +		kasan_slab_free_mempool(element);
>  	else if (pool->alloc == mempool_alloc_pages)
>  		kasan_free_pages(element, (unsigned long)pool->pool_data);
>  }
> diff --git a/mm/slab.c b/mm/slab.c
> index d7c8da9319c7..afeb6191fb1e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3421,7 +3421,7 @@ static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
>  		memset(objp, 0, cachep->object_size);
>  
>  	/* Put the object into the quarantine, don't touch it for now. */
> -	if (kasan_slab_free(cachep, objp, _RET_IP_))
> +	if (kasan_slab_free(cachep, objp))
>  		return;
>  
>  	/* Use KCSAN to help debug racy use-after-free. */
> diff --git a/mm/slub.c b/mm/slub.c
> index 75fb097d990d..0afb53488238 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1514,7 +1514,7 @@ static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
>  static __always_inline void kfree_hook(void *x)
>  {
>  	kmemleak_free(x);
> -	kasan_kfree_large(x, _RET_IP_);
> +	kasan_kfree_large(x);
>  }
>  
>  static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
> @@ -1544,7 +1544,7 @@ static __always_inline bool slab_free_hook(struct kmem_cache *s, void *x)
>  				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
>  
>  	/* KASAN might put x into memory quarantine, delaying its reuse */
> -	return kasan_slab_free(s, x, _RET_IP_);
> +	return kasan_slab_free(s, x);
>  }
>  
>  static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

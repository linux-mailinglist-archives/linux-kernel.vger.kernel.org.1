Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A272AF790
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKKRtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:49:10 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D3BC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:49:10 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so4559585wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dxflwy28eDhlYIu6gOleg6G31J7w566728A9aheIIzc=;
        b=OkPFBQNY33GuRT9kJslk4zchdnlSREwN8BMH8NjW94y72hywV1vCptYF2hPefFPqqO
         dNKiLTAAN0rrNEg5YzOKoqh1t/KRzqEcqf8RZRaG0ofbsG/J9bGAeqyGsi54ecV5Xo4e
         /108gm6u4JEQEhw9kIUqusxIeJUWD/VGKzUU9tmfrgj/2usRs6z6VTtMsZsP82vUKN9M
         WrdFd9xIyhPNYSoD0ug+ToNErdNVDZZX9ha+yUwfKDVWUtMPfUVc/v+v/t3Zh+CbERYZ
         x4UPVf5y4FK2S5HgpENxJS8Q1aRBlyPTqbWinkXNCtKBHNOrpVeimdC/r78WKFZgRf+6
         i1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dxflwy28eDhlYIu6gOleg6G31J7w566728A9aheIIzc=;
        b=WsxAEzFOLO5EI9hmsxCEv8SXS/JwMcC3vBWE+aR4O8b76sSyrswCpfNo9Rl0quGtWW
         XI7FPyjHeccZx/f+pMA1exXcV58sTFF7YqxsMSJ82f/Zr+RzEW3io2vnNgbbep0X7fPV
         9OF7ld66rXRVrlU8BRA1sxoxS+MPHgCs3n3+IEg/gaG5EDBPc5I6tLRjveDxX7+tFFtS
         fosg1OzH/yYEzFsSJ48P2I/WgoPZDr/tQqQWtwasOTlEk/mVrIo7d4FaVROjxFIaLG2o
         uJctYdgYjmqg3GaF8z2TOws6mQ0V7k44r577W+Cd2BpGcX3bUNfWYRMuAggD1kofNSXO
         dP6w==
X-Gm-Message-State: AOAM530kOlFJbOvRP8d3lyrUDjRSIFRNlpFKT6LIk+bI7VJQG5VmKeM4
        U5X8RRbjkzDUURHtvwwqqQTcJQ==
X-Google-Smtp-Source: ABdhPJwqQoAPIaDeXqszMd6JSDoa+iBReTA0TuaP7AoeyibVh5E4CU1FeUzT6c39m58y0Gxanoi+rA==
X-Received: by 2002:a05:600c:2119:: with SMTP id u25mr5258800wml.53.1605116948480;
        Wed, 11 Nov 2020 09:49:08 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id v19sm3486601wrf.40.2020.11.11.09.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 09:49:07 -0800 (PST)
Date:   Wed, 11 Nov 2020 18:49:02 +0100
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
Subject: Re: [PATCH v2 10/20] kasan: inline and rename kasan_unpoison_memory
Message-ID: <20201111174902.GK517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <0a9b63bff116734ab63d99ebd09c244332d71958.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9b63bff116734ab63d99ebd09c244332d71958.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Currently kasan_unpoison_memory() is used as both an external annotation
> and as an internal memory poisoning helper. Rename external annotation to
> kasan_unpoison_data() and inline the internal helper for hardware
> tag-based mode to avoid undeeded function calls.

I don't understand why this needs to be renamed again. The users of
kasan_unpoison_memory() outweigh those of kasan_unpoison_slab(), of
which there seems to be only 1!

So can't we just get rid of kasan_unpoison_slab() and just open-code it
in mm/mempool.c:kasan_unpoison_element()? That function is already
kasan-prefixed, so we can even place a small comment there (which would
also be an improvement over current interface, since
kasan_unpoison_slab() is not documented and its existence not quite
justified).

> There's the external annotation kasan_unpoison_slab() that is currently
> defined as static inline and uses kasan_unpoison_memory(). With this
> change it's turned into a function call. Overall, this results in the
> same number of calls for hardware tag-based mode as
> kasan_unpoison_memory() is now inlined.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia7c8b659f79209935cbaab3913bf7f082cc43a0e
> ---
>  include/linux/kasan.h | 16 ++++++----------
>  kernel/fork.c         |  2 +-
>  mm/kasan/common.c     | 10 ++++++++++
>  mm/kasan/hw_tags.c    |  6 ------
>  mm/kasan/kasan.h      |  7 +++++++
>  mm/slab_common.c      |  2 +-
>  6 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 53c8e8b12fbc..f1a5042ae4fc 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -74,14 +74,15 @@ static inline void kasan_disable_current(void) {}
>  
>  #ifdef CONFIG_KASAN
>  
> -void kasan_unpoison_memory(const void *address, size_t size);
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
>  
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  			slab_flags_t *flags);
>  
> +void kasan_unpoison_data(const void *address, size_t size);
> +void kasan_unpoison_slab(const void *ptr);
> +
>  void kasan_poison_slab(struct page *page);
>  void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object);
> @@ -106,11 +107,6 @@ struct kasan_cache {
>  	int free_meta_offset;
>  };
>  
> -size_t __ksize(const void *);
> -static inline void kasan_unpoison_slab(const void *ptr)
> -{
> -	kasan_unpoison_memory(ptr, __ksize(ptr));
> -}
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>  
>  bool kasan_save_enable_multi_shot(void);
> @@ -118,8 +114,6 @@ void kasan_restore_multi_shot(bool enabled);
>  
>  #else /* CONFIG_KASAN */
>  
> -static inline void kasan_unpoison_memory(const void *address, size_t size) {}
> -
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>  
> @@ -127,6 +121,9 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
>  				      unsigned int *size,
>  				      slab_flags_t *flags) {}
>  
> +static inline void kasan_unpoison_data(const void *address, size_t size) { }
> +static inline void kasan_unpoison_slab(const void *ptr) { }
> +
>  static inline void kasan_poison_slab(struct page *page) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>  					void *object) {}
> @@ -166,7 +163,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  	return false;
>  }
>  
> -static inline void kasan_unpoison_slab(const void *ptr) { }
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  
>  #endif /* CONFIG_KASAN */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1c905e4290ab..883898487b3f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -226,7 +226,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  			continue;
>  
>  		/* Mark stack accessible for KASAN. */
> -		kasan_unpoison_memory(s->addr, THREAD_SIZE);
> +		kasan_unpoison_data(s->addr, THREAD_SIZE);

... this change would become unnecessary.

>  		/* Clear stale pointers from reused stack. */
>  		memset(s->addr, 0, THREAD_SIZE);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a266b90636a1..4598c1364f19 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -184,6 +184,16 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>  	return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>  
> +void kasan_unpoison_data(const void *address, size_t size)
> +{
> +	kasan_unpoison_memory(address, size);
> +}
> +
> +void kasan_unpoison_slab(const void *ptr)
> +{
> +	kasan_unpoison_memory(ptr, __ksize(ptr));
> +}
> +

This function is so simple, I think just open-coding 

	kasan_unpoison_memory(ptr, __ksize(ptr))

wherever required is much simpler, also bearing in mind the changes that
are coming to the rest of this series.

>  void kasan_poison_slab(struct page *page)
>  {
>  	unsigned long i;
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 0303e49904b4..838b29e44e32 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -30,12 +30,6 @@ void kasan_init_hw_tags(void)
>  	pr_info("KernelAddressSanitizer initialized\n");
>  }
>  
> -void kasan_unpoison_memory(const void *address, size_t size)
> -{
> -	hw_set_mem_tag_range(kasan_reset_tag(address),
> -			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> -}
> -
>  void kasan_set_free_info(struct kmem_cache *cache,
>  				void *object, u8 tag)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ab7314418604..2d3c99125996 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -283,6 +283,12 @@ static inline void kasan_poison_memory(const void *address, size_t size, u8 valu
>  			round_up(size, KASAN_GRANULE_SIZE), value);
>  }
>  
> +static inline void kasan_unpoison_memory(const void *address, size_t size)
> +{
> +	hw_set_mem_tag_range(kasan_reset_tag(address),
> +			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> +}
> +
>  static inline bool check_invalid_free(void *addr)
>  {
>  	u8 ptr_tag = get_tag(addr);
> @@ -295,6 +301,7 @@ static inline bool check_invalid_free(void *addr)
>  #else /* CONFIG_KASAN_HW_TAGS */
>  
>  void kasan_poison_memory(const void *address, size_t size, u8 value);
> +void kasan_unpoison_memory(const void *address, size_t size);
>  bool check_invalid_free(void *addr);
>  
>  #endif /* CONFIG_KASAN_HW_TAGS */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 53d0f8bb57ea..f1b0c4a22f08 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1176,7 +1176,7 @@ size_t ksize(const void *objp)
>  	 * We assume that ksize callers could use whole allocated area,
>  	 * so we need to unpoison this area.
>  	 */
> -	kasan_unpoison_memory(objp, size);
> +	kasan_unpoison_data(objp, size);

... this change would become unnecessary.

Thanks,
-- Marco

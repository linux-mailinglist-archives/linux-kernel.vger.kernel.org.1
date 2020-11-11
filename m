Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8848F2AF5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKKQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgKKQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:09:45 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05698C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:09:45 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so2843807wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IBs3li60EOi/W5+017BpBFCYAVBpZJoicHAyd9GYBDE=;
        b=KPIoJai4aYa2n4Op9swUVnMetVQ2SwHjyt4TqVyTJ5YlOJmmZZxwrTWvgRJpYqG7dq
         WrMI7wW0Uf39Tgr1f9fX3k9Gw8kN428dElgOKSckBEeumCwJ++Qxm0vGnmOG8G9O7iv6
         8zDrJJHIumjnXjQtqMAmNBhdpzpdRJNlZUFnvNitGCe1nQ6z1k4bFZB3FWAyfOLs44Vx
         YYB7yq3pt7avG31D3xFqMwhSVxYjkrqTTvV385fF1VY9DFinrV9wNojBQPYoLgazOA6C
         z2fErQmfD658yulAQNandxo81iEErekvKlSayQ/bedsy5sJp0+qgTPSQ0qufzdr7AOxA
         2DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IBs3li60EOi/W5+017BpBFCYAVBpZJoicHAyd9GYBDE=;
        b=hQXpTYAN7y3CSXaJ33dUBQRGMje/LdO3kG5Z7NdDo/kNVLTM+c146znsKr4j8OA9j5
         wSJbWRUPhU4iDOfnD3Tj0x4I9ZDacWv2A8oNLo8nKTQ/eqZj+qHDL88gSiXD0MVFpn0v
         2JpMIwXasS0fL1vcouJWzQD/ik6KG7jYi5bmkxf2fXccnlAlSm1tCBHDDXjeVUmQJS+n
         0pPBO8GL5BRY8FeHVYdace0mpl+/ksbaEzTCTdGOyLcdCiBzNOAY4I7RMIjpgkiQ2NKN
         v4xDMhyev//pG0nLD9ETTlHF/Ctvcpoc1CzqKHn9eTYGl3r87nbu1a/TyVyGq6+kZFhf
         43qQ==
X-Gm-Message-State: AOAM531wldgzkl7z2h8kkUI5iXVOqQJVOa4UQo3LmA1u4q/bF9Qf6tD0
        b6TNY29jlOM8tfEcuWCOnNSfZw==
X-Google-Smtp-Source: ABdhPJyDtO1GdDkvRUmwDFX8joET0r+ePZXFT4RKo7p2vUbMbHbtEK97zhOWYjWYpNtF93/j4UPyQw==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr5038037wmb.181.1605110983453;
        Wed, 11 Nov 2020 08:09:43 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id v6sm3414128wrb.53.2020.11.11.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:09:42 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:09:37 +0100
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
Subject: Re: [PATCH v2 02/20] kasan: rename get_alloc/free_info
Message-ID: <20201111160937.GD517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <f60a0852051bbe9a20d5f9eba7567c0e9474a1c4.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60a0852051bbe9a20d5f9eba7567c0e9474a1c4.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Rename get_alloc_info() and get_free_info() to kasan_get_alloc_meta()
> and kasan_get_free_meta() to better reflect what those do and avoid
> confusion with kasan_set_free_info().
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/Ib6e4ba61c8b12112b403d3479a9799ac8fff8de1
> ---
>  mm/kasan/common.c         | 16 ++++++++--------
>  mm/kasan/generic.c        | 12 ++++++------
>  mm/kasan/hw_tags.c        |  4 ++--
>  mm/kasan/kasan.h          |  8 ++++----
>  mm/kasan/quarantine.c     |  4 ++--
>  mm/kasan/report.c         | 12 ++++++------
>  mm/kasan/report_sw_tags.c |  2 +-
>  mm/kasan/sw_tags.c        |  4 ++--
>  8 files changed, 31 insertions(+), 31 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 5712c66c11c1..8fd04415d8f4 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -175,14 +175,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
>  		sizeof(struct kasan_free_meta) : 0);
>  }
>  
> -struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
> -					const void *object)
> +struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
> +					      const void *object)
>  {
>  	return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
>  }
>  
> -struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
> -				      const void *object)
> +struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
> +					    const void *object)
>  {
>  	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
>  	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
> @@ -259,13 +259,13 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object,
>  void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>  						const void *object)
>  {
> -	struct kasan_alloc_meta *alloc_info;
> +	struct kasan_alloc_meta *alloc_meta;
>  
>  	if (!(cache->flags & SLAB_KASAN))
>  		return (void *)object;
>  
> -	alloc_info = get_alloc_info(cache, object);
> -	__memset(alloc_info, 0, sizeof(*alloc_info));
> +	alloc_meta = kasan_get_alloc_meta(cache, object);
> +	__memset(alloc_meta, 0, sizeof(*alloc_meta));
>  
>  	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>  		object = set_tag(object, assign_tag(cache, object, true, false));
> @@ -345,7 +345,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  		KASAN_KMALLOC_REDZONE);
>  
>  	if (cache->flags & SLAB_KASAN)
> -		kasan_set_track(&get_alloc_info(cache, object)->alloc_track, flags);
> +		kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
>  
>  	return set_tag(object, tag);
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index adb254df1b1d..d259e4c3aefd 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -329,7 +329,7 @@ void kasan_record_aux_stack(void *addr)
>  {
>  	struct page *page = kasan_addr_to_page(addr);
>  	struct kmem_cache *cache;
> -	struct kasan_alloc_meta *alloc_info;
> +	struct kasan_alloc_meta *alloc_meta;
>  	void *object;
>  
>  	if (!(page && PageSlab(page)))
> @@ -337,13 +337,13 @@ void kasan_record_aux_stack(void *addr)
>  
>  	cache = page->slab_cache;
>  	object = nearest_obj(cache, page, addr);
> -	alloc_info = get_alloc_info(cache, object);
> +	alloc_meta = kasan_get_alloc_meta(cache, object);
>  
>  	/*
>  	 * record the last two call_rcu() call stacks.
>  	 */
> -	alloc_info->aux_stack[1] = alloc_info->aux_stack[0];
> -	alloc_info->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
> +	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
> +	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
>  }
>  
>  void kasan_set_free_info(struct kmem_cache *cache,
> @@ -351,7 +351,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>  {
>  	struct kasan_free_meta *free_meta;
>  
> -	free_meta = get_free_info(cache, object);
> +	free_meta = kasan_get_free_meta(cache, object);
>  	kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
>  
>  	/*
> @@ -365,5 +365,5 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  {
>  	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_KMALLOC_FREETRACK)
>  		return NULL;
> -	return &get_free_info(cache, object)->free_track;
> +	return &kasan_get_free_meta(cache, object)->free_track;
>  }
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 0080b78ec843..70b88dd40cd8 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -66,7 +66,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>  {
>  	struct kasan_alloc_meta *alloc_meta;
>  
> -	alloc_meta = get_alloc_info(cache, object);
> +	alloc_meta = kasan_get_alloc_meta(cache, object);
>  	kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
>  }
>  
> @@ -75,6 +75,6 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  {
>  	struct kasan_alloc_meta *alloc_meta;
>  
> -	alloc_meta = get_alloc_info(cache, object);
> +	alloc_meta = kasan_get_alloc_meta(cache, object);
>  	return &alloc_meta->free_track[0];
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index c2c40ec1544d..db8a7a508121 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -148,10 +148,10 @@ struct kasan_free_meta {
>  #endif
>  };
>  
> -struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
> -					const void *object);
> -struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
> -					const void *object);
> +struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
> +						const void *object);
> +struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
> +						const void *object);
>  
>  void kasan_poison_memory(const void *address, size_t size, u8 value);
>  
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index a0792f0d6d0f..0da3d37e1589 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -166,7 +166,7 @@ void quarantine_put(struct kmem_cache *cache, void *object)
>  	unsigned long flags;
>  	struct qlist_head *q;
>  	struct qlist_head temp = QLIST_INIT;
> -	struct kasan_free_meta *info = get_free_info(cache, object);
> +	struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
>  
>  	/*
>  	 * Note: irq must be disabled until after we move the batch to the
> @@ -179,7 +179,7 @@ void quarantine_put(struct kmem_cache *cache, void *object)
>  	local_irq_save(flags);
>  
>  	q = this_cpu_ptr(&cpu_quarantine);
> -	qlist_put(q, &info->quarantine_link, cache->size);
> +	qlist_put(q, &meta->quarantine_link, cache->size);
>  	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
>  		qlist_move_all(q, &temp);
>  
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index ce06005d4052..0cac53a57c14 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -164,12 +164,12 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>  static void describe_object(struct kmem_cache *cache, void *object,
>  				const void *addr, u8 tag)
>  {
> -	struct kasan_alloc_meta *alloc_info = get_alloc_info(cache, object);
> +	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
>  
>  	if (cache->flags & SLAB_KASAN) {
>  		struct kasan_track *free_track;
>  
> -		print_track(&alloc_info->alloc_track, "Allocated");
> +		print_track(&alloc_meta->alloc_track, "Allocated");
>  		pr_err("\n");
>  		free_track = kasan_get_free_track(cache, object, tag);
>  		if (free_track) {
> @@ -178,14 +178,14 @@ static void describe_object(struct kmem_cache *cache, void *object,
>  		}
>  
>  #ifdef CONFIG_KASAN_GENERIC
> -		if (alloc_info->aux_stack[0]) {
> +		if (alloc_meta->aux_stack[0]) {
>  			pr_err("Last call_rcu():\n");
> -			print_stack(alloc_info->aux_stack[0]);
> +			print_stack(alloc_meta->aux_stack[0]);
>  			pr_err("\n");
>  		}
> -		if (alloc_info->aux_stack[1]) {
> +		if (alloc_meta->aux_stack[1]) {
>  			pr_err("Second to last call_rcu():\n");
> -			print_stack(alloc_info->aux_stack[1]);
> +			print_stack(alloc_meta->aux_stack[1]);
>  			pr_err("\n");
>  		}
>  #endif
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index aebc44a29e83..317100fd95b9 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -46,7 +46,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>  	if (page && PageSlab(page)) {
>  		cache = page->slab_cache;
>  		object = nearest_obj(cache, page, (void *)addr);
> -		alloc_meta = get_alloc_info(cache, object);
> +		alloc_meta = kasan_get_alloc_meta(cache, object);
>  
>  		for (i = 0; i < KASAN_NR_FREE_STACKS; i++)
>  			if (alloc_meta->free_pointer_tag[i] == tag)
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index dfe707dd8d0d..3bffb489b144 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -174,7 +174,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>  	struct kasan_alloc_meta *alloc_meta;
>  	u8 idx = 0;
>  
> -	alloc_meta = get_alloc_info(cache, object);
> +	alloc_meta = kasan_get_alloc_meta(cache, object);
>  
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>  	idx = alloc_meta->free_track_idx;
> @@ -191,7 +191,7 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  	struct kasan_alloc_meta *alloc_meta;
>  	int i = 0;
>  
> -	alloc_meta = get_alloc_info(cache, object);
> +	alloc_meta = kasan_get_alloc_meta(cache, object);
>  
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>  	for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

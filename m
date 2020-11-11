Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA422AF485
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgKKPNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgKKPNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:13:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D862C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:13:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so2875455wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+INv8JEk5XPkG3ax0MxxlvUdmFmE55+jTOg5CXTsRM=;
        b=gCOH6uGacfEGAlGZE5LqTC3tTkpdWZ1awdWHzQ8/nU3bavxaDN+dvvIqQQCDtIn4E+
         3RccuUGS3SlpCsZL/zgllI5FQey6ukHD5asCGHApC5TICTWXprEaVlcXu2mVzAOmVa7V
         yqOtn83ZQdRPRd+UiACgcmhKaDL7eaaGlxYTZR5MyymcXS1t4tK7TA7FJKeeq1UidxBT
         ybeMeXhNb63l2HWe8omDpdT3bOXVwQR3Lv/8z5U7wSeqbCrsknV92vkmuZSayjkuTYyk
         2N7rCakFWaEz6IlkpMF+r2qYsZUYOydIB4wG/GN4dNOblyjF/AUDbQEXxiCanhKBuXXi
         Upjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+INv8JEk5XPkG3ax0MxxlvUdmFmE55+jTOg5CXTsRM=;
        b=kHvjC+3AEEaK4IteyF7WJqC+mB3dUrDx6S9eCQfqT0Dx6fRP6t12o1i2RARUDPva0+
         Cs9zmOVA84kg75MnVfPrpJsWm5mJe/C3pHZMywKr868GpEhotkFiI8GsuF/uqU+AzYRu
         WZ8poxrVsi57cd40wEHiBcDfY24M0VAXwqX+LmJ1ntNQIab6XUd5w+VXDckfebkx2Qmf
         E7DJrezYU2oFpDxSIP5GUyLHZeg4lOJmTr6oQeofTSuLUCsSBPgzHCpSwNb+AEYTjJ7Q
         sLxubYETqXXms7OLhGH4GZsvArg48EmMcBKs0VApPvgaUXwA8YzSA7o1GZgn5Oq/E07b
         6QxQ==
X-Gm-Message-State: AOAM532ycPdpxvyU37D2jl6/hxvHXvMvR82GqBLeboW4+QY7PKoC5ptg
        w7BNGbMkHyqOfGpdSw5SSoBYiQ==
X-Google-Smtp-Source: ABdhPJyT0sGWjPC6z/N8eDyDtVf0jkrEfp0riVXnnt/LmxwMaGfpcHd9dqUAYqGcWbLufSEkVWMBFg==
X-Received: by 2002:adf:db4a:: with SMTP id f10mr15496651wrj.420.1605107622540;
        Wed, 11 Nov 2020 07:13:42 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id p13sm2763952wrt.73.2020.11.11.07.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:13:41 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:13:36 +0100
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
Subject: Re: [PATCH v2 19/20] kasan, mm: allow cache merging with no metadata
Message-ID: <20201111151336.GA517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <936c0c198145b663e031527c49a6895bd21ac3a0.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <936c0c198145b663e031527c49a6895bd21ac3a0.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> The reason cache merging is disabled with KASAN is because KASAN puts its
> metadata right after the allocated object. When the merged caches have
> slightly different sizes, the metadata ends up in different places, which
> KASAN doesn't support.
> 
> It might be possible to adjust the metadata allocation algorithm and make
> it friendly to the cache merging code. Instead this change takes a simpler
> approach and allows merging caches when no metadata is present. Which is
> the case for hardware tag-based KASAN with kasan.mode=prod.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba
> ---
>  include/linux/kasan.h | 26 ++++++++++++++++++++++++--
>  mm/kasan/common.c     | 11 +++++++++++
>  mm/slab_common.c      | 11 ++++++++---
>  3 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 534ab3e2935a..c754eca356f7 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -81,17 +81,35 @@ struct kasan_cache {
>  };
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
> +
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +
>  static inline kasan_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }
> -#else
> +
> +slab_flags_t __kasan_never_merge(slab_flags_t flags);
> +static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
> +{
> +	if (kasan_enabled())
> +		return __kasan_never_merge(flags);
> +	return flags;
> +}
> +
> +#else /* CONFIG_KASAN_HW_TAGS */
> +
>  static inline kasan_enabled(void)
>  {
>  	return true;
>  }
> -#endif
> +
> +static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
> +{
> +	return flags;
> +}
> +
> +#endif /* CONFIG_KASAN_HW_TAGS */
>  
>  void __kasan_alloc_pages(struct page *page, unsigned int order);
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order)
> @@ -240,6 +258,10 @@ static inline kasan_enabled(void)
>  {
>  	return false;
>  }
> +static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
> +{
> +	return flags;
> +}
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_cache_create(struct kmem_cache *cache,
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 940b42231069..25b18c145b06 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -81,6 +81,17 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  }
>  #endif /* CONFIG_KASAN_STACK */
>  
> +/*
> + * Only allow cache merging when stack collection is disabled and no metadata
> + * is present.
> + */
> +slab_flags_t __kasan_never_merge(slab_flags_t flags)
> +{
> +	if (kasan_stack_collection_enabled())
> +		return flags;
> +	return flags & ~SLAB_KASAN;
> +}
> +
>  void __kasan_alloc_pages(struct page *page, unsigned int order)
>  {
>  	u8 tag;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f1b0c4a22f08..3042ee8ea9ce 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -18,6 +18,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/proc_fs.h>
>  #include <linux/debugfs.h>
> +#include <linux/kasan.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  #include <asm/page.h>
> @@ -49,12 +50,16 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>  		    slab_caches_to_rcu_destroy_workfn);
>  
>  /*
> - * Set of flags that will prevent slab merging
> + * Set of flags that will prevent slab merging.
> + * Use slab_never_merge() instead.
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
>  		SLAB_FAILSLAB | SLAB_KASAN)

Rather than changing this to require using slab_never_merge() which
removes SLAB_KASAN, could we not just have a function
kasan_never_merge() that returns KASAN-specific flags that should never
result in merging -- because as-is now, making kasan_never_merge()
remove the SLAB_KASAN flag seems the wrong way around.

Could we not just do this:

  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
  		SLAB_FAILSLAB | kasan_never_merge())

??

Of course that might be problematic if this always needs to be a
compile-time constant, but currently that's not a requirement.

> +/* KASAN allows merging in some configurations and will remove SLAB_KASAN. */
> +#define slab_never_merge() (kasan_never_merge(SLAB_NEVER_MERGE))

Braces unnecessary.

>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
>  
> @@ -164,7 +169,7 @@ static unsigned int calculate_alignment(slab_flags_t flags,
>   */
>  int slab_unmergeable(struct kmem_cache *s)
>  {
> -	if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
> +	if (slab_nomerge || (s->flags & slab_never_merge()))
>  		return 1;
>  
>  	if (s->ctor)
> @@ -198,7 +203,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
>  	size = ALIGN(size, align);
>  	flags = kmem_cache_flags(size, flags, name, NULL);
>  
> -	if (flags & SLAB_NEVER_MERGE)
> +	if (flags & slab_never_merge())
>  		return NULL;
>  
>  	list_for_each_entry_reverse(s, &slab_caches, list) {
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

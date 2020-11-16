Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6632B49BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbgKPPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgKPPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:45:25 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:45:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so24149076wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbFqzMvWkwy7nQ4a/oXAq0hKgif40IyQfOuqmDIS5m0=;
        b=C4zcZnUOBUlYavXgkmhztysqv+lt/KIffwhcnzK2ETTGlQbv5gWCnIw7Ey0Ej8u8UJ
         zHJnaO7sle5chY/EkWyzM0KgeeIgzLwDk+PVLxkYr/+JgGOzzvneRMq5Sl2dTVty7w8S
         0ZLyZwtzk0wOe98xMC0w3Jjm9PZtgvFandJpz2PG2wzQX6nGCQTaJ6yixXzJL1Q6FDiK
         lSohOQ7CoVcVUlAZQJuM6lTN9uOfU33esKvS/dlmsRKkPmfW3U93/C4FgQGYpXx7c3EH
         8o776dW3f/36hutiF9yDVk6xP3CncUKi0mQpTygVuax/nXf757x6FmCkbgb0ST5bY+oB
         2c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbFqzMvWkwy7nQ4a/oXAq0hKgif40IyQfOuqmDIS5m0=;
        b=efl5wtAhtrOAUfbDgQhOVi/5U1436hltSADq1dmnDogwzdJqPCuxjcxBUyu/MusuW4
         Rz1tXRq8qWAkQI5VBvCdKlp29k+87xEu4Y7G/5oz7/fUw3BAIupD/YPzYbP2rmny2c+a
         9ybnfudgfwtKTtzMrfI+07rBqVe4MoGRn/kIFwzR+n9cWLVjzi4ECj7C8Cwr8RgRq+Jp
         BaStod9bTUexXZdQHFgEdXJhRXsbh1zpIZMjg4cNDXtQIOJxGbOEIZLkZ+BjXm+tCg/d
         ev0y9W+MjYcywLYDauAb7zZYhAsY3EC7imvM/F9cR+OLjIr4EZFIrc1uARS2BfJ7P8Vt
         DHYg==
X-Gm-Message-State: AOAM5333S04r2Y0+UHSiz23k0mIYRUlgszF5GemO6A3NcrndbRn1AQIH
        QJd3n+CHtC+B7tUKKgtrLM7wYg==
X-Google-Smtp-Source: ABdhPJxy1Yn9VRBEdUbtcQKiw7w0OFwQsb6saiT5KDQPwGECAmrFhdKV3SE1tEy0gi/FDLvyz7GAkw==
X-Received: by 2002:a1c:f20d:: with SMTP id s13mr16738373wmc.156.1605541523649;
        Mon, 16 Nov 2020 07:45:23 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id h62sm23337450wrh.82.2020.11.16.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:45:22 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:45:17 +0100
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
Subject: Re: [PATCH mm v3 18/19] kasan, mm: allow cache merging with no
 metadata
Message-ID: <20201116154517.GG1357314@elver.google.com>
References: <cover.1605305978.git.andreyknvl@google.com>
 <6f0a1e72783ddac000ac08e7315b1d7c0ca4ec51.1605305978.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0a1e72783ddac000ac08e7315b1d7c0ca4ec51.1605305978.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
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
> Co-developed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Signed-off-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kasan.h | 21 +++++++++++++++++++--
>  mm/kasan/common.c     | 11 +++++++++++
>  mm/slab_common.c      |  3 ++-
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 16cf53eac29b..173a8e81d001 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -81,17 +81,30 @@ struct kasan_cache {
>  };
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
> +
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +
>  static __always_inline bool kasan_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }
> -#else
> +
> +#else /* CONFIG_KASAN_HW_TAGS */
> +
>  static inline bool kasan_enabled(void)
>  {
>  	return true;
>  }
> -#endif
> +
> +#endif /* CONFIG_KASAN_HW_TAGS */
> +
> +slab_flags_t __kasan_never_merge(void);
> +static __always_inline slab_flags_t kasan_never_merge(void)
> +{
> +	if (kasan_enabled())
> +		return __kasan_never_merge();
> +	return 0;
> +}
>  
>  void __kasan_unpoison_range(const void *addr, size_t size);
>  static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
> @@ -238,6 +251,10 @@ static inline bool kasan_enabled(void)
>  {
>  	return false;
>  }
> +static inline slab_flags_t kasan_never_merge(void)
> +{
> +	return 0;
> +}
>  static inline void kasan_unpoison_range(const void *address, size_t size) {}
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index cf874243efab..a5a4dcb1254d 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -87,6 +87,17 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  }
>  #endif /* CONFIG_KASAN_STACK */
>  
> +/*
> + * Only allow cache merging when stack collection is disabled and no metadata
> + * is present.
> + */
> +slab_flags_t __kasan_never_merge(void)
> +{
> +	if (kasan_stack_collection_enabled())
> +		return SLAB_KASAN;
> +	return 0;
> +}
> +
>  void __kasan_alloc_pages(struct page *page, unsigned int order)
>  {
>  	u8 tag;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 0b5ae1819a8b..075b23ce94ec 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -19,6 +19,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/proc_fs.h>
>  #include <linux/debugfs.h>
> +#include <linux/kasan.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  #include <asm/page.h>
> @@ -54,7 +55,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -		SLAB_FAILSLAB | SLAB_KASAN)
> +		SLAB_FAILSLAB | kasan_never_merge())
>  
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> -- 
> 2.29.2.299.gdc1121823c-goog
> 

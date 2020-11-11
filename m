Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9D2AF8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgKKTRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgKKTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:17:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C776C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:17:39 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so3614161wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kMrBNTvUl7eFEy433Sc7HrH1xnZw22qMO0dPs+XlBag=;
        b=JyMoM46iSDFsiDKvjg0YoviV0jxdDbSXOIqKDrRqUpzPy5au4hhoa98Y41MM6Zvn69
         7Jo7UIkvwH3Ssuk43BJjXiFJ30PzNeTzt6VQEDgS0UwANh5P/1eNNysQ7BCB1DU1ltNA
         2w0SR9iG3ajokKf/91XnJPozzUdEco8sod6U2zQPgbxu+FpKcu1x7s6va8ks253wNNIe
         Jr5TSykdUc/F6Ev77gVW8ceTL9fJe/w9SWAp89YLMUEDCdO31Lx0CxCq2AmKxoBpNnBl
         zfhFcjuUBjC+N2SGYOmcib6r+rWZmpuUf6pSiFR0DbUaSYTtCPNSWeVXQXrv+I6hwBVK
         XHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kMrBNTvUl7eFEy433Sc7HrH1xnZw22qMO0dPs+XlBag=;
        b=XpRNcgFzQlGtccjE2ZXnqxQHfYSAPRR38CqiiO+CXh8sk72uhSyxtn2U8j4Tt2/g3e
         yL+ji5H0zD6DMZJ5adVEmxnfxCVKD46LQ5fGuBeEkETW4qRK4ABKMzKq2iaxXIsJZRio
         1AyBgtDyHCnG+oNp9MBweno1/7KzYvnkK3hcZSdcpfaZMO/AysJLn9JapvNeuQ0IVSlG
         JobTSYAlgD1lrA+ldd4JBKoI/7fwy/dK9y4ZlDOAJ6IOa3vHoL2iUsyjor6uQ26b1/50
         xn9heRE8QiXsFXk++0t4uwQ+qiImVk4wxpZjscxI3loV0ZlcKmBm+1SJwgF6bZqpMDAG
         V64g==
X-Gm-Message-State: AOAM530oHt+Wyu1BZqy0VAER9Oq6wJTr0SCS2AShxJt2OuvKabXuDGBY
        9141FskZFgsE4VbIJ3cg3pUVWA==
X-Google-Smtp-Source: ABdhPJyDmF5o/EhHUlAWnTV5B9M/0BDsYvV61vd+CfOa8MeLPXuw8/vrzkyo+MVG1df4JWcvaJhoFg==
X-Received: by 2002:adf:93e1:: with SMTP id 88mr30294553wrp.37.1605122257781;
        Wed, 11 Nov 2020 11:17:37 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id b1sm3833382wmd.43.2020.11.11.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:17:36 -0800 (PST)
Date:   Wed, 11 Nov 2020 20:17:31 +0100
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
Subject: Re: [PATCH v2 16/20] kasan: simplify assign_tag and set_tag calls
Message-ID: <20201111191731.GR517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <eae2f21f9e412b508783f72c687cb0b76c151440.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae2f21f9e412b508783f72c687cb0b76c151440.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> set_tag() already ignores the tag for the generic mode, so just call it
> as is. Add a check for the generic mode to assign_tag(), and simplify its
> call in ____kasan_kmalloc().
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/I18905ca78fb4a3d60e1a34a4ca00247272480438
> ---
>  mm/kasan/common.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 69ab880abacc..40ff3ce07a76 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -238,6 +238,9 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  static u8 assign_tag(struct kmem_cache *cache, const void *object,
>  			bool init, bool keep_tag)
>  {
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +		return 0xff;
> +

Hopefully the compiler is clever enough to start inlining this function.

>  	/*
>  	 * 1. When an object is kmalloc()'ed, two hooks are called:
>  	 *    kasan_slab_alloc() and kasan_kmalloc(). We assign the
> @@ -280,8 +283,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>  		__memset(alloc_meta, 0, sizeof(*alloc_meta));
>  	}
>  
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> -		object = set_tag(object, assign_tag(cache, object, true, false));
> +	/* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
> +	object = set_tag(object, assign_tag(cache, object, true, false));
>  
>  	return (void *)object;
>  }
> @@ -362,9 +365,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  				KASAN_GRANULE_SIZE);
>  	redzone_end = round_up((unsigned long)object + cache->object_size,
>  				KASAN_GRANULE_SIZE);
> -
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> -		tag = assign_tag(cache, object, false, keep_tag);
> +	tag = assign_tag(cache, object, false, keep_tag);
>  

The definition of 'tag' at the start of ____kasan_kmalloc() no longer
needs an initializer.

>  	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
>  	kasan_unpoison_memory(set_tag(object, tag), size);

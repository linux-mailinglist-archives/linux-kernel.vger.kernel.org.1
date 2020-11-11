Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79D2AF5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgKKQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgKKQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:10:29 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224DFC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:10:29 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id j7so3072533wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u6Xd/aWnBK+33C9vA03cmc0xfNfCQ2wQSEufKCfSLLc=;
        b=S7eIjQJsoE5u9wPV9toq8jRiNhUQI3htGOSx8qUpkqR4BGLJRnQr+4x0Q4C0jbYqp2
         j1AS4li5L6Zbgn/O6bkqXpl3IrUhfW4fM0+xLQq6hyiBSFdHCYDE2XHU91znp4goXKvS
         EnB028EKIaLTEO5BOnGWZj5kpj7BUeQ5BEhlXzBaNTzdYAxK3uheaTyrpwTIE513EOz4
         jlXFggVxGCRzgwfvoExZ/3pE+dQsiFQZwlMsrBfof7DqYUbXTBADuj3OYAywwXF1JJt1
         CMQ6r5GBXsqa5eWpLEdcoegrHB9aUiIKtv0xnX971ZC4VGwHHqFrynLHOT6KDFJuSHXm
         95mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u6Xd/aWnBK+33C9vA03cmc0xfNfCQ2wQSEufKCfSLLc=;
        b=lYB/TTwPU4HP82Whcmq3BXEhBojwCmDNUToEkIEKO1j6fZBSGWJVc6948aBH2Q33mw
         JiaRztXu5E+TiJqWeQh+s9DCrOlK6YnS0U6vqMVuyDWVHfFgwFV3ga+JPdbdpAMBoB6+
         KNbSeq1P+lywncGpXgFpIRqBJZWzgwPV5jCKZZ9ciWutpf+9ffC5JB7+NRsmP7xQ1kq4
         fqW9KqKIQ5q4uQ4elWt6MA3kCPzq93jQMcqw2HfL1xVG3vIg8j07aI8tdmSYpqSSzeDn
         /qUdC6hp7N39x6/F0LipW+RIz84sz45AxZ9mJHk4gy7AGHJQAE07bqqw6yyoBNglgN4h
         gY2g==
X-Gm-Message-State: AOAM532eTyAwv0RQtARm1/wI47ujx0G9TFiov2Kr90vXmkkrw4FBgmPZ
        h8FKzXwhjv5Vby6qvXfvvcihYw==
X-Google-Smtp-Source: ABdhPJzALDfccylOWWCdBES+52srerfBn/V79OR8V0/sJjZ9s83yv6J95IO3y2SnNvZOpZH/OgK75g==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr31148545wrr.343.1605111027687;
        Wed, 11 Nov 2020 08:10:27 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id h62sm2946698wrh.82.2020.11.11.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:10:26 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:10:20 +0100
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
Subject: Re: [PATCH v2 03/20] kasan: introduce set_alloc_info
Message-ID: <20201111161020.GE517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <5302e6d48429465259bd0868a7dc357290a2e8a5.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5302e6d48429465259bd0868a7dc357290a2e8a5.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Add set_alloc_info() helper and move kasan_set_track() into it. This will
> simplify the code for one of the upcoming changes.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/I0316193cbb4ecc9b87b7c2eee0dd79f8ec908c1a
> ---

Reviewed-by: Marco Elver <elver@google.com>

>  mm/kasan/common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8fd04415d8f4..a880e5a547ed 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -318,6 +318,11 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  	return __kasan_slab_free(cache, object, ip, true);
>  }
>  
> +static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> +{
> +	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> +}
> +
>  static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  				size_t size, gfp_t flags, bool keep_tag)
>  {
> @@ -345,7 +350,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  		KASAN_KMALLOC_REDZONE);
>  
>  	if (cache->flags & SLAB_KASAN)
> -		kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> +		set_alloc_info(cache, (void *)object, flags);
>  
>  	return set_tag(object, tag);
>  }
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

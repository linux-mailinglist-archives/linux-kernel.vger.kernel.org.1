Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190172F7C53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbhAONRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbhAONRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:17:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72302C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:16:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 190so7332308wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qEMRXLlUvyuq/GhhJdtp57CwP12NI88NDUm2Xo71cuA=;
        b=d6rRLMr4FyYq+VjCGB63ryucj5NgGEP2mMPxsiB8MDoK7vTfyPvYLPn7/T8P4J50yw
         xckPKNOD0j2SZZFuOd2fmsKvLokunXuw0u1csOUtIs02oGvM8Y+1PL6ENGTi1/7D69nZ
         PeOf6Db69G6pYqiaM2tmkYPmCnnn1aHjOjDqVSNLPAFN8DDFTfu4I5caM3pBXwc4Y46x
         /WDZVTL03O+gDsvYyMTuc/CledMTVy5iD0fxF8BNDQSbqYtYg4CPNfuSY5kVfVYdSraP
         MzI8vpM2fc4QZNnQl+1hZVZ6RFBtIJaQZrvJTCw8aEyzGFx1J1PZRavXgl0RWoQQKciN
         d24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qEMRXLlUvyuq/GhhJdtp57CwP12NI88NDUm2Xo71cuA=;
        b=Y7tiJdCdmL1am1gQmQvyW8bCQOXHkdd18ZOEG6xiv2rMu8XIKSwgnd4UK1auQoUmwE
         X40aY/2CkdT9gsdRpQf+ihrkwmR1YHBAqcXYux9d2EQf1Tuj6xhi0EOnBT6s+UnfIjZu
         kNCcb4gcml0tPRQKYyE7siifBAUxz2NftgajC2IGKYSpZqE9HJiwrYtCN0uw+CIB9LGV
         9ziuOvu0DVVfccW6xhX68matbIhO3HX6n52mBD7Bv9JDnitqHYYXYLUNVhlOD2gY7+ip
         24/AbUt/uwKtmhfCXdCA1xU5s27eIzmNxzePOfIQjC/QINKnmMzK8uOCoi2Mi7Kn03a4
         l7xA==
X-Gm-Message-State: AOAM530uWERGModkpkVcxjCneYDV9NIIocNQTZDiZ2cV5e7P9WevNizf
        YBwWC6nkFiB4z9liG6UcBoXCVQ==
X-Google-Smtp-Source: ABdhPJwQKV/9URfVl9Me3tL0rZzeOIj2wQs4eXy1SRrDXwMmcndHU5pd5KYkfi+FxSfsT4aZ0NaOog==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr8794876wmj.61.1610716592906;
        Fri, 15 Jan 2021 05:16:32 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id s25sm15675814wrs.49.2021.01.15.05.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:16:32 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:16:26 +0100
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
Subject: Re: [PATCH v3 14/15] kasan: add a test for kmem_cache_alloc/free_bulk
Message-ID: <YAGVqisrGwZfRRQU@elver.google.com>
References: <cover.1610652890.git.andreyknvl@google.com>
 <b75320408b90f18e369a464c446b6969c2afb06c.1610652890.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75320408b90f18e369a464c446b6969c2afb06c.1610652890.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> Add a test for kmem_cache_alloc/free_bulk to make sure there are no
> false-positives when these functions are used.
> 
> Link: https://linux-review.googlesource.com/id/I2a8bf797aecf81baeac61380c567308f319e263d
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index ab22a653762e..a96376aa7293 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -479,10 +479,11 @@ static void kmem_cache_oob(struct kunit *test)
>  {
>  	char *p;
>  	size_t size = 200;
> -	struct kmem_cache *cache = kmem_cache_create("test_cache",
> -						size, 0,
> -						0, NULL);
> +	struct kmem_cache *cache;
> +
> +	cache = kmem_cache_create("test_cache",	size, 0, 0, NULL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +
>  	p = kmem_cache_alloc(cache, GFP_KERNEL);
>  	if (!p) {
>  		kunit_err(test, "Allocation failed: %s\n", __func__);
> @@ -491,11 +492,12 @@ static void kmem_cache_oob(struct kunit *test)
>  	}
>  
>  	KUNIT_EXPECT_KASAN_FAIL(test, *p = p[size + OOB_TAG_OFF]);
> +
>  	kmem_cache_free(cache, p);
>  	kmem_cache_destroy(cache);
>  }
>  
> -static void memcg_accounted_kmem_cache(struct kunit *test)
> +static void kmem_cache_accounted(struct kunit *test)
>  {
>  	int i;
>  	char *p;
> @@ -522,6 +524,31 @@ static void memcg_accounted_kmem_cache(struct kunit *test)
>  	kmem_cache_destroy(cache);
>  }
>  
> +static void kmem_cache_bulk(struct kunit *test)
> +{
> +	struct kmem_cache *cache;
> +	size_t size = 200;
> +	char *p[10];
> +	bool ret;
> +	int i;
> +
> +	cache = kmem_cache_create("test_cache",	size, 0, 0, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
> +
> +	ret = kmem_cache_alloc_bulk(cache, GFP_KERNEL, ARRAY_SIZE(p), (void **)&p);
> +	if (!ret) {
> +		kunit_err(test, "Allocation failed: %s\n", __func__);
> +		kmem_cache_destroy(cache);
> +		return;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(p); i++)
> +		p[i][0] = p[i][size - 1] = 42;
> +
> +	kmem_cache_free_bulk(cache, ARRAY_SIZE(p), (void **)&p);
> +	kmem_cache_destroy(cache);
> +}
> +
>  static char global_array[10];
>  
>  static void kasan_global_oob(struct kunit *test)
> @@ -961,7 +988,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kfree_via_page),
>  	KUNIT_CASE(kfree_via_phys),
>  	KUNIT_CASE(kmem_cache_oob),
> -	KUNIT_CASE(memcg_accounted_kmem_cache),
> +	KUNIT_CASE(kmem_cache_accounted),
> +	KUNIT_CASE(kmem_cache_bulk),
>  	KUNIT_CASE(kasan_global_oob),
>  	KUNIT_CASE(kasan_stack_oob),
>  	KUNIT_CASE(kasan_alloca_oob_left),
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

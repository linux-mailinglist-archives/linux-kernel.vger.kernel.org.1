Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A272F3306
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbhALOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhALOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:35:03 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53728C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:34:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r3so2744728wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U744HxyOHZ4bYG3Cc/mr37WoBXh+B0nSwCGfLK9zJn0=;
        b=p7sCAvlUYMzziw08KT/qOtcyvICsjejqtIpqIExn+H4PwcgvGDwmg16FQlQ75sQuCD
         xBH4gE5KQye10UuMDSF2RgbVZIulq5JDyWzHKGHj260uD4/BAcMKaZh+HqEsPEtYjt7E
         U3coTjGgKjnE0BrpCvc5Py0MH9LJ2/RyQqA3OOWTIF/PyVmiFais/Its6G3UrNwYSnq+
         JZU4hv4ikKdTh2+Mbj+cIsyhyUBRrEgL9tqvoyZvdoRJasaVXK3PacPRYYkpwCSYx4br
         ZYl6WqaJNYaCqtLmaclLMjiVfVdusosjDeERWjS8id9n3pvPWCz5aQPaV65r3pztPHLz
         1NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U744HxyOHZ4bYG3Cc/mr37WoBXh+B0nSwCGfLK9zJn0=;
        b=pVyTnWYRWo6TmfiljzVdjrscYdf9wedrSA+Qy5ERA0KboAruh93lpxDurz/JJkUvGC
         r5rZ7mLliVliVuyu9AoqwpNcLQhMFyjf4UjnUYXiG8YmquRda0C4POJhL2Pw4G2ztmry
         8/Wmc8CbfbpdmbIF7pA9429ZJ7jj4dwcIUuDUOrj6bmmh+nYjs9TRgapqf+WIxtxgAPU
         /j6jlJfu39zyXO4jci0ILWDrL5scHU6bwAgvOWkCyKUNqP/jgJltaYt4zDWT5AuEHZeh
         HnBKE7IWxxbvdOi4Gyr3MUs8K8vgtmBtXM5o14OjB0bEWZFhuxmX74aeJNeVpgTF3a2Z
         oMQQ==
X-Gm-Message-State: AOAM533hhrIV+jE38DtpjK5Cn2IzRvtMDfCXrh1R/ABrN0O7iWqnpOHa
        PCSlR/SPA6iQGP6xZRGgVflapQ==
X-Google-Smtp-Source: ABdhPJzKuddLdUE2T+B3q5M1asSfQtHaNy4J4XGxxEqbDbNKrNxvoQKkAPi5eAkDeCrROmSsNM29dg==
X-Received: by 2002:a5d:6204:: with SMTP id y4mr4678555wru.48.1610462061876;
        Tue, 12 Jan 2021 06:34:21 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id u10sm4120446wmd.43.2021.01.12.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:34:20 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:34:15 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] kasan: add proper page allocator tests
Message-ID: <X/2zZ1kuRDVvtq/T@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <15ca1976b26aa9edcec4a9d0f3b73f5b6536e5d0.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ca1976b26aa9edcec4a9d0f3b73f5b6536e5d0.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> The currently existing page allocator tests rely on kmalloc fallback
> with large sizes that is only present for SLUB. Add proper tests that
> use alloc/free_pages().
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia173d5a1b215fe6b2548d814ef0f4433cf983570

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 54 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 6261521e57ad..24798c034d05 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -128,6 +128,12 @@ static void kmalloc_node_oob_right(struct kunit *test)
>  	kfree(ptr);
>  }
>  
> +/*
> + * These kmalloc_pagealloc_* tests try allocating a memory chunk that doesn't
> + * fit into a slab cache and therefore is allocated via the page allocator
> + * fallback. Since this kind of fallback is only implemented for SLUB, these
> + * tests are limited to that allocator.
> + */
>  static void kmalloc_pagealloc_oob_right(struct kunit *test)
>  {
>  	char *ptr;
> @@ -138,14 +144,11 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
>  		return;
>  	}
>  
> -	/*
> -	 * Allocate a chunk that does not fit into a SLUB cache to trigger
> -	 * the page allocator fallback.
> -	 */
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
>  	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + OOB_TAG_OFF] = 0);
> +
>  	kfree(ptr);
>  }
>  
> @@ -161,8 +164,8 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
>  
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> -
>  	kfree(ptr);
> +
>  	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
>  }
>  
> @@ -182,6 +185,45 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
>  	KUNIT_EXPECT_KASAN_FAIL(test, kfree(ptr + 1));
>  }
>  
> +static void pagealloc_oob_right(struct kunit *test)
> +{
> +	char *ptr;
> +	struct page *pages;
> +	size_t order = 4;
> +	size_t size = (1UL << (PAGE_SHIFT + order));
> +
> +	/*
> +	 * With generic KASAN page allocations have no redzones, thus
> +	 * out-of-bounds detection is not guaranteed.
> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=210503.
> +	 */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC enabled");
> +		return;
> +	}
> +
> +	pages = alloc_pages(GFP_KERNEL, order);
> +	ptr = page_address(pages);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 0);
> +	free_pages((unsigned long)ptr, order);
> +}
> +
> +static void pagealloc_uaf(struct kunit *test)
> +{
> +	char *ptr;
> +	struct page *pages;
> +	size_t order = 4;
> +
> +	pages = alloc_pages(GFP_KERNEL, order);
> +	ptr = page_address(pages);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +	free_pages((unsigned long)ptr, order);
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = 0);
> +}
> +
>  static void kmalloc_large_oob_right(struct kunit *test)
>  {
>  	char *ptr;
> @@ -933,6 +975,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kmalloc_pagealloc_oob_right),
>  	KUNIT_CASE(kmalloc_pagealloc_uaf),
>  	KUNIT_CASE(kmalloc_pagealloc_invalid_free),
> +	KUNIT_CASE(pagealloc_oob_right),
> +	KUNIT_CASE(pagealloc_uaf),
>  	KUNIT_CASE(kmalloc_large_oob_right),
>  	KUNIT_CASE(kmalloc_oob_krealloc_more),
>  	KUNIT_CASE(kmalloc_oob_krealloc_less),
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

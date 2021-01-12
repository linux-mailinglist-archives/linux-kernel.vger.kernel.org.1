Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8302F315E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbhALNS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732573AbhALNSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:18:23 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89041C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:17:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c124so1869472wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r2Ei7fyUEnHPknZWOcRP3y5fyGhRG9BocXM6SVWCLZg=;
        b=HSpqfH3tnCj5BdIf8b8tZRD4P31NkNa078/+bVSugqthwJKAs9DH6s+rloG0HbsH75
         bCD2PsidCVgo/A7+sTJMH2NRbUSQbbNUfAe+8qVc9cJ2GeDnXAnHWlDXubWykseo2Lrd
         eW4oE/lxRyoVSFjmZzaYE264ls0vBhuu8wtwXWS3iriWA0F93Tps3yLvjyfQGXbsuSlM
         u4nHXbuBVdDL+9e2N8eKkOJcTsIF0HbTozu6hNoZ0WOufrzpD7+za9AZJPgQRfPdJJcf
         QYbvwYndVQGgVbE5XSN9G2MUYPx98fviCnCNuaAmQmUlZJa/EUEVQ6N+Q14mWB8F0Onb
         0CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r2Ei7fyUEnHPknZWOcRP3y5fyGhRG9BocXM6SVWCLZg=;
        b=C9kCtcsHmQBrsQOTvOzQDIc/YmS+yv14cBwTi8ANLt7V3WxSkIyUwWsgTDKGHuERLB
         ib9XM1VAF2whZzObn/xedVKSzyjfS/0Dem3p9WBFnAVP7AmQJuPWoiTuDT9iOijp81hO
         mPR4Kn/EQ4vtCWUtRHPAhI83gD11XWJ5g+TJ919BovVRf9bKb+E8s7oUxJIpb3Rf8gdR
         gFq7tPe6EGuXLo8DsKrXKy7yJIXOpjEYyPfOxVyAaJ24XQNgqbQHh1mUL+mqvROipWPI
         CjPNfMevfpFqGxHv43a+5hxjbQWH+zn8SmGI5Q1PuUttbKxhO0dLYMC5mnQCy6fjdCdw
         i8Zg==
X-Gm-Message-State: AOAM532w7b/rnCtEz+kHpgZi2fP7UlTXJhD2AYqT06PSDiXm2A5bKv42
        YDzJG4/x4wn5ZaqWbh02e99SSQ==
X-Google-Smtp-Source: ABdhPJyooKl17t+b1soLThNa0tuEUVCrKFbR51YfSayR5q56pNQQaP9pJ9JG9hnsgPFgqSjOIhDRww==
X-Received: by 2002:a1c:4684:: with SMTP id t126mr3592828wma.165.1610457461081;
        Tue, 12 Jan 2021 05:17:41 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id c20sm3810825wmb.38.2021.01.12.05.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:17:40 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:17:34 +0100
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
Subject: Re: [PATCH 04/11] kasan: add match-all tag tests
Message-ID: <X/2hboi2Tp87UZFZ@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <0f20f867d747b678604a68173a5f20fb8df9b756.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f20f867d747b678604a68173a5f20fb8df9b756.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> Add 3 new tests for tag-based KASAN modes:
> 
> 1. Check that match-all pointer tag is not assigned randomly.
> 2. Check that 0xff works as a match-all pointer tag.
> 3. Check that there are no match-all memory tags.
> 
> Note, that test #3 causes a significant number (255) of KASAN reports
> to be printed during execution for the SW_TAGS mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I78f1375efafa162b37f3abcb2c5bc2f3955dfd8e
> ---
>  lib/test_kasan.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/kasan/kasan.h |  6 ++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 46e578c8e842..f1eda0bcc780 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -13,6 +13,7 @@
>  #include <linux/mman.h>
>  #include <linux/module.h>
>  #include <linux/printk.h>
> +#include <linux/random.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> @@ -790,6 +791,95 @@ static void vmalloc_oob(struct kunit *test)
>  	vfree(area);
>  }
>  
> +/*
> + * Check that match-all pointer tag is not assigned randomly for
> + * tag-based modes.
> + */
> +static void match_all_not_assigned(struct kunit *test)
> +{
> +	char *ptr;
> +	struct page *pages;
> +	int i, size, order;
> +
> +	for (i = 0; i < 256; i++) {
> +		size = get_random_int() % KMALLOC_MAX_SIZE;

size appears to be unused?

> +		ptr = kmalloc(128, GFP_KERNEL);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +		KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +		kfree(ptr);
> +	}
> +
> +	for (i = 0; i < 256; i++) {
> +		order = get_random_int() % 4;
> +		pages = alloc_pages(GFP_KERNEL, order);
> +		ptr = page_address(pages);
> +		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +		KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +		free_pages((unsigned long)ptr, order);
> +	}
> +}
> +
> +/* Check that 0xff works as a match-all pointer tag for tag-based modes. */
> +static void match_all_ptr_tag(struct kunit *test)
> +{
> +	char *ptr;
> +	u8 tag;
> +
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +		kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
> +		return;
> +	}
> +
> +	ptr = kmalloc(128, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +	/* Backup the assigned tag. */
> +	tag = get_tag(ptr);
> +	KUNIT_EXPECT_NE(test, tag, (u8)KASAN_TAG_KERNEL);
> +
> +	/* Reset the tag to 0xff.*/
> +	ptr = set_tag(ptr, KASAN_TAG_KERNEL);
> +
> +	/* This access shouldn't trigger a KASAN report. */
> +	*ptr = 0;
> +
> +	/* Recover the pointer tag and free. */
> +	ptr = set_tag(ptr, tag);
> +	kfree(ptr);
> +}
> +
> +/* Check that there are no match-all memory tags for tag-based modes. */
> +static void match_all_mem_tag(struct kunit *test)
> +{
> +	char *ptr;
> +	int tag;
> +
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +		kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
> +		return;
> +	}
> +
> +	ptr = kmalloc(128, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +	KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +
> +	/* For each possible tag value not matching the pointer tag. */
> +	for (tag = KASAN_TAG_MIN; tag <= KASAN_TAG_KERNEL; tag++) {
> +		if (tag == get_tag(ptr))
> +			continue;
> +
> +		/* Mark the first memory granule with the chosen memory tag. */
> +		kasan_poison(ptr, KASAN_GRANULE_SIZE, (u8)tag);
> +
> +		/* This access must cause a KASAN report. */
> +		KUNIT_EXPECT_KASAN_FAIL(test, *ptr = 0);
> +	}
> +
> +	/* Recover the memory tag and free. */
> +	kasan_poison(ptr, KASAN_GRANULE_SIZE, get_tag(ptr));
> +	kfree(ptr);
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kmalloc_oob_right),
>  	KUNIT_CASE(kmalloc_oob_left),
> @@ -829,6 +919,9 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kasan_bitops_tags),
>  	KUNIT_CASE(kmalloc_double_kzfree),
>  	KUNIT_CASE(vmalloc_oob),
> +	KUNIT_CASE(match_all_not_assigned),
> +	KUNIT_CASE(match_all_ptr_tag),
> +	KUNIT_CASE(match_all_mem_tag),
>  	{}
>  };
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3b38baddec47..c3fb9bf241d3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -36,6 +36,12 @@ extern bool kasan_flag_panic __ro_after_init;
>  #define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
>  #define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +#define KASAN_TAG_MIN		0xF0 /* mimimum value for random tags */
> +#else
> +#define KASAN_TAG_MIN		0x00 /* mimimum value for random tags */
> +#endif
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  #define KASAN_FREE_PAGE         0xFF  /* page was freed */
>  #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

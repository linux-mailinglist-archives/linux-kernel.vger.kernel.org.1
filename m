Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D32F30A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbhALNIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbhALNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:08:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5749AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:07:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q18so2452928wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GnsdLE8z7GKqgdEkPWmktkSWY9f1wcAcGK6xh9iY7ow=;
        b=Wv7K70rB+SEKqbws4zM/pkhyra65viIyckmvHfFq2ReRrTGzNhD7fX0n9rug0ViROJ
         hfPf4k+DkkXH9fsbsNe5vi8IR1aRGZOO0ggzQG86ea/+FDAZSDKLRQkqtamdkxHtIWgy
         49eO9eIojEcm/0B5HmsRhbO42h2PBk9MCINAcHhmXpr8dKNFhj5uvPC2NywBs9anVlhT
         vx7NUbKALZCWqV9UfU/qsXDrq34YIRBYKWkkKWlIAHjZgMgljhlaIQ+t6J+W19d//aAP
         NKXDm08fh4lM5K/dCF/Tk9iaiIRTygAOKRSvnCCycqRWi2t9xdprKiR5dFzN/xuQtjHU
         3phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GnsdLE8z7GKqgdEkPWmktkSWY9f1wcAcGK6xh9iY7ow=;
        b=efp7YkI0QN6R+2UHL6d7kCZaZ839+UiLcorMFoEBtWnk0jkhRKCL6ziGxX8esq4CTp
         pkHNIUVeeVcE9sj2SLA/LPPX7edIri4RXhdRkOc8N8TRPyDIiyBz7lfdO62SFARVeUHk
         0zjTtxoZewUfp1QfjvfYfSr6NLzTkuwjEgM0LAQ53AsYw94zaX26Pe/3TXmNaaynbYfl
         jy/FVIcUltNK+2ok4yLEbOP8/wfad2E/Zn5+3trW8CANsCXxwaG0UTHCCi9uZCk5xH8w
         iNdr94k6+ArxK/+FWL9qK2WX3BTbq9ZpG06yjT8c6uqMGXYacwopUNqrhW/yWqXJUzV9
         L56A==
X-Gm-Message-State: AOAM531iK0koJykHuvlbjwgnMnNdgDiF4Vk6b4TVepSE4DprGElMFa8y
        8gg4snQclSJpcK91mE4ffYw0oQ==
X-Google-Smtp-Source: ABdhPJyNJcJ+VXAmZB1PIycCUtop7P7TDEiXYuKJX7hmaQezI44o8GndzMSJnyA8AjY9AlU+wdupqQ==
X-Received: by 2002:adf:b359:: with SMTP id k25mr4376621wrd.98.1610456845707;
        Tue, 12 Jan 2021 05:07:25 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id b133sm3694353wme.33.2021.01.12.05.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:07:24 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:07:19 +0100
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
Subject: Re: [PATCH 03/11] kasan: clean up comments in tests
Message-ID: <X/2fB7oPuRN29r7u@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <cb4e610c6584251aa2397b56c46e278da0050a25.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb4e610c6584251aa2397b56c46e278da0050a25.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> Clarify and update comments and info messages in KASAN tests.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I6c816c51fa1e0eb7aa3dead6bda1f339d2af46c8

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c        | 94 +++++++++++++++++++++++------------------
>  lib/test_kasan_module.c |  5 ++-
>  2 files changed, 55 insertions(+), 44 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 2947274cc2d3..46e578c8e842 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -28,10 +28,9 @@
>  #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
>  
>  /*
> - * We assign some test results to these globals to make sure the tests
> - * are not eliminated as dead code.
> + * Some tests use these global variables to store return values from function
> + * calls that could otherwise be eliminated by the compiler as dead code.
>   */
> -
>  void *kasan_ptr_result;
>  int kasan_int_result;
>  
> @@ -39,14 +38,13 @@ static struct kunit_resource resource;
>  static struct kunit_kasan_expectation fail_data;
>  static bool multishot;
>  
> +/*
> + * Temporarily enable multi-shot mode. Otherwise, KASAN would only report the
> + * first detected bug and panic the kernel if panic_on_warn is enabled.
> + */
>  static int kasan_test_init(struct kunit *test)
>  {
> -	/*
> -	 * Temporarily enable multi-shot mode and set panic_on_warn=0.
> -	 * Otherwise, we'd only get a report for the first case.
> -	 */
>  	multishot = kasan_save_enable_multi_shot();
> -
>  	return 0;
>  }
>  
> @@ -56,12 +54,12 @@ static void kasan_test_exit(struct kunit *test)
>  }
>  
>  /**
> - * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
> - * not cause a KASAN error. This uses a KUnit resource named "kasan_data." Do
> - * Do not use this name for a KUnit resource outside here.
> - *
> + * KUNIT_EXPECT_KASAN_FAIL() - check that the executed expression produces a
> + * KASAN report; causes a test failure otherwise. This relies on a KUnit
> + * resource named "kasan_data". Do not use this name for KUnit resources
> + * outside of KASAN tests.
>   */
> -#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
> +#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do { \
>  	fail_data.report_expected = true; \
>  	fail_data.report_found = false; \
>  	kunit_add_named_resource(test, \
> @@ -69,7 +67,7 @@ static void kasan_test_exit(struct kunit *test)
>  				NULL, \
>  				&resource, \
>  				"kasan_data", &fail_data); \
> -	condition; \
> +	expression; \
>  	KUNIT_EXPECT_EQ(test, \
>  			fail_data.report_expected, \
>  			fail_data.report_found); \
> @@ -117,11 +115,12 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
>  	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
>  
>  	if (!IS_ENABLED(CONFIG_SLUB)) {
> -		kunit_info(test, "CONFIG_SLUB is not enabled.");
> +		kunit_info(test, "skipping, CONFIG_SLUB required");
>  		return;
>  	}
>  
> -	/* Allocate a chunk that does not fit into a SLUB cache to trigger
> +	/*
> +	 * Allocate a chunk that does not fit into a SLUB cache to trigger
>  	 * the page allocator fallback.
>  	 */
>  	ptr = kmalloc(size, GFP_KERNEL);
> @@ -137,7 +136,7 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
>  	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
>  
>  	if (!IS_ENABLED(CONFIG_SLUB)) {
> -		kunit_info(test, "CONFIG_SLUB is not enabled.");
> +		kunit_info(test, "skipping, CONFIG_SLUB required");
>  		return;
>  	}
>  
> @@ -154,7 +153,7 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
>  	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
>  
>  	if (!IS_ENABLED(CONFIG_SLUB)) {
> -		kunit_info(test, "CONFIG_SLUB is not enabled.");
> +		kunit_info(test, "skipping, CONFIG_SLUB required");
>  		return;
>  	}
>  
> @@ -168,7 +167,9 @@ static void kmalloc_large_oob_right(struct kunit *test)
>  {
>  	char *ptr;
>  	size_t size = KMALLOC_MAX_CACHE_SIZE - 256;
> -	/* Allocate a chunk that is large enough, but still fits into a slab
> +
> +	/*
> +	 * Allocate a chunk that is large enough, but still fits into a slab
>  	 * and does not trigger the page allocator fallback in SLUB.
>  	 */
>  	ptr = kmalloc(size, GFP_KERNEL);
> @@ -218,7 +219,7 @@ static void kmalloc_oob_16(struct kunit *test)
>  
>  	/* This test is specifically crafted for the generic mode. */
>  	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
> +		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
>  		return;
>  	}
>  
> @@ -454,7 +455,7 @@ static void kasan_global_oob(struct kunit *test)
>  
>  	/* Only generic mode instruments globals. */
>  	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -		kunit_info(test, "CONFIG_KASAN_GENERIC required");
> +		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
>  		return;
>  	}
>  
> @@ -469,10 +470,13 @@ static void ksize_unpoisons_memory(struct kunit *test)
>  	ptr = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  	real_size = ksize(ptr);
> -	/* This access doesn't trigger an error. */
> +
> +	/* This access shouldn't trigger a KASAN report. */
>  	ptr[size] = 'x';
> -	/* This one does. */
> +
> +	/* This one must. */
>  	KUNIT_EXPECT_KASAN_FAIL(test, ptr[real_size] = 'y');
> +
>  	kfree(ptr);
>  }
>  
> @@ -483,7 +487,7 @@ static void kasan_stack_oob(struct kunit *test)
>  	char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
>  
>  	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
> -		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
> +		kunit_info(test, "skipping, CONFIG_KASAN_STACK required");
>  		return;
>  	}
>  
> @@ -498,12 +502,12 @@ static void kasan_alloca_oob_left(struct kunit *test)
>  
>  	/* Only generic mode instruments dynamic allocas. */
>  	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -		kunit_info(test, "CONFIG_KASAN_GENERIC required");
> +		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
>  		return;
>  	}
>  
>  	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
> -		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
> +		kunit_info(test, "skipping, CONFIG_KASAN_STACK required");
>  		return;
>  	}
>  
> @@ -518,12 +522,12 @@ static void kasan_alloca_oob_right(struct kunit *test)
>  
>  	/* Only generic mode instruments dynamic allocas. */
>  	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -		kunit_info(test, "CONFIG_KASAN_GENERIC required");
> +		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
>  		return;
>  	}
>  
>  	if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
> -		kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
> +		kunit_info(test, "skipping, CONFIG_KASAN_STACK required");
>  		return;
>  	}
>  
> @@ -568,7 +572,7 @@ static void kmem_cache_invalid_free(struct kunit *test)
>  		return;
>  	}
>  
> -	/* Trigger invalid free, the object doesn't get freed */
> +	/* Trigger invalid free, the object doesn't get freed. */
>  	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_free(cache, p + 1));
>  
>  	/*
> @@ -585,10 +589,12 @@ static void kasan_memchr(struct kunit *test)
>  	char *ptr;
>  	size_t size = 24;
>  
> -	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
> +	/*
> +	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
> +	 */
>  	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -		kunit_info(test,
> -			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> +		kunit_info(test, "skipping, CONFIG_AMD_MEM_ENCRYPT enabled");
>  		return;
>  	}
>  
> @@ -610,10 +616,12 @@ static void kasan_memcmp(struct kunit *test)
>  	size_t size = 24;
>  	int arr[9];
>  
> -	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
> +	/*
> +	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
> +	 */
>  	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -		kunit_info(test,
> -			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> +		kunit_info(test, "skipping, CONFIG_AMD_MEM_ENCRYPT enabled");
>  		return;
>  	}
>  
> @@ -634,10 +642,12 @@ static void kasan_strings(struct kunit *test)
>  	char *ptr;
>  	size_t size = 24;
>  
> -	/* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
> +	/*
> +	 * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
> +	 */
>  	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -		kunit_info(test,
> -			"str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> +		kunit_info(test, "skipping, CONFIG_AMD_MEM_ENCRYPT enabled");
>  		return;
>  	}
>  
> @@ -701,12 +711,12 @@ static void kasan_bitops_generic(struct kunit *test)
>  
>  	/* This test is specifically crafted for the generic mode. */
>  	if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -		kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
> +		kunit_info(test, "skipping, CONFIG_KASAN_GENERIC required");
>  		return;
>  	}
>  
>  	/*
> -	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
> +	 * Allocate 1 more byte, which causes kzalloc to round up to 16 bytes;
>  	 * this way we do not actually corrupt other memory.
>  	 */
>  	bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
> @@ -733,7 +743,7 @@ static void kasan_bitops_tags(struct kunit *test)
>  
>  	/* This test is specifically crafted for the tag-based mode. */
>  	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -		kunit_info(test, "CONFIG_KASAN_SW_TAGS required\n");
> +		kunit_info(test, "skipping, CONFIG_KASAN_SW_TAGS required");
>  		return;
>  	}
>  
> @@ -765,7 +775,7 @@ static void vmalloc_oob(struct kunit *test)
>  	void *area;
>  
>  	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> -		kunit_info(test, "CONFIG_KASAN_VMALLOC is not enabled.");
> +		kunit_info(test, "skipping, CONFIG_KASAN_VMALLOC required");
>  		return;
>  	}
>  
> diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> index 3b4cc77992d2..eee017ff8980 100644
> --- a/lib/test_kasan_module.c
> +++ b/lib/test_kasan_module.c
> @@ -123,8 +123,9 @@ static noinline void __init kasan_workqueue_uaf(void)
>  static int __init test_kasan_module_init(void)
>  {
>  	/*
> -	 * Temporarily enable multi-shot mode. Otherwise, we'd only get a
> -	 * report for the first case.
> +	 * Temporarily enable multi-shot mode. Otherwise, KASAN would only
> +	 * report the first detected bug and panic the kernel if panic_on_warn
> +	 * is enabled.
>  	 */
>  	bool multishot = kasan_save_enable_multi_shot();
>  
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

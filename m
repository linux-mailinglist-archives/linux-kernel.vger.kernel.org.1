Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814B32F3303
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbhALOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhALOd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:33:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF54C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:32:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i9so2712604wrc.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BjAc/arzdiYUQi9Fxp3yyzGY535p3hAg/IhemadQIq8=;
        b=grkqsyVpK2KQlRVussqWvM2+Vo89ssCy9kJZAuAXLfSJiQWI/zHJ8j3TlhsZcELBkV
         qWyTCAb009Ah9arukg78+/2mv6xb9Q56qbmbIt+LKdSYnrzKEo+sN9yusJhPIOKKriJn
         fWa6HCDMYJ9bOsrY7nniAZ1k9sNVg3yAPysvOrAiTQ9+vqEJ0C/xNCtu+sYHkaCSd1F1
         AWnXkZVkO71nasxAsOZCHd93rOt5fjFgubddSK0UjXNYrDLDLPEOCAIm7h4W2OY3sJ8w
         9cA15V9ilWlCMOMSKGUxPnCqmO+xBWaEp3fpRDF7miFCidbb4uia6LYjoM0sUm/KodrX
         MtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjAc/arzdiYUQi9Fxp3yyzGY535p3hAg/IhemadQIq8=;
        b=lLlqhxrPX698jKl6m4wumOLi60MqKXyHE4etXHVGgSvkIWTfcaOTctiL3Ej5EYZTnN
         Uv/N3x2ftONz2vqTiH9z9uIKawXLwrfFAvD5P9wOhLoBzw/tvr9j63++SjFYPT3zfQAM
         V6weosd9AKFxIhPkj+sRPN0A5i0FJ11nubXLQfIE8cFQ7RZPdpog3q1Ie6Gz/o+NkRIV
         w1EL1f2I9ot/KgOTbUSkR5mv+kPWvQ92EiP+ENuhCdpq6IQKY14fg1JKeGHahwqsKz5D
         JZrPSzoxhrRR8yEZc7i/knzB6lpV0LmuXrqrfBky81z4hU/qJYw1OkxC2erQYQjCtvRn
         JwWQ==
X-Gm-Message-State: AOAM532Af8PDQqilDtgU25cS+GtKqFONHYwHVO5dr/neGrR4wS3jU3b5
        qcMSCs5moEqcndTOlBnb0C03JA==
X-Google-Smtp-Source: ABdhPJxtSyrzh/iDinoRKJiMFnEIe6jwrFy+DuUWwcNnodLeUptNdj9mA6G4gtYX/afbyrc9UimQdg==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr4877009wro.338.1610461964966;
        Tue, 12 Jan 2021 06:32:44 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id g1sm5380699wrq.30.2021.01.12.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:32:44 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:32:38 +0100
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
Subject: Re: [PATCH 10/11] kasan: fix bug detection via ksize for HW_TAGS mode
Message-ID: <X/2zBibnd/zCBFa/@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <a83aa371e2ef96e79cbdefceebaa960a34957a79.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a83aa371e2ef96e79cbdefceebaa960a34957a79.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> The currently existing kasan_check_read/write() annotations are intended
> to be used for kernel modules that have KASAN compiler instrumentation
> disabled. Thus, they are only relevant for the software KASAN modes that
> rely on compiler instrumentation.
> 
> However there's another use case for these annotations: ksize() checks
> that the object passed to it is indeed accessible before unpoisoning the
> whole object. This is currently done via __kasan_check_read(), which is
> compiled away for the hardware tag-based mode that doesn't rely on
> compiler instrumentation. This leads to KASAN missing detecting some
> memory corruptions.
> 
> Provide another annotation called kasan_check_byte() that is available
> for all KASAN modes. As the implementation rename and reuse
> kasan_check_invalid_free(). Use this new annotation in ksize().
> 
> Also add a new ksize_uaf() test that checks that a use-after-free is
> detected via ksize() itself, and via plain accesses that happen later.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Iaabf771881d0f9ce1b969f2a62938e99d3308ec5
> ---
>  include/linux/kasan-checks.h |  6 ++++++
>  include/linux/kasan.h        | 13 +++++++++++++
>  lib/test_kasan.c             | 20 ++++++++++++++++++++
>  mm/kasan/common.c            | 11 ++++++++++-
>  mm/kasan/generic.c           |  4 ++--
>  mm/kasan/kasan.h             | 10 +++++-----
>  mm/kasan/sw_tags.c           |  6 +++---
>  mm/slab_common.c             | 15 +++++++++------
>  8 files changed, 68 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index ca5e89fb10d3..3d6d22a25bdc 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -4,6 +4,12 @@
>  
>  #include <linux/types.h>
>  
> +/*
> + * The annotations present in this file are only relevant for the software
> + * KASAN modes that rely on compiler instrumentation, and will be optimized
> + * away for the hardware tag-based KASAN mode. Use kasan_check_byte() instead.
> + */
> +
>  /*
>   * __kasan_check_*: Always available when KASAN is enabled. This may be used
>   * even in compilation units that selectively disable KASAN, but must use KASAN
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5e0655fb2a6f..992ba5c653a3 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -243,6 +243,18 @@ static __always_inline void kasan_kfree_large(void *ptr, unsigned long ip)
>  		__kasan_kfree_large(ptr, ip);
>  }
>  
> +/*
> + * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
> + * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> + */

We have too many check-functions, and the name needs to be more precise.
Intuitively, I would have thought this should have access-type, i.e.
read or write, effectively mirroring a normal access.

Would kasan_check_byte_read() be better (and just not have a 'write'
variant because we do not need it)? This would restore ksize() closest
to what it was before (assuming reporting behaviour is fixed, too).

> +bool __kasan_check_byte(const void *addr, unsigned long ip);
> +static __always_inline bool kasan_check_byte(const void *addr, unsigned long ip)
> +{
> +	if (kasan_enabled())
> +		return __kasan_check_byte(addr, ip);
> +	return true;
> +}
> +
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
>  
> @@ -299,6 +311,7 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>  	return (void *)object;
>  }
>  static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> +static inline bool kasan_check_byte(const void *address, unsigned long ip) {}
>  
>  #endif /* CONFIG_KASAN */
>  
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 3ea52da52714..6261521e57ad 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -490,6 +490,7 @@ static void kasan_global_oob(struct kunit *test)
>  	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
>  
> +/* Check that ksize() makes the whole object accessible. */
>  static void ksize_unpoisons_memory(struct kunit *test)
>  {
>  	char *ptr;
> @@ -508,6 +509,24 @@ static void ksize_unpoisons_memory(struct kunit *test)
>  	kfree(ptr);
>  }
>  
> +/*
> + * Check that a use-after-free is detected by ksize() and via normal accesses
> + * after it.
> + */
> +static void ksize_uaf(struct kunit *test)
> +{
> +	char *ptr;
> +	int size = 128 - KASAN_GRANULE_SIZE;
> +
> +	ptr = kmalloc(size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +	kfree(ptr);
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
> +	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *ptr);
> +	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *(ptr + size));
> +}
> +
>  static void kasan_stack_oob(struct kunit *test)
>  {
>  	char stack_array[10];
> @@ -937,6 +956,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kasan_alloca_oob_left),
>  	KUNIT_CASE(kasan_alloca_oob_right),
>  	KUNIT_CASE(ksize_unpoisons_memory),
> +	KUNIT_CASE(ksize_uaf),
>  	KUNIT_CASE(kmem_cache_double_free),
>  	KUNIT_CASE(kmem_cache_invalid_free),
>  	KUNIT_CASE(kasan_memchr),
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index eedc3e0fe365..45ab2c7073a8 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -345,7 +345,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>  		return false;
>  
> -	if (kasan_check_invalid_free(tagged_object)) {
> +	if (!kasan_check(tagged_object)) {
>  		kasan_report_invalid_free(tagged_object, ip);
>  		return true;
>  	}
> @@ -490,3 +490,12 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
>  		kasan_report_invalid_free(ptr, ip);
>  	/* The object will be poisoned by kasan_free_pages(). */
>  }
> +
> +bool __kasan_check_byte(const void *address, unsigned long ip)
> +{
> +	if (!kasan_check(address)) {
> +		kasan_report_invalid_free((void *)address, ip);

This is strange: why does it report an invalid free? Should this be a
use-after-free? I think this could just call kasan_report(....) for 1
byte, and we'd get the right report.

> +		return false;
> +	}
> +	return true;
> +}
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index acab8862dc67..b3631ad9a8ef 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -185,11 +185,11 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>  	return check_region_inline(addr, size, write, ret_ip);
>  }
>  
> -bool kasan_check_invalid_free(void *addr)
> +bool kasan_check(const void *addr)
>  {
>  	s8 shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
>  
> -	return shadow_byte < 0 || shadow_byte >= KASAN_GRANULE_SIZE;
> +	return shadow_byte >= 0 && shadow_byte < KASAN_GRANULE_SIZE;
>  }
>  
>  void kasan_cache_shrink(struct kmem_cache *cache)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 292dfbc37deb..f17591545279 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -329,20 +329,20 @@ static inline void kasan_unpoison(const void *address, size_t size)
>  			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>  
> -static inline bool kasan_check_invalid_free(void *addr)
> +static inline bool kasan_check(const void *addr)
>  {
>  	u8 ptr_tag = get_tag(addr);
> -	u8 mem_tag = hw_get_mem_tag(addr);
> +	u8 mem_tag = hw_get_mem_tag((void *)addr);
>  
> -	return (mem_tag == KASAN_TAG_INVALID) ||
> -		(ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
> +	return (mem_tag != KASAN_TAG_INVALID) &&
> +		(ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag);
>  }
>  
>  #else /* CONFIG_KASAN_HW_TAGS */
>  
>  void kasan_poison(const void *address, size_t size, u8 value);
>  void kasan_unpoison(const void *address, size_t size);
> -bool kasan_check_invalid_free(void *addr);
> +bool kasan_check(const void *addr);

Definitely prefer shorted names, but we're in the unfortunate situation
of having numerous kasan_check-functions, so we probably need to be more
precise.

kasan_check() makes me think this also does reporting, but it does not
(it seems to only check the metadata for validity).

The internal function could therefore be kasan_check_allocated() (it's
now the inverse of kasan_check_invalid_free()).

>  
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index cc271fceb5d5..e326caaaaca3 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -118,13 +118,13 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>  	return true;
>  }
>  
> -bool kasan_check_invalid_free(void *addr)
> +bool kasan_check(const void *addr)
>  {
>  	u8 tag = get_tag(addr);
>  	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
>  
> -	return (shadow_byte == KASAN_TAG_INVALID) ||
> -		(tag != KASAN_TAG_KERNEL && tag != shadow_byte);
> +	return (shadow_byte != KASAN_TAG_INVALID) &&
> +		(tag == KASAN_TAG_KERNEL || tag == shadow_byte);
>  }
>  
>  #define DEFINE_HWASAN_LOAD_STORE(size)					\
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e981c80d216c..a3bb44516623 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1157,11 +1157,13 @@ size_t ksize(const void *objp)
>  	size_t size;
>  
>  	/*
> -	 * We need to check that the pointed to object is valid, and only then
> -	 * unpoison the shadow memory below. We use __kasan_check_read(), to
> -	 * generate a more useful report at the time ksize() is called (rather
> -	 * than later where behaviour is undefined due to potential
> -	 * use-after-free or double-free).
> +	 * We need to first check that the pointer to the object is valid, and
> +	 * only then unpoison the memory. The report printed from ksize() is
> +	 * more useful, then when it's printed later when the behaviour could
> +	 * be undefined due to a potential use-after-free or double-free.
> +	 *
> +	 * We use kasan_check_byte(), which is supported for hardware tag-based
> +	 * KASAN mode, unlike kasan_check_read/write().
>  	 *
>  	 * If the pointed to memory is invalid we return 0, to avoid users of
>  	 * ksize() writing to and potentially corrupting the memory region.
> @@ -1169,7 +1171,8 @@ size_t ksize(const void *objp)
>  	 * We want to perform the check before __ksize(), to avoid potentially
>  	 * crashing in __ksize() due to accessing invalid metadata.
>  	 */
> -	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !__kasan_check_read(objp, 1))
> +	if (unlikely(ZERO_OR_NULL_PTR(objp)) ||
> +	    !kasan_check_byte(objp, _RET_IP_))
>  		return 0;
>  
>  	size = __ksize(objp);
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

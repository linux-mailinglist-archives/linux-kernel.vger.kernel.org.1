Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D012F7C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbhAONTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbhAONTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:19:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D8AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:18:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id s24so921084wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GkDcd3M5BN96zQc3rGkP2PwiXLixN9g52SK2TKwq13E=;
        b=SNfAj5VCiuT4TQVw1LyZ8ytuoKlFdneAAFY7EnhAaZbR+4X8VfQTYjHMpH7IIRrm1s
         P+Ic0yCbLqh71a58JtB7dWDH+AADOdsLYWWuqkvNK4uRd1Vzc29FkHz6RvwWZwf3Br8T
         iCal92Fop2KJz1zBAM9Ii2zgeA5peW7KgH8RhgeYr34GG+XhhvjRtASgPCJoE/ldvn58
         lNk5GYT/AcL7w048veSpqkgxS0V9g4jbOqH7JvJyQUw6whwJbRZ3/HJmDhWmHpFZiNIA
         h9xJ3XZXhqRaGR3Owl9kbByxIShiCCx2qX2mNxgoiknXNFErXcS+1j6af8jgWGROSwwG
         +2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GkDcd3M5BN96zQc3rGkP2PwiXLixN9g52SK2TKwq13E=;
        b=DTG9RrPZIXiZ5A1MqEVnfMo67bgjkHfWYj/zfNrKcoM618s/0+AhRndXsU7+DL8yw6
         VDC82Se/Mn5ZBlHVi/HmypuMOM/BbZtx0R3MXCk47D1rJpNLSR2zWKSP7h7ucea2s9Rz
         YSV0sU7qz9ar0QnWidKrgisJYTtX73DWmvILTWNZUPXgHKUNPXwJs/0l//tR99eDcwtQ
         /AHZYL4dFrqzvrRI44Fs3Cn+h1T8J/vyZUqPRSlrwxWLPrctAkE+cd7gpIisObVgPMY2
         wyqOpqFP9Sa8e2pumFVjyQBR47AHWmWdoQGXINE/fpuSo0nJbMi0MJJF9PCXdz6H2xbm
         NdHQ==
X-Gm-Message-State: AOAM531sS/lZVeV68JFbGzzIqmFpOLmEG0qjqKMcWWQ3nUVZmnju/k/J
        ztwri4xGPduxWyMykeInaExTQg==
X-Google-Smtp-Source: ABdhPJx2UychYZ9k0G8Uzg3rFbgSJ4BTXj/TSJjfGwwweKaYBBLuyl3za61xTuoShR0VFOheiN83Qw==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr8487765wmb.43.1610716681745;
        Fri, 15 Jan 2021 05:18:01 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id b19sm12075431wmj.37.2021.01.15.05.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:18:00 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:17:55 +0100
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
Subject: Re: [PATCH v3 12/15] kasan: fix bug detection via ksize for HW_TAGS
 mode
Message-ID: <YAGWA4EWQQd+7e+v@elver.google.com>
References: <cover.1610652890.git.andreyknvl@google.com>
 <bb93ea5b526a57ca328c69173433309837d05b25.1610652890.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb93ea5b526a57ca328c69173433309837d05b25.1610652890.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
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
> To avoid having ksize() as the top frame in the reported stack trace
> pass _RET_IP_ to __kasan_check_byte().
> 
> Also add a new ksize_uaf() test that checks that a use-after-free is
> detected via ksize() itself, and via plain accesses that happen later.
> 
> Link: https://linux-review.googlesource.com/id/Iaabf771881d0f9ce1b969f2a62938e99d3308ec5
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/kasan-checks.h |  6 ++++++
>  include/linux/kasan.h        | 17 +++++++++++++++++
>  lib/test_kasan.c             | 20 ++++++++++++++++++++
>  mm/kasan/common.c            | 11 ++++++++++-
>  mm/kasan/generic.c           |  4 ++--
>  mm/kasan/kasan.h             | 10 +++++-----
>  mm/kasan/sw_tags.c           |  6 +++---
>  mm/slab_common.c             | 16 +++++++++-------
>  8 files changed, 72 insertions(+), 18 deletions(-)
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
> index bba1637827c3..5bedd5ee481f 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -242,6 +242,19 @@ static __always_inline void kasan_kfree_large(void *ptr)
>  		__kasan_kfree_large(ptr, _RET_IP_);
>  }
>  
> +/*
> + * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
> + * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> + */
> +bool __kasan_check_byte(const void *addr, unsigned long ip);
> +static __always_inline bool kasan_check_byte(const void *addr)
> +{
> +	if (kasan_enabled())
> +		return __kasan_check_byte(addr, _RET_IP_);
> +	return true;
> +}
> +
> +
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
>  
> @@ -297,6 +310,10 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>  	return (void *)object;
>  }
>  static inline void kasan_kfree_large(void *ptr) {}
> +static inline bool kasan_check_byte(const void *address)
> +{
> +	return true;
> +}
>  
>  #endif /* CONFIG_KASAN */
>  
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index a06e7946f581..566d894ba20b 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -496,6 +496,7 @@ static void kasan_global_oob(struct kunit *test)
>  	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
>  
> +/* Check that ksize() makes the whole object accessible. */
>  static void ksize_unpoisons_memory(struct kunit *test)
>  {
>  	char *ptr;
> @@ -514,6 +515,24 @@ static void ksize_unpoisons_memory(struct kunit *test)
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
> @@ -907,6 +926,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(kasan_alloca_oob_left),
>  	KUNIT_CASE(kasan_alloca_oob_right),
>  	KUNIT_CASE(ksize_unpoisons_memory),
> +	KUNIT_CASE(ksize_uaf),
>  	KUNIT_CASE(kmem_cache_double_free),
>  	KUNIT_CASE(kmem_cache_invalid_free),
>  	KUNIT_CASE(kasan_memchr),
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index eedc3e0fe365..b18189ef3a92 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -345,7 +345,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>  		return false;
>  
> -	if (kasan_check_invalid_free(tagged_object)) {
> +	if (!kasan_byte_accessible(tagged_object)) {
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
> +	if (!kasan_byte_accessible(address)) {
> +		kasan_report((unsigned long)address, 1, false, ip);
> +		return false;
> +	}
> +	return true;
> +}
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index acab8862dc67..3f17a1218055 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -185,11 +185,11 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>  	return check_region_inline(addr, size, write, ret_ip);
>  }
>  
> -bool kasan_check_invalid_free(void *addr)
> +bool kasan_byte_accessible(const void *addr)
>  {
>  	s8 shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
>  
> -	return shadow_byte < 0 || shadow_byte >= KASAN_GRANULE_SIZE;
> +	return shadow_byte >= 0 && shadow_byte < KASAN_GRANULE_SIZE;
>  }
>  
>  void kasan_cache_shrink(struct kmem_cache *cache)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 292dfbc37deb..bd4ee6fab648 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -329,20 +329,20 @@ static inline void kasan_unpoison(const void *address, size_t size)
>  			round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>  
> -static inline bool kasan_check_invalid_free(void *addr)
> +static inline bool kasan_byte_accessible(const void *addr)
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
> +bool kasan_byte_accessible(const void *addr);
>  
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index cc271fceb5d5..94c2d33be333 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -118,13 +118,13 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>  	return true;
>  }
>  
> -bool kasan_check_invalid_free(void *addr)
> +bool kasan_byte_accessible(const void *addr)
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
> index e981c80d216c..9c12cf4212ea 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1157,19 +1157,21 @@ size_t ksize(const void *objp)
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
>  	 *
> -	 * If the pointed to memory is invalid we return 0, to avoid users of
> +	 * We use kasan_check_byte(), which is supported for the hardware
> +	 * tag-based KASAN mode, unlike kasan_check_read/write().
> +	 *
> +	 * If the pointed to memory is invalid, we return 0 to avoid users of
>  	 * ksize() writing to and potentially corrupting the memory region.
>  	 *
>  	 * We want to perform the check before __ksize(), to avoid potentially
>  	 * crashing in __ksize() due to accessing invalid metadata.
>  	 */
> -	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !__kasan_check_read(objp, 1))
> +	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !kasan_check_byte(objp))
>  		return 0;
>  
>  	size = __ksize(objp);
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 

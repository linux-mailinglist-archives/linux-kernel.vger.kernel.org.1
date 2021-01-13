Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71712F5072
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbhAMQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbhAMQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:55:30 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92605C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:54:50 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j12so2517548ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YM0lJ/DYtyywdsvK1TFwMpWTO8sFlphE2mcAvc/4Ouo=;
        b=JvyXeWyofIosOzUAiXVluLGLsM8rXShJ7rt29C3/663yMgk9cRQ4qrZLI/ssLLVRJr
         a096YjyDYxWGLG+F554S8V0iSmD1mxqd1NepozdpCTEL46cIppgXfdTpe9+VfMaazsOA
         RWbNVeMnUbGuXFwybZ//TSFuk5CGQevfjQQCSkLJh0vs4f1tlhT3Hm3JjCtBFv2PXVHB
         gEX5Nbb9j8r8M+Lm82ULvf5dsdn/2LB2JiVVYeffUBDNtBdR8176S8tXGhYAzR7kpErz
         scQPHl7cIBlsl+75l7zYwECKj6e4abCn1E+qOPLndr8/RDUwABKvLWb7YdhMspShU7gF
         OHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YM0lJ/DYtyywdsvK1TFwMpWTO8sFlphE2mcAvc/4Ouo=;
        b=alSsp5gZhWen8aRGbMcG5YAPIpXTOmejMup30IiFCKG7w3EFjEzh9PGUd3e1/IoTMo
         5VBle5lAibDd2jNVVv4nHr6j3fhkLptcEJ8U0Q0wDtevXDlGb4vKWsWwlXixCP58sac4
         jarj5hMKYLFITq4CE58l5M7YsnPFvnVxd6I5hyeyg3SDFPIhIrIKvxEWh7LXP/DqDm7t
         gRCWwfwWNlUKDmSmVpPZIFclTXjMrq3AF4NqR/9U4LDz9IJ98l4U9+uxBsw4Vdca+2po
         BhuWZ68hCzdq3iNWC1Dy8aGkysKCARzDGnqeBCKDOMsmUeMwvAdbEDnlwsM83H+Dc44q
         Zcnw==
X-Gm-Message-State: AOAM532x6W+4H4W73YriKjyzAs8iGlxW2MYwt55Edn5ozc4TnuhGR+Ai
        QoAbck21XNHHFb3bN+WNPmjXCWfLy4nYqD0QvPYMYg==
X-Google-Smtp-Source: ABdhPJw/bMQatzXCXmH0yM6oArE/QAAVRJGHVI4s3bkPFqrdynbRT5JxymMIIY7y4cjdEGa0iKoK3h4czmlhpCZuo4U=
X-Received: by 2002:a05:6830:19ca:: with SMTP id p10mr1851300otp.233.1610556889580;
 Wed, 13 Jan 2021 08:54:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <77015767eb7cfe1cc112a564d31e749d68615a0f.1610554432.git.andreyknvl@google.com>
In-Reply-To: <77015767eb7cfe1cc112a564d31e749d68615a0f.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:54:38 +0100
Message-ID: <CANpmjNPX9yn5izxtYMq14Aas2y4NA1ijkcS9KN4QQ-7Hv8qZEQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] kasan: fix bug detection via ksize for HW_TAGS mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 at 17:22, Andrey Konovalov <andreyknvl@google.com> wrote:
>
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
> Link: https://linux-review.googlesource.com/id/Iaabf771881d0f9ce1b969f2a62938e99d3308ec5
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Added some additional questions below, as I'm not sure about these
points yet. Otherwise looks good.

> ---
>  include/linux/kasan-checks.h |  6 ++++++
>  include/linux/kasan.h        | 16 ++++++++++++++++
>  lib/test_kasan.c             | 20 ++++++++++++++++++++
>  mm/kasan/common.c            | 11 ++++++++++-
>  mm/kasan/generic.c           |  4 ++--
>  mm/kasan/kasan.h             | 10 +++++-----
>  mm/kasan/sw_tags.c           |  6 +++---
>  mm/slab_common.c             | 15 +++++++++------
>  8 files changed, 71 insertions(+), 17 deletions(-)
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
> index 5e0655fb2a6f..b723895b157c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -243,6 +243,18 @@ static __always_inline void kasan_kfree_large(void *ptr, unsigned long ip)
>                 __kasan_kfree_large(ptr, ip);
>  }
>
> +/*
> + * Unlike kasan_check_read/write(), kasan_check_byte() is performed even for
> + * the hardware tag-based mode that doesn't rely on compiler instrumentation.
> + */
> +bool __kasan_check_byte(const void *addr, unsigned long ip);
> +static __always_inline bool kasan_check_byte(const void *addr, unsigned long ip)
> +{
> +       if (kasan_enabled())
> +               return __kasan_check_byte(addr, ip);
> +       return true;
> +}

Why was this not added to kasan-checks.h? I'd assume including all of
kasan.h is also undesirable for tag-based modes if we just want to do
a kasan_check_byte().

Was requiring 'ip' intentional? Unlike the other
kasan_check-functions, this takes an explicit 'ip'. In the case of
ksize() usage, this is an advantage, so I'd probably keep it, but the
rationale to introducing 'ip' vs. before wasn't mentioned.

>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
>
> @@ -299,6 +311,10 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>         return (void *)object;
>  }
>  static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> +static inline bool kasan_check_byte(const void *address, unsigned long ip)
> +{
> +       return true;
> +}
>
>  #endif /* CONFIG_KASAN */
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 63252d1fd58c..710e714dc0cb 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -496,6 +496,7 @@ static void kasan_global_oob(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
>
> +/* Check that ksize() makes the whole object accessible. */
>  static void ksize_unpoisons_memory(struct kunit *test)
>  {
>         char *ptr;
> @@ -514,6 +515,24 @@ static void ksize_unpoisons_memory(struct kunit *test)
>         kfree(ptr);
>  }
>
> +/*
> + * Check that a use-after-free is detected by ksize() and via normal accesses
> + * after it.
> + */
> +static void ksize_uaf(struct kunit *test)
> +{
> +       char *ptr;
> +       int size = 128 - KASAN_GRANULE_SIZE;
> +
> +       ptr = kmalloc(size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       kfree(ptr);
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *ptr);
> +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = *(ptr + size));
> +}
> +
>  static void kasan_stack_oob(struct kunit *test)
>  {
>         char stack_array[10];
> @@ -907,6 +926,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kasan_alloca_oob_left),
>         KUNIT_CASE(kasan_alloca_oob_right),
>         KUNIT_CASE(ksize_unpoisons_memory),
> +       KUNIT_CASE(ksize_uaf),
>         KUNIT_CASE(kmem_cache_double_free),
>         KUNIT_CASE(kmem_cache_invalid_free),
>         KUNIT_CASE(kasan_memchr),
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index eedc3e0fe365..b18189ef3a92 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -345,7 +345,7 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>         if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return false;
>
> -       if (kasan_check_invalid_free(tagged_object)) {
> +       if (!kasan_byte_accessible(tagged_object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
>                 return true;
>         }
> @@ -490,3 +490,12 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
>                 kasan_report_invalid_free(ptr, ip);
>         /* The object will be poisoned by kasan_free_pages(). */
>  }
> +
> +bool __kasan_check_byte(const void *address, unsigned long ip)
> +{
> +       if (!kasan_byte_accessible(address)) {
> +               kasan_report((unsigned long)address, 1, false, ip);
> +               return false;
> +       }
> +       return true;
> +}

Like the other __kasan_check*, should this have been EXPORT_SYMBOL()?
Or was it intentional to not export as it's currently only used by
non-modules?

> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index acab8862dc67..3f17a1218055 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -185,11 +185,11 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>         return check_region_inline(addr, size, write, ret_ip);
>  }
>
> -bool kasan_check_invalid_free(void *addr)
> +bool kasan_byte_accessible(const void *addr)
>  {
>         s8 shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
>
> -       return shadow_byte < 0 || shadow_byte >= KASAN_GRANULE_SIZE;
> +       return shadow_byte >= 0 && shadow_byte < KASAN_GRANULE_SIZE;
>  }
>
>  void kasan_cache_shrink(struct kmem_cache *cache)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 292dfbc37deb..bd4ee6fab648 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -329,20 +329,20 @@ static inline void kasan_unpoison(const void *address, size_t size)
>                         round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>
> -static inline bool kasan_check_invalid_free(void *addr)
> +static inline bool kasan_byte_accessible(const void *addr)
>  {
>         u8 ptr_tag = get_tag(addr);
> -       u8 mem_tag = hw_get_mem_tag(addr);
> +       u8 mem_tag = hw_get_mem_tag((void *)addr);
>
> -       return (mem_tag == KASAN_TAG_INVALID) ||
> -               (ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag);
> +       return (mem_tag != KASAN_TAG_INVALID) &&
> +               (ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag);
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
>         return true;
>  }
>
> -bool kasan_check_invalid_free(void *addr)
> +bool kasan_byte_accessible(const void *addr)
>  {
>         u8 tag = get_tag(addr);
>         u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
>
> -       return (shadow_byte == KASAN_TAG_INVALID) ||
> -               (tag != KASAN_TAG_KERNEL && tag != shadow_byte);
> +       return (shadow_byte != KASAN_TAG_INVALID) &&
> +               (tag == KASAN_TAG_KERNEL || tag == shadow_byte);
>  }
>
>  #define DEFINE_HWASAN_LOAD_STORE(size)                                 \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index e981c80d216c..a3bb44516623 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1157,11 +1157,13 @@ size_t ksize(const void *objp)
>         size_t size;
>
>         /*
> -        * We need to check that the pointed to object is valid, and only then
> -        * unpoison the shadow memory below. We use __kasan_check_read(), to
> -        * generate a more useful report at the time ksize() is called (rather
> -        * than later where behaviour is undefined due to potential
> -        * use-after-free or double-free).
> +        * We need to first check that the pointer to the object is valid, and
> +        * only then unpoison the memory. The report printed from ksize() is
> +        * more useful, then when it's printed later when the behaviour could
> +        * be undefined due to a potential use-after-free or double-free.
> +        *
> +        * We use kasan_check_byte(), which is supported for hardware tag-based
> +        * KASAN mode, unlike kasan_check_read/write().
>          *
>          * If the pointed to memory is invalid we return 0, to avoid users of
>          * ksize() writing to and potentially corrupting the memory region.
> @@ -1169,7 +1171,8 @@ size_t ksize(const void *objp)
>          * We want to perform the check before __ksize(), to avoid potentially
>          * crashing in __ksize() due to accessing invalid metadata.
>          */
> -       if (unlikely(ZERO_OR_NULL_PTR(objp)) || !__kasan_check_read(objp, 1))
> +       if (unlikely(ZERO_OR_NULL_PTR(objp)) ||
> +           !kasan_check_byte(objp, _RET_IP_))
>                 return 0;
>
>         size = __ksize(objp);
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

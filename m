Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1282F4FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhAMQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbhAMQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:24:56 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C6EC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:24:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id d189so2673238oig.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyTHDPIRlWLUaLwyKAW0evEpBngzgktQyEH3p/lXCIQ=;
        b=tlmb7Dtm51MoH15iZg/lhbLEU6E68eF7hqHr1ps+iDOD9RNrV57MUjlTOEoiDYpx69
         2YAEmHX3h7QQSxfCGnPtws3q+v+8qoDfQgCAX/6c5bnqVjNrNclTcfs88p4Ts0qyke/v
         ZlCAK0KNdVFHCc/68pduQuHGmlZ+rAqUP1e16Pxj2qGysyZQe1ElKbcaJYO/2BQrFCKa
         BwcWhOlEbJPZrmymNTXoiudyzG6dgf19wjbt8WJxM0qyLERrMKqDZgCfl8rEZlDio16m
         GRYglcqBDhqtJofwb28SiGQ3j6arsVBTJccjuQnqdI/ztty+oWz6GQNyTFbNlwdDE1qX
         3kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyTHDPIRlWLUaLwyKAW0evEpBngzgktQyEH3p/lXCIQ=;
        b=mvx3BK1ogN6SJ13u2h+OWAj9YbEVfvVa5/YoFH7lwvCvKrXW3/QT3sxn8oIr9+J4F3
         jRKD7DUmEwCDndZAOsHfWi4rn9uGb0bCp2PQZB6cvU9+CT3dYGQwCsuOGdzURgIoRxdA
         Ez5yew98EzS/V1BcZDQPx8h2OQ4sA91BlVGiYcjCM1pBxexqjEQ8+UTQdnW3Y3q6tp+z
         78gTRsQx7XJcPdiDqUxGOnR+GjzlKH9zllJ9IPS05Q8FyOryhpNBoGeETpdPWpgHPFCX
         mXIHgz5yF1GLcxQSIF7ViSJ5qCfrQQ24KGUEwAMokqUIdD3dOIFWp8EVQPF1JD5QYNAE
         4R6g==
X-Gm-Message-State: AOAM531RIFXk8ET3f8sqAu9e6SlirD2pvcg3lB0FYiT9roUwV6DrrKz0
        xK41A2rOZkOvqTx/WYbkwZgTAY1gxIwTdF250N18jA==
X-Google-Smtp-Source: ABdhPJzTX1NywOTNPaOnaT0/36HRmD8HHFaXd0vCHiUeKsmc7RWZZTe0P8Mxj/7ZesW69I5KXUm9LuyLJUSGubltUn8=
X-Received: by 2002:aca:c085:: with SMTP id q127mr58645oif.70.1610555055524;
 Wed, 13 Jan 2021 08:24:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <2b43049e25dcd04850ba6c205cd6dcc7caa4a886.1610554432.git.andreyknvl@google.com>
In-Reply-To: <2b43049e25dcd04850ba6c205cd6dcc7caa4a886.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:24:03 +0100
Message-ID: <CANpmjNOdax5uH1bG_D+7SWBL6FphCefcKs+5wig9NZxeEghUYA@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] kasan: clean up comments in tests
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

On Wed, 13 Jan 2021 at 17:21, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Clarify and update comments in KASAN tests.
>
> Link: https://linux-review.googlesource.com/id/I6c816c51fa1e0eb7aa3dead6bda1f339d2af46c8
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  lib/test_kasan.c        | 59 +++++++++++++++++++++++++----------------
>  lib/test_kasan_module.c |  5 ++--
>  2 files changed, 39 insertions(+), 25 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 2947274cc2d3..6f46e27c2af7 100644
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
> -       /*
> -        * Temporarily enable multi-shot mode and set panic_on_warn=0.
> -        * Otherwise, we'd only get a report for the first case.
> -        */
>         multishot = kasan_save_enable_multi_shot();
> -
>         return 0;
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
>         fail_data.report_expected = true; \
>         fail_data.report_found = false; \
>         kunit_add_named_resource(test, \
> @@ -69,7 +67,7 @@ static void kasan_test_exit(struct kunit *test)
>                                 NULL, \
>                                 &resource, \
>                                 "kasan_data", &fail_data); \
> -       condition; \
> +       expression; \
>         KUNIT_EXPECT_EQ(test, \
>                         fail_data.report_expected, \
>                         fail_data.report_found); \
> @@ -121,7 +119,8 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
>                 return;
>         }
>
> -       /* Allocate a chunk that does not fit into a SLUB cache to trigger
> +       /*
> +        * Allocate a chunk that does not fit into a SLUB cache to trigger
>          * the page allocator fallback.
>          */
>         ptr = kmalloc(size, GFP_KERNEL);
> @@ -168,7 +167,9 @@ static void kmalloc_large_oob_right(struct kunit *test)
>  {
>         char *ptr;
>         size_t size = KMALLOC_MAX_CACHE_SIZE - 256;
> -       /* Allocate a chunk that is large enough, but still fits into a slab
> +
> +       /*
> +        * Allocate a chunk that is large enough, but still fits into a slab
>          * and does not trigger the page allocator fallback in SLUB.
>          */
>         ptr = kmalloc(size, GFP_KERNEL);
> @@ -469,10 +470,13 @@ static void ksize_unpoisons_memory(struct kunit *test)
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         real_size = ksize(ptr);
> -       /* This access doesn't trigger an error. */
> +
> +       /* This access shouldn't trigger a KASAN report. */
>         ptr[size] = 'x';
> -       /* This one does. */
> +
> +       /* This one must. */
>         KUNIT_EXPECT_KASAN_FAIL(test, ptr[real_size] = 'y');
> +
>         kfree(ptr);
>  }
>
> @@ -568,7 +572,7 @@ static void kmem_cache_invalid_free(struct kunit *test)
>                 return;
>         }
>
> -       /* Trigger invalid free, the object doesn't get freed */
> +       /* Trigger invalid free, the object doesn't get freed. */
>         KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_free(cache, p + 1));
>
>         /*
> @@ -585,7 +589,10 @@ static void kasan_memchr(struct kunit *test)
>         char *ptr;
>         size_t size = 24;
>
> -       /* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
> +       /*
> +        * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> +        * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
> +        */
>         if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
>                 kunit_info(test,
>                         "str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> @@ -610,7 +617,10 @@ static void kasan_memcmp(struct kunit *test)
>         size_t size = 24;
>         int arr[9];
>
> -       /* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
> +       /*
> +        * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> +        * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
> +        */
>         if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
>                 kunit_info(test,
>                         "str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> @@ -634,7 +644,10 @@ static void kasan_strings(struct kunit *test)
>         char *ptr;
>         size_t size = 24;
>
> -       /* See https://bugzilla.kernel.org/show_bug.cgi?id=206337 */
> +       /*
> +        * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
> +        * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
> +        */
>         if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
>                 kunit_info(test,
>                         "str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> @@ -706,7 +719,7 @@ static void kasan_bitops_generic(struct kunit *test)
>         }
>
>         /*
> -        * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
> +        * Allocate 1 more byte, which causes kzalloc to round up to 16 bytes;
>          * this way we do not actually corrupt other memory.
>          */
>         bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
> diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> index 3b4cc77992d2..eee017ff8980 100644
> --- a/lib/test_kasan_module.c
> +++ b/lib/test_kasan_module.c
> @@ -123,8 +123,9 @@ static noinline void __init kasan_workqueue_uaf(void)
>  static int __init test_kasan_module_init(void)
>  {
>         /*
> -        * Temporarily enable multi-shot mode. Otherwise, we'd only get a
> -        * report for the first case.
> +        * Temporarily enable multi-shot mode. Otherwise, KASAN would only
> +        * report the first detected bug and panic the kernel if panic_on_warn
> +        * is enabled.
>          */
>         bool multishot = kasan_save_enable_multi_shot();
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

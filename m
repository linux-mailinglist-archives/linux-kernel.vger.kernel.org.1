Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2012F4FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbhAMQ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbhAMQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:26:23 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50383C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:25:43 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s75so2728636oih.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rj6WRYh2NAKrrsW/5ki70/RayzjiACCNyfDalLAwfF0=;
        b=jSgTpyYiVJNvKujRLGFHHELEmVz4JaV4upEv4FrohplG4JzMFV2LBIWHmUvTqhpUez
         8WhDODyf3jNJ5VECgMdRmCtxLaFe12S2tcRAbwSi1uZSq+pXvrcExhVkO5DrPu5GiDdx
         gQSBle4eN1Joaf53lFbpxNGky8YVAoRsOCvr2ricmh0lHb6BqsD/CUolq7af1qTUSPZD
         kG11xlEloWLUF6690HyCiS0NvfrHxKGMip8LHYyNcxuCBNyhvC1fmbD14pQO/trvmyOK
         W3JQ1SU+3Nd0pTyJaHKpqXYDfSP8hUwigwsli8PqsUDn7J8QHj/dDHmHwiuS0PlRt1FU
         2qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rj6WRYh2NAKrrsW/5ki70/RayzjiACCNyfDalLAwfF0=;
        b=mEsfrNIcM6ZB+7eBSXh/bgjKzLTlZPlqEuUQ+8FKwCCfUWBbxWjtFp1krBIX6LUxJP
         QKAWa9I8auSKbjvhfg320aUuZu8lbDwOZZg6R7ngvJTaawVHJsdoB9oXNcD71OqVG+J1
         +urGGpUXdwrtYsg81KBWn3+5/A0mChLOY+fZuchtBhdpVcGZ/VY3QySdLh4vl1nPBFff
         Jmbrt1bWQ5Np6fex7hiyr+roSDNuGij2MGudRY4xaEHjP8XKjkU3Ai1V5qnDRDTppeaD
         tluICX4F5YsxzcjJNxiYnpI/Nrxn4wh5Rz+HppCwLdBSUaorethnaJQ4HXHtFfbhPuc0
         u26A==
X-Gm-Message-State: AOAM5300nX26RhGXEzPmhbq+/IXNNIWQSne+y3VbbVbsS1XhmlDvhEza
        VWd7YIVMSqQW2lrraUd1/WnJ18yZQ4dGy2855bt+Aw==
X-Google-Smtp-Source: ABdhPJywPKjJzUSFfYCgX2MFHcUXeN6dr16UwQ1EagdVwLG9fJmHZSDX5Gftx2s3q5t7XWKipNBvsCRCzXZ1EiumsIU=
X-Received: by 2002:aca:58d6:: with SMTP id m205mr17059oib.121.1610555142511;
 Wed, 13 Jan 2021 08:25:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <0afed913e43017575794de0777b15ef6b2bdd486.1610554432.git.andreyknvl@google.com>
In-Reply-To: <0afed913e43017575794de0777b15ef6b2bdd486.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:25:30 +0100
Message-ID: <CANpmjNMZHiwKDTyBdHzHB6CexJTfN9TUjk=q6zmj_nebtq9=mg@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] kasan: add macros to simplify checking test constraints
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
> Some KASAN tests require specific kernel configs to be enabled.
> Instead of copy-pasting the checks for these configs add a few helper
> macros and use them.
>
> Link: https://linux-review.googlesource.com/id/I237484a7fddfedf4a4aae9cc61ecbcdbe85a0a63
> Suggested-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Nice!

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 101 +++++++++++++++--------------------------------
>  1 file changed, 31 insertions(+), 70 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 6f46e27c2af7..714ea27fcc3e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -73,6 +73,20 @@ static void kasan_test_exit(struct kunit *test)
>                         fail_data.report_found); \
>  } while (0)
>
> +#define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {                  \
> +       if (!IS_ENABLED(config)) {                                      \
> +               kunit_info((test), "skipping, " #config " required");   \
> +               return;                                                 \
> +       }                                                               \
> +} while (0)
> +
> +#define KASAN_TEST_NEEDS_CONFIG_OFF(test, config) do {                 \
> +       if (IS_ENABLED(config)) {                                       \
> +               kunit_info((test), "skipping, " #config " enabled");    \
> +               return;                                                 \
> +       }                                                               \
> +} while (0)
> +
>  static void kmalloc_oob_right(struct kunit *test)
>  {
>         char *ptr;
> @@ -114,10 +128,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
>         char *ptr;
>         size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
>
> -       if (!IS_ENABLED(CONFIG_SLUB)) {
> -               kunit_info(test, "CONFIG_SLUB is not enabled.");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
>
>         /*
>          * Allocate a chunk that does not fit into a SLUB cache to trigger
> @@ -135,10 +146,7 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
>         char *ptr;
>         size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
>
> -       if (!IS_ENABLED(CONFIG_SLUB)) {
> -               kunit_info(test, "CONFIG_SLUB is not enabled.");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> @@ -152,10 +160,7 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
>         char *ptr;
>         size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
>
> -       if (!IS_ENABLED(CONFIG_SLUB)) {
> -               kunit_info(test, "CONFIG_SLUB is not enabled.");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> @@ -218,10 +223,7 @@ static void kmalloc_oob_16(struct kunit *test)
>         } *ptr1, *ptr2;
>
>         /* This test is specifically crafted for the generic mode. */
> -       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -               kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
>
>         ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
> @@ -454,10 +456,7 @@ static void kasan_global_oob(struct kunit *test)
>         char *p = &global_array[ARRAY_SIZE(global_array) + i];
>
>         /* Only generic mode instruments globals. */
> -       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -               kunit_info(test, "CONFIG_KASAN_GENERIC required");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
>
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
> @@ -486,10 +485,7 @@ static void kasan_stack_oob(struct kunit *test)
>         volatile int i = OOB_TAG_OFF;
>         char *p = &stack_array[ARRAY_SIZE(stack_array) + i];
>
> -       if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
> -               kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
>
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
> @@ -501,15 +497,8 @@ static void kasan_alloca_oob_left(struct kunit *test)
>         char *p = alloca_array - 1;
>
>         /* Only generic mode instruments dynamic allocas. */
> -       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -               kunit_info(test, "CONFIG_KASAN_GENERIC required");
> -               return;
> -       }
> -
> -       if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
> -               kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
>
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
> @@ -521,15 +510,8 @@ static void kasan_alloca_oob_right(struct kunit *test)
>         char *p = alloca_array + i;
>
>         /* Only generic mode instruments dynamic allocas. */
> -       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -               kunit_info(test, "CONFIG_KASAN_GENERIC required");
> -               return;
> -       }
> -
> -       if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
> -               kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_STACK);
>
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
> @@ -593,11 +575,7 @@ static void kasan_memchr(struct kunit *test)
>          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
>          * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
>          */
> -       if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -               kunit_info(test,
> -                       "str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);
>
>         if (OOB_TAG_OFF)
>                 size = round_up(size, OOB_TAG_OFF);
> @@ -621,11 +599,7 @@ static void kasan_memcmp(struct kunit *test)
>          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
>          * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
>          */
> -       if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -               kunit_info(test,
> -                       "str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);
>
>         if (OOB_TAG_OFF)
>                 size = round_up(size, OOB_TAG_OFF);
> @@ -648,11 +622,7 @@ static void kasan_strings(struct kunit *test)
>          * str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT.
>          * See https://bugzilla.kernel.org/show_bug.cgi?id=206337 for details.
>          */
> -       if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -               kunit_info(test,
> -                       "str* functions are not instrumented with CONFIG_AMD_MEM_ENCRYPT");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);
>
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> @@ -713,10 +683,7 @@ static void kasan_bitops_generic(struct kunit *test)
>         long *bits;
>
>         /* This test is specifically crafted for the generic mode. */
> -       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -               kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_GENERIC);
>
>         /*
>          * Allocate 1 more byte, which causes kzalloc to round up to 16 bytes;
> @@ -744,11 +711,8 @@ static void kasan_bitops_tags(struct kunit *test)
>  {
>         long *bits;
>
> -       /* This test is specifically crafted for the tag-based mode. */
> -       if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -               kunit_info(test, "CONFIG_KASAN_SW_TAGS required\n");
> -               return;
> -       }
> +       /* This test is specifically crafted for tag-based modes. */
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
>
>         /* Allocation size will be rounded to up granule size, which is 16. */
>         bits = kzalloc(sizeof(*bits), GFP_KERNEL);
> @@ -777,10 +741,7 @@ static void vmalloc_oob(struct kunit *test)
>  {
>         void *area;
>
> -       if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> -               kunit_info(test, "CONFIG_KASAN_VMALLOC is not enabled.");
> -               return;
> -       }
> +       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_VMALLOC);
>
>         /*
>          * We have to be careful not to hit the guard page.
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

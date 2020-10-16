Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4FF290C96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393402AbgJPUFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392848AbgJPUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:05:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5991BC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:05:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a200so2097337pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlmEeUtoxILUOsMKYCpMQdn4yPK9pTLKCLX4Si8MjAU=;
        b=t1Dv5NTlDwXbYXAQYRzsrIDZdbB/MF9AsR8YdHhz/45R310IsVYdrtBLl8T8cwKYBj
         3xpXcEeHrSZGYKKYwpFec9j+2FWElN2nVfN3PDcOU2eXRYkgb8pWaAT/OoS/PIrmBz4h
         H1A8YLAK2rrOBydgtSbad0UHF3FNaPaKP9/oopZxRU8nr1FBEcPLUDANhbjKU5JBpRo6
         WtP7MI73Je4UubwwpBP4i2yC1/Q0qaU9MW60IL+1SAHhXqnE3yDAvmJaAIz4fk7UmglV
         Qety6GIbPtUqu0oBJKYfRkw7XGUbILbAAoLFF3t5Ha2mj2lIa6mpBRsb2ihzULbWsfuf
         3UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlmEeUtoxILUOsMKYCpMQdn4yPK9pTLKCLX4Si8MjAU=;
        b=lu+zfx0z7xd5z2/sPK3SLFjhJWvcWDgTkvlcEVEeJ2qkx8gPRbOohNM6Toi6u1Csvn
         /We65xMoIanq0JpmKDLXuSuKQOM9UqVaXb2F3IYvWEu/1GN2xa6zXaj/8nbiiJa2YtUC
         sjobu/VGoTwKHg5ndjEzx4/RTmXEEMC4KhBe1AlVfNtAR2JNicTzW8rc4qnwLaSrbr97
         KnW8mPVzpbxRLF4MtHyjxgMD3WB30zCyGj3aodbO3VWAU8pR+r28iM+ifLwrpIiOiuq8
         VTmPJ5r8JvZjreN+9GFku0d+cCnT58nmkKLtoEoSGrVoKoUD+mfPhGG61KgLfCKHdbH+
         Ow9A==
X-Gm-Message-State: AOAM533rzDfud0uuw5lFgGc0ynRQdUpGEx9cNssULCmlq7WtD2r4ZoHe
        Rt7OLqPGPDRtEsYb13XQmeVr5oFCXE6q++SavwZCpw==
X-Google-Smtp-Source: ABdhPJyY0iL3mCeN7sysfzxRlTqNR6HarRP8wyQNgU5xI+aCw8nzRm4aJgTclvHo+lg1XAtCCJJ/3+T3KQbJJNKH+sw=
X-Received: by 2002:a63:8c42:: with SMTP id q2mr4523721pgn.130.1602878731581;
 Fri, 16 Oct 2020 13:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <44861eaca17ffbb51726473bc8e86ad9e130c67e.1602876780.git.andreyknvl@google.com>
In-Reply-To: <44861eaca17ffbb51726473bc8e86ad9e130c67e.1602876780.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 16 Oct 2020 22:05:20 +0200
Message-ID: <CAAeHK+y=6cGn9OUd7wgB_RZyBDkZSpSBvyf8_c+V_ESz=hA7qw@mail.gmail.com>
Subject: Re: [PATCH] kasan: adopt KUNIT tests to SW_TAGS mode
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        David Gow <davidgow@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 9:33 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Now that we have KASAN-KUNIT tests integration, it's easy to see that
> some KASAN tests are not adopted to the SW_TAGS mode and are failing.
>
> Adjust the allocation size for kasan_memchr() and kasan_memcmp() by
> roung it up to OOB_TAG_OFF so the bad access ends up in a separate
> memory granule.
>
> Add new kmalloc_uaf_16() and kasan_bitops_uaf() tests that rely on UAFs,
> as it's hard to adopt the existing kmalloc_oob_16() and kasan_bitops_oob()
> (rename from kasan_bitops()) without losing the precision.
>
> Disable kasan_global_oob() and kasan_alloca_oob_left/right() as SW_TAGS
> mode doesn't instrument globals nor dynamic allocas.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/test_kasan.c | 144 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 99 insertions(+), 45 deletions(-)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 63c26171a791..3bff25a7fdcc 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -216,6 +216,12 @@ static void kmalloc_oob_16(struct kunit *test)
>                 u64 words[2];
>         } *ptr1, *ptr2;
>
> +       /* This test is specifically crafted for the generic mode. */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
> +               return;
> +       }
> +
>         ptr1 = kmalloc(sizeof(*ptr1) - 3, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>
> @@ -227,6 +233,23 @@ static void kmalloc_oob_16(struct kunit *test)
>         kfree(ptr2);
>  }
>
> +static void kmalloc_uaf_16(struct kunit *test)
> +{
> +       struct {
> +               u64 words[2];
> +       } *ptr1, *ptr2;
> +
> +       ptr1 = kmalloc(sizeof(*ptr1), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
> +
> +       ptr2 = kmalloc(sizeof(*ptr2), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
> +       kfree(ptr2);
> +
> +       KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 = *ptr2);
> +       kfree(ptr1);
> +}
> +
>  static void kmalloc_oob_memset_2(struct kunit *test)
>  {
>         char *ptr;
> @@ -429,6 +452,12 @@ static void kasan_global_oob(struct kunit *test)
>         volatile int i = 3;
>         char *p = &global_array[ARRAY_SIZE(global_array) + i];
>
> +       /* Only generic mode instruments globals. */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               kunit_info(test, "CONFIG_KASAN_GENERIC required");
> +               return;
> +       }
> +
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
>
> @@ -467,6 +496,12 @@ static void kasan_alloca_oob_left(struct kunit *test)
>         char alloca_array[i];
>         char *p = alloca_array - 1;
>
> +       /* Only generic mode instruments dynamic allocas. */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               kunit_info(test, "CONFIG_KASAN_GENERIC required");
> +               return;
> +       }
> +
>         if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
>                 kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
>                 return;
> @@ -481,6 +516,12 @@ static void kasan_alloca_oob_right(struct kunit *test)
>         char alloca_array[i];
>         char *p = alloca_array + i;
>
> +       /* Only generic mode instruments dynamic allocas. */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               kunit_info(test, "CONFIG_KASAN_GENERIC required");
> +               return;
> +       }
> +
>         if (!IS_ENABLED(CONFIG_KASAN_STACK)) {
>                 kunit_info(test, "CONFIG_KASAN_STACK is not enabled");
>                 return;
> @@ -551,6 +592,9 @@ static void kasan_memchr(struct kunit *test)
>                 return;
>         }
>
> +       if (OOB_TAG_OFF)
> +               size = round_up(size, OOB_TAG_OFF);
> +
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> @@ -573,6 +617,9 @@ static void kasan_memcmp(struct kunit *test)
>                 return;
>         }
>
> +       if (OOB_TAG_OFF)
> +               size = round_up(size, OOB_TAG_OFF);
> +
>         ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>         memset(arr, 0, sizeof(arr));
> @@ -619,13 +666,50 @@ static void kasan_strings(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strnlen(ptr, 1));
>  }
>
> -static void kasan_bitops(struct kunit *test)
> +static void kasan_bitops_modify(struct kunit *test, int nr, void *addr)
> +{
> +       KUNIT_EXPECT_KASAN_FAIL(test, set_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, __set_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, clear_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, clear_bit_unlock(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit_unlock(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, change_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, __change_bit(nr, addr));
> +}
> +
> +static void kasan_bitops_test_and_modify(struct kunit *test, int nr, void *addr)
>  {
> +       KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, __test_and_set_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, test_and_clear_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, __test_and_clear_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, test_and_change_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, __test_and_change_bit(nr, addr));
> +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = test_bit(nr, addr));
> +
> +#if defined(clear_bit_unlock_is_negative_byte)
> +       KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =
> +                               clear_bit_unlock_is_negative_byte(nr, addr));
> +#endif
> +}
> +
> +static void kasan_bitops_oob(struct kunit *test)
> +{
> +       long *bits;
> +
> +       /* This test is specifically crafted for the generic mode. */
> +       if (!IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> +               kunit_info(test, "CONFIG_KASAN_GENERIC required\n");
> +               return;
> +       }
> +
>         /*
>          * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
>          * this way we do not actually corrupt other memory.
>          */
> -       long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
> +       bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
>
>         /*
> @@ -633,56 +717,24 @@ static void kasan_bitops(struct kunit *test)
>          * below accesses are still out-of-bounds, since bitops are defined to
>          * operate on the whole long the bit is in.
>          */
> -       KUNIT_EXPECT_KASAN_FAIL(test, set_bit(BITS_PER_LONG, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, __set_bit(BITS_PER_LONG, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, clear_bit(BITS_PER_LONG, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit(BITS_PER_LONG, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, clear_bit_unlock(BITS_PER_LONG, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, __clear_bit_unlock(BITS_PER_LONG, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, change_bit(BITS_PER_LONG, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test, __change_bit(BITS_PER_LONG, bits));
> +       kasan_bitops_modify(test, BITS_PER_LONG, bits);
>
>         /*
>          * Below calls try to access bit beyond allocated memory.
>          */
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               __test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
> +       kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, bits);
>
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               __test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
> -
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               __test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
> +       kfree(bits);
> +}
>
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               kasan_int_result =
> -                       test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits));
> +static void kasan_bitops_uaf(struct kunit *test)
> +{
> +       long *bits = kzalloc(sizeof(*bits), GFP_KERNEL);
>
> -#if defined(clear_bit_unlock_is_negative_byte)
> -       KUNIT_EXPECT_KASAN_FAIL(test,
> -               kasan_int_result = clear_bit_unlock_is_negative_byte(
> -                       BITS_PER_LONG + BITS_PER_BYTE, bits));
> -#endif
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
>         kfree(bits);
> +       kasan_bitops_modify(test, BITS_PER_LONG, bits);
> +       kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, bits);
>  }

This actually ends up modifying the data in a freed object, which
isn't a good idea. I'll change this to do an OOB too, but for the
tag-based mode.

>
>  static void kmalloc_double_kzfree(struct kunit *test)
> @@ -728,6 +780,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kmalloc_oob_krealloc_more),
>         KUNIT_CASE(kmalloc_oob_krealloc_less),
>         KUNIT_CASE(kmalloc_oob_16),
> +       KUNIT_CASE(kmalloc_uaf_16),
>         KUNIT_CASE(kmalloc_oob_in_memset),
>         KUNIT_CASE(kmalloc_oob_memset_2),
>         KUNIT_CASE(kmalloc_oob_memset_4),
> @@ -751,7 +804,8 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kasan_memchr),
>         KUNIT_CASE(kasan_memcmp),
>         KUNIT_CASE(kasan_strings),
> -       KUNIT_CASE(kasan_bitops),
> +       KUNIT_CASE(kasan_bitops_oob),
> +       KUNIT_CASE(kasan_bitops_uaf),
>         KUNIT_CASE(kmalloc_double_kzfree),
>         KUNIT_CASE(vmalloc_oob),
>         {}
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24C52F4FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbhAMQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbhAMQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:27:51 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F71C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:27:10 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d8so2431871otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToZseukMUfS4/Mno4fjs/e3BlupSLArbp20G4eoQPpc=;
        b=k902rbsbnxoc+Bj5N0U5Acwa809QXnhgEHkNURHH3wpV0km+RTurtwNORXWGgNzMhD
         oODhyAMjS70nopnlr2Uxp6jRWJaFmu2fj84kolLW2SFhwDlCMky3rqIht5Ea7DBHL2Z0
         oVhG7ZDhy+W6GcQujNmDd9BbTbBiKcQurznSA636KA+VdMGOjbTnY0aQAEqYX1AaCgUG
         sCFy3z6u7aWY09M8BcMvMHovX59JbFjCUCP+sqOQirQCBX1qTJlnJ1Z4xTb4czvxMoE2
         R8loMXO6IAkNWPyWwNYdifcUIO//KEIlNpUXHlkvXpozxPoozPLzRZI+fiPClmWYT/Xm
         ihGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToZseukMUfS4/Mno4fjs/e3BlupSLArbp20G4eoQPpc=;
        b=Vf4kWff/dt60llyk14u12+5cSAuCg8WR7FWEjfbcyrTGmrvoPUXFoEO1LTyiw5MbGl
         dejikjK2ycxSNmHe2+EdKAn/StiVko9uWmBrM8fbEjhQAAOKeCKM6Vzkv4nu2uV1MeSx
         oniSQNhiQhaOQzqyKUGUq5V+mA3M8z9smCgoMz8Q8SDRzBXaYxtbW0jOVjCFtv/xs6VX
         vYKL6V/OSsRscdJO3b4sLfwVr9wZPMn3b3zOdzaHgJrC/VgF2QPs7MzJX51Ov0WL/JtJ
         3EMUmgIQdf86aLoylFPWo6Dk/9GCUC1Jc8/4YMBrmyfONZoqRhc9Zt/8javSwxZCV3kP
         9/bg==
X-Gm-Message-State: AOAM53157erm5u/QnI9+lZFy2efzTXe0Om1QFhL7/1EfPnjVH4yRBQqo
        Ah5hVx8XdgceIieAbAls1lHMcO7Y4VSL1dkQ+Jzg2Q==
X-Google-Smtp-Source: ABdhPJw0Qd7K/zT8zJ06tvDTzutjwuFCqmusr6CvuuRdVbsyHJZR2KOJ/cChg024Rs9ADuW9aH8veLV6EytfRwXLSao=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr1826937ots.251.1610555230134;
 Wed, 13 Jan 2021 08:27:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com> <351f554b6e4c4c0581d15d7b70cbbacf238c887f.1610554432.git.andreyknvl@google.com>
In-Reply-To: <351f554b6e4c4c0581d15d7b70cbbacf238c887f.1610554432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 13 Jan 2021 17:26:58 +0100
Message-ID: <CANpmjNP-r3CcgCnenJEbHB5_RNfnFDF7x=4uufLVbqRZtqGd7g@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] kasan: add match-all tag tests
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
> Add 3 new tests for tag-based KASAN modes:
>
> 1. Check that match-all pointer tag is not assigned randomly.
> 2. Check that 0xff works as a match-all pointer tag.
> 3. Check that there are no match-all memory tags.
>
> Note, that test #3 causes a significant number (255) of KASAN reports
> to be printed during execution for the SW_TAGS mode.
>
> Link: https://linux-review.googlesource.com/id/I78f1375efafa162b37f3abcb2c5bc2f3955dfd8e
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/kasan/kasan.h |  6 ++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 714ea27fcc3e..f5470bed50b6 100644
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
> @@ -754,6 +755,94 @@ static void vmalloc_oob(struct kunit *test)
>         vfree(area);
>  }
>
> +/*
> + * Check that the assigned pointer tag falls within the [KASAN_TAG_MIN,
> + * KASAN_TAG_KERNEL) range (note: excluding the match-all tag) for tag-based
> + * modes.
> + */
> +static void match_all_not_assigned(struct kunit *test)
> +{
> +       char *ptr;
> +       struct page *pages;
> +       int i, size, order;
> +
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
> +
> +       for (i = 0; i < 256; i++) {
> +               size = get_random_int() % 1024;
> +               ptr = kmalloc(size, GFP_KERNEL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
> +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +               kfree(ptr);
> +       }
> +
> +       for (i = 0; i < 256; i++) {
> +               order = get_random_int() % 4;
> +               pages = alloc_pages(GFP_KERNEL, order);
> +               ptr = page_address(pages);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +               KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
> +               KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +               free_pages((unsigned long)ptr, order);
> +       }
> +}
> +
> +/* Check that 0xff works as a match-all pointer tag for tag-based modes. */
> +static void match_all_ptr_tag(struct kunit *test)
> +{
> +       char *ptr;
> +       u8 tag;
> +
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
> +
> +       ptr = kmalloc(128, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
> +       /* Backup the assigned tag. */
> +       tag = get_tag(ptr);
> +       KUNIT_EXPECT_NE(test, tag, (u8)KASAN_TAG_KERNEL);
> +
> +       /* Reset the tag to 0xff.*/
> +       ptr = set_tag(ptr, KASAN_TAG_KERNEL);
> +
> +       /* This access shouldn't trigger a KASAN report. */
> +       *ptr = 0;
> +
> +       /* Recover the pointer tag and free. */
> +       ptr = set_tag(ptr, tag);
> +       kfree(ptr);
> +}
> +
> +/* Check that there are no match-all memory tags for tag-based modes. */
> +static void match_all_mem_tag(struct kunit *test)
> +{
> +       char *ptr;
> +       int tag;
> +
> +       KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_GENERIC);
> +
> +       ptr = kmalloc(128, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +       KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> +
> +       /* For each possible tag value not matching the pointer tag. */
> +       for (tag = KASAN_TAG_MIN; tag <= KASAN_TAG_KERNEL; tag++) {
> +               if (tag == get_tag(ptr))
> +                       continue;
> +
> +               /* Mark the first memory granule with the chosen memory tag. */
> +               kasan_poison(ptr, KASAN_GRANULE_SIZE, (u8)tag);
> +
> +               /* This access must cause a KASAN report. */
> +               KUNIT_EXPECT_KASAN_FAIL(test, *ptr = 0);
> +       }
> +
> +       /* Recover the memory tag and free. */
> +       kasan_poison(ptr, KASAN_GRANULE_SIZE, get_tag(ptr));
> +       kfree(ptr);
> +}
> +
>  static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kmalloc_oob_right),
>         KUNIT_CASE(kmalloc_oob_left),
> @@ -793,6 +882,9 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>         KUNIT_CASE(kasan_bitops_tags),
>         KUNIT_CASE(kmalloc_double_kzfree),
>         KUNIT_CASE(vmalloc_oob),
> +       KUNIT_CASE(match_all_not_assigned),
> +       KUNIT_CASE(match_all_ptr_tag),
> +       KUNIT_CASE(match_all_mem_tag),
>         {}
>  };
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3b38baddec47..c3fb9bf241d3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -36,6 +36,12 @@ extern bool kasan_flag_panic __ro_after_init;
>  #define KASAN_TAG_INVALID      0xFE /* inaccessible memory tag */
>  #define KASAN_TAG_MAX          0xFD /* maximum value for random tags */
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +#define KASAN_TAG_MIN          0xF0 /* mimimum value for random tags */
> +#else
> +#define KASAN_TAG_MIN          0x00 /* mimimum value for random tags */
> +#endif
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  #define KASAN_FREE_PAGE         0xFF  /* page was freed */
>  #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

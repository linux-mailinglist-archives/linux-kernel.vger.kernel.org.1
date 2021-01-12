Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0222F3834
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406599AbhALSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406232AbhALSMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:12:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B849BC061346
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:22 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id p12so2099040pju.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHIuhecZMVyLx+ijiJ0VpXni4YAkn1lcKgd4j/76ieY=;
        b=k2Vk8XGGSMMmBHOZkQLIepIkeJh9g/D70p+FHo+OHkfPbacQXAS+kNhV+TcvtwgXXd
         PM+RAmMzbz1oe/87tSXng5aOoHrrki42p+cBRISOY3VXssTYJmj07k3fnuhfrW31R9h4
         7MY2/JbOSeYBtt/UTJkQnClF1JOM1KHWzi1u5+62w7HV2jap/gv17wJx5T1w66Tpy1Nj
         07wPdf71lUGorXIGIbJvkBD9yVdSsd8Dkps9kSZYGxa+0CBCdaQmVRCb6fnYYg0nHnHE
         J2NQRCbz3pQg7RjrNlr5l5FDhnHkaJaCtzzv587CXvAS5hN+SoxsJXVbiZkdjnw1Qd6o
         H9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHIuhecZMVyLx+ijiJ0VpXni4YAkn1lcKgd4j/76ieY=;
        b=Xwk1HXc+OI0ZeF1Je5OZuCQ7VyekG+WlstjpC3GGP2dJr9L9C1ulyv1gsEkMrmi0nu
         l+Z5dogzo6a2QGD5/DWWbkeZj9V9XOBEUn98LIb/eKQZH33w1x2a5zKeXG0AG0piwHYZ
         UQejtO8bRzW5DK4LmQ4BafqbwTEwXt0W+xI9hNbCeo+zl9ChEQma1VdBXtPOgqTsK9TY
         TWuY3Cwqr1/MVNGkgwAJFCJhAMMFNS3epujG6fzPUeTjfS9XcujOeCFsuM7fusSCIj7Y
         lHg/x8f5EcSz2M2VvbezvWwmd/rW984WAnFfEJALwzIpc2gG1LrZTrvoaJF0Xh3sXV5B
         0dvw==
X-Gm-Message-State: AOAM533P0JUIU38Ntzyldeyu6ZAX2e14F8+F2QA52fq97evThszbn/e4
        l3qUHHFW88RhTUhC2gKGaHsX7FaCqphLRVHTBfNNVA==
X-Google-Smtp-Source: ABdhPJwJ1FMdhW0jHz7DXfH+KVJFXvSxTzvgklCFyexaWLl69lIesWnNkxlOzw22YhI7Gz8v20BzA4cyotU5Kzyzvb4=
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr343606pjb.41.1610475082106;
 Tue, 12 Jan 2021 10:11:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <0f20f867d747b678604a68173a5f20fb8df9b756.1609871239.git.andreyknvl@google.com>
 <X/2hboi2Tp87UZFZ@elver.google.com>
In-Reply-To: <X/2hboi2Tp87UZFZ@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 19:11:10 +0100
Message-ID: <CAAeHK+xW+4m140OKa4QG_x1Y-74xnMoxhzpSRszUdm9ZyAkMbA@mail.gmail.com>
Subject: Re: [PATCH 04/11] kasan: add match-all tag tests
To:     Marco Elver <elver@google.com>
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
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 2:17 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> > Add 3 new tests for tag-based KASAN modes:
> >
> > 1. Check that match-all pointer tag is not assigned randomly.
> > 2. Check that 0xff works as a match-all pointer tag.
> > 3. Check that there are no match-all memory tags.
> >
> > Note, that test #3 causes a significant number (255) of KASAN reports
> > to be printed during execution for the SW_TAGS mode.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I78f1375efafa162b37f3abcb2c5bc2f3955dfd8e
> > ---
> >  lib/test_kasan.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/kasan/kasan.h |  6 ++++
> >  2 files changed, 99 insertions(+)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index 46e578c8e842..f1eda0bcc780 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/mman.h>
> >  #include <linux/module.h>
> >  #include <linux/printk.h>
> > +#include <linux/random.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/uaccess.h>
> > @@ -790,6 +791,95 @@ static void vmalloc_oob(struct kunit *test)
> >       vfree(area);
> >  }
> >
> > +/*
> > + * Check that match-all pointer tag is not assigned randomly for
> > + * tag-based modes.
> > + */
> > +static void match_all_not_assigned(struct kunit *test)
> > +{
> > +     char *ptr;
> > +     struct page *pages;
> > +     int i, size, order;
> > +
> > +     for (i = 0; i < 256; i++) {
> > +             size = get_random_int() % KMALLOC_MAX_SIZE;
>
> size appears to be unused?

Indeed, will fix in v2, thanks!

>
> > +             ptr = kmalloc(128, GFP_KERNEL);
> > +             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +             KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> > +             kfree(ptr);
> > +     }
> > +
> > +     for (i = 0; i < 256; i++) {
> > +             order = get_random_int() % 4;
> > +             pages = alloc_pages(GFP_KERNEL, order);
> > +             ptr = page_address(pages);
> > +             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +             KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> > +             free_pages((unsigned long)ptr, order);
> > +     }
> > +}
> > +
> > +/* Check that 0xff works as a match-all pointer tag for tag-based modes. */
> > +static void match_all_ptr_tag(struct kunit *test)
> > +{
> > +     char *ptr;
> > +     u8 tag;
> > +
> > +     if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> > +             kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
> > +             return;
> > +     }
> > +
> > +     ptr = kmalloc(128, GFP_KERNEL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +
> > +     /* Backup the assigned tag. */
> > +     tag = get_tag(ptr);
> > +     KUNIT_EXPECT_NE(test, tag, (u8)KASAN_TAG_KERNEL);
> > +
> > +     /* Reset the tag to 0xff.*/
> > +     ptr = set_tag(ptr, KASAN_TAG_KERNEL);
> > +
> > +     /* This access shouldn't trigger a KASAN report. */
> > +     *ptr = 0;
> > +
> > +     /* Recover the pointer tag and free. */
> > +     ptr = set_tag(ptr, tag);
> > +     kfree(ptr);
> > +}
> > +
> > +/* Check that there are no match-all memory tags for tag-based modes. */
> > +static void match_all_mem_tag(struct kunit *test)
> > +{
> > +     char *ptr;
> > +     int tag;
> > +
> > +     if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> > +             kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
> > +             return;
> > +     }
> > +
> > +     ptr = kmalloc(128, GFP_KERNEL);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> > +     KUNIT_EXPECT_NE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
> > +
> > +     /* For each possible tag value not matching the pointer tag. */
> > +     for (tag = KASAN_TAG_MIN; tag <= KASAN_TAG_KERNEL; tag++) {
> > +             if (tag == get_tag(ptr))
> > +                     continue;
> > +
> > +             /* Mark the first memory granule with the chosen memory tag. */
> > +             kasan_poison(ptr, KASAN_GRANULE_SIZE, (u8)tag);
> > +
> > +             /* This access must cause a KASAN report. */
> > +             KUNIT_EXPECT_KASAN_FAIL(test, *ptr = 0);
> > +     }
> > +
> > +     /* Recover the memory tag and free. */
> > +     kasan_poison(ptr, KASAN_GRANULE_SIZE, get_tag(ptr));
> > +     kfree(ptr);
> > +}
> > +
> >  static struct kunit_case kasan_kunit_test_cases[] = {
> >       KUNIT_CASE(kmalloc_oob_right),
> >       KUNIT_CASE(kmalloc_oob_left),
> > @@ -829,6 +919,9 @@ static struct kunit_case kasan_kunit_test_cases[] = {
> >       KUNIT_CASE(kasan_bitops_tags),
> >       KUNIT_CASE(kmalloc_double_kzfree),
> >       KUNIT_CASE(vmalloc_oob),
> > +     KUNIT_CASE(match_all_not_assigned),
> > +     KUNIT_CASE(match_all_ptr_tag),
> > +     KUNIT_CASE(match_all_mem_tag),
> >       {}
> >  };
> >
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index 3b38baddec47..c3fb9bf241d3 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -36,6 +36,12 @@ extern bool kasan_flag_panic __ro_after_init;
> >  #define KASAN_TAG_INVALID    0xFE /* inaccessible memory tag */
> >  #define KASAN_TAG_MAX                0xFD /* maximum value for random tags */
> >
> > +#ifdef CONFIG_KASAN_HW_TAGS
> > +#define KASAN_TAG_MIN                0xF0 /* mimimum value for random tags */
> > +#else
> > +#define KASAN_TAG_MIN                0x00 /* mimimum value for random tags */
> > +#endif
> > +
> >  #ifdef CONFIG_KASAN_GENERIC
> >  #define KASAN_FREE_PAGE         0xFF  /* page was freed */
> >  #define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
> > --
> > 2.29.2.729.g45daf8777d-goog
> >

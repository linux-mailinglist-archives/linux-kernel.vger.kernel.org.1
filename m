Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F552F37FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbhALSLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhALSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:11:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F9DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m5so2197941pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5gCy8U+Pj2XIzaMO6G08RY3MnWe8pOVDCWwBl512KM=;
        b=JM8ZOsGVvKGolIXNKKqJXO4fSUXqRXcDqfKUHqakGtuZlVqbFpX/kvF7gXEJLioRm6
         bkdxnwLdyc4LxUR53ZvnExAvqFRisvdkSmMAGLPw5oZxobOeozsNcYrLaE+9RLHP8ABg
         corlflIjxXBJtTxmlBd51pOmCgGDIJEiFmGvCHFxP8UONRghM0oCn8VZocKn2hrgGz7W
         qDngkPPCI6eetFRRsXcf48CHulOrr6lr0YJX2NxKhboyY+VHoMe6vt10G5v32VqWzhNv
         ybIJA2gIh/uFwwh6wNSwsuzxNvtf72dnav6Bk8DWl74kmEHjJaDB7vrOhl66O0JnTZ0C
         naXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5gCy8U+Pj2XIzaMO6G08RY3MnWe8pOVDCWwBl512KM=;
        b=DN4fC6sm/Xnut7DVnIkVz74y26ikD/nUO7tWCm/Gf6LFEZsM2MJB5h8mtGtJPd7JUN
         7s08CvIU0BIfiXPSphe0wVyBWoZkFBkUh4OQxYcomjLrtH1wsh27d4LmdOnVceMQtCHC
         vP/d8BqXSCx57SypSwlSDy5Im0gAxKEn1OKE9bGtrfNhkGRqxqFSFafUfKW7swr6933N
         89+W0jwP2eikmatS/do8bMCLzb8ThhQwTJYLg2RQ3LEttz71ls+1R6hBIYhPeffiJHKB
         Ca4DQ5OOVREmsGt4Ae9U2wX3Xb2pw7RjatoT/fw89QSYEKR7KgKf8wFdbwd9Tu+MG3/5
         QJCw==
X-Gm-Message-State: AOAM530otyvY+DUfLYLxLz1ryRVxgApnRZpjygl7Q/buottUJ18/3Pj7
        HRdoGfTEQsCQdB2SfTde0Vw/Pl5jkS8dY+FY4AbIYQ==
X-Google-Smtp-Source: ABdhPJxzA1kproFmWSJpV4LbwVmJvr7ytGhhiBUePjWacRL/+tb3Ft5R9ssk9pZnQ1ncNtMgQnnwHf6RLWbxxIcjmdE=
X-Received: by 2002:a17:902:c144:b029:dc:292e:a8a1 with SMTP id
 4-20020a170902c144b02900dc292ea8a1mr376024plj.13.1610475020053; Tue, 12 Jan
 2021 10:10:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <0f20f867d747b678604a68173a5f20fb8df9b756.1609871239.git.andreyknvl@google.com>
 <CAG_fn=WX5rGMHKPrDVCUoTNFwygW9AP7QrVwrco1R70sZ6MqQA@mail.gmail.com>
In-Reply-To: <CAG_fn=WX5rGMHKPrDVCUoTNFwygW9AP7QrVwrco1R70sZ6MqQA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 19:10:09 +0100
Message-ID: <CAAeHK+yJ4SsbxEyYj8+bucUNb1wSFwrLgUuLJ09mOyGw04NF0Q@mail.gmail.com>
Subject: Re: [PATCH 04/11] kasan: add match-all tag tests
To:     Alexander Potapenko <glider@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
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

On Tue, Jan 12, 2021 at 9:05 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
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
> >         vfree(area);
> >  }
> >
> > +/*
> > + * Check that match-all pointer tag is not assigned randomly for
> > + * tag-based modes.
> > + */
> > +static void match_all_not_assigned(struct kunit *test)
> > +{
>
> Do we want to run this test in non-tag-based modes? Probably not?

Will fix in v2, thanks!

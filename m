Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48A2F4B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbhAMMbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbhAMMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:31:14 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D632C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:30:34 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z20so952376qtq.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHb853OW+nOYLu/IE6QCDFLb71LosLe9lCUBT46DGFo=;
        b=A4DDeU2VTnUM/WugpeuuSLcq9DsDKZjW0otZi4DeSSn3tJzX8FHHFbhlUurXyQRR4p
         PiIgYMuNq97TrI5EQsmI1BzT66qkEfU5AuW1i02BlbKZ44VFVxHmLB9rjtDfH7/RK9OJ
         FS3SOC1fw1P/VWiCX6FK2U1QqrbCQVIGSgqu/KDe+h5MaJ7GTRNQZ+1+0I9k4t6+LOBl
         PNDRukfZWdk3Ue13Ow6DENqwIhn7TeIkUR0nTSBygPjK6T4TFDqPsVlTpMDWXvjkR9IM
         /Dsn21BJ3wSZnwOAW9hc1ZXARRdSKj9vniM1aNMeir7rOy4EIsqw3ss75pR+mlAQMC5p
         K6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHb853OW+nOYLu/IE6QCDFLb71LosLe9lCUBT46DGFo=;
        b=TWm1DDAzi5vGtx23Uy82NuNNva1k5oGK6lxPc6aH2Xz65nWDBu1p6Le3rYrNvDnCEj
         uzy2NQXYZvr0Hn6ZtnjkoE+hIte+NChB0P3CpMMs1O2IPAwgVerdH/7RoM1oQMlzkbAB
         lOGAmOjkL5InEl5bsYvu/l1MOMTMTt3aylG1NC5qULKVaASUNycRX37F+h8X5WZho+yD
         4VMVfgQSYxxIIFtFcDx2ch74yQdt4TPV/aj6kF6Cv4J97RUNpXii/jcMxTQITnqDsJX4
         mx3gWGTE6bTOljVhJQab/L5JnyAS1d0NXYK0oTbUh9xVnvWehut3y/PtHwTXRsvnHXtD
         1MUg==
X-Gm-Message-State: AOAM532Z8kBibH3v1/jKuZpAefNQYRSUPP8NG0E54ox6YhfFYaI6Sh4L
        V+1huHl3okcWFf9UdwaM784IW5/qlfev3QZzT2EfPQ==
X-Google-Smtp-Source: ABdhPJzKGyNdIflFErZkBaYeIIgatGIdJmqQZ/ahgW1INpCbqgO3B6lUZSe/Ve2mjALp83/bCAe0T/tIFtiJL5pfZGs=
X-Received: by 2002:ac8:6f32:: with SMTP id i18mr1908368qtv.175.1610541033304;
 Wed, 13 Jan 2021 04:30:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <0c51a7266ea851797dc9816405fc40d860a48db1.1609871239.git.andreyknvl@google.com>
 <CAG_fn=VXe2AZZ3q6+HoV+zB=9GLP+kgyW_r9hfqvX-NJHurTRg@mail.gmail.com> <CAAeHK+xbYpuipd3+Jew7=fL8Mn2J1ZzOVyzK+X6bvtLCeiGFuw@mail.gmail.com>
In-Reply-To: <CAAeHK+xbYpuipd3+Jew7=fL8Mn2J1ZzOVyzK+X6bvtLCeiGFuw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 13 Jan 2021 13:30:22 +0100
Message-ID: <CAG_fn=XfNb_tuUiGDhRAyihTQhW8RQ8zVjT+gXM_Efhw0cBg6Q@mail.gmail.com>
Subject: Re: [PATCH 09/11] kasan: fix memory corruption in kasan_bitops_tags test
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Jan 12, 2021 at 9:07 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, Jan 12, 2021 at 9:30 AM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > Since the hardware tag-based KASAN mode might not have a redzone that
> > > comes after an allocated object (when kasan.mode=prod is enabled), the
> > > kasan_bitops_tags() test ends up corrupting the next object in memory.
> > >
> > > Change the test so it always accesses the redzone that lies within the
> > > allocated object's boundaries.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Link: https://linux-review.googlesource.com/id/I67f51d1ee48f0a8d0fe2658c2a39e4879fe0832a
Reviewed-by: Alexander Potapenko <glider@google.com>

> > > ---
> > >  lib/test_kasan.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > index b67da7f6e17f..3ea52da52714 100644
> > > --- a/lib/test_kasan.c
> > > +++ b/lib/test_kasan.c
> > > @@ -771,17 +771,17 @@ static void kasan_bitops_tags(struct kunit *test)
> > >
> > >         /* This test is specifically crafted for the tag-based mode. */
> > >         if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> > > -               kunit_info(test, "skipping, CONFIG_KASAN_SW_TAGS required");
> > > +               kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
> > >                 return;
> > >         }
> > >
> > > -       /* Allocation size will be rounded to up granule size, which is 16. */
> > > -       bits = kzalloc(sizeof(*bits), GFP_KERNEL);
> > > +       /* kmalloc-64 cache will be used and the last 16 bytes will be the redzone. */
> > > +       bits = kzalloc(48, GFP_KERNEL);
> >
> > I think it might make sense to call ksize() here to ensure we have
> > these spare bytes.
>
> Calling ksize() will unpoison the whole object.

Ah, that's right.

> I think it's OK to make assumptions about KASAN internals in tests. I
> would actually say that we need more tests that check such internal
> properties.

Agreed.

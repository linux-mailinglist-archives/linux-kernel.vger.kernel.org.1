Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA792F3CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437278AbhALVeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436671AbhALUHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:07:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2209C061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:07:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p12so2290942pju.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMt208i988Aj1RV+YWcUlsqzon7o0ifo6LZ2mK0qEq0=;
        b=hp5afakNd2d/FQoQpixyj3+dET0KAs/17uAZVG2pt5rAFbU6WZBkW/T0x4f5Gwu0rF
         zVN+Ck9CcaN4f7yG+3ctQS1OCckqVyxGKNe/NL+mMblv6IdAJ8EYWnioEfhdVoJrb+zg
         jwPFQR87TwuAPE1J9s9t0JSpwYAvlQE2Z96giLtFUHgqvklZhu3buAnwiINDF6nAqy8r
         maxUiS6HPd87hiGmj9YyUz23qOlrjdNH/0Ab6y/uGq26aFj4vzS8skOfh5jOLRldoHgs
         LlDnU/6XEb0LNfs1eKaW9Uj+CGSFM951EH0Qm87MTYfrhqsoTYwXrz1HwydVZqVKVWEG
         D8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMt208i988Aj1RV+YWcUlsqzon7o0ifo6LZ2mK0qEq0=;
        b=fhUG+CMaTaw/cBsQ992VKjW7qZLSgeG06MQR7n7MUkpBX/fFNG0wYTcHO9zQsJCs6f
         f939oGeoTRkbrm7V5jxPY1tC5MI9AhbJcAVnt5mS19gPZ5VWzHPBkaLjFoO60JUD3Gza
         DxCege2zrNmrv5R1ZKcjHUUB7NvsCkz+ZUs2zVUf0BFpnuZE9Ct2stKyMkL/rK3XTG/I
         LOS091TQourXAfEgbhyISsNAW/on4Xs+u2r7pycqtahB2H7mYG/vzGFKJC4/yGGiCGKF
         AB1/CV7KxL1X2zPKpn1CJaCSBOe8jTEmfZ9ICapGule35xTXRufOtahIS/eG8lvMKYOE
         sr5g==
X-Gm-Message-State: AOAM531uQPe6apVzHUNkdtc7D9t6iR594WjuKIUzj71Ag4YEffQB/RSa
        Ka/m/GRkROqOVmQ+FMj95SzDY7ZItz4CXSSKR/pf+A==
X-Google-Smtp-Source: ABdhPJxmSGRHqWdnI3a/eD2Zk4MKrqBKhIill+QCO1/HJbdNIc7ksRdpTMI9qx1p9hVBDBv9KOHd7j1iLC0/AYVSsNE=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr844230pjb.166.1610482027266;
 Tue, 12 Jan 2021 12:07:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <0c51a7266ea851797dc9816405fc40d860a48db1.1609871239.git.andreyknvl@google.com>
 <CAG_fn=VXe2AZZ3q6+HoV+zB=9GLP+kgyW_r9hfqvX-NJHurTRg@mail.gmail.com>
In-Reply-To: <CAG_fn=VXe2AZZ3q6+HoV+zB=9GLP+kgyW_r9hfqvX-NJHurTRg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 21:06:56 +0100
Message-ID: <CAAeHK+xbYpuipd3+Jew7=fL8Mn2J1ZzOVyzK+X6bvtLCeiGFuw@mail.gmail.com>
Subject: Re: [PATCH 09/11] kasan: fix memory corruption in kasan_bitops_tags test
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

On Tue, Jan 12, 2021 at 9:30 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Tue, Jan 5, 2021 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Since the hardware tag-based KASAN mode might not have a redzone that
> > comes after an allocated object (when kasan.mode=prod is enabled), the
> > kasan_bitops_tags() test ends up corrupting the next object in memory.
> >
> > Change the test so it always accesses the redzone that lies within the
> > allocated object's boundaries.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I67f51d1ee48f0a8d0fe2658c2a39e4879fe0832a
> > ---
> >  lib/test_kasan.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index b67da7f6e17f..3ea52da52714 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -771,17 +771,17 @@ static void kasan_bitops_tags(struct kunit *test)
> >
> >         /* This test is specifically crafted for the tag-based mode. */
> >         if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> > -               kunit_info(test, "skipping, CONFIG_KASAN_SW_TAGS required");
> > +               kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
> >                 return;
> >         }
> >
> > -       /* Allocation size will be rounded to up granule size, which is 16. */
> > -       bits = kzalloc(sizeof(*bits), GFP_KERNEL);
> > +       /* kmalloc-64 cache will be used and the last 16 bytes will be the redzone. */
> > +       bits = kzalloc(48, GFP_KERNEL);
>
> I think it might make sense to call ksize() here to ensure we have
> these spare bytes.

Calling ksize() will unpoison the whole object.

I think it's OK to make assumptions about KASAN internals in tests. I
would actually say that we need more tests that check such internal
properties.

Thanks!

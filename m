Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24D12F3CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437241AbhALVeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436636AbhALUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:06:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D020C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:05:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y12so2305221pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zL6WgU5Xs4gBKlOeTyyYJxfsUDm2s7KXGqsTMwbacGQ=;
        b=wPsXp3Ms+9EG1G2s8Vph8Xwk1B8VZYND0uude8zcWLUg4+owazggV+vpjAf+tzTgdC
         W8z3dx3wqpnqzj+clMUqZ5w32P12JqYLB7GGqKQS20jYZUYXLbBPX+nWFcoS+ytaCgfa
         ps9VzSsZn4MKGUaHATXr6ILJ1S41IjhM9JP1Z6sZj2SmTTb1Y0zl640U45qm+Bo5Hu4M
         U/ysBYw5lPnASZUCeG4IppqXWhMinJNkXvYVH8dIrQQBUgOFXvVB1SFZuyquAdrPSXXZ
         IIXjjQrJrG1GtenX2Ohzzx4r5y0UQTJQV50f04e+n/urAEsIXZxxDOldEga5JSxuu6WB
         U+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zL6WgU5Xs4gBKlOeTyyYJxfsUDm2s7KXGqsTMwbacGQ=;
        b=BRwt+hZyOfyme2uRY+3m+Zl9zGLUi0Dq5Hw2AFu3mH6VuWNNf+G159BizyCS0XZ8Oq
         nXzbtp2W1xleMS7Z9a2jY7k4+xOIREFbzX9Ohb6ZGmr6DibbioAtLFVPeLxAkyuF1o/+
         7o3ZiY7ZdIMquPaHhR5eN5PWIYL2k5TwX7dEL9Z18EksuRx6ZgmNnSo9ocE5t6CzACht
         Cg5DYsCSyV6IYNa4nhDn8kIKwfa9l7Ypz6k3NCuFEgkz1Y5opuw+CYmeM7UKAqH0HMM/
         XaqcPolBoeDld8Df/awUlLXo0rKF4QlZpUZEg/wOe8RtMnPnkzf9wP9mXCyBMFtYpnK1
         tILQ==
X-Gm-Message-State: AOAM531sbW5b+6Etqymg1NhnLBpQUCcyFlMwUhO2grV5K904SfEe07kJ
        qm/Mq2KE9hMETxjveOIl7oMXWceGAw9SMySpQRy7gQ==
X-Google-Smtp-Source: ABdhPJwYQTFzqikue18gpW9umL0WcFvbyoNK1QEUuE6kEZf85DaGVaLKgmWEvox10SpVBdo9Ni4n/BW0mjJiejzq8OY=
X-Received: by 2002:a17:90b:1087:: with SMTP id gj7mr814111pjb.41.1610481928938;
 Tue, 12 Jan 2021 12:05:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com> <9a4f47fe8717b4b249591b307cdd1f26c46dcb82.1609871239.git.andreyknvl@google.com>
 <X/2md4h0Nki8RNW0@elver.google.com>
In-Reply-To: <X/2md4h0Nki8RNW0@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 12 Jan 2021 21:05:18 +0100
Message-ID: <CAAeHK+w0_WmVZ9kh1QM4vmn3-0oBeWWV3BaLj2+-uh0xj8_BnA@mail.gmail.com>
Subject: Re: [PATCH 08/11] kasan: adopt kmalloc_uaf2 test to HW_TAGS mode
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

On Tue, Jan 12, 2021 at 2:39 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> > In the kmalloc_uaf2() test, the pointers to the two allocated memory
> > blocks might be the same, and the test will fail. With the software
> > tag-based mode, the probability of the that happening is 1/254, so it's
> > hard to observe the failure. For the hardware tag-based mode though,
> > the probablity is 1/14, which is quite noticable.
> >
> > Allow up to 4 attempts at generating different tags for the tag-based
> > modes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Ibfa458ef2804ff465d8eb07434a300bf36388d55
> > ---
> >  lib/test_kasan.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index b5077a47b95a..b67da7f6e17f 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -375,7 +375,9 @@ static void kmalloc_uaf2(struct kunit *test)
> >  {
> >       char *ptr1, *ptr2;
> >       size_t size = 43;
> > +     int counter = 0;
> >
> > +again:
> >       ptr1 = kmalloc(size, GFP_KERNEL);
> >       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
> >
> > @@ -384,6 +386,13 @@ static void kmalloc_uaf2(struct kunit *test)
> >       ptr2 = kmalloc(size, GFP_KERNEL);
> >       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
> >
> > +     /*
> > +      * For tag-based KASAN ptr1 and ptr2 tags might happen to be the same.
> > +      * Allow up to 4 attempts at generating different tags.
> > +      */
> > +     if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 == ptr2 && counter++ < 4)
> > +             goto again;
> > +
>
> Why do we even need a limit? Why not retry until ptr1 != ptr2?

Then the test will hang if it's failing. Let's do up to 16 attempts,
it should be more than enough in practice. Thanks!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF152D897D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 19:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406659AbgLLS5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 13:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406167AbgLLS4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 13:56:46 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06037C061794
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 10:56:06 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id b8so11962050ila.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoATNY6l7UvnRR540ZxeHmNTuygWDYuG0d6WKBGh/fQ=;
        b=kfOCrGHdvi6jfrPSEsCAIMzsQdAErnLROpmpV8S1jLNeJNXe2uzbSrIZ7i2YPDDsEN
         UwyUafk63Y6mRhxYw8OBHOnbtjIXZKrTzHX/gu7wTd/ovUI8QWIxl/DcfuDewcHntbOo
         fPv0Wg9IEqRd+uR+RkU4Pl52ewBkJhMOB68MOUcKO67Wgz+4prb17RKgtGHetRFu6Ymj
         Mahk5x3qBUtTQxXVjemcWmWfXHUO3cF1l4mOSVzi2wBxaiTD2Gou9IYBvCt31WcpQamR
         QmlC9aXNzG/XODLMC3JvxXvwlskR3bfNnCx/aTQlMqjYteA6PsZUSJZK6m+nt1XJla4f
         WP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoATNY6l7UvnRR540ZxeHmNTuygWDYuG0d6WKBGh/fQ=;
        b=ijuXrFuDX1M2zgwuUTC2vS5qpPtkVxcX50JZ2Jy+wc4Cgf9WZo9BS7r1MlpYrVw1a1
         2ycr2o+pF4r2AOEUT2CERDbc2pZ4nqasynh95EoVuY8fznFTV2wBmbCb88eATWpVMAXc
         eGA8rZxBm/8Opf+Z0LphRw5n/Yqk0OjfDdzjmT/alzL601cOenAWAZtssvSM9dUO8+8w
         KwHX3ADjvxWL+SLRZE0n1BvTrwkpy3yw5MzHsyAvLwXrYfeTkEdr1DQ97/lRCCVXICp8
         IL0Rnkf75TlBeaF9sXXrnY+i/ur04tss2LCVGV8/zKpfQs21/SVkjfDX3dqQNJVMPtP/
         1I+A==
X-Gm-Message-State: AOAM531hf7XTRgREer0lhSxMXsXhqVZXZtk7hPQoMwnkQTgeU6stxlDK
        k/eXkwJeF8pRiKzjNJCqKzQ5loro1j63IW7dtyTDgy+pzp6+Zg==
X-Google-Smtp-Source: ABdhPJxGQLhHvuwwgqyZDuB5zsrS0LdiJw/ICNuSUTcLE49l8c3P2+2O0DJDpQY1xVtYQiMu/u5llgr2Zdvnwv5yWhE=
X-Received: by 2002:a92:9881:: with SMTP id a1mr24463090ill.238.1607799365127;
 Sat, 12 Dec 2020 10:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20201211085039.GA7619@ubuntu> <CAAH8bW8piLSCYLKjVXYV45cJeHApFX3Z3G=Zx-nap3yCA1=DDg@mail.gmail.com>
 <CAM7-yPR4fFCcmav2HhSqV2Zs5coOfvuVeqD_U2HkXxwsBSEobw@mail.gmail.com>
In-Reply-To: <CAM7-yPR4fFCcmav2HhSqV2Zs5coOfvuVeqD_U2HkXxwsBSEobw@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Sat, 12 Dec 2020 10:55:54 -0800
Message-ID: <CAAH8bW9L=oVLTE28D+=8=TuF2oof3g3M1Fo4ncPNBfv0vm+k6g@mail.gmail.com>
Subject: Re: [PATCH] lib/find_bit_bench: fix the unmatched iterations cnt
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     dushistov@mail.ru, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        richard.weiyang@linux.alibaba.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        joseph.qi@linux.alibaba.com, skalluru@marvell.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 4:09 PM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> > I didn't understand why is so (I mean "same", I think you rather talking about
> > same order of amount of itterations).
>
> Yes. That's what I want to talk about. Thanks!
>
> > Can you provide before and after to compare?
>
> I tested when the bitmap's 0 bit is set only. and below are before and
> after results.
>
> before:
>               Start testing find_bit() with random-filled bitmap
> [  +0.000481] find_next_bit:                    8966 ns,      2 iterations
> [  +0.001739] find_next_zero_bit:            1726335 ns, 327679 iterations
> [  +0.000020] find_last_bit:                    7428 ns,      1 iterations
> [  +0.000017] find_first_bit:                   5523 ns,      2 iterations
> [  +0.000022] find_next_and_bit:                9643 ns,      1 iterations
> [  +0.000007]
>               Start testing find_bit() with sparse bitmap
> [  +0.000041] find_next_bit:                   16343 ns,    656 iterations
> [  +0.001943] find_next_zero_bit:            1928324 ns, 327025 iterations
> [  +0.000029] find_last_bit:                   14398 ns,    656 iterations
> [  +0.000725] find_first_bit:                 711383 ns,    656 iterations
> [  +0.000022] find_next_and_bit:                9581 ns,      1 iterations
>
> after:
> [Dec12 08:25]
>               Start testing find_bit() with random-filled bitmap
> [  +0.000687] find_next_bit:                   11079 ns,      1 iterations
> [  +0.002156] find_next_zero_bit:            2055752 ns, 327679 iterations
> [  +0.000022] find_last_bit:                    8052 ns,      1 iterations
> [  +0.000020] find_first_bit:                   6270 ns,      1 iterations
> [  +0.000024] find_next_and_bit:                9519 ns,      0 iterations
> [  +0.000007]
>               Start testing find_bit() with sparse bitmap
> [  +0.000047] find_next_bit:                   18389 ns,    655 iterations
> [  +0.001807] find_next_zero_bit:            1793314 ns, 327025 iterations
> [  +0.000027] find_last_bit:                   13600 ns,    655 iterations
> [  +0.000604] find_first_bit:                 591173 ns,    655 iterations
> [  +0.000023] find_next_and_bit:                9392 ns,      0 iterations

> find_next_and_bit:                9392 ns,      0 iterations

This is definitely wrong. The test simply says that it has parsed the bitmap
without actually parsing it. Bollocks.

> >I think it's not that important, because the difference is not measurable.
> > But if this part raises questions, I have nothing against aligning numbers.
> Right it's not that important, But if the amount of iteration value is
> not same to the same bitmap,
> makes people confused when they run the test cases. so I just fix.

Can you please welcome those people to join the discussion? What exactly
confuses them? What is their usecase? Will they be satisfied if we add
the comment pointing that we count _iterations_, not number of bits?

> > What for this check against ++cnt? I doubt that the counter can overflow.
> This test case suppose the bitmap size is 327680 (4096UL * 8 * 10)
> So I think there is no case that the counter can overflow in the testcase.
>
> >>         time = ktime_get() - time;
> >>         pr_err("find_first_bit:     %18llu ns, %6ld\n", time, cnt);
> > Why this?
> Sorry, I don't catch what you are saying.
> Could you tell me in detail?

This change adds useless check against overflow on each iteration.
Except that, nothing is changed. We don't need this change, right?

> > Can you please confirm that for bitmap 0001,
> > test_find_{first,next,next_and}_bit reports cnt == 0, and
> > test_find_last_bit() reports 1?
> This happens because "test_find_first_bit" calls __clear_bit
> in case of bitmap 0001 (only 0 bit set), the test_find_first_bit will
> clear the 0 bit
> that makes no match with bitmap2 so it reports 0.
>
> In the view we need to call the find_last_bit or find_next_bit to know
> bitmap is empty so cnt should be the 1 in that case,
> I think it possible by initializing cnt as 1.

Again, we count iterations, not the number of set bits. If you are able to
demonstrate that this test counts iterations wrongly, I'll happily
accept the fix.
Otherwise NACK.

Yury

> > Do you experience the same problem with find_next_and_bit() as well?
> Nope, But compared to other test cases, I think it's better to
> integrate their format.
> Should I sustain the former one?
>
> On Sat, Dec 12, 2020 at 2:20 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Fri, Dec 11, 2020 at 12:50 AM Levi Yun <ppbuk5246@gmail.com> wrote:
> > >
> > > We should have same iteration count when we walk the same bitmap
> > > regardless of using find_next_bit or find_last_b
> >
> > I think it's not that important, because the difference is not measurable.
> > But if this part raises questions, I have nothing against aligning numbers.
> >
> > > When we run the find_bit_benchmark.ko, we sometime get
> > > unmatched iterations count below:
> > >
> > >              Start testing find_bit() with random-filled bitmap
> > > [+...] find_next_bit:                  875085 ns, 163755 iterations <
> > > [+...] find_next_zero_bit:             865319 ns, 163926 iterations
> > > [+...] find_last_bit:                  611807 ns, 163756 iterations <
> > > [+...] find_first_bit:                1601016 ns,  16335 iterations
> > > [+...] find_next_and_bit:              400645 ns,  74040 iterations
> > > [+...]
> > >               Start testing find_bit() with sparse bitmap
> > > [+...] find_next_bit:                    9942 ns,    654 iterations
> > > [+...] find_next_zero_bit:            1678445 ns, 327027 iterations
> > > [+...] find_last_bit:                    7131 ns,    654 iterations
> > > [+...] find_first_bit:                 551383 ns,    654 iterations
> > > [+...] find_next_and_bit:                3027 ns,      1 iterations
> > >
> > > Normally, this is happen when the last bit of bitmap was set.
> >
> > Can you please confirm that for bitmap 0001,
> > test_find_{first,next,next_and}_bit reports cnt == 0, and
> > test_find_last_bit() reports 1?
> >
> > > This patch fix the unmatched iterations count between
> > > test_find_next_bit and test_find_last_bit.
> > >
> > > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > > ---
> > >  lib/find_bit_benchmark.c | 30 ++++++++++++++++--------------
> > >  1 file changed, 16 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> > > index 5637c5711db9..766e0487852b 100644
> > > --- a/lib/find_bit_benchmark.c
> > > +++ b/lib/find_bit_benchmark.c
> > > @@ -35,14 +35,14 @@ static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
> > >   */
> > >  static int __init test_find_first_bit(void *bitmap, unsigned long len)
> > >  {
> > > -       unsigned long i, cnt;
> > > +       unsigned long i = 0, cnt = 0;
> > >         ktime_t time;
> > >
> > >         time = ktime_get();
> > > -       for (cnt = i = 0; i < len; cnt++) {
> > > +       do {
> > >                 i = find_first_bit(bitmap, len);
> > >                 __clear_bit(i, bitmap);
> > > -       }
> > > +       } while (i++ < len && ++cnt);
> >
> > What for this check against ++cnt? I doubt that the counter can overflow.
> >
> > >         time = ktime_get() - time;
> > >         pr_err("find_first_bit:     %18llu ns, %6ld\n", time, cnt);
> > >
> > > @@ -51,12 +51,13 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
> > >
> > >  static int __init test_find_next_bit(const void *bitmap, unsigned long len)
> > >  {
> > > -       unsigned long i, cnt;
> > > +       unsigned long i = 0, cnt = 0;
> > >         ktime_t time;
> > >
> > >         time = ktime_get();
> > > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > -               i = find_next_bit(bitmap, BITMAP_LEN, i) + 1;
> > > +       do {
> > > +               i = find_next_bit(bitmap, BITMAP_LEN, i);
> > > +       } while (i++ < BITMAP_LEN && ++cnt);
> > >         time = ktime_get() - time;
> > >         pr_err("find_next_bit:      %18llu ns, %6ld iterations\n", time, cnt);
> > >
> > > @@ -65,12 +66,13 @@ static int __init test_find_next_bit(const void *bitmap, unsigned long len)
> > >
> > >  static int __init test_find_next_zero_bit(const void *bitmap, unsigned long len)
> > >  {
> > > -       unsigned long i, cnt;
> > > +       unsigned long i = 0, cnt = 0;
> > >         ktime_t time;
> > >
> > >         time = ktime_get();
> > > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > -               i = find_next_zero_bit(bitmap, len, i) + 1;
> > > +       do {
> > > +               i = find_next_zero_bit(bitmap, len, i);
> > > +       } while (i++ < BITMAP_LEN && ++cnt);
> > >         time = ktime_get() - time;
> > >         pr_err("find_next_zero_bit: %18llu ns, %6ld iterations\n", time, cnt);
> > >
> > > @@ -84,12 +86,11 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
> > >
> > >         time = ktime_get();
> > >         do {
> > > -               cnt++;
> > >                 l = find_last_bit(bitmap, len);
> > >                 if (l >= len)
> > >                         break;
> > >                 len = l;
> > > -       } while (len);
> > > +       } while (len >= 0 && ++cnt);
> >
> > Why this?
> >
> > >         time = ktime_get() - time;
> > >         pr_err("find_last_bit:      %18llu ns, %6ld iterations\n", time, cnt);
> > >
> > > @@ -99,12 +100,13 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
> > >  static int __init test_find_next_and_bit(const void *bitmap,
> > >                 const void *bitmap2, unsigned long len)
> > >  {
> > > -       unsigned long i, cnt;
> > > +       unsigned long i = 0, cnt = 0;
> > >         ktime_t time;
> > >
> > >         time = ktime_get();
> > > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > -               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> > > +       do {
> > > +               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i);
> > > +       } while (i++ < BITMAP_LEN && ++cnt);
> >
> > Do you experience the same problem with find_next_and_bit() as well?
> >
> > >         time = ktime_get() - time;
> > >         pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> > >
> > > --
> > > 2.27.0

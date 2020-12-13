Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77C2D8AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 01:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501950AbgLMANC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 19:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLMANC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 19:13:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35BCC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 16:12:21 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m5so12767045wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 16:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17DIrX8yTFYiEwIw0ftfjI3+w/NL+k3H0dzIFfxTntQ=;
        b=WDEIO876Tw/lhUyc5uR8i0FxnNo23BIY11lTLtRViIUdEIutNW3FGmGflPzdLC4J7g
         38oK7OWJxis0DnKbs5hp4WYuOJBOhdYNi+qYx4o+TjmS3YY0J9frNCpsQvH0qzm7XiSH
         h/rnQt0MrkaLvs+jmbvMW0lNs/atpnHbKGJE+HO3CQUpzZKq1rldkNssduWMs50qFqiA
         6+UEV0eCEZk5zq/lBolK/DBiff3UizxWG5LgEs0KG5l1U7SxkiTFUxQfNJa23DIAKn95
         1amfntgNOLfPnTErEPHqhAGvXQmrQ8xhhI88byC38x0JyJhMnDoawNDlWjplHP4MaNW0
         D78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17DIrX8yTFYiEwIw0ftfjI3+w/NL+k3H0dzIFfxTntQ=;
        b=p+AdYWvGinJWPdFC5Vxoy11mJPnbhvGXd7hAouHaBh+vweCLc11TPv0oMlafW8+lJx
         /+sXiGrCnKFQXHBunKmrpAgBLRe2ND46w9BeU4y8A3ejfb8Sm3H/KVgwcl3/d9np8QNp
         cv/fEHomNb46Lxup/mFVypr8Dej/3fX1U3PbjHova6wnFxRb+aygLAYI3jAvy6fRAUVI
         WL56G15QXhhvP10x5K2uqkOtAfOymehOkJI9s5kkOiNVHH6OFt92tyjtD7N8jYyCqBvv
         m638S9PAz4Or9medg6G/e+fU5ScfUeiuORTLbebVXVNXYI1jrLZHp7YY4e5oogGKYCG4
         +Nww==
X-Gm-Message-State: AOAM530aGLWMRTJLY9CvNZtomUGXCCOpPyUM0aEgLBzoJOblpf45SPHy
        IdElHs8cNeTS4zXn8muxtwbN6GiCkb0buup9s8A=
X-Google-Smtp-Source: ABdhPJwML3h5rc4UXjIKeit7bkxawzy0z6qG4i5Ck2J0Qx/X+wY5fMl4pb1MTLiga2j3FziCkXD5FBosSX790HOJFIE=
X-Received: by 2002:adf:f681:: with SMTP id v1mr19212924wrp.133.1607818340257;
 Sat, 12 Dec 2020 16:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20201211085039.GA7619@ubuntu> <CAAH8bW8piLSCYLKjVXYV45cJeHApFX3Z3G=Zx-nap3yCA1=DDg@mail.gmail.com>
 <CAM7-yPR4fFCcmav2HhSqV2Zs5coOfvuVeqD_U2HkXxwsBSEobw@mail.gmail.com> <CAAH8bW9L=oVLTE28D+=8=TuF2oof3g3M1Fo4ncPNBfv0vm+k6g@mail.gmail.com>
In-Reply-To: <CAAH8bW9L=oVLTE28D+=8=TuF2oof3g3M1Fo4ncPNBfv0vm+k6g@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sun, 13 Dec 2020 09:12:07 +0900
Message-ID: <CAM7-yPR74YR5FVbEhTyTv6NG-cd=VEkvnspiaCt0gKRquboQFA@mail.gmail.com>
Subject: Re: [PATCH] lib/find_bit_bench: fix the unmatched iterations cnt
To:     Yury Norov <yury.norov@gmail.com>
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

> Can you please welcome those people to join the discussion? What exactly
> confuses them? What is their usecase? Will they be satisfied if we add
> the comment pointing that we count _iterations_, not number of bits?

> Again, we count iterations, not the number of set bits. If you are able to
> demonstrate that this test counts iterations wrongly, I'll happily
> accept the fix.

What I want to ask people is that question
is it much better to have the same iteration on the same bitmap
regardless of the find_next_bit and find_last_bit.
At my first thought the benchmark is much easier to be compared if
they have the same iteration count
regardless of situation.
What I mentioned as "confused" is people think one more time when
unmatched iteration happens,
(divide time by iteration for getting a benchmark..)
I don't point out the iteration is wrong but ask if it is much better
to have the same iteration count on the
same bitmap regardless of find_next_bit and find_last_bit to be compared easier.

> This change adds useless check against overflow on each iteration.
> Except that, nothing is changed. We don't need this change, right?

it is coming from my misunderstanding it should count the number of bits.
You're right it adds useless checks thank you.

Thanks.
Levi.







On Sun, Dec 13, 2020 at 3:56 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Fri, Dec 11, 2020 at 4:09 PM Yun Levi <ppbuk5246@gmail.com> wrote:
> >
> > > I didn't understand why is so (I mean "same", I think you rather talking about
> > > same order of amount of itterations).
> >
> > Yes. That's what I want to talk about. Thanks!
> >
> > > Can you provide before and after to compare?
> >
> > I tested when the bitmap's 0 bit is set only. and below are before and
> > after results.
> >
> > before:
> >               Start testing find_bit() with random-filled bitmap
> > [  +0.000481] find_next_bit:                    8966 ns,      2 iterations
> > [  +0.001739] find_next_zero_bit:            1726335 ns, 327679 iterations
> > [  +0.000020] find_last_bit:                    7428 ns,      1 iterations
> > [  +0.000017] find_first_bit:                   5523 ns,      2 iterations
> > [  +0.000022] find_next_and_bit:                9643 ns,      1 iterations
> > [  +0.000007]
> >               Start testing find_bit() with sparse bitmap
> > [  +0.000041] find_next_bit:                   16343 ns,    656 iterations
> > [  +0.001943] find_next_zero_bit:            1928324 ns, 327025 iterations
> > [  +0.000029] find_last_bit:                   14398 ns,    656 iterations
> > [  +0.000725] find_first_bit:                 711383 ns,    656 iterations
> > [  +0.000022] find_next_and_bit:                9581 ns,      1 iterations
> >
> > after:
> > [Dec12 08:25]
> >               Start testing find_bit() with random-filled bitmap
> > [  +0.000687] find_next_bit:                   11079 ns,      1 iterations
> > [  +0.002156] find_next_zero_bit:            2055752 ns, 327679 iterations
> > [  +0.000022] find_last_bit:                    8052 ns,      1 iterations
> > [  +0.000020] find_first_bit:                   6270 ns,      1 iterations
> > [  +0.000024] find_next_and_bit:                9519 ns,      0 iterations
> > [  +0.000007]
> >               Start testing find_bit() with sparse bitmap
> > [  +0.000047] find_next_bit:                   18389 ns,    655 iterations
> > [  +0.001807] find_next_zero_bit:            1793314 ns, 327025 iterations
> > [  +0.000027] find_last_bit:                   13600 ns,    655 iterations
> > [  +0.000604] find_first_bit:                 591173 ns,    655 iterations
> > [  +0.000023] find_next_and_bit:                9392 ns,      0 iterations
>
> > find_next_and_bit:                9392 ns,      0 iterations
>
> This is definitely wrong. The test simply says that it has parsed the bitmap
> without actually parsing it. Bollocks.
>
> > >I think it's not that important, because the difference is not measurable.
> > > But if this part raises questions, I have nothing against aligning numbers.
> > Right it's not that important, But if the amount of iteration value is
> > not same to the same bitmap,
> > makes people confused when they run the test cases. so I just fix.
>
> Can you please welcome those people to join the discussion? What exactly
> confuses them? What is their usecase? Will they be satisfied if we add
> the comment pointing that we count _iterations_, not number of bits?
>
> > > What for this check against ++cnt? I doubt that the counter can overflow.
> > This test case suppose the bitmap size is 327680 (4096UL * 8 * 10)
> > So I think there is no case that the counter can overflow in the testcase.
> >
> > >>         time = ktime_get() - time;
> > >>         pr_err("find_first_bit:     %18llu ns, %6ld\n", time, cnt);
> > > Why this?
> > Sorry, I don't catch what you are saying.
> > Could you tell me in detail?
>
> This change adds useless check against overflow on each iteration.
> Except that, nothing is changed. We don't need this change, right?
>
> > > Can you please confirm that for bitmap 0001,
> > > test_find_{first,next,next_and}_bit reports cnt == 0, and
> > > test_find_last_bit() reports 1?
> > This happens because "test_find_first_bit" calls __clear_bit
> > in case of bitmap 0001 (only 0 bit set), the test_find_first_bit will
> > clear the 0 bit
> > that makes no match with bitmap2 so it reports 0.
> >
> > In the view we need to call the find_last_bit or find_next_bit to know
> > bitmap is empty so cnt should be the 1 in that case,
> > I think it possible by initializing cnt as 1.
>
> Again, we count iterations, not the number of set bits. If you are able to
> demonstrate that this test counts iterations wrongly, I'll happily
> accept the fix.
> Otherwise NACK.
>
> Yury
>
> > > Do you experience the same problem with find_next_and_bit() as well?
> > Nope, But compared to other test cases, I think it's better to
> > integrate their format.
> > Should I sustain the former one?
> >
> > On Sat, Dec 12, 2020 at 2:20 AM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > On Fri, Dec 11, 2020 at 12:50 AM Levi Yun <ppbuk5246@gmail.com> wrote:
> > > >
> > > > We should have same iteration count when we walk the same bitmap
> > > > regardless of using find_next_bit or find_last_b
> > >
> > > I think it's not that important, because the difference is not measurable.
> > > But if this part raises questions, I have nothing against aligning numbers.
> > >
> > > > When we run the find_bit_benchmark.ko, we sometime get
> > > > unmatched iterations count below:
> > > >
> > > >              Start testing find_bit() with random-filled bitmap
> > > > [+...] find_next_bit:                  875085 ns, 163755 iterations <
> > > > [+...] find_next_zero_bit:             865319 ns, 163926 iterations
> > > > [+...] find_last_bit:                  611807 ns, 163756 iterations <
> > > > [+...] find_first_bit:                1601016 ns,  16335 iterations
> > > > [+...] find_next_and_bit:              400645 ns,  74040 iterations
> > > > [+...]
> > > >               Start testing find_bit() with sparse bitmap
> > > > [+...] find_next_bit:                    9942 ns,    654 iterations
> > > > [+...] find_next_zero_bit:            1678445 ns, 327027 iterations
> > > > [+...] find_last_bit:                    7131 ns,    654 iterations
> > > > [+...] find_first_bit:                 551383 ns,    654 iterations
> > > > [+...] find_next_and_bit:                3027 ns,      1 iterations
> > > >
> > > > Normally, this is happen when the last bit of bitmap was set.
> > >
> > > Can you please confirm that for bitmap 0001,
> > > test_find_{first,next,next_and}_bit reports cnt == 0, and
> > > test_find_last_bit() reports 1?
> > >
> > > > This patch fix the unmatched iterations count between
> > > > test_find_next_bit and test_find_last_bit.
> > > >
> > > > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > > > ---
> > > >  lib/find_bit_benchmark.c | 30 ++++++++++++++++--------------
> > > >  1 file changed, 16 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> > > > index 5637c5711db9..766e0487852b 100644
> > > > --- a/lib/find_bit_benchmark.c
> > > > +++ b/lib/find_bit_benchmark.c
> > > > @@ -35,14 +35,14 @@ static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
> > > >   */
> > > >  static int __init test_find_first_bit(void *bitmap, unsigned long len)
> > > >  {
> > > > -       unsigned long i, cnt;
> > > > +       unsigned long i = 0, cnt = 0;
> > > >         ktime_t time;
> > > >
> > > >         time = ktime_get();
> > > > -       for (cnt = i = 0; i < len; cnt++) {
> > > > +       do {
> > > >                 i = find_first_bit(bitmap, len);
> > > >                 __clear_bit(i, bitmap);
> > > > -       }
> > > > +       } while (i++ < len && ++cnt);
> > >
> > > What for this check against ++cnt? I doubt that the counter can overflow.
> > >
> > > >         time = ktime_get() - time;
> > > >         pr_err("find_first_bit:     %18llu ns, %6ld\n", time, cnt);
> > > >
> > > > @@ -51,12 +51,13 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
> > > >
> > > >  static int __init test_find_next_bit(const void *bitmap, unsigned long len)
> > > >  {
> > > > -       unsigned long i, cnt;
> > > > +       unsigned long i = 0, cnt = 0;
> > > >         ktime_t time;
> > > >
> > > >         time = ktime_get();
> > > > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > > -               i = find_next_bit(bitmap, BITMAP_LEN, i) + 1;
> > > > +       do {
> > > > +               i = find_next_bit(bitmap, BITMAP_LEN, i);
> > > > +       } while (i++ < BITMAP_LEN && ++cnt);
> > > >         time = ktime_get() - time;
> > > >         pr_err("find_next_bit:      %18llu ns, %6ld iterations\n", time, cnt);
> > > >
> > > > @@ -65,12 +66,13 @@ static int __init test_find_next_bit(const void *bitmap, unsigned long len)
> > > >
> > > >  static int __init test_find_next_zero_bit(const void *bitmap, unsigned long len)
> > > >  {
> > > > -       unsigned long i, cnt;
> > > > +       unsigned long i = 0, cnt = 0;
> > > >         ktime_t time;
> > > >
> > > >         time = ktime_get();
> > > > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > > -               i = find_next_zero_bit(bitmap, len, i) + 1;
> > > > +       do {
> > > > +               i = find_next_zero_bit(bitmap, len, i);
> > > > +       } while (i++ < BITMAP_LEN && ++cnt);
> > > >         time = ktime_get() - time;
> > > >         pr_err("find_next_zero_bit: %18llu ns, %6ld iterations\n", time, cnt);
> > > >
> > > > @@ -84,12 +86,11 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
> > > >
> > > >         time = ktime_get();
> > > >         do {
> > > > -               cnt++;
> > > >                 l = find_last_bit(bitmap, len);
> > > >                 if (l >= len)
> > > >                         break;
> > > >                 len = l;
> > > > -       } while (len);
> > > > +       } while (len >= 0 && ++cnt);
> > >
> > > Why this?
> > >
> > > >         time = ktime_get() - time;
> > > >         pr_err("find_last_bit:      %18llu ns, %6ld iterations\n", time, cnt);
> > > >
> > > > @@ -99,12 +100,13 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
> > > >  static int __init test_find_next_and_bit(const void *bitmap,
> > > >                 const void *bitmap2, unsigned long len)
> > > >  {
> > > > -       unsigned long i, cnt;
> > > > +       unsigned long i = 0, cnt = 0;
> > > >         ktime_t time;
> > > >
> > > >         time = ktime_get();
> > > > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > > > -               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> > > > +       do {
> > > > +               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i);
> > > > +       } while (i++ < BITMAP_LEN && ++cnt);
> > >
> > > Do you experience the same problem with find_next_and_bit() as well?
> > >
> > > >         time = ktime_get() - time;
> > > >         pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> > > >
> > > > --
> > > > 2.27.0

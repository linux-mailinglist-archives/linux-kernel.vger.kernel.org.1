Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B92D834C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437711AbgLLALM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437678AbgLLAKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:10:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B37C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:09:52 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so10095273wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+HwQZQNvYvvie7Xs6nKRTAa+cApPvaQTZtrQ6CuXF8=;
        b=rT83yW/NrGrCYHIpG++Pjzr/wa3Ppard3KPxAKt5ciAUegM9WjaIqjOpzNV6ge0kZd
         9MtIY9pIdQBX6ACgqDUh1uw3CDoM5OjKofckFrHkj9K5x5zPxyNOMmNVu0q1gB8R+X/5
         ro7MDG/ngvUuyuoXQ+KTwV+ggAouhSGnOq6CyKHpgIVHaDKM1gZco7r9Iyb1atdyxxo1
         8VRb+I3l/I7TMRR6Ly68E/HxKm3xvuqSpAoxGZ+4kv4Mr0A+K4N1VXMnqg3gykYl9Ht2
         5jCTcYA6VrFvu2JGQT+9broKRvyv7t+MGQZ7l7KMwr202KaoWBbp338YDY7nXCPzamkw
         YCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+HwQZQNvYvvie7Xs6nKRTAa+cApPvaQTZtrQ6CuXF8=;
        b=dbSykfefmtt/6nes+Mr2FDBZLG+bdGX9nAseSU5/79bAWooBSI/8sWl3uOOeJwZfYn
         5dnsK7Od2tT34qCLfL7kb8pf70cUyEHsuAQC2PbHxtxGRtnY4AOjuzVW1IkKI23+Qsti
         KKsMz/wjQZdwlk2+ZfBUcuoH1/bK6UWjMZkt05LuDgND60qd951eiO5SxvplhY0dh2ML
         BuqhssJAgqQ3j6oUbNn8X35D8C/l4p+Jjmo3z3vbhPvvVXv6Lqp2CCZdJJzW2XLevhpZ
         NrDXCjApRc1PltG0vfnyf1Lg/h86vWSsnwXcK7T9mc1VMZX1u4YqgQY0zXYjngk5czlg
         QLHg==
X-Gm-Message-State: AOAM530Z4t/ea8PfCcXjmUBRSzGf/3PG9sysleIVeTsKRE+MDR7nBk94
        7+vMEZb+m6tnM6LenfJ+ypWlHz5HHfNyJoZxfpI=
X-Google-Smtp-Source: ABdhPJzikI7tRN8AbOLkKeNlH4WfHT41YrztLHXPAdVmV69kQYlpnNl+Xxyj8fDwnRWfHdSOdL0RJFTLn0slO9pqLMo=
X-Received: by 2002:a1c:b742:: with SMTP id h63mr15857926wmf.122.1607731791265;
 Fri, 11 Dec 2020 16:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20201211085039.GA7619@ubuntu> <CAAH8bW8piLSCYLKjVXYV45cJeHApFX3Z3G=Zx-nap3yCA1=DDg@mail.gmail.com>
In-Reply-To: <CAAH8bW8piLSCYLKjVXYV45cJeHApFX3Z3G=Zx-nap3yCA1=DDg@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sat, 12 Dec 2020 09:09:40 +0900
Message-ID: <CAM7-yPR4fFCcmav2HhSqV2Zs5coOfvuVeqD_U2HkXxwsBSEobw@mail.gmail.com>
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

> I didn't understand why is so (I mean "same", I think you rather talking about
> same order of amount of itterations).

Yes. That's what I want to talk about. Thanks!

> Can you provide before and after to compare?

I tested when the bitmap's 0 bit is set only. and below are before and
after results.

before:
              Start testing find_bit() with random-filled bitmap
[  +0.000481] find_next_bit:                    8966 ns,      2 iterations
[  +0.001739] find_next_zero_bit:            1726335 ns, 327679 iterations
[  +0.000020] find_last_bit:                    7428 ns,      1 iterations
[  +0.000017] find_first_bit:                   5523 ns,      2 iterations
[  +0.000022] find_next_and_bit:                9643 ns,      1 iterations
[  +0.000007]
              Start testing find_bit() with sparse bitmap
[  +0.000041] find_next_bit:                   16343 ns,    656 iterations
[  +0.001943] find_next_zero_bit:            1928324 ns, 327025 iterations
[  +0.000029] find_last_bit:                   14398 ns,    656 iterations
[  +0.000725] find_first_bit:                 711383 ns,    656 iterations
[  +0.000022] find_next_and_bit:                9581 ns,      1 iterations

after:
[Dec12 08:25]
              Start testing find_bit() with random-filled bitmap
[  +0.000687] find_next_bit:                   11079 ns,      1 iterations
[  +0.002156] find_next_zero_bit:            2055752 ns, 327679 iterations
[  +0.000022] find_last_bit:                    8052 ns,      1 iterations
[  +0.000020] find_first_bit:                   6270 ns,      1 iterations
[  +0.000024] find_next_and_bit:                9519 ns,      0 iterations
[  +0.000007]
              Start testing find_bit() with sparse bitmap
[  +0.000047] find_next_bit:                   18389 ns,    655 iterations
[  +0.001807] find_next_zero_bit:            1793314 ns, 327025 iterations
[  +0.000027] find_last_bit:                   13600 ns,    655 iterations
[  +0.000604] find_first_bit:                 591173 ns,    655 iterations
[  +0.000023] find_next_and_bit:                9392 ns,      0 iterations

>I think it's not that important, because the difference is not measurable.
> But if this part raises questions, I have nothing against aligning numbers.
Right it's not that important, But if the amount of iteration value is
not same to the same bitmap,
makes people confused when they run the test cases. so I just fix.

> What for this check against ++cnt? I doubt that the counter can overflow.
This test case suppose the bitmap size is 327680 (4096UL * 8 * 10)
So I think there is no case that the counter can overflow in the testcase.

>>         time = ktime_get() - time;
>>         pr_err("find_first_bit:     %18llu ns, %6ld\n", time, cnt);
> Why this?
Sorry, I don't catch what you are saying.
Could you tell me in detail?


> Can you please confirm that for bitmap 0001,
> test_find_{first,next,next_and}_bit reports cnt == 0, and
> test_find_last_bit() reports 1?
This happens because "test_find_first_bit" calls __clear_bit
in case of bitmap 0001 (only 0 bit set), the test_find_first_bit will
clear the 0 bit
that makes no match with bitmap2 so it reports 0.

In the view we need to call the find_last_bit or find_next_bit to know
bitmap is empty so cnt should be the 1 in that case,
I think it possible by initializing cnt as 1.

> Do you experience the same problem with find_next_and_bit() as well?
Nope, But compared to other test cases, I think it's better to
integrate their format.
Should I sustain the former one?

On Sat, Dec 12, 2020 at 2:20 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Fri, Dec 11, 2020 at 12:50 AM Levi Yun <ppbuk5246@gmail.com> wrote:
> >
> > We should have same iteration count when we walk the same bitmap
> > regardless of using find_next_bit or find_last_b
>
> I think it's not that important, because the difference is not measurable.
> But if this part raises questions, I have nothing against aligning numbers.
>
> > When we run the find_bit_benchmark.ko, we sometime get
> > unmatched iterations count below:
> >
> >              Start testing find_bit() with random-filled bitmap
> > [+...] find_next_bit:                  875085 ns, 163755 iterations <
> > [+...] find_next_zero_bit:             865319 ns, 163926 iterations
> > [+...] find_last_bit:                  611807 ns, 163756 iterations <
> > [+...] find_first_bit:                1601016 ns,  16335 iterations
> > [+...] find_next_and_bit:              400645 ns,  74040 iterations
> > [+...]
> >               Start testing find_bit() with sparse bitmap
> > [+...] find_next_bit:                    9942 ns,    654 iterations
> > [+...] find_next_zero_bit:            1678445 ns, 327027 iterations
> > [+...] find_last_bit:                    7131 ns,    654 iterations
> > [+...] find_first_bit:                 551383 ns,    654 iterations
> > [+...] find_next_and_bit:                3027 ns,      1 iterations
> >
> > Normally, this is happen when the last bit of bitmap was set.
>
> Can you please confirm that for bitmap 0001,
> test_find_{first,next,next_and}_bit reports cnt == 0, and
> test_find_last_bit() reports 1?
>
> > This patch fix the unmatched iterations count between
> > test_find_next_bit and test_find_last_bit.
> >
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > ---
> >  lib/find_bit_benchmark.c | 30 ++++++++++++++++--------------
> >  1 file changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> > index 5637c5711db9..766e0487852b 100644
> > --- a/lib/find_bit_benchmark.c
> > +++ b/lib/find_bit_benchmark.c
> > @@ -35,14 +35,14 @@ static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
> >   */
> >  static int __init test_find_first_bit(void *bitmap, unsigned long len)
> >  {
> > -       unsigned long i, cnt;
> > +       unsigned long i = 0, cnt = 0;
> >         ktime_t time;
> >
> >         time = ktime_get();
> > -       for (cnt = i = 0; i < len; cnt++) {
> > +       do {
> >                 i = find_first_bit(bitmap, len);
> >                 __clear_bit(i, bitmap);
> > -       }
> > +       } while (i++ < len && ++cnt);
>
> What for this check against ++cnt? I doubt that the counter can overflow.
>
> >         time = ktime_get() - time;
> >         pr_err("find_first_bit:     %18llu ns, %6ld\n", time, cnt);
> >
> > @@ -51,12 +51,13 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
> >
> >  static int __init test_find_next_bit(const void *bitmap, unsigned long len)
> >  {
> > -       unsigned long i, cnt;
> > +       unsigned long i = 0, cnt = 0;
> >         ktime_t time;
> >
> >         time = ktime_get();
> > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > -               i = find_next_bit(bitmap, BITMAP_LEN, i) + 1;
> > +       do {
> > +               i = find_next_bit(bitmap, BITMAP_LEN, i);
> > +       } while (i++ < BITMAP_LEN && ++cnt);
> >         time = ktime_get() - time;
> >         pr_err("find_next_bit:      %18llu ns, %6ld iterations\n", time, cnt);
> >
> > @@ -65,12 +66,13 @@ static int __init test_find_next_bit(const void *bitmap, unsigned long len)
> >
> >  static int __init test_find_next_zero_bit(const void *bitmap, unsigned long len)
> >  {
> > -       unsigned long i, cnt;
> > +       unsigned long i = 0, cnt = 0;
> >         ktime_t time;
> >
> >         time = ktime_get();
> > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > -               i = find_next_zero_bit(bitmap, len, i) + 1;
> > +       do {
> > +               i = find_next_zero_bit(bitmap, len, i);
> > +       } while (i++ < BITMAP_LEN && ++cnt);
> >         time = ktime_get() - time;
> >         pr_err("find_next_zero_bit: %18llu ns, %6ld iterations\n", time, cnt);
> >
> > @@ -84,12 +86,11 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
> >
> >         time = ktime_get();
> >         do {
> > -               cnt++;
> >                 l = find_last_bit(bitmap, len);
> >                 if (l >= len)
> >                         break;
> >                 len = l;
> > -       } while (len);
> > +       } while (len >= 0 && ++cnt);
>
> Why this?
>
> >         time = ktime_get() - time;
> >         pr_err("find_last_bit:      %18llu ns, %6ld iterations\n", time, cnt);
> >
> > @@ -99,12 +100,13 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
> >  static int __init test_find_next_and_bit(const void *bitmap,
> >                 const void *bitmap2, unsigned long len)
> >  {
> > -       unsigned long i, cnt;
> > +       unsigned long i = 0, cnt = 0;
> >         ktime_t time;
> >
> >         time = ktime_get();
> > -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> > -               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> > +       do {
> > +               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i);
> > +       } while (i++ < BITMAP_LEN && ++cnt);
>
> Do you experience the same problem with find_next_and_bit() as well?
>
> >         time = ktime_get() - time;
> >         pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
> >
> > --
> > 2.27.0

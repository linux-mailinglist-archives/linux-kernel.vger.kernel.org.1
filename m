Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72B2D7CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395134AbgLKRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391389AbgLKRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:21:16 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:20:35 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id r17so9452100ilo.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWWdoWGKC/NZ45HHis8WzaQgs1zCgXnZjIEifJXxKnA=;
        b=DsLoj3Ygm22lIJhP2xfmRqAgb/DEn58TMntVqyTN0WqzeixvgB8bpM/OQcmwANaIR+
         YTTkVXPdmRAHtbLILbfU1fwaKub2gaiO33NnjXJjSHepCGtl//R+vwtj8sxOy3ub8ey8
         6SnFw6cv1X1+cd5Jn3Y693K1xw3NsvjZuNNp1DdC+AHquG3OPajhmxnQ+3LOzrFB/NYN
         pLzl2MDKr26Oc1v1ykuKpgiDrQaAefYnRuiyNODzTLRKdCbPLMhJWk0+26VWGQKJbTo/
         0rKEcsGIS80Xwn19XFt9jk9nu5XV5diLqhWPHO69hs/gYI+OP1TJ8G7IlVsyExVNwMm5
         6tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWWdoWGKC/NZ45HHis8WzaQgs1zCgXnZjIEifJXxKnA=;
        b=skY2vDMs+Ft6F2ZWOCKlHh3y+1SlwK2SUXch/4akaRtm5LURwmV0p3YHYjVIlF72Ry
         YaRYWsyvYkGO9lpVDIUd92kqzHU0HbT4qOFx8dQzhfvGwrOxgtBwJfvw9HafoABwnTlB
         8+frsuw/bq6BUtoxnraBSVBFpLBqwho7q3ZknyayGR8qk1DiaEjPrrSFSBbiYgq19vc/
         JV2W/ib1fnYQ8Te3oNVpS5zH+mqmpdPamxAjYfX19cBa7v6gYXaBCy/aNdKC6A/cgtb8
         o+3WbNUuAcc2gJZNEHeqSSNXT29TucOK82NDiiOWwK/YADUfZ/O7XJ48m3HtgicGBL5A
         lcpQ==
X-Gm-Message-State: AOAM5309cmbmy/P/+d2Hboh3RoqytdKcZEjuUrxqcd7R0VqIczNQ4W1z
        naLYQy03Ta6b23wuCAiO6aQHvxMXyHyqESWfJUs=
X-Google-Smtp-Source: ABdhPJzBpbCWqJwDONY394CwDBDL7awHME0oue8sp77JPLDhEagHA1hiSYI48TYdToOlAIEwe/vVjii7q2sQ7MeukVI=
X-Received: by 2002:a92:418d:: with SMTP id o135mr17719189ila.213.1607707235064;
 Fri, 11 Dec 2020 09:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20201211085039.GA7619@ubuntu>
In-Reply-To: <20201211085039.GA7619@ubuntu>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 11 Dec 2020 09:20:23 -0800
Message-ID: <CAAH8bW8piLSCYLKjVXYV45cJeHApFX3Z3G=Zx-nap3yCA1=DDg@mail.gmail.com>
Subject: Re: [PATCH] lib/find_bit_bench: fix the unmatched iterations cnt
To:     Levi Yun <ppbuk5246@gmail.com>
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

On Fri, Dec 11, 2020 at 12:50 AM Levi Yun <ppbuk5246@gmail.com> wrote:
>
> We should have same iteration count when we walk the same bitmap
> regardless of using find_next_bit or find_last_b

I think it's not that important, because the difference is not measurable.
But if this part raises questions, I have nothing against aligning numbers.

> When we run the find_bit_benchmark.ko, we sometime get
> unmatched iterations count below:
>
>              Start testing find_bit() with random-filled bitmap
> [+...] find_next_bit:                  875085 ns, 163755 iterations <
> [+...] find_next_zero_bit:             865319 ns, 163926 iterations
> [+...] find_last_bit:                  611807 ns, 163756 iterations <
> [+...] find_first_bit:                1601016 ns,  16335 iterations
> [+...] find_next_and_bit:              400645 ns,  74040 iterations
> [+...]
>               Start testing find_bit() with sparse bitmap
> [+...] find_next_bit:                    9942 ns,    654 iterations
> [+...] find_next_zero_bit:            1678445 ns, 327027 iterations
> [+...] find_last_bit:                    7131 ns,    654 iterations
> [+...] find_first_bit:                 551383 ns,    654 iterations
> [+...] find_next_and_bit:                3027 ns,      1 iterations
>
> Normally, this is happen when the last bit of bitmap was set.

Can you please confirm that for bitmap 0001,
test_find_{first,next,next_and}_bit reports cnt == 0, and
test_find_last_bit() reports 1?

> This patch fix the unmatched iterations count between
> test_find_next_bit and test_find_last_bit.
>
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
>  lib/find_bit_benchmark.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
> index 5637c5711db9..766e0487852b 100644
> --- a/lib/find_bit_benchmark.c
> +++ b/lib/find_bit_benchmark.c
> @@ -35,14 +35,14 @@ static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
>   */
>  static int __init test_find_first_bit(void *bitmap, unsigned long len)
>  {
> -       unsigned long i, cnt;
> +       unsigned long i = 0, cnt = 0;
>         ktime_t time;
>
>         time = ktime_get();
> -       for (cnt = i = 0; i < len; cnt++) {
> +       do {
>                 i = find_first_bit(bitmap, len);
>                 __clear_bit(i, bitmap);
> -       }
> +       } while (i++ < len && ++cnt);

What for this check against ++cnt? I doubt that the counter can overflow.

>         time = ktime_get() - time;
>         pr_err("find_first_bit:     %18llu ns, %6ld\n", time, cnt);
>
> @@ -51,12 +51,13 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
>
>  static int __init test_find_next_bit(const void *bitmap, unsigned long len)
>  {
> -       unsigned long i, cnt;
> +       unsigned long i = 0, cnt = 0;
>         ktime_t time;
>
>         time = ktime_get();
> -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> -               i = find_next_bit(bitmap, BITMAP_LEN, i) + 1;
> +       do {
> +               i = find_next_bit(bitmap, BITMAP_LEN, i);
> +       } while (i++ < BITMAP_LEN && ++cnt);
>         time = ktime_get() - time;
>         pr_err("find_next_bit:      %18llu ns, %6ld iterations\n", time, cnt);
>
> @@ -65,12 +66,13 @@ static int __init test_find_next_bit(const void *bitmap, unsigned long len)
>
>  static int __init test_find_next_zero_bit(const void *bitmap, unsigned long len)
>  {
> -       unsigned long i, cnt;
> +       unsigned long i = 0, cnt = 0;
>         ktime_t time;
>
>         time = ktime_get();
> -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> -               i = find_next_zero_bit(bitmap, len, i) + 1;
> +       do {
> +               i = find_next_zero_bit(bitmap, len, i);
> +       } while (i++ < BITMAP_LEN && ++cnt);
>         time = ktime_get() - time;
>         pr_err("find_next_zero_bit: %18llu ns, %6ld iterations\n", time, cnt);
>
> @@ -84,12 +86,11 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
>
>         time = ktime_get();
>         do {
> -               cnt++;
>                 l = find_last_bit(bitmap, len);
>                 if (l >= len)
>                         break;
>                 len = l;
> -       } while (len);
> +       } while (len >= 0 && ++cnt);

Why this?

>         time = ktime_get() - time;
>         pr_err("find_last_bit:      %18llu ns, %6ld iterations\n", time, cnt);
>
> @@ -99,12 +100,13 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
>  static int __init test_find_next_and_bit(const void *bitmap,
>                 const void *bitmap2, unsigned long len)
>  {
> -       unsigned long i, cnt;
> +       unsigned long i = 0, cnt = 0;
>         ktime_t time;
>
>         time = ktime_get();
> -       for (cnt = i = 0; i < BITMAP_LEN; cnt++)
> -               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
> +       do {
> +               i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i);
> +       } while (i++ < BITMAP_LEN && ++cnt);

Do you experience the same problem with find_next_and_bit() as well?

>         time = ktime_get() - time;
>         pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
>
> --
> 2.27.0

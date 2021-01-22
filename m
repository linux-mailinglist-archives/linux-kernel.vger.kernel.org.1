Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439AF2FF978
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbhAVAaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhAVAaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:30:05 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B3C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:29:24 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d81so7872109iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GB8i5pInAwJJUs19Bi7qWAcYC3XfY0IQENGFmY0L3nk=;
        b=kfZd/nmNsn61WOvdrjLBdpklObq470VuXRCXuKTW25YX3MATeQLG7SvoUl/uqwvPO2
         rAadILPic1Qe64bK1lwW6OeWJQIxBhAUliaC3pHQGyAKaorG14+eJvxvnSbfOtssTM2j
         Wm41MH4t+eOT4wpOT21AleTiuYNXyHyXmmDSqlRMSRPwi1ftA0j/vFCpKc3T3ERua8fN
         1gjiyNfFpE2gVpglWfwvhE/hdlbucluQ/oHizAttnMlugcWqKwCZt7dE3wXMjdiRRkQN
         FE6Wu6t6GYrQNyzjKa6jOd7gNC9JJxaODM4nfI6ZQfgqLCeqCSpnzt/lpZFlnVW5MfTe
         JXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GB8i5pInAwJJUs19Bi7qWAcYC3XfY0IQENGFmY0L3nk=;
        b=J15C3mVa4Z1dckILk2804np6r3QVaEucjSDisnw/nspxxgGNFLTb9tmTzn/tkp74tI
         rQOEIxjnj2WR8f5mIYNTHh30fmci3VpbB64ZbQmvxSHzXdKkuBNoxPQldFozaQiifiWC
         DY7/P2btARIBpKWczBzjnu1jiAi52+gMbZdwKLwo1rPKZVSiX0TPn9wSX6C8LjQBngUP
         7K25ppShh4hFCoM9L2lg28Y3HLiuOlFFRU55JEA6DRvtLtAYYlsA5lgIhiMUs0oSzBxt
         CaO+Jev0lDtj6ucGOHBjWYQ73s/J1yL/zeSAN2MghGFysB5Tk89U9BK8qyn4qK8+uWEu
         hhYQ==
X-Gm-Message-State: AOAM531kxfUrKV/yFMJ8CMSOrtttDQwd6U/Ktl1I2TQVRPOn939hDwba
        vCkawZt+esEnE/tSqSSrcg/A9ZephI+K6zlzLNM=
X-Google-Smtp-Source: ABdhPJxn+v3shqiIM+1yTKE9mVGNdfoPMM5WI4lZx2sQMRNGviotd0AYWcYM2byqFYro0hfTDLk/KEbuljh6f4W0XwY=
X-Received: by 2002:a6b:7501:: with SMTP id l1mr1586762ioh.92.1611275364347;
 Thu, 21 Jan 2021 16:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20210121223355.59780-1-paul.gortmaker@windriver.com> <20210121223355.59780-4-paul.gortmaker@windriver.com>
In-Reply-To: <20210121223355.59780-4-paul.gortmaker@windriver.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 21 Jan 2021 16:29:13 -0800
Message-ID: <CAAH8bW8GYYsHy7c8KD3EL+a1mR+wCrj7WFS+Gp5=4CJbz7GpgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 2:34 PM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
>
> While this is done for all bitmaps, the original use case in mind was
> for CPU masks and cpulist_parse().  Credit to Yury who suggested to
> push it down from CPU subsys to bitmap - it simplified things a lot.

Can you convert your credit to Suggested-by or Reviewed-by? :)

> It seems that a common configuration is to use the 1st couple cores
> for housekeeping tasks, and or driving a busy peripheral that generates
> a lot of interrupts, or something similar.
>
> This tends to leave the remaining ones to form a pool of similarly
> configured cores to take on the real workload of interest to the user.
>
> So on machine A - with 32 cores, it could be 0-3 for "system" and then
> 4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
> setting up the worker pool of CPUs.
>
> But then newer machine B is added, and it has 48 cores, and so while
> the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.
>
> Deployment would be easier if we could just simply replace 31 and 47
> with "N" and let the system substitute in the actual number at boot;
> a number that it knows better than we do.
>
> No need to have custom boot args per node, no need to do a trial boot
> in order to snoop /proc/cpuinfo and/or /sys/devices/system/cpu - no
> more fencepost errors of using 32 and 48 instead of 31 and 47.
>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  .../admin-guide/kernel-parameters.rst          |  4 ++++
>  lib/bitmap.c                                   | 18 +++++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 5e080080b058..668f0b69fb4f 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -68,6 +68,10 @@ For example one can add to the command line following parameter:
>
>  where the final item represents CPUs 100,101,125,126,150,151,...
>
> +The value "N" can be used as the end of a range, to represent the numerically
> +last CPU on the system, i.e "foo_cpus=16-N" would be equivalent to "16-31" on
> +a 32 core system.
> +
>  The following convenience aliases are also accepted and used:
>
>          foo_cpus=all
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index a1010646fbe5..d498ea9d526b 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -571,7 +571,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
>         return end;
>  }
>
> -static const char *bitmap_parse_region(const char *str, struct region *r)
> +static const char *bitmap_parse_region(const char *str, struct region *r, int nmaskbits)
>  {

in bitmap_parselist() you can store nmaskbits in the struct region, and avoid
passing nmaskbits as a parameter.

>         str = bitmap_getnum(str, &r->start);
>         if (IS_ERR(str))
> @@ -583,9 +583,15 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>         if (*str != '-')
>                 return ERR_PTR(-EINVAL);
>
> -       str = bitmap_getnum(str + 1, &r->end);
> -       if (IS_ERR(str))
> -               return str;
> +       str++;
> +       if (*str == 'N') {
> +               r->end = nmaskbits - 1;
> +               str++;
> +       } else {
> +               str = bitmap_getnum(str, &r->end);
> +               if (IS_ERR(str))
> +                       return str;
> +       }

Indeed it's much simpler. But I don't like that you increase the nesting level.
Can you keep bitmap_parse_region() a single-tab style function?

What about group size? Are you going to support N there, like "0-N:5/N"?
What about "N-N"? Is it legal? Maybe hide new logic in bitmap_getnum()?

I would also like to see tests covering new functionality. As a user of "N",
I want to be 100% sure that this "N" is a full equivalent of NR_CPUS, including
error codes that the parser returns. Otherwise it will be hard to maintain the
transition.

>         if (end_of_region(*str))
>                 goto no_pattern;
> @@ -628,6 +634,8 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
>   * Syntax: range:used_size/group_size
>   * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
>   * Optionally the self-descriptive "all" or "none" can be used.
> + * The value 'N' can be used as the end of a range to indicate the maximum
> + * allowed value; i.e (nmaskbits - 1).
>   *
>   * Returns: 0 on success, -errno on invalid input strings. Error values:
>   *
> @@ -656,7 +664,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>                 if (buf == NULL)
>                         return 0;
>
> -               buf = bitmap_parse_region(buf, &r);
> +               buf = bitmap_parse_region(buf, &r, nmaskbits);
>                 if (IS_ERR(buf))
>                         return PTR_ERR(buf);
>
> --
> 2.17.1
>

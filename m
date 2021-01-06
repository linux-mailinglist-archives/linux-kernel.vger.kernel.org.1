Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75C42EBB32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAFIm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAFIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:42:29 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0C9C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:41:48 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w17so2424429ilj.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7xBHuSfckezWkGBbL98BBKocRfjK2xqsDJMv8wP24I=;
        b=gMVycZ9egsgCnW7lcTqN4dpuVQTqOitq14J848WENdZM0J5CCKwVNJ1lfYFmVywri6
         WhgS0Tl8O04nMJBDSswy7mdoupt5SpGHSU8LeY43u/swJr7VNXeaqgdPPSF44bD2PlVd
         Mf9+UHOstIATegHV9h16GhaWsgWk3/treH9zClLcU+LAH55Yvb4S7jFA4xjfEAw+Vi7l
         s3DMTJXFetBuz2xbqGvOYcsyv1P09AdLrpcnWRbjm+Zjy++GtE5ETFItgawFq3IaZrVg
         udvcKA8B581FQs/K2fjJU9+3folr06ld7C4GA69S3ho6CBuKs9M5hLNLF/x2FQxm1B2R
         ztMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7xBHuSfckezWkGBbL98BBKocRfjK2xqsDJMv8wP24I=;
        b=bf336cXKPIb0G0xUx5w5AGSCyHAqZHS39s+owuKVJ6CNZCVCLkTGqp2/fr18ZiGbLQ
         fy9NGrFlP3ksDvUhWhA9LTdY3kmPpHqzIPBf2swKsOY6tpyKNgKZITkrhPKq83+wP2jV
         vYq02d6wO62saqHna5TnP7f7xBeNkMeL30DGQGNAvBAD1XZFWzq5ccwcjG/lffDF/o7X
         SOZ9nhEhxnMRArRH2EOcNnCDbFf+C61ckG8uiMgcFVAHi7aSlHWUybKFY22AIF1wJMNC
         PaE6aPfJu4kbHf9GkB/MJhoY4Z8Ov6aOa29zRcVix0Kdy4jWqfPYzmsA/W6ElSvKZ5xq
         zNRA==
X-Gm-Message-State: AOAM533aogWyExuyxm5eEzGT2PdzW1yspSRwJ6v9cZeg4/6Ja0SkYmcr
        +mADCh+EHEuHtLpci0zC+fOQE/c0JKG2p/HRI30=
X-Google-Smtp-Source: ABdhPJxtZ6nX9VnbXItc9fNmAi5uNqFYnaNhBBm5x64cd1Hq+ENxHHQmTahMIazZbYCkGtUoTpwKgRFqynQyXlhutSM=
X-Received: by 2002:a05:6e02:20c4:: with SMTP id 4mr3248417ilq.170.1609922508104;
 Wed, 06 Jan 2021 00:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20210106004850.GA11682@paulmck-ThinkPad-P72> <20210106004956.11961-4-paulmck@kernel.org>
In-Reply-To: <20210106004956.11961-4-paulmck@kernel.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 6 Jan 2021 00:41:36 -0800
Message-ID: <CAAH8bW9LU3rLk5pKYDMpJS9zue200Ve7dnjup4043Pb2WuoNdA@mail.gmail.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list specifications
To:     paulmck@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 4:49 PM <paulmck@kernel.org> wrote:
>
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>
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
> with "last" and let the system substitute in the actual number at boot;
> a number that it knows better than we do.
>
> No need to have custom boot args per node, no need to do a trial boot
> in order to snoop /proc/cpuinfo and/or /sys/devices/system/cpu - no
> more fencepost errors of using 32 and 48 instead of 31 and 47.
>
> A generic token replacement is used to substitute "last" with the
> number of CPUs present before handing off to bitmap processing.  But
> it could just as easily be used to replace any placeholder token with
> any other token or value only known at/after boot.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.rst |   7 ++
>  lib/cpumask.c                                   | 112 +++++++++++++++++++++++-
>  2 files changed, 117 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 7dd1224..5f441ef 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -83,6 +83,13 @@ will provide an empty/cleared cpu mask for the associated boot argument.
>  Note that "all" and "none" are not necessarily valid/sensible input values
>  for each available parameter expecting a CPU list.
>
> +        foo_cpus=1,3,5,16-last
> +
> +will at runtime, replace "last" with the number of the last (highest number)
> +present CPU on the system.  Thus a common deployment can be used on multiple
> +systems with different total number of cores present, without needing to
> +evaluate the total core count in advance on each system.
> +
>  This document may not be entirely up to date and comprehensive. The command
>  "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
>  module. Loadable modules, after being loaded into the running kernel, also
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 7fbcab8..97a005f 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -3,6 +3,7 @@
>  #include <linux/kernel.h>
>  #include <linux/bitops.h>
>  #include <linux/string.h>
> +#include <linux/ctype.h>
>  #include <linux/cpumask.h>
>  #include <linux/export.h>
>  #include <linux/memblock.h>
> @@ -96,15 +97,97 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
>  }
>  EXPORT_SYMBOL(cpumask_next_wrap);
>
> +/*
> + * Basically strstr() but given "foo", ignore "foobar", "myfoo", "foofoo"
> + * and "foo2bar" -- i.e. any case where the token is a word fragment.
> + */
> +static char *cpumask_find_token(const char *str, const char *token)

This should go to lib/string.c and have a name like strword().

> +{
> +       char *here = strstr(str, token);
> +       size_t tlen = strlen(token);
> +
> +       if (!here)
> +               return NULL;
> +
> +       while (here) {
> +               size_t offset = here - str;
> +               char prev, next = str[offset + tlen];
> +
> +               if (offset)
> +                       prev = str[offset - 1];
> +               else
> +                       prev = '\0';
> +
> +               if (!(isalnum(prev) || isalnum(next)))
> +                       break;
> +
> +               here = strstr(here + tlen, token);
> +       }
> +
> +       return here;
> +}
> +
> +/*
> + * replace old token with new token: Given a convenience or placeholder
> + * token "last" and an associated value not known until boot, of say 1234,
> + * replace instances of "last" with "1234".
> + *
> + * For example src = "1,3,last,7-last,9,lastly,last-2047\0"  results in a
> + *            dest = "1,3,1234,7-1234,9,lastly,1234-2047\0"

This should be definitely done in bitmap_parselist(). There you will
find suitable
helpers to solve this problem in a few lines.

> + * The destination string may be shorter than, equal to, or longer than
> + * the source string -- based on whether the new token strlen is shorter
> + * than, equal to, or longer than the old token strlen.
> + * The caller must allocate dest space accordingly with that in mind.

How could he have a proper value in mind if he doesn't know the number of
digits in the last cpu number in advance, as well as the number of
substitutions?
For me, this hole will be exploited sooner or later.

> + */
> +
> +static void cpulist_replace_token(char *dest, const char *src,
> +                          const char *old_token, const char *new_token)
> +{
> +       const char *src_start = src;
> +       char *dest_start = dest, *here;
> +       const size_t olen = strlen(old_token);
> +       const size_t nlen = strlen(new_token);
> +
> +       here = cpumask_find_token(src_start, old_token);
> +       if (!here) {
> +               strcpy(dest, src);
> +               return;
> +       }
> +
> +       while (here) {
> +               size_t offset = here - src_start;
> +
> +               strncpy(dest_start, src_start, offset);
> +               dest_start += offset;
> +               src_start += offset;
> +
> +               strcpy(dest_start, new_token);
> +               dest_start += nlen;
> +               src_start += olen;
> +
> +               strcpy(dest_start, src_start);  /* remainder of string */

'Shlemiel the painter' style. The complexity is O(N^2).

> +               here = cpumask_find_token(src_start, old_token);
> +       }
> +}
> +
>  /**
>   * cpulist_parse - extract a cpumask from a user string of ranges
>   * @buf: the buffer to extract from
>   * @dstp: the cpumask to set.
>   *
>   * Returns -errno, or 0 for success.
> + *
> + * Marked __ref because memblock_*() are __meminit and we use them for
> + * any early calls before slab is available.
>   */
> -int cpulist_parse(const char *buf, struct cpumask *dstp)
> +int __ref cpulist_parse(const char *buf, struct cpumask *dstp)
>  {
> +       int r;
> +       char *cpulist, last_cpu[5];     /* NR_CPUS <= 9999 */
> +       size_t len = strlen(buf) + 1;   /* don't forget '\0' */
> +       bool early = !slab_is_available();
> +
>         if (!strcmp(buf, "all")) {
>                 cpumask_setall(dstp);
>                 return 0;
> @@ -115,7 +198,32 @@ int cpulist_parse(const char *buf, struct cpumask *dstp)
>                 return 0;
>         }
>
> -       return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
> +       /*
> +        * strlen("last") means "len" is OK up to NR_CPUS <= 9999.

Most supercomputers run Linux these days.

> +        */
> +       if (early)
> +               cpulist = memblock_alloc(len, SMP_CACHE_BYTES);
> +       else
> +               cpulist = kzalloc(len, GFP_KERNEL);
> +
> +       if (cpulist == NULL)
> +               return -ENOMEM;
> +
> +       /*
> +        * bitmap_parselist has no concept of "last" CPU, so we have to
> +        * replace "last" with a real number in dest copy of the string.

..., so we have to add that concept to bitmap_parselist. NAK.

> +        */
> +       sprintf(last_cpu, "%d", cpumask_last(cpu_present_mask));
> +       cpulist_replace_token(cpulist, buf, "last", last_cpu);
> +
> +       r = bitmap_parselist(cpulist, cpumask_bits(dstp), nr_cpumask_bits);
> +
> +       if (early)
> +               memblock_free((phys_addr_t)cpulist, len);
> +       else
> +               kfree(cpulist);
> +
> +       return r;
>  }
>  EXPORT_SYMBOL(cpulist_parse);
>
> --
> 2.9.5
>

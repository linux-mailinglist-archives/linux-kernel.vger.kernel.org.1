Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FDD2EBA06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbhAFGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbhAFGdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:33:44 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45DC06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 22:33:03 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id n9so2235569ili.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 22:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2T0nuiqZ51cyL88bRrJqH5KD+Rsokp1j/idw8L4Z2k=;
        b=QKSPDy2ZTbkhVhckQQ42x04UuQib50pGNHr+cMccflrfxlG/+CN9CIjoIQ6jzuoizC
         0FHrAZxmCdQvBJVqX8suCv1gYTEWvycLK30U+Td3tbO+yKAaMir/Td4etF4GCVhIcrPU
         CZlvvUrF1vSfrqDR1JmbWsDUG1kHS9hEEFWa2qJeOxj2tKFeH19t7jkkCuNfOy1FKFG1
         OgIfQ1g5fJ+o3qet9dE7Lvo1/3JavFgXJKQVaoHuc/QdUE4VZd2gEeXAFiWh8OpE4gnr
         wiqKUwQzZdrLXwIsRWndOu6vngI7nhkuPx/alKnI/H3XFhpelA41iieNDajPsFFsjNW/
         4yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2T0nuiqZ51cyL88bRrJqH5KD+Rsokp1j/idw8L4Z2k=;
        b=tb+IIOVAQiasOqE7fEBhW/LOUp0rr9Bnr3sZeBYcQok6Imc975ofi94pgjBVOcINny
         1VsArOgnGmQFvofJRDOmyHqcn8jUoUshXvqBWyTnvYO4g4/WtvBilrHQcry+qm/xCDhJ
         +vd0bboFugV2Y5SC4kA3A9Tdd5HgE8uskFPIlooeDykqeXWwxtbMW5fnGXnvtSlcAykz
         vh51ORDTef9Jxwi6Q+iE5YtV4hBBwCcSrw6fybCwKNNAo2TLdnqKzd5Na5C/rNUdK3uz
         9+cCHU0uaijSToYpeSrYFqmSqmOpZTE9t0mDYRVfCeo8TsF2W5EMVJ1pJoEXn6AzTCx3
         cznQ==
X-Gm-Message-State: AOAM532UB7KCZHK5Hgih2Ip5gC8iJ0XaLOgVxSwqJy5/rEebMtlrps+H
        FBRrfihuw0xIX6GhWJMr4ArWRsTTyB5nrHNHB8w=
X-Google-Smtp-Source: ABdhPJzU4Y0t/m/adhM+A7kQWthDtfj85Kt0KW0FSOMDlY2gJ1z2URFaFiR7g+1FN9VZLMoYAS86l5VdCgbJfEY+f9w=
X-Received: by 2002:a05:6e02:20c4:: with SMTP id 4mr2950339ilq.170.1609914782855;
 Tue, 05 Jan 2021 22:33:02 -0800 (PST)
MIME-Version: 1.0
References: <20210106004850.GA11682@paulmck-ThinkPad-P72> <20210106004956.11961-2-paulmck@kernel.org>
In-Reply-To: <20210106004956.11961-2-paulmck@kernel.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 5 Jan 2021 22:32:51 -0800
Message-ID: <CAAH8bW_euakp=vSKcZoH4=6WHuAuEH-4LdKm21C=-+4jdrT8xQ@mail.gmail.com>
Subject: Re: [PATCH RFC cpumask 2/5] cpumask: Make "all" alias global and not
 just RCU
To:     paulmck@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jan 5, 2021 at 4:49 PM <paulmck@kernel.org> wrote:
>
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> It is probably better that we don't have subsystem specific
> abbreviations or aliases for generic CPU list specifications.
>
> Hence we move the "all" from RCU out to lib/ so that it can be
> used in any instance where CPU lists are being parsed.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.rst |  7 +++++++
>  Documentation/admin-guide/kernel-parameters.txt |  4 +---
>  kernel/rcu/tree_plugin.h                        | 13 ++++---------
>  lib/cpumask.c                                   |  6 ++++++
>  4 files changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 06fb1b4..cdf4e81 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
>
>  where the final item represents CPUs 100,101,125,126,150,151,...
>
> +The following convenience aliases are also accepted and used:
> +
> +        foo_cpus=all
> +
> +is equivalent to "foo_cpus=0-N" -- where "N" is the numerically last CPU on
> +the system, thus avoiding looking up the value in "/sys/devices/system/cpu"
> +in advance on each deployed system.
>
>
>  This document may not be entirely up to date and comprehensive. The command
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c722ec1..0f4379b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4037,9 +4037,7 @@
>                                 see CONFIG_RAS_CEC help text.
>
>         rcu_nocbs=      [KNL]
> -                       The argument is a cpu list, as described above,
> -                       except that the string "all" can be used to
> -                       specify every CPU on the system.
> +                       The argument is a cpu list, as described above.
>
>                         In kernels built with CONFIG_RCU_NOCB_CPU=y, set
>                         the specified list of CPUs to be no-callback CPUs.
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 7e291ce..642ebd6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1463,20 +1463,15 @@ static void rcu_cleanup_after_idle(void)
>
>  /*
>   * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
> - * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
> - * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
> - * given, a warning is emitted and all CPUs are offloaded.
> + * If the list is invalid, a warning is emitted and all CPUs are offloaded.
>   */
>  static int __init rcu_nocb_setup(char *str)
>  {
>         alloc_bootmem_cpumask_var(&rcu_nocb_mask);
> -       if (!strcasecmp(str, "all"))
> +       if (cpulist_parse(str, rcu_nocb_mask)) {
> +               pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
>                 cpumask_setall(rcu_nocb_mask);
> -       else
> -               if (cpulist_parse(str, rcu_nocb_mask)) {
> -                       pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
> -                       cpumask_setall(rcu_nocb_mask);
> -               }
> +       }
>         return 1;
>  }
>  __setup("rcu_nocbs=", rcu_nocb_setup);
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 6e6e835..9f8ff72 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -2,6 +2,7 @@
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/bitops.h>
> +#include <linux/string.h>
>  #include <linux/cpumask.h>
>  #include <linux/export.h>
>  #include <linux/memblock.h>
> @@ -104,6 +105,11 @@ EXPORT_SYMBOL(cpumask_next_wrap);
>   */
>  int cpulist_parse(const char *buf, struct cpumask *dstp)
>  {
> +       if (!strcmp(buf, "all")) {
> +               cpumask_setall(dstp);
> +               return 0;
> +       }

I like the extensions. Can you move this chunk inside  bitmap_parselist()
to let other users like nodelist_parse() use it?

>         return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
>  }
>  EXPORT_SYMBOL(cpulist_parse);
> --
> 2.9.5
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9727A423
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI0Uzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 16:55:55 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:1181 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgI0Uzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 16:55:54 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="469746023"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 22:55:53 +0200
Date:   Sun, 27 Sep 2020 22:55:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     corbet@lwn.net, michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        linux-doc@vger.kernel.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 1/2] scripts: coccicheck: Change default value
 for    parallelism
In-Reply-To: <3beb97122995eafe3f0b831e36167b1edadb47c5.1600945451.git.sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2009272255220.20726@hadrien>
References: <cover.1600945451.git.sylphrenadin@gmail.com> <3beb97122995eafe3f0b831e36167b1edadb47c5.1600945451.git.sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Sep 2020, Sumera Priyadarsini wrote:

> By default, coccicheck utilizes all available threads to implement
> parallelisation. However, when all available threads are used,
> a decrease in performance is noted. The elapsed time is  minimum
> when at most one thread per core is used.
>
> For example, on benchmarking the semantic patch kfree.cocci for
> usb/serial using hyperfine, the outputs obtained for J=5 and J=2
> are 1.32 and 1.90 times faster than those for J=10 and J=9
> respectively for two separate runs. For the larger drivers/staging
> directory, minimium elapsed time is obtained for J=3 which is 1.86
> times faster than that for J=12. The optimal J value does not
> exceed 6 in any of the test runs. The benchmarks are run on a machine
> with 6 cores, with 2 threads per core, i.e, 12 hyperthreads in all.
>
> To improve performance, modify coccicheck to use at most only
> one thread per core by default.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

I have applied this one, so just the patch on the docuemtnation needs to
be improved.

julia

>
> ---
> Changes in V2:
> 	- Change commit message as suggested by Julia Lawall
> Changes in V3:
> 	- Use J/2 as optimal value for machines with more
> than 8 hyperthreads as well.
> ---
>  scripts/coccicheck | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328210ac..a72aa6c037ff 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -75,8 +75,13 @@ else
>          OPTIONS="--dir $KBUILD_EXTMOD $COCCIINCLUDE"
>      fi
>
> +    # Use only one thread per core by default if hyperthreading is enabled
> +    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
> +	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
> +		NPROC=$((NPROC/2))
> +	fi
>      else
>          NPROC="$J"
>      fi
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3227A2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI0Tff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:35:35 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33346 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbgI0Tff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:35:35 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="469742917"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:35:32 +0200
Date:   Sun, 27 Sep 2020 21:35:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>, lkp <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH]
 checkpatch: Add test for comma use that should be semicolon)
In-Reply-To: <983c49ebe4bbe0435a73d25cd8525764a4f8adac.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009272132110.2839@hadrien>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>  <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>  <alpine.DEB.2.22.394.2009271907270.2839@hadrien> <983c49ebe4bbe0435a73d25cd8525764a4f8adac.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 27 Sep 2020, Joe Perches wrote:

> On Sun, 2020-09-27 at 19:08 +0200, Julia Lawall wrote:
> > I end up with 208 patches.  I'm not sure that sending them all at once
> > would be a good idea...
>
> Last I looked the diffstat for comma -> semicolon was:
>
> 234 files changed, 509 insertions(+), 509 deletions(-)
>
> So it would be nearly 1 patch per individual file,

I have 282 files.

>
> Greg KH does send hundreds of patches for -stable at a time.
>
> So, maybe or maybe not send them all at once.
> Maybe send it in batches of 25 or so.
>
> There's no single right way to do this.
>
> Maybe put up a git tree somewhere and let the
> kernel-robot test compilation.

I compiled all but about 15 and checked those 15 an extra time.

I'll try the small batch approach to get started.

thanks,
julia

> (A nicety might be for the kernel-robot to have some
>  option to test pre and post compilation object code
>  differences with an optional report)
>
> When I automated 491 patches for /* fallthrough */ to
> fallthrough;, the robot caught a couple problems which
> was great.
>
> https://repo.or.cz/linux-2.6/trivial-mods.git/shortlog/refs/heads/20200310_fallthrough_2
>
> I only posted the first ~30 patches though with
> about 50% acceptance. Gustavo Silva picked up the
> effort and did a great job.  Eventually, a single
> treewide patch was posted and accepted by Linus for
> this though after dozens of individual patches went
> through various maintainer trees:
>
> $ git log --shortstat -1 df561f6688fe
> commit df561f6688fef775baa341a0f5d960becd248b11
> Author: Gustavo A. R. Silva <gustavoars@kernel.org>
> Date:   Sun Aug 23 17:36:59 2020 -0500
>
>     treewide: Use fallthrough pseudo-keyword
>
>     Replace the existing /* fall through */ comments and its variants with
>     the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
>     fall-through markings when it is the case.
>
>     [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=>
>
>     Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
>  1148 files changed, 2667 insertions(+), 2737 deletions(-)
>
>
>

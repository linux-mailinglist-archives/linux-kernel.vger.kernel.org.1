Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4457827A220
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI0Rpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:45:50 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:60032 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgI0Rpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:45:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 7921C1730858;
        Sun, 27 Sep 2020 17:45:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3743:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6742:7903:7974:8985:9025:9121:10004:10400:10471:10848:11232:11233:11658:11914:12043:12262:12297:12438:12555:12663:12679:12740:12760:12895:12903:12986:13069:13161:13229:13255:13311:13357:13439:13618:14181:14659:14721:14764:21080:21325:21365:21451:21627:21740:30012:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cry47_3d0f42d2717a
X-Filterd-Recvd-Size: 3344
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Sep 2020 17:45:46 +0000 (UTC)
Message-ID: <983c49ebe4bbe0435a73d25cd8525764a4f8adac.camel@perches.com>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
 [PATCH] checkpatch: Add test for comma use that should be semicolon)
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@shadowen.org>, lkp <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date:   Sun, 27 Sep 2020 10:45:45 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009271907270.2839@hadrien>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
         <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
         <alpine.DEB.2.22.394.2009271907270.2839@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-27 at 19:08 +0200, Julia Lawall wrote:
> I end up with 208 patches.  I'm not sure that sending them all at once
> would be a good idea...

Last I looked the diffstat for comma -> semicolon was:

234 files changed, 509 insertions(+), 509 deletions(-)

So it would be nearly 1 patch per individual file,

Greg KH does send hundreds of patches for -stable at a time.

So, maybe or maybe not send them all at once.
Maybe send it in batches of 25 or so.

There's no single right way to do this.

Maybe put up a git tree somewhere and let the
kernel-robot test compilation.

(A nicety might be for the kernel-robot to have some
 option to test pre and post compilation object code
 differences with an optional report)

When I automated 491 patches for /* fallthrough */ to
fallthrough;, the robot caught a couple problems which
was great.

https://repo.or.cz/linux-2.6/trivial-mods.git/shortlog/refs/heads/20200310_fallthrough_2

I only posted the first ~30 patches though with
about 50% acceptance. Gustavo Silva picked up the
effort and did a great job.  Eventually, a single
treewide patch was posted and accepted by Linus for
this though after dozens of individual patches went
through various maintainer trees:

$ git log --shortstat -1 df561f6688fe
commit df561f6688fef775baa341a0f5d960becd248b11
Author: Gustavo A. R. Silva <gustavoars@kernel.org>
Date:   Sun Aug 23 17:36:59 2020 -0500

    treewide: Use fallthrough pseudo-keyword
    
    Replace the existing /* fall through */ comments and its variants with
    the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
    fall-through markings when it is the case.
    
    [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=>
    
    Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

 1148 files changed, 2667 insertions(+), 2737 deletions(-)



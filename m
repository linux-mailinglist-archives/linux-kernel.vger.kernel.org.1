Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5227B3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1R51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:57:27 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:48790 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726327AbgI1R50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:57:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 387CF182CF665;
        Mon, 28 Sep 2020 17:57:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:599:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2197:2199:2200:2393:2525:2553:2560:2563:2682:2685:2689:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4384:4605:5007:6119:6121:7903:9025:9388:10004:10400:10848:11026:11232:11658:11914:12295:12296:12297:12740:12760:12895:13255:13439:14180:14181:14659:14721:21060:21080:21221:21324:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: smell94_24172cc27183
X-Filterd-Recvd-Size: 3389
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Sep 2020 17:57:23 +0000 (UTC)
Message-ID: <25aa56e1f7943f9ac535fa184465a752aa00a4b4.camel@perches.com>
Subject: Re: [PATCH 03/18] [ARM] pata_icside: use semicolons rather than
 commas to separate statements
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Sep 2020 10:57:22 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009281909000.2650@hadrien>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
         <1601233948-11629-4-git-send-email-Julia.Lawall@inria.fr>
         <8cf2fad1659acd756703deb106d55483bd1e1eb9.camel@perches.com>
         <alpine.DEB.2.22.394.2009281909000.2650@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-28 at 19:11 +0200, Julia Lawall wrote:
> 
> On Mon, 28 Sep 2020, Joe Perches wrote:
> 
> > On Sun, 2020-09-27 at 21:12 +0200, Julia Lawall wrote:
> > > Replace commas with semicolons.  What is done is essentially described by
> > > the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> > 
> > Hi Julia.
> > 
> > How did you decide on this patch subject header line?
> > 
> > It's certainly reasonable, but not what I would expect
> > from any automation.
> 
> Most of the patches on this file touch other files as well.  There are
> four that only touch this file.  One has no subsystem.  One has dma as the
> subsystem.  Two have pata_icside, so that was chosen.

So did you select the patch subject without any automation
or did you create a tool that looks only at commits for
individual files?

> > $ git log --no-merges --format='%s' drivers/ata/pata_icside.c | \
> >   cut -f1 -d":" | sort | uniq -c | sort -rn
> >      10 libata
> >       5 libata-sff
> >       2 [ARM] pata_icside
> >       2 [ARM] ecard
> >       2 [ARM] dma

Yeah...

Something like the script below and some examples of its use?

$ cat find_best_header.sh
#!/bin/bash

# Show possible patch subject prefixes for a file in git

# use commits that modify only the single file argument and
# emit up to the 5 most common commit prefixes

git log --no-merges --format='%h' -- $1 |
    while read commit ; do
	if [[ $(git log --format='%h' --name-only -1 $commit | wc -l) == 3 ]] ; then
	    git log --format='%s' -1 $commit
	fi
    done |
    cut -f1 -d":" | cut -f1-3 -d" " | sort | uniq -c | sort -rn | head -5

$ ./find_best_header.sh drivers/ata/pata_icside.c
      2 [ARM] pata_icside
      1 Fix pata_icside build
      1 [ARM] dma

$ ./find_best_header.sh kernel/fork.c
     36 fork
     14 kernel/fork.c
      6 mm
      4 pidns
      4 [PATCH] unshare system

$ ./find_best_header.sh kernel/sched/core.c
    150 sched
    110 sched/core
     12 sched/uclamp
     12 sched/debug
     10 sched/deadline

$ ./find_best_header.sh drivers/iio/pressure/mpl115.c
      3 iio



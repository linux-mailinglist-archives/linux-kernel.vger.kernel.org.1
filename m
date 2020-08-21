Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0624DC96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgHURFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 13:05:40 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:54010 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728084AbgHURFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:05:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E99E718020C34;
        Fri, 21 Aug 2020 17:05:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:8527:8985:9010:9025:10004:10400:10848:11232:11658:11914:12043:12295:12297:12555:12740:12760:12895:12986:13161:13184:13229:13439:14096:14097:14181:14659:14721:21080:21433:21627:21740:21819:30022:30034:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: kick55_520a7402703a
X-Filterd-Recvd-Size: 3116
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 17:05:17 +0000 (UTC)
Message-ID: <8213206d4764375f32cbea36ea214573248094dc.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Date:   Fri, 21 Aug 2020 10:05:16 -0700
In-Reply-To: <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
References: <20200821154848.GI7871@localhost.localdomain>
         <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 10:45 -0600, Rob Herring wrote:
> +Joe Perches
> 
> On Fri, Aug 21, 2020 at 9:48 AM Steve Wahl <steve.wahl@hpe.com> wrote:
> > 
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> 
> get_maintainers.pl doesn't work on MAINTAINERS. You need to send this
> to the maintainers of the files listed in the entry below. Looks like
> that would be the x86 maintainers.
> 
> 
> What did Mauro, David and I do to become MAINTAINERS maintainers?
> 
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> (commit_signer:127/806=16%,authored:80/806=10%)
> Rob Herring <robh@kernel.org> (commit_signer:103/806=13%)
> "David S. Miller" <davem@davemloft.net> (commit_signer:99/806=12%)
> linux-kernel@vger.kernel.org (open list)
> 
> 
> Can we make --no-git-fallback the default? It's useful for
> informational purposes, but never for who to email patches to. Having
> no output would be better, then submitters have to think about where
> to send patches.

Doubtful that improves things.  At least the --git-fallback option
shows who modified or got patches accepted to files that are
nominally unmaintained.  It also shows the upstream path for those
files via Signed-off-by: lines so I think --git-fallback is generally
a good mechanism and control flag for directly unmaintained files.

> What ever happened to splitting up MAINTAINERS to subdirectories? That
> would help routing MAINTAINERS changes to the right maintainers.

Splitting MAINTAINERS into subdirectories would do nothing
to route patches.  It would just be convenience to reduce
the total number of changes to a single file.

Those large number of changes to the single MAINTAINERS file
very rarely have any conflicts either, so it wouldn't really
change the overall number of changes to MAINTAINERS entries
spread around the tree.

You are be welcome to try to split the file and get Linus to
accept it.  I gave it a go.  Try yourself.

https://lore.kernel.org/patchwork/patch/817857/



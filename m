Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F871CFA81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgELQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:23:49 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:35566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgELQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:23:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5274B180A9553;
        Tue, 12 May 2020 16:23:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:560:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2693:2731:2828:2895:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6238:7875:9010:10004:10400:10450:10455:10848:11232:11473:11658:11914:12043:12297:12555:12740:12760:12895:12986:13138:13149:13161:13229:13230:13231:13439:13870:14096:14097:14180:14181:14659:14721:19904:19999:21060:21080:21324:21451:21627:21740:21741:30030:30034:30054:30070:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: ice59_5b42530d4ca5b
X-Filterd-Recvd-Size: 2966
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 May 2020 16:23:46 +0000 (UTC)
Message-ID: <80146d5713f8579a92b4da1e2b7d7626999dd9be.camel@perches.com>
Subject: Re: MAINTAINERS: Wrong ordering in VIRTIO BALLOON
From:   Joe Perches <joe@perches.com>
To:     David Hildenbrand <david@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 May 2020 09:23:45 -0700
In-Reply-To: <bb2eea77-72df-6c53-5397-de057ffc9dd8@redhat.com>
References: <alpine.DEB.2.21.2005120717260.3701@felia>
         <bb2eea77-72df-6c53-5397-de057ffc9dd8@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-12 at 08:38 +0200, David Hildenbrand wrote:
> On 12.05.20 07:21, Lukas Bulwahn wrote:
> > Hi David,
> > 
> > with your commit 6d6b93b9afd8 ("MAINTAINERS: Add myself as virtio-balloon 
> > co-maintainer"), visible on next-20200508, ./scripts/checkpatch.pl -f 
> > MAINTAINERS complains:
> > 
> > WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> > #17982: FILE: MAINTAINERS:17982:
> > +F:	include/uapi/linux/virtio_balloon.h
> > +F:	include/linux/balloon_compaction.h
> > 
> > This is due to wrong ordering of the entries in your submission. If you 
> > would like me to send you a patch fixing that, please just let me know.
> > 
> > It is a recent addition to checkpatch.pl to report ordering problems in 
> > MAINTAINERS, so you might have not seen that at submission time.
> 
> Thanks for the notification Lukas,
> 
> b962ee8622d0 ("checkpatch: additional MAINTAINER section entry ordering
> checks") is not in Linus' tree yet AFAIKS.
> 
> I can see that 3b50142d8528 ("MAINTAINERS: sort field names for all
> entries") is upstream. I do wonder if we should just do another batch
> update after the checkpatch patch is upstream instead, I guess more will
> pile up?
> 
> @mst, joe, what do you prefer?
> 
> 1. I can resend the original patch.
> 2. Lukas can send a fixup that we might want to squash.
> 3. We wait until the checkpatch change goes upstream and to a final
> batch update.

A fixup patch would work.

I think if Linus every once in awhile just before an -rc1 runs
scripts/parse-maintainers like:

commit 3b50142d8528 ("MAINTAINERS: sort field names for all entries")

then these sorts of individual patches would not matter much.

This first time the script was run, I think there was just 1 patch
conflict from -next to Linus' tree, and that scripted change was
fairly large.

As the changes will generally be smaller in the future, it's unlikely
there will be a significant number of conflicts.



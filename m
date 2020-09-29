Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E16E27BEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgI2IIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:08:37 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:41372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgI2IIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:08:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E259A837F24D;
        Tue, 29 Sep 2020 08:08:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:2890:3138:3139:3140:3141:3142:3308:3351:3622:3865:3866:3867:3868:3871:3873:3874:4042:4321:5007:6119:6120:6691:7875:7903:10004:10400:10848:11232:11658:11914:12114:12297:12740:12760:12895:13069:13255:13311:13357:13439:14659:21067:21080:21450:21627:30001:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: maid67_5512bab27188
X-Filterd-Recvd-Size: 1508
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Sep 2020 08:08:35 +0000 (UTC)
Message-ID: <c04c10773d5fd12fac67d0dc9ebab46d41962376.camel@perches.com>
Subject: Re: [RFC PATCH] scripts/most_common_subject_prefix.pl: Find the
 most common commit subject prefix
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 29 Sep 2020 01:08:33 -0700
In-Reply-To: <alpine.DEB.2.22.394.2009290941260.2808@hadrien>
References: <e949cb8f12caec813c22dc3791a92e9f87670a5b.1601356990.git.joe@perches.com>
         <alpine.DEB.2.22.394.2009290941260.2808@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-29 at 09:45 +0200, Julia Lawall wrote:
> On Mon, 28 Sep 2020, Joe Perches wrote:
> < This will emit a single line that is the most commonly used commit
> > subject prefix up to and including the last colon of the commit subject
> > for commits that _only_ include the specific file and not any other file.
> 
> For the comma->semicolon patches, I noticed the need for a number of
> suject lines of the form:
> 
> hwrng: xxx - patch description
> 
> So maybe other delimiters have to be taken into account.

Maybe. Can you provide a few more examples?


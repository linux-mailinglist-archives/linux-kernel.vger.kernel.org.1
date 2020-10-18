Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3929163E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgJRGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 02:20:29 -0400
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:35668 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgJRGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 02:20:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BE8F718225E13;
        Sun, 18 Oct 2020 06:20:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:9010:10004:10400:10848:11232:11658:11914:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21063:21080:21627:21740:30054:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rake08_5a151d22722c
X-Filterd-Recvd-Size: 2202
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 06:20:26 +0000 (UTC)
Message-ID: <eda7a64b4af42ba1fb66a5b3704780cf3f761951.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add new exception to repeated word check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 17 Oct 2020 23:20:25 -0700
In-Reply-To: <CABJPP5DuQ_Y0LLS5BzNXUWyxjzp9ts5kgEH-3+7Pn7PPjq0Ljg@mail.gmail.com>
References: <20201017162732.152351-1-dwaipayanray1@gmail.com>
         <1ad9c5f49e10a192f0c6efb1116f3f0d31adce74.camel@perches.com>
         <CABJPP5DuQ_Y0LLS5BzNXUWyxjzp9ts5kgEH-3+7Pn7PPjq0Ljg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-17 at 22:19 +0530, Dwaipayan Ray wrote:
> On Sat, Oct 17, 2020 at 10:03 PM Joe Perches <joe@perches.com> wrote:
> > On Sat, 2020-10-17 at 21:57 +0530, Dwaipayan Ray wrote:
> > > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > > moved the repeated word test to check for more file types. But after
> > > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > > new warnings of the type:
> > 
> > NAK.
> > 
> > Slow down and test before you send more patch versions.
> > 
> > > +                             next if (index(" \t.,;?!", $end_char) == -1);
> > 
> > what does this do?
> 
> Um, it checks if end_char is not present in " \t.,;?!".
> If end_char doesn't belong to this list, then the check shall
> skip. That is the test will skip for "word word:", but will produce
> a warning for "word word." or "word word?", etc.
> 
> Shouldn't this itself be the case or am I perhaps going wrong
> somewhere?

No, you were right, I was being a numbskull.

btw: I think this should set
	my $end_char = ' ';
not '' 

so that if the last word on a line is a
repeat the test still works.



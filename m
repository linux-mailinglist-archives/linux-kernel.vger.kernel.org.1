Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18B2918D2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgJRS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 14:27:02 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:40318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727094AbgJRS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 14:27:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6B0E9837F24A;
        Sun, 18 Oct 2020 18:27:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:2902:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6248:7903:7974:10004:10400:10848:11232:11289:11658:11914:12043:12297:12438:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14180:14181:14659:14721:14777:21060:21080:21325:21365:21433:21451:21627:21740:21741:21819:21939:30022:30029:30054:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dad38_590e2f027230
X-Filterd-Recvd-Size: 2921
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 18:27:00 +0000 (UTC)
Message-ID: <3d9ef962b7007308a538e42375adf09d058ee8ab.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in
 git
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 18 Oct 2020 11:26:59 -0700
In-Reply-To: <CAMuHMdUp5U0nnp9LfWgY0VnkRppMVXZU9NSpWqcMKYM_zRXRuA@mail.gmail.com>
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
         <CAMuHMdV8FEPhTp653RN00LK4UcQZHkuLByJzqiM85r2qoqhDvQ@mail.gmail.com>
         <fce55e74e4331c6e19c4030a4e02fb35ca5ee4f7.camel@perches.com>
         <CAMuHMdUp5U0nnp9LfWgY0VnkRppMVXZU9NSpWqcMKYM_zRXRuA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-18 at 20:15 +0200, Geert Uytterhoeven wrote:
> Hi Joe,

rehi Geert

> On Sun, Oct 18, 2020 at 6:07 PM Joe Perches <joe@perches.com> wrote:
> > On Sun, 2020-10-18 at 16:03 +0200, Geert Uytterhoeven wrote:
[]
> > > This is now commit f5f613259f3fea81 ("checkpatch: allow not using -f
> > > with files that are in git"), causing:
> > > 
> > >     Global symbol "$gitroot" requires explicit package name (did you
> > > forget to declare "my $gitroot"?) at scripts/checkpatch.pl line 980.
> > >     Execution of scripts/checkpatch.pl aborted due to compilation errors.
[]
> > I believe there is a dependency on another patch
> > in -next that wasn't pushed to Linus' tree.
> > 
> > commit 5ec1f7de97b26a3fa364bbb31fdd2e42c8e6fa22
> > Author: Joe Perches <joe@perches.com>
> > Date:   Thu Oct 8 11:53:44 2020 +1100
> > 
> >     checkpatch: test $GIT_DIR changes
> > 
> > So it'd be better to revert right now until
> > this other patch is accepted or pushed.
> 
> Thanks, after cherry-picking that one from next, checkpatch works again.
> However, there are some issues with that commit:
>   1. ERROR: Missing Signed-off-by: line by nominal patch author 'Joe
> Perches <joe@perches.com>',
>   2. The Link: is bogus, and gives 404.

I generally create patches against -next.

The above commit was a test patch for Andrew who
had some inconvenience because he doesn't generally
use git or has a git repo in some non-standard path.

I believe it works well enough to be OK, but I
didn't test it and don't have the same setup.

I'll post it again as a reply to this email with a
with a sign-off and a better commit description and
Linus/Andrew can decide if it's better to revert
f5f613259f3f or apply it separately.



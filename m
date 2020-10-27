Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C729C945
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504120AbgJ0TwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:52:04 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:60186 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503972AbgJ0TwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:52:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A213063D;
        Tue, 27 Oct 2020 19:52:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2911:3138:3139:3140:3141:3142:3353:3742:3865:3866:3867:3868:3870:3871:3874:4250:4321:4425:5007:6117:7903:9010:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13146:13161:13229:13230:13311:13357:13439:14096:14097:14659:14721:21080:21433:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: soap06_23053322727e
X-Filterd-Recvd-Size: 2922
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Oct 2020 19:51:58 +0000 (UTC)
Message-ID: <a4c58c21f0361f844588f5479f6fee33dc1a1dae.camel@perches.com>
Subject: Re: Subject: [RFC] clang tooling cleanups
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Julia.Lawall@lip6.fr,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
Date:   Tue, 27 Oct 2020 12:51:57 -0700
In-Reply-To: <8abd1e5a-511a-e4f6-6f2c-a045d33fa2aa@redhat.com>
References: <20201027164255.1573301-1-trix@redhat.com>
         <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
         <8abd1e5a-511a-e4f6-6f2c-a045d33fa2aa@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Stephen Rothwell)

On Tue, 2020-10-27 at 12:33 -0700, Tom Rix wrote:
> On 10/27/20 11:42 AM, Nick Desaulniers wrote:
> > (cutting down the CC list to something more intimate)

[]

> I am interested in treewide fixes.

As am I, but here the definition of fixes is undefined though.
Whitespace / style changes and other bits that don't change generated
object code aren't considered fixes by many maintainers.

> Cleaning them up (maybe me not doing all the patches) and keeping them clean.
> 
> The clang -Wextra-semi-stmt -fixit will fix all 10,000 problems

I rather doubt there are 10K extra semicolons in the kernel source tree.
Is there a proposed diff/patch posted somewhere?

> This clang tidy fixer will fix only the 100 problems that are 'switch() {};'
> 
> When doing a treewide cleanup, batching a bunch of fixes that are the same problem and fix 
> is much easier on everyone to review and more likely to be accepted.

That depends on the definition of batching.

If individual patches are sent to multiple maintainers, the
acceptance / apply rate seems always < 50% and some are rejected
outright by various maintainers as "unnecessary churn".

Single treewide patches are generally not applied unless by Linus.
The trivial tree isn't widely used for this.

Perhaps a 'scripted' git tree could be established that is integrated
into -next that would allow these automated patches to be better
vetted and increase the acceptance rate of these automated patches.

> Long term, a c/i system would keep the tree clean by running the switch-semi checker/fixer. 
> And we can all move onto the next problem.

Good idea...
I hope a scripted patches mechanism will be established.



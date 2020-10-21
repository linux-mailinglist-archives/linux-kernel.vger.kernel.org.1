Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6729545A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506334AbgJUVlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:41:14 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:52098 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506318AbgJUVlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:41:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A250518002A38;
        Wed, 21 Oct 2020 21:41:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2894:2895:2909:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3874:4250:4321:5007:6742:8568:10004:10400:10450:10455:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:13618:14096:14097:14181:14659:14721:19904:19999:21080:21627:30016:30029:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: debt45_550e0712724b
X-Filterd-Recvd-Size: 2443
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 21:41:07 +0000 (UTC)
Message-ID: <12bc8364008f797324097fb1974da1c0f75776b0.camel@perches.com>
Subject: Re: [GIT PULL] prandom32 changes for v5.10
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marc Plumb <lkml.mplumb@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Amit Klein <aksecurity@gmail.com>,
        George Spelvin <lkml@sdf.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Oct 2020 14:41:06 -0700
In-Reply-To: <CAHk-=wi9Oe=NCG_S1X-rSFwkWe=vK7GYUHp22PFWa2W47WnzKA@mail.gmail.com>
References: <20201012203226.GA11861@1wt.eu>
         <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
         <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
         <20201021032725.GB396@1wt.eu>
         <6700002d-e775-4c6b-5ebc-2d6a872f1a62@gmail.com>
         <432132f9c678dc5093fd85055e5b708584018a0d.camel@perches.com>
         <CAHk-=wi9Oe=NCG_S1X-rSFwkWe=vK7GYUHp22PFWa2W47WnzKA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-21 at 14:35 -0700, Linus Torvalds wrote:
> On Wed, Oct 21, 2020 at 2:20 PM Joe Perches <joe@perches.com> wrote:
> > While secure solutions are useful, I really wonder if
> > "George Spelvin" is a real person.
> 
> It's not his real name, no, but he's a real person.
> 
> I do have his real name from years ago when I needed to confirm his
> identity for sign-offs (I forget what for, I think it was some dcache
> name hashing thing).
> 
> So I can confirm he's a real person who just wants to keep private,
> and is competent when it comes to hashing and security.

I hope that real name is in some escrow somewhere and
not just in some long thrown away spinning rust disk.

And because George isn't a real name and contributions
by him have been accepted, the DCO should be updated
to show how pseudonymous contributions can be made.



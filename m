Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839E295410
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506065AbgJUVUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:20:17 -0400
Received: from smtprelay0139.hostedemail.com ([216.40.44.139]:47498 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440919AbgJUVUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:20:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id BD569180A7FDF;
        Wed, 21 Oct 2020 21:20:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2525:2538:2553:2560:2563:2682:2685:2692:2693:2828:2859:2892:2917:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4470:4605:5007:6742:7903:7904:8568:8985:9025:9108:9121:10004:10400:10450:10455:10848:11232:11233:11658:11914:12043:12297:12663:12683:12740:12760:12895:13019:13161:13229:13439:14181:14659:14721:19904:19999:21080:21451:21627:21740:30029:30054:30060:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: moon29_12066032724b
X-Filterd-Recvd-Size: 3546
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 21:20:13 +0000 (UTC)
Message-ID: <432132f9c678dc5093fd85055e5b708584018a0d.camel@perches.com>
Subject: Re: [GIT PULL] prandom32 changes for v5.10
From:   Joe Perches <joe@perches.com>
To:     Marc Plumb <lkml.mplumb@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amit Klein <aksecurity@gmail.com>, George Spelvin <lkml@sdf.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Florian Westphal <fw@strlen.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 21 Oct 2020 14:20:12 -0700
In-Reply-To: <6700002d-e775-4c6b-5ebc-2d6a872f1a62@gmail.com>
References: <20201012203226.GA11861@1wt.eu>
         <CANEQ_+Jyf-MZEsvT5iMu0a=waJCiAKdLaOfLHe_py6AXOt-hjQ@mail.gmail.com>
         <CAHk-=wioF37gX6iMCguGi7XrpBQqMiJ_5HjQ=dJQas_np8_MyQ@mail.gmail.com>
         <20201021032725.GB396@1wt.eu>
         <6700002d-e775-4c6b-5ebc-2d6a872f1a62@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-21 at 13:52 -0700, Marc Plumb wrote:
> As one of the participants, I mostly backed off when Spelvin seemed to 
> be more aggressively driving a secure solution.

While secure solutions are useful, I really wonder if
"George Spelvin" is a real person.

https://en.wikipedia.org/wiki/George_Spelvin

_If_ "George Spelvin" is a pseudonym, (apologies if it is not),
should anything with that signature be added to the kernel?

The Developer's Certificate of Origin says that no pseudonyms
are allowed.

---

Developer's Certificate of Origin 1.1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.

then you just add a line saying::

	Signed-off-by: Random J Developer <random@developer.example.org>

using your real name (sorry, no pseudonyms or anonymous contributions.)
This will be done for you automatically if you use ``git commit -s``.




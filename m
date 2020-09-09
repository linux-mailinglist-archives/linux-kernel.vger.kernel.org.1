Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FD262E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 14:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIIMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 08:13:38 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:49916 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730174AbgIIMDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:03:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D2987100E7B43;
        Wed,  9 Sep 2020 12:02:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2691:2693:2828:2911:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4425:5007:6119:7903:8526:9010:10004:10226:10400:10450:10455:10471:10848:11232:11658:11914:12114:12297:12663:12740:12760:12895:13095:13200:13229:13255:13439:13618:13972:14096:14097:14181:14659:14721:19904:19999:21080:21212:21324:21433:21450:21627:21660:21740:21939:30029:30045:30047:30054:30060:30071:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: touch41_4202f16270dd
X-Filterd-Recvd-Size: 3596
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Sep 2020 12:02:12 +0000 (UTC)
Message-ID: <1d6548cc89bf89a0bea9a2d84a94a01cebc4ec7b.camel@perches.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] checkpatch: GIT_COMMIT_ID:
 handle commit messages with multiple quotes
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, Ayush <ayush@disroot.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Sep 2020 05:02:11 -0700
In-Reply-To: <alpine.DEB.2.21.2009091324590.5622@felia>
References: <alpine.DEB.2.21.2009091152530.5622@felia>
         <beed63208cc412f122fe273602675801add08ede.camel@perches.com>
         <20200907151417.44453-1-ayush@disroot.org>
         <22db634e7be36f4514f0c9b3ecf0060a@disroot.org>
         <3dea1eefdbbf97791bed3f838d4f06a7@disroot.org>
         <alpine.DEB.2.21.2009091324590.5622@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-09 at 13:32 +0200, Lukas Bulwahn wrote:
> dropped the maintainers.
> 
> On Wed, 9 Sep 2020, Ayush wrote:
> 
> > Sir,
> > 
> > > As the mentor in the linux kernel community bridge program, I usually
> > > inform the mentees when the review on the mentee mailing list has
> > > successfully concluded to a first acceptable state and I think it is well
> > > advised to reach out to the maintainers for further discussion.
> > > 
> > > You did not do that, but just send some patch to the maintainers.
> > > That is fully up to you, but I will not support the patch acceptance in
> > > any way, and it suggests that you do not see the need to be mentored.
> > > 
> > > If you can land patches without mentoring support successfully, that is
> > > great, but then you do not need a mentorship.
> > 
> > I am extremely sorry for my mistakes. It won't happen again.
> >  
> > > Now, to the commit:
> > > 
> > > Ayush, your commit message is largely incomprehensible.
> > > 
> > > Your follow-up explanation that was needed should have been in the commit
> > > message in the first place.
> > 
> > It was my first patch, so I had very little idea of forming commit messages. 
> > I will discuss it with mentors next time before sending the patch next time.
> > 
> 
> Let us start with the simpler patch and then see if you can write a commit 
> message that convinces Joe to ack your patch.
>  
> > > Ayush, you did not sign-off with your full legal name.
> > 
> > My legal name according to all official identification documents of India is Ayush. 
> > I have no surname registered legally.
> > So should I include "Ayush <ayush@disroot.org>"  or do I need to include my last name too (Which is Ayush only)?
> > 
> 
> Okay. If you say so, I cannot judge but you should try to use a name that 
> others can with a fair chance uniquely identify that is you.
> 
> The name is used in git log summaries, pull requests, etc.; so, it should 
> be a name that with high chance to refer to one person.
> 
> Maybe you find a good way that works as suitable name for 
> unique identification?

I believe the Developer's Certificate of Origin (DCO) in
Documentation/pr
ocess/submitting-patches.rst just asks
for a "full name".

If Ayush has no surname, then I imagine that his actual
full name Ayush should be good enough for the DCO.

A line like "Signed-off-by: Ayush <ayush@disroot.org>"
should be fine.



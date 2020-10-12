Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6866228BF51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390821AbgJLSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:03:42 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:51082 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389885AbgJLSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:03:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C9FD1100E7B48;
        Mon, 12 Oct 2020 18:03:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3167:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7903:8907:9108:10004:10400:10450:10455:10848:11232:11658:11914:12297:12663:12679:12740:12760:12895:13069:13160:13229:13255:13311:13357:13439:14096:14097:14659:14721:14777:19904:19999:21080:21433:21451:21627:21740:21819:30022:30026:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: mine76_460606a271fc
X-Filterd-Recvd-Size: 2575
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 18:03:39 +0000 (UTC)
Message-ID: <03d26751ba302dfafeaf11718a26771c2f915ba3.camel@perches.com>
Subject: Re: [PATCH -v4] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 12 Oct 2020 11:03:36 -0700
In-Reply-To: <20201012175545.GJ22829@zn.tnic>
References: <20201010105421.GA24674@zn.tnic>
         <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
         <20201010161112.GC24674@zn.tnic>
         <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
         <20201012142148.GA22829@zn.tnic>
         <b74a95944a4bc6be1ea4ae8cf065c23e03511ba5.camel@perches.com>
         <20201012171544.GH22829@zn.tnic>
         <5590cd3df8b28cdd077230dda8c99e80436bdcf3.camel@perches.com>
         <20201012173142.GI22829@zn.tnic>
         <73e18a141df7a9259ef47363152bc2595b00bda4.camel@perches.com>
         <20201012175545.GJ22829@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-12 at 19:55 +0200, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 10:40:07AM -0700, Joe Perches wrote:
> > Why?  I think it unnecessary.
> 
> Joe, I'm sick'n'tired of debating with you what needs to happen.
> 
> Please forget that patch altogether

Fine by me.

>  - I'll add the functionality to our
> own checker script where I don't need to debate with you what I have to
> and I have not to do.
> 
> And I won't be getting private emails about you teaching me how I should
> have replied to your mail. The only "mistake" I made is even thinking
> about adding this to checkpatch. Won't happen again.

For the record:

My single-line private email to you was not "teaching",
it was just a statement of what I would have preferred.

Just remain the "best you" you want to be...

---

On Mon, 2020-10-12 at 10:41 -0700, Joe Perches wrote:
> On Mon, 2020-10-12 at 19:31 +0200, Borislav Petkov wrote:
> > On Mon, Oct 12, 2020 at 10:17:56AM -0700, Joe Perches wrote:
> > > Workie here.  This is against -next.
> > Nevermind - I had an old version in that branch.
> btw: adding "my mistake" would have been more appreciated...



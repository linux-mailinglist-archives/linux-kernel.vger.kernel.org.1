Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5329782B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756015AbgJWUTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:19:09 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:46266 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756008AbgJWUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:19:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id DD4F21730851;
        Fri, 23 Oct 2020 20:19:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3834:3865:3866:3867:3868:3870:3871:3874:4321:4560:5007:6119:6248:9010:10004:10400:10483:10848:11026:11232:11658:11914:12043:12297:12438:12663:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:14096:14097:14659:14721:14777:19901:19997:21063:21080:21433:21627:21660:30054:30070:30085:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: thing33_0e181ed2725c
X-Filterd-Recvd-Size: 2638
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Oct 2020 20:19:06 +0000 (UTC)
Message-ID: <b2532a0a0032d39657a46198bf572a53232d29a4.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Fri, 23 Oct 2020 13:19:05 -0700
In-Reply-To: <alpine.DEB.2.21.2010232104150.11676@felia>
References: <20201023133828.19609-1-yashsri421@gmail.com>
         <alpine.DEB.2.21.2010232104150.11676@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-23 at 21:06 +0200, Lukas Bulwahn wrote:
> On Fri, 23 Oct 2020, Aditya Srivastava wrote:
> > A quick evaluation on v5.6..v5.8 showed that this fix reduces
> > REPEATED_WORD warnings from 2797 to 907.
> > 
> > A quick manual check found all cases are related to hex output or
> > list command outputs in commit messages.
[] 
> I think this strategy now makes sense and has the right complexity for a 
> good heuristics in this case.

The proper indentation was not followed as described in a previous reply.
This patch also causes conflicts with Dwaipayan's earlier effort.

Lastly, I'm not sure this complexity is worthwhile.

The style is also somewhat complex and doesn't allow for upper and lower
case variants.

I still think that a trivial "is $first hex only" test is simpler.

Perhaps use a hash and an exists test if this is useful at all.

What specific matches were found with this word list?
Why not just add those to the word list?

In all the nearly 1 million commit descriptions in the kernel without
the patch contexts, these were the only hex-like word matches I found
with their count of matches:

76 be
17 Add
13 add
6 dada
2 Bad
2 bad

100 or so false positives in about a million commits isn't many.

dada is not an actual word in a commit message so I suggest
adding hex word like checks only for "be" "add" and "bad".

Maybe "added" too but that hasn't been used as far as I can tell.

But all the other dictionary entries don't appear to be useful.

So maybe something like:

our %allow_repeated_words = (
	add => '',
	added => '',
	bad => '',
	be => '',
);

and

	next if (exists($allow_repeated_words{lc($first)}));


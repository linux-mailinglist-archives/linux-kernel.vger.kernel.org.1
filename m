Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1E2C8E31
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgK3TiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:38:14 -0500
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:35884 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728846AbgK3TiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:38:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 58E7E181D3039;
        Mon, 30 Nov 2020 19:37:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:4321:5007:6119:10004:10400:10848:11232:11658:11914:12043:12297:12740:12895:13069:13160:13229:13311:13357:13439:13894:14180:14659:21080:21627:30054:30062:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: jar12_59094b1273a4
X-Filterd-Recvd-Size: 2194
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Nov 2020 19:37:32 +0000 (UTC)
Message-ID: <ddfde921e75f36cab2cd924d45dfbd11e07c6768.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Mon, 30 Nov 2020 11:37:30 -0800
In-Reply-To: <CABJPP5C0eN5kC8-jB0Bes438GxWbwnNyYeN5a+6uym5MgyuBPw@mail.gmail.com>
References: <20201130144515.8320-1-dwaipayanray1@gmail.com>
         <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
         <CABJPP5BLjbx3FbvB3nAOiHfkRLUo7s0n-vboE+AXJqrZXseUNQ@mail.gmail.com>
         <070109a56817288562a91dfeec74359eb948234e.camel@perches.com>
         <CABJPP5BxO20-YzbTZij4gZGm4R63iG_n2kH58pSz5mgyXXwVBw@mail.gmail.com>
         <40b6e1fa9fc638a7e755f7e91f401b6019fee2fa.camel@perches.com>
         <CABJPP5C0eN5kC8-jB0Bes438GxWbwnNyYeN5a+6uym5MgyuBPw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-30 at 23:56 +0530, Dwaipayan Ray wrote:
> Thanks, this does resolve the original problem, but again the following
> line throws 0 warnings:
> 
> "zeebra" ther, yourr.
> 
> Any punctuation separators are ignored :(
> 
>  (?:^|\s)($misspellings)(?=[\s\.\,\:\;\"\?\!]|$)
> 
> Would this be acceptable rather? But again this doesn't
> handle [therr] or (therr).

No idea.
What does codespell use for its regex?
Maybe that should be used.

Maybe all the added lines should be collected and
codespell should be called on those lines instead.

Try other options and check if the overall cpu/wall clock use is reduced.

Adding codespell's dictionary was kind of a 'nice to have' option and
it's not likely that it matters a lot if it's perfect or not.

My presumption is that it's not frequently used, but hey, who knows.


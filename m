Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302BF1A4AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDJTsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:48:52 -0400
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:49888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDJTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:48:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BD81B2C8B;
        Fri, 10 Apr 2020 19:48:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2110:2198:2199:2393:2559:2562:2689:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3873:3874:4250:4321:4605:5007:7903:10004:10400:10848:11232:11658:11914:12050:12297:12663:12740:12895:13069:13161:13229:13311:13357:13439:13894:14096:14097:14181:14659:14721:21080:21212:21324:21611:21627:21660:21740:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wind68_130abdd8b8d4c
X-Filterd-Recvd-Size: 1972
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Apr 2020 19:48:50 +0000 (UTC)
Message-ID: <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 10 Apr 2020 12:46:49 -0700
In-Reply-To: <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-10 at 19:35 +0200, Christophe JAILLET wrote:
> Le 08/04/2020 à 04:14, Joe Perches a écrit :
> > This works rather better:
> > Perhaps you could test?
[]
> I'm looking at some modification done in the last month that could have 
> been spotted by the above script.
> 
>      ./scripts/checkpatch.pl -f drivers/usb/phy/phy-jz4770.c
> 
> correctly spots the 3 first cases, but the 3 last (line 202, 210 and 
> 217) are missed.
> I don't understand why.

It has to do with checkpatch's single statement parsing.

This case:

	if (foo)
		dev_warn(...);

is parsed as a single statement but

	if (foo) {
		dev_warn(...);
	};

is parsed as multiple statements so for the
second case

		dev_warn(...);

is analyzed as a separate statement.

The regex match for this missing newline test expects
that each printk is a separate statement so the first
case doesn't match.

Clearly the regex can be improved here.

cheers, Joe


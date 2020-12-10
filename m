Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5992D64A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgLJSOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:14:50 -0500
Received: from smtprelay0010.hostedemail.com ([216.40.44.10]:56408 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403993AbgLJSO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:14:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BEBA818029146;
        Thu, 10 Dec 2020 18:13:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4303:4321:5007:8531:10004:10400:10450:10455:10848:11232:11658:11783:11914:12043:12297:12740:12895:13019:13069:13161:13229:13255:13311:13357:13439:13894:14093:14097:14181:14659:19904:19999:21080:21221:21433:21627:21740:30012:30054:30056:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: arm83_08169e1273fa
X-Filterd-Recvd-Size: 1973
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Dec 2020 18:13:42 +0000 (UTC)
Message-ID: <c0382efac23a4fb18f31974b80f25558cada7243.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix "Missing a blank line after
 declarations" test on patches
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 10 Dec 2020 10:13:40 -0800
In-Reply-To: <20201210175235.65657-1-christophe.jaillet@wanadoo.fr>
References: <20201210175235.65657-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-10 at 18:52 +0100, Christophe JAILLET wrote:
> "Missing a blank line after declarations" is not triggered on patches.

That's not true.
It does work on any patch that does a new function addition.
There are some patch context complications here when lines are
added and removed such that '+' add, '-' delete, and ' ' context
testing isn't always obvious.

So, the code was intentionally limited to just new functions.

If there are simple ways to avoid false positives, great, but I
believe it's not trivial.

> Tweak the regex to match such cases.

Please send multiple patch examples of different forms where it
does not work.

> This patch is mostly a PoC. I don't know enough about checkpatch.pl to be
> sure that the fix is the right thing to do.
> At least, it works for me :)

Always a starting point...

> 
> The [\+ ] is taken from the test just above.
> 
> I also wonder if there is a missing ^ in the last test:
>   (($prevline =~ /[\+ ](\s+)\S/) && $sline =~ /^[\+ ]$1\S/))
>                   ^
>                   |___ here




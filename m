Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C71A3C05
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 23:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDIVmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 17:42:43 -0400
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:47544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbgDIVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:42:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2E3DD182CCCD2;
        Thu,  9 Apr 2020 21:42:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3743:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6119:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13095:13311:13357:13439:14040:14096:14097:14659:21080:21212:21433:21627:21660:21790:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wax82_51ab01c676e4b
X-Filterd-Recvd-Size: 2471
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  9 Apr 2020 21:42:41 +0000 (UTC)
Message-ID: <576a57b4c134903e9889cb670ccbb08a47230b6c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 09 Apr 2020 14:40:40 -0700
In-Reply-To: <59d1ef8f-4fb0-9af2-f761-b52559c8a699@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <4b7e1cf3-6fa7-60af-a1d3-2457339dbe8a@wanadoo.fr>
         <efb5a518fdc47f0120b94a7e8a95d275c0f4ad43.camel@perches.com>
         <60c732a1-aa4e-afab-d223-894a67713003@wanadoo.fr>
         <bcdfa5ae68b8cb7d9324a89aedf452f6209b570c.camel@perches.com>
         <05379b22-6755-368b-8127-8827fa020189@wanadoo.fr>
         <f212b3ad6c09e595cb91c2f7e8728d71e27f6833.camel@perches.com>
         <59d1ef8f-4fb0-9af2-f761-b52559c8a699@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-09 at 20:52 +0200, Christophe JAILLET wrote:
> In fact, I don't really see the need to modify many files just for some 
> kind of style.
> (same reason why I think that checkpatch is a better place for a test 
> than submitting hundreds of patches based on coccinelle)
> 
> From your point of view, does auditing and fixing these missing \n make 
> sense?

Not all that much no.  Even the existing conversions
of formats missing newlines isn't all that important.

It's only a consideration for relatively unmaintained
old drivers and arches that still use printk without a
KERN_<LEVEL> where a message might either be interleaved
with a pr_<level> style message without a terminating
newline or by old style messages that should actually
instead be coalesced because the printks don't have
any KERN_<LEVEL>.

> Wouldn't it just be a lot of noise for a small benefit?

Much of the noise has already been filtered out by patches
and the ambient noise is already at a relatively low
level.

Quiet is good though and I think the noise reduction
is useful and quite painless.




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202952E7318
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL2S4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:56:52 -0500
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:52714 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726126AbgL2S4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:56:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 68C28181D3039;
        Tue, 29 Dec 2020 18:56:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3867:3868:3870:3871:3872:3874:4321:5007:6120:7652:10004:10400:10848:11232:11658:11914:12048:12297:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14659:14721:21080:21433:21451:21627:21939:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: son76_1713ca52749e
X-Filterd-Recvd-Size: 1573
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 29 Dec 2020 18:56:10 +0000 (UTC)
Message-ID: <4520e86ead300c92de0736fcb7b1ec3045c34efa.camel@perches.com>
Subject: Re: [RFC PATCH v2 00/19] dynamic debug diet plan
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Date:   Tue, 29 Dec 2020 10:56:08 -0800
In-Reply-To: <20201225201944.3701590-1-jim.cromie@gmail.com>
References: <20201225201944.3701590-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-25 at 13:19 -0700, Jim Cromie wrote:
> Well, we're mostly overeating, but we can all look forward to a diet
> in January.  And more exersize.
> 
> dyndbg's compiled-in data-table currently uses 56 bytes per prdebug;
> this includes 3 pointers to hierarchical "decorator" data, which is
> primarily for adding "module:function:line:" prefixes to prdebug
> messages, and for enabling and modifying those prdebugs selectively.
> 
> This patchset decouples "decorator" data, and makes it optional, and
> disposable.  By separating that data, it opens up possiblities to
> compress it, swap it out, map it selectively, etc.

While this may be somewhat useful, what debugging does it really help?
Are there really memory limited platforms that enable dynamic debug?




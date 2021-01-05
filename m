Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93F12EA6CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbhAEI5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:57:53 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:48806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726982AbhAEI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:57:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 55201100E7B44;
        Tue,  5 Jan 2021 08:57:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:4321:4605:5007:7652:7875:9121:10004:10400:10848:11232:11658:11914:12297:12346:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: snail54_12179a2274d7
X-Filterd-Recvd-Size: 2375
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Jan 2021 08:57:10 +0000 (UTC)
Message-ID: <5f01770454d163605406265b1bf316e0452753cf.camel@perches.com>
Subject: Re: [PATCH v3 3/5] checkpatch: kconfig: enforce help text
 indentation
From:   Joe Perches <joe@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, akpm@linux-foundation.org,
        johannes.czekay@fau.de, linux-kernel@i4.cs.fau.de
Date:   Tue, 05 Jan 2021 00:57:09 -0800
In-Reply-To: <0e8754d14cb5624704159ba85b18f8a6bb703b27.camel@perches.com>
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
         <20210103075015.23946-1-nicolai.fischer@fau.de>
         <20210103075015.23946-4-nicolai.fischer@fau.de>
         <0e8754d14cb5624704159ba85b18f8a6bb703b27.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-01-04 at 14:09 -0800, Joe Perches wrote:
> On Sun, 2021-01-03 at 08:50 +0100, Nicolai Fischer wrote:
> > Adds a new warning in case the indentation level of the
> > first line of a Kconfig help message is not at least two spaces
> > higher than the keyword itself.
> > Blank lines between the message and the help keyword
> > are ignored.
> > 
> > Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
> > Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
> > Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
> > ---
> > 
> > Now matches indentation of two or more spaces, instead of exactly two.
> 
> No, this should match exactly 2 and warn on any other use.

To clarify, only the first line after the help keyword needs to
have a 2 space indent more than the help keyword and the help
block may start with Kconfig keywords.

Subsequent help block lines may have more than 2 chars.

The help block line count should end when the indent is less than
the help keyword indent and is a non-blank line.

This should be valid:

	help
	  line 1
	    -- reason 1
	    -- reason 2
	       continuation
	    -- reason 3

But this should warn only on line 1:

	help
	   line 1 has a 3 space indent
	   -- reason 1
	   -- reason 2
	       continuation
	   -- reason 3



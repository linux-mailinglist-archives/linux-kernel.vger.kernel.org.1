Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017A1BAAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 19:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD0ROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 13:14:31 -0400
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:36250 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgD0ROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:14:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 918CD180A7352;
        Mon, 27 Apr 2020 17:14:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2110:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3871:4250:4321:5007:6119:6691:7522:7875:9545:10004:10400:10848:11232:11658:11914:12295:12297:12740:12760:12895:13069:13071:13161:13229:13255:13311:13357:13439:14180:14659:21060:21080:21451:21627:21740:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: land80_616b262899562
X-Filterd-Recvd-Size: 1600
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Apr 2020 17:14:29 +0000 (UTC)
Message-ID: <ed61ea55a275e520e6245c9fe33f2f076d5cbe3c.camel@perches.com>
Subject: Re: [PATCH 2/2] drivers: staging: rts5208: rtsx.c fix Unbalanced
 braces around else-if statements
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Apr 2020 10:14:28 -0700
In-Reply-To: <20200427160430.GA3549342@kroah.com>
References: <20200427152442.26597-1-john.oldman@polehill.co.uk>
         <20200427152442.26597-2-john.oldman@polehill.co.uk>
         <20200427160430.GA3549342@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 18:04 +0200, Greg KH wrote:
> On Mon, Apr 27, 2020 at 04:24:42PM +0100, John Oldman wrote:
> > Make a better job of fixing coding style issues, this time fixing
> > all blocks as per Joe Perches' comment.
[]
> Why is this not just one patch?

Hi John.

These _should_ be one patch.

The subject line should be versioned and affirmative like:

Subject: [PATCH V2] staging: rts5208: rtsx: Use balanced braces for if/else if blocks

The subject should not include "fix", as this is a coding style
issue and not really a logical defect.

Lastly the "this time fixing" bit should be below the --- line.

cheers, Joe


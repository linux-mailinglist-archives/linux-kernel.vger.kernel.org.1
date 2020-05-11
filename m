Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D7D1CE4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 21:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgEKT4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 15:56:15 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:47656 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729049AbgEKT4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:56:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 820CC837F253;
        Mon, 11 May 2020 19:56:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3870:3871:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21972:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fall43_8d37d983a5062
X-Filterd-Recvd-Size: 1590
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 19:56:10 +0000 (UTC)
Message-ID: <df390f30d2cca58bad013196b443f82e048c528c.camel@perches.com>
Subject: Re: [PATCH] Revert "dynamic_debug: Remove unnecessary __used"
From:   Joe Perches <joe@perches.com>
To:     Elliot Berman <eberman@codeaurora.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     Trilok Soni <tsoni@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Murali Nalajala <mnalajal@codeaurora.org>
Date:   Mon, 11 May 2020 12:56:09 -0700
In-Reply-To: <9b6694ac-acb3-6bc4-49c9-39ad1c64d6e1@codeaurora.org>
References: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
         <59b3e2aac1388209d168a31294dfd2b1f7d21513.camel@perches.com>
         <9b6694ac-acb3-6bc4-49c9-39ad1c64d6e1@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 12:31 -0700, Elliot Berman wrote:
> On 5/11/2020 11:54 AM, Joe Perches wrote> Change-Id: probably isn't necessary.
> 
> Thanks for the catch
> 
> > Is there a separate mechanism possible to avoid bloating the
> > otherwise unused content?
> 
> This struct is being used in lib/dynamic_debug.c but compiler doesn't know
> about this usage when optimizing the struct/branch away.

I only remember that I removed __used awhile ago
because it _wasn't_ used in some paths.

Maybe that's changed, but I don't know.



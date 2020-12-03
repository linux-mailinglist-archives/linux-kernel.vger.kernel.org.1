Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA32CDBA3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436539AbgLCQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:56:38 -0500
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:33996 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725999AbgLCQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:56:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 35ED118224D60;
        Thu,  3 Dec 2020 16:55:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:979:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2892:2902:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3874:4321:4383:4388:4395:5007:7875:10004:10400:10848:11232:11658:11914:12295:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:14777:21080:21433:21450:21451:21627:21819:21939:30022:30054:30056:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: grain99_2c007c7273bd
X-Filterd-Recvd-Size: 2150
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Dec 2020 16:55:56 +0000 (UTC)
Message-ID: <3c11134905f06185dda4e9125f2fb7fd30fff979.camel@perches.com>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Dec 2020 08:55:54 -0800
In-Reply-To: <694039d6e386d999fd74d038cf2627f5b3b0ca71.camel@HansenPartnership.com>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
         <694039d6e386d999fd74d038cf2627f5b3b0ca71.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 05:58 -0800, James Bottomley wrote:
> So there are two embedded questions here: firstly, should we be as
> wedded to clean history as we are, because showing the evolution would
> simply solve this?  Secondly, if we are agreed on clean history, how
> can we make engagement via email as important as engagement via commit
> for the community managers so the Link tag is enough?  I've got to say
> I think trying to add tags to recognize patch evolution is a mistake
> and we instead investigate one of the two proposals above.

I don't care that any trivial style notes I give to anyone
are tracked for posterity.

Who are these 'community managers' that use these?

Signatures are a mechanism for credit tracking isn't great.

One style that seems to have been generally accepted is for
patch revision change logs to be noted below a --- line.

Often that change log will shows various improvements made
to a patch and the people and reasoning that helped make
those improvements.

Perhaps automate a mechanism to capture that information as
git notes for the patches when applied.



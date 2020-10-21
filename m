Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBE22951F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503890AbgJUSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:05:26 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:56340 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438566AbgJUSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:05:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 49EE8181D330D;
        Wed, 21 Oct 2020 18:05:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2890:2901:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:3873:3874:4042:4321:5007:6119:7903:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21450:21451:21627:21660:21740:30001:30054:30055:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: power34_130717c2724a
X-Filterd-Recvd-Size: 2295
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 18:05:24 +0000 (UTC)
Message-ID: <d44e35ec1d923fd09ea6530ca5d1988cc8e59347.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Wed, 21 Oct 2020 11:05:22 -0700
In-Reply-To: <c4f8aae0-d805-8d09-1a87-ba64bc01c29a@gmail.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
         <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
         <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
         <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
         <c4f8aae0-d805-8d09-1a87-ba64bc01c29a@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-21 at 23:25 +0530, Aditya wrote:
> Thanks for your feedback. I ran a manual check using this approach
> over v5.6..v5.8.
> The negatives occurring with this approach are for the word 'be'
> (Frequency 5) and 'add'(Frequency 1). For eg.
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'be'
> #278: FILE: drivers/net/ethernet/intel/ice/ice_flow.c:388:
> + * @seg: index of packet segment whose raw fields are to be be extracted
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'add'
> #21:
> Let's also add add a note about using only the l3 access without l4
> 
> Apart from these, it works as expected. It also takes into account the
> cases for multiple occurrences of hex, as you mentioned. For eg.
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'ffff'
> #15:
[]
> I'll try to combine both methods and come up with a better approach.

Enjoy, but please consider:

If for over 30K patches, there are just a few false positives and
a few false negatives, it likely doesn't need much improvement...

checkpatch works on patch contexts.

It's not intended to be perfect.

It's just a little tool that can help avoid some common defects.



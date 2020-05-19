Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A4C1DA07C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgESTGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:06:49 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:60242 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgESTGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:06:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4C1A9182CED28;
        Tue, 19 May 2020 19:06:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:7901:7903:7974:9025:9040:10004:10400:10848:11232:11658:11914:12043:12262:12297:12438:12663:12679:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:14777:21080:21325:21365:21433:21451:21627:21660:21788:21819:21939:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: cave79_0e050da26d0f
X-Filterd-Recvd-Size: 1827
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 19:06:46 +0000 (UTC)
Message-ID: <f723cce2bcbccbfdf6ebc80d1e68ba4fe10c2aee.camel@perches.com>
Subject: Re: git-send-email: Ability to populate CC using more tags
From:   Joe Perches <joe@perches.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        gitster@pobox.com
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Tue, 19 May 2020 12:06:45 -0700
In-Reply-To: <20200519184041.GB4397@Mani-XPS-13-9360>
References: <20200519184041.GB4397@Mani-XPS-13-9360>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-20 at 00:10 +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> Currently 'git-send-email' lacks the ability to CC people described using
> tags such as Acked-by and Reported-by etc...
> 
> While doing a bit of googling, I found a patch from Joe [1] but that doesn't
> look like made its way. And in that discussion I didn't see any real objections
> for the patch intention apart from the usage of the term 'trailers'.
> 
> So I'm just curious if Joe or anyone has plan to resubmit it! If not I may
> do that.
> 
> PS: 'bylines' as mentioned by Joe seems reasonable to me.
> 
> Thanks,
> Mani
> 
> [1] https://lkml.org/lkml/2016/8/30/650

You need to use the "--misc-by" option.

Perhaps you need to update your git version
as that was added with:

commit ef0cc1df90f6b6c2987ab2db8e0ccf2cfc421edf
Author: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Tue Oct 16 09:39:23 2018 +0200

send-email: also pick up cc addresses from -by trailers



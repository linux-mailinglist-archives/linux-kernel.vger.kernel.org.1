Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61D209ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbgFYHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 03:49:13 -0400
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:33488 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390237AbgFYHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:49:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2E10A837F24D;
        Thu, 25 Jun 2020 07:49:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21063:21080:21433:21627:21740:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: stove73_501568826e4b
X-Filterd-Recvd-Size: 1548
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jun 2020 07:49:11 +0000 (UTC)
Message-ID: <027076b1335f3b48307c78a3d6d1573fa8975822.camel@perches.com>
Subject: Re: cocci script from 2016 - assignment in if ?
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kris Borer <kborer@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jun 2020 00:49:10 -0700
In-Reply-To: <alpine.DEB.2.22.394.2006250848260.3692@hadrien>
References: <3af82c36a9e7477566bf3c2e6ce013cd@perches.com>
         <alpine.DEB.2.22.394.2006250848260.3692@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-25 at 08:49 +0200, Julia Lawall wrote:
> 
> On Wed, 24 Jun 2020, joe@perches.com wrote:
> 
> > https://lore.kernel.org/patchwork/patch/649705/
> > 
> > Any particular reason this wasn't applied?
> > 
> > I ask because I added something similar recently to checkpatch.
> 
> It probably slipped through the cracks at the time the Coccinelle
> scripts maintainer disappeared.  I can check and see if it does anything
> more than your script.

The checkpatch thing only works on single lines,
so this cocci script looks more whitespace robust
but this script doesn't appear to handle code like

	if (!(foo = bar(...)))
		baz;

where the checkpatch thing converts it OK.
		


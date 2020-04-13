Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89E1A6906
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 17:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgDMPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 11:42:00 -0400
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:50396 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728597AbgDMPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:41:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3BC1A18224504;
        Mon, 13 Apr 2020 15:41:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:42:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3868:3870:3872:3873:4250:4321:5007:7223:10004:10400:10848:11232:11658:11914:12043:12295:12297:12740:12760:12895:13069:13095:13311:13357:13439:14180:14659:14777:21080:21433:21627:21819:21990:30022:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: dolls70_4b08d2e0a8857
X-Filterd-Recvd-Size: 1657
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 15:41:55 +0000 (UTC)
Message-ID: <ba11f20b35eb1b4fbdcaf353eeec29950146af9f.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
Cc:     navid.emamdoost@gmail.com, sylphrenadin@gmail.com,
        nishkadg.linux@gmail.com, stephen@brennan.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Date:   Mon, 13 Apr 2020 08:39:48 -0700
In-Reply-To: <20200413125015.GA3077651@kroah.com>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
         <20200413125015.GA3077651@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 14:50 +0200, Greg KH wrote:
> On Mon, Apr 13, 2020 at 03:01:28AM +0000, Camylla Goncalves Cantanheide wrote:
> > Changes of the local variable value and
> > modification in the seletive repetition structure.
[]
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
[]
> You are receiving this message because of the following common error(s)
> as indicated below:
[]
> greg k-h's patch email bot

Hey Greg.

I think I wrote most (all?) of this as a suggestion
to Camylla.

It's a refactoring patch which would be difficult
or impossible to separate into multiple patches.



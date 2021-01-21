Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95E02FE22B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbhAUF66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:58:58 -0500
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:35224 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726929AbhAUDKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:10:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CE02618021C95;
        Thu, 21 Jan 2021 03:09:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3151:3351:3622:3865:3866:3868:3870:3872:4184:4321:5007:6119:7576:7652:8957:10004:10400:11232:11658:11914:12043:12048:12295:12297:12533:12740:12895:13069:13095:13146:13230:13311:13357:13439:13894:14180:14181:14659:14721:21060:21080:21433:21451:21600:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: work76_21134a92755f
X-Filterd-Recvd-Size: 1782
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Jan 2021 03:09:06 +0000 (UTC)
Message-ID: <1a3ab487bfb0365991355147fadbf51df14a4772.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell
 checking
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        ChunyouTang <tangchunyou@163.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, xndchn@gmail.com, j.neuschaefer@gmx.net,
        luca@lucaceresoli.net, naoki.hayama@lineo.co.jp,
        ebiggers@google.com, sjpark@amazon.de
Cc:     linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        tangchunyou@yulong.com
Date:   Wed, 20 Jan 2021 19:09:05 -0800
In-Reply-To: <47008cd9-2b87-f5b2-5fad-e8f009869dda@infradead.org>
References: <20210121020731.2316-1-tangchunyou@163.com>
         <47008cd9-2b87-f5b2-5fad-e8f009869dda@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-01-20 at 19:02 -0800, Randy Dunlap wrote:
> On 1/20/21 6:07 PM, ChunyouTang wrote:
> > From: tangchunyou <tangchunyou@yulong.com>
> > 
> > Increase direcly,maping,manger spelling error check
> 
> Hi,
> I don't see all of those in the patch below.
> What happened?

I think mostly it's just a poor commit message as
direcly and manger are already in spelling.txt

> > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> > @@ -875,6 +875,7 @@ manger||manager
> >  manoeuvering||maneuvering
> >  manufaucturing||manufacturing
> >  mappping||mapping
> > +maping||mapping
> >  matchs||matches
> >  mathimatical||mathematical
> >  mathimatic||mathematic



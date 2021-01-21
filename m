Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09772FE67D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbhAUJh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:37:58 -0500
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:52920 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728883AbhAUJhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:37:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5AC60182251B2;
        Thu, 21 Jan 2021 09:36:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3151:3353:3622:3653:3865:3866:3868:3870:3871:3872:3873:3874:4321:5007:6119:7576:7652:7903:8957:10004:10400:10848:10967:11232:11658:11914:12043:12297:12533:12740:12895:13069:13161:13229:13311:13357:13439:13894:14181:14659:14721:21080:21451:21600:21611:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: wind30_170fe2727562
X-Filterd-Recvd-Size: 2571
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 Jan 2021 09:36:51 +0000 (UTC)
Message-ID: <6223e06f2a45b8772f04d97d840fe7da960a8037.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: increase error-prone spell
 checking
From:   Joe Perches <joe@perches.com>
To:     Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Chunyou Tang <tangchunyou@163.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        colin.king@canonical.com, xndchn@gmail.com, j.neuschaefer@gmx.net,
        ebiggers@google.com, sjpark@amazon.de,
        linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        tangchunyou@yulong.com
Date:   Thu, 21 Jan 2021 01:36:50 -0800
In-Reply-To: <b54335cd-2009-3542-a175-6118c294fd74@lineo.co.jp>
References: <20210121020731.2316-1-tangchunyou@163.com>
         <47008cd9-2b87-f5b2-5fad-e8f009869dda@infradead.org>
         <1a3ab487bfb0365991355147fadbf51df14a4772.camel@perches.com>
         <20210121112115.00005cb6@163.com>
         <7937a406-812e-0a41-12c5-41576737a44f@lucaceresoli.net>
         <b54335cd-2009-3542-a175-6118c294fd74@lineo.co.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-21 at 18:14 +0900, Naoki Hayama wrote:
> On 2021/01/21 17:41, Luca Ceresoli wrote:
> > On 21/01/21 04:21, Chunyou Tang wrote:
> > > On Wed, 20 Jan 2021 19:09:05 -0800 Joe Perches <joe@perches.com> wrote:
> > > > On Wed, 2021-01-20 at 19:02 -0800, Randy Dunlap wrote:
> > > > > On 1/20/21 6:07 PM, ChunyouTang wrote:  
> > > > > > From: tangchunyou <tangchunyou@yulong.com>
[]
> > > > > > diff --git a/scripts/spelling.txt b/scripts/spelling.txt  
> > > > []
> > > > > > @@ -875,6 +875,7 @@ manger||manager
> > > > > >  manoeuvering||maneuvering
> > > > > >  manufaucturing||manufacturing
> > > > > >  mappping||mapping
> > > > > > +maping||mapping
> > > > > >  matchs||matches
> > > > > >  mathimatical||mathematical
> > > > > >  mathimatic||mathematic  
[]
> Rules in scripts/spelling.txt are sorted
> alphabetically by leftside words. It would
> be better that you insert "maping||mapping"
> rule between:
> 
> "manufaucturing||manufacturing"
> and
> "mappping||mapping" .

That's not really true.  Try a diff of $ sort < scripts/spelling.txt

The general rule of thumb, and it's only a rule of thumb and it is
not strictly enforced, is that similar misspellings are grouped
together.



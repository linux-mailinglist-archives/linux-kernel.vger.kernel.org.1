Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDA71CCF31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 03:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgEKBcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 21:32:11 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:43492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728468AbgEKBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:32:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A5CE218224D6B;
        Mon, 11 May 2020 01:32:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:3873:3874:4321:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21990:30034:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: paste63_6a0e2d4071849
X-Filterd-Recvd-Size: 1626
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 01:32:08 +0000 (UTC)
Message-ID: <8bf0f4bc3ff924143fe1a90d112c73047de0288d.camel@perches.com>
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
From:   Joe Perches <joe@perches.com>
To:     chenzhou <chenzhou10@huawei.com>, davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 10 May 2020 18:32:07 -0700
In-Reply-To: <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
         <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
         <887e9dc1-745b-fd2d-39fe-3354e25c6ce8@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 09:24 +0800, chenzhou wrote:
> Sorry, i made a mistake, should be scnprintf().

No worries.

But why do you think this is useful?
Is it likely that either snprint length will exceed PAGE_SIZE?

> 
> On 2020/5/9 19:40, Joe Perches wrote:
> > On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
> > > snprintf() returns the number of bytes that would be written,
> > > which may be greater than the the actual length to be written.
> > []
> > > Chen Zhou (2):
> > >   sparc: use snprintf() in show_pciobppath_attr() in pci.c
> > >   sparc: use snprintf() in show_pciobppath_attr() in vio.c
> > Your subjects are a bit off: snprintf vs scnprintf
> > 
> > 
> > 
> > 
> 
> 


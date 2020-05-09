Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8544E1CC10D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 13:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgEILkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 07:40:16 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:36636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgEILkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:40:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BF79A837F24F;
        Sat,  9 May 2020 11:40:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3874:4321:5007:7903:10004:10400:10848:11026:11232:11658:11914:12297:12438:12740:12760:12895:13069:13163:13229:13311:13357:13439:14659:21080:21451:21627:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cast62_3be03e240845c
X-Filterd-Recvd-Size: 1179
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 May 2020 11:40:11 +0000 (UTC)
Message-ID: <d31e35da0921eb88424e2b201a38b3b8b2d2580c.camel@perches.com>
Subject: Re: [PATCH -next 0/2] sparc: use snprintf() in show() methods
From:   Joe Perches <joe@perches.com>
To:     Chen Zhou <chenzhou10@huawei.com>, davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 09 May 2020 04:40:10 -0700
In-Reply-To: <20200509091849.116954-1-chenzhou10@huawei.com>
References: <20200509091849.116954-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-09 at 17:18 +0800, Chen Zhou wrote:
> snprintf() returns the number of bytes that would be written,
> which may be greater than the the actual length to be written.
[]
> Chen Zhou (2):
>   sparc: use snprintf() in show_pciobppath_attr() in pci.c
>   sparc: use snprintf() in show_pciobppath_attr() in vio.c

Your subjects are a bit off: snprintf vs scnprintf



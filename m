Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBFA2C380D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 05:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKYEYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 23:24:19 -0500
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:39332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbgKYEYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 23:24:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id EE9FC180A8CBE;
        Wed, 25 Nov 2020 04:24:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 57,3.5,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3150:3352:3622:3865:3867:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7903:8985:9025:10013:10400:10471:10848:11232:11657:11658:11914:12043:12048:12266:12297:12438:12555:12740:12760:12895:12903:12986:13069:13255:13311:13357:13439:14181:14659:14721:21080:21347:21365:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: death67_3d0c23b27373
X-Filterd-Recvd-Size: 2226
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed, 25 Nov 2020 04:24:16 +0000 (UTC)
Message-ID: <a102bb51a8ebde2e22d9527fb00a2c1f64c6e69f.camel@perches.com>
Subject: Re: [PATCH RESEND] checkpatch: Do not check git commit description
 style when backport the upstream commit
From:   Joe Perches <joe@perches.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Date:   Tue, 24 Nov 2020 20:24:15 -0800
In-Reply-To: <995e0acb-c219-ea00-f078-7582516e25de@loongson.cn>
References: <1606275347-19297-1-git-send-email-yangtiezhu@loongson.cn>
         <dddb87a6ffb94b6b8046eb2eca1480a7ca37f962.camel@perches.com>
         <995e0acb-c219-ea00-f078-7582516e25de@loongson.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-25 at 12:08 +0800, Tiezhu Yang wrote:
> On 11/25/2020 11:51 AM, Joe Perches wrote:
> > On Wed, 2020-11-25 at 11:35 +0800, Tiezhu Yang wrote:
> > > When backport the upstream commit to the internal LTS kernel version,
> > > we usually use the following description [1] [2]:
> > > 
> > > [ Upstream commit cc6528bc9a0c901c83b8220a2e2617f3354d6dd9 ]
> > > or
> > > commit c51f8f88d705e06bd696d7510aff22b33eb8e638 upstream.
> > Internal to what?
> > 
> > If it's your own internal build system, I think you should
> > keep your own local patch to checkpatch.
> > 
> > I don't see why the kernel version should accept it.
> > 
> > Is this style used by anyone else?
> 
> AFAIK, this style is only used in the stable tree, for example:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.9.y&id=c68a9ca7ca33f1020cca97e4e935c2154bec37c7

Greg?/Sasha?

https://lore.kernel.org/lkml/995e0acb-c219-ea00-f078-7582516e25de@loongson.cn/T/#m2f3d87bd985bf3d4d7b63f1fa4f0490baa01119b

Is this in your scripts?
Is this something you want/use?



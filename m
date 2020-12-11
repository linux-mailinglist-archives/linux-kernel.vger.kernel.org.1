Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523B62D72AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393336AbgLKJM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:12:56 -0500
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:48258 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730095AbgLKJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:12:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3B03E18086847;
        Fri, 11 Dec 2020 09:12:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1561:1593:1594:1711:1714:1730:1747:1777:1792:2194:2199:2393:2525:2560:2563:2682:2685:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3871:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7903:8985:9025:9108:10004:10400:10848:11232:11473:11658:11914:12043:12048:12297:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21324:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: boy28_4d07a91273ff
X-Filterd-Recvd-Size: 1192
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Dec 2020 09:12:05 +0000 (UTC)
Message-ID: <aef3e4fdb2fd1117e1e559b442f42db4b2909db0.camel@perches.com>
Subject: Re: [PATCH -next] fs/afs: convert comma to semicolon
From:   Joe Perches <joe@perches.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Julia Lawall <julia.lawall@lip6.fr>
Date:   Fri, 11 Dec 2020 01:12:03 -0800
In-Reply-To: <20201211083843.1684-1-zhengyongjun3@huawei.com>
References: <20201211083843.1684-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-11 at 16:38 +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.

If you are using a tool to find and fix these, you should mention the tool.

btw: using Julia Lawall's cocci script to update these is probably best.

https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2008201856110.2524@hadrien/


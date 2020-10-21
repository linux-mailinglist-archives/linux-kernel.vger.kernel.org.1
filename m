Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B758A29517B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 19:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444235AbgJURZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 13:25:53 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:42650 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390251AbgJURZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 13:25:52 -0400
X-Greylist: delayed 518 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 13:25:52 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 354C21801653F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 17:17:14 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 646F21801626A;
        Wed, 21 Oct 2020 17:17:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,coupons@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7514:8985:9025:10004:10400:11232:11658:11854:11914:12043:12297:12555:12740:12760:12895:12986:13019:13069:13311:13357:13439:14181:14659:14721:21080:21627:21660:21811:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fruit19_400ba4f2724a
X-Filterd-Recvd-Size: 1682
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 17:17:12 +0000 (UTC)
Message-ID: <0f2bd4e988ce0a75434407a2db584a4e0c6c6280.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
From:   Joe Perches <coupons@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Aditya Srivastava <yashsri421@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 21 Oct 2020 10:17:10 -0700
In-Reply-To: <CABJPP5D9noCN9nMD5HdHq+uk=ot+Xcvd35CrC1E1GKy+nHAhGw@mail.gmail.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
         <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
         <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
         <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
         <CABJPP5D9noCN9nMD5HdHq+uk=ot+Xcvd35CrC1E1GKy+nHAhGw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-21 at 22:29 +0530, Dwaipayan Ray wrote:
> Can it be considered that the Hex numbers occur
> mostly in pairs or groups of 8, like "FF" or "FFFFFFFF"?
> 
> I think it might reduce the negative side further.

Maybe.  This already looks for pairs.

Combined with your previous patch,
https://lore.kernel.org/linux-kernel-mentees/20201017162732.152351-1-dwaipayanray1@gmail.com/
it seems OK to me.

Try something out and see if it makes a difference.




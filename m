Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272DC2960F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900941AbgJVOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:35:04 -0400
Received: from smtprelay0031.hostedemail.com ([216.40.44.31]:41504 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2900934AbgJVOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:35:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 53E8218029125;
        Thu, 22 Oct 2020 14:35:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3871:3872:4321:4470:5007:6248:7903:9010:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14180:14659:14777:21060:21080:21433:21627:21660:21740:30026:30054:30060:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: deer96_500855227251
X-Filterd-Recvd-Size: 1759
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 14:35:02 +0000 (UTC)
Message-ID: <41a6764bf25b75a16167a95dbe1faa192e227aff.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 22 Oct 2020 07:35:01 -0700
In-Reply-To: <cfa48542-4654-fe62-e7fa-c7d99c6ab4f5@gmail.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
         <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
         <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
         <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
         <c4f8aae0-d805-8d09-1a87-ba64bc01c29a@gmail.com>
         <d44e35ec1d923fd09ea6530ca5d1988cc8e59347.camel@perches.com>
         <0871715a-e605-91c0-ffa5-389a313ec34d@gmail.com>
         <CAKXUXMzdjV8aPL=Paf2QJs1iWB5swxYXFJozyPi_JxJVXRArxQ@mail.gmail.com>
         <cfa48542-4654-fe62-e7fa-c7d99c6ab4f5@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-22 at 19:51 +0530, Aditya wrote:
> > > Alright Sir.

Joe is fine, sir isn't necessary.
> Hi Sir
> I have implemented my solution. Should I send the patch in reply to
> this mail or as a different mail? Also should I label it as v2? I have
> also addressed the warnings out of list command output in it. for eg.

Either way works.



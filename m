Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DD524DFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgHUSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 14:35:55 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:54846 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbgHUSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:35:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6DC3E1822495E;
        Fri, 21 Aug 2020 18:35:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:9025:10004:10400:10848:11232:11658:11914:12043:12050:12297:12438:12555:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:13618:13845:14181:14659:14721:21080:21627:21740:21811:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shoe97_390c3bd2703b
X-Filterd-Recvd-Size: 1887
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 18:35:52 +0000 (UTC)
Message-ID: <745aba13716b91cf58a45468083b59201d1530fc.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Date:   Fri, 21 Aug 2020 11:35:50 -0700
In-Reply-To: <CAL_JsqL0v6PXgMLVZzqZwjpZ4KTUGmutg6Z0YuvTccdAUa-=mw@mail.gmail.com>
References: <20200821154848.GI7871@localhost.localdomain>
         <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
         <8213206d4764375f32cbea36ea214573248094dc.camel@perches.com>
         <CAL_JsqL0v6PXgMLVZzqZwjpZ4KTUGmutg6Z0YuvTccdAUa-=mw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 12:17 -0600, Rob Herring wrote:
> I have another reason for wanting the split. I want to generate a
> MAINTAINERS file from the DT schema files. We have the data there and
> it's checked automatically. I don't care to either continually tell
> folks to add a MAINTAINERS entry or tell them to run checkpatch.pl to
> tell them that. But if the infrastructure got merged, would that
> already work?

It already gets addresses from yaml files.
The same could be done for dts/dtsi files.

Last month I proposed:

https://lore.kernel.org/linux-arm-kernel/da52724655ff2161add7fb27fea8fc673028b9fc.camel@perches.com/



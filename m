Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95AD27ECF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgI3Paa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:30:30 -0400
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:34586 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730851AbgI3Pa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:30:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E5188181D302B;
        Wed, 30 Sep 2020 15:30:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2538:2553:2560:2563:2682:2685:2828:2859:2892:2911:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4425:5007:6119:6742:7903:9012:9025:9040:10004:10400:10848:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13072:13161:13229:13311:13357:13439:13618:14181:14659:14721:14777:21063:21067:21080:21433:21451:21611:21627:21740:21788:21819:30003:30022:30054:30055:30056:30067:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: vase23_3d0218b27193
X-Filterd-Recvd-Size: 2476
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Sep 2020 15:30:22 +0000 (UTC)
Message-ID: <f92c0644700ef7adc703907f95e4332f94d7aa7b.camel@perches.com>
Subject: Re: [PATCH v6 2/3] MAINTAINERS: Add Purism Librem 5 section to the
 list
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        kernel@puri.sm, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, mchehab@kernel.org,
        Anson.Huang@nxp.com, agx@sigxcpu.org, angus@akkea.ca,
        broonie@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Wed, 30 Sep 2020 08:30:20 -0700
In-Reply-To: <CAJKOXPcJUg+a8rJEn1D-_Ex3HEyHi7TZdh8VGPr9C23xq8L2pA@mail.gmail.com>
References: <20200821121755.24599-1-martin.kepplinger@puri.sm>
         <20200821121755.24599-2-martin.kepplinger@puri.sm>
         <20200830131459.GL32096@dragon>
         <CAJKOXPcJUg+a8rJEn1D-_Ex3HEyHi7TZdh8VGPr9C23xq8L2pA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-30 at 12:50 +0200, Krzysztof Kozlowski wrote:
> On Sun, 30 Aug 2020 at 15:15, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Fri, Aug 21, 2020 at 02:17:54PM +0200, Martin Kepplinger wrote:
> > > Add development information for the devicetree files for hardware
> > > by Purism SPC.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > 
> > I decided to drop this patch from my queue, as I took the suggestion
> > from Joe and sent a patch to have get_maintainer report email address
> > in the dts file.
> > 
> > Shawn
> > 
> > [1] https://lkml.org/lkml/2020/8/30/118
> 
> Shawn, Joe,
> 
> Cool idea! Multiple times I needed review/testing for individual
> boards and this should be faster than going through git history.
> 
> Could you tell me how this is supposed to work for DTS/DTSI files? It
> seems it ignores the comments, so usual copyright notice does not have
> an effect. Where to put the address?

The get_maintainer.pl script reads an existing file and
looks for whatever appears to be an email address.

It does not ignore comments.



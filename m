Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C616F21D062
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 09:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgGMH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 03:26:35 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:54108 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgGMH0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:26:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8EEAF180A7FF9;
        Mon, 13 Jul 2020 07:26:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3653:3865:3871:3872:4321:4605:5007:6119:6742:10004:10400:10848:11026:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:21819:21990,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: coil74_1d1262a26ee6
X-Filterd-Recvd-Size: 1873
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Jul 2020 07:26:32 +0000 (UTC)
Message-ID: <855b5a01416dfe42d89018450a1c791ccb48e500.camel@perches.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add Bruno Thomsen as reviewer of
 Kamstrup DTS
From:   Joe Perches <joe@perches.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, bth@kamstrup.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Mon, 13 Jul 2020 00:26:31 -0700
In-Reply-To: <20200713071342.GK12113@dragon>
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
         <20200629114927.17379-3-bruno.thomsen@gmail.com>
         <20200713025559.GZ21277@dragon>
         <da52724655ff2161add7fb27fea8fc673028b9fc.camel@perches.com>
         <20200713071342.GK12113@dragon>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-13 at 15:13 +0800, Shawn Guo wrote:
> On Sun, Jul 12, 2020 at 10:22:50PM -0700, Joe Perches wrote:
[]
> > diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
[]
> > @@ -436,7 +436,7 @@ sub maintainers_in_file {
> >  
> >      return if ($file =~ m@\bMAINTAINERS$@);
> >  
> > -    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
> > +    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
> 
> It should cover .dts file too?

It does as dtsi? means the i is optional.



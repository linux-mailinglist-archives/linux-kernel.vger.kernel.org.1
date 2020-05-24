Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9941DFE88
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgEXLR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 07:17:59 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:35582 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgEXLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 07:17:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2BCA318006CF4;
        Sun, 24 May 2020 11:17:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3868:3870:3873:3874:4321:5007:6119:7903:8603:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:13869:14659:21080:21627:30005:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: eyes43_3a0b98a26d37
X-Filterd-Recvd-Size: 1344
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 May 2020 11:17:56 +0000 (UTC)
Message-ID: <9ac5f51837a2e4e86fc4009ebc4d56ecfe733598.camel@perches.com>
Subject: Re: [PATCH v2 2/2] staging: rtl8188eu: make some arrays static const
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 24 May 2020 04:17:55 -0700
In-Reply-To: <20200524101514.20557-2-straube.linux@gmail.com>
References: <20200524101514.20557-1-straube.linux@gmail.com>
         <20200524101514.20557-2-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-24 at 12:15 +0200, Michael Straube wrote:
> Make some arrays in phy_iq_calibrate() static const and adjust
> the functions that take these arrays as parameters accordingly.
> Reduces object file size by 84 bytes (GCC 9.3.1 x86_64).

You could also do drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
and reduce data by a fair amount there too.

Just change the prototype for _rtl92d_phy_calc_curvindex there.


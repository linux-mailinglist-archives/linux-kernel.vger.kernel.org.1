Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED1267BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgILSn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 14:43:56 -0400
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:47874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725838AbgILSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 14:43:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5B52F1803F9A8;
        Sat, 12 Sep 2020 18:43:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:4321:5007:10004:10400:10848:11026:11232:11657:11658:11914:12043:12114:12297:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: shock79_1b09319270f9
X-Filterd-Recvd-Size: 1573
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Sep 2020 18:43:50 +0000 (UTC)
Message-ID: <38299e7c135de26dc7cf3fbe25d6a74e4632bbd9.camel@perches.com>
Subject: Re: [PATCH 1/5] staging: rtl8723bs: refactor cckrates{only}_included
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 12 Sep 2020 11:43:49 -0700
In-Reply-To: <f5fdb27843143dfefb1a1a416dab63931fef6d41.camel@perches.com>
References: <20200912084520.8383-1-straube.linux@gmail.com>
         <f5fdb27843143dfefb1a1a416dab63931fef6d41.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-12 at 11:22 -0700, Joe Perches wrote:
> On Sat, 2020-09-12 at 10:45 +0200, Michael Straube wrote:
> > Refactor cckrates_included() and cckratesonly_included() to simplify
> > the code and improve readability.
[]
> diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
[]
> bool cckratesonly_included(unsigned char *rate, int ratelen)
> {
[]
> 	if (i <= 0)
	if (ratelen <= 0)  of course...

> 		return false;
> 
> 	for (i = 0; i < ratelen; i++) {
> 		if (!is_cckrate(rate[i])
> 			return false;
> 	}
> 
> 	return true;
> }
> 
> 


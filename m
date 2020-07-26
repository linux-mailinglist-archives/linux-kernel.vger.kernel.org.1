Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3A522E19A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGZRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 13:15:36 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:56558 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726121AbgGZRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:15:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F15A5182CED5B;
        Sun, 26 Jul 2020 17:15:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3870:3871:3872:3874:4250:4321:5007:8957:10004:10400:11026:11232:11657:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21611:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sound58_281484c26f5a
X-Filterd-Recvd-Size: 1982
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 17:15:33 +0000 (UTC)
Message-ID: <1177f80aa848a294f65e305729304b76d1e5ee98.camel@perches.com>
Subject: Re: [PATCH v3 3/4] staging: rtl8723bs: include: Further clean up
 function declarations
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Cc:     devel@driverdev.osuosl.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Date:   Sun, 26 Jul 2020 10:15:32 -0700
In-Reply-To: <20200726150244.GD452766@kroah.com>
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
         <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
         <20200726142013.2891-3-aditya.jainadityajain.jain@gmail.com>
         <20200726150244.GD452766@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 17:02 +0200, Greg KH wrote:
> On Sun, Jul 26, 2020 at 07:50:12PM +0530, Aditya Jain wrote:
> > Cleaning up messy multiline function declarations in hal_phy_cfg.h
[]
> > diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
[]
> > -void
> > -PHY_SetSwChnlBWMode8723B(
> > -struct adapter *Adapter,
> > -u8 			channel,
> > -enum CHANNEL_WIDTH		Bandwidth,
> > -u8 			Offset40,
> > -u8 			Offset80
> > +void PHY_SetBWMode8723B(struct adapter *Adapter,
> > +			enum CHANNEL_WIDTH Bandwidth,	/*  20M or 40M */
> > +			unsigned char Offset	/*  Upper, Lower, or Don't care */
> 
> Those comments should go at the top of the function declaration, in
> kernel doc format.

Not every external function needs kernel-doc.

This is a realtek staging driver that likely it will never be
moved out of staging.



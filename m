Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6462E6C10
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgL1Wzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:44 -0500
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:47600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729333AbgL1TsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:48:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 452531802926E;
        Mon, 28 Dec 2020 19:47:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:4250:4321:5007:7652:10004:10400:10848:11026:11232:11657:11658:11914:12043:12297:12438:12683:12740:12895:13069:13311:13357:13439:13894:14110:14659:21080:21451:21611:21627:21939:30012:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dust30_4a09e1827496
X-Filterd-Recvd-Size: 2258
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Dec 2020 19:47:28 +0000 (UTC)
Message-ID: <4aeb47e4aa643181e462328104ef63c66eaf587b.camel@perches.com>
Subject: Re: [PATCH 8455/8455] staging: rtl8188eu: core: fixed a comment
 format issue.
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel West <daniel.west.dev@gmail.com>
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        insafonov@gmail.com, gustavoars@kernel.org,
        andrealmeidap1996@gmail.com, linux-kernel@vger.kernel.org,
        yepeilin.cs@gmail.com
Date:   Mon, 28 Dec 2020 11:47:27 -0800
In-Reply-To: <X+nnAwy/a7mZlmeL@kroah.com>
References: <20201219224312.380126-1-daniel.west.dev@gmail.com>
         <X+nnAwy/a7mZlmeL@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-28 at 15:09 +0100, Greg KH wrote:
> On Sat, Dec 19, 2020 at 02:43:12PM -0800, Daniel West wrote:
> > Fixed a checkpatch warning:
> > 
> > WARNING: Block comments use * on subsequent lines
> >  #4595: FILE: drivers/staging/rtl8188eu/core/rtw_mlme_ext.c:4595:
> > +/****************************************************************************
> > +
> > 
> > The code is full of comments like this. Should the coding style
> > be inforced here, even when there is a logic to the way the code
> > was broken up?
[]
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
[]
> > @@ -4591,11 +4591,10 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
> >  	}
> >  }
> >  
> > 
> > -/****************************************************************************
> > -
> > -Following are the functions for the timer handlers
> > -
> > -*****************************************************************************/
> > +/*
> > + *
> > + *Following are the functions for the timer handlers
> > + */
> 
> Does that look correct?  Make it all one line please.

Just:

/* timer handler functions */

would be simpler.

And the code is mostly a horror to read.



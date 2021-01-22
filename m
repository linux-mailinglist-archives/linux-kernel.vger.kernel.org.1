Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2407B3007E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbhAVPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:55:45 -0500
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:50860 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729232AbhAVPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:51:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 0BD8B837F24A;
        Fri, 22 Jan 2021 15:50:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3867:3871:4250:4321:5007:6119:7652:7903:9163:10004:10400:10848:11232:11658:11914:12297:12679:12740:12760:12895:13019:13069:13206:13211:13229:13311:13357:13439:14659:14721:14819:21080:21451:21627:21987:30054:30060:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: land10_2911aa62756d
X-Filterd-Recvd-Size: 1852
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Jan 2021 15:50:56 +0000 (UTC)
Message-ID: <64d3d8cb83e09d03927dba998a09e8b37e06dece.camel@perches.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang
 line
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Jan 2021 07:50:54 -0800
In-Reply-To: <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com>
References: <20210121170736.2266-1-scott.branden@broadcom.com>
         <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
         <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
         <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
         <CAK7LNARL570EgjijCMY_CF91frwtTeatyhYcnD8-s08aiduFnQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-01-22 at 07:06 +0900, Masahiro Yamada wrote:
> I use Ubuntu, where /usr/bin/python is a symlink
> to /usr/bin/python3.

Odd, here:

$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.10
Release:	20.10
Codename:	groovy

$ ls /usr/bin/python -la
lrwxrwxrwx 1 root root 7 Apr 15  2020 /usr/bin/python -> python2




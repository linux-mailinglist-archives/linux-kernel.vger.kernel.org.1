Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5792F2FFA56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 03:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhAVCTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 21:19:42 -0500
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:44150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725764AbhAVCTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 21:19:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1021F18086838;
        Fri, 22 Jan 2021 02:18:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3866:3867:3868:3870:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7652:7775:8985:9025:10004:10400:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14764:21080:21627:30054:30060:30064:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: chair33_3b04b1827568
X-Filterd-Recvd-Size: 1636
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Jan 2021 02:18:46 +0000 (UTC)
Message-ID: <b9c303e70dc4f8573bebb6bb07c98daa25ea0fba.camel@perches.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang
 line
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 21 Jan 2021 18:18:45 -0800
In-Reply-To: <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
References: <20210121170736.2266-1-scott.branden@broadcom.com>
         <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-01-22 at 05:25 +0900, Masahiro Yamada wrote:
> On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
> <scott.branden@broadcom.com> wrote:
> > 
> > Use python3 instead of python in diffconfig Shebang line.
> > python2 was sunset January 1, 2000 and environments do not need
> > to support python any more.

python2 was sunset Jan 1, 2020, not 20 years before that.

https://www.python.org/doc/sunset-python-2/



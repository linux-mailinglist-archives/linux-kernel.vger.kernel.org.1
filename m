Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB32DE0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbgLRKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:09:24 -0500
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:34894 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733048AbgLRKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:09:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 821BB18026431;
        Fri, 18 Dec 2020 10:08:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:3874:4321:5007:7576:8879:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:21773:21796:30030:30036:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rock88_2b13b822743c
X-Filterd-Recvd-Size: 2292
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Dec 2020 10:08:40 +0000 (UTC)
Message-ID: <c09401d003360cff41c949ccaea8ae9dc7b2c733.camel@perches.com>
Subject: Re: [PATCH] staging: most: video: fixed a parentheses coding style
 issue.
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Daniel West <daniel.west.dev@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "christian.gromm@microchip.com" <christian.gromm@microchip.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 18 Dec 2020 02:08:39 -0800
In-Reply-To: <d5993e314b134e038a1e4eeba32833ce@AcuMS.aculab.com>
References: <20201217234501.351725-1-daniel.west.dev@gmail.com>
         <04c331f6bfce57c253cb86208ebd28f6363e04c0.camel@perches.com>
         <d5993e314b134e038a1e4eeba32833ce@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-18 at 09:49 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 17 December 2020 23:58
> > 
> > On Thu, 2020-12-17 at 15:45 -0800, Daniel West wrote:
> > > Fixed a coding style issue.
> > 
> > It may pass checkpatch without warning, but it's uncommon kernel coding style.
> 
> checkpatch probably shouldn't complain about lines that end in (
> if they are function definitions.

Opinons vary.

Very few function declaration/definitions in the linux kernel use the
one line per argument style (gnu indent -bfde)

type function(
	type argument1,
	type argument2,
	...
	)
{
	...
}

It probably shouldn't be encouraged.

> > or (> 80 columns)
> > static struct most_video_dev *get_comp_dev(struct most_interface *iface, int channel_idx)
> Or shorten the variable/type names a bit so it all fits.

Always a possibility but probably not a good one here as even
renaming channel_idx to idx doesn't make it < 80 columns



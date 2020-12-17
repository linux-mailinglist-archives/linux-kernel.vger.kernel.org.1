Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9946E2DDC39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 01:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbgLQX7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:59:00 -0500
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:43314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732037AbgLQX7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:59:00 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6BBEA181D337B;
        Thu, 17 Dec 2020 23:58:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:857:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3872:4321:5007:8879:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12683:12740:12895:13069:13311:13357:13439:13894:14110:14659:14721:21080:21627:21773:21796:30036:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: limit53_2f0fb3827438
X-Filterd-Recvd-Size: 1969
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Dec 2020 23:58:17 +0000 (UTC)
Message-ID: <04c331f6bfce57c253cb86208ebd28f6363e04c0.camel@perches.com>
Subject: Re: [PATCH] staging: most: video: fixed a parentheses coding style
 issue.
From:   Joe Perches <joe@perches.com>
To:     Daniel West <daniel.west.dev@gmail.com>, gregkh@linuxfoundation.org
Cc:     hverkuil-cisco@xs4all.nl, mchehab+huawei@kernel.org,
        christian.gromm@microchip.com, masahiroy@kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Dec 2020 15:58:16 -0800
In-Reply-To: <20201217234501.351725-1-daniel.west.dev@gmail.com>
References: <20201217234501.351725-1-daniel.west.dev@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-17 at 15:45 -0800, Daniel West wrote:
> Fixed a coding style issue.

It may pass checkpatch without warning, but it's uncommon kernel coding style.

> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
[]
> @@ -365,8 +365,8 @@ static const struct video_device comp_videodev_template = {
>  
> 
>  /**************************************************************************/
>  
> 
> -static struct most_video_dev *get_comp_dev(
> -	struct most_interface *iface, int channel_idx)
> +static struct most_video_dev *get_comp_dev
> +	(struct most_interface *iface, int channel_idx)

This would be better using any of:

(most common)

static struct most_video_dev *get_comp_dev(struct most_interface *iface,
					   int channel_idx)

or (less common)

static struct most_video_dev *
get_comp_dev(struct most_interface *iface, int channel_idx)

or (> 80 columns)

static struct most_video_dev *get_comp_dev(struct most_interface *iface, int channel_idx)


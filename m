Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEBC2254B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 01:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGSXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 19:12:19 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:38102 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726949AbgGSXLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 1AEB5D8C3C;
        Sun, 19 Jul 2020 23:11:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:7809:9025:10004:10400:10848:11232:11658:11914:12043:12048:12297:12555:12740:12760:12895:13069:13072:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21433:21451:21627:21773:21819:30003:30022:30029:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: girl50_5c169ea26f20
X-Filterd-Recvd-Size: 1656
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 Jul 2020 23:11:28 +0000 (UTC)
Message-ID: <f9111b6c4132e672fc491232155a39bff4410ed4.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: mark usbvision as obsolete
From:   Joe Perches <joe@perches.com>
To:     bkkarthik <bkkarthik@pesu.pes.edu>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Date:   Sun, 19 Jul 2020 16:11:26 -0700
In-Reply-To: <20200719180411.bkojjvumwe7hkxyc@pesu.pes.edu>
References: <20200719180411.bkojjvumwe7hkxyc@pesu.pes.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-19 at 14:04 -0400, bkkarthik wrote:
> mark staging/media/usbvision as obsolete so
> checkpatch tells people not to send patches.
> 
> Signed-off-by: bkkarthik <bkkarthik@pesu.pes.edu>

This needs to have a full name before the email address.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a88bf0759c90..82120c2fcedd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17946,7 +17946,7 @@ F:	include/uapi/linux/uvcvideo.h
>  USB VISION DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
> -S:	Odd Fixes
> +S:	Odd Fixes / Obsolete
>  W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/staging/media/usbvision/


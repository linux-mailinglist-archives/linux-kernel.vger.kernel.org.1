Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794A1C82DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGGtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 02:49:53 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:39696 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgEGGtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 427BF1803950B;
        Thu,  7 May 2020 06:49:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:4321:5007:6997:10004:10400:10848:11026:11232:11658:11914:12043:12220:12297:12438:12555:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: burst17_1bd6e369c792e
X-Filterd-Recvd-Size: 1816
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 06:49:51 +0000 (UTC)
Message-ID: <5f2d179c35de8e7705f82a8c9a540dbd204bb978.camel@perches.com>
Subject: Re: [PATCH -next] ALSA: portman2x4: Use bitwise instead of
 arithmetic operator for flags
From:   Joe Perches <joe@perches.com>
To:     Samuel Zou <zou_wei@huawei.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 May 2020 23:49:50 -0700
In-Reply-To: <1588834135-14842-1-git-send-email-zou_wei@huawei.com>
References: <1588834135-14842-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 14:48 +0800, Samuel Zou wrote:
> Fix the following coccinelle warning:
> 
> sound/drivers/portman2x4.c:460:34-35: WARNING: sum of probable bitmasks, consider |

This one is reasonable.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  sound/drivers/portman2x4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
> index ecefa7c..38603cb 100644
> --- a/sound/drivers/portman2x4.c
> +++ b/sound/drivers/portman2x4.c
> @@ -457,7 +457,7 @@ static int portman_probe(struct parport *p)
>  
>  	/* Set for RXDATA0 where no damage will be done. */
>  	/* 5 */
> -	parport_write_control(p, RXDATA0 + STROBE);	/* Write Strobe=1 to command reg. */
> +	parport_write_control(p, RXDATA0 | STROBE);	/* Write Strobe=1 to command reg. */
>  
>  	/* 6 */
>  	if ((parport_read_status(p) & ESTB) != ESTB)


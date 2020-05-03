Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A181C2A11
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 07:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgECFLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 01:11:47 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:43596 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgECFLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 01:11:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 40AC0837F24A;
        Sun,  3 May 2020 05:11:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2693:2828:2914:3138:3139:3140:3141:3142:3353:3622:3865:3867:3870:3871:4321:5007:6119:7903:8660:8957:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12296:12297:12740:12760:12895:13069:13148:13161:13229:13230:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:21660:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: smile70_669627d94555f
X-Filterd-Recvd-Size: 2698
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun,  3 May 2020 05:11:44 +0000 (UTC)
Message-ID: <e5166009d549f42b75e8d764bc9078538ce0ce4a.camel@perches.com>
Subject: Re: [PATCH 2/2] staging: vt6655: fix LONG_LINE warning
From:   Joe Perches <joe@perches.com>
To:     Matej Dujava <mdujava@kocurkovo.cz>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Date:   Sat, 02 May 2020 22:11:43 -0700
In-Reply-To: <1588457794-31438-2-git-send-email-mdujava@kocurkovo.cz>
References: <1588457794-31438-1-git-send-email-mdujava@kocurkovo.cz>
         <1588457794-31438-2-git-send-email-mdujava@kocurkovo.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-03 at 00:16 +0200, Matej Dujava wrote:
> This patch will fix LONG_LINE error from checkpatch, by createing temporary
> variable so call to the function is not in if/else block.
[]
> diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
[]
> @@ -164,16 +164,24 @@ s_uGetTxRsvTime(
>  )
>  {
>  	unsigned int uDataTime, uAckTime;
> +	unsigned short basic_rate;
>  
>  	uDataTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, cbFrameLength, wRate);
>  
>  	if (!bNeedAck)
>  		return uDataTime;
>  
> -	if (byPktType == PK_TYPE_11B) /* llb,CCK mode */
> -		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopCCKBasicRate);
> -	else /* 11g 2.4G OFDM mode & 11a 5G OFDM mode */
> -		uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14, (unsigned short)pDevice->byTopOFDMBasicRate);
> +	/*
> +	 * CCK mode  - 11b
> +	 * OFDM mode - 11g 2.4G & 11a 5G
> +	 */
> +	if (byPktType == PK_TYPE_11B)
> +		basic_rate = (unsigned short)pDevice->byTopCCKBasicRate;
> +	else
> +		basic_rate = (unsigned short)pDevice->byTopOFDMBasicRate;
> +
> +	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
> +				     basic_rate);
>  
>  	return uDataTime + pDevice->uSIFS + uAckTime;
>  }

perhaps simpler using a ?:

	uAckTime = bb_get_frame_time(pDevice->byPreambleType, byPktType, 14,
				     byPktType == PK_TYPE_11B
				     ? pDevice->byTopCCKBasicRate
				     : pDevice->byTopOFDMBasicRate);

the casts aren't necessary either as both by... fields are u8



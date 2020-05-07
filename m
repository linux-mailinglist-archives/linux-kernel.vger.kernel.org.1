Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C462C1C82B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 08:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgEGGno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 02:43:44 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:51830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:43:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AA3E7801A056;
        Thu,  7 May 2020 06:43:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3868:3871:3872:3873:4321:4362:5007:6997:10004:10400:11026:11232:11473:11657:11658:11914:12043:12048:12050:12220:12297:12438:12555:12740:12760:12895:13161:13229:13255:13439:14096:14097:14180:14181:14659:14721:21080:21451:21627:21939:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: humor62_7784db8d54d20
X-Filterd-Recvd-Size: 3778
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 06:43:41 +0000 (UTC)
Message-ID: <158979eb8e6e80c9b535acfdb4821bc9547c7c50.camel@perches.com>
Subject: Re: [PATCH -next] ASoC: amd: acp3x-pcm-dma: Use bitwise instead of
 arithmetic operator for flags
From:   Joe Perches <joe@perches.com>
To:     Samuel Zou <zou_wei@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 May 2020 23:43:40 -0700
In-Reply-To: <1588833562-14417-1-git-send-email-zou_wei@huawei.com>
References: <1588833562-14417-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 14:39 +0800, Samuel Zou wrote:
> Fix the following coccinelle warnings:

> sound/soc/amd/raven/acp3x-pcm-dma.c:161:39-40: WARNING: sum of probable bitmasks, consider |
> sound/soc/amd/raven/acp3x-pcm-dma.c:172:39-40: WARNING: sum of probable bitmasks, consider |
> sound/soc/amd/raven/acp3x-pcm-dma.c:183:39-40: WARNING: sum of probable bitmasks, consider |
> sound/soc/amd/raven/acp3x-pcm-dma.c:194:39-40: WARNING: sum of probable bitmasks, consider |

These are not bitmasks.

Samuel, please look deeper at the code before submitting
bad patches.

And hey Julia.

This is the second false positive submitted for this
warning today.

Can you please remove the script or fix it so it
uses better logic?k

Thanks.


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  sound/soc/amd/raven/acp3x-pcm-dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> index e362f0b..b0cc0fe 100644
> --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> @@ -158,7 +158,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		switch (rtd->i2s_instance) {
>  		case I2S_BT_INSTANCE:
>  			reg_dma_size = mmACP_BT_TX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						BT_PB_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr = mmACP_BT_TX_FIFOADDR;
>  			reg_fifo_size = mmACP_BT_TX_FIFOSIZE;
> @@ -169,7 +169,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		case I2S_SP_INSTANCE:
>  		default:
>  			reg_dma_size = mmACP_I2S_TX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						SP_PB_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr =	mmACP_I2S_TX_FIFOADDR;
>  			reg_fifo_size = mmACP_I2S_TX_FIFOSIZE;
> @@ -180,7 +180,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		switch (rtd->i2s_instance) {
>  		case I2S_BT_INSTANCE:
>  			reg_dma_size = mmACP_BT_RX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						BT_CAPT_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr = mmACP_BT_RX_FIFOADDR;
>  			reg_fifo_size = mmACP_BT_RX_FIFOSIZE;
> @@ -191,7 +191,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		case I2S_SP_INSTANCE:
>  		default:
>  			reg_dma_size = mmACP_I2S_RX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						SP_CAPT_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr = mmACP_I2S_RX_FIFOADDR;
>  			reg_fifo_size = mmACP_I2S_RX_FIFOSIZE;


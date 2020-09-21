Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC81272B91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgIUQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:47622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIUQS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:18:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600705136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqOJVf49CUVVxcz8kEiVqivoHMj3m8RD+N1BRvW+DgU=;
        b=G3YQ4qbryrlPa84ws3fLjF9qOAcMppOY6InukLyCoPgytd6pRmzIpgEBlei/bLk7TMcbMc
        TxQDU7dd/hc+AYNgY6A6L/l25AeIVBpOQkGXNQLZEj7UNRDwLXSXwqWifLpbnxeDwy6WmJ
        Hlvik19sHEe2VhWJSSozAd+ntterhOI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78C23B2C3;
        Mon, 21 Sep 2020 16:19:32 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] soc: mediatek: cmdq: add jump function
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, HS Liao <hs.liao@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
 <1594136714-11650-8-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <1b66c203-e0ea-79f9-6856-a9be3e410dd2@suse.com>
Date:   Mon, 21 Sep 2020 18:18:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1594136714-11650-8-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 17:45, Dennis YC Hsieh wrote:
> Add jump function so that client can jump to any address which
> contains instruction.
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>

Now pushed to v5.9-next/soc

Thanks!

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c |   13 +++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  |   11 +++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index b6e25f216605..d55dc3296105 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -13,6 +13,7 @@
>   #define CMDQ_POLL_ENABLE_MASK	BIT(0)
>   #define CMDQ_EOC_IRQ_EN		BIT(0)
>   #define CMDQ_REG_TYPE		1
> +#define CMDQ_JUMP_RELATIVE	1
>   
>   struct cmdq_instruction {
>   	union {
> @@ -407,6 +408,18 @@ int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_assign);
>   
> +int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
> +{
> +	struct cmdq_instruction inst = {};
> +
> +	inst.op = CMDQ_CODE_JUMP;
> +	inst.offset = CMDQ_JUMP_RELATIVE;
> +	inst.value = addr >>
> +		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_jump);
> +
>   int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   {
>   	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index d9390d76ee14..34354e952f60 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -253,6 +253,17 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subsys,
>   int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value);
>   
>   /**
> + * cmdq_pkt_jump() - Append jump command to the CMDQ packet, ask GCE
> + *		     to execute an instruction that change current thread PC to
> + *		     a physical address which should contains more instruction.
> + * @pkt:        the CMDQ packet
> + * @addr:       physical address of target instruction buffer
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr);
> +
> +/**
>    * cmdq_pkt_finalize() - Append EOC and jump command to pkt.
>    * @pkt:	the CMDQ packet
>    *
> 

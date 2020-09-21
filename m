Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E61272B81
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgIUQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgIUQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:16:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0ABC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:16:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so13408844wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFpxcM6XUPIah7zzLKeBoWdYZ+ocbEsyrrWoWDds4JU=;
        b=fLkui3TXyRWE/tfTme+aWiB/zCdNLRk3btahb1DrnPLN1jVP/RbrlKeBCYrm6t2Mee
         /LqdXtErXrriFo++qL3BihhUXCl69gd0mKrcn1hCdAfaGIIXau+UPr2E75afwYSVcZtC
         0mkRuUCB6cXWokP/sYZpXFaSQrlHZs4nPTGUgsO1hr3wkEcgLjAkswtK4rTeaZCh5TtZ
         t47cKM+04wJi86WDd3310dChRrLfvVeaMOuVfCRmLiyD+jtUdPyjEEz1O21mIMw/hLcx
         QdQXAP7Bey03iWKs2vi5/UnIltpGK1zW449254TmBZF0efZbGNu6ZvACVyOgjpoEjuuP
         Ot5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFpxcM6XUPIah7zzLKeBoWdYZ+ocbEsyrrWoWDds4JU=;
        b=NQX27VkgvyOiDIhztg2Ax5Bi+HTwLd3cZYel9wPQZfm4x1hDvfsfzofax4Ky3qtFU1
         9t2hsqZHhTj7hKoUKD0C4s8Fm2uJyzDkduGavrD8oaid+CliQN0DbRWR8rEzUCpLZROW
         KWGQ+jz2aogudh+H0LN0hfTpQKhJP7kE+NhTUIvF1/IQQ+v3FqZwor3OR0eb9nWy9tyM
         9jmp6GRyEqYV83v8us5Zbn3xu3WWWg3s9lRr8LTqjgidv112PeKOyZ746eSgw041oETu
         LXI4YtdlIjx+snDau4ALDLzHp3zKXOp3Au6nk1Czsjb475/OCtKsGcVq05laS2X3Aplp
         4gIA==
X-Gm-Message-State: AOAM5338xjz7mux1G9kYvrtP9f51XCkyGLqOJCvS2tiPW9LZGE1qEWeX
        TwZOEMkb5txL0lpT4xoNRiYZmr+NvcXDlg==
X-Google-Smtp-Source: ABdhPJxlKA2A2s9DM+LuR07uxc2hXxduS8/5sPYYupoj0yeuPukqpex99x7SyNRtFXbgj4U//+/+uw==
X-Received: by 2002:adf:81e6:: with SMTP id 93mr534258wra.412.1600704963655;
        Mon, 21 Sep 2020 09:16:03 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id t17sm22013545wrx.82.2020.09.21.09.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:16:03 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] soc: mediatek: cmdq: add read_s function
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
 <1594136714-11650-5-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <89ff84a9-dd22-536b-7a41-8a802df97868@gmail.com>
Date:   Mon, 21 Sep 2020 18:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1594136714-11650-5-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 17:45, Dennis YC Hsieh wrote:
> Add read_s function in cmdq helper functions which support read value from
> register or dma physical address into gce internal register.
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>

Now pushed to v5.9-next/soc

Thanks!

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c   |   15 +++++++++++++++
>   include/linux/mailbox/mtk-cmdq-mailbox.h |    1 +
>   include/linux/soc/mediatek/mtk-cmdq.h    |   12 ++++++++++++
>   3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 550e9e7e3ff2..ed9f5e63c195 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -227,6 +227,21 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
>   }
>   EXPORT_SYMBOL(cmdq_pkt_write_mask);
>   
> +int cmdq_pkt_read_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx, u16 addr_low,
> +		    u16 reg_idx)
> +{
> +	struct cmdq_instruction inst = {};
> +
> +	inst.op = CMDQ_CODE_READ_S;
> +	inst.dst_t = CMDQ_REG_TYPE;
> +	inst.sop = high_addr_reg_idx;
> +	inst.reg_dst = reg_idx;
> +	inst.src_reg = addr_low;
> +
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_read_s);
> +
>   int cmdq_pkt_write_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
>   		     u16 addr_low, u16 src_reg_idx)
>   {
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index 90d1d8e64412..efbd8a9eb2d1 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -60,6 +60,7 @@ enum cmdq_code {
>   	CMDQ_CODE_JUMP = 0x10,
>   	CMDQ_CODE_WFE = 0x20,
>   	CMDQ_CODE_EOC = 0x40,
> +	CMDQ_CODE_READ_S = 0x80,
>   	CMDQ_CODE_WRITE_S = 0x90,
>   	CMDQ_CODE_WRITE_S_MASK = 0x91,
>   	CMDQ_CODE_LOGIC = 0xa0,
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 53230341bf94..cd7ec714344e 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -104,6 +104,18 @@ struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
>   int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
>   			u16 offset, u32 value, u32 mask);
>   
> +/*
> + * cmdq_pkt_read_s() - append read_s command to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @high_addr_reg_idx:	internal register ID which contains high address of pa
> + * @addr_low:	low address of pa
> + * @reg_idx:	the CMDQ internal register ID to cache read data
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_read_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx, u16 addr_low,
> +		    u16 reg_idx);
> +
>   /**
>    * cmdq_pkt_write_s() - append write_s command to the CMDQ packet
>    * @pkt:	the CMDQ packet
> 

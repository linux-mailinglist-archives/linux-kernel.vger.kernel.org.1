Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C15272B84
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgIUQQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIUQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:16:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3A5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:16:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so13421847wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VlG26JqU7FwBeORSXeuhuiFQeJWA8DcS5yfbqqgjFoI=;
        b=LzbH1QjW77tl2JRTNZN+3mCCa1VJDaXInHVdXNXHD/lXhEsyT30taOJQpj4pCMB9ia
         /B4raLutHcC8Y/FBNWleD/TkOIxoZGIseZ8hjvBudXz4F1zyyt0k9qqJuUZE1SN7A3vF
         DS2/5+vcFMWwXrwwuh2/mgywxnFUPMDNlhOHz0VDb+SGI0VQDR4MuTHCWkj2TAq9wmY0
         toPY6uCGKQkVYvzWCvLM6bHwJEkVO9Lk1TX7bu+gT9cFszv/srm0bvpReMgynk1e7ujn
         jZUceJnx5S4D4BpjVE2ImgfCS0uSS8DUmtm6mzMrxh4vitjcBWScXtxRybZ1XBWn5PZw
         rNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VlG26JqU7FwBeORSXeuhuiFQeJWA8DcS5yfbqqgjFoI=;
        b=iIxhfimW9yFGkjVBuzMl/oIRF9ifprEApEQdkFMYhk/wVezeWNUuBrP+awP3+rViSK
         50yZRhu0Cx8z+veKiFdD3dYKWUAly50fZldfIEQbXivCx5dyTRR/xjvoHUGKtqFfMgjM
         WKNWZZMKtUPgsuqm9cb8/FPoO7d80vpW6th6Y+0X1aTOczNsVMIEQ2vyuuHbrV4wIoRE
         PlXmgnjUmR7MLskTlQYZqtrptTcWvSMhj0ZrP8V/jVTiVDuPXZ+tDwil8T8d8TXhbMSn
         oKaRfpRR1AiTLxZEnNxiPZyN3DVk5V0Uyf1BLHssG8xQbnSmoIE/BIvRgGm0sGOZXM7d
         31KA==
X-Gm-Message-State: AOAM533efqieT8UnJo0UNWBKfbNDQsJkPyMsGCkoIZyZ3eB44cqMjJcU
        0VNwizQKysE0zqEDKty+tfo=
X-Google-Smtp-Source: ABdhPJyNwvoduPPv6j+uBwraRDRsICqaWW6gD6+FGnI81kjd5ZWwWFDuh/xvlGa6UijBkTDICaAixA==
X-Received: by 2002:adf:aa84:: with SMTP id h4mr559557wrc.426.1600704977232;
        Mon, 21 Sep 2020 09:16:17 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id a5sm21218422wrp.37.2020.09.21.09.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:16:16 -0700 (PDT)
Subject: Re: [PATCH v3 5/9] soc: mediatek: cmdq: add write_s value function
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
 <1594136714-11650-6-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <db10d46a-18fb-345f-17a2-b847fb8d0bac@gmail.com>
Date:   Mon, 21 Sep 2020 18:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1594136714-11650-6-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 17:45, Dennis YC Hsieh wrote:
> add write_s function in cmdq helper functions which
> writes a constant value to address with large dma
> access support.
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>

Now pushed to v5.9-next/soc

Thanks!

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c |   14 ++++++++++++++
>   include/linux/soc/mediatek/mtk-cmdq.h  |   13 +++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index ed9f5e63c195..4e86b65815fc 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -280,6 +280,20 @@ int cmdq_pkt_write_s_mask(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
>   }
>   EXPORT_SYMBOL(cmdq_pkt_write_s_mask);
>   
> +int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
> +			   u16 addr_low, u32 value)
> +{
> +	struct cmdq_instruction inst = {};
> +
> +	inst.op = CMDQ_CODE_WRITE_S;
> +	inst.sop = high_addr_reg_idx;
> +	inst.offset = addr_low;
> +	inst.value = value;
> +
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_write_s_value);
> +
>   int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
>   {
>   	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index cd7ec714344e..ae73e10da274 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -152,6 +152,19 @@ int cmdq_pkt_write_s_mask(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
>   			  u16 addr_low, u16 src_reg_idx, u32 mask);
>   
>   /**
> + * cmdq_pkt_write_s_value() - append write_s command to the CMDQ packet which
> + *			      write value to a physical address
> + * @pkt:	the CMDQ packet
> + * @high_addr_reg_idx:	internal register ID which contains high address of pa
> + * @addr_low:	low address of pa
> + * @value:	the specified target value
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_write_s_value(struct cmdq_pkt *pkt, u8 high_addr_reg_idx,
> +			   u16 addr_low, u32 value);
> +
> +/**
>    * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
>    * @pkt:	the CMDQ packet
>    * @event:	the desired event type to "wait and CLEAR"
> 

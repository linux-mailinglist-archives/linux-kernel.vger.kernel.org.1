Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0DB272B72
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIUQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:15:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879ECC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:15:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so13441403wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZPtr60mHTjlNfqCvJeoZ3ko5+1eq2V7IMw/TOsfPRQ=;
        b=K8BLN9iVlIHxqwxjYXAkd6As9BW0RggJe7sjNn+mBBgCUQ2HLR8MRkhj9cpa3Q3tiF
         hbfpW3sJSZtSeOAY2P3zwddPEAglOL96HMb75BTU+j6CoRDcIXOr1wPPFjLTUgBQWxHi
         RNXt95VTVj0oc+r0ARYHsSTmW49ybfwgmD4Nk6Dw/VOoOFAZpCNCj6ABgsVds0llyZpt
         TJ61HLbVYxz7mggew/BVq62CyDMj4jM/iiTOIPMDVRvcNRNpGKmx7Kb4kpnz8Fi9H1M0
         IeVO8T8oqC91sRnAhj3mEoHuDypw1xWylKoblf+W1lCQlDcmlIgSK+Rs0TDqPtkt1VSf
         eAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZPtr60mHTjlNfqCvJeoZ3ko5+1eq2V7IMw/TOsfPRQ=;
        b=MJX5wzy+lkiRiBq3dzfXQMgB2ASeoIn6XJkbTXdI9uGItbtmId/wRzpFY9o32oDgj2
         W/9iUZAP71BQBB2GIoSpAdMioxnmC7/OQbbBJ6o3qrDdIgz++mgcLzbpGK+Ms2p03HyH
         k8VPB2O5H2aWVqEkZnSLVQb9zxrjewyo1FSHUP4ovKRDk3GgEFUnOiqz0/dbD2XrjBLu
         m+SDUvfpgPXsTi09QXmEmn9ZHkK8ogUTyclKDWQGaItxphnviUG/IqFBYyIjv4vjDXDK
         uN4QT31QNfAJ/2XGiCoIkRq0u/v8Eq7JPbXyPLeeNzua1jYHoNx1hiPMZbeQsFZCidCY
         5+Xw==
X-Gm-Message-State: AOAM532mUYvocSNZIfdOhbl3vMvOHZS/WlNg0miSu6+/kr7m+dd1LHx8
        6K9RTGaUxARppkeJ9Se0oaKjC7vNk7rR2A==
X-Google-Smtp-Source: ABdhPJyaI/j2BOiQ7LXv2eZPHmz6CaxDkz9OPzl3YJYlKBDrLEo6lJVeoR/a50CUcy2rfo0sAUN0KA==
X-Received: by 2002:a5d:6784:: with SMTP id v4mr598735wru.132.1600704949233;
        Mon, 21 Sep 2020 09:15:49 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id f12sm91029wmf.26.2020.09.21.09.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:15:48 -0700 (PDT)
Subject: Re: [PATCH v3 3/9] soc: mediatek: cmdq: add write_s_mask function
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
 <1594136714-11650-4-git-send-email-dennis-yc.hsieh@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d37643f0-bf2e-264a-6dc1-cdd485b18576@gmail.com>
Date:   Mon, 21 Sep 2020 18:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1594136714-11650-4-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 17:45, Dennis YC Hsieh wrote:
> add write_s_mask function in cmdq helper functions which
> writes value contains in internal register to address
> with mask and large dma access support.
> 
> Signed-off-by: Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>

Now pushed to v5.9-next/soc

Thanks!

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c   |   23 +++++++++++++++++++++++
>   include/linux/mailbox/mtk-cmdq-mailbox.h |    1 +
>   include/linux/soc/mediatek/mtk-cmdq.h    |   18 ++++++++++++++++++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 880349b3f16c..550e9e7e3ff2 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -242,6 +242,29 @@ int cmdq_pkt_write_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
>   }
>   EXPORT_SYMBOL(cmdq_pkt_write_s);
>   
> +int cmdq_pkt_write_s_mask(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
> +			  u16 addr_low, u16 src_reg_idx, u32 mask)
> +{
> +	struct cmdq_instruction inst = {};
> +	int err;
> +
> +	inst.op = CMDQ_CODE_MASK;
> +	inst.mask = ~mask;
> +	err = cmdq_pkt_append_command(pkt, inst);
> +	if (err < 0)
> +		return err;
> +
> +	inst.mask = 0;
> +	inst.op = CMDQ_CODE_WRITE_S_MASK;
> +	inst.src_t = CMDQ_REG_TYPE;
> +	inst.sop = high_addr_reg_idx;
> +	inst.offset = addr_low;
> +	inst.src_reg = src_reg_idx;
> +
> +	return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_write_s_mask);
> +
>   int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
>   {
>   	struct cmdq_instruction inst = { {0} };
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index 1f76cfedb16d..90d1d8e64412 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -61,6 +61,7 @@ enum cmdq_code {
>   	CMDQ_CODE_WFE = 0x20,
>   	CMDQ_CODE_EOC = 0x40,
>   	CMDQ_CODE_WRITE_S = 0x90,
> +	CMDQ_CODE_WRITE_S_MASK = 0x91,
>   	CMDQ_CODE_LOGIC = 0xa0,
>   };
>   
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 9b0c57a0063d..53230341bf94 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -122,6 +122,24 @@ int cmdq_pkt_write_s(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
>   		     u16 addr_low, u16 src_reg_idx);
>   
>   /**
> + * cmdq_pkt_write_s_mask() - append write_s with mask command to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @high_addr_reg_idx:	internal register ID which contains high address of pa
> + * @addr_low:	low address of pa
> + * @src_reg_idx:	the CMDQ internal register ID which cache source value
> + * @mask:	the specified target address mask, use U32_MAX if no need
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Support write value to physical address without subsys. Use CMDQ_ADDR_HIGH()
> + * to get high address and call cmdq_pkt_assign() to assign value into internal
> + * reg. Also use CMDQ_ADDR_LOW() to get low address for addr_low parameter when
> + * call to this function.
> + */
> +int cmdq_pkt_write_s_mask(struct cmdq_pkt *pkt, u16 high_addr_reg_idx,
> +			  u16 addr_low, u16 src_reg_idx, u32 mask);
> +
> +/**
>    * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
>    * @pkt:	the CMDQ packet
>    * @event:	the desired event type to "wait and CLEAR"
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4776210E38
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgGAPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgGAPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:00:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C27C08C5C1;
        Wed,  1 Jul 2020 08:00:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so24288200wrn.3;
        Wed, 01 Jul 2020 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pHqhpjZJUby9eQpzOQ6VxfAY/WASPlLSgqVZy38byMI=;
        b=WCu8livKyhxoW/UbMXAbrLb/H043C9IdZidoOjlXHVWsYr9W1B59JQRoFa6Oi6vrqy
         BHPC91TVCCngcHtZSDdO1EIMz00t3ZygIlRRSnUJ7GlcMVipvpHfRF7Zvcmkh9BjaDpb
         0dcw/LLYq6E7+/OncOOwH4Gawlah1xMb16t9a+VRxLjfNN5/8Cv5Cj2FlpZRbsPCU8L/
         AW/47GkLkILyz6SmxexLLhy7izLjXKP9rN+mcWeHv65khn5ydfY3YFa0BO+/2UL18TBD
         8PKOWs5hA/JtKSCPJmkqbf6boS+KuIgppFJaATOFV+bJv1aiaZpHUdnBNU+4UPAM68LK
         6N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pHqhpjZJUby9eQpzOQ6VxfAY/WASPlLSgqVZy38byMI=;
        b=D7VtRsLj41Z2ioYQinzuQyKuBonvD+0LMwT3j17smYGaZ6MemcH9Laxk94kUovTy+R
         j3/Dq4DU+G04/3ui7/1AzcOW7bEOKjOxZcX0ihEJQpkbSNLUok/aVVSCKwpJ32QG2CUB
         zUF0VdF4AHRDlCFiSfdPMLNXE/c9FBxpaBdILbjpVeWfBFUBHfgLh61ThqqocjySCf1H
         BS0SYCOVufTwZl4QurpzUin9SjBEf79LyfkoAcL56zkCnzKs09iFnq7DsgTPD/1fZoi4
         vPDm7SG04pv1A7RB9vvTSLt1bUTFdrEI+7jNFkLenDDilbCvFgYWqdGWLnlhYcWfe5Cn
         hocg==
X-Gm-Message-State: AOAM532uNfyyTaA/9a0Rz9xJBjNyZ0xWQEy8iZdFFMNr2mfq7jam+Q6M
        7kCBKrJwXeUj3uvhrT5vE6k=
X-Google-Smtp-Source: ABdhPJxwfRVlYCw+cg95tMVI06AsKTYkyqnkzbouhIbF43+e6NRPCtVb/SjWRZtpImVLpYrauDauhA==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr26975890wrs.365.1593615608901;
        Wed, 01 Jul 2020 08:00:08 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.138])
        by smtp.gmail.com with ESMTPSA id 104sm8005599wrl.25.2020.07.01.08.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:00:08 -0700 (PDT)
Subject: Re: [PATCH v5 07/10] iommu/mediatek: Add REG_MMU_WR_LEN register
 definition
To:     chao hao <Chao.Hao@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        FY Yang <fy.yang@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-8-chao.hao@mediatek.com>
 <ccb63946-e187-187e-c92c-0423f1831d8f@gmail.com>
 <1593514765.13270.3.camel@mbjsdccf07>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5bd3bebc-54ab-b06a-e91b-50c1272ffbf0@gmail.com>
Date:   Wed, 1 Jul 2020 17:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593514765.13270.3.camel@mbjsdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2020 12:59, chao hao wrote:
> On Mon, 2020-06-29 at 12:16 +0200, Matthias Brugger wrote:
>>
>> On 29/06/2020 09:13, Chao Hao wrote:
>>> Some platforms(ex: mt6779) need to improve performance by setting
>>> REG_MMU_WR_LEN register. And we can use WR_THROT_EN macro to control
>>> whether we need to set the register. If the register uses default value,
>>> iommu will send command to EMI without restriction, when the number of
>>> commands become more and more, it will drop the EMI performance. So when
>>> more than ten_commands(default value) don't be handled for EMI, iommu will
>>> stop send command to EMI for keeping EMI's performace by enabling write
>>> throttling mechanism(bit[5][21]=0) in MMU_WR_LEN_CTRL register.
>>>
>>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>>> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
>>> ---
>>>  drivers/iommu/mtk_iommu.c | 10 ++++++++++
>>>  drivers/iommu/mtk_iommu.h |  2 ++
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index ec1f86913739..92316c4175a9 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -46,6 +46,8 @@
>>>  #define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
>>>  
>>>  #define REG_MMU_DCM_DIS				0x050
>>> +#define REG_MMU_WR_LEN				0x054
>>
>> The register name is confusing. For me it seems to describe the length of a
>> write but it is used for controlling the write throttling. Is this the name
>> that's used in the datasheet?
>>
> 
> Thanks for your review carefully, we can name it to REG_MMU_WR_LEN_CTRL

Yes, that's mbetter, thanks.

> 
> 
>>> +#define F_MMU_WR_THROT_DIS_BIT			(BIT(5) |  BIT(21))
>>
>> There are two spaces between '|' and 'BIT(21)', should be one.
>>
>> Regarding the name of the define, what does the 'F_' statnds for? 
> 
> F_ is used to described some bits in register and doesn't have other
> meanings. The format is refer to other bits definition
> 
>> Also I think
>> it should be called '_MASK' instead of '_BIT' as it defines a mask of bits.
>>
> 
> Thanks for your advice.
> For F_MMU_WR_THROT_DIS_BIT:
> 1'b0: Enable write throttling mechanism
> 1'b1: Disable write throttling mechanism
> So I think we can name "F_MMU_WR_THROT_DIS  BIT(5) | BIT(21)" directly,
> it maybe more clearer.
> 

Is this what the datasheet names it? If not then I'd prefer F_MMU_WR_THROT_DIS_MASK.

Regards,
Matthias

>> Regards,
>> Matthias
>>
>>>  
>>>  #define REG_MMU_CTRL_REG			0x110
>>>  #define F_MMU_TF_PROT_TO_PROGRAM_ADDR		(2 << 4)
>>> @@ -582,6 +584,12 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>>>  		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
>>>  	}
>>>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>>> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, WR_THROT_EN)) {
>>> +		/* write command throttling mode */
>>> +		regval = readl_relaxed(data->base + REG_MMU_WR_LEN);
>>> +		regval &= ~F_MMU_WR_THROT_DIS_BIT;
>>> +		writel_relaxed(regval, data->base + REG_MMU_WR_LEN);
>>> +	}
>>>  
>>>  	regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
>>>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
>>> @@ -737,6 +745,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>>>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
>>>  	void __iomem *base = data->base;
>>>  
>>> +	reg->wr_len = readl_relaxed(base + REG_MMU_WR_LEN);
>>>  	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
>>>  	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
>>>  	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
>>> @@ -761,6 +770,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>>>  		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
>>>  		return ret;
>>>  	}
>>> +	writel_relaxed(reg->wr_len, base + REG_MMU_WR_LEN);
>>>  	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
>>>  	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
>>>  	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
>>> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
>>> index be6d32ee5bda..ce4f4e8f03aa 100644
>>> --- a/drivers/iommu/mtk_iommu.h
>>> +++ b/drivers/iommu/mtk_iommu.h
>>> @@ -24,6 +24,7 @@
>>>  #define RESET_AXI			BIT(3)
>>>  #define OUT_ORDER_EN			BIT(4)
>>>  #define HAS_SUB_COMM			BIT(5)
>>> +#define WR_THROT_EN			BIT(6)
>>>  
>>>  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>>>  		((((pdata)->flags) & (_x)) == (_x))
>>> @@ -36,6 +37,7 @@ struct mtk_iommu_suspend_reg {
>>>  	u32				int_main_control;
>>>  	u32				ivrp_paddr;
>>>  	u32				vld_pa_rng;
>>> +	u32				wr_len;
>>>  };
>>>  
>>>  enum mtk_iommu_plat {
>>>
> 

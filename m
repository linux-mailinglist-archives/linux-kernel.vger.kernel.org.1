Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1820272EED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgIUQw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgIUQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:48:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C937C0613CF;
        Mon, 21 Sep 2020 09:48:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so13508256wrn.13;
        Mon, 21 Sep 2020 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=URfAAeE/qgk8sT/Wm2vnk5lrePLdlllj/wkX1f1eM68=;
        b=axs1riWMOvOZyOe8I79CkqKtQynq3c/VspLF0NeNPC4DZCIHGo4GN7GUPx1HDK8vtX
         9XrQCMO0F7RVErZX5NJwUNca6PwhXMgbi+q0flAzXT3HOsorsIfSjZlJ4av+aDUkXKNE
         qg5qbKsME6US5UGq5SPsyfAebdJD3/RBXYMLuXBt4C0kSTazrXHdxRWVzLxT4Ag6BnpV
         IqSpl2ANcf0VwGvxjOdPpYAJrpKK95OdJQNs5yq6i2hfbQO99NJQiB29qxljczGyZ2rH
         qmFwSz3xPjBw44MmBy3Fz95IMRa4pgcDqG8O2O1UwS6xopEhmOBqYWYPNRxAT9psAB9D
         i2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=URfAAeE/qgk8sT/Wm2vnk5lrePLdlllj/wkX1f1eM68=;
        b=aDHXGcJnRNhKkFuLXKURyz/pjuMStoSGJ2sNwMYJSmkkRAd33LKlJtRvhyftF0NRqH
         qIEVe5+P+IFR7d25kiS4E328SqoFBoOFt23wginozNtt+3rObzjWY7ltbyHfyonq2fTu
         EniXdSCf8y74uf6EqsO9pqolXS+uJAIcF7mD9hMZv6jJDX2/kUHLsZsSKXtE/6Owplm1
         jDWVL7xoCuP1ajfvnxubc2w+AYvZH4gygWeazx0RP/7DdEN5Wkt13qEh/GPtrcPDaybj
         ry/FpOUBxLQvKsZwqU3FQ774XiuluXltDxaLBnZYqUk6NLbMlEFQKGLr2FHhQE5UudQk
         EItQ==
X-Gm-Message-State: AOAM533D3vwmZvrrFVTHZcUDoeWLPwZvBQQ3h129YVIOy6V+wgUvUjFS
        W6+UnYgh5DKWD3FOlHSB7Qg=
X-Google-Smtp-Source: ABdhPJzD1+iBNhEfmdzzsEn5iKnl1a/JzgPOb4oQKkaGY8YN7RofKFzYd4I0/RSzVYtptbD8SSsBrA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr620884wro.233.1600706920782;
        Mon, 21 Sep 2020 09:48:40 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id o4sm20889655wru.55.2020.09.21.09.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:48:40 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] soc: mediatek: pwrap: add arbiter capability
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Argus Lin <argus.lin@mediatek.com>, drinkcat@chromium.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
References: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1600686235-27979-3-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <46c0e204-b5e2-4ee3-678b-e09844442aad@gmail.com>
Date:   Mon, 21 Sep 2020 18:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1600686235-27979-3-git-send-email-hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/09/2020 13:03, Hsin-Hsiung Wang wrote:
> Add arbiter capability for pwrap driver.

Can you provide a bit more verbose commit message, please.

> This patch is preparing for adding mt6873/8192 pwrap support.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 57 ++++++++++++++++++++++++++++++------
>   1 file changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index c897205..149bf02 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -25,10 +25,12 @@
>   
>   /* macro for wrapper status */
>   #define PWRAP_GET_WACS_RDATA(x)		(((x) >> 0) & 0x0000ffff)
> +#define PWRAP_GET_WACS_ARB_FSM(x)	(((x) >> 1) & 0x00000007)
>   #define PWRAP_GET_WACS_FSM(x)		(((x) >> 16) & 0x00000007)
>   #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) & 0x00000001)
>   #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
>   #define PWRAP_STATE_INIT_DONE0		BIT(21)
> +#define PWRAP_STATE_INIT_DONE1		BIT(15)
>   
>   /* macro for WACS FSM */
>   #define PWRAP_WACS_FSM_IDLE		0x00
> @@ -74,6 +76,7 @@
>   #define PWRAP_CAP_DCM		BIT(2)
>   #define PWRAP_CAP_INT1_EN	BIT(3)
>   #define PWRAP_CAP_WDT_SRC1	BIT(4)
> +#define PWRAP_CAP_ARB		BIT(5)
>   
>   /* defines for slave device wrapper registers */
>   enum dew_regs {
> @@ -340,6 +343,8 @@ enum pwrap_regs {
>   	PWRAP_DCM_DBC_PRD,
>   	PWRAP_EINT_STA0_ADR,
>   	PWRAP_EINT_STA1_ADR,
> +	PWRAP_SWINF_2_WDATA_31_0,
> +	PWRAP_SWINF_2_RDATA_31_0,
>   
>   	/* MT2701 only regs */
>   	PWRAP_ADC_CMD_ADDR,
> @@ -1108,14 +1113,22 @@ static void pwrap_writel(struct pmic_wrapper *wrp, u32 val, enum pwrap_regs reg)
>   
>   static bool pwrap_is_fsm_idle(struct pmic_wrapper *wrp)
>   {
> -	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	u32 val;
> +
> +	val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		return PWRAP_GET_WACS_ARB_FSM(val) == PWRAP_WACS_FSM_IDLE;
>   
>   	return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_IDLE;
>   }
>   
>   static bool pwrap_is_fsm_vldclr(struct pmic_wrapper *wrp)
>   {
> -	u32 val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	u32 val;
> +
> +	val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		return PWRAP_GET_WACS_ARB_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
>   
>   	return PWRAP_GET_WACS_FSM(val) == PWRAP_WACS_FSM_WFVLDCLR;
>   }
> @@ -1165,6 +1178,7 @@ static int pwrap_wait_for_state(struct pmic_wrapper *wrp,
>   static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   {
>   	int ret;
> +	u32 val;
>   
>   	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_idle);
>   	if (ret) {
> @@ -1172,13 +1186,21 @@ static int pwrap_read16(struct pmic_wrapper *wrp, u32 adr, u32 *rdata)
>   		return ret;
>   	}
>   
> -	pwrap_writel(wrp, (adr >> 1) << 16, PWRAP_WACS2_CMD);
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		val = adr;
> +	else
> +		val = (adr >> 1) << 16;
> +	pwrap_writel(wrp, val, PWRAP_WACS2_CMD);
>   
>   	ret = pwrap_wait_for_state(wrp, pwrap_is_fsm_vldclr);
>   	if (ret)
>   		return ret;
>   
> -	*rdata = PWRAP_GET_WACS_RDATA(pwrap_readl(wrp, PWRAP_WACS2_RDATA));
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		val = pwrap_readl(wrp, PWRAP_SWINF_2_RDATA_31_0);
> +	else
> +		val = pwrap_readl(wrp, PWRAP_WACS2_RDATA);
> +	*rdata = PWRAP_GET_WACS_RDATA(val);
>   
>   	pwrap_writel(wrp, 1, PWRAP_WACS2_VLDCLR);
>   
> @@ -1228,8 +1250,13 @@ static int pwrap_write16(struct pmic_wrapper *wrp, u32 adr, u32 wdata)
>   		return ret;
>   	}
>   
> -	pwrap_writel(wrp, (1 << 31) | ((adr >> 1) << 16) | wdata,
> -		     PWRAP_WACS2_CMD);
> +	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB)) {

Please switch if's so that we take the else branch on the arbiter not present 
case. Or the other way round, just make it uniform, where possible, of course.

> +		pwrap_writel(wrp, BIT(31) | ((adr >> 1) << 16) | wdata,
> +			     PWRAP_WACS2_CMD);
> +	} else {
> +		pwrap_writel(wrp, wdata, PWRAP_SWINF_2_WDATA_31_0);
> +		pwrap_writel(wrp, BIT(29) | adr, PWRAP_WACS2_CMD);
> +	}
>   
>   	return 0;
>   }
> @@ -2022,6 +2049,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
>   static int pwrap_probe(struct platform_device *pdev)
>   {
>   	int ret, irq;
> +	u32 mask_done;
>   	struct pmic_wrapper *wrp;
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct of_device_id *of_slave_id = NULL;
> @@ -2116,14 +2144,21 @@ static int pwrap_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		mask_done = PWRAP_STATE_INIT_DONE1;
> +	else
> +		mask_done = PWRAP_STATE_INIT_DONE0;
> +
> +	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
>   		dev_dbg(wrp->dev, "initialization isn't finished\n");
>   		ret = -ENODEV;
>   		goto err_out2;
>   	}
>   
>   	/* Initialize watchdog, may not be done by the bootloader */
> -	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> +	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> +		pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
> +

Whats the connection between an arbiter being present and the watchdog?

Regards,
Matthias

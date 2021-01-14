Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828102F6861
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbhANRyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbhANRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:54:21 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C653CC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:53:18 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s2so6790156oij.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6sMJO4kfBQwLawdO0k4svr5VHqz+kNn7fUzvcElkSY=;
        b=FTabxqYKus8BeKFYMwPP3TBYhQFd5MqPPYOezyfcp44QWeagP0j0nTV/Yglxmct5Jo
         6p4uIeuPN3dtAksC5zLB4og4d7X1ENfnq880W6BdHb5O3XMWfWGU2/EZ+Rr0iW88c9RV
         KqwE8yX3/EMTW6aPUpF5HiQwZymw1vrYBi2xXAUerqsFgE0Il7Ri+b9SmXgTq8Uw4wQt
         WaX/VDEaXAKN4LkS8OSAIuaWIeXo/DrNlgn7lSafKOsrrx68XQCw3JDcpMb79XyThX96
         w0JYNXPQFeMBuomuTVWV2/hjbs3f9uPuyrNwr6I7fkiqikTWgWWem3Fsj6hXnkOwQXgz
         ddOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6sMJO4kfBQwLawdO0k4svr5VHqz+kNn7fUzvcElkSY=;
        b=PCukeWMZ6sD5Smsq37z/8mKRwUiOn8wy7CHYjaLHRVnmtMKfYDOu/BALLKf6RgPsA/
         ZgSsoEds/Ty+aosQWYUfikHwk19TJHd7eumIj7xEsW3FOnDfD6PzB4CuiTohCSMvLImE
         u2phS1UZ8k8IpuXCP7CnpI2piD8vWFLVjRipTsljn1krQU4XETRNoxtz4QR46Nb1FUek
         qkBCSYDxyXaMSrOdL811hIaBo2u8wwuAJg8523EnR+07OSCPNye9YMkYLuZAxUfe99Im
         UZ0uvPuzvnV8dSU27WgVe/dbqv/lht14x2hK0K4oaYtpyfQS3FvhNvUaJldhyxH7miNK
         Cvhw==
X-Gm-Message-State: AOAM532QMXJ662qIEShQwWLQAFEkSx8iGU/4V3QXcQC9HgmRmmuuvLvB
        wn4bnIA1ZY/lscceYXUBJ4RGPQ==
X-Google-Smtp-Source: ABdhPJy0Rrm7BlryBH/i4qd9aCRnMVWJCF5CVTyVuupU7spv1wfTIU/bEdZC6CzRSJoXSqmS+QtYsw==
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr3296016oij.132.1610646798219;
        Thu, 14 Jan 2021 09:53:18 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m7sm1196101ool.29.2021.01.14.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:53:17 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:53:15 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     agross@kernel.org, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        martin.botka@somainline.org, marijn.suijten@somainline.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/3] phy: qcom-qusb2: Add configuration for SDM660
Message-ID: <YACFC5TK0d0hQbA7@builder.lan>
References: <20210114174718.398638-1-angelogioacchino.delregno@somainline.org>
 <20210114174718.398638-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114174718.398638-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 Jan 11:47 CST 2021, AngeloGioacchino Del Regno wrote:

> The SDM660 SoC uses the same configuration as MSM8996, but the
> clock scheme uses a differential reference clock and none of
> the SoCs in this series (630, 636 and others) have got a usable
> PHY_CLK_SCHEME register in the TCSR for clk scheme detection.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 8fcfea2a8f1f..3629f60460a1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -289,6 +289,19 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
>  	.update_tune1_with_efuse = true,
>  };
>  
> +static const struct qusb2_phy_cfg sdm660_phy_cfg = {
> +	.tbl		= msm8996_init_tbl,
> +	.tbl_num	= ARRAY_SIZE(msm8996_init_tbl),
> +	.regs		= msm8996_regs_layout,
> +
> +	.has_pll_test	= true,
> +	.se_clk_scheme_default = false,
> +	.disable_ctrl	= (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
> +	.mask_core_ready = PLL_LOCKED,
> +	.autoresume_en	 = BIT(3),
> +};
> +
> +
>  static const char * const qusb2_phy_vreg_names[] = {
>  	"vdda-pll", "vdda-phy-dpdm",
>  };
> @@ -829,6 +842,9 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
>  	}, {
>  		.compatible	= "qcom,msm8998-qusb2-phy",
>  		.data		= &msm8998_phy_cfg,
> +	}, {
> +		.compatible	= "qcom,sdm660-qusb2-phy",
> +		.data		= &sdm660_phy_cfg,
>  	}, {
>  		/*
>  		 * Deprecated. Only here to support legacy device
> -- 
> 2.29.2
> 

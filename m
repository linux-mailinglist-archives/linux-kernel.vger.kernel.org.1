Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC92F6859
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbhANRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbhANRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:53:41 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A17C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:53:01 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x5so5957355otp.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6oTorFXnsgqidEZZM4C5olHwJ90X+DJyt6IYyiuwdc=;
        b=uhxCk8QGTrvkw6Q4iKk6o6mhBvNo4CJTqrNFKzUsvC7M54N1VUoTyKlca/QMyL0CEm
         qjdtAqS9O7o2AmeEBn6LfN16bPHGCY1eSNsBkntOoLy0jZ3bEsX7cdbx7Wn66cU1/6Tt
         GKLMthnmdpWpivY1st7Uo3OIWJm9AZVzs20t4gsQHdgJRMT/RQ/2B5mGk0fDuBp3uU0N
         L/PtF3SCWKap1EjINYb0uROYktFJ6l0ALfeIw94JcPg6baaxnraVKSjWJI4nm8cDAsd6
         HCgaYyT67GYzHYNmdnpauRB1D/TQkDM6SHUNaWzeEuyzu5XspxiRBOuo+P1S25NcYPRR
         6WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6oTorFXnsgqidEZZM4C5olHwJ90X+DJyt6IYyiuwdc=;
        b=kYqg0ZjeIqo3M9siJA1OKmQJkl8jbkHtpwZaKFRAFxFiEOMjlYey+aJf+ecmNzxIWa
         Q09evcygAutwGTZBmbSX5Ug71jmFSE4JkTLlNNQq68AUYxBQVC7DZyZikpbiahANkSNZ
         imBQD73BDVHlLRsSDFwx7P+MASYbLaDJBa7X4BkFV8nTnJKb08C/G3Nq8sF6mECHItjw
         eAiPd/27CPPobJbe6c3xzhCZ+mOljRVFyuatAaXcfTNR2ypNOmfevJM+n9jVJrAokAT9
         hjWavmzWKPtVG9D2A3itM+lqkx5TIUbFx5owNqRhbAJ4upbze5xPufudvGUSjOGXeJ2H
         X5tA==
X-Gm-Message-State: AOAM531+UoWswhw+YZjsE1M/qKwSTVLEpUSy0OMOYwH8zpMbj6qzuwSQ
        GF0yRSU23kqZ54dgQNr00GY7Rg==
X-Google-Smtp-Source: ABdhPJzMY9gni+cFIpQXl/kvHR6wSCoWvyMyQZ+533ZIemFA/b2TXL2eeZRnfQCtt3fKHo1/ZlYsgA==
X-Received: by 2002:a05:6830:2157:: with SMTP id r23mr5290727otd.300.1610646780739;
        Thu, 14 Jan 2021 09:53:00 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 63sm1187857otx.2.2021.01.14.09.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:53:00 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:52:58 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     agross@kernel.org, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        martin.botka@somainline.org, marijn.suijten@somainline.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: qcom-qusb2: Allow specifying default clock
 scheme
Message-ID: <YACE+uWidV6xzAwC@builder.lan>
References: <20210114174718.398638-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114174718.398638-1-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 Jan 11:47 CST 2021, AngeloGioacchino Del Regno wrote:

> The TCSR's PHY_CLK_SCHEME register is not available on all SoC
> models, but some may still use a differential reference clock.
> 
> In preparation for these SoCs, add a se_clk_scheme_default
> configuration entry and declare it to true for all currently
> supported SoCs (retaining the previous defaults.
> 
> This patch brings no functional changes.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index 109792203baf..8fcfea2a8f1f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -245,6 +245,9 @@ struct qusb2_phy_cfg {
>  
>  	/* true if PHY has PLL_CORE_INPUT_OVERRIDE register to reset PLL */
>  	bool has_pll_override;
> +
> +	/* true if PHY default clk scheme is single-ended */
> +	bool se_clk_scheme_default;
>  };
>  
>  static const struct qusb2_phy_cfg msm8996_phy_cfg = {
> @@ -253,6 +256,7 @@ static const struct qusb2_phy_cfg msm8996_phy_cfg = {
>  	.regs		= msm8996_regs_layout,
>  
>  	.has_pll_test	= true,
> +	.se_clk_scheme_default = true,
>  	.disable_ctrl	= (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
>  	.mask_core_ready = PLL_LOCKED,
>  	.autoresume_en	 = BIT(3),
> @@ -266,6 +270,7 @@ static const struct qusb2_phy_cfg msm8998_phy_cfg = {
>  	.disable_ctrl   = POWER_DOWN,
>  	.mask_core_ready = CORE_READY_STATUS,
>  	.has_pll_override = true,
> +	.se_clk_scheme_default = true,
>  	.autoresume_en   = BIT(0),
>  	.update_tune1_with_efuse = true,
>  };
> @@ -279,6 +284,7 @@ static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
>  			   POWER_DOWN),
>  	.mask_core_ready = CORE_READY_STATUS,
>  	.has_pll_override = true,
> +	.se_clk_scheme_default = true,
>  	.autoresume_en	  = BIT(0),
>  	.update_tune1_with_efuse = true,
>  };
> @@ -701,8 +707,13 @@ static int qusb2_phy_init(struct phy *phy)
>  	/* Required to get phy pll lock successfully */
>  	usleep_range(150, 160);
>  
> -	/* Default is single-ended clock on msm8996 */
> -	qphy->has_se_clk_scheme = true;
> +	/*
> +	 * Not all the SoCs have got a readable TCSR_PHY_CLK_SCHEME
> +	 * register in the TCSR so, if there's none, use the default
> +	 * value hardcoded in the configuration.
> +	 */
> +	qphy->has_se_clk_scheme = cfg->se_clk_scheme_default;
> +
>  	/*
>  	 * read TCSR_PHY_CLK_SCHEME register to check if single-ended
>  	 * clock scheme is selected. If yes, then disable differential
> -- 
> 2.29.2
> 

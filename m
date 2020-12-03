Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37282CE338
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgLCX4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgLCX4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:56:46 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D610AC061A55
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 15:56:00 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h19so3584463otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGwg7wF1Rp1zHJlnEU83DG1rFe1MHJXahft1afvfgkw=;
        b=cFVS134cbJj6iMT6egtRO9fOue5xD08BfH8wU0s76o/HW63sIQ8i2R6Xw1Yz/ylzYw
         Js+1KrBR5vOqtxPWph9qUZEFd4934TRmhuYWq+6UljiDZZJbXOZy29yGXbBMERH88Iei
         ipVZkskQkP2Q6/dO9+DXGWmKrrQZLYMssa/P0ZiKlIKkrjIhVnKXExX3FNqlKG2X3eoQ
         Zx3LwcYvwI54TqOLxv1mHc+oK1Vy/EtRqsSrgNSlfPyoVmth5PxoOIqoKeHngy0dPhMN
         dFR0+R6/0PJ9r9qBMCwP3oCE0ruuV1JnFx5Lje0V4uJgxSadFbaSGyeiVsQp0wNUAb18
         08sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGwg7wF1Rp1zHJlnEU83DG1rFe1MHJXahft1afvfgkw=;
        b=XzD5j3Byg48C/XfWheXUGQQHbi9DCx+olIYvbEt3EXGhRCZXmCv0mBm0eHsvTJoK55
         /CNqpyQ9ktA8Q57yH30fGcFpi3AZNkgaQeapoGtHW8tJ78fslmSDqUw/d79cIMdo7K+q
         zeiRZOj15HLzCO2EfbZw0HeGPVV1t8KnPLUMCGpxSclx7povW2AxMgKXCmR7GVdepjRd
         oB6T3zZj+HHwp4n6fnFtjPlNFeQYL9fk+zjXAiLH3gyU+w47KgFtZ5ius0TkbrAEWttk
         rLmokcy/e7sFfCE+yzOVGEp0nZGTK+HjH4D+WAv2naZNZlERWIlEo5S1INNxaSTJFicK
         zwDg==
X-Gm-Message-State: AOAM531Chs/MnapbQhxBFgTb6Z+9hWhHTZyUBSGGs9lP4AymCMnExPpe
        6xW9vfNZXFaPIlTAQvJpgCsLEg==
X-Google-Smtp-Source: ABdhPJxNE4tV1l6o8wRPF7g4RBllVxAK7UyVquN7DCEG+XPyOQKZd6cZFGN8ULFVQhynvMYxzcjOgA==
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr1472152oti.244.1607039760143;
        Thu, 03 Dec 2020 15:56:00 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j46sm269809oof.36.2020.12.03.15.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 15:55:59 -0800 (PST)
Date:   Thu, 3 Dec 2020 17:55:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] clk: qcom: rpmh: add support for SM8350 rpmh clocks
Message-ID: <X8l7DSGiQ69Tydzc@builder.lan>
References: <20201203070241.2648874-1-vkoul@kernel.org>
 <20201203070241.2648874-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203070241.2648874-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Dec 01:02 CST 2020, Vinod Koul wrote:

> This adds the RPMH clocks present in SM8350 SoC
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/clk-rpmh.c           | 34 +++++++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,rpmh.h |  8 +++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index e2c669b08aff..64cab4403a17 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -432,6 +432,39 @@ static const struct clk_rpmh_desc clk_rpmh_sm8250 = {
>  	.num_clks = ARRAY_SIZE(sm8250_rpmh_clocks),
>  };
>  
> +DEFINE_CLK_RPMH_VRM(sm8350, div_clk1, div_clk1_ao, "divclka1", 2);
> +DEFINE_CLK_RPMH_VRM(sm8350, rf_clk4, rf_clk4_ao, "rfclka4", 1);
> +DEFINE_CLK_RPMH_VRM(sm8350, rf_clk5, rf_clk5_ao, "rfclka5", 1);
> +DEFINE_CLK_RPMH_BCM(sm8350, pka, "PKA0");
> +DEFINE_CLK_RPMH_BCM(sm8350, hwkm, "HK0");
> +
> +static struct clk_hw *sm8350_rpmh_clocks[] = {
> +	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
> +	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
> +	[RPMH_DIV_CLK1]		= &sm8350_div_clk1.hw,
> +	[RPMH_DIV_CLK1_A]	= &sm8350_div_clk1_ao.hw,
> +	[RPMH_LN_BB_CLK1]	= &sm8250_ln_bb_clk1.hw,
> +	[RPMH_LN_BB_CLK1_A]	= &sm8250_ln_bb_clk1_ao.hw,
> +	[RPMH_LN_BB_CLK2]	= &sdm845_ln_bb_clk2.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &sdm845_ln_bb_clk2_ao.hw,
> +	[RPMH_RF_CLK1]		= &sdm845_rf_clk1.hw,
> +	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
> +	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
> +	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
> +	[RPMH_RF_CLK4]		= &sm8350_rf_clk4.hw,
> +	[RPMH_RF_CLK4_A]	= &sm8350_rf_clk4_ao.hw,
> +	[RPMH_RF_CLK5]		= &sm8350_rf_clk5.hw,
> +	[RPMH_RF_CLK5_A]	= &sm8350_rf_clk5_ao.hw,
> +	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
> +	[RPMH_PKA_CLK]		= &sm8350_pka.hw,
> +	[RPMH_HWKM_CLK]		= &sm8350_hwkm.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sm8350 = {
> +	.clks = sm8350_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sm8350_rpmh_clocks),
> +};
> +
>  static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>  					 void *data)
>  {
> @@ -519,6 +552,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>  	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
>  	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
>  	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
> +	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
> diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
> index 2e6c54e65455..6dbe5d398bf0 100644
> --- a/include/dt-bindings/clock/qcom,rpmh.h
> +++ b/include/dt-bindings/clock/qcom,rpmh.h
> @@ -21,5 +21,13 @@
>  #define RPMH_IPA_CLK				12
>  #define RPMH_LN_BB_CLK1				13
>  #define RPMH_LN_BB_CLK1_A			14
> +#define RPMH_DIV_CLK1				15
> +#define RPMH_DIV_CLK1_A				16
> +#define RPMH_RF_CLK4				17
> +#define RPMH_RF_CLK4_A				18
> +#define RPMH_RF_CLK5				19
> +#define RPMH_RF_CLK5_A				20
> +#define RPMH_PKA_CLK				21
> +#define RPMH_HWKM_CLK				22
>  
>  #endif
> -- 
> 2.26.2
> 

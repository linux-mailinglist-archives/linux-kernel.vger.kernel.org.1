Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A762CF969
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 06:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLEFAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 00:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLEFAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:00:36 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B519C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 20:59:56 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 11so7394139oty.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 20:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wSgUGUXnFDKhHhb8WtgZMF/PzYufjbjvE9QiZ+cHEwU=;
        b=wNe+86mm6puGFc4cLUdEco/Xg9dylu4KR3rHFgk/5vH/fN/B2WDFuN1yI8Q0gzhA+m
         EXDCccbDopJF8zmUciXtRO9A97qjI2q+D/TpwlGtQAfR1tAOvT62SkT+q9GbPT7FmOIt
         BUjHulnXCu6Hsia4155jBq8j9VeaNDQzjNGyb4tlrBUEZtW6fNoY2H8A+tJ+XrY/lrBz
         rkyfEi4ZG+1s2GDI1k2UvvS9mKJAPBB8O9EcQX0etgEGCvVPlFkHKqhGlOlMo+72TZAI
         4HTkHETvC7CZowht4H9tcc5fgWajbcU8VuvDT84H1L9choH2nqZfT7WXGmsuvj0O6Phx
         kYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSgUGUXnFDKhHhb8WtgZMF/PzYufjbjvE9QiZ+cHEwU=;
        b=tMIVY18ToY0bny4GPkC7Opu9oJv4cI4v81WnEP2mgismd4UrhmXJ1MLGedInEv3QHR
         LBTmXX5zY+7R3xG/bgUz3MEy5ZRs6S+IxoLZvhoxwAS5Bf31i62QOcJE4hCJsAbNbwRi
         2+o3LyMVFvARgqNHzDvLeDaaDLCWBos+CH3Q6tPBkiEAFRF8fSHJRNPLMujbJZ99f5TP
         bbRscIXOm8/fzTfCEYprUsusok4M+6iG/uFESnywDFHJ2U+zBYYSB8M8kArpF6gNKN78
         Bq4NRdb441IFrs0AxdhoxcUUCKK4YdfzUF8s8SB7v9ItlLeYfSKpcZo2rIRyY4Y6yIAl
         e++A==
X-Gm-Message-State: AOAM530NpKQdXHHxV6NiIIFERvtEAX+LpUWLwUIbTauX2NqnHJMEbcyt
        PT/QUMRUhxZltLbfjpSHEanQhA==
X-Google-Smtp-Source: ABdhPJwstogV1jeXnSfg4AfmH0pdZThD9cHD4d9HCGJkiYftNyN/ePerd0utakaOsDm0rmg+t10Ymw==
X-Received: by 2002:a9d:3435:: with SMTP id v50mr6044996otb.292.1607144395452;
        Fri, 04 Dec 2020 20:59:55 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h17sm1136458oor.1.2020.12.04.20.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 20:59:54 -0800 (PST)
Date:   Fri, 4 Dec 2020 22:59:52 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     kholk11@gmail.com
Cc:     agross@kernel.org, sboyd@kernel.org, marijns95@gmail.com,
        konradybcio@gmail.com, martin.botka1@gmail.com,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] clk: qcom: Add SDM660 Multimedia Clock Controller
 (MMCC) driver
Message-ID: <X8sTyHGhYeCpqQ/B@builder.lan>
References: <20200926130306.13843-1-kholk11@gmail.com>
 <20200926130306.13843-2-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926130306.13843-2-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26 Sep 08:03 CDT 2020, kholk11@gmail.com wrote:
> diff --git a/drivers/clk/qcom/mmcc-sdm660.c b/drivers/clk/qcom/mmcc-sdm660.c
[..]
> +static int mmcc_660_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	bool is_sdm630 = 0;

This shouldn't be 0, but there's no need for initializing it either, as
the first reference is an assignment. On the other hand, you could
without loss of clarity just move the of_device_is_compatible() into the
if statement directly.

> +
> +	regmap = qcom_cc_map(pdev, &mmcc_660_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	is_sdm630 = of_device_is_compatible(pdev->dev.of_node,
> +					    "qcom,mmcc-sdm630");
> +
> +	clk_alpha_pll_configure(&mmpll3, regmap, &mmpll3_config);
> +	clk_alpha_pll_configure(&mmpll4, regmap, &mmpll4_config);
> +	clk_alpha_pll_configure(&mmpll5, regmap, &mmpll5_config);
> +	clk_alpha_pll_configure(&mmpll7, regmap, &mmpll7_config);
> +	clk_alpha_pll_configure(&mmpll8, regmap, &mmpll8_config);
> +	clk_alpha_pll_configure(&mmpll10, regmap, &mmpll10_config);
> +
> +	if (is_sdm630) {
> +		mmcc_660_desc.clks[BYTE1_CLK_SRC] = 0;
> +		mmcc_660_desc.clks[MDSS_BYTE1_CLK] = 0;
> +		mmcc_660_desc.clks[MDSS_BYTE1_INTF_DIV_CLK] = 0;
> +		mmcc_660_desc.clks[MDSS_BYTE1_INTF_CLK] = 0;
> +		mmcc_660_desc.clks[ESC1_CLK_SRC] = 0;
> +		mmcc_660_desc.clks[MDSS_ESC1_CLK] = 0;
> +		mmcc_660_desc.clks[PCLK1_CLK_SRC] = 0;
> +		mmcc_660_desc.clks[MDSS_PCLK1_CLK] = 0;
> +	}
> +
> +	return qcom_cc_really_probe(pdev, &mmcc_660_desc, regmap);
> +}
> +
> +static struct platform_driver mmcc_660_driver = {
> +	.probe		= mmcc_660_probe,
> +	.driver		= {
> +		.name	= "mmcc-sdm660",
> +		.of_match_table = mmcc_660_match_table,
> +	},
> +};
> +
> +static int __init mmcc_660_init(void)
> +{
> +	return platform_driver_register(&mmcc_660_driver);
> +}
> +core_initcall_sync(mmcc_660_init);
> +
> +static void __exit mmcc_660_exit(void)
> +{
> +	platform_driver_unregister(&mmcc_660_driver);
> +}
> +module_exit(mmcc_660_exit);
> +

The driver is tristate (which is correct), but for that you need a
MODULE_LICENSE at least.

> diff --git a/include/dt-bindings/clock/qcom,mmcc-sdm660.h b/include/dt-bindings/clock/qcom,mmcc-sdm660.h

Please move this to the dt-binding patch, and reorder the two.

> new file mode 100644
> index 000000000000..f9dbc21cb5c7
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,mmcc-sdm660.h
> @@ -0,0 +1,162 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

And please make this "GPL-2.0-only OR BSD-2-Clause".

Regards,
Bjorn

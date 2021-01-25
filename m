Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8DC3028A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbhAYRTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbhAYRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:16:57 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967EC06178C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:14:44 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id x71so15496637oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rkROO57uKmnnVbP7K6y85+srohQ8Aw0WBhKWTRvOvuk=;
        b=qgTYaOuVerpQyuW7/OT7xgdxL/eIy9BR0U7tKWpiGaesQ856FT/YQXBEd0OLn2MwuX
         Yb8HW0gE+QCWRBjAYIoePlDKPITP3O8q/WWPiEYK6ecNWLCovrMyXFV5yRHE9MdVQPl3
         CFiDxFx2kWfJzQgmkn7G+HjnGfQUgSzzAuLM9eqAiBFM+BgnM3osOyKnHiiRMa1loP9d
         yge8S5E3okSsZUh+SXCNPDDutt+uvAitg86zRzNyT66g6SIeGMWfPzQ7sjhVkXyfeXCE
         D4EU1frNjuc+CrTpUckeZgwvaVWUnq8OJoY/3UyRS3zv/hsyz0tfMg6h4T4NQMS7vhgR
         L86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rkROO57uKmnnVbP7K6y85+srohQ8Aw0WBhKWTRvOvuk=;
        b=s/PcMtGnKnAny2wIP7v1uP7xgB9UNfENuk5MlARgcqPJUKTUxI+X9qeFlFbvez964U
         tFaiks+q1pA3ukN3apEv6cQkTId0CLGRR6F+cDr1DZg/oCep2kgBhBK4BYMf3POeIElj
         Np8oqoQHZZInpxPGMV36zWmWsttitdPl80fKtwlU5XpleSbY+TGaS+AiIQJO4nKa4bca
         Lbpe41ZUxScllRBoofJ0JnXwS/XRvXixtIUK5Lia75dNeOOWfA/qliXvdhRJSvvJwiHV
         KrWzYqeh73YV1Ip74dq+uHOIH0vHekDXrJqOZf3ftwj9GITfl8m4woi1w0OV9nxZJJL7
         Vdcw==
X-Gm-Message-State: AOAM531Y2DOtzmmWfEOKJY6zbO9SKr/rHxGYOw2wjReQwfY0vyKWutzp
        /ZE2H9d97wuZDlCWu3rhr4ABoA==
X-Google-Smtp-Source: ABdhPJw13+EEDGOa7bk2nm+Fm+WInSkBPXZIdTqkY0j7a39sHq56ZNWSCPmD3OUyb1YIo3KdyHVRhw==
X-Received: by 2002:aca:4c85:: with SMTP id z127mr755076oia.124.1611594884125;
        Mon, 25 Jan 2021 09:14:44 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g13sm3540748otl.60.2021.01.25.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:14:43 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:14:40 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] clk: qcom: clk-alpha-pll: modularize
 alpha_pll_trion_set_rate()
Message-ID: <YA78gO7xEoZSb+Wy@builder.lan>
References: <20210118044321.2571775-1-vkoul@kernel.org>
 <20210118044321.2571775-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118044321.2571775-3-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 17 Jan 22:43 CST 2021, Vinod Koul wrote:

> Trion 5LPE set rate uses code similar to alpha_pll_trion_set_rate() but
> with different registers. Modularize these by moving out latch and latch
> ack bits so that we can reuse the function.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index f7721088494c..a30ea7b09224 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1471,8 +1471,8 @@ static int alpha_pll_lucid_prepare(struct clk_hw *hw)
>  	return __alpha_pll_trion_prepare(hw, LUCID_PCAL_DONE);
>  }
>  
> -static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
> -				    unsigned long prate)
> +static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long prate, u32 latch_bit, u32 latch_ack)
>  {
>  	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
>  	unsigned long rrate;
> @@ -1490,22 +1490,20 @@ static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
>  	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
>  
>  	/* Latch the PLL input */
> -	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
> -				 PLL_UPDATE, PLL_UPDATE);
> +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), latch_bit, latch_bit);
>  	if (ret)
>  		return ret;
>  
>  	/* Wait for 2 reference cycles before checking the ACK bit. */
>  	udelay(1);
>  	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
> -	if (!(val & ALPHA_PLL_ACK_LATCH)) {
> +	if (!(val & latch_ack)) {
>  		pr_err("Lucid PLL latch failed. Output may be unstable!\n");
>  		return -EINVAL;
>  	}
>  
>  	/* Return the latch input to 0 */
> -	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
> -				 PLL_UPDATE, 0);
> +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), latch_bit, 0);
>  	if (ret)
>  		return ret;
>  
> @@ -1520,6 +1518,12 @@ static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long prate)
> +{
> +	return __alpha_pll_trion_set_rate(hw, rate, prate, PLL_UPDATE, ALPHA_PLL_ACK_LATCH);
> +}
> +
>  const struct clk_ops clk_alpha_pll_trion_ops = {
>  	.prepare = alpha_pll_trion_prepare,
>  	.enable = clk_trion_pll_enable,
> -- 
> 2.26.2
> 

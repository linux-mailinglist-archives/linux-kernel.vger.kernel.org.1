Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982CF2F7B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbhAONDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732594AbhAONDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:03:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED709221FA;
        Fri, 15 Jan 2021 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610715754;
        bh=ecEu9xVKi9pky1OPVUSqIbl4j8EhR8DIBnOEeNIL5V4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWmt9Xc0Kxq+bcUtvPNzlCo5BOUJVvCpBdUhQzwyEIU+09ebIzLuCxlzcUzwnILeo
         ILbKlnifzAhxqfHu0kvK5rkFhbyKhxx6EoR63F5UW1ft7Kz078LC7hluuRCf6RrRGL
         DcgpyfsAqOQN/juc57ICGmj12K7VREZK8l4rQuv9YKT2pd12385sN4GnLbVpR8MF3A
         s4ZkUV7S+3jC3ake8U6KXyQXm+ECpvKtTJQTghuImVJxXIWcoZI2CwE5ewzDj21o8M
         pdr+Hb42wb5rKnz0gFdriDT/OeMozDrMjktdVHcfPELrm9+Db1NP3B66dZmDzNZGi9
         6citvBgVzGO9g==
Date:   Fri, 15 Jan 2021 18:32:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vivek Aknurwar <viveka@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeevan Shriram <jshriram@codeaurora.org>,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org
Subject: Re: [PATCH 2/4] clk: qcom: clk-alpha-pll: Add support for Lucid 5LPE
 PLL
Message-ID: <20210115130229.GG2771@vkoul-mobl>
References: <20210105154645.217998-1-vkoul@kernel.org>
 <20210105154645.217998-3-vkoul@kernel.org>
 <c1354fed-7887-f60f-e288-df7b64d419b7@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1354fed-7887-f60f-e288-df7b64d419b7@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-21, 23:39, AngeloGioacchino Del Regno wrote:
> Il 05/01/21 16:46, Vinod Koul ha scritto:
> > From: Vivek Aknurwar <viveka@codeaurora.org>
> > 
> > Lucid 5LPE is a slightly different Lucid PLL with different offsets and
> > porgramming sequence so add support for these
> > 
> > Signed-off-by: Vivek Aknurwar <viveka@codeaurora.org>
> > Signed-off-by: Jeevan Shriram <jshriram@codeaurora.org>
> > [vkoul: rebase and tidy up for upstream]
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   drivers/clk/qcom/clk-alpha-pll.c | 217 +++++++++++++++++++++++++++++++
> >   drivers/clk/qcom/clk-alpha-pll.h |   4 +
> >   2 files changed, 221 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> > index f7721088494c..843c43649a5a 100644
> > --- a/drivers/clk/qcom/clk-alpha-pll.c
> > +++ b/drivers/clk/qcom/clk-alpha-pll.c
> > @@ -156,6 +156,12 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
> >   /* LUCID PLL specific settings and offsets */
> >   #define LUCID_PCAL_DONE		BIT(27)
> > +/* LUCID 5LPE PLL specific settings and offsets */
> > +#define LUCID_5LPE_PCAL_DONE		BIT(11)
> > +#define LUCID_5LPE_ALPHA_PLL_ACK_LATCH	BIT(13)
> > +#define LUCID_5LPE_PLL_LATCH_INPUT	BIT(14)
> > +#define LUCID_5LPE_ENABLE_VOTE_RUN	BIT(21)
> > +
> >   #define pll_alpha_width(p)					\
> >   		((PLL_ALPHA_VAL_U(p) - PLL_ALPHA_VAL(p) == 4) ?	\
> >   				 ALPHA_REG_BITWIDTH : ALPHA_REG_16BIT_WIDTH)
> > @@ -1600,3 +1606,214 @@ const struct clk_ops clk_alpha_pll_agera_ops = {
> >   	.set_rate = clk_alpha_pll_agera_set_rate,
> >   };
> >   EXPORT_SYMBOL_GPL(clk_alpha_pll_agera_ops);
> > +
> > +static int alpha_pll_lucid_5lpe_enable(struct clk_hw *hw)
> > +{
> > +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* If in FSM mode, just vote for it */
> > +	if (val & LUCID_5LPE_ENABLE_VOTE_RUN) {
> > +		ret = clk_enable_regmap(hw);
> > +		if (ret)
> > +			return ret;
> > +		return wait_for_pll_enable_lock(pll);
> > +	}
> > +
> > +	/* Check if PLL is already enabled, return if enabled */
> > +	ret = trion_pll_is_enabled(pll, pll->clkr.regmap);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
> > +	if (ret)
> > +		return ret;
> > +
> > +	regmap_write(pll->clkr.regmap, PLL_OPMODE(pll), PLL_RUN);
> > +
> > +	ret = wait_for_pll_enable_lock(pll);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable the PLL outputs */
> > +	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, PLL_OUT_MASK);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable the global PLL outputs */
> > +	return regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
> > +}
> > +
> > +static void alpha_pll_lucid_5lpe_disable(struct clk_hw *hw)
> > +{
> > +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> > +	u32 val;
> > +	int ret;
> > +
> > +	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
> > +	if (ret)
> > +		return;
> > +
> > +	/* If in FSM mode, just unvote it */
> > +	if (val & LUCID_5LPE_ENABLE_VOTE_RUN) {
> > +		clk_disable_regmap(hw);
> > +		return;
> > +	}
> > +
> > +	/* Disable the global PLL output */
> > +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
> > +	if (ret)
> > +		return;
> > +
> > +	/* Disable the PLL outputs */
> > +	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
> > +	if (ret)
> > +		return;
> > +
> > +	/* Place the PLL mode in STANDBY */
> > +	regmap_write(pll->clkr.regmap, PLL_OPMODE(pll), PLL_STANDBY);
> > +}
> > +
> > +/*
> > + * The Lucid 5LPE PLL requires a power-on self-calibration which happens
> > + * when the PLL comes out of reset. Calibrate in case it is not completed.
> > + */
> > +static int alpha_pll_lucid_5lpe_prepare(struct clk_hw *hw)
> > +{
> > +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> > +	struct clk_hw *p;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* Return early if calibration is not needed. */
> > +	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
> > +	if (val & LUCID_5LPE_PCAL_DONE)
> > +		return 0;
> > +
> > +	p = clk_hw_get_parent(hw);
> > +	if (!p)
> > +		return -EINVAL;
> > +
> > +	ret = alpha_pll_lucid_5lpe_enable(hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	alpha_pll_lucid_5lpe_disable(hw);
> > +
> > +	return 0;
> > +}
> > +
> > +static int alpha_pll_lucid_5lpe_set_rate(struct clk_hw *hw, unsigned long rate,
> > +					 unsigned long prate)
> > +{
> > +	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> > +	unsigned long rrate;
> > +	u32 val, l;
> > +	u64 a;
> > +	int ret;
> > +
> > +	rrate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_16BIT_WIDTH);
> > +
> > +	/*
> > +	 * Due to a limited number of bits for fractional rate programming, the
> > +	 * rounded up rate could be marginally higher than the requested rate.
> > +	 */
> > +	ret = alpha_pll_check_rate_margin(hw, rrate, rate);
> > +	if (ret)
> > +		return ret;
> > +
> > +	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> > +	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
> > +
> > +	/* Latch the PLL input */
> > +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
> > +				 LUCID_5LPE_PLL_LATCH_INPUT, LUCID_5LPE_PLL_LATCH_INPUT);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Wait for 2 reference cycles before checking the ACK bit. */
> > +	udelay(1);
> > +	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
> > +	if (!(val & LUCID_5LPE_ALPHA_PLL_ACK_LATCH)) {
> > +		pr_err("Lucid 5LPE PLL latch failed. Output may be unstable!\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Return the latch input to 0 */
> > +	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), LUCID_5LPE_PLL_LATCH_INPUT, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (clk_hw_is_enabled(hw)) {
> > +		ret = wait_for_pll_enable_lock(pll);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/* Wait for PLL output to stabilize */
> > +	udelay(100);
> > +	return 0;
> > +}
> > +
> 
> This one looks exactly like alpha_pll_trion_set_rate() but:
> 1. You are forcing ALPHA_REG_16BIT_WIDTH for the alpha_pll_round_rate
>    call: this is bad, you should actually use pll_alpha_width(pll) here,
>    unless you have a very good reason that I didn't understand...
> 2. The only change between these two functions (trion and
>    lucid_5lpe_set_rate) is that PLL_UPDATE becomes
>    LUCID_5LPE_PLL_LATCH_INPUT, and that you check for
>    LUCID_5LPE_ALPHA_PLL_ACK_LATCH instead of ALPHA_PLL_ACK_LATCH: this
>    looks like being 95% code duplication.
> 
> The best options here, in my opinion, would be to commonize the function
> alpha_pll_trion_set_rate: that will avoid this huge duplication.

Yeah I agree we could reuse, I can redo this. I was thinking of making
this bit as one of the values in register and use that but that does not
look good as this is not a register offset, so only option is to have a
new type of PLL for this and use that as here..

-- 
~Vinod

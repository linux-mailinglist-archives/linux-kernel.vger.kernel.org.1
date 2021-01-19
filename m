Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC22FBAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391355AbhASPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389132AbhASPB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:01:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B21D82312E;
        Tue, 19 Jan 2021 15:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611068445;
        bh=WsmEuGO3cSlOjeMFww6osCf8AgOAWnC7qWpR/NPhiYk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IyY451FlUqN/Vi/rDifFifMjL2WrG4ADwDWzIMzB8aZZgPGCSMq6l4tS0vc/L0doY
         /LgQbD7B/EU6tpiRY87862MY12dwame9+KEh1e4c6/k7sxRiFvEuN3Fb1xEB7HinVN
         7UtujWuQ2rUMcwiUFdHtsQkNQ6oZtmoytEPbvUKZmzDY/pcdAQogivkdPi1cbEFL7p
         zswmk9fzJpZc8aavfoTI9D/XuAEu8cKXXlqwQh8LMyMj7o9yhJKCxEd7vTtQUxCQLt
         27cR88l9ZFgoDByqqfHTG2RNVCZkK55TkhP+mFvudVVUriHzi/qfk8bkwqWBIDpXi2
         56FpgcwQ2DkYw==
Subject: Re: [PATCH] clk: socfpga: agilex: add clock driver for eASIC N5X
 platform
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105192956.2059505-1-dinguyen@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <0d9a6222-4628-09b9-4ddb-01a065ce456e@kernel.org>
Date:   Tue, 19 Jan 2021 09:00:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105192956.2059505-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen/Mike,

Was wondering if you had a chance to review this patch?

Thanks,
Dinh


On 1/5/21 1:29 PM, Dinh Nguyen wrote:
> Add support for Intel's eASIC N5X platform. The clock manager driver for
> the N5X is very similar to the Agilex platform, we can re-use most of
> the Agilex clock driver.
> 
> This patch makes the necessary changes for the driver to differentiate
> between the Agilex and the N5X platforms.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>   drivers/clk/socfpga/clk-agilex.c     | 88 +++++++++++++++++++++++++++-
>   drivers/clk/socfpga/clk-periph-s10.c | 53 +++++++++++++++++
>   drivers/clk/socfpga/clk-pll-s10.c    | 85 ++++++++++++++++++++++++++-
>   drivers/clk/socfpga/stratix10-clk.h  | 15 +++++
>   4 files changed, 238 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
> index bb3e80928ebe..f9394ed8a41d 100644
> --- a/drivers/clk/socfpga/clk-agilex.c
> +++ b/drivers/clk/socfpga/clk-agilex.c
> @@ -196,6 +196,17 @@ static const struct stratix10_pll_clock agilex_pll_clks[] = {
>   	  0, 0x9c},
>   };
>   
> +static const struct n5x_perip_c_clock n5x_main_perip_c_clks[] = {
> +	{ AGILEX_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0, 0x54, 0},
> +	{ AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, 0x54, 8},
> +	{ AGILEX_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0, 0x54, 16},
> +	{ AGILEX_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0, 0x54, 24},
> +	{ AGILEX_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0, 0xA8, 0},
> +	{ AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0, 0xA8, 8},
> +	{ AGILEX_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0, 0xA8, 16},
> +	{ AGILEX_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0, 0xA8, 24},
> +};
> +
>   static const struct stratix10_perip_c_clock agilex_main_perip_c_clks[] = {
>   	{ AGILEX_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0, 0x58},
>   	{ AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, 0x5C},
> @@ -289,6 +300,25 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
>   	  10, 0, 0, 0, 0, 0, 4},
>   };
>   
> +static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
> +				       int nums, struct stratix10_clock_data *data)
> +{
> +	struct clk *clk;
> +	void __iomem *base = data->base;
> +	int i;
> +
> +	for (i = 0; i < nums; i++) {
> +		clk = n5x_register_periph(&clks[i], base);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: failed to register clock %s\n",
> +			       __func__, clks[i].name);
> +			continue;
> +		}
> +		data->clk_data.clks[clks[i].id] = clk;
> +	}
> +	return 0;
> +}
> +
>   static int agilex_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
>   				       int nums, struct stratix10_clock_data *data)
>   {
> @@ -367,6 +397,26 @@ static int agilex_clk_register_pll(const struct stratix10_pll_clock *clks,
>   	return 0;
>   }
>   
> +static int n5x_clk_register_pll(const struct stratix10_pll_clock *clks,
> +				 int nums, struct stratix10_clock_data *data)
> +{
> +	struct clk *clk;
> +	void __iomem *base = data->base;
> +	int i;
> +
> +	for (i = 0; i < nums; i++) {
> +		clk = n5x_register_pll(&clks[i], base);
> +		if (IS_ERR(clk)) {
> +			pr_err("%s: failed to register clock %s\n",
> +			       __func__, clks[i].name);
> +			continue;
> +		}
> +		data->clk_data.clks[clks[i].id] = clk;
> +	}
> +
> +	return 0;
> +}
> +
>   static struct stratix10_clock_data *__socfpga_agilex_clk_init(struct platform_device *pdev,
>   						    int nr_clks)
>   {
> @@ -401,7 +451,7 @@ static struct stratix10_clock_data *__socfpga_agilex_clk_init(struct platform_de
>   	return clk_data;
>   }
>   
> -static int agilex_clkmgr_probe(struct platform_device *pdev)
> +static int agilex_clkmgr_init(struct platform_device *pdev)
>   {
>   	struct stratix10_clock_data *clk_data;
>   
> @@ -423,9 +473,43 @@ static int agilex_clkmgr_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static int n5x_clkmgr_init(struct platform_device *pdev)
> +{
> +	struct stratix10_clock_data *clk_data;
> +
> +	clk_data = __socfpga_agilex_clk_init(pdev, AGILEX_NUM_CLKS);
> +	if (IS_ERR(clk_data))
> +		return PTR_ERR(clk_data);
> +
> +	n5x_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
> +
> +	n5x_clk_register_c_perip(n5x_main_perip_c_clks,
> +				 ARRAY_SIZE(n5x_main_perip_c_clks), clk_data);
> +
> +	agilex_clk_register_cnt_perip(agilex_main_perip_cnt_clks,
> +				   ARRAY_SIZE(agilex_main_perip_cnt_clks),
> +				   clk_data);
> +
> +	agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate_clks),
> +			      clk_data);
> +	return 0;
> +}
> +
> +static int agilex_clkmgr_probe(struct platform_device *pdev)
> +{
> +	int (*probe_func)(struct platform_device *);
> +
> +	probe_func = of_device_get_match_data(&pdev->dev);
> +	if (!probe_func)
> +		return -ENODEV;
> +	return	probe_func(pdev);;
> +}
> +
>   static const struct of_device_id agilex_clkmgr_match_table[] = {
>   	{ .compatible = "intel,agilex-clkmgr",
> -	  .data = agilex_clkmgr_probe },
> +	  .data = agilex_clkmgr_init },
> +	{ .compatible = "intel,n5x-clkmgr",
> +	  .data = n5x_clkmgr_init },
>   	{ }
>   };
>   
> diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
> index 397b77b89b16..135581c41c05 100644
> --- a/drivers/clk/socfpga/clk-periph-s10.c
> +++ b/drivers/clk/socfpga/clk-periph-s10.c
> @@ -15,6 +15,21 @@
>   
>   #define to_periph_clk(p) container_of(p, struct socfpga_periph_clk, hw.hw)
>   
> +static unsigned long n5x_clk_peri_c_clk_recalc_rate(struct clk_hw *hwclk,
> +					     unsigned long parent_rate)
> +{
> +	struct socfpga_periph_clk *socfpgaclk = to_periph_clk(hwclk);
> +	unsigned long div;
> +	unsigned long shift = socfpgaclk->shift;
> +	u32 val;
> +
> +	val = readl(socfpgaclk->hw.reg);
> +	val &= (0x1F << shift);
> +	div = (val >> shift) + 1;
> +
> +	return parent_rate / div;
> +}
> +
>   static unsigned long clk_peri_c_clk_recalc_rate(struct clk_hw *hwclk,
>   					     unsigned long parent_rate)
>   {
> @@ -63,6 +78,11 @@ static u8 clk_periclk_get_parent(struct clk_hw *hwclk)
>   	return parent;
>   }
>   
> +static const struct clk_ops n5x_peri_c_clk_ops = {
> +	.recalc_rate = n5x_clk_peri_c_clk_recalc_rate,
> +	.get_parent = clk_periclk_get_parent,
> +};
> +
>   static const struct clk_ops peri_c_clk_ops = {
>   	.recalc_rate = clk_peri_c_clk_recalc_rate,
>   	.get_parent = clk_periclk_get_parent,
> @@ -107,6 +127,39 @@ struct clk *s10_register_periph(const struct stratix10_perip_c_clock *clks,
>   	return clk;
>   }
>   
> +struct clk *n5x_register_periph(const struct n5x_perip_c_clock *clks,
> +				void __iomem *regbase)
> +{
> +	struct clk *clk;
> +	struct socfpga_periph_clk *periph_clk;
> +	struct clk_init_data init;
> +	const char *name = clks->name;
> +	const char *parent_name = clks->parent_name;
> +
> +	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
> +	if (WARN_ON(!periph_clk))
> +		return NULL;
> +
> +	periph_clk->hw.reg = regbase + clks->offset;
> +	periph_clk->shift = clks->shift;
> +
> +	init.name = name;
> +	init.ops = &n5x_peri_c_clk_ops;
> +	init.flags = clks->flags;
> +
> +	init.num_parents = clks->num_parents;
> +	init.parent_names = parent_name ? &parent_name : NULL;
> +
> +	periph_clk->hw.hw.init = &init;
> +
> +	clk = clk_register(NULL, &periph_clk->hw.hw);
> +	if (WARN_ON(IS_ERR(clk))) {
> +		kfree(periph_clk);
> +		return NULL;
> +	}
> +	return clk;
> +}
> +
>   struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *clks,
>   				    void __iomem *regbase)
>   {
> diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
> index 4e268953b7da..4bdf64be3ed4 100644
> --- a/drivers/clk/socfpga/clk-pll-s10.c
> +++ b/drivers/clk/socfpga/clk-pll-s10.c
> @@ -27,10 +27,37 @@
>   #define SWCTRLBTCLKSEL_MASK		0x200
>   #define SWCTRLBTCLKSEL_SHIFT		9
>   
> +#define SOCFPGA_N5X_PLLDIV_FDIV_MASK	GENMASK(16, 8)
> +#define SOCFPGA_N5X_PLLDIV_FDIV_SHIFT	8
> +#define SOCFPGA_N5X_PLLDIV_RDIV_MASK	GENMASK(5, 0)
> +#define SOCFPGA_N5X_PLLDIV_QDIV_MASK	GENMASK(26, 24)
> +#define SOCFPGA_N5X_PLLDIV_QDIV_SHIFT	24
> +
>   #define SOCFPGA_BOOT_CLK		"boot_clk"
>   
>   #define to_socfpga_clk(p) container_of(p, struct socfpga_pll, hw.hw)
>   
> +static unsigned long n5x_clk_pll_recalc_rate(struct clk_hw *hwclk,
> +						unsigned long parent_rate)
> +{
> +	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
> +	unsigned long fdiv, reg, rdiv, qdiv;
> +	u32 power = 1;
> +
> +	/* read VCO1 reg for numerator and denominator */
> +	reg = readl(socfpgaclk->hw.reg + 0x8);
> +	fdiv = (reg & SOCFPGA_N5X_PLLDIV_FDIV_MASK) >> SOCFPGA_N5X_PLLDIV_FDIV_SHIFT;
> +	rdiv = (reg & SOCFPGA_N5X_PLLDIV_RDIV_MASK);
> +	qdiv = (reg & SOCFPGA_N5X_PLLDIV_QDIV_MASK) >> SOCFPGA_N5X_PLLDIV_QDIV_SHIFT;
> +
> +	while (qdiv) {
> +		power *= 2;
> +		qdiv--;
> +	}
> +
> +	return ((parent_rate * 2 * (fdiv + 1)) / ((rdiv + 1) * power));
> +}
> +
>   static unsigned long agilex_clk_pll_recalc_rate(struct clk_hw *hwclk,
>   						unsigned long parent_rate)
>   {
> @@ -123,7 +150,26 @@ static int clk_pll_prepare(struct clk_hw *hwclk)
>   	return 0;
>   }
>   
> -static const struct clk_ops agilex_clk_pll_ops = {
> +static int n5x_clk_pll_prepare(struct clk_hw *hwclk)
> +{
> +	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
> +	u32 reg;
> +
> +	/* Bring PLL out of reset */
> +	reg = readl(socfpgaclk->hw.reg + 0x4);
> +	reg &= ~SOCFPGA_PLL_RESET_MASK;
> +	writel(reg, socfpgaclk->hw.reg + 0x4);
> +
> +	return 0;
> +}
> +
> +static struct clk_ops n5x_clk_pll_ops = {
> +	.recalc_rate = n5x_clk_pll_recalc_rate,
> +	.get_parent = clk_pll_get_parent,
> +	.prepare = n5x_clk_pll_prepare,
> +};
> +
> +static struct clk_ops agilex_clk_pll_ops = {
>   	.recalc_rate = agilex_clk_pll_recalc_rate,
>   	.get_parent = clk_pll_get_parent,
>   	.prepare = clk_pll_prepare,
> @@ -214,3 +260,40 @@ struct clk *agilex_register_pll(const struct stratix10_pll_clock *clks,
>   	}
>   	return clk;
>   }
> +
> +struct clk *n5x_register_pll(const struct stratix10_pll_clock *clks,
> +			     void __iomem *reg)
> +{
> +	struct clk *clk;
> +	struct socfpga_pll *pll_clk;
> +	struct clk_init_data init;
> +	const char *name = clks->name;
> +
> +	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
> +	if (WARN_ON(!pll_clk))
> +		return NULL;
> +
> +	pll_clk->hw.reg = reg + clks->offset;
> +
> +	if (streq(name, SOCFPGA_BOOT_CLK))
> +		init.ops = &clk_boot_ops;
> +	else
> +		init.ops = &n5x_clk_pll_ops;
> +
> +	init.name = name;
> +	init.flags = clks->flags;
> +
> +	init.num_parents = clks->num_parents;
> +	init.parent_names = NULL;
> +	init.parent_data = clks->parent_data;
> +	pll_clk->hw.hw.init = &init;
> +
> +	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
> +
> +	clk = clk_register(NULL, &pll_clk->hw.hw);
> +	if (WARN_ON(IS_ERR(clk))) {
> +		kfree(pll_clk);
> +		return NULL;
> +	}
> +	return clk;
> +}
> diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
> index f9d5d724c694..90441c990855 100644
> --- a/drivers/clk/socfpga/stratix10-clk.h
> +++ b/drivers/clk/socfpga/stratix10-clk.h
> @@ -30,6 +30,17 @@ struct stratix10_perip_c_clock {
>   	unsigned long		offset;
>   };
>   
> +struct n5x_perip_c_clock {
> +	unsigned int		id;
> +	const char		*name;
> +	const char		*parent_name;
> +	const char		*const *parent_names;
> +	u8			num_parents;
> +	unsigned long		flags;
> +	unsigned long		offset;
> +	unsigned long		shift;
> +};
> +
>   struct stratix10_perip_cnt_clock {
>   	unsigned int		id;
>   	const char		*name;
> @@ -64,8 +75,12 @@ struct clk *s10_register_pll(const struct stratix10_pll_clock *,
>   			     void __iomem *);
>   struct clk *agilex_register_pll(const struct stratix10_pll_clock *,
>   				void __iomem *);
> +struct clk *n5x_register_pll(const struct stratix10_pll_clock *,
> +			     void __iomem *);
>   struct clk *s10_register_periph(const struct stratix10_perip_c_clock *,
>   				void __iomem *);
> +struct clk *n5x_register_periph(const struct n5x_perip_c_clock *,
> +				void __iomem *);
>   struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *,
>   				    void __iomem *);
>   struct clk *s10_register_gate(const struct stratix10_gate_clock *,
> 

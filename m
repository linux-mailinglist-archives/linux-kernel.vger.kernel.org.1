Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF72C46D7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbgKYRc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbgKYRc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:32:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA8C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 09:32:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so2694287wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=YeiDrEc86xIycJfwKc5bLCqAgMKj5XTfNaIBX6lyjdA=;
        b=jK5CH9sEY686hQgSKe1CwyrnXFmIAXDl+oH3T/yxkKLng6zt5CB9uStMQrqx9Kuuaw
         dDKmaV/d8ZQr8XFFV5sl1t7MD1d6pjgw8aP/xEywbNs+e/hzP5/DBPH8X0xPoUj+kTm4
         remvAq2JEgWSHMBKs4vp04i4hGdo0gz3l8hS4umApryHihbAC1gIycECc2qbeTQaiRqr
         jq2u/U6sTX7pITA/7cceQIbjh0Na7Ci5G4TXL7mhjzMbbEe03kBP4vlbjOvFzmGq4omk
         t3cpmgZrR0xklyKicea/ZejNOe4ojbtdwPPYOlPa0m9UdegnotnOg0dc3gF/vYu95dRy
         X9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=YeiDrEc86xIycJfwKc5bLCqAgMKj5XTfNaIBX6lyjdA=;
        b=Z98aM1ITsYSQD0pv9RHTM2Xeb6SsLq1D2Aiv2mrdAqBccXhRe+Svbadw4woZJGEIqC
         jQ3Y168yFLS5uKqRBjdgt/1mUDD+EytNdxg6judxmuDQq2JgwVzUULSg2u6UPKIGTRzr
         pkK1BMlDVz+mrf5BGlGxHpNxMGZQSi9+ZDz/7+M1yIwISyTi+C1sJWv2yMRdWLTCdlal
         ld0ZTPJRHGMzWmgRRgQjLcKVe2P0EAaX3an2BaN4WknAzGPlw+B/hPv2rJkIUqwOC4Za
         MsU6lb6aikhltBbWU++Rhp3Iw5r9CLWwUy0G4sabyny6ANhI2G9Dp4iXzBxz0Gcex+W0
         rXjQ==
X-Gm-Message-State: AOAM530MUeknxvX9XMyAGRNrf4Tu/z19nFkEvALBPbrbdfiOnbf554kC
        3V90tq/MUfNs7fspzllUqzQQdw==
X-Google-Smtp-Source: ABdhPJyaibWquAMim/5GHYlHcizp6oZtp39RwCmendo1r++fTRExKmfqUjlExXkf4zP10ewkK4e+5w==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr5354145wrt.312.1606325547270;
        Wed, 25 Nov 2020 09:32:27 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id p4sm5740947wrm.51.2020.11.25.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 09:32:26 -0800 (PST)
References: <20201123163811.353444-1-narmstrong@baylibre.com>
 <20201123163811.353444-3-narmstrong@baylibre.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: meson: g12a: add MIPI DSI Host Pixel Clock
In-reply-to: <20201123163811.353444-3-narmstrong@baylibre.com>
Message-ID: <1jlfep8hqu.fsf@starbuckisacylon.baylibre.com>
Date:   Wed, 25 Nov 2020 18:32:25 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 23 Nov 2020 at 17:38, Neil Armstrong <narmstrong@baylibre.com> wrote:

> This adds the MIPI DSI Host Pixel Clock, unlike AXG, the pixel clock can be different
> from the VPU ENCL output clock to feed the DSI Host controller with a different clock rate.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Series looks good.
2 minor comments below 

> ---
>  drivers/clk/meson/g12a.c | 72 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h |  3 +-
>  2 files changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 3cb8196c8e29..3dedf8408405 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -3658,6 +3658,66 @@ static struct clk_regmap g12a_hdmi_tx = {
>  	},
>  };
>  
> +/* MIPI DSI Host Clocks */
> +
> +static const struct clk_hw *g12a_mipi_dsi_pxclk_parent_hws[] = {
> +	&g12a_vid_pll.hw,
> +	&g12a_gp0_pll.hw,
> +	&g12a_hifi_pll.hw,
> +	&g12a_mpll1.hw,
> +	&g12a_fclk_div2.hw,
> +	&g12a_fclk_div2p5.hw,
> +	&g12a_fclk_div3.hw,
> +	&g12a_fclk_div7.hw,
> +};
> +
> +static struct clk_regmap g12a_mipi_dsi_pxclk_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 12,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mipi_dsi_pxclk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = g12a_mipi_dsi_pxclk_parent_hws,
> +		.num_parents = ARRAY_SIZE(g12a_mipi_dsi_pxclk_parent_hws),
> +		.flags = CLK_SET_RATE_PARENT,

The id of the mux is exposed which seems to hint the mux will be
manually controller but CLK_SET_RATE_NO_REPARENT is not set. Is this on
purpose ?

> +	},
> +};
> +
> +static struct clk_regmap g12a_mipi_dsi_pxclk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mipi_dsi_pxclk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +					&g12a_mipi_dsi_pxclk_sel.hw },

Alignment here is weird compared to the reset of the file

> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap g12a_mipi_dsi_pxclk = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_MIPIDSI_PHY_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mipi_dsi_pxclk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +					&g12a_mipi_dsi_pxclk_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  /* HDMI Clocks */
>  
>  static const struct clk_parent_data g12a_hdmi_parent_data[] = {
> @@ -4403,6 +4463,9 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
>  		[CLKID_SPICC1_SCLK_SEL]		= &g12a_spicc1_sclk_sel.hw,
>  		[CLKID_SPICC1_SCLK_DIV]		= &g12a_spicc1_sclk_div.hw,
>  		[CLKID_SPICC1_SCLK]		= &g12a_spicc1_sclk.hw,
> +		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
> +		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
> +		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -4658,6 +4721,9 @@ static struct clk_hw_onecell_data g12b_hw_onecell_data = {
>  		[CLKID_SPICC1_SCLK_SEL]		= &g12a_spicc1_sclk_sel.hw,
>  		[CLKID_SPICC1_SCLK_DIV]		= &g12a_spicc1_sclk_div.hw,
>  		[CLKID_SPICC1_SCLK]		= &g12a_spicc1_sclk.hw,
> +		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
> +		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
> +		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -4904,6 +4970,9 @@ static struct clk_hw_onecell_data sm1_hw_onecell_data = {
>  		[CLKID_NNA_CORE_CLK_SEL]	= &sm1_nna_core_clk_sel.hw,
>  		[CLKID_NNA_CORE_CLK_DIV]	= &sm1_nna_core_clk_div.hw,
>  		[CLKID_NNA_CORE_CLK]		= &sm1_nna_core_clk.hw,
> +		[CLKID_MIPI_DSI_PXCLK_SEL]	= &g12a_mipi_dsi_pxclk_sel.hw,
> +		[CLKID_MIPI_DSI_PXCLK_DIV]	= &g12a_mipi_dsi_pxclk_div.hw,
> +		[CLKID_MIPI_DSI_PXCLK]		= &g12a_mipi_dsi_pxclk.hw,
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -5151,6 +5220,9 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
>  	&sm1_nna_core_clk_sel,
>  	&sm1_nna_core_clk_div,
>  	&sm1_nna_core_clk,
> +	&g12a_mipi_dsi_pxclk_sel,
> +	&g12a_mipi_dsi_pxclk_div,
> +	&g12a_mipi_dsi_pxclk,
>  };
>  
>  static const struct reg_sequence g12a_init_regs[] = {
> diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
> index 69b6a69549c7..a97613df38b3 100644
> --- a/drivers/clk/meson/g12a.h
> +++ b/drivers/clk/meson/g12a.h
> @@ -264,8 +264,9 @@
>  #define CLKID_NNA_AXI_CLK_DIV			263
>  #define CLKID_NNA_CORE_CLK_SEL			265
>  #define CLKID_NNA_CORE_CLK_DIV			266
> +#define CLKID_MIPI_DSI_PXCLK_DIV		268
>  
> -#define NR_CLKS					268
> +#define NR_CLKS					271
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/g12a-clkc.h>


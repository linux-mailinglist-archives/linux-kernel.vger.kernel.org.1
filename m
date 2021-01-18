Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE32FA07B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391911AbhARMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:53:24 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41774 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391646AbhARMwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:52:54 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D1BE200F03;
        Mon, 18 Jan 2021 13:52:05 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F6F2200EEE;
        Mon, 18 Jan 2021 13:52:05 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AE372030E;
        Mon, 18 Jan 2021 13:52:05 +0100 (CET)
Date:   Mon, 18 Jan 2021 14:52:04 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] clk: imx: Fix reparenting of UARTs not associated
 with sdout
Message-ID: <20210118125204.hxsanoohwvdtdvym@fsr-ub1664-175>
References: <20210115182909.314756-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115182909.314756-1-aford173@gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-15 12:29:08, Adam Ford wrote:

...

> diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
> index a66cabfbf94f..66192fe0a898 100644
> --- a/drivers/clk/imx/clk-imx25.c
> +++ b/drivers/clk/imx/clk-imx25.c
> @@ -73,16 +73,6 @@ enum mx25_clks {
>  
>  static struct clk *clk[clk_max];
>  
> -static struct clk ** const uart_clks[] __initconst = {
> -	&clk[uart_ipg_per],
> -	&clk[uart1_ipg],
> -	&clk[uart2_ipg],
> -	&clk[uart3_ipg],
> -	&clk[uart4_ipg],
> -	&clk[uart5_ipg],
> -	NULL
> -};
> -

I'm assuming there is another patch that updatesthe dts files. Right ?

TBH, I'm against the idea of having to call consumer API from a clock provider driver.
I'm still investigating a way of moving the uart clock control calls in drivers/serial/imx,
where they belong.

>  static int __init __mx25_clocks_init(void __iomem *ccm_base)
>  {
>  	BUG_ON(!ccm_base);
> @@ -228,7 +218,7 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
>  	 */
>  	clk_set_parent(clk[cko_sel], clk[ipg]);
>  
> -	imx_register_uart_clocks(uart_clks);
> +	imx_register_uart_clocks(6);

Suggestion: Maybe the number of clocks can be determined by the existing clocks in that dts node.
Hardcoding is not a good ideea here.

...

>  
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 47882c51cb85..158fe302a8b7 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -147,8 +147,10 @@ void imx_cscmr1_fixup(u32 *val)
>  }
>  
>  #ifndef MODULE
> -static int imx_keep_uart_clocks;
> -static struct clk ** const *imx_uart_clocks;
> +
> +static bool imx_keep_uart_clocks;
> +static int imx_enabled_uart_clocks;
> +static struct clk **imx_uart_clocks;
>  
>  static int __init imx_keep_uart_clocks_param(char *str)
>  {
> @@ -161,24 +163,43 @@ __setup_param("earlycon", imx_keep_uart_earlycon,
>  __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
>  	      imx_keep_uart_clocks_param, 0);
>  
> -void imx_register_uart_clocks(struct clk ** const clks[])
> +void imx_register_uart_clocks(unsigned int clk_count)
>  {
> +#ifdef CONFIG_OF
>  	if (imx_keep_uart_clocks) {
>  		int i;
>  
> -		imx_uart_clocks = clks;
> -		for (i = 0; imx_uart_clocks[i]; i++)
> -			clk_prepare_enable(*imx_uart_clocks[i]);
> +		imx_uart_clocks = kcalloc(clk_count, sizeof(struct clk *), GFP_KERNEL);
> +		imx_enabled_uart_clocks = 0;
> +
> +		for (i = 0; i < clk_count; i++) {
> +			imx_uart_clocks[imx_enabled_uart_clocks] = of_clk_get(of_stdout, i);
> +
> +			/* Stop if there are no more of_stdout references */
> +			if (IS_ERR(imx_uart_clocks[imx_enabled_uart_clocks]))
> +				return;
> +
> +			/* Only enable the clock if it's not NULL */
> +			if (imx_uart_clocks[imx_enabled_uart_clocks])
> +				clk_prepare_enable(imx_uart_clocks[imx_enabled_uart_clocks++]);
> +		}
>  	}
> +#else
> +	/* i.MX boards use device trees now.  For build tests without CONFIG_OF, do nothing */
> +	imx_enabled_uart_clocks = 0;
> +#endif

Don't really see the point of this #ifdef here. Just makes the code more messy.

>  }
>  
>  static int __init imx_clk_disable_uart(void)
>  {
> -	if (imx_keep_uart_clocks && imx_uart_clocks) {
> +	if (imx_keep_uart_clocks && imx_enabled_uart_clocks) {
>  		int i;
>  
> -		for (i = 0; imx_uart_clocks[i]; i++)
> -			clk_disable_unprepare(*imx_uart_clocks[i]);
> +		for (i = 0; i < imx_enabled_uart_clocks; i++) {
> +			clk_disable_unprepare(imx_uart_clocks[i]);
> +			clk_put(imx_uart_clocks[i]);
> +		};
> +		kfree(imx_uart_clocks);
>  	}
>  
>  	return 0;
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 4f04c8287286..7571603bee23 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -11,9 +11,9 @@ extern spinlock_t imx_ccm_lock;
>  void imx_check_clocks(struct clk *clks[], unsigned int count);
>  void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
>  #ifndef MODULE
> -void imx_register_uart_clocks(struct clk ** const clks[]);
> +void imx_register_uart_clocks(unsigned int clk_count);
>  #else
> -static inline void imx_register_uart_clocks(struct clk ** const clks[])
> +static inline void imx_register_uart_clocks(unsigned int clk_count)
>  {
>  }
>  #endif
> -- 
> 2.25.1
> 

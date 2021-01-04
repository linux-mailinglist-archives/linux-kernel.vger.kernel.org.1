Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3FD2E90C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbhADHMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbhADHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:12:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC5C061574
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 23:12:10 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kwK1x-00044f-Iy; Mon, 04 Jan 2021 08:11:53 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kwK1w-0000k2-1v; Mon, 04 Jan 2021 08:11:52 +0100
Date:   Mon, 4 Jan 2021 08:11:52 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fugang Duan <fugang.duan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: imx: enable the earlycon uart clocks by parsing
 from dt
Message-ID: <20210104071152.GA19063@pengutronix.de>
References: <20201229145130.2680442-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229145130.2680442-1-aford173@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:55:54 up 32 days, 19:22, 49 users,  load average: 0.13, 0.08,
 0.10
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, Dec 29, 2020 at 08:51:28AM -0600, Adam Ford wrote:
> Remove the earlycon uart clocks that are hard cord in platforms
> clock driver, instead of parsing the earlycon uart port from dt

"instead parse the earlycon uart..."

Otherwise it's confusing what you mean here.

> and enable these clocks from clock property in dt node.
> 
> Fixes: 9461f7b33d11c ("clk: fix CLK_SET_RATE_GATE with clock rate protection")
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> Based on NXP's code base and adapted for 5.11-rc1.
> https://source.codeaurora.org/external/imx/linux-imx/commit/drivers/clk/imx/clk.c?h=imx_5.4.47_2.2.0&id=754ae82cc55b7445545fc2f092a70e0f490e9c1b
> 
> The original signed-off was retained.
> Added the fixes tag.
> ---
>  drivers/clk/imx/clk.c | 43 +++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 47882c51cb85..c32b46890945 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -148,7 +148,7 @@ void imx_cscmr1_fixup(u32 *val)
>  
>  #ifndef MODULE
>  static int imx_keep_uart_clocks;
> -static struct clk ** const *imx_uart_clocks;
> +static bool imx_uart_clks_on;
>  
>  static int __init imx_keep_uart_clocks_param(char *str)
>  {
> @@ -161,25 +161,40 @@ __setup_param("earlycon", imx_keep_uart_earlycon,
>  __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
>  	      imx_keep_uart_clocks_param, 0);
>  
> -void imx_register_uart_clocks(struct clk ** const clks[])
> +static void imx_earlycon_uart_clks_onoff(bool is_on)

"is_on" sounds like it's the current state of the clock, but actually
the variable is used for the desired state, so I suggest using plain
"on" as name.

>  {
> -	if (imx_keep_uart_clocks) {
> -		int i;
> +	struct clk *uart_clk;
> +	int i = 0;
>  
> -		imx_uart_clocks = clks;
> -		for (i = 0; imx_uart_clocks[i]; i++)
> -			clk_prepare_enable(*imx_uart_clocks[i]);
> -	}
> +	if (!imx_keep_uart_clocks || (!is_on && !imx_uart_clks_on))
> +		return;
> +
> +	/* only support dt */
> +	if (!of_stdout)
> +		return;
> +
> +	do {
> +		uart_clk = of_clk_get(of_stdout, i++);

of_clk_get() allocates memory and gets you a reference to the clock. You
have to release the clock with clk_put(). I think what you have to do
here is to fill an array with clks when called from
imx_register_uart_clocks() and when called from imx_clk_disable_uart()
use that array to clk_disable_unprepare()/clk_put() the clocks.

Sascha

> +		if (IS_ERR(uart_clk))
> +			break;
> +
> +		if (is_on)
> +			clk_prepare_enable(uart_clk);
> +		else
> +			clk_disable_unprepare(uart_clk);
> +	} while (true);
> +
> +	if (is_on)
> +		imx_uart_clks_on = true;
> +}
> +void imx_register_uart_clocks(struct clk ** const clks[])
> +{
> +	imx_earlycon_uart_clks_onoff(true);
>  }
>  
>  static int __init imx_clk_disable_uart(void)
>  {
> -	if (imx_keep_uart_clocks && imx_uart_clocks) {
> -		int i;
> -
> -		for (i = 0; imx_uart_clocks[i]; i++)
> -			clk_disable_unprepare(*imx_uart_clocks[i]);
> -	}
> +	imx_earlycon_uart_clks_onoff(false);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

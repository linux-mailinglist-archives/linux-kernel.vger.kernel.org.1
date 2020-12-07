Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D006D2D0A31
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgLGFZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 00:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgLGFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:25:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F5FC0613D2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 21:24:53 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1km90p-0000C3-J3; Mon, 07 Dec 2020 06:24:39 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1km90o-0000yR-6p; Mon, 07 Dec 2020 06:24:38 +0100
Date:   Mon, 7 Dec 2020 06:24:38 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        charles.steves@logicpd.com, Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: Fix reparenting of UARTs not associated with
 sdout
Message-ID: <20201207052438.GA3977@pengutronix.de>
References: <20201204183154.94002-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204183154.94002-1-aford173@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:13:56 up 4 days, 17:40, 32 users,  load average: 0.04, 0.17, 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Fri, Dec 04, 2020 at 12:31:54PM -0600, Adam Ford wrote:
> The default clock source on i.MX8M Mini and Nano boards use a 24MHz clock,
> but users who need to re-parent the clock source run into issues because
> all the UART clocks are enabled whether or not they're needed by sdout.
> 
> Any attempt to change the parent results in an busy error because the
> clocks have been enabled already.
> 
>   clk: failed to reparent uart1 to sys_pll1_80m: -16
> 
> Instead of pre-initializing all UARTS, scan the device tree to see if UART
> clock is used as stdout before initializing it.  Only enable the UART clock
> if it's needed in order to delay the clock initialization until after the
> re-parenting of the clocks.
> 
> Fixes: 9461f7b33d11c ("clk: fix CLK_SET_RATE_GATE with clock rate protection")
> Suggested-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 47882c51cb85..6dcc5fbd8f3f 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -163,12 +163,18 @@ __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
>  
>  void imx_register_uart_clocks(struct clk ** const clks[])
>  {
> +	struct clk *uart_clk;
>  	if (imx_keep_uart_clocks) {
>  		int i;
>  
>  		imx_uart_clocks = clks;
> -		for (i = 0; imx_uart_clocks[i]; i++)
> -			clk_prepare_enable(*imx_uart_clocks[i]);
> +		for (i = 0; imx_uart_clocks[i]; i++) {
> +			uart_clk = of_clk_get(of_stdout, i);

This looks wrong. imx_uart_clocks is an array containing all clocks that
could possibly be used for an UART. With of_clk_get(of_stdout, i) you
get the nth clock for one specific UART.
What you have to do here is: For each of imx_uart_clocks[] you have to
iterate over all clocks of the of_stdout node.

Sascha

> +			if (IS_ERR(uart_clk))
> +				continue;
> +			clk_prepare_enable(uart_clk);
> +			clk_put(uart_clk);
> +		}
>  	}
>  }
>  
> -- 
> 2.25.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

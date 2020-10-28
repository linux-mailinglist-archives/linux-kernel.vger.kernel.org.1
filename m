Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C877029D5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgJ1WJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:09:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50109 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbgJ1WJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:09:09 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kXgkg-0006bG-1o; Wed, 28 Oct 2020 09:24:14 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kXgke-00023H-St; Wed, 28 Oct 2020 09:24:12 +0100
Date:   Wed, 28 Oct 2020 09:24:12 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx: gate2: Fix the is_enabled op
Message-ID: <20201028082412.GU26805@pengutronix.de>
References: <1603738248-8193-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603738248-8193-1-git-send-email-abel.vesa@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:05:22 up 251 days, 15:35, 142 users,  load average: 0.56, 0.42,
 0.30
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Mon, Oct 26, 2020 at 08:50:48PM +0200, Abel Vesa wrote:
> The clock is considered to be enabled only if the controlling bits
> match the cgr_val mask. Also make sure the is_enabled returns the
> correct vaule by locking the access to the register.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Fixes: 1e54afe9fcfe ("clk: imx: gate2: Allow single bit gating clock")
> ---
>  drivers/clk/imx/clk-gate2.c | 60 ++++++++++++++++++++-------------------------
>  drivers/clk/imx/clk.h       |  8 ++----
>  2 files changed, 29 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
> index 7eed708..f320bd2b 100644
> --- a/drivers/clk/imx/clk-gate2.c
> +++ b/drivers/clk/imx/clk-gate2.c
> @@ -37,10 +37,22 @@ struct clk_gate2 {
>  
>  #define to_clk_gate2(_hw) container_of(_hw, struct clk_gate2, hw)
>  
> +static void clk_gate2_do_shared_clks(struct clk_hw *hw, bool enable)
> +{
> +	struct clk_gate2 *gate = to_clk_gate2(hw);
> +	u32 reg;
> +
> +	reg = readl(gate->reg);
> +	if (enable)
> +		reg |= gate->cgr_val << gate->bit_idx;
> +	else
> +		reg &= ~(gate->cgr_val << gate->bit_idx);

Shouldn't this be:

	reg &= ~(3 << gate->bit_idx);
	if (enable)
		reg |= gate->cgr_val << gate->bit_idx;

At least that's how it was without this patch and that's how it makes
sense to me with cgr_val != 3.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664E6303C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405497AbhAZLwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405479AbhAZLvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:51:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBEAC061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:51:08 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l4MsD-00089m-PB; Tue, 26 Jan 2021 12:51:05 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l4MsD-0000iA-B6; Tue, 26 Jan 2021 12:51:05 +0100
Date:   Tue, 26 Jan 2021 12:51:05 +0100
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [RFC] clk: Mark HW enabled clocks as enabled in core
Message-ID: <20210126115105.GD28722@pengutronix.de>
References: <1611660096-12381-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611660096-12381-1-git-send-email-abel.vesa@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:46:48 up 55 days, 13 min, 98 users,  load average: 0.21, 0.10,
 0.10
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 01:21:36PM +0200, Abel Vesa wrote:
> Some clocks are already enabled in HW even before the kernel
> starts to boot. So, in order to make sure that these clocks do not
> get disabled when clk_disable_unused call is done or when
> reparenting clocks, we enable them in core on clock registration.
> Such a clock will have to be registered with CLK_IGNORE_UNUSED flag
> and also needs to have the is_enabled ops implemented.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/clk.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 3d751ae5bc70..26d55851cfa5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3416,6 +3416,7 @@ static int __clk_core_init(struct clk_core *core)
>  	int ret;
>  	struct clk_core *parent;
>  	unsigned long rate;
> +	bool is_hw_enabled = false;
>  	int phase;
>  
>  	if (!core)
> @@ -3558,12 +3559,20 @@ static int __clk_core_init(struct clk_core *core)
>  		rate = 0;
>  	core->rate = core->req_rate = rate;
>  
> +	/*
> +	 * If the clock has the CLK_IGNORE_UNUSED flag set and it is already
> +	 * enabled in HW, enable it in core too so it won't get accidentally
> +	 * disabled when walking the orphan tree and reparenting clocks
> +	 */
> +	if (core->flags & CLK_IGNORE_UNUSED && core->ops->is_enabled)
> +		is_hw_enabled = clk_core_is_enabled(core);
> +
>  	/*
>  	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
>  	 * don't get accidentally disabled when walking the orphan tree and
>  	 * reparenting clocks
>  	 */
> -	if (core->flags & CLK_IS_CRITICAL) {
> +	if (core->flags & CLK_IS_CRITICAL || is_hw_enabled) {
>  		unsigned long flags;
>  
>  		ret = clk_core_prepare(core);

This means that a bootloader enabled clock with CLK_IGNORE_UNUSED flag
can effectively never be disabled because the prepare/enable count is 1
without any user. This is the behaviour we want to have with critical
clocks, but I don't think this is desired for clocks with the
CLK_IGNORE_UNUSED flag.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

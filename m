Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0E29D5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgJ1WJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:09:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41615 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgJ1WJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:09:11 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kXiUj-0002Qk-8m; Wed, 28 Oct 2020 11:15:53 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kXiUi-0000Xa-FY; Wed, 28 Oct 2020 11:15:52 +0100
Date:   Wed, 28 Oct 2020 11:15:52 +0100
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
Message-ID: <20201028101552.GA26805@pengutronix.de>
References: <1603738248-8193-1-git-send-email-abel.vesa@nxp.com>
 <20201028082412.GU26805@pengutronix.de>
 <20201028095057.cuaxqqr4yzxvzwvp@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028095057.cuaxqqr4yzxvzwvp@fsr-ub1664-175>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:04:33 up 251 days, 17:35, 155 users,  load average: 0.06, 0.22,
 0.24
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 11:50:57AM +0200, Abel Vesa wrote:
> On 20-10-28 09:24:12, Sascha Hauer wrote:
> > Hi Abel,
> > 
> > On Mon, Oct 26, 2020 at 08:50:48PM +0200, Abel Vesa wrote:
> > > The clock is considered to be enabled only if the controlling bits
> > > match the cgr_val mask. Also make sure the is_enabled returns the
> > > correct vaule by locking the access to the register.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > Fixes: 1e54afe9fcfe ("clk: imx: gate2: Allow single bit gating clock")
> > > ---
> > >  drivers/clk/imx/clk-gate2.c | 60 ++++++++++++++++++++-------------------------
> > >  drivers/clk/imx/clk.h       |  8 ++----
> > >  2 files changed, 29 insertions(+), 39 deletions(-)
> > > 
> > > diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
> > > index 7eed708..f320bd2b 100644
> > > --- a/drivers/clk/imx/clk-gate2.c
> > > +++ b/drivers/clk/imx/clk-gate2.c
> > > @@ -37,10 +37,22 @@ struct clk_gate2 {
> > >  
> > >  #define to_clk_gate2(_hw) container_of(_hw, struct clk_gate2, hw)
> > >  
> > > +static void clk_gate2_do_shared_clks(struct clk_hw *hw, bool enable)
> > > +{
> > > +	struct clk_gate2 *gate = to_clk_gate2(hw);
> > > +	u32 reg;
> > > +
> > > +	reg = readl(gate->reg);
> > > +	if (enable)
> > > +		reg |= gate->cgr_val << gate->bit_idx;
> > > +	else
> > > +		reg &= ~(gate->cgr_val << gate->bit_idx);
> > 
> > Shouldn't this be:
> > 
> > 	reg &= ~(3 << gate->bit_idx);
> > 	if (enable)
> > 		reg |= gate->cgr_val << gate->bit_idx;
> > 
> > At least that's how it was without this patch and that's how it makes
> > sense to me with cgr_val != 3.
> > 
> 
> Well, that's the actual problem. The value 3 forces all the clocks
> that register with this clock type to have 2 bits for controlling the gate.
> 
> My patch (though now I think I should split it into 2 separate patches) allows
> two HW gates to be controlled by as many bits necessary. For example, there
> could be multiple HW gates that are controled by the same bit. By passing
> the cgr_val when registering the clocks you can specify how many bits (as a mask)
> control all those HW gates that share their control bits.

cgr_val is not a mask, it's a value that shall be written to the two
bits to enable the clock. cgr_val could also be 0b10, see imx_clk_gate2_cgr().

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE7629D318
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgJ1Vkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:40:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46844 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgJ1Vko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:40:44 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B1D24201578;
        Wed, 28 Oct 2020 10:50:57 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A495420156B;
        Wed, 28 Oct 2020 10:50:57 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FD512030E;
        Wed, 28 Oct 2020 10:50:57 +0100 (CET)
Date:   Wed, 28 Oct 2020 11:50:57 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
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
Message-ID: <20201028095057.cuaxqqr4yzxvzwvp@fsr-ub1664-175>
References: <1603738248-8193-1-git-send-email-abel.vesa@nxp.com>
 <20201028082412.GU26805@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028082412.GU26805@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-28 09:24:12, Sascha Hauer wrote:
> Hi Abel,
> 
> On Mon, Oct 26, 2020 at 08:50:48PM +0200, Abel Vesa wrote:
> > The clock is considered to be enabled only if the controlling bits
> > match the cgr_val mask. Also make sure the is_enabled returns the
> > correct vaule by locking the access to the register.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Fixes: 1e54afe9fcfe ("clk: imx: gate2: Allow single bit gating clock")
> > ---
> >  drivers/clk/imx/clk-gate2.c | 60 ++++++++++++++++++++-------------------------
> >  drivers/clk/imx/clk.h       |  8 ++----
> >  2 files changed, 29 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
> > index 7eed708..f320bd2b 100644
> > --- a/drivers/clk/imx/clk-gate2.c
> > +++ b/drivers/clk/imx/clk-gate2.c
> > @@ -37,10 +37,22 @@ struct clk_gate2 {
> >  
> >  #define to_clk_gate2(_hw) container_of(_hw, struct clk_gate2, hw)
> >  
> > +static void clk_gate2_do_shared_clks(struct clk_hw *hw, bool enable)
> > +{
> > +	struct clk_gate2 *gate = to_clk_gate2(hw);
> > +	u32 reg;
> > +
> > +	reg = readl(gate->reg);
> > +	if (enable)
> > +		reg |= gate->cgr_val << gate->bit_idx;
> > +	else
> > +		reg &= ~(gate->cgr_val << gate->bit_idx);
> 
> Shouldn't this be:
> 
> 	reg &= ~(3 << gate->bit_idx);
> 	if (enable)
> 		reg |= gate->cgr_val << gate->bit_idx;
> 
> At least that's how it was without this patch and that's how it makes
> sense to me with cgr_val != 3.
> 

Well, that's the actual problem. The value 3 forces all the clocks
that register with this clock type to have 2 bits for controlling the gate.

My patch (though now I think I should split it into 2 separate patches) allows
two HW gates to be controlled by as many bits necessary. For example, there
could be multiple HW gates that are controled by the same bit. By passing
the cgr_val when registering the clocks you can specify how many bits (as a mask)
control all those HW gates that share their control bits.

> Sascha
> 

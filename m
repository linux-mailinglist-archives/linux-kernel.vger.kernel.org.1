Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4D24260C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 09:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHLH25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 03:28:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44566 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgHLH24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:28:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5564120003C;
        Wed, 12 Aug 2020 09:28:54 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 45412200002;
        Wed, 12 Aug 2020 09:28:54 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3092B2030A;
        Wed, 12 Aug 2020 09:28:54 +0200 (CEST)
Date:   Wed, 12 Aug 2020 10:28:54 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 11/17] clk: imx: Add blk_ctrl combo driver
Message-ID: <20200812072854.4r4d6cz5cprezlof@fsr-ub1664-175>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-12-git-send-email-abel.vesa@nxp.com>
 <d44e88a1408add6491897a8793b57ee0090fa4c6.camel@pengutronix.de>
 <20200730085508.ddxhb4rjnzwooh2z@fsr-ub1664-175>
 <3f4fd963bdf58e61715524fdb246481fb2b2d137.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4fd963bdf58e61715524fdb246481fb2b2d137.camel@pengutronix.de>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-30 11:39:22, Philipp Zabel wrote:
> On Thu, 2020-07-30 at 11:55 +0300, Abel Vesa wrote:
> > On 20-07-29 14:46:28, Philipp Zabel wrote:
> > > Hi Abel,
> > > 
> > > On Wed, 2020-07-29 at 15:07 +0300, Abel Vesa wrote:
> > > > On i.MX8MP, there is a new type of IP which is called BLK_CTRL in
> > 
> > [...]
> > 
> > > > +
> > > > +static int imx_blk_ctrl_reset_set(struct reset_controller_dev *rcdev,
> > > > +				  unsigned long id, bool assert)
> > > > +{
> > > > +	struct imx_blk_ctrl_drvdata *drvdata = container_of(rcdev,
> > > > +			struct imx_blk_ctrl_drvdata, rcdev);
> > > > +	unsigned int offset = drvdata->rst_hws[id].offset;
> > > > +	unsigned int shift = drvdata->rst_hws[id].shift;
> > > > +	unsigned int mask = drvdata->rst_hws[id].mask;
> > > > +	void __iomem *reg_addr = drvdata->base + offset;
> > > > +	unsigned long flags;
> > > > +	u32 reg;
> > > > +
> > > > +	if (assert) {
> > > > +		pm_runtime_get_sync(rcdev->dev);
> > > > +		spin_lock_irqsave(&drvdata->lock, flags);
> > > > +		reg = readl(reg_addr);
> > > > +		writel(reg & ~(mask << shift), reg_addr);
> > > > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > > > +	} else {
> > > > +		spin_lock_irqsave(&drvdata->lock, flags);
> > > > +		reg = readl(reg_addr);
> > > > +		writel(reg | (mask << shift), reg_addr);
> > > > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > > > +		pm_runtime_put(rcdev->dev);
> > > 
> > > This still has the issue of potentially letting exclusive reset control
> > > users break the device usage counter.
> > > 
> > > Also shared reset control users start with deassert(), and you end probe
> > > with pm_runtime_put(), so the first shared reset control user that
> > > deasserts its reset will decrement the dev->power.usage_count to -1 ?
> > > For multiple resets being initially deasserted this would decrement
> > > multiple times.
> > > 
> > > I think you'll have to track the (number of) asserted reset bits in this
> > > reset controller and limit when to call pm_runtime_get/put_sync().
> > > 
> > 
> > Yes, you're right.
> > 
> > I'll add a mask, and for each assert, the according bit will get set, and 
> > for each deasssert the same bit will get cleared.
> 
> > And when the mask has at least one bit set, the pm_runtime_get gets called
> 
> ^ When the mask was 0 before but now has a bit set.
> 
> > and when the mask is 0, the pm_runtime_put_sync will be called.
> 
> ^ When the mask had a bit set but now is 0.
> 
> > Does that sound OK ?
> 
> And the mask starts out as 0, as after the pm_runtime_put() in probe all
> reset lines are deasserted?
> 

Yes, that is correct.

> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int imx_blk_ctrl_reset_reset(struct reset_controller_dev *rcdev,
> > > > +					   unsigned long id)
> > > > +{
> > > > +	imx_blk_ctrl_reset_set(rcdev, id, true);
> > > > +	return imx_blk_ctrl_reset_set(rcdev, id, false);
> > > 
> > > Does this work for all peripherals? Are there none that require the
> > > reset line to be asserted for a certain number of bus clocks or similar?
> > 
> > As of now, there is no user that calls reset. All the users call the assert
> > and then deassert. As for the number of clocks for reset, I'll try to have a
> > chat to the HW design team and then come back with the information.
> 
> Ok. If this is not required or can't be guaranteed to work, it may be
> better to just leave it out.
> 
> regards
> Philipp

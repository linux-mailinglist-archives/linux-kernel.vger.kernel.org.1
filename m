Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE52B67C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgKQOse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:48:34 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35778 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgKQOsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:48:33 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A9A141A1380;
        Tue, 17 Nov 2020 15:48:28 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A01E1A137A;
        Tue, 17 Nov 2020 15:48:28 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 838BD20340;
        Tue, 17 Nov 2020 15:48:28 +0100 (CET)
Date:   Tue, 17 Nov 2020 16:48:28 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
Message-ID: <20201117144828.omlwhu5y7cwsf5ci@fsr-ub1664-175>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
 <1604402306-5348-11-git-send-email-abel.vesa@nxp.com>
 <CAA+hA=TfyW6Ya9adcQFd1=-sJyoCgMyaENmGumtV1ZYar1Ud2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=TfyW6Ya9adcQFd1=-sJyoCgMyaENmGumtV1ZYar1Ud2g@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-11 17:13:25, Dong Aisheng wrote:
> On Tue, Nov 3, 2020 at 7:22 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> ...
> > +static int imx_blk_ctl_reset_set(struct reset_controller_dev *rcdev,
> > +                                 unsigned long id, bool assert)
> > +{
> > +       struct imx_blk_ctl_drvdata *drvdata = container_of(rcdev,
> > +                       struct imx_blk_ctl_drvdata, rcdev);
> > +       unsigned int offset = drvdata->rst_hws[id].offset;
> > +       unsigned int shift = drvdata->rst_hws[id].shift;
> > +       unsigned int mask = drvdata->rst_hws[id].mask;
> > +       void __iomem *reg_addr = drvdata->base + offset;
> > +       unsigned long flags;
> > +       u32 reg;
> > +
> > +       if (!assert && !test_bit(1, &drvdata->rst_hws[id].asserted))
> > +               return -ENODEV;
> 
> What if consumers call deassert first in probe which seems common in kernel?
> It seems will fail.
> e.g.
> probe() {
>     reset_control_get()
>     reset_control_deassert()
> }
> 
> Regards
> Aisheng
> 

OK, I'm trying to explain here how I know the resets are supposed to be working
and how the BLK_CTL IP is working.


First of, the BLK_CTL bits (resets and clocks) all have the HW init (default) values
as 0. Basically, after the blk_ctl PD is powered on, the resets are deasserted and
clocks are gated by default. Since the blk_ctl is not the parent of any of the
consumers in devicetree (the reg maps are entirely different anyway), there is no
way of ordering the runtime callbacks between the consumer and the blk_ctl. So we
might end up having the runtime resume callback after the one from EARC (consumer),
for example, which will basically overwrite the value written by EARC driver with
whatever was saved on suspend.

Now, about the usage of the reset bits. AFAICT, it would make more sense to assert
the reset, then enable the clock, then deassert. This way, you're keeping the
EARC (consumer) in reset (with the clocks on) until you eventually release it out of
reset by deasserting. This is how the runtime resume should deal with the reset
and the clock. As for the runtime suspend, the reset can be entirely ignored as long
as you're disabling the clock.

This last part will allow the blk_ctl to make the following assumption:
if all the clocks are disabled and none of the reset bits are asserted, I can power off.

Now, I know there are drivers outthere that do assert on suspend, but as long as the 
clocks are disabled, the assert will have no impact. But maybe in their case the reset
controller cannot power down itself.

As for the safekeeping of the register, I'll just drop it due to the following arguments:
1. all the clocks are gated by default
2. all resets are deasserted by default
3. when blk_ctl goes down, all the consumers go down. (all have the same PD)

From 1 and 2 results the IP will not be running and from 3 results the HW state
of every IP becomes HW init state.

> > +
> > +       if (assert && !test_and_set_bit(1, &drvdata->rst_hws[id].asserted))
> > +               pm_runtime_get_sync(rcdev->dev)
> > +
> > +       spin_lock_irqsave(&drvdata->lock, flags);
> > +
> > +       reg = readl(reg_addr);
> > +       if (assert)
> > +               writel(reg & ~(mask << shift), reg_addr);
> > +       else
> > +               writel(reg | (mask << shift), reg_addr);
> > +
> > +       spin_unlock_irqrestore(&drvdata->lock, flags);
> > +
> > +       if (!assert && test_and_clear_bit(1, &drvdata->rst_hws[id].asserted))
> > +               pm_runtime_put(rcdev->dev)
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx_blk_ctl_reset_assert(struct reset_controller_dev *rcdev,
> > +                                          unsigned long id)
> > +{
> > +       return imx_blk_ctl_reset_set(rcdev, id, true);
> > +}
> > +
> > +static int imx_blk_ctl_reset_deassert(struct reset_controller_dev *rcdev,
> > +                                            unsigned long id)
> > +{
> > +       return imx_blk_ctl_reset_set(rcdev, id, false);
> > +}
> > +
> > +static const struct reset_control_ops imx_blk_ctl_reset_ops = {
> > +       .assert         = imx_blk_ctl_reset_assert,
> > +       .deassert       = imx_blk_ctl_reset_deassert,
> > +};
> > +
> > +static int imx_blk_ctl_register_reset_controller(struct device *dev)
> > +{
> > +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> > +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> > +       int max = dev_data->resets_max;
> > +       struct imx_reset_hw *hws;
> > +       int i;
> > +
> > +       spin_lock_init(&drvdata->lock);
> > +
> > +       drvdata->rcdev.owner     = THIS_MODULE;
> > +       drvdata->rcdev.nr_resets = max;
> > +       drvdata->rcdev.ops       = &imx_blk_ctl_reset_ops;
> > +       drvdata->rcdev.of_node   = dev->of_node;
> > +       drvdata->rcdev.dev       = dev;
> > +
> > +       drvdata->rst_hws = devm_kcalloc(dev, max, sizeof(struct imx_reset_hw),
> > +                                       GFP_KERNEL);
> > +       hws = drvdata->rst_hws;
> > +
> > +       for (i = 0; i < dev_data->hws_num; i++) {
> > +               struct imx_blk_ctl_hw *hw = &dev_data->hws[i];
> > +
> > +               if (hw->type != BLK_CTL_RESET)
> > +                       continue;
> > +
> > +               hws[hw->id].offset = hw->offset;
> > +               hws[hw->id].shift = hw->shift;
> > +               hws[hw->id].mask = hw->mask;
> > +       }
> > +
> > +       return devm_reset_controller_register(dev, &drvdata->rcdev);
> > +}
> > +static struct clk_hw *imx_blk_ctl_register_one_clock(struct device *dev,
> > +                                               struct imx_blk_ctl_hw *hw)
> > +{
> > +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> > +       void __iomem *base = drvdata->base;
> > +       struct clk_hw *clk_hw = NULL;
> > +
> > +       switch (hw->type) {
> > +       case BLK_CTL_CLK_MUX:
> > +               clk_hw = imx_dev_clk_hw_mux_flags(dev, hw->name,
> > +                                                 base + hw->offset,
> > +                                                 hw->shift, hw->width,
> > +                                                 hw->parents,
> > +                                                 hw->parents_count,
> > +                                                 hw->flags);
> > +               break;
> > +       case BLK_CTL_CLK_GATE:
> > +               clk_hw = imx_dev_clk_hw_gate(dev, hw->name, hw->parents,
> > +                                            base + hw->offset, hw->shift);
> > +               break;
> > +       case BLK_CTL_CLK_SHARED_GATE:
> > +               clk_hw = imx_dev_clk_hw_gate_shared(dev, hw->name,
> > +                                                   hw->parents,
> > +                                                   base + hw->offset,
> > +                                                   hw->shift,
> > +                                                   hw->shared_count);
> > +               break;
> > +       case BLK_CTL_CLK_PLL14XX:
> > +               clk_hw = imx_dev_clk_hw_pll14xx(dev, hw->name, hw->parents,
> > +                                               base + hw->offset, hw->pll_tbl);
> > +               break;
> > +       };
> > +
> > +       return clk_hw;
> > +}
> > +
> > +static int imx_blk_ctl_register_clock_controller(struct device *dev)
> > +{
> > +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> > +       struct clk_hw_onecell_data *clk_hw_data;
> > +       struct clk_hw **hws;
> > +       int i;
> > +
> > +       clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> > +                               dev_data->hws_num), GFP_KERNEL);
> > +       if (WARN_ON(!clk_hw_data))
> > +               return -ENOMEM;
> > +
> > +       clk_hw_data->num = dev_data->clocks_max;
> > +       hws = clk_hw_data->hws;
> > +
> > +       for (i = 0; i < dev_data->hws_num; i++) {
> > +               struct imx_blk_ctl_hw *hw = &dev_data->hws[i];
> > +
> > +               if (hw->type == BLK_CTL_RESET)
> > +                       continue;
> > +
> > +               hws[hw->id] = imx_blk_ctl_register_one_clock(dev, hw);
> > +       }
> > +
> > +       imx_check_clk_hws(hws, dev_data->clocks_max);
> > +
> > +       return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> > +                                       clk_hw_data);
> > +}
> > +
> > +static int imx_blk_ctl_init_runtime_pm_safekeeping(struct device *dev)
> > +{
> > +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> > +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> > +       struct imx_pm_safekeep_info *pm_info = &drvdata->pm_info;
> > +       u32 regs_num = dev_data->pm_runtime_saved_regs_num;
> > +       const u32 *regs_offsets = dev_data->pm_runtime_saved_regs;
> > +
> > +       if (!dev_data->pm_runtime_saved_regs_num)
> > +               return 0;
> > +
> > +       pm_info->regs_values = devm_kzalloc(dev,
> > +                                           sizeof(u32) * regs_num,
> > +                                           GFP_KERNEL);
> > +       if (WARN_ON(IS_ERR(pm_info->regs_values)))
> > +               return PTR_ERR(pm_info->regs_values);
> > +
> > +       pm_info->regs_offsets = kmemdup(regs_offsets,
> > +                                       regs_num * sizeof(u32), GFP_KERNEL);
> > +       if (WARN_ON(IS_ERR(pm_info->regs_offsets)))
> > +               return PTR_ERR(pm_info->regs_offsets);
> > +
> > +       pm_info->regs_num = regs_num;
> > +
> > +       return 0;
> > +}
> > +
> > +int imx_blk_ctl_register(struct platform_device *pdev)
> > +{
> > +       struct imx_blk_ctl_drvdata *drvdata;
> > +       struct device *dev = &pdev->dev;
> > +       int ret;
> > +
> > +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > +       if (WARN_ON(!drvdata))
> > +               return -ENOMEM;
> > +
> > +       drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (WARN_ON(IS_ERR(drvdata->base)))
> > +               return PTR_ERR(drvdata->base);
> > +
> > +       dev_set_drvdata(dev, drvdata);
> > +
> > +       ret = imx_blk_ctl_init_runtime_pm_safekeeping(dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pm_runtime_get_noresume(dev);
> > +       pm_runtime_set_active(dev);
> > +       pm_runtime_enable(dev);
> > +
> > +       ret = imx_blk_ctl_register_clock_controller(dev);
> > +       if (ret) {
> > +               pm_runtime_put(dev);
> > +               return ret;
> > +       }
> > +
> > +       ret = imx_blk_ctl_register_reset_controller(dev);
> > +
> > +       pm_runtime_put(dev);
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
> > diff --git a/drivers/clk/imx/clk-blk-ctl.h b/drivers/clk/imx/clk-blk-ctl.h
> > new file mode 100644
> > index 00000000..3f14a47
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-blk-ctl.h
> > @@ -0,0 +1,80 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __MACH_IMX_CLK_BLK_CTL_H
> > +#define __MACH_IMX_CLK_BLK_CTL_H
> > +
> > +enum imx_blk_ctl_hw_type {
> > +       BLK_CTL_CLK_MUX,
> > +       BLK_CTL_CLK_GATE,
> > +       BLK_CTL_CLK_SHARED_GATE,
> > +       BLK_CTL_CLK_PLL14XX,
> > +       BLK_CTL_RESET,
> > +};
> > +
> > +struct imx_blk_ctl_hw {
> > +       int type;
> > +       char *name;
> > +       u32 offset;
> > +       u32 shift;
> > +       u32 mask;
> > +       u32 width;
> > +       u32 flags;
> > +       u32 id;
> > +       const void *parents;
> > +       u32 parents_count;
> > +       int *shared_count;
> > +       const struct imx_pll14xx_clk *pll_tbl;
> > +};
> > +
> > +struct imx_blk_ctl_dev_data {
> > +       struct imx_blk_ctl_hw *hws;
> > +       u32 hws_num;
> > +
> > +       u32 clocks_max;
> > +       u32 resets_max;
> > +
> > +       u32 pm_runtime_saved_regs_num;
> > +       u32 pm_runtime_saved_regs[];
> > +};
> > +
> > +#define IMX_BLK_CTL(_type, _name, _id, _offset, _shift, _width, _mask, _parents, _parents_count, _flags, sh_count, _pll_tbl) \
> > +       {                                               \
> > +               .type = _type,                          \
> > +               .name = _name,                          \
> > +               .id = _id,                              \
> > +               .offset = _offset,                      \
> > +               .shift = _shift,                        \
> > +               .width = _width,                        \
> > +               .mask = _mask,                          \
> > +               .parents = _parents,                    \
> > +               .parents_count = _parents_count,        \
> > +               .flags = _flags,                        \
> > +               .shared_count = sh_count,               \
> > +               .pll_tbl = _pll_tbl,                    \
> > +       }
> > +
> > +#define IMX_BLK_CTL_CLK_MUX(_name, _id, _offset, _shift, _width, _parents) \
> > +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), 0, NULL, NULL)
> > +
> > +#define IMX_BLK_CTL_CLK_MUX_FLAGS(_name, _id, _offset, _shift, _width, _parents, _flags) \
> > +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), _flags, NULL, NULL)
> > +
> > +#define IMX_BLK_CTL_CLK_GATE(_name, _id, _offset, _shift, _parents) \
> > +       IMX_BLK_CTL(BLK_CTL_CLK_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, NULL, NULL)
> > +
> > +#define IMX_BLK_CTL_CLK_SHARED_GATE(_name, _id, _offset, _shift, _parents, sh_count) \
> > +       IMX_BLK_CTL(BLK_CTL_CLK_SHARED_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, sh_count, NULL)
> > +
> > +#define IMX_BLK_CTL_CLK_PLL14XX(_name, _id, _offset, _parents, _pll_tbl) \
> > +       IMX_BLK_CTL(BLK_CTL_CLK_PLL14XX, _name, _id, _offset, 0, 0, 0, _parents, 1, 0, NULL, _pll_tbl)
> > +
> > +#define IMX_BLK_CTL_RESET(_id, _offset, _shift) \
> > +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, 1, NULL, 0, 0, NULL, NULL)
> > +
> > +#define IMX_BLK_CTL_RESET_MASK(_id, _offset, _shift, mask) \
> > +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, mask, NULL, 0, 0, NULL, NULL)
> > +
> > +extern const struct dev_pm_ops imx_blk_ctl_pm_ops;
> > +
> > +int imx_blk_ctl_register(struct platform_device *pdev);
> > +
> > +#endif
> > --
> > 2.7.4
> >

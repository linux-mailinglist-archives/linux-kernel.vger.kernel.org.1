Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0782AEDCE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKKJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgKKJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:31:06 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C471C0613D1;
        Wed, 11 Nov 2020 01:31:06 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id r17so1297995ljg.5;
        Wed, 11 Nov 2020 01:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DUkNb+DftkRK1N2II0Jh8IwjfDCAOXjEdUfQYAFCME=;
        b=XfcWcDzEerkIIZfs8RSD5U5vI9Wn5OHJtyO8fSmwSdZVhpeG97lTh7mWimStjiARSF
         PtnhNH9P8MYslUzdgnixjrZSs0WI0zZqmili6EByrH6F5ve2cdNt1svWgmd8kRlR3tM/
         K8Hdze+jyAZfxKqOR71gxJPKFcDs92wnHhmZCOLrlNOoFq4FF4gJBna2IwyD4h0cunte
         CiP9JaUSXfuKQmik/ngkTDwlVJLhSI9R07LLk8dzI2G5VATlhZjk6MFK3RVM2E9463cc
         0X8ycuouaQ3SJISjjBosvgFl1L2rLjc4Cs5z69udHIqbyhLVlyzhJxBzDD5T8Ols+fo/
         La4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DUkNb+DftkRK1N2II0Jh8IwjfDCAOXjEdUfQYAFCME=;
        b=HxKU9ld8V38S1wN9umgghm4V1Vs0OxtaLQjonKJiyQXQng7Y76A8cgy+Td4+P2tQZP
         zR9R4urLcek3ksaoKLtbNyOrLNbA3xjkc0zQfny616gDfjkZB41Pj4yDf91R0Zq4nhvt
         vmOQEvmNu65PXe5eajtov3LFBojmfkeh1qfEfHpmk3a0qh7m5tpEtjsW3KM4/rHqaenB
         WNfVkhv7g6AakBE7tGPZY9BrYUAFL5UquUjsgULBNjR31xIO+rIxpHeaJkuAPg3UgV3Q
         WSfBPW5zDpfWcsW69yLhsEB1F8qfTGW90dXSD7XiWcUxs9B7EKqCO2cizRbzMzqWFXLG
         vHrg==
X-Gm-Message-State: AOAM530hRDWyFP/Dj4w/0lqg7juNVFAAp88aQ4KfAPEG3GoQ1F6pHHU1
        5PeM2z/uUlNSIqI0JyUESuSL7rDuLm+k0qu9Tek=
X-Google-Smtp-Source: ABdhPJz2YQQUPhMwNGg2SxCrpZ+2SfLETyH9+eNN2yzwgtfacxEoN0+dTEwG1jBYY+c03E/0+gD4De1HrvC4BOGdMxk=
X-Received: by 2002:a2e:b0f8:: with SMTP id h24mr10462391ljl.2.1605087064794;
 Wed, 11 Nov 2020 01:31:04 -0800 (PST)
MIME-Version: 1.0
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com> <1604402306-5348-11-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1604402306-5348-11-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 11 Nov 2020 17:13:25 +0800
Message-ID: <CAA+hA=TfyW6Ya9adcQFd1=-sJyoCgMyaENmGumtV1ZYar1Ud2g@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
To:     Abel Vesa <abel.vesa@nxp.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 7:22 PM Abel Vesa <abel.vesa@nxp.com> wrote:
...
> +static int imx_blk_ctl_reset_set(struct reset_controller_dev *rcdev,
> +                                 unsigned long id, bool assert)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata = container_of(rcdev,
> +                       struct imx_blk_ctl_drvdata, rcdev);
> +       unsigned int offset = drvdata->rst_hws[id].offset;
> +       unsigned int shift = drvdata->rst_hws[id].shift;
> +       unsigned int mask = drvdata->rst_hws[id].mask;
> +       void __iomem *reg_addr = drvdata->base + offset;
> +       unsigned long flags;
> +       u32 reg;
> +
> +       if (!assert && !test_bit(1, &drvdata->rst_hws[id].asserted))
> +               return -ENODEV;

What if consumers call deassert first in probe which seems common in kernel?
It seems will fail.
e.g.
probe() {
    reset_control_get()
    reset_control_deassert()
}

Regards
Aisheng

> +
> +       if (assert && !test_and_set_bit(1, &drvdata->rst_hws[id].asserted))
> +               pm_runtime_get_sync(rcdev->dev)
> +
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +
> +       reg = readl(reg_addr);
> +       if (assert)
> +               writel(reg & ~(mask << shift), reg_addr);
> +       else
> +               writel(reg | (mask << shift), reg_addr);
> +
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +       if (!assert && test_and_clear_bit(1, &drvdata->rst_hws[id].asserted))
> +               pm_runtime_put(rcdev->dev)
> +
> +       return 0;
> +}
> +
> +static int imx_blk_ctl_reset_assert(struct reset_controller_dev *rcdev,
> +                                          unsigned long id)
> +{
> +       return imx_blk_ctl_reset_set(rcdev, id, true);
> +}
> +
> +static int imx_blk_ctl_reset_deassert(struct reset_controller_dev *rcdev,
> +                                            unsigned long id)
> +{
> +       return imx_blk_ctl_reset_set(rcdev, id, false);
> +}
> +
> +static const struct reset_control_ops imx_blk_ctl_reset_ops = {
> +       .assert         = imx_blk_ctl_reset_assert,
> +       .deassert       = imx_blk_ctl_reset_deassert,
> +};
> +
> +static int imx_blk_ctl_register_reset_controller(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> +       int max = dev_data->resets_max;
> +       struct imx_reset_hw *hws;
> +       int i;
> +
> +       spin_lock_init(&drvdata->lock);
> +
> +       drvdata->rcdev.owner     = THIS_MODULE;
> +       drvdata->rcdev.nr_resets = max;
> +       drvdata->rcdev.ops       = &imx_blk_ctl_reset_ops;
> +       drvdata->rcdev.of_node   = dev->of_node;
> +       drvdata->rcdev.dev       = dev;
> +
> +       drvdata->rst_hws = devm_kcalloc(dev, max, sizeof(struct imx_reset_hw),
> +                                       GFP_KERNEL);
> +       hws = drvdata->rst_hws;
> +
> +       for (i = 0; i < dev_data->hws_num; i++) {
> +               struct imx_blk_ctl_hw *hw = &dev_data->hws[i];
> +
> +               if (hw->type != BLK_CTL_RESET)
> +                       continue;
> +
> +               hws[hw->id].offset = hw->offset;
> +               hws[hw->id].shift = hw->shift;
> +               hws[hw->id].mask = hw->mask;
> +       }
> +
> +       return devm_reset_controller_register(dev, &drvdata->rcdev);
> +}
> +static struct clk_hw *imx_blk_ctl_register_one_clock(struct device *dev,
> +                                               struct imx_blk_ctl_hw *hw)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> +       void __iomem *base = drvdata->base;
> +       struct clk_hw *clk_hw = NULL;
> +
> +       switch (hw->type) {
> +       case BLK_CTL_CLK_MUX:
> +               clk_hw = imx_dev_clk_hw_mux_flags(dev, hw->name,
> +                                                 base + hw->offset,
> +                                                 hw->shift, hw->width,
> +                                                 hw->parents,
> +                                                 hw->parents_count,
> +                                                 hw->flags);
> +               break;
> +       case BLK_CTL_CLK_GATE:
> +               clk_hw = imx_dev_clk_hw_gate(dev, hw->name, hw->parents,
> +                                            base + hw->offset, hw->shift);
> +               break;
> +       case BLK_CTL_CLK_SHARED_GATE:
> +               clk_hw = imx_dev_clk_hw_gate_shared(dev, hw->name,
> +                                                   hw->parents,
> +                                                   base + hw->offset,
> +                                                   hw->shift,
> +                                                   hw->shared_count);
> +               break;
> +       case BLK_CTL_CLK_PLL14XX:
> +               clk_hw = imx_dev_clk_hw_pll14xx(dev, hw->name, hw->parents,
> +                                               base + hw->offset, hw->pll_tbl);
> +               break;
> +       };
> +
> +       return clk_hw;
> +}
> +
> +static int imx_blk_ctl_register_clock_controller(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       struct clk_hw **hws;
> +       int i;
> +
> +       clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> +                               dev_data->hws_num), GFP_KERNEL);
> +       if (WARN_ON(!clk_hw_data))
> +               return -ENOMEM;
> +
> +       clk_hw_data->num = dev_data->clocks_max;
> +       hws = clk_hw_data->hws;
> +
> +       for (i = 0; i < dev_data->hws_num; i++) {
> +               struct imx_blk_ctl_hw *hw = &dev_data->hws[i];
> +
> +               if (hw->type == BLK_CTL_RESET)
> +                       continue;
> +
> +               hws[hw->id] = imx_blk_ctl_register_one_clock(dev, hw);
> +       }
> +
> +       imx_check_clk_hws(hws, dev_data->clocks_max);
> +
> +       return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +                                       clk_hw_data);
> +}
> +
> +static int imx_blk_ctl_init_runtime_pm_safekeeping(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data = of_device_get_match_data(dev);
> +       struct imx_blk_ctl_drvdata *drvdata = dev_get_drvdata(dev);
> +       struct imx_pm_safekeep_info *pm_info = &drvdata->pm_info;
> +       u32 regs_num = dev_data->pm_runtime_saved_regs_num;
> +       const u32 *regs_offsets = dev_data->pm_runtime_saved_regs;
> +
> +       if (!dev_data->pm_runtime_saved_regs_num)
> +               return 0;
> +
> +       pm_info->regs_values = devm_kzalloc(dev,
> +                                           sizeof(u32) * regs_num,
> +                                           GFP_KERNEL);
> +       if (WARN_ON(IS_ERR(pm_info->regs_values)))
> +               return PTR_ERR(pm_info->regs_values);
> +
> +       pm_info->regs_offsets = kmemdup(regs_offsets,
> +                                       regs_num * sizeof(u32), GFP_KERNEL);
> +       if (WARN_ON(IS_ERR(pm_info->regs_offsets)))
> +               return PTR_ERR(pm_info->regs_offsets);
> +
> +       pm_info->regs_num = regs_num;
> +
> +       return 0;
> +}
> +
> +int imx_blk_ctl_register(struct platform_device *pdev)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (WARN_ON(!drvdata))
> +               return -ENOMEM;
> +
> +       drvdata->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (WARN_ON(IS_ERR(drvdata->base)))
> +               return PTR_ERR(drvdata->base);
> +
> +       dev_set_drvdata(dev, drvdata);
> +
> +       ret = imx_blk_ctl_init_runtime_pm_safekeeping(dev);
> +       if (ret)
> +               return ret;
> +
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       ret = imx_blk_ctl_register_clock_controller(dev);
> +       if (ret) {
> +               pm_runtime_put(dev);
> +               return ret;
> +       }
> +
> +       ret = imx_blk_ctl_register_reset_controller(dev);
> +
> +       pm_runtime_put(dev);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_register);
> diff --git a/drivers/clk/imx/clk-blk-ctl.h b/drivers/clk/imx/clk-blk-ctl.h
> new file mode 100644
> index 00000000..3f14a47
> --- /dev/null
> +++ b/drivers/clk/imx/clk-blk-ctl.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __MACH_IMX_CLK_BLK_CTL_H
> +#define __MACH_IMX_CLK_BLK_CTL_H
> +
> +enum imx_blk_ctl_hw_type {
> +       BLK_CTL_CLK_MUX,
> +       BLK_CTL_CLK_GATE,
> +       BLK_CTL_CLK_SHARED_GATE,
> +       BLK_CTL_CLK_PLL14XX,
> +       BLK_CTL_RESET,
> +};
> +
> +struct imx_blk_ctl_hw {
> +       int type;
> +       char *name;
> +       u32 offset;
> +       u32 shift;
> +       u32 mask;
> +       u32 width;
> +       u32 flags;
> +       u32 id;
> +       const void *parents;
> +       u32 parents_count;
> +       int *shared_count;
> +       const struct imx_pll14xx_clk *pll_tbl;
> +};
> +
> +struct imx_blk_ctl_dev_data {
> +       struct imx_blk_ctl_hw *hws;
> +       u32 hws_num;
> +
> +       u32 clocks_max;
> +       u32 resets_max;
> +
> +       u32 pm_runtime_saved_regs_num;
> +       u32 pm_runtime_saved_regs[];
> +};
> +
> +#define IMX_BLK_CTL(_type, _name, _id, _offset, _shift, _width, _mask, _parents, _parents_count, _flags, sh_count, _pll_tbl) \
> +       {                                               \
> +               .type = _type,                          \
> +               .name = _name,                          \
> +               .id = _id,                              \
> +               .offset = _offset,                      \
> +               .shift = _shift,                        \
> +               .width = _width,                        \
> +               .mask = _mask,                          \
> +               .parents = _parents,                    \
> +               .parents_count = _parents_count,        \
> +               .flags = _flags,                        \
> +               .shared_count = sh_count,               \
> +               .pll_tbl = _pll_tbl,                    \
> +       }
> +
> +#define IMX_BLK_CTL_CLK_MUX(_name, _id, _offset, _shift, _width, _parents) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_MUX_FLAGS(_name, _id, _offset, _shift, _width, _parents, _flags) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width, 0, _parents, ARRAY_SIZE(_parents), _flags, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_GATE(_name, _id, _offset, _shift, _parents) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_SHARED_GATE(_name, _id, _offset, _shift, _parents, sh_count) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_SHARED_GATE, _name, _id, _offset, _shift, 1, 0, _parents, 1, 0, sh_count, NULL)
> +
> +#define IMX_BLK_CTL_CLK_PLL14XX(_name, _id, _offset, _parents, _pll_tbl) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_PLL14XX, _name, _id, _offset, 0, 0, 0, _parents, 1, 0, NULL, _pll_tbl)
> +
> +#define IMX_BLK_CTL_RESET(_id, _offset, _shift) \
> +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, 1, NULL, 0, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_RESET_MASK(_id, _offset, _shift, mask) \
> +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, mask, NULL, 0, 0, NULL, NULL)
> +
> +extern const struct dev_pm_ops imx_blk_ctl_pm_ops;
> +
> +int imx_blk_ctl_register(struct platform_device *pdev);
> +
> +#endif
> --
> 2.7.4
>

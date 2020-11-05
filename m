Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4CF2A7431
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgKEA77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgKEA77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:59:59 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC2422072E;
        Thu,  5 Nov 2020 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604537997;
        bh=QcbyPWSRQulyeWOH3d6eP/j4FKXehRssL3e64gDdsZA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=zxBt9tj9A2tvOxGhzZPWcy7rDagAZM01fC+6CoM7xH7miVFKWPIj3v3dHe9Rnoued
         wllq5VGdDQW8VQ8o91TKMw5uBrrtidvIb2nCK4EDMDWh6Ff7eULZWDITARNOQPnQAP
         YJcIvp5XJnLv5gUUOAClyU8NH4B/gIdHBw0mvJtM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1604402306-5348-11-git-send-email-abel.vesa@nxp.com>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com> <1604402306-5348-11-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH v5 10/14] clk: imx: Add generic blk-ctl driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Adam Ford <aford173@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 04 Nov 2020 16:59:55 -0800
Message-ID: <160453799538.3965362.16773121624590810076@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-11-03 03:18:22)
> diff --git a/drivers/clk/imx/clk-blk-ctl.c b/drivers/clk/imx/clk-blk-ctl.c
> new file mode 100644
> index 00000000..9ac0ed0
> --- /dev/null
> +++ b/drivers/clk/imx/clk-blk-ctl.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 NXP.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/reset-controller.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +#include "clk-blk-ctl.h"
> +
> +struct imx_reset_hw {
> +       u32 offset;
> +       u32 shift;
> +       u32 mask;
> +       unsigned long asserted;
> +};
> +
> +struct imx_pm_safekeep_info {
> +       uint32_t *regs_values;
> +       uint32_t *regs_offsets;

Please use u32, it's shorter and kernel style.

> +       uint32_t regs_num;
> +};
> +
> +struct imx_blk_ctl_drvdata {
> +       void __iomem *base;
> +       struct reset_controller_dev rcdev;
> +       struct imx_reset_hw *rst_hws;
> +       struct imx_pm_safekeep_info pm_info;
> +
> +       spinlock_t lock;
> +};
> +
> +static void __maybe_unused imx_blk_ctl_read_write(struct device *dev,
> +                                                       bool write)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata =3D dev_get_drvdata(dev);
> +       struct imx_pm_safekeep_info *pm_info =3D &drvdata->pm_info;
> +       void __iomem *base =3D drvdata->base;
> +       int i;
> +
> +       if (!pm_info->regs_num)
> +               return;
> +
> +       for (i =3D 0; i < pm_info->regs_num; i++) {
> +               u32 offset =3D pm_info->regs_offsets[i];
> +
> +               if (write)
> +                       writel(pm_info->regs_values[i], base + offset);
> +               else
> +                       pm_info->regs_values[i] =3D readl(base + offset);
> +       }
> +
> +}
> +
> +static int __maybe_unused imx_blk_ctl_runtime_suspend(struct device *dev)
> +{
> +       imx_blk_ctl_read_write(dev, false);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused imx_blk_ctl_runtime_resume(struct device *dev)
> +{
> +       imx_blk_ctl_read_write(dev, true);
> +
> +       return 0;
> +}
> +
> +const struct dev_pm_ops imx_blk_ctl_pm_ops =3D {
> +       SET_RUNTIME_PM_OPS(imx_blk_ctl_runtime_suspend,
> +                          imx_blk_ctl_runtime_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                          pm_runtime_force_resume)
> +};
> +EXPORT_SYMBOL_GPL(imx_blk_ctl_pm_ops);
> +
> +static int imx_blk_ctl_reset_set(struct reset_controller_dev *rcdev,
> +                                 unsigned long id, bool assert)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata =3D container_of(rcdev,
> +                       struct imx_blk_ctl_drvdata, rcdev);
> +       unsigned int offset =3D drvdata->rst_hws[id].offset;
> +       unsigned int shift =3D drvdata->rst_hws[id].shift;
> +       unsigned int mask =3D drvdata->rst_hws[id].mask;
> +       void __iomem *reg_addr =3D drvdata->base + offset;
> +       unsigned long flags;
> +       u32 reg;
> +
> +       if (!assert && !test_bit(1, &drvdata->rst_hws[id].asserted))
> +               return -ENODEV;
> +
> +       if (assert && !test_and_set_bit(1, &drvdata->rst_hws[id].asserted=
))

We are testing the same bit atomically, twice. At a quick glance this
code looks broken. But then looking closer it's being multiplexed. Can
we move these assert/!assert checks to the caller? It will make it
easier to reason about.

Is the atomic-ness of this code important? If not, it should use
__test_bit() and __test_and_set_bit() because locking is being handled
somewhere higher up. Furthermore, why are we using a per-reset bitmap to
set one bit? Either combine them into one bitmap or have a simple bool
please.

> +               pm_runtime_get_sync(rcdev->dev);
> +
> +       spin_lock_irqsave(&drvdata->lock, flags);
> +
> +       reg =3D readl(reg_addr);
> +       if (assert)
> +               writel(reg & ~(mask << shift), reg_addr);
> +       else
> +               writel(reg | (mask << shift), reg_addr);
> +
> +       spin_unlock_irqrestore(&drvdata->lock, flags);
> +
> +       if (!assert && test_and_clear_bit(1, &drvdata->rst_hws[id].assert=
ed))
> +               pm_runtime_put(rcdev->dev);
> +

Same comment here.

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
> +static const struct reset_control_ops imx_blk_ctl_reset_ops =3D {
> +       .assert         =3D imx_blk_ctl_reset_assert,
> +       .deassert       =3D imx_blk_ctl_reset_deassert,
> +};
> +
> +static int imx_blk_ctl_register_reset_controller(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data =3D of_device_get_mat=
ch_data(dev);
> +       struct imx_blk_ctl_drvdata *drvdata =3D dev_get_drvdata(dev);
> +       int max =3D dev_data->resets_max;
> +       struct imx_reset_hw *hws;
> +       int i;
> +
> +       spin_lock_init(&drvdata->lock);
> +
> +       drvdata->rcdev.owner     =3D THIS_MODULE;
> +       drvdata->rcdev.nr_resets =3D max;
> +       drvdata->rcdev.ops       =3D &imx_blk_ctl_reset_ops;
> +       drvdata->rcdev.of_node   =3D dev->of_node;
> +       drvdata->rcdev.dev       =3D dev;
> +
> +       drvdata->rst_hws =3D devm_kcalloc(dev, max, sizeof(struct imx_res=
et_hw),
> +                                       GFP_KERNEL);
> +       hws =3D drvdata->rst_hws;
> +
> +       for (i =3D 0; i < dev_data->hws_num; i++) {
> +               struct imx_blk_ctl_hw *hw =3D &dev_data->hws[i];
> +
> +               if (hw->type !=3D BLK_CTL_RESET)
> +                       continue;
> +
> +               hws[hw->id].offset =3D hw->offset;
> +               hws[hw->id].shift =3D hw->shift;
> +               hws[hw->id].mask =3D hw->mask;
> +       }
> +
> +       return devm_reset_controller_register(dev, &drvdata->rcdev);
> +}

Nitpick: Add a newline here please

> +static struct clk_hw *imx_blk_ctl_register_one_clock(struct device *dev,
> +                                               struct imx_blk_ctl_hw *hw)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata =3D dev_get_drvdata(dev);
> +       void __iomem *base =3D drvdata->base;
> +       struct clk_hw *clk_hw =3D NULL;

Is this necessary? Please add a default to the case if so and drop this
assignment. But if all hw->type are covered in the case statement then
this assignment can be dropped and nothing else. The compiler should
tell us we forgot to handle a case.

> +
> +       switch (hw->type) {
> +       case BLK_CTL_CLK_MUX:
> +               clk_hw =3D imx_dev_clk_hw_mux_flags(dev, hw->name,
> +                                                 base + hw->offset,
> +                                                 hw->shift, hw->width,
> +                                                 hw->parents,
> +                                                 hw->parents_count,
> +                                                 hw->flags);
> +               break;
> +       case BLK_CTL_CLK_GATE:
> +               clk_hw =3D imx_dev_clk_hw_gate(dev, hw->name, hw->parents,
> +                                            base + hw->offset, hw->shift=
);
> +               break;
> +       case BLK_CTL_CLK_SHARED_GATE:
> +               clk_hw =3D imx_dev_clk_hw_gate_shared(dev, hw->name,
> +                                                   hw->parents,
> +                                                   base + hw->offset,
> +                                                   hw->shift,
> +                                                   hw->shared_count);
> +               break;
> +       case BLK_CTL_CLK_PLL14XX:
> +               clk_hw =3D imx_dev_clk_hw_pll14xx(dev, hw->name, hw->pare=
nts,
> +                                               base + hw->offset, hw->pl=
l_tbl);
> +               break;
> +       };
> +
> +       return clk_hw;
> +}
> +
> +static int imx_blk_ctl_register_clock_controller(struct device *dev)
> +{
> +       const struct imx_blk_ctl_dev_data *dev_data =3D of_device_get_mat=
ch_data(dev);
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       struct clk_hw **hws;
> +       int i;
> +
> +       clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws,
> +                               dev_data->hws_num), GFP_KERNEL);
> +       if (WARN_ON(!clk_hw_data))

We can drop the WARN_ON() call, slab allocations already print a
stacktrace.

> +               return -ENOMEM;
> +
> +       clk_hw_data->num =3D dev_data->clocks_max;
> +       hws =3D clk_hw_data->hws;
> +
> +       for (i =3D 0; i < dev_data->hws_num; i++) {
> +               struct imx_blk_ctl_hw *hw =3D &dev_data->hws[i];
> +

Add a comment like /* Resets aren't a clk */

> +               if (hw->type =3D=3D BLK_CTL_RESET)
> +                       continue;
> +
> +               hws[hw->id] =3D imx_blk_ctl_register_one_clock(dev, hw);
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
> +       const struct imx_blk_ctl_dev_data *dev_data =3D of_device_get_mat=
ch_data(dev);
> +       struct imx_blk_ctl_drvdata *drvdata =3D dev_get_drvdata(dev);
> +       struct imx_pm_safekeep_info *pm_info =3D &drvdata->pm_info;
> +       u32 regs_num =3D dev_data->pm_runtime_saved_regs_num;
> +       const u32 *regs_offsets =3D dev_data->pm_runtime_saved_regs;
> +
> +       if (!dev_data->pm_runtime_saved_regs_num)
> +               return 0;
> +
> +       pm_info->regs_values =3D devm_kzalloc(dev,
> +                                           sizeof(u32) * regs_num,
> +                                           GFP_KERNEL);
> +       if (WARN_ON(IS_ERR(pm_info->regs_values)))

Please drop WARN_ON

> +               return PTR_ERR(pm_info->regs_values);
> +
> +       pm_info->regs_offsets =3D kmemdup(regs_offsets,
> +                                       regs_num * sizeof(u32), GFP_KERNE=
L);
> +       if (WARN_ON(IS_ERR(pm_info->regs_offsets)))

Please drop WARN_ON

> +               return PTR_ERR(pm_info->regs_offsets);
> +
> +       pm_info->regs_num =3D regs_num;
> +
> +       return 0;
> +}
> +
> +int imx_blk_ctl_register(struct platform_device *pdev)
> +{
> +       struct imx_blk_ctl_drvdata *drvdata;
> +       struct device *dev =3D &pdev->dev;
> +       int ret;
> +
> +       drvdata =3D devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (WARN_ON(!drvdata))

Please drop WARN_ON

> +               return -ENOMEM;
> +
> +       drvdata->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (WARN_ON(IS_ERR(drvdata->base)))

Please drop WARN_ON

> +               return PTR_ERR(drvdata->base);
> +
> +       dev_set_drvdata(dev, drvdata);
> +
> +       ret =3D imx_blk_ctl_init_runtime_pm_safekeeping(dev);
> +       if (ret)
> +               return ret;
> +
> +       pm_runtime_get_noresume(dev);
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +
> +       ret =3D imx_blk_ctl_register_clock_controller(dev);
> +       if (ret) {
> +               pm_runtime_put(dev);
> +               return ret;
> +       }
> +
> +       ret =3D imx_blk_ctl_register_reset_controller(dev);
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

Please forward declare pointer types.

> +};
> +
> +struct imx_blk_ctl_dev_data {
> +       struct imx_blk_ctl_hw *hws;

Please forward declare pointer types.

> +       u32 hws_num;
> +
> +       u32 clocks_max;
> +       u32 resets_max;
> +
> +       u32 pm_runtime_saved_regs_num;
> +       u32 pm_runtime_saved_regs[];
> +};
> +
> +#define IMX_BLK_CTL(_type, _name, _id, _offset, _shift, _width, _mask, _=
parents, _parents_count, _flags, sh_count, _pll_tbl) \
> +       {                                               \
> +               .type =3D _type,                          \
> +               .name =3D _name,                          \
> +               .id =3D _id,                              \
> +               .offset =3D _offset,                      \
> +               .shift =3D _shift,                        \
> +               .width =3D _width,                        \
> +               .mask =3D _mask,                          \
> +               .parents =3D _parents,                    \
> +               .parents_count =3D _parents_count,        \
> +               .flags =3D _flags,                        \
> +               .shared_count =3D sh_count,               \
> +               .pll_tbl =3D _pll_tbl,                    \
> +       }
> +
> +#define IMX_BLK_CTL_CLK_MUX(_name, _id, _offset, _shift, _width, _parent=
s) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width,=
 0, _parents, ARRAY_SIZE(_parents), 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_MUX_FLAGS(_name, _id, _offset, _shift, _width, _=
parents, _flags) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_MUX, _name, _id, _offset, _shift, _width,=
 0, _parents, ARRAY_SIZE(_parents), _flags, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_GATE(_name, _id, _offset, _shift, _parents) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_GATE, _name, _id, _offset, _shift, 1, 0, =
_parents, 1, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_CLK_SHARED_GATE(_name, _id, _offset, _shift, _parent=
s, sh_count) \
> +       IMX_BLK_CTL(BLK_CTL_CLK_SHARED_GATE, _name, _id, _offset, _shift,=
 1, 0, _parents, 1, 0, sh_count, NULL)
> +
> +#define IMX_BLK_CTL_CLK_PLL14XX(_name, _id, _offset, _parents, _pll_tbl)=
 \
> +       IMX_BLK_CTL(BLK_CTL_CLK_PLL14XX, _name, _id, _offset, 0, 0, 0, _p=
arents, 1, 0, NULL, _pll_tbl)
> +
> +#define IMX_BLK_CTL_RESET(_id, _offset, _shift) \
> +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, 1, NULL=
, 0, 0, NULL, NULL)
> +
> +#define IMX_BLK_CTL_RESET_MASK(_id, _offset, _shift, mask) \
> +       IMX_BLK_CTL(BLK_CTL_RESET, NULL, _id, _offset, _shift, 0, mask, N=
ULL, 0, 0, NULL, NULL)
> +
> +extern const struct dev_pm_ops imx_blk_ctl_pm_ops;
> +
> +int imx_blk_ctl_register(struct platform_device *pdev);

Please forward declare pointer types.

> +
> +#endif
> --=20
> 2.7.4
>

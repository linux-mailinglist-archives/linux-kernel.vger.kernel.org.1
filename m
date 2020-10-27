Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B229A1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410188AbgJ0A4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:56:13 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44719 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406397AbgJ0A4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:56:11 -0400
Received: by mail-ua1-f66.google.com with SMTP id k12so3465076uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 17:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WoKB/srioGYZFrOiR/vTQ76HLh1qjsZ1vGD70vagiic=;
        b=OZjpNlCNvELIjQY4DNsTOIu2sgzjGh9VyL58ZCFiagbzr2O3wS74uaSJy2KHoLfiGi
         +JkiCp55zrzoOuehMD0acHrHLGV1HsMfkWQR3i124GMhHpDk3R/izjb9xiQjgoBtohFW
         2vRj6F6aBFQSN5VtlnhYUxL9VByVasdZ0A2fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WoKB/srioGYZFrOiR/vTQ76HLh1qjsZ1vGD70vagiic=;
        b=E5kyAnypxsQOv2oeAJdowIyG5BioiSDhej1NRCHlCvr+7ZPkhxysRvCmn+BppseLPO
         aHP5+Y1qGVFM8QOl+6Msw9u5G/7R6fE9idHhDzpt3SnWrLXPI03o4tHKnjtIwXBr1jUE
         BdAGKkOBM4KScZyefLMVgXsDiOk6Lgj71E+aNKuYwhtbWMDGFYcbxHaaQQzSx1mQR3pf
         /UxwPtKRLgsKfCyizIrAdUFCX+blLVuDp/w2WD87JHb+r7NFaAY8hdR/hJFeqx0tYlbu
         1m78Tkvht12mND8uClzU81qqOvcWz8447jmHdhhot8lbGluRYWjT513nmyttmn2xB9Am
         5F5A==
X-Gm-Message-State: AOAM53075DILg3ZgdE8YzlYzLAAZfkyWzWfK7Rw8Mqnp1phUgNpTXtTR
        CUK/YfmiKhzLrK/jgKKhnOgHDadN/7W4BzBcoG9TGMZZx7nj7w==
X-Google-Smtp-Source: ABdhPJzxqzz748TSYWPG8lFbUdNb/5Hp9mlU4favU6DLNa8AkVglYedp6m6EWcf5g6e2WuW90seFMJRDE/i2umyGf3A=
X-Received: by 2002:ab0:235:: with SMTP id 50mr20907288uas.48.1603760169766;
 Mon, 26 Oct 2020 17:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201026175526.2915399-1-enric.balletbo@collabora.com> <20201026175526.2915399-3-enric.balletbo@collabora.com>
In-Reply-To: <20201026175526.2915399-3-enric.balletbo@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Oct 2020 08:55:58 +0800
Message-ID: <CANMq1KCe-QtQWXpmwFiCt4vcy0MG==L-C9cSU=o4W4OC5tyWgA@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] soc: mediatek: Add MediaTek SCPSYS power domains
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:55 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The System Control Processor System (SCPSYS) has several power management
> related tasks in the system. This driver implements support to handle
> the different power domains supported in order to meet high performance
> and low power requirements.
>
> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v3:
> - Return only a boolean for scpsys_domain_is_on()
> - Use regmap_update_bits API when possible.
> - Add some logic to make sure scpsys->domains[id] == NULL or != NULL
>   when needed.
> - Return the child node for scpsys_add_one_domain() call.
> - Remove unneded zeroing num_clks variable.
> - Move the soc specific data to separate include files.
>
> Changes in v2:
> - Get base address from parent syscon. We have now a scpsys syscon node
>   and a child for the SPM (System Power Manager).
> - Use regmap API to acces de base address.
>
>  drivers/soc/mediatek/Kconfig             |  13 +
>  drivers/soc/mediatek/Makefile            |   1 +
>  drivers/soc/mediatek/mt8173-pm-domains.h |  96 +++++
>  drivers/soc/mediatek/mtk-pm-domains.c    | 455 +++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-pm-domains.h    |  65 ++++
>  5 files changed, 630 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mt8173-pm-domains.h
>  create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
>  create mode 100644 drivers/soc/mediatek/mtk-pm-domains.h
[snip]
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> new file mode 100644
> index 000000000000..16503d6db6a8
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -0,0 +1,455 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020 Collabora Ltd.
> + */
> +#include <linux/clk.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_clk.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/mediatek/infracfg.h>
> +
> +#include "mt8173-pm-domains.h"
> +
> +#define MTK_POLL_DELAY_US              10
> +#define MTK_POLL_TIMEOUT               USEC_PER_SEC
> +
> +#define PWR_RST_B_BIT                  BIT(0)
> +#define PWR_ISO_BIT                    BIT(1)
> +#define PWR_ON_BIT                     BIT(2)
> +#define PWR_ON_2ND_BIT                 BIT(3)
> +#define PWR_CLK_DIS_BIT                        BIT(4)
> +
> +struct scpsys_domain {
> +       struct generic_pm_domain genpd;
> +       const struct scpsys_domain_data *data;
> +       struct scpsys *scpsys;
> +       int num_clks;
> +       struct clk_bulk_data *clks;
> +       struct regmap *infracfg;
> +};
> +
> +struct scpsys {
> +       struct device *dev;
> +       struct regmap *base;
> +       const struct scpsys_soc_data *soc_data;
> +       struct genpd_onecell_data pd_data;
> +       struct generic_pm_domain *domains[];
> +};
> +
> +#define to_scpsys_domain(gpd) container_of(gpd, struct scpsys_domain, genpd)
> +
> +static int scpsys_domain_is_on(struct scpsys_domain *pd)

static bool?

> +{
> +       struct scpsys *scpsys = pd->scpsys;
> +       u32 status, status2;
> +
> +       regmap_read(scpsys->base, scpsys->soc_data->pwr_sta_offs, &status);
> +       status &= pd->data->sta_mask;
> +
> +       regmap_read(scpsys->base, scpsys->soc_data->pwr_sta2nd_offs, &status2);
> +       status2 &= pd->data->sta_mask;
> +
> +       /* A domain is on when both status bits are set. */
> +       return status && status2;
> +}
> +
> +static int scpsys_sram_enable(struct scpsys_domain *pd)
> +{
> +       u32 pdn_ack = pd->data->sram_pdn_ack_bits;
> +       struct scpsys *scpsys = pd->scpsys;
> +       unsigned int tmp;
> +
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits, 0);
> +
> +       /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +       return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
> +                                       (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int scpsys_sram_disable(struct scpsys_domain *pd)
> +{
> +       u32 pdn_ack = pd->data->sram_pdn_ack_bits;
> +       struct scpsys *scpsys = pd->scpsys;
> +       unsigned int tmp;
> +
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits,
> +                          pd->data->sram_pdn_bits);
> +
> +       /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +       return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
> +                                       (tmp & pdn_ack) == pdn_ack, MTK_POLL_DELAY_US,
> +                                       MTK_POLL_TIMEOUT);
> +}
> +
> +static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
> +{
> +       const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
> +
> +       if (!bp_data->bus_prot_mask)
> +               return 0;
> +
> +       return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
> +                                              bp_data->bus_prot_reg_update);
> +}
> +
> +static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
> +{
> +       const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
> +
> +       if (!bp_data->bus_prot_mask)
> +               return 0;
> +
> +       return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
> +                                                bp_data->bus_prot_reg_update);
> +}
> +
> +static int scpsys_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
> +       struct scpsys *scpsys = pd->scpsys;
> +       unsigned int tmp;

bool tmp?

> +       int ret;
> +
> +       ret = clk_bulk_enable(pd->num_clks, pd->clks);
> +       if (ret)
> +               return ret;
> +
> +       /* subsys power on */
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT, PWR_ON_BIT);
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT, PWR_ON_2ND_BIT);
> +
> +       /* wait until PWR_ACK = 1 */
> +       ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp > 0, MTK_POLL_DELAY_US,

`tmp > 0` is a little weird now that scpsys_domain_is_on returns a
boolean. Just use `tmp`.

> +                                MTK_POLL_TIMEOUT);
> +       if (ret < 0)
> +               goto err_pwr_ack;
> +
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT, 0);
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT, 0);
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT, PWR_RST_B_BIT);
> +
> +       ret = scpsys_sram_enable(pd);
> +       if (ret < 0)
> +               goto err_pwr_ack;
> +
> +       ret = scpsys_bus_protect_disable(pd);
> +       if (ret < 0)
> +               goto err_pwr_ack;

Do we need to disable the SRAM in this error path?

> +
> +       return 0;
> +
> +err_pwr_ack:
> +       clk_bulk_disable(pd->num_clks, pd->clks);
> +       return ret;
> +}
> +
> +static int scpsys_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
> +       struct scpsys *scpsys = pd->scpsys;
> +       unsigned int tmp;
> +       int ret;
> +
> +       ret = scpsys_bus_protect_enable(pd);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = scpsys_sram_disable(pd);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* subsys power off */
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT, 0);
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT, PWR_ISO_BIT);
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT, PWR_CLK_DIS_BIT);
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT, 0);
> +       regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT, 0);
> +
> +       /* wait until PWR_ACK = 0 */
> +       ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp == 0, MTK_POLL_DELAY_US,

`!tmp` as condition.

> +                                MTK_POLL_TIMEOUT);
> +       if (ret < 0)
> +               return ret;
> +
> +       clk_bulk_disable(pd->num_clks, pd->clks);
> +
> +       return 0;
> +}
> +
> +static struct
> +generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
> +{
> +       const struct scpsys_domain_data *domain_data;
> +       struct scpsys_domain *pd;
> +       int i, ret;
> +       u32 id;
> +
> +       ret = of_property_read_u32(node, "reg", &id);
> +       if (ret) {
> +               dev_err(scpsys->dev, "%pOF: failed to retrieve domain id from reg: %d\n",
> +                       node, ret);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (id >= scpsys->soc_data->num_domains) {
> +               dev_err(scpsys->dev, "%pOF: invalid domain id %d\n", node, id);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       domain_data = &scpsys->soc_data->domains[id];

See my comment on v2. domain_data = scpsys->soc_data->domains[id]; is
probably what you want (unless I got it completely wrong...)

> +       if (!domain_data) {
> +               dev_err(scpsys->dev, "%pOF: undefined domain id %d\n", node, id);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       pd = devm_kzalloc(scpsys->dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pd->data = domain_data;
> +       pd->scpsys = scpsys;
> +
> +       pd->infracfg = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
> +       if (IS_ERR(pd->infracfg))
> +               pd->infracfg = NULL;
> +
> +       pd->num_clks = of_clk_get_parent_count(node);
> +       if (pd->num_clks > 0) {
> +               pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
> +               if (!pd->clks)
> +                       return ERR_PTR(-ENOMEM);
> +       }
[snip]

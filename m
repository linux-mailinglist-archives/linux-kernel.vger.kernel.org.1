Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5B2F0D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbhAKHIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:08:42 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A5C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:08:02 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id x15so1562256ilk.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 23:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40oBNgDhCJIenRjP2UaWivQWND3op8oUN0q1ogQZ4H0=;
        b=GLmVBWXOXItcO7uM97k3HHXx8aY/QJNuAxdyD+DgVkMhw0MRGaindsRrVN3/FJdy//
         qZXrTYMigJiX3NPZwFjeedPF1Gbp5OKyv6EVuHxzjrMnObBLv0IqIWp+HtIUHEnYN9Xg
         W4ZeiB5cJlyHBKHH016G28hh5zGwvMuVBgcCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40oBNgDhCJIenRjP2UaWivQWND3op8oUN0q1ogQZ4H0=;
        b=cyNoWUOPJ0EwU6Ky/Shw15VOzz56vQcWXFEzilrJAp6yCynUpmpONMvgE43FPR3Q25
         FXr/ZVOhFqy+OpKl3358kbFxy3Ng4P7luukbsgwxGtEJoPsRCVFcilQOVkvuE0FokK9I
         z1QVWoOca1cFYOI9HE5EiQi1EKhz4P4EOkw3JfjahRljvGGKrv17jFvgwSIG5QAEVtg8
         hTqUNF1RpsKK8r0BekvFdl5mitgSskd2mAAiHL4v6cfxl0b8rbuKiHk1cHfu+nunYhvE
         Jf2yFx65urY4kRXq8zTER6NAnuabvTPpH535AtFM2We+eQK/mekutXHOfFWVfAw/rBAy
         EynQ==
X-Gm-Message-State: AOAM532+cCvXF+WeX0hHBncryULllM11Xi7IU+Vb01+/+jkshN4R3vpN
        YG2wQG+DL69Qt7LexJlqQeFutPgfHdaDFqRqd3N3vg==
X-Google-Smtp-Source: ABdhPJwmQZMxtcu5IkBAJPG1CtXM1CtU5UgOcE7BPBorIBdTTjWxavfJvhfu6+LtlLaYGy/6ZGS59+iVqwsN8RIQ+mY=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr4398347ilv.308.1610348881564;
 Sun, 10 Jan 2021 23:08:01 -0800 (PST)
MIME-Version: 1.0
References: <1609757093-30618-1-git-send-email-weiyi.lu@mediatek.com> <1609757093-30618-2-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1609757093-30618-2-git-send-email-weiyi.lu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 11 Jan 2021 15:07:35 +0800
Message-ID: <CAJMQK-iUaRoYB8C6MmKA-TLD3gFj3XL4eX8MemeEWjh-9ZaTEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: mediatek: Add regulator control for MT8192 MFG
 power domain
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, lkml <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 10:44 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Add regulator control support and specific power domain name of
> MT8192 MFG power domain for regulator lookup.
> Also power domain name can fix the debugfs warning.
> (e.g. debugfs: Directory 'power-domain' with parent 'pm_genpd'
> already present!)
> However, not every domain with name need to get the regulator,
> if we just want to fix the debugfs warning log by adding names to
> power domains. Considering this case, lookup regulator by
> regulator_get_optional() instead of getting a dummy regulator from
> regulator_get() to operate.
>
Hi,

sorry I didn't notice this patch before. I sent out a similar patch
for this problem here:
https://patchwork.kernel.org/project/linux-mediatek/cover/20210107104915.2888408-1-hsinyi@chromium.org/

The difference is that
1) we store the requirement for quirks in caps instead of name.
2) regulators are under power-domain nodes instead of mfg devices in dts.

> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mt8192-pm-domains.h |  1 +
>  drivers/soc/mediatek/mtk-pm-domains.c    | 42 ++++++++++++++++++++++++++++++--
>  drivers/soc/mediatek/mtk-pm-domains.h    |  2 ++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
> index 0fdf6dc..7db0ad3 100644
> --- a/drivers/soc/mediatek/mt8192-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8192-pm-domains.h
> @@ -49,6 +49,7 @@
>                 .ctl_offs = 0x0308,
>                 .sram_pdn_bits = GENMASK(8, 8),
>                 .sram_pdn_ack_bits = GENMASK(12, 12),
> +               .name = "mfg",
>         },
>         [MT8192_POWER_DOMAIN_MFG1] = {
>                 .sta_mask = BIT(3),
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index fb70cb3..a160800 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/soc/mediatek/infracfg.h>
>
>  #include "mt8173-pm-domains.h"
> @@ -40,6 +41,7 @@ struct scpsys_domain {
>         struct clk_bulk_data *subsys_clks;
>         struct regmap *infracfg;
>         struct regmap *smi;
> +       struct regulator *supply;
>  };
>
>  struct scpsys {
> @@ -187,6 +189,22 @@ static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>         return _scpsys_bus_protect_disable(pd->data->bp_infracfg, pd->infracfg);
>  }
>
> +static int scpsys_regulator_enable(struct scpsys_domain *pd)
> +{
> +       if (!pd->supply)
> +               return 0;
> +
> +       return regulator_enable(pd->supply);
> +}
> +
> +static int scpsys_regulator_disable(struct scpsys_domain *pd)
> +{
> +       if (!pd->supply)
> +               return 0;
> +
> +       return regulator_disable(pd->supply);
> +}
> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>         struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
> @@ -194,9 +212,13 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         bool tmp;
>         int ret;
>
> +       ret = scpsys_regulator_enable(pd);
> +       if (ret < 0)
> +               return ret;
> +
>         ret = clk_bulk_enable(pd->num_clks, pd->clks);
>         if (ret)
> -               return ret;
> +               goto err_disable_regulator;
>
>         /* subsys power on */
>         regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
> @@ -232,6 +254,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>         clk_bulk_disable(pd->num_subsys_clks, pd->subsys_clks);
>  err_pwr_ack:
>         clk_bulk_disable(pd->num_clks, pd->clks);
> +err_disable_regulator:
> +       scpsys_regulator_disable(pd);
>         return ret;
>  }
>
> @@ -267,6 +291,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>
>         clk_bulk_disable(pd->num_clks, pd->clks);
>
> +       ret = scpsys_regulator_disable(pd);
> +       if (ret < 0)
> +               return ret;
> +
>         return 0;
>  }
>
> @@ -315,6 +343,16 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>         if (IS_ERR(pd->smi))
>                 return ERR_CAST(pd->smi);
>
> +       if (pd->data->name) {
> +               pd->supply = devm_regulator_get_optional(scpsys->dev, pd->data->name);
> +               if (IS_ERR(pd->supply)) {
> +                       if (PTR_ERR(pd->supply) == -ENODEV)
> +                               pd->supply = NULL;
> +                       else
> +                               return ERR_CAST(pd->supply);
> +               }
> +       }
> +
>         num_clks = of_clk_get_parent_count(node);
>         if (num_clks > 0) {
>                 /* Calculate number of subsys_clks */
> @@ -397,7 +435,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
>                 goto err_unprepare_subsys_clocks;
>         }
>
> -       pd->genpd.name = node->name;
> +       pd->genpd.name = pd->data->name ?: node->name;
>         pd->genpd.power_off = scpsys_power_off;
>         pd->genpd.power_on = scpsys_power_on;
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index a2f4d8f..58d72fb 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -81,6 +81,7 @@ struct scpsys_bus_prot_data {
>   * @caps: The flag for active wake-up action.
>   * @bp_infracfg: bus protection for infracfg subsystem
>   * @bp_smi: bus protection for smi subsystem
> + * @name: specific power domain name for regulator lookup and debugfs
>   */
>  struct scpsys_domain_data {
>         u32 sta_mask;
> @@ -90,6 +91,7 @@ struct scpsys_domain_data {
>         u8 caps;
>         const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
>         const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
> +       char *name;
>  };
>
>  struct scpsys_soc_data {

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3A282EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 03:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJEBkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 21:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJEBkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 21:40:05 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FBC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 18:40:05 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id 91so1474807uas.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 18:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/yqJ+HhrhgPbrSsEZfNc48eiVB4p+KKFeF86aga8Spk=;
        b=ea/34oM8cUBAXmra78MIMwx3lZN4OhsaQhOAYd1sBw9M3xqV7RvW9OQ7YA3PlaJvip
         PIxihbcBOtIoyjjcBtITgWRbTWoDYUb1nBAanr84w4CtMRCPmRCoPBB2nk/uhFILEPJK
         5/P61pICr8gLe0d8pOQ91MqmuUSYJwZCjoxzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/yqJ+HhrhgPbrSsEZfNc48eiVB4p+KKFeF86aga8Spk=;
        b=mqThSXmjbw3/n9F+EzgO2ULixnJI3jCk+afapZQuxaGN3GRz5QHnwxzU/PJ9YBz6/z
         JY8IclMify3cNk3Q66ClZ8IvpxsMzrTIp1NHMwieSaCyd1Z23fEgr3dbPC6dkayM1Xse
         3/cJWkvqeE+fxMfryQet663ue7YqnbJl0Y/d3YZBuUDITS2+Rzzd7EV9xG1UMNez0rT8
         Mk8+IJaBNqS+H3XzNQUNBejbEgSoBhA6W3Vxl5H2Djq1vw8TDmxiYol/u5Iq3cSkQ14S
         lADTbftylRPRPX7D7zFO6wkl/FqoUnVIXRKZ3N2FwEOAuwwSpCtYzUaAWT+ripL1oQYa
         WeaQ==
X-Gm-Message-State: AOAM530aCCSERa/Q8TFH3bn8q6e6pd0Ay09a41/2GFgDcsZYZ3I3K+qw
        mObJapqTIvWwWCpAHB40g9fxYv5ScphcA9mXG4FrZg==
X-Google-Smtp-Source: ABdhPJx1Peac0DJbHizhPI9NtQdm0hS7NTSI0PzfIrA8jSbB4C/5UlARtNTwZ+Y1zKyHJwBpQt2b21AQaCwqIDLi6l0=
X-Received: by 2002:ab0:6d8d:: with SMTP id m13mr5737182uah.82.1601862004635;
 Sun, 04 Oct 2020 18:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201001160154.3587848-1-enric.balletbo@collabora.com> <20201001160154.3587848-3-enric.balletbo@collabora.com>
In-Reply-To: <20201001160154.3587848-3-enric.balletbo@collabora.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 5 Oct 2020 09:39:53 +0800
Message-ID: <CANMq1KDSsfX3r1440qbmWggqbD7pU_iM4S36LUF8rsS2jVGqOg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] soc: mediatek: Add MediaTek SCPSYS power domains
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 12:02 AM Enric Balletbo i Serra
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
> Changes in v2:
> - Get base address from parent syscon. We have now a scpsys syscon node
>   and a child for the SPM (System Power Manager).
> - Use regmap API to acces de base address.
>
>  drivers/soc/mediatek/Kconfig          |  13 +
>  drivers/soc/mediatek/Makefile         |   1 +
>  drivers/soc/mediatek/mtk-pm-domains.c | 628 ++++++++++++++++++++++++++
>  3 files changed, 642 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 59a56cd790ec..68d800f9e4a5 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -44,6 +44,19 @@ config MTK_SCPSYS
>           Say yes here to add support for the MediaTek SCPSYS power domain
>           driver.
>
> +config MTK_SCPSYS_PM_DOMAINS
> +       bool "MediaTek SCPSYS generic power domain"
> +       default ARCH_MEDIATEK
> +       depends on PM
> +       depends on MTK_INFRACFG
> +       select PM_GENERIC_DOMAINS
> +       select REGMAP
> +       help
> +         Say y here to enable power domain support.
> +         In order to meet high performance and low power requirements, the System
> +         Control Processor System (SCPSYS) has several power management related
> +         tasks in the system.
> +
>  config MTK_MMSYS
>         bool "MediaTek MMSYS Support"
>         default ARCH_MEDIATEK
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 01f9f873634a..1e60fb4f89d4 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> +obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>  obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> new file mode 100644
> index 000000000000..68886bf437f9
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -0,0 +1,628 @@
> [snip]
> +
> +static int scpsys_domain_is_on(struct scpsys_domain *pd)
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
> +       /*
> +        * A domain is on when both status bits are set. If only one is set
> +        * return an error. This happens while powering up a domain
> +        */
> +
> +       if (status && status2)
> +               return true;
> +       if (!status && !status2)
> +               return false;
> +
> +       return -EINVAL;


Why do you care? It seems like all you ever do with this is check if
the domain is powered on, so it seems like you could just
return (status && status2); ?

> +}
> +
> +static int scpsys_sram_enable(struct scpsys_domain *pd)
> +{
> +       u32 pdn_ack = pd->data->sram_pdn_ack_bits;
> +       struct scpsys *scpsys = pd->scpsys;
> +       u32 val;
> +       int tmp;

regmap_read_poll_timeout => regmap_read technically takes a `unsigned
int *` parameter, so this should probably be unsigned too (or... just
reuse val?)

> +
> +       regmap_read(scpsys->base, pd->data->ctl_offs, &val);
> +       val &= ~pd->data->sram_pdn_bits;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);

Replace with regmap_update_bits?

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
> +       u32 val;
> +       int tmp;
> +
> +       regmap_read(scpsys->base, pd->data->ctl_offs, &val);
> +       val |= pd->data->sram_pdn_bits;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
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
> +       int ret, tmp;
> +       u32 val;
> +
> +       ret = clk_bulk_enable(pd->num_clks, pd->clks);
> +       if (ret)
> +               return ret;
> +
> +       /* subsys power on */
> +       regmap_read(scpsys->base, pd->data->ctl_offs, &val);
> +       val |= PWR_ON_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +       val |= PWR_ON_2ND_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       /* wait until PWR_ACK = 1 */
> +       ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp > 0, MTK_POLL_DELAY_US,
> +                                MTK_POLL_TIMEOUT);
> +       if (ret < 0)
> +               goto err_pwr_ack;
> +
> +       val &= ~PWR_CLK_DIS_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       val &= ~PWR_ISO_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       val |= PWR_RST_B_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       ret = scpsys_sram_enable(pd);
> +       if (ret < 0)
> +               goto err_pwr_ack;
> +
> +       ret = scpsys_bus_protect_disable(pd);
> +       if (ret < 0)
> +               goto err_pwr_ack;
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
> +       int ret, tmp;
> +       u32 val;
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
> +       regmap_read(scpsys->base, pd->data->ctl_offs, &val);
> +       val |= PWR_ISO_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       val &= ~PWR_RST_B_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       val |= PWR_CLK_DIS_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       val &= ~PWR_ON_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       val &= ~PWR_ON_2ND_BIT;
> +       regmap_write(scpsys->base, pd->data->ctl_offs, val);
> +
> +       /* wait until PWR_ACK = 0 */
> +       ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp == 0, MTK_POLL_DELAY_US,
> +                                MTK_POLL_TIMEOUT);
> +       if (ret < 0)
> +               return ret;
> +
> +       clk_bulk_disable(pd->num_clks, pd->clks);
> +
> +       return 0;
> +}
> +
> +static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
> +{
> +       const struct scpsys_domain_data *domain_data;
> +       struct scpsys_domain *pd;
> +       int i, ret;
> +       u32 id;
> +
> +       ret = of_property_read_u32(node, "reg", &id);
> +       if (ret) {
> +               dev_err_probe(scpsys->dev, ret,
> +                             "%pOFn: failed to retrieve domain id from reg\n", node);
> +               return -EINVAL;
> +       }
> +
> +       if (id >= scpsys->soc_data->num_domains) {
> +               dev_err_probe(scpsys->dev, -EINVAL, "%pOFn: invalid domain id %d\n", node, id);
> +               return -EINVAL;
> +       }
> +
> +       domain_data = &scpsys->soc_data->domains[id];
> +       if (!domain_data) {

Is that even possible at all? I mean, even if
scpsys->soc_data->domains is NULL, as long as id != 0, this will no
happen.

> +               dev_err_probe(scpsys->dev, -EINVAL, "%pOFn: undefined domain id %d\n", node, id);
> +               return -EINVAL;
> +       }
> +
> +       pd = devm_kzalloc(scpsys->dev, sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               return -ENOMEM;
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
> +                       return -ENOMEM;
> +       } else {
> +               pd->num_clks = 0;
> +       }

pd->num_clks < 0 can't happen so you can drop this.

> +
> +       for (i = 0; i < pd->num_clks; i++) {
> +               pd->clks[i].clk = of_clk_get(node, i);
> +               if (IS_ERR(pd->clks[i].clk)) {
> +                       ret = PTR_ERR(pd->clks[i].clk);
> +                       dev_err_probe(scpsys->dev, ret, "%pOFn: failed to get clk at index %d\n",
> +                                     node, i);
> +                       return ret;
> +               }
> +       }
> +
> +       ret = clk_bulk_prepare(pd->num_clks, pd->clks);
> +       if (ret)
> +               goto err_put_clocks;
> +
> +       /*
> +        * Initially turn on all domains to make the domains usable
> +        * with !CONFIG_PM and to get the hardware in sync with the
> +        * software.  The unused domains will be switched off during
> +        * late_init time.
> +        */
> +       ret = scpsys_power_on(&pd->genpd);
> +       if (ret < 0) {
> +               dev_err_probe(scpsys->dev, ret, "failed to power on domain %pOFN\n", node);
> +               goto err_unprepare_clocks;
> +       }
> +
> +       pd->genpd.name = node->name;
> +       pd->genpd.power_off = scpsys_power_off;
> +       pd->genpd.power_on = scpsys_power_on;
> +
> +       pm_genpd_init(&pd->genpd, NULL, false);
> +
> +       scpsys->domains[id] = &pd->genpd;

Do we want to add some logic to make sure scpsys->domains[id] == NULL
before this? (to make sure we don't accidentally probe 2 domains with
the same id, which I guess could happen with some incorrect
devicetree)

> +       return 0;
> +
> +err_unprepare_clocks:
> +       clk_bulk_unprepare(pd->num_clks, pd->clks);
> +err_put_clocks:
> +       clk_bulk_put(pd->num_clks, pd->clks);

> +       devm_kfree(scpsys->dev, pd->clks);
> +       pd->num_clks = 0;

Why do you need these 2 lines? Can't you just let the core free the
devm_ allocated data?

> +       return ret;
> +}
> +
> +static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *parent)
> +{
> +       struct device_node *child;
> +       struct generic_pm_domain *child_pd, *parent_pd;
> +       int ret;
> +
> +       for_each_child_of_node(parent, child) {
> +               u32 id;
> +
> +               ret = of_property_read_u32(parent, "reg", &id);
> +               if (ret) {
> +                       dev_err_probe(scpsys->dev, ret,
> +                                     "%pOFn: failed to get parent domain id\n", child);
> +                       goto err_put_node;
> +               }
> +               parent_pd = scpsys->pd_data.domains[id];

No bounds check on id here? Also, wondering if you want to move the
logic, including bounds check, to a small function (since it's
repeated 3 times now, but I think that can be reduced to 2).

> +
> +               ret = scpsys_add_one_domain(scpsys, child);
> +               if (ret)
> +                       goto err_put_node;
> +
> +               ret = of_property_read_u32(child, "reg", &id);
> +               if (ret) {
> +                       dev_err_probe(scpsys->dev, ret,
> +                                     "%pOFn: failed to get child domain id\n", child);
> +                       goto err_put_node;
> +               }
> +               child_pd = scpsys->pd_data.domains[id];

You already obtained the child_pd in scpsys_add_one_domain... Can you
have scpsys_add_one_domain return `child_pd` as a pointer (or a
PTR_ERR)?

> +
> +               ret = pm_genpd_add_subdomain(parent_pd, child_pd);
> +               if (ret) {
> +                       dev_err_probe(scpsys->dev, ret,
> +                                     "failed to add %s subdomain to parent %s\n", child_pd->name,
> +                                     parent_pd->name);
> +                       goto err_put_node;
> +               } else {
> +                       dev_dbg(scpsys->dev, "%s add subdomain: %s\n", parent_pd->name,
> +                               child_pd->name);
> +               }
> +
> +               /* recursive call to add all subdomains */
> +               ret = scpsys_add_subdomain(scpsys, child);
> +               if (ret)
> +                       goto err_put_node;
> +       }
> +
> +       return 0;
> +
> +err_put_node:
> +       of_node_put(child);
> +       return ret;
> +}
> +
> +static void scpsys_remove_one_domain(struct scpsys_domain *pd)
> +{
> +       int ret;
> +
> +       /*
> +        * We're in the error cleanup already, so we only complain,
> +        * but won't emit another error on top of the original one.
> +        */
> +       ret = pm_genpd_remove(&pd->genpd);
> +       if (ret < 0)
> +               dev_err(pd->scpsys->dev,
> +                       "failed to remove domain '%s' : %d - state may be inconsistent\n",
> +                       pd->genpd.name, ret);
> +
> +       scpsys_power_off(&pd->genpd);
> +
> +       clk_bulk_unprepare(pd->num_clks, pd->clks);
> +       clk_bulk_put(pd->num_clks, pd->clks);

> +       pd->num_clks = 0;

What's the point of setting num_clks to 0?

> +}
> +
> +static void scpsys_domain_cleanup(struct scpsys *scpsys)
> +{
> +       struct generic_pm_domain *genpd;
> +       struct scpsys_domain *pd;
> +       int i;
> +
> +       for (i = scpsys->pd_data.num_domains - 1; i >= 0; i--) {
> +               genpd = scpsys->pd_data.domains[i];
> +               if (genpd) {
> +                       pd = to_scpsys_domain(genpd);
> +                       scpsys_remove_one_domain(pd);
> +               }
> +       }
> +}
> [snip]

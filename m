Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0E278551
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgIYKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:43:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgIYKnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:43:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601030597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tgQqIUnodYzvOOQkGaExMTVz+YEFWV2xfmmDq9+Fc0=;
        b=o6W0meRdVM+XAptva3obrmZ8kMO+vycPM6aNjVNJUNk/M4KMY/ng0zuESSPkPoFOOtJ4Jy
        uqSMWruvR39oDcVsZXkVMtJ0WWSs0iYIog1lnejWQWFkQL/dP06CfRsHaelBLw83tXZSXR
        y4gbU860/j3VYnLW7YQ1NMf0eafWqIw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54592AC0C;
        Fri, 25 Sep 2020 10:43:17 +0000 (UTC)
Subject: Re: [PATCH 02/12] soc: mediatek: Add MediaTek SCPSYS power domains
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-3-enric.balletbo@collabora.com>
 <1601029522.1346.53.camel@mtksdaap41>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <96d052a3-b0fb-4a28-88ab-213d8e6c201f@suse.com>
Date:   Fri, 25 Sep 2020 12:43:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601029522.1346.53.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/09/2020 12:25, Weiyi Lu wrote:
> On Thu, 2020-09-10 at 19:28 +0200, Enric Balletbo i Serra wrote:
>> The System Control Processor System (SCPSYS) has several power management
>> related tasks in the system. This driver implements support to handle
>> the different power domains supported in order to meet high performance
>> and low power requirements.
>>
>> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>   drivers/soc/mediatek/Kconfig          |  13 +
>>   drivers/soc/mediatek/Makefile         |   1 +
>>   drivers/soc/mediatek/mtk-pm-domains.c | 626 ++++++++++++++++++++++++++
>>   3 files changed, 640 insertions(+)
>>   create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
>>
>> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
>> index 59a56cd790ec..68d800f9e4a5 100644
>> --- a/drivers/soc/mediatek/Kconfig
>> +++ b/drivers/soc/mediatek/Kconfig
>> @@ -44,6 +44,19 @@ config MTK_SCPSYS
>>   	  Say yes here to add support for the MediaTek SCPSYS power domain
>>   	  driver.
>>   
>> +config MTK_SCPSYS_PM_DOMAINS
>> +	bool "MediaTek SCPSYS generic power domain"
>> +	default ARCH_MEDIATEK
>> +	depends on PM
>> +	depends on MTK_INFRACFG
>> +	select PM_GENERIC_DOMAINS
>> +	select REGMAP
>> +	help
>> +	  Say y here to enable power domain support.
>> +	  In order to meet high performance and low power requirements, the System
>> +	  Control Processor System (SCPSYS) has several power management related
>> +	  tasks in the system.
>> +
>>   config MTK_MMSYS
>>   	bool "MediaTek MMSYS Support"
>>   	default ARCH_MEDIATEK
>> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
>> index 01f9f873634a..1e60fb4f89d4 100644
>> --- a/drivers/soc/mediatek/Makefile
>> +++ b/drivers/soc/mediatek/Makefile
>> @@ -3,4 +3,5 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>> +obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
>> new file mode 100644
>> index 000000000000..db631dbaf2e3
>> --- /dev/null
>> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
>> @@ -0,0 +1,626 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2020 Collabora Ltd.
>> + */
>> +#include <linux/clk.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_clk.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/soc/mediatek/infracfg.h>
>> +
>> +#include <dt-bindings/power/mt8173-power.h>
>> +
>> +#define MTK_POLL_DELAY_US   10
>> +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
>> +
>> +#define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
>> +#define MTK_SCPD_FWAIT_SRAM		BIT(1)
>> +#define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>> +
>> +#define SPM_VDE_PWR_CON			0x0210
>> +#define SPM_MFG_PWR_CON			0x0214
>> +#define SPM_VEN_PWR_CON			0x0230
>> +#define SPM_ISP_PWR_CON			0x0238
>> +#define SPM_DIS_PWR_CON			0x023c
>> +#define SPM_VEN2_PWR_CON		0x0298
>> +#define SPM_AUDIO_PWR_CON		0x029c
>> +#define SPM_MFG_2D_PWR_CON		0x02c0
>> +#define SPM_MFG_ASYNC_PWR_CON		0x02c4
>> +#define SPM_USB_PWR_CON			0x02cc
>> +
> 
> If me, I'd choose to write directly into the data of each SoC now
> because it's inconsistent on most MediatTek chips.
> 

What do you mean with "write directly into the data of each SoC"?

>> +#define SPM_PWR_STATUS			0x060c
>> +#define SPM_PWR_STATUS_2ND		0x0610
>> +
>> +#define PWR_RST_B_BIT			BIT(0)
>> +#define PWR_ISO_BIT			BIT(1)
>> +#define PWR_ON_BIT			BIT(2)
>> +#define PWR_ON_2ND_BIT			BIT(3)
>> +#define PWR_CLK_DIS_BIT			BIT(4)
>> +
>> +#define PWR_STATUS_DISP			BIT(3)
>> +#define PWR_STATUS_MFG			BIT(4)
>> +#define PWR_STATUS_ISP			BIT(5)
>> +#define PWR_STATUS_VDEC			BIT(7)
>> +#define PWR_STATUS_VENC_LT		BIT(20)
>> +#define PWR_STATUS_VENC			BIT(21)
>> +#define PWR_STATUS_MFG_2D		BIT(22)
>> +#define PWR_STATUS_MFG_ASYNC		BIT(23)
>> +#define PWR_STATUS_AUDIO		BIT(24)
>> +#define PWR_STATUS_USB			BIT(25)
>> +
> 
> same here for the status bits.
> 

Up to now we have litte collisions in the different defines. Not sure what you 
propose.

>> +struct scpsys_bus_prot_data {
>> +	u32 bus_prot_mask;
>> +	bool bus_prot_reg_update;
>> +};
>> +
>> +/**
>> + * struct scpsys_domain_data - scp domain data for power on/off flow
>> + * @sta_mask: The mask for power on/off status bit.
>> + * @ctl_offs: The offset for main power control register.
>> + * @sram_pdn_bits: The mask for sram power control bits.
>> + * @sram_pdn_ack_bits: The mask for sram power control acked bits.
>> + * @caps: The flag for active wake-up action.
>> + * @bp_infracfg: bus protection for infracfg subsystem
>> + */
>> +struct scpsys_domain_data {
>> +	u32 sta_mask;
>> +	int ctl_offs;
>> +	u32 sram_pdn_bits;
>> +	u32 sram_pdn_ack_bits;
>> +	u8 caps;
>> +	const struct scpsys_bus_prot_data bp_infracfg;
>> +};
>> +
>> +struct scpsys_domain {
>> +	struct generic_pm_domain genpd;
>> +	const struct scpsys_domain_data *data;
>> +	struct scpsys *scpsys;
>> +	int num_clks;
>> +	struct clk_bulk_data *clks;
>> +	struct regmap *infracfg;
> 
> Could we move
> struct regmap *infracfg;
> back to struct scpsys? It seems we need to set this property many times
> under each power domain sub node in device tree?
> 

With the new design only the power domain that needs infracfg/smi will actually 
get a handle to the regmap.
That allows us to describe the HW better in device tree.

This is done once when we load the driver I don't see why this should be an 
issue (if you were referring to the fact that it takes longer do this several 
times instead of once). So I think it is a good trade-off.

>> +};
>> +
>> +struct scpsys_soc_data {
>> +	const struct scpsys_domain_data *domains;
>> +	int num_domains;
>> +	int pwr_sta_offs;
>> +	int pwr_sta2nd_offs;
>> +};
>> +
>> +struct scpsys {
>> +	struct device *dev;
>> +	void __iomem *base;
>> +	const struct scpsys_soc_data *soc_data;
>> +	struct genpd_onecell_data pd_data;
>> +	struct generic_pm_domain *domains[];
>> +};
>> +
>> +#define to_scpsys_domain(gpd) container_of(gpd, struct scpsys_domain, genpd)
>> +
>> +static int scpsys_domain_is_on(struct scpsys_domain *pd)
>> +{
>> +	struct scpsys *scpsys = pd->scpsys;
>> +
>> +	u32 status = readl(scpsys->base + scpsys->soc_data->pwr_sta_offs) & pd->data->sta_mask;
>> +	u32 status2 = readl(scpsys->base + scpsys->soc_data->pwr_sta2nd_offs) & pd->data->sta_mask;
>> +
>> +	/*
>> +	 * A domain is on when both status bits are set. If only one is set
>> +	 * return an error. This happens while powering up a domain
>> +	 */
>> +
>> +	if (status && status2)
>> +		return true;
>> +	if (!status && !status2)
>> +		return false;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int scpsys_sram_enable(struct scpsys_domain *pd, void __iomem *ctl_addr)
>> +{
>> +	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
>> +	u32 val;
>> +	int tmp;
>> +	int ret;
>> +
>> +	val = readl(ctl_addr);
>> +	val &= ~pd->data->sram_pdn_bits;
>> +	writel(val, ctl_addr);
>> +
>> +	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
>> +	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0, MTK_POLL_DELAY_US,
>> +				 MTK_POLL_TIMEOUT);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static int scpsys_sram_disable(struct scpsys_domain *pd, void __iomem *ctl_addr)
>> +{
>> +	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
>> +	u32 val;
>> +	int tmp;
>> +
>> +	val = readl(ctl_addr);
>> +	val |= pd->data->sram_pdn_bits;
>> +	writel(val, ctl_addr);
>> +
>> +	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
>> +	return readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack, MTK_POLL_DELAY_US,
>> +				  MTK_POLL_TIMEOUT);
>> +}
>> +
>> +static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
>> +{
>> +	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
>> +
>> +	if (!bp_data->bus_prot_mask)
>> +		return 0;
>> +
>> +	return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
>> +					       bp_data->bus_prot_reg_update);
>> +}
>> +
>> +static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
>> +{
>> +	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
>> +
>> +	if (!bp_data->bus_prot_mask)
>> +		return 0;
>> +
>> +	return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
>> +						 bp_data->bus_prot_reg_update);
>> +}
>> +
>> +static int scpsys_power_on(struct generic_pm_domain *genpd)
>> +{
>> +	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
>> +	struct scpsys *scpsys = pd->scpsys;
>> +	void __iomem *ctl_addr = scpsys->base + pd->data->ctl_offs;
>> +	int ret, tmp;
>> +	u32 val;
>> +
>> +	ret = clk_bulk_enable(pd->num_clks, pd->clks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* subsys power on */
>> +	val = readl(ctl_addr);
>> +	val |= PWR_ON_BIT;
>> +	writel(val, ctl_addr);
>> +	val |= PWR_ON_2ND_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	/* wait until PWR_ACK = 1 */
>> +	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp > 0, MTK_POLL_DELAY_US,
>> +				 MTK_POLL_TIMEOUT);
>> +	if (ret < 0)
>> +		goto err_pwr_ack;
>> +
>> +	val &= ~PWR_CLK_DIS_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	val &= ~PWR_ISO_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	val |= PWR_RST_B_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	ret = scpsys_sram_enable(pd, ctl_addr);
>> +	if (ret < 0)
>> +		goto err_pwr_ack;
>> +
>> +	ret = scpsys_bus_protect_disable(pd);
>> +	if (ret < 0)
>> +		goto err_pwr_ack;
>> +
>> +	return 0;
>> +
>> +err_pwr_ack:
>> +	clk_bulk_disable(pd->num_clks, pd->clks);
>> +	dev_err(scpsys->dev, "Failed to power on domain %s\n", genpd->name);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scpsys_power_off(struct generic_pm_domain *genpd)
>> +{
>> +	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
>> +	struct scpsys *scpsys = pd->scpsys;
>> +	void __iomem *ctl_addr = scpsys->base + pd->data->ctl_offs;
>> +	int ret, tmp;
>> +	u32 val;
>> +
>> +	ret = scpsys_bus_protect_enable(pd);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = scpsys_sram_disable(pd, ctl_addr);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* subsys power off */
>> +	val = readl(ctl_addr);
>> +	val |= PWR_ISO_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	val &= ~PWR_RST_B_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	val |= PWR_CLK_DIS_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	val &= ~PWR_ON_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	val &= ~PWR_ON_2ND_BIT;
>> +	writel(val, ctl_addr);
>> +
>> +	/* wait until PWR_ACK = 0 */
>> +	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp == 0, MTK_POLL_DELAY_US,
>> +				 MTK_POLL_TIMEOUT);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	clk_bulk_disable(pd->num_clks, pd->clks);
>> +
>> +	return 0;
>> +}
>> +
>> +static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
>> +{
>> +	const struct scpsys_domain_data *domain_data;
>> +	struct scpsys_domain *pd;
>> +	int i, ret;
>> +	u32 id;
>> +
>> +	ret = of_property_read_u32(node, "reg", &id);
>> +	if (ret) {
>> +		dev_err(scpsys->dev, "%pOFn: failed to retrieve domain id from reg: %d\n", node,
>> +			ret);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (id >= scpsys->soc_data->num_domains) {
>> +		dev_err(scpsys->dev, "%pOFn: invalid domain id %d\n", node, id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	domain_data = &scpsys->soc_data->domains[id];
>> +	if (!domain_data) {
>> +		dev_err(scpsys->dev, "%pOFn: undefined domain id %d\n", node, id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	pd = devm_kzalloc(scpsys->dev, sizeof(*pd), GFP_KERNEL);
>> +	if (!pd)
>> +		return -ENOMEM;
>> +
>> +	pd->data = domain_data;
>> +	pd->scpsys = scpsys;
>> +
>> +	pd->infracfg = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
>> +	if (IS_ERR(pd->infracfg))
>> +		pd->infracfg = NULL;
>> +
>> +	pd->num_clks = of_clk_get_parent_count(node);
>> +	if (pd->num_clks > 0) {
>> +		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
>> +		if (!pd->clks)
>> +			return -ENOMEM;
>> +	} else {
>> +		pd->num_clks = 0;
>> +	}
>> +
>> +	for (i = 0; i < pd->num_clks; i++) {
>> +		pd->clks[i].clk = of_clk_get(node, i);
> 
> Is it possible to have a better way that we could use of_clk_bulk_get()?
> 
>> +		if (IS_ERR(pd->clks[i].clk)) {
>> +			ret = PTR_ERR(pd->clks[i].clk);
>> +			dev_err(scpsys->dev, "%pOFn: failed to get clk at index %d: %d\n", node, i,
>> +				ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
>> +	if (ret)
>> +		goto err_put_clocks;
>> +
>> +	/*
>> +	 * Initially turn on all domains to make the domains usable
>> +	 * with !CONFIG_PM and to get the hardware in sync with the
>> +	 * software.  The unused domains will be switched off during
>> +	 * late_init time.
>> +	 */
>> +	ret = scpsys_power_on(&pd->genpd);
>> +	if (ret < 0) {
>> +		dev_err(scpsys->dev, "failed to power on domain %pOFN with error %d\n", node, ret);
>> +		goto err_unprepare_clocks;
>> +	}
>> +
>> +	pd->genpd.name = node->name;
>> +	pd->genpd.power_off = scpsys_power_off;
>> +	pd->genpd.power_on = scpsys_power_on;
>> +
>> +	pm_genpd_init(&pd->genpd, NULL, false);
>> +
>> +	scpsys->domains[id] = &pd->genpd;
>> +	return 0;
>> +
>> +err_unprepare_clocks:
>> +	clk_bulk_unprepare(pd->num_clks, pd->clks);
>> +err_put_clocks:
>> +	clk_bulk_put(pd->num_clks, pd->clks);
>> +	devm_kfree(scpsys->dev, pd->clks);
>> +	pd->num_clks = 0;
>> +	return ret;
>> +}
>> +
>> +static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *parent)
>> +{
>> +	struct device_node *child;
>> +	struct generic_pm_domain *child_pd, *parent_pd;
>> +	int ret;
>> +
>> +	for_each_child_of_node(parent, child) {
>> +		u32 id;
>> +
>> +		ret = of_property_read_u32(parent, "reg", &id);
>> +		if (ret) {
>> +			dev_err(scpsys->dev, "%pOFn: failed to get parent domain id: %d\n", child,
>> +				ret);
>> +			goto err_put_node;
>> +		}
>> +		parent_pd = scpsys->pd_data.domains[id];
>> +
> 
> nit. Could we move parent outside(in front of) the loop?
> 

Yes, I think that makes sense.

Regards,
Matthias

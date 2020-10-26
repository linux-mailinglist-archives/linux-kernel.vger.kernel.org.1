Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3122299473
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788727AbgJZRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:55:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33820 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781489AbgJZRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9BA3A1F44FCA
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 02/16] soc: mediatek: Add MediaTek SCPSYS power domains
Date:   Mon, 26 Oct 2020 18:55:11 +0100
Message-Id: <20201026175526.2915399-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System Control Processor System (SCPSYS) has several power management
related tasks in the system. This driver implements support to handle
the different power domains supported in order to meet high performance
and low power requirements.

Co-developed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- Return only a boolean for scpsys_domain_is_on()
- Use regmap_update_bits API when possible.
- Add some logic to make sure scpsys->domains[id] == NULL or != NULL
  when needed.
- Return the child node for scpsys_add_one_domain() call.
- Remove unneded zeroing num_clks variable.
- Move the soc specific data to separate include files.

Changes in v2:
- Get base address from parent syscon. We have now a scpsys syscon node
  and a child for the SPM (System Power Manager).
- Use regmap API to acces de base address.

 drivers/soc/mediatek/Kconfig             |  13 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mt8173-pm-domains.h |  96 +++++
 drivers/soc/mediatek/mtk-pm-domains.c    | 455 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.h    |  65 ++++
 5 files changed, 630 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8173-pm-domains.h
 create mode 100644 drivers/soc/mediatek/mtk-pm-domains.c
 create mode 100644 drivers/soc/mediatek/mtk-pm-domains.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 59a56cd790ec..68d800f9e4a5 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -44,6 +44,19 @@ config MTK_SCPSYS
 	  Say yes here to add support for the MediaTek SCPSYS power domain
 	  driver.
 
+config MTK_SCPSYS_PM_DOMAINS
+	bool "MediaTek SCPSYS generic power domain"
+	default ARCH_MEDIATEK
+	depends on PM
+	depends on MTK_INFRACFG
+	select PM_GENERIC_DOMAINS
+	select REGMAP
+	help
+	  Say y here to enable power domain support.
+	  In order to meet high performance and low power requirements, the System
+	  Control Processor System (SCPSYS) has several power management related
+	  tasks in the system.
+
 config MTK_MMSYS
 	bool "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 069625c118c2..905b4faa624d 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
+obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mmsys/
diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
new file mode 100644
index 000000000000..a2a624bbd8b8
--- /dev/null
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8173_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8173_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mt8173-power.h>
+
+/*
+ * MT8173 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
+	[MT8173_POWER_DOMAIN_VDEC] = {
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8173_POWER_DOMAIN_VENC] = {
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = SPM_VEN_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8173_POWER_DOMAIN_ISP] = {
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT8173_POWER_DOMAIN_MM] = {
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			.bus_prot_reg_update = true,
+			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
+				MT8173_TOP_AXI_PROT_EN_MM_M1,
+		},
+	},
+	[MT8173_POWER_DOMAIN_VENC_LT] = {
+		.sta_mask = PWR_STATUS_VENC_LT,
+		.ctl_offs = SPM_VEN2_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8173_POWER_DOMAIN_AUDIO] = {
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = SPM_AUDIO_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+	},
+	[MT8173_POWER_DOMAIN_USB] = {
+		.sta_mask = PWR_STATUS_USB,
+		.ctl_offs = SPM_USB_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
+		.sta_mask = PWR_STATUS_MFG_ASYNC,
+		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = 0,
+	},
+	[MT8173_POWER_DOMAIN_MFG_2D] = {
+		.sta_mask = PWR_STATUS_MFG_2D,
+		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+	},
+	[MT8173_POWER_DOMAIN_MFG] = {
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.sram_pdn_bits = GENMASK(13, 8),
+		.sram_pdn_ack_bits = GENMASK(21, 16),
+		.bp_infracfg = {
+			.bus_prot_reg_update = true,
+			.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
+				MT8173_TOP_AXI_PROT_EN_MFG_M0 |
+				MT8173_TOP_AXI_PROT_EN_MFG_M1 |
+				MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT,
+		},
+	},
+};
+
+static const struct scpsys_soc_data mt8173_scpsys_data = {
+	.domains = scpsys_domain_data_mt8173,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8173),
+	.pwr_sta_offs = SPM_PWR_STATUS,
+	.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
+};
+
+#endif /* __SOC_MEDIATEK_MT8173_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
new file mode 100644
index 000000000000..16503d6db6a8
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020 Collabora Ltd.
+ */
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_clk.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/soc/mediatek/infracfg.h>
+
+#include "mt8173-pm-domains.h"
+
+#define MTK_POLL_DELAY_US		10
+#define MTK_POLL_TIMEOUT		USEC_PER_SEC
+
+#define PWR_RST_B_BIT			BIT(0)
+#define PWR_ISO_BIT			BIT(1)
+#define PWR_ON_BIT			BIT(2)
+#define PWR_ON_2ND_BIT			BIT(3)
+#define PWR_CLK_DIS_BIT			BIT(4)
+
+struct scpsys_domain {
+	struct generic_pm_domain genpd;
+	const struct scpsys_domain_data *data;
+	struct scpsys *scpsys;
+	int num_clks;
+	struct clk_bulk_data *clks;
+	struct regmap *infracfg;
+};
+
+struct scpsys {
+	struct device *dev;
+	struct regmap *base;
+	const struct scpsys_soc_data *soc_data;
+	struct genpd_onecell_data pd_data;
+	struct generic_pm_domain *domains[];
+};
+
+#define to_scpsys_domain(gpd) container_of(gpd, struct scpsys_domain, genpd)
+
+static int scpsys_domain_is_on(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+	u32 status, status2;
+
+	regmap_read(scpsys->base, scpsys->soc_data->pwr_sta_offs, &status);
+	status &= pd->data->sta_mask;
+
+	regmap_read(scpsys->base, scpsys->soc_data->pwr_sta2nd_offs, &status2);
+	status2 &= pd->data->sta_mask;
+
+	/* A domain is on when both status bits are set. */
+	return status && status2;
+}
+
+static int scpsys_sram_enable(struct scpsys_domain *pd)
+{
+	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
+	struct scpsys *scpsys = pd->scpsys;
+	unsigned int tmp;
+
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits, 0);
+
+	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
+	return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
+					(tmp & pdn_ack) == 0, MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_sram_disable(struct scpsys_domain *pd)
+{
+	u32 pdn_ack = pd->data->sram_pdn_ack_bits;
+	struct scpsys *scpsys = pd->scpsys;
+	unsigned int tmp;
+
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, pd->data->sram_pdn_bits,
+			   pd->data->sram_pdn_bits);
+
+	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
+	return regmap_read_poll_timeout(scpsys->base, pd->data->ctl_offs, tmp,
+					(tmp & pdn_ack) == pdn_ack, MTK_POLL_DELAY_US,
+					MTK_POLL_TIMEOUT);
+}
+
+static int scpsys_bus_protect_enable(struct scpsys_domain *pd)
+{
+	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+
+	if (!bp_data->bus_prot_mask)
+		return 0;
+
+	return mtk_infracfg_set_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
+					       bp_data->bus_prot_reg_update);
+}
+
+static int scpsys_bus_protect_disable(struct scpsys_domain *pd)
+{
+	const struct scpsys_bus_prot_data *bp_data = &pd->data->bp_infracfg;
+
+	if (!bp_data->bus_prot_mask)
+		return 0;
+
+	return mtk_infracfg_clear_bus_protection(pd->infracfg, bp_data->bus_prot_mask,
+						 bp_data->bus_prot_reg_update);
+}
+
+static int scpsys_power_on(struct generic_pm_domain *genpd)
+{
+	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
+	struct scpsys *scpsys = pd->scpsys;
+	unsigned int tmp;
+	int ret;
+
+	ret = clk_bulk_enable(pd->num_clks, pd->clks);
+	if (ret)
+		return ret;
+
+	/* subsys power on */
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT, PWR_ON_BIT);
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT, PWR_ON_2ND_BIT);
+
+	/* wait until PWR_ACK = 1 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp > 0, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		goto err_pwr_ack;
+
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT, 0);
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT, 0);
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT, PWR_RST_B_BIT);
+
+	ret = scpsys_sram_enable(pd);
+	if (ret < 0)
+		goto err_pwr_ack;
+
+	ret = scpsys_bus_protect_disable(pd);
+	if (ret < 0)
+		goto err_pwr_ack;
+
+	return 0;
+
+err_pwr_ack:
+	clk_bulk_disable(pd->num_clks, pd->clks);
+	return ret;
+}
+
+static int scpsys_power_off(struct generic_pm_domain *genpd)
+{
+	struct scpsys_domain *pd = container_of(genpd, struct scpsys_domain, genpd);
+	struct scpsys *scpsys = pd->scpsys;
+	unsigned int tmp;
+	int ret;
+
+	ret = scpsys_bus_protect_enable(pd);
+	if (ret < 0)
+		return ret;
+
+	ret = scpsys_sram_disable(pd);
+	if (ret < 0)
+		return ret;
+
+	/* subsys power off */
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT, 0);
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT, PWR_ISO_BIT);
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT, PWR_CLK_DIS_BIT);
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT, 0);
+	regmap_update_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT, 0);
+
+	/* wait until PWR_ACK = 0 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, tmp == 0, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	clk_bulk_disable(pd->num_clks, pd->clks);
+
+	return 0;
+}
+
+static struct
+generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
+{
+	const struct scpsys_domain_data *domain_data;
+	struct scpsys_domain *pd;
+	int i, ret;
+	u32 id;
+
+	ret = of_property_read_u32(node, "reg", &id);
+	if (ret) {
+		dev_err(scpsys->dev, "%pOF: failed to retrieve domain id from reg: %d\n",
+			node, ret);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (id >= scpsys->soc_data->num_domains) {
+		dev_err(scpsys->dev, "%pOF: invalid domain id %d\n", node, id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	domain_data = &scpsys->soc_data->domains[id];
+	if (!domain_data) {
+		dev_err(scpsys->dev, "%pOF: undefined domain id %d\n", node, id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pd = devm_kzalloc(scpsys->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	pd->data = domain_data;
+	pd->scpsys = scpsys;
+
+	pd->infracfg = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
+	if (IS_ERR(pd->infracfg))
+		pd->infracfg = NULL;
+
+	pd->num_clks = of_clk_get_parent_count(node);
+	if (pd->num_clks > 0) {
+		pd->clks = devm_kcalloc(scpsys->dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
+		if (!pd->clks)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < pd->num_clks; i++) {
+		pd->clks[i].clk = of_clk_get(node, i);
+		if (IS_ERR(pd->clks[i].clk)) {
+			dev_err(scpsys->dev, "%pOF: failed to get clk at index %d\n",
+				node, i);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
+	if (ret)
+		goto err_put_clocks;
+
+	/*
+	 * Initially turn on all domains to make the domains usable
+	 * with !CONFIG_PM and to get the hardware in sync with the
+	 * software.  The unused domains will be switched off during
+	 * late_init time.
+	 */
+	ret = scpsys_power_on(&pd->genpd);
+	if (ret < 0) {
+		dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
+		goto err_unprepare_clocks;
+	}
+
+	if (scpsys->domains[id]) {
+		ret = -EINVAL;
+		dev_err(scpsys->dev,
+			"power domain with id %d already exists, check your device-tree\n", id);
+		goto err_unprepare_clocks;
+	}
+
+	pd->genpd.name = node->name;
+	pd->genpd.power_off = scpsys_power_off;
+	pd->genpd.power_on = scpsys_power_on;
+
+	pm_genpd_init(&pd->genpd, NULL, false);
+	scpsys->domains[id] = &pd->genpd;
+
+	return scpsys->pd_data.domains[id];
+
+err_unprepare_clocks:
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
+err_put_clocks:
+	clk_bulk_put(pd->num_clks, pd->clks);
+	return ERR_PTR(ret);
+}
+
+static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *parent)
+{
+	struct generic_pm_domain *child_pd, *parent_pd;
+	struct device_node *child;
+	int ret;
+
+	for_each_child_of_node(parent, child) {
+		u32 id;
+
+		ret = of_property_read_u32(parent, "reg", &id);
+		if (ret) {
+			dev_err(scpsys->dev, "%pOF: failed to get parent domain id\n", child);
+			goto err_put_node;
+		}
+
+		if (!scpsys->pd_data.domains[id]) {
+			ret = -EINVAL;
+			dev_err(scpsys->dev, "power domain with id %d does not exist\n", id);
+			goto err_put_node;
+		}
+
+		parent_pd = scpsys->pd_data.domains[id];
+
+		child_pd = scpsys_add_one_domain(scpsys, child);
+		if (IS_ERR(child_pd)) {
+			ret = PTR_ERR(child_pd);
+			dev_err(scpsys->dev, "%pOF: failed to get child domain id\n", child);
+			goto err_put_node;
+		}
+
+		ret = pm_genpd_add_subdomain(parent_pd, child_pd);
+		if (ret) {
+			dev_err(scpsys->dev, "failed to add %s subdomain to parent %s\n",
+				child_pd->name, parent_pd->name);
+			goto err_put_node;
+		} else {
+			dev_dbg(scpsys->dev, "%s add subdomain: %s\n", parent_pd->name,
+				child_pd->name);
+		}
+
+		/* recursive call to add all subdomains */
+		ret = scpsys_add_subdomain(scpsys, child);
+		if (ret)
+			goto err_put_node;
+	}
+
+	return 0;
+
+err_put_node:
+	of_node_put(child);
+	return ret;
+}
+
+static void scpsys_remove_one_domain(struct scpsys_domain *pd)
+{
+	int ret;
+
+	/*
+	 * We're in the error cleanup already, so we only complain,
+	 * but won't emit another error on top of the original one.
+	 */
+	ret = pm_genpd_remove(&pd->genpd);
+	if (ret < 0)
+		dev_err(pd->scpsys->dev,
+			"failed to remove domain '%s' : %d - state may be inconsistent\n",
+			pd->genpd.name, ret);
+
+	scpsys_power_off(&pd->genpd);
+
+	clk_bulk_unprepare(pd->num_clks, pd->clks);
+	clk_bulk_put(pd->num_clks, pd->clks);
+}
+
+static void scpsys_domain_cleanup(struct scpsys *scpsys)
+{
+	struct generic_pm_domain *genpd;
+	struct scpsys_domain *pd;
+	int i;
+
+	for (i = scpsys->pd_data.num_domains - 1; i >= 0; i--) {
+		genpd = scpsys->pd_data.domains[i];
+		if (genpd) {
+			pd = to_scpsys_domain(genpd);
+			scpsys_remove_one_domain(pd);
+		}
+	}
+}
+
+static const struct of_device_id scpsys_of_match[] = {
+	{
+		.compatible = "mediatek,mt8173-power-controller",
+		.data = &mt8173_scpsys_data,
+	},
+	{ }
+};
+
+static int scpsys_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct scpsys_soc_data *soc;
+	struct device_node *node;
+	struct device *parent;
+	struct scpsys *scpsys;
+	int ret;
+
+	soc = of_device_get_match_data(&pdev->dev);
+	if (!soc) {
+		dev_err(&pdev->dev, "no power controller data\n");
+		return -EINVAL;
+	}
+
+	scpsys = devm_kzalloc(dev, struct_size(scpsys, domains, soc->num_domains), GFP_KERNEL);
+	if (!scpsys)
+		return -ENOMEM;
+
+	scpsys->dev = dev;
+	scpsys->soc_data = soc;
+
+	scpsys->pd_data.domains = scpsys->domains;
+	scpsys->pd_data.num_domains = soc->num_domains;
+
+	parent = dev->parent;
+	if (!parent) {
+		dev_err(dev, "no parent for syscon devices\n");
+		return -ENODEV;
+	}
+
+	scpsys->base = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR(scpsys->base)) {
+		dev_err(dev, "no regmap available\n");
+		return PTR_ERR(scpsys->base);
+	}
+
+	ret = -ENODEV;
+	for_each_available_child_of_node(np, node) {
+		struct generic_pm_domain *domain;
+
+		domain = scpsys_add_one_domain(scpsys, node);
+		if (IS_ERR(domain)) {
+			ret = PTR_ERR(domain);
+			of_node_put(node);
+			goto err_cleanup_domains;
+		}
+
+		ret = scpsys_add_subdomain(scpsys, node);
+		if (ret) {
+			of_node_put(node);
+			goto err_cleanup_domains;
+		}
+	}
+
+	if (ret) {
+		dev_dbg(dev, "no power domains present\n");
+		return ret;
+	}
+
+	ret = of_genpd_add_provider_onecell(np, &scpsys->pd_data);
+	if (ret) {
+		dev_err(dev, "failed to add provider: %d\n", ret);
+		goto err_cleanup_domains;
+	}
+
+	return 0;
+
+err_cleanup_domains:
+	scpsys_domain_cleanup(scpsys);
+	return ret;
+}
+
+static struct platform_driver scpsys_pm_domain_driver = {
+	.probe = scpsys_probe,
+	.driver = {
+		.name = "mtk-power-controller",
+		.suppress_bind_attrs = true,
+		.of_match_table = scpsys_of_match,
+	},
+};
+builtin_platform_driver(scpsys_pm_domain_driver);
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
new file mode 100644
index 000000000000..7c8efcb3cef2
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MTK_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MTK_PM_DOMAINS_H
+
+#define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
+#define MTK_SCPD_FWAIT_SRAM		BIT(1)
+#define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
+
+#define SPM_VDE_PWR_CON			0x0210
+#define SPM_MFG_PWR_CON			0x0214
+#define SPM_VEN_PWR_CON			0x0230
+#define SPM_ISP_PWR_CON			0x0238
+#define SPM_DIS_PWR_CON			0x023c
+#define SPM_VEN2_PWR_CON		0x0298
+#define SPM_AUDIO_PWR_CON		0x029c
+#define SPM_MFG_2D_PWR_CON		0x02c0
+#define SPM_MFG_ASYNC_PWR_CON		0x02c4
+#define SPM_USB_PWR_CON			0x02cc
+
+#define SPM_PWR_STATUS			0x060c
+#define SPM_PWR_STATUS_2ND		0x0610
+
+#define PWR_STATUS_DISP			BIT(3)
+#define PWR_STATUS_MFG			BIT(4)
+#define PWR_STATUS_ISP			BIT(5)
+#define PWR_STATUS_VDEC			BIT(7)
+#define PWR_STATUS_VENC_LT		BIT(20)
+#define PWR_STATUS_VENC			BIT(21)
+#define PWR_STATUS_MFG_2D		BIT(22)
+#define PWR_STATUS_MFG_ASYNC		BIT(23)
+#define PWR_STATUS_AUDIO		BIT(24)
+#define PWR_STATUS_USB			BIT(25)
+
+struct scpsys_bus_prot_data {
+	u32 bus_prot_mask;
+	bool bus_prot_reg_update;
+};
+
+/**
+ * struct scpsys_domain_data - scp domain data for power on/off flow
+ * @sta_mask: The mask for power on/off status bit.
+ * @ctl_offs: The offset for main power control register.
+ * @sram_pdn_bits: The mask for sram power control bits.
+ * @sram_pdn_ack_bits: The mask for sram power control acked bits.
+ * @caps: The flag for active wake-up action.
+ * @bp_infracfg: bus protection for infracfg subsystem
+ */
+struct scpsys_domain_data {
+	u32 sta_mask;
+	int ctl_offs;
+	u32 sram_pdn_bits;
+	u32 sram_pdn_ack_bits;
+	u8 caps;
+	const struct scpsys_bus_prot_data bp_infracfg;
+};
+
+struct scpsys_soc_data {
+	const struct scpsys_domain_data *domains;
+	int num_domains;
+	int pwr_sta_offs;
+	int pwr_sta2nd_offs;
+};
+
+#endif /* __SOC_MEDIATEK_MTK_PM_DOMAINS_H */
-- 
2.28.0


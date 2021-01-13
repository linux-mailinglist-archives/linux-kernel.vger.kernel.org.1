Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EB32F4F70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbhAMQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbhAMQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:02:19 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF5C0617A5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:01:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x23so3111424lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk89QtY9XlOJ4lSbFodbDfjmlfoZzf3XCi+vMFHgHok=;
        b=Qm+ezvQ7s08d9MpJdq4Y3FKAMzw6lp513zYHOAe6axP4DV9m2sJUuHqT4pfk9XQUMa
         jRgATKLWv82AyTUDo2RMJCJh9NUrohx/iTPHjPBVe63V7w2Gl3QR019VlXxjjoAvHHjl
         WwY3VVh7ag2qaUrOVO9KQHIFrCmcR+v9qF/2iOBRHpeydKsNblfG011IWkBtm7x5Sup3
         5zuYBpIvyZayisuXgbUvKXhRH299qQdfhX/83J7/RbLxc7yKgiCM7CDS92Ki6CAIDMQ0
         VTLVuHrfqLQKEBmvTTLjgl3xgVrhEAImyOtiQkxW7iFtwqXYnFvuo7FQ4suFvIXHglh9
         bkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk89QtY9XlOJ4lSbFodbDfjmlfoZzf3XCi+vMFHgHok=;
        b=UevLw1ixPrGH5bwv0TMnXo5G9B0oZXNnPg4K7Zh0CpVTULnmm0iOtjVroU4ShXEQdw
         rsYK9pk4dfH7HDYbs52coyh4e9vY+eZbWfRTP/k3cm2DiFvd72k7JUMBJ6VJyKCLeew8
         RH2NRG7zj5QsgR/38Dr+ndVgPAOH//n09Dexohqr3UhiWYhNNNcO/44lrUg4Tgkyg6pU
         D5bylgCoa4tOqzzcvzWVym9lp9wtpyEbZsF/tSuN9U3CHv4LfZPvZEDEfrEWwDExiscH
         AERY/erlGM47bVUOQ+SjE6UgWl2krGtQLfKjusrdvyYzq0G2hG5ZmDheJI1M9V4dfH1d
         vO6A==
X-Gm-Message-State: AOAM532qO+yfEM48hkaKsRkrdPDyUDNZJl9AZaLhUHYmGQwPYHKZrN/1
        ugR7GcLnfQIk4jsKhffuQeEDXg==
X-Google-Smtp-Source: ABdhPJw2vvlK8lnsVND9AAEYRqTeYKz+L8Y4KXyNFcwcvGaPqogUWOPcS06L1wJVjedQ+HMKTSEp2w==
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr1254872ljj.380.1610553660262;
        Wed, 13 Jan 2021 08:01:00 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.189])
        by smtp.gmail.com with ESMTPSA id m25sm248559lfb.144.2021.01.13.08.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:00:59 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] misc: qca639x: add support for QCA639x powerup sequence
Date:   Wed, 13 Jan 2021 19:00:53 +0300
Message-Id: <20210113160053.3974229-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113160053.3974229-1-dmitry.baryshkov@linaro.org>
References: <20210113160053.3974229-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm QCA639x is a family of WiFi + Bluetooth SoCs, with BT part
being controlled through the UART and WiFi being present on PCIe
bus. Both blocks share common power sources. Add device driver handling
power sequencing of QCA6390/1.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/misc/Kconfig        |  12 +++
 drivers/misc/Makefile       |   1 +
 drivers/misc/qcom-qca639x.c | 164 ++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/misc/qcom-qca639x.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e90c2524e46c..a14f67ab476c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -255,6 +255,18 @@ config QCOM_FASTRPC
 	  applications DSP processor. Say M if you want to enable this
 	  module.
 
+config QCOM_QCA639X
+	tristate "Qualcomm QCA639x WiFi/Bluetooth module support"
+	depends on REGULATOR && PM_GENERIC_DOMAINS
+	help
+	  If you say yes to this option, support will be included for Qualcomm
+	  QCA639x family of WiFi and Bluetooth SoCs. Note, this driver supports
+	  only power control for this SoC, you still have to enable individual
+	  Bluetooth and WiFi drivers.
+
+	  Say M here if you want to include support for QCA639x chips as a
+	  module. This will build a module called "qcom-qca639x".
+
 config SGI_GRU
 	tristate "SGI GRU driver"
 	depends on X86_UV && SMP
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index f65e8b18ecd8..bf21d5b1189f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
 obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
 obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
+obj-$(CONFIG_QCOM_QCA639X)	+= qcom-qca639x.o
 obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
 obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
 obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
diff --git a/drivers/misc/qcom-qca639x.c b/drivers/misc/qcom-qca639x.c
new file mode 100644
index 000000000000..b34e08ff4a88
--- /dev/null
+++ b/drivers/misc/qcom-qca639x.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, Linaro Limited
+ */
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/devinfo.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#define MAX_NUM_REGULATORS	8
+
+static struct vreg {
+	const char *name;
+	unsigned int load_uA;
+} vregs[MAX_NUM_REGULATORS] = {
+	/* 2.0 V */
+	{ "vddpcie2", 15000 },
+	{ "vddrfa3", 400000 },
+
+	/* 0.95 V */
+	{ "vddaon", 100000 },
+	{ "vddpmu", 1250000 },
+	{ "vddrfa1", 200000 },
+
+	/* 1.35 V */
+	{ "vddrfa2", 400000 },
+	{ "vddpcie1", 35000 },
+
+	/* 1.8 V */
+	{ "vddio", 20000 },
+};
+
+struct qca639x_data {
+	struct regulator_bulk_data regulators[MAX_NUM_REGULATORS];
+	size_t num_vregs;
+	struct device *dev;
+	struct pinctrl_state *active_state;
+	struct generic_pm_domain pd;
+};
+
+#define domain_to_data(domain) container_of(domain, struct qca639x_data, pd)
+
+static int qca639x_power_on(struct generic_pm_domain *domain)
+{
+	struct qca639x_data *data = domain_to_data(domain);
+	int ret;
+
+	ret = regulator_bulk_enable(data->num_vregs, data->regulators);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable regulators");
+		return ret;
+	}
+
+	/* Wait for 1ms before toggling enable pins. */
+	usleep_range(1000, 2000);
+
+	ret = pinctrl_select_state(data->dev->pins->p, data->active_state);
+	if (ret) {
+		dev_err(data->dev, "Failed to select active state");
+		return ret;
+	}
+
+	/* Wait for all power levels to stabilize */
+	usleep_range(6000, 7000);
+
+	return 0;
+}
+
+static int qca639x_power_off(struct generic_pm_domain *domain)
+{
+	struct qca639x_data *data = domain_to_data(domain);
+
+	pinctrl_select_default_state(data->dev);
+	regulator_bulk_disable(data->num_vregs, data->regulators);
+
+	return 0;
+}
+
+static int qca639x_probe(struct platform_device *pdev)
+{
+	struct qca639x_data *data;
+	struct device *dev = &pdev->dev;
+	int i, ret;
+
+	if (!dev->pins || IS_ERR_OR_NULL(dev->pins->default_state))
+		return -EINVAL;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	data->num_vregs = ARRAY_SIZE(vregs);
+
+	data->active_state = pinctrl_lookup_state(dev->pins->p, "active");
+	if (IS_ERR(data->active_state)) {
+		ret = PTR_ERR(data->active_state);
+		dev_err(dev, "Failed to get active_state: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < data->num_vregs; i++)
+		data->regulators[i].supply = vregs[i].name;
+	ret = devm_regulator_bulk_get(dev, data->num_vregs, data->regulators);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < data->num_vregs; i++) {
+		ret = regulator_set_load(data->regulators[i].consumer, vregs[i].load_uA);
+		if (ret)
+			return ret;
+	}
+
+	data->pd.name = dev_name(dev);
+	data->pd.power_on = qca639x_power_on;
+	data->pd.power_off = qca639x_power_off;
+
+	ret = pm_genpd_init(&data->pd, NULL, true);
+	if (ret < 0)
+		return ret;
+
+	ret = of_genpd_add_provider_simple(dev->of_node, &data->pd);
+	if (ret < 0) {
+		pm_genpd_remove(&data->pd);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static int qca639x_remove(struct platform_device *pdev)
+{
+	struct qca639x_data *data = platform_get_drvdata(pdev);
+
+	pm_genpd_remove(&data->pd);
+
+	return 0;
+}
+
+static const struct of_device_id qca639x_of_match[] = {
+	{ .compatible = "qcom,qca6390" },
+};
+
+static struct platform_driver qca639x_driver = {
+	.probe = qca639x_probe,
+	.remove = qca639x_remove,
+	.driver = {
+		.name = "qca639x",
+		.of_match_table = qca639x_of_match,
+	},
+};
+
+module_platform_driver(qca639x_driver);
+MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
+MODULE_DESCRIPTION("Power control for Qualcomm QCA639x BT/WiFi chip");
+MODULE_LICENSE("GPL v2");
-- 
2.29.2


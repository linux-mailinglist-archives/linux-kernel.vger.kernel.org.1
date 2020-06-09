Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5671F35A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 10:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgFIIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 04:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgFIIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:01:15 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A21FC05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 01:01:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n23so9929552pgb.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2MF0f3JcIgm9etfzgKHTh+/3m6Mi8vFuXrQT0uKz6Q=;
        b=D9bE8atfFKtykXQIUHoAgqm8kIcLe3HET3XA/i1yNNrjiytPO6DH3fc2OmiznvaB6i
         j28JMmUo3dyx/+PWiQN1DybfUiTtiQFDthF7Lm2ZrkNQ8EgB6hV/Fju1+0i/mS7zb0ox
         YquiqlLkLyV2Szzd+bbAmOtrgv5Cm7ZFp7qzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2MF0f3JcIgm9etfzgKHTh+/3m6Mi8vFuXrQT0uKz6Q=;
        b=evbbcABGWNH0kJtuG/O/kDGYSSj8qBOGDli2pakha0TqlCCmUNy/3QqeI+wqDw3Uj3
         764gzfooRgsBmBTSJVat4Yq+1xOXnhGvzH9AAPXLOdQfOJX/8aBmnNl8BT1p5rdl0SSZ
         YPGmle7AcCIGJx6Kli6zhisUxNaRzousR0NHitJtsrpALJhNwuTg0BP5vzL+YLeW3Q5C
         MBUHMmSnpKbP9IKd6HY4eSFxpi3nxCnFO6KULWXVhKatl2+HgIfvoZerrPHRu4lNQYCt
         3ZMZLxDYhH+6WwdwAl4k3W3O1ODV3DrGK8BX7eTS5qlINxk8i9niHYXtwxVNtV06+NkD
         egHA==
X-Gm-Message-State: AOAM533qMAaBblKbu+0qzg1tpPzFLf8cNq3Y761FQ9/ON6wvQCDRhJMT
        BA3nzwPgJvRviqfEIhrAfKPljA==
X-Google-Smtp-Source: ABdhPJwNiV5bqBZmIpz1RBil2ov81aYX0LDu67lQnDw+fU3Lm/L7Xw4uP6LhFMYlE6USFNpPzulEbg==
X-Received: by 2002:a62:7e95:: with SMTP id z143mr24495097pfc.108.1591689674375;
        Tue, 09 Jun 2020 01:01:14 -0700 (PDT)
Received: from pihsun-glaptop.lan (180-176-97-18.dynamic.kbronet.com.tw. [180.176.97.18])
        by smtp.googlemail.com with ESMTPSA id gt22sm2506252pjb.2.2020.06.09.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 01:01:13 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] regulator: Add driver for cros-ec-regulator
Date:   Tue,  9 Jun 2020 15:59:55 +0800
Message-Id: <20200609080001.121499-3-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200609080001.121499-1-pihsun@chromium.org>
References: <20200609080001.121499-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for cros-ec-regulator, representing a voltage regulator that
is connected and controlled by ChromeOS EC, and is controlled by kernel
with EC host commands.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
This patch contains function cros_ec_cmd that is copied from the series:
https://lore.kernel.org/patchwork/project/lkml/list/?series=428457.

I can't find the first patch in that v2 series, so the function is
modified from v1 of that series according to reviewers comment:
https://lore.kernel.org/patchwork/patch/1188110/

I copied the function instead of depending on that series since I feel
the function is small enough, and the series has stalled for some time.
---
 drivers/regulator/Kconfig                     |   7 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/cros-ec-regulator.c         | 261 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  82 ++++++
 4 files changed, 351 insertions(+)
 create mode 100644 drivers/regulator/cros-ec-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8f677f5d79b4..3543e0fc54ca 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -238,6 +238,13 @@ config REGULATOR_CPCAP
 	  Say y here for CPCAP regulator found on some Motorola phones
 	  and tablets such as Droid 4.
 
+config REGULATOR_CROS_EC
+	tristate "ChromeOS EC regulators"
+	depends on CROS_EC
+	help
+	  This driver supports voltage regulators that is connected to ChromeOS
+	  EC and controlled through EC host commands.
+
 config REGULATOR_DA903X
 	tristate "Dialog Semiconductor DA9030/DA9034 regulators"
 	depends on PMIC_DA903X
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index e8f163371071..46592c160d22 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
 obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
+obj-$(CONFIG_REGULATOR_CROS_EC) += cros-ec-regulator.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
 obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
new file mode 100644
index 000000000000..495006f6381c
--- /dev/null
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2020 Google LLC.
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
+
+struct cros_ec_regulator_data {
+	struct regulator_desc desc;
+	struct regulator_dev *dev;
+	struct cros_ec_device *ec_dev;
+
+	u32 index;
+
+	u16 *voltages_mV;
+	u16 num_voltages;
+};
+
+static int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
+		       void *outdata, u32 outsize, void *indata, u32 insize)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = version;
+	msg->command = command;
+	msg->outsize = outsize;
+	msg->insize = insize;
+
+	if (outdata && outsize > 0)
+		memcpy(msg->data, outdata, outsize);
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	if (ret < 0) {
+		dev_warn(ec->dev, "Command failed: %d\n", msg->result);
+		goto cleanup;
+	}
+
+	if (insize)
+		memcpy(indata, msg->data, insize);
+
+cleanup:
+	kfree(msg);
+	return ret;
+}
+
+static int cros_ec_regulator_set_state(struct regulator_dev *dev, bool enable)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	struct ec_params_regulator_enable cmd = {
+		.index = data->index,
+		.enable = enable ? 1 : 0,
+	};
+
+	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
+			  sizeof(cmd), NULL, 0);
+}
+
+static int cros_ec_regulator_enable(struct regulator_dev *dev)
+{
+	return cros_ec_regulator_set_state(dev, true);
+}
+
+static int cros_ec_regulator_disable(struct regulator_dev *dev)
+{
+	return cros_ec_regulator_set_state(dev, false);
+}
+
+static int cros_ec_regulator_is_enabled(struct regulator_dev *dev)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	struct ec_params_regulator_is_enabled cmd = {
+		.index = data->index,
+	};
+	struct ec_response_regulator_is_enabled resp;
+	int ret;
+
+	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_IS_ENABLED, &cmd,
+			  sizeof(cmd), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+	return resp.enabled;
+}
+
+static int cros_ec_regulator_list_voltage(struct regulator_dev *dev,
+					  unsigned int selector)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+
+	if (selector >= data->num_voltages)
+		return -EINVAL;
+
+	return data->voltages_mV[selector] * 1000;
+}
+
+static int cros_ec_regulator_get_voltage(struct regulator_dev *dev)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	struct ec_params_regulator_get_voltage cmd = {
+		.index = data->index,
+	};
+	struct ec_response_regulator_get_voltage resp;
+	int ret;
+
+	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_VOLTAGE, &cmd,
+			  sizeof(cmd), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+	return resp.voltage_mv * 1000;
+}
+
+static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
+					 int max_uV, unsigned int *selector)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	int min_mV = DIV_ROUND_UP(min_uV, 1000);
+	int max_mV = max_uV / 1000;
+	struct ec_params_regulator_set_voltage cmd = {
+		.index = data->index,
+		.min_mv = min_mV,
+		.max_mv = max_mV,
+	};
+
+	if (min_mV > max_mV)
+		return -EINVAL;
+	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_SET_VOLTAGE, &cmd,
+			   sizeof(cmd), NULL, 0);
+}
+
+static struct regulator_ops cros_ec_regulator_voltage_ops = {
+	.enable = cros_ec_regulator_enable,
+	.disable = cros_ec_regulator_disable,
+	.is_enabled = cros_ec_regulator_is_enabled,
+	.list_voltage = cros_ec_regulator_list_voltage,
+	.get_voltage = cros_ec_regulator_get_voltage,
+	.set_voltage = cros_ec_regulator_set_voltage,
+};
+
+static int cros_ec_regulator_init_info(struct device *dev,
+				       struct cros_ec_regulator_data *data)
+{
+	struct ec_params_regulator_get_info cmd = {
+		.index = data->index,
+	};
+	struct ec_response_regulator_get_info resp;
+	int ret;
+
+	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_INFO, &cmd,
+			   sizeof(cmd), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	data->num_voltages =
+		min_t(u16, ARRAY_SIZE(resp.voltages_mv), resp.num_voltages);
+	data->voltages_mV =
+		devm_kmemdup(dev, resp.voltages_mv,
+			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
+	data->desc.n_voltages = data->num_voltages;
+	data->desc.name = kstrndup(resp.name, sizeof(resp.name), GFP_KERNEL);
+	if (!data->desc.name)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int cros_ec_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct cros_ec_regulator_data *drvdata;
+	struct regulator_init_data *init_data;
+	struct regulator_config cfg = {};
+	struct regulator_desc *desc;
+	int ret;
+
+	drvdata = devm_kzalloc(
+		&pdev->dev, sizeof(struct cros_ec_regulator_data), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->ec_dev = dev_get_drvdata(dev->parent);
+	desc = &drvdata->desc;
+
+	init_data = of_get_regulator_init_data(dev, np, desc);
+	if (!init_data)
+		return -EINVAL;
+
+	ret = of_property_read_u32(np, "google,remote-regulator",
+				   &drvdata->index);
+	if (ret < 0)
+		return ret;
+
+	desc->owner = THIS_MODULE;
+	desc->type = REGULATOR_VOLTAGE;
+	desc->ops = &cros_ec_regulator_voltage_ops;
+
+	ret = cros_ec_regulator_init_info(dev, drvdata);
+	if (ret < 0)
+		return ret;
+
+	cfg.dev = &pdev->dev;
+	cfg.init_data = init_data;
+	cfg.driver_data = drvdata;
+	cfg.of_node = np;
+
+	drvdata->dev = regulator_register(&drvdata->desc, &cfg);
+	if (IS_ERR(drvdata->dev)) {
+		ret = PTR_ERR(drvdata->dev);
+		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
+		goto free_name;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+
+	return 0;
+
+free_name:
+	kfree(desc->name);
+	return ret;
+}
+
+static int cros_ec_regulator_remove(struct platform_device *pdev)
+{
+	struct cros_ec_regulator_data *drvdata = platform_get_drvdata(pdev);
+
+	kfree(drvdata->desc.name);
+
+	return 0;
+}
+
+#if defined(CONFIG_OF)
+static const struct of_device_id regulator_cros_ec_of_match[] = {
+	{ .compatible = "regulator-cros-ec", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, regulator_cros_ec_of_match);
+#endif
+
+static struct platform_driver cros_ec_regulator_driver = {
+	.probe		= cros_ec_regulator_probe,
+	.remove		= cros_ec_regulator_remove,
+	.driver		= {
+		.name		= "cros-ec-regulator",
+		.of_match_table = of_match_ptr(regulator_cros_ec_of_match),
+	},
+};
+
+module_platform_driver(cros_ec_regulator_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ChromeOS EC controlled regulator");
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 69210881ebac..a417b51b5764 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -5430,6 +5430,88 @@ struct ec_response_rollback_info {
 /* Issue AP reset */
 #define EC_CMD_AP_RESET 0x0125
 
+/*****************************************************************************/
+/* Voltage regulator controls */
+
+/*
+ * Get basic info of voltage regulator for given index.
+ *
+ * Returns the regulator name and supported voltage list in mV.
+ */
+#define EC_CMD_REGULATOR_GET_INFO 0x012B
+
+/* Maximum length of regulator name */
+#define EC_REGULATOR_NAME_MAX_LEN 16
+
+/* Maximum length of the supported voltage list. */
+#define EC_REGULATOR_VOLTAGE_MAX_COUNT 16
+
+struct ec_params_regulator_get_info {
+	uint32_t index;
+} __ec_align4;
+
+struct ec_response_regulator_get_info {
+	char name[EC_REGULATOR_NAME_MAX_LEN];
+	uint16_t num_voltages;
+	uint16_t voltages_mv[EC_REGULATOR_VOLTAGE_MAX_COUNT];
+} __ec_align1;
+
+/*
+ * Configure the regulator as enabled / disabled.
+ */
+#define EC_CMD_REGULATOR_ENABLE 0x012C
+
+struct ec_params_regulator_enable {
+	uint32_t index;
+	uint8_t enable;
+} __ec_align4;
+
+/*
+ * Query if the regulator is enabled.
+ *
+ * Returns 1 if the regulator is enabled, 0 if not.
+ */
+#define EC_CMD_REGULATOR_IS_ENABLED 0x012D
+
+struct ec_params_regulator_is_enabled {
+	uint32_t index;
+} __ec_align4;
+
+struct ec_response_regulator_is_enabled {
+	uint8_t enabled;
+} __ec_align1;
+
+/*
+ * Set voltage for the voltage regulator within the range specified.
+ *
+ * The driver should select the voltage in range closest to min_mv.
+ *
+ * Also note that this might be called before the regulator is enabled, and the
+ * setting should be in effect after the regulator is enabled.
+ */
+#define EC_CMD_REGULATOR_SET_VOLTAGE 0x012E
+
+struct ec_params_regulator_set_voltage {
+	uint32_t index;
+	uint32_t min_mv;
+	uint32_t max_mv;
+} __ec_align4;
+
+/*
+ * Get the currently configured voltage for the voltage regulator.
+ *
+ * Note that this might be called before the regulator is enabled.
+ */
+#define EC_CMD_REGULATOR_GET_VOLTAGE 0x012F
+
+struct ec_params_regulator_get_voltage {
+	uint32_t index;
+} __ec_align4;
+
+struct ec_response_regulator_get_voltage {
+	uint32_t voltage_mv;
+} __ec_align4;
+
 /*****************************************************************************/
 /* The command range 0x200-0x2FF is reserved for Rotor. */
 
-- 
2.27.0.278.ge193c7cf3a9-goog


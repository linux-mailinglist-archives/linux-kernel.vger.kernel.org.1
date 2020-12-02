Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5902CC824
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389210AbgLBUnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:43:03 -0500
Received: from foss.arm.com ([217.140.110.172]:50646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388531AbgLBUmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90AE31597;
        Wed,  2 Dec 2020 12:41:26 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF1F3F575;
        Wed,  2 Dec 2020 12:41:24 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 29/37] regulator: scmi: port driver to the new scmi_voltage_proto_ops interface
Date:   Wed,  2 Dec 2020 20:40:01 +0000
Message-Id: <20201202204009.32073-30-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port driver to the new SCMI Voltage interface based on protocol handles
and common devm_get_ops().

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/regulator/scmi-regulator.c | 39 ++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 0e8b3caa8146..4689937ebbfa 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -33,9 +33,12 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+static const struct scmi_voltage_proto_ops *voltage_ops;
+
 struct scmi_regulator {
 	u32 id;
 	struct scmi_device *sdev;
+	struct scmi_protocol_handle *ph;
 	struct regulator_dev *rdev;
 	struct device_node *of_node;
 	struct regulator_desc desc;
@@ -50,19 +53,17 @@ struct scmi_regulator_info {
 static int scmi_reg_enable(struct regulator_dev *rdev)
 {
 	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
-	const struct scmi_handle *handle = sreg->sdev->handle;
 
-	return handle->voltage_ops->config_set(handle, sreg->id,
-					       SCMI_VOLTAGE_ARCH_STATE_ON);
+	return voltage_ops->config_set(sreg->ph, sreg->id,
+				       SCMI_VOLTAGE_ARCH_STATE_ON);
 }
 
 static int scmi_reg_disable(struct regulator_dev *rdev)
 {
 	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
-	const struct scmi_handle *handle = sreg->sdev->handle;
 
-	return handle->voltage_ops->config_set(handle, sreg->id,
-					       SCMI_VOLTAGE_ARCH_STATE_OFF);
+	return voltage_ops->config_set(sreg->ph, sreg->id,
+				       SCMI_VOLTAGE_ARCH_STATE_OFF);
 }
 
 static int scmi_reg_is_enabled(struct regulator_dev *rdev)
@@ -70,10 +71,8 @@ static int scmi_reg_is_enabled(struct regulator_dev *rdev)
 	int ret;
 	u32 config;
 	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
-	const struct scmi_handle *handle = sreg->sdev->handle;
 
-	ret = handle->voltage_ops->config_get(handle, sreg->id,
-					      &config);
+	ret = voltage_ops->config_get(sreg->ph, sreg->id, &config);
 	if (ret) {
 		dev_err(&sreg->sdev->dev,
 			"Error %d reading regulator %s status.\n",
@@ -89,9 +88,8 @@ static int scmi_reg_get_voltage_sel(struct regulator_dev *rdev)
 	int ret;
 	s32 volt_uV;
 	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
-	const struct scmi_handle *handle = sreg->sdev->handle;
 
-	ret = handle->voltage_ops->level_get(handle, sreg->id, &volt_uV);
+	ret = voltage_ops->level_get(sreg->ph, sreg->id, &volt_uV);
 	if (ret)
 		return ret;
 
@@ -103,13 +101,12 @@ static int scmi_reg_set_voltage_sel(struct regulator_dev *rdev,
 {
 	s32 volt_uV;
 	struct scmi_regulator *sreg = rdev_get_drvdata(rdev);
-	const struct scmi_handle *handle = sreg->sdev->handle;
 
 	volt_uV = sreg->desc.ops->list_voltage(rdev, selector);
 	if (volt_uV <= 0)
 		return -EINVAL;
 
-	return handle->voltage_ops->level_set(handle, sreg->id, 0x0, volt_uV);
+	return voltage_ops->level_set(sreg->ph, sreg->id, 0x0, volt_uV);
 }
 
 static const struct regulator_ops scmi_reg_fixed_ops = {
@@ -204,11 +201,10 @@ scmi_config_discrete_regulator_mappings(struct scmi_regulator *sreg,
 static int scmi_regulator_common_init(struct scmi_regulator *sreg)
 {
 	int ret;
-	const struct scmi_handle *handle = sreg->sdev->handle;
 	struct device *dev = &sreg->sdev->dev;
 	const struct scmi_voltage_info *vinfo;
 
-	vinfo = handle->voltage_ops->info_get(handle, sreg->id);
+	vinfo = voltage_ops->info_get(sreg->ph, sreg->id);
 	if (!vinfo) {
 		dev_warn(dev, "Failure to get voltage domain %d\n",
 			 sreg->id);
@@ -257,6 +253,7 @@ static int scmi_regulator_common_init(struct scmi_regulator *sreg)
 }
 
 static int process_scmi_regulator_of_node(struct scmi_device *sdev,
+					  struct scmi_protocol_handle *ph,
 					  struct device_node *np,
 					  struct scmi_regulator_info *rinfo)
 {
@@ -284,6 +281,7 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 
 	rinfo->sregv[dom]->id = dom;
 	rinfo->sregv[dom]->sdev = sdev;
+	rinfo->sregv[dom]->ph = ph;
 
 	/* get hold of good nodes */
 	of_node_get(np);
@@ -302,11 +300,16 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	struct device_node *np, *child;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_regulator_info *rinfo;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->voltage_ops)
+	if (!handle)
 		return -ENODEV;
 
-	num_doms = handle->voltage_ops->num_domains_get(handle);
+	voltage_ops = handle->devm_get_ops(sdev, SCMI_PROTOCOL_VOLTAGE, &ph);
+	if (IS_ERR(voltage_ops))
+		return PTR_ERR(voltage_ops);
+
+	num_doms = voltage_ops->num_domains_get(ph);
 	if (num_doms <= 0) {
 		if (!num_doms) {
 			dev_err(&sdev->dev,
@@ -341,7 +344,7 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	 */
 	np = of_find_node_by_name(handle->dev->of_node, "regulators");
 	for_each_child_of_node(np, child) {
-		ret = process_scmi_regulator_of_node(sdev, child, rinfo);
+		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
 		if (ret == -ENOMEM)
 			return ret;
-- 
2.17.1


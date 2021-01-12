Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E6E2F3A13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436797AbhALTXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:23:18 -0500
Received: from foss.arm.com ([217.140.110.172]:52236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436785AbhALTXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:23:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BF8F1500;
        Tue, 12 Jan 2021 11:21:31 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D9ED3F66E;
        Tue, 12 Jan 2021 11:21:29 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v5 15/36] firmware: arm_scmi: port GenPD driver to the new scmi_power_proto_ops interface
Date:   Tue, 12 Jan 2021 19:19:57 +0000
Message-Id: <20210112192018.34994-16-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112192018.34994-1-cristian.marussi@arm.com>
References: <20210112192018.34994-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port driver to the new SCMI Power interface based on protocol handles
and common devm_get_ops().

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v4 --> v5
- using renamed devm_get/put_protocol
---
 drivers/firmware/arm_scmi/scmi_pm_domain.c | 26 +++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index 9e44479f0284..b85141e7e6bc 100644
--- a/drivers/firmware/arm_scmi/scmi_pm_domain.c
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -2,7 +2,7 @@
 /*
  * SCMI Generic power domain support.
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #include <linux/err.h>
@@ -11,9 +11,11 @@
 #include <linux/pm_domain.h>
 #include <linux/scmi_protocol.h>
 
+static const struct scmi_power_proto_ops *power_ops;
+
 struct scmi_pm_domain {
 	struct generic_pm_domain genpd;
-	const struct scmi_handle *handle;
+	const struct scmi_protocol_handle *ph;
 	const char *name;
 	u32 domain;
 };
@@ -25,16 +27,15 @@ static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
 	int ret;
 	u32 state, ret_state;
 	struct scmi_pm_domain *pd = to_scmi_pd(domain);
-	const struct scmi_power_ops *ops = pd->handle->power_ops;
 
 	if (power_on)
 		state = SCMI_POWER_STATE_GENERIC_ON;
 	else
 		state = SCMI_POWER_STATE_GENERIC_OFF;
 
-	ret = ops->state_set(pd->handle, pd->domain, state);
+	ret = power_ops->state_set(pd->ph, pd->domain, state);
 	if (!ret)
-		ret = ops->state_get(pd->handle, pd->domain, &ret_state);
+		ret = power_ops->state_get(pd->ph, pd->domain, &ret_state);
 	if (!ret && state != ret_state)
 		return -EIO;
 
@@ -60,11 +61,16 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 	struct genpd_onecell_data *scmi_pd_data;
 	struct generic_pm_domain **domains;
 	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->power_ops)
+	if (!handle)
 		return -ENODEV;
 
-	num_domains = handle->power_ops->num_domains_get(handle);
+	power_ops = handle->devm_get_protocol(sdev, SCMI_PROTOCOL_POWER, &ph);
+	if (IS_ERR(power_ops))
+		return PTR_ERR(power_ops);
+
+	num_domains = power_ops->num_domains_get(ph);
 	if (num_domains < 0) {
 		dev_err(dev, "number of domains not found\n");
 		return num_domains;
@@ -85,14 +91,14 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 	for (i = 0; i < num_domains; i++, scmi_pd++) {
 		u32 state;
 
-		if (handle->power_ops->state_get(handle, i, &state)) {
+		if (power_ops->state_get(ph, i, &state)) {
 			dev_warn(dev, "failed to get state for domain %d\n", i);
 			continue;
 		}
 
 		scmi_pd->domain = i;
-		scmi_pd->handle = handle;
-		scmi_pd->name = handle->power_ops->name_get(handle, i);
+		scmi_pd->ph = ph;
+		scmi_pd->name = power_ops->name_get(ph, i);
 		scmi_pd->genpd.name = scmi_pd->name;
 		scmi_pd->genpd.power_off = scmi_pd_power_off;
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
-- 
2.17.1


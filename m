Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBE2CC81E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgLBUms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:48 -0500
Received: from foss.arm.com ([217.140.110.172]:50620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388428AbgLBUmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 293BE153B;
        Wed,  2 Dec 2020 12:41:06 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CC323F575;
        Wed,  2 Dec 2020 12:41:04 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 20/37] firmware: arm_scmi: remove legacy scmi_clk_ops protocol interface
Date:   Wed,  2 Dec 2020 20:39:52 +0000
Message-Id: <20201202204009.32073-21-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the SCMI driver users have been migrated to the new interface
remove the legacy interface and all the transient code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 67 -------------------------------
 include/linux/scmi_protocol.h     | 15 -------
 2 files changed, 82 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index bf7dcd537fce..a0a6593f464f 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -235,16 +235,6 @@ scmi_clock_rate_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int
-__scmi_clock_rate_get(const struct scmi_handle *handle,
-		      u32 clk_id, u64 *value)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
-
-	return scmi_clock_rate_get(ph, clk_id, value);
-}
-
 static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 			       u32 clk_id, u64 rate)
 {
@@ -280,15 +270,6 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_clock_rate_set(const struct scmi_handle *handle,
-				 u32 clk_id, u64 rate)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
-
-	return scmi_clock_rate_set(ph, clk_id, rate);
-}
-
 static int
 scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
 		      u32 config)
@@ -317,27 +298,11 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id)
 	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE);
 }
 
-static int __scmi_clock_enable(const struct scmi_handle *handle, u32 clk_id)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
-
-	return scmi_clock_enable(ph, clk_id);
-}
-
 static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
 	return scmi_clock_config_set(ph, clk_id, 0);
 }
 
-static int __scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
-
-	return scmi_clock_disable(ph, clk_id);
-}
-
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 {
 	struct clock_info *ci = ph->get_priv(ph);
@@ -345,14 +310,6 @@ static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 	return ci->num_clocks;
 }
 
-static int __scmi_clock_count_get(const struct scmi_handle *handle)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
-
-	return scmi_clock_count_get(ph);
-}
-
 static const struct scmi_clock_info *
 scmi_clock_info_get(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
@@ -365,24 +322,6 @@ scmi_clock_info_get(const struct scmi_protocol_handle *ph, u32 clk_id)
 	return clk;
 }
 
-static const struct scmi_clock_info *
-__scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_CLOCK);
-
-	return scmi_clock_info_get(ph, clk_id);
-}
-
-static const struct scmi_clk_ops clk_ops = {
-	.count_get = __scmi_clock_count_get,
-	.info_get = __scmi_clock_info_get,
-	.rate_get = __scmi_clock_rate_get,
-	.rate_set = __scmi_clock_rate_set,
-	.enable = __scmi_clock_enable,
-	.disable = __scmi_clock_disable,
-};
-
 static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.count_get = scmi_clock_count_get,
 	.info_get = scmi_clock_info_get,
@@ -397,7 +336,6 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 	u32 version;
 	int clkid, ret;
 	struct clock_info *cinfo;
-	struct scmi_handle *handle;
 
 	ph->xops->version_get(ph, &version);
 
@@ -424,11 +362,6 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 	}
 
 	cinfo->version = version;
-
-	/* Transient code for legacy ops interface */
-	handle = scmi_map_scmi_handle(ph);
-	handle->clk_ops = &clk_ops;
-
 	return ph->set_priv(ph, cinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index d18d5510986e..d562a0df3462 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -84,19 +84,6 @@ struct scmi_clk_proto_ops {
 	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id);
 };
 
-struct scmi_clk_ops {
-	int (*count_get)(const struct scmi_handle *hamdle);
-
-	const struct scmi_clock_info *(*info_get)
-		(const struct scmi_handle *handle, u32 clk_id);
-	int (*rate_get)(const struct scmi_handle *handle, u32 clk_id,
-			u64 *rate);
-	int (*rate_set)(const struct scmi_handle *handle, u32 clk_id,
-			u64 rate);
-	int (*enable)(const struct scmi_handle *handle, u32 clk_id);
-	int (*disable)(const struct scmi_handle *handle, u32 clk_id);
-};
-
 /**
  * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
@@ -614,7 +601,6 @@ struct scmi_notify_ops {
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
- * @clk_ops: pointer to set of clock protocol operations
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
  * @voltage_ops: pointer to set of voltage protocol operations
@@ -637,7 +623,6 @@ struct scmi_notify_ops {
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
-	const struct scmi_clk_ops *clk_ops;
 	const struct scmi_sensor_ops *sensor_ops;
 	const struct scmi_reset_ops *reset_ops;
 	const struct scmi_voltage_ops *voltage_ops;
-- 
2.17.1


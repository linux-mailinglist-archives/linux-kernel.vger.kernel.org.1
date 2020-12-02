Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A032CC80F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbgLBUmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:13 -0500
Received: from foss.arm.com ([217.140.110.172]:50474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731245AbgLBUmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F3F1516;
        Wed,  2 Dec 2020 12:40:53 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37CF73F575;
        Wed,  2 Dec 2020 12:40:52 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 14/37] firmware: arm_scmi: remove legacy scmi_perf_ops protocol interface
Date:   Wed,  2 Dec 2020 20:39:46 +0000
Message-Id: <20201202204009.32073-15-cristian.marussi@arm.com>
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
 drivers/firmware/arm_scmi/perf.c | 111 -------------------------------
 include/linux/scmi_protocol.h    |  26 --------
 2 files changed, 137 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 667a29d42c53..9cfc42c8fffd 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -391,15 +391,6 @@ static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 	return scmi_perf_mb_limits_set(ph, domain, max_perf, min_perf);
 }
 
-static int __scmi_perf_limits_set(const struct scmi_handle *handle,
-				  u32 domain, u32 max_perf, u32 min_perf)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_perf_limits_set(ph, domain, max_perf, min_perf);
-}
-
 static int scmi_perf_mb_limits_get(const struct scmi_protocol_handle *ph,
 				   u32 domain, u32 *max_perf, u32 *min_perf)
 {
@@ -441,15 +432,6 @@ static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 	return scmi_perf_mb_limits_get(ph, domain, max_perf, min_perf);
 }
 
-static int __scmi_perf_limits_get(const struct scmi_handle *handle,
-				  u32 domain, u32 *max_perf, u32 *min_perf)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_perf_limits_get(ph, domain, max_perf, min_perf);
-}
-
 static int scmi_perf_mb_level_set(const struct scmi_protocol_handle *ph,
 				  u32 domain, u32 level, bool poll)
 {
@@ -487,15 +469,6 @@ static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 	return scmi_perf_mb_level_set(ph, domain, level, poll);
 }
 
-static int __scmi_perf_level_set(const struct scmi_handle *handle,
-				 u32 domain, u32 level, bool poll)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_perf_level_set(ph, domain, level, poll);
-}
-
 static int scmi_perf_mb_level_get(const struct scmi_protocol_handle *ph,
 				  u32 domain, u32 *level, bool poll)
 {
@@ -532,15 +505,6 @@ static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 	return scmi_perf_mb_level_get(ph, domain, level, poll);
 }
 
-static int __scmi_perf_level_get(const struct scmi_handle *handle,
-				 u32 domain, u32 *level, bool poll)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_perf_level_get(ph, domain, level, poll);
-}
-
 static int scmi_perf_level_limits_notify(const struct scmi_protocol_handle *ph,
 					 u32 domain, int message_id,
 					 bool enable)
@@ -704,15 +668,6 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	return 0;
 }
 
-static int __scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
-				       struct device *dev)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_dvfs_device_opps_add(ph, dev);
-}
-
 static int
 scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 				 struct device *dev)
@@ -729,16 +684,6 @@ scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
 }
 
-static int
-__scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
-				   struct device *dev)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_dvfs_transition_latency_get(ph, dev);
-}
-
 static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
@@ -748,15 +693,6 @@ static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 	return scmi_perf_level_set(ph, domain, freq / dom->mult_factor, poll);
 }
 
-static int __scmi_dvfs_freq_set(const struct scmi_handle *handle,
-				u32 domain, unsigned long freq, bool poll)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_dvfs_freq_set(ph, domain, freq, poll);
-}
-
 static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long *freq, bool poll)
 {
@@ -772,15 +708,6 @@ static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 	return ret;
 }
 
-static int __scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
-				unsigned long *freq, bool poll)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_dvfs_freq_get(ph, domain, freq, poll);
-}
-
 static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 				   u32 domain, unsigned long *freq,
 				   unsigned long *power)
@@ -809,16 +736,6 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int __scmi_dvfs_est_power_get(const struct scmi_handle *handle,
-				     u32 domain, unsigned long *freq,
-				     unsigned long *power)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_dvfs_est_power_get(ph, domain, freq, power);
-}
-
 static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 				      struct device *dev)
 {
@@ -830,29 +747,6 @@ static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 	return dom->fc_info && dom->fc_info->level_set_addr;
 }
 
-static bool __scmi_fast_switch_possible(const struct scmi_handle *handle,
-					struct device *dev)
-{
-	const struct scmi_protocol_handle *ph =
-		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
-
-	return scmi_fast_switch_possible(ph, dev);
-}
-
-static const struct scmi_perf_ops perf_ops = {
-	.limits_set = __scmi_perf_limits_set,
-	.limits_get = __scmi_perf_limits_get,
-	.level_set = __scmi_perf_level_set,
-	.level_get = __scmi_perf_level_get,
-	.device_domain_id = scmi_dev_domain_id,
-	.transition_latency_get = __scmi_dvfs_transition_latency_get,
-	.device_opps_add = __scmi_dvfs_device_opps_add,
-	.freq_set = __scmi_dvfs_freq_set,
-	.freq_get = __scmi_dvfs_freq_get,
-	.est_power_get = __scmi_dvfs_est_power_get,
-	.fast_switch_possible = __scmi_fast_switch_possible,
-};
-
 static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
@@ -974,7 +868,6 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 	int domain;
 	u32 version;
 	struct scmi_perf_info *pinfo;
-	struct scmi_handle *handle;
 
 	ph->xops->version_get(ph, &version);
 
@@ -1004,10 +897,6 @@ static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 
 	pinfo->version = version;
 
-	/* Transient code for legacy ops interface */
-	handle = scmi_map_scmi_handle(ph);
-	handle->perf_ops = &perf_ops;
-
 	return ph->set_priv(ph, pinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 52481e5e45e0..e4212ce1dfbf 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -126,30 +126,6 @@ struct scmi_perf_proto_ops {
 				     struct device *dev);
 };
 
-struct scmi_perf_ops {
-	int (*limits_set)(const struct scmi_handle *handle, u32 domain,
-			  u32 max_perf, u32 min_perf);
-	int (*limits_get)(const struct scmi_handle *handle, u32 domain,
-			  u32 *max_perf, u32 *min_perf);
-	int (*level_set)(const struct scmi_handle *handle, u32 domain,
-			 u32 level, bool poll);
-	int (*level_get)(const struct scmi_handle *handle, u32 domain,
-			 u32 *level, bool poll);
-	int (*device_domain_id)(struct device *dev);
-	int (*transition_latency_get)(const struct scmi_handle *handle,
-				      struct device *dev);
-	int (*device_opps_add)(const struct scmi_handle *handle,
-			       struct device *dev);
-	int (*freq_set)(const struct scmi_handle *handle, u32 domain,
-			unsigned long rate, bool poll);
-	int (*freq_get)(const struct scmi_handle *handle, u32 domain,
-			unsigned long *rate, bool poll);
-	int (*est_power_get)(const struct scmi_handle *handle, u32 domain,
-			     unsigned long *rate, unsigned long *power);
-	bool (*fast_switch_possible)(const struct scmi_handle *handle,
-				     struct device *dev);
-};
-
 /**
  * struct scmi_power_ops - represents the various operations provided
  *	by SCMI Power Protocol
@@ -626,7 +602,6 @@ struct scmi_notify_ops {
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
  * @power_ops: pointer to set of power protocol operations
- * @perf_ops: pointer to set of performance protocol operations
  * @clk_ops: pointer to set of clock protocol operations
  * @sensor_ops: pointer to set of sensor protocol operations
  * @reset_ops: pointer to set of reset protocol operations
@@ -654,7 +629,6 @@ struct scmi_notify_ops {
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
-	const struct scmi_perf_ops *perf_ops;
 	const struct scmi_clk_ops *clk_ops;
 	const struct scmi_power_ops *power_ops;
 	const struct scmi_sensor_ops *sensor_ops;
-- 
2.17.1


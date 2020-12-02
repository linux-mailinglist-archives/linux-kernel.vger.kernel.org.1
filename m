Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B22CC80E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbgLBUmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:06 -0500
Received: from foss.arm.com ([217.140.110.172]:50472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731240AbgLBUmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 839561509;
        Wed,  2 Dec 2020 12:40:49 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D33AD3F575;
        Wed,  2 Dec 2020 12:40:47 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 12/37] firmware: arm_scmi: port Perf protocol to new protocols interface
Date:   Wed,  2 Dec 2020 20:39:44 +0000
Message-Id: <20201202204009.32073-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert internals of protocol implementation to use protocol handles and
expose a new protocol operations interface for SCMI driver using the new
get/put common operations, while keeping the old handle->perf_ops still
around to ease transition.

Remove handle->perf_priv now unused.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/perf.c | 336 ++++++++++++++++++++-----------
 include/linux/scmi_protocol.h    |  29 ++-
 2 files changed, 246 insertions(+), 119 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 13f3a968f781..667a29d42c53 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -175,21 +175,21 @@ static enum scmi_performance_protocol_cmd evt_2_cmd[] = {
 	PERF_NOTIFY_LEVEL,
 };
 
-static int scmi_perf_attributes_get(const struct scmi_handle *handle,
+static int scmi_perf_attributes_get(const struct scmi_protocol_handle *ph,
 				    struct scmi_perf_info *pi)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_perf_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_PERF, 0, sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
+				      sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		u16 flags = le16_to_cpu(attr->flags);
 
@@ -200,28 +200,27 @@ static int scmi_perf_attributes_get(const struct scmi_handle *handle,
 		pi->stats_size = le32_to_cpu(attr->stats_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
-				struct perf_dom_info *dom_info)
+scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
+				u32 domain, struct perf_dom_info *dom_info)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_perf_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PERF_DOMAIN_ATTRIBUTES,
-				 SCMI_PROTOCOL_PERF, sizeof(domain),
-				 sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_DOMAIN_ATTRIBUTES,
+				     sizeof(domain), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		u32 flags = le32_to_cpu(attr->flags);
 
@@ -245,7 +244,7 @@ scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
@@ -257,7 +256,7 @@ static int opp_cmp_func(const void *opp1, const void *opp2)
 }
 
 static int
-scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
+scmi_perf_describe_levels_get(const struct scmi_protocol_handle *ph, u32 domain,
 			      struct perf_dom_info *perf_dom)
 {
 	int ret, cnt;
@@ -268,8 +267,8 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 	struct scmi_msg_perf_describe_levels *dom_info;
 	struct scmi_msg_resp_perf_describe_levels *level_info;
 
-	ret = scmi_xfer_get_init(handle, PERF_DESCRIBE_LEVELS,
-				 SCMI_PROTOCOL_PERF, sizeof(*dom_info), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_DESCRIBE_LEVELS,
+				      sizeof(*dom_info), 0, &t);
 	if (ret)
 		return ret;
 
@@ -281,14 +280,14 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 		/* Set the number of OPPs to be skipped/already read */
 		dom_info->level_index = cpu_to_le32(tot_opp_cnt);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (ret)
 			break;
 
 		num_returned = le16_to_cpu(level_info->num_returned);
 		num_remaining = le16_to_cpu(level_info->num_remaining);
 		if (tot_opp_cnt + num_returned > MAX_OPPS) {
-			dev_err(handle->dev, "No. of OPPs exceeded MAX_OPPS");
+			dev_err(ph->dev, "No. of OPPs exceeded MAX_OPPS");
 			break;
 		}
 
@@ -299,13 +298,13 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 			opp->trans_latency_us = le16_to_cpu
 				(level_info->opp[cnt].transition_latency_us);
 
-			dev_dbg(handle->dev, "Level %d Power %d Latency %dus\n",
+			dev_dbg(ph->dev, "Level %d Power %d Latency %dus\n",
 				opp->perf, opp->power, opp->trans_latency_us);
 		}
 
 		tot_opp_cnt += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ph->xops->reset_rx_to_maxsz(ph, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
@@ -313,7 +312,7 @@ scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
 	} while (num_returned && num_remaining);
 
 	perf_dom->opp_count = tot_opp_cnt;
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	sort(perf_dom->opp, tot_opp_cnt, sizeof(*opp), opp_cmp_func, NULL);
 	return ret;
@@ -353,15 +352,15 @@ static void scmi_perf_fc_ring_db(struct scmi_fc_db_info *db)
 #endif
 }
 
-static int scmi_perf_mb_limits_set(const struct scmi_handle *handle, u32 domain,
-				   u32 max_perf, u32 min_perf)
+static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
+				   u32 domain, u32 max_perf, u32 min_perf)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_perf_set_limits *limits;
 
-	ret = scmi_xfer_get_init(handle, PERF_LIMITS_SET, SCMI_PROTOCOL_PERF,
-				 sizeof(*limits), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_LIMITS_SET,
+				      sizeof(*limits), 0, &t);
 	if (ret)
 		return ret;
 
@@ -370,16 +369,16 @@ static int scmi_perf_mb_limits_set(const struct scmi_handle *handle, u32 domain,
 	limits->max_level = cpu_to_le32(max_perf);
 	limits->min_level = cpu_to_le32(min_perf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
-				u32 max_perf, u32 min_perf)
+static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
+				u32 domain, u32 max_perf, u32 min_perf)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->limit_set_addr) {
@@ -389,24 +388,33 @@ static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_limits_set(handle, domain, max_perf, min_perf);
+	return scmi_perf_mb_limits_set(ph, domain, max_perf, min_perf);
 }
 
-static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
-				   u32 *max_perf, u32 *min_perf)
+static int __scmi_perf_limits_set(const struct scmi_handle *handle,
+				  u32 domain, u32 max_perf, u32 min_perf)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_perf_limits_set(ph, domain, max_perf, min_perf);
+}
+
+static int scmi_perf_mb_limits_get(const struct scmi_protocol_handle *ph,
+				   u32 domain, u32 *max_perf, u32 *min_perf)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_perf_get_limits *limits;
 
-	ret = scmi_xfer_get_init(handle, PERF_LIMITS_GET, SCMI_PROTOCOL_PERF,
-				 sizeof(__le32), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_LIMITS_GET,
+				      sizeof(__le32), 0, &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		limits = t->rx.buf;
 
@@ -414,14 +422,14 @@ static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
 		*min_perf = le32_to_cpu(limits->min_level);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
-				u32 *max_perf, u32 *min_perf)
+static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
+				u32 domain, u32 *max_perf, u32 *min_perf)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->limit_get_addr) {
@@ -430,18 +438,26 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_limits_get(handle, domain, max_perf, min_perf);
+	return scmi_perf_mb_limits_get(ph, domain, max_perf, min_perf);
+}
+
+static int __scmi_perf_limits_get(const struct scmi_handle *handle,
+				  u32 domain, u32 *max_perf, u32 *min_perf)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_perf_limits_get(ph, domain, max_perf, min_perf);
 }
 
-static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
-				  u32 level, bool poll)
+static int scmi_perf_mb_level_set(const struct scmi_protocol_handle *ph,
+				  u32 domain, u32 level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_perf_set_level *lvl;
 
-	ret = scmi_xfer_get_init(handle, PERF_LEVEL_SET, SCMI_PROTOCOL_PERF,
-				 sizeof(*lvl), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_LEVEL_SET, sizeof(*lvl), 0, &t);
 	if (ret)
 		return ret;
 
@@ -450,16 +466,16 @@ static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
 	lvl->domain = cpu_to_le32(domain);
 	lvl->level = cpu_to_le32(level);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
-			       u32 level, bool poll)
+static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
+			       u32 domain, u32 level, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->level_set_addr) {
@@ -468,35 +484,44 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_level_set(handle, domain, level, poll);
+	return scmi_perf_mb_level_set(ph, domain, level, poll);
+}
+
+static int __scmi_perf_level_set(const struct scmi_handle *handle,
+				 u32 domain, u32 level, bool poll)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_perf_level_set(ph, domain, level, poll);
 }
 
-static int scmi_perf_mb_level_get(const struct scmi_handle *handle, u32 domain,
-				  u32 *level, bool poll)
+static int scmi_perf_mb_level_get(const struct scmi_protocol_handle *ph,
+				  u32 domain, u32 *level, bool poll)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, PERF_LEVEL_GET, SCMI_PROTOCOL_PERF,
-				 sizeof(u32), sizeof(u32), &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_LEVEL_GET,
+				     sizeof(u32), sizeof(u32), &t);
 	if (ret)
 		return ret;
 
 	t->hdr.poll_completion = poll;
 	put_unaligned_le32(domain, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		*level = get_unaligned_le32(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
-			       u32 *level, bool poll)
+static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
+			       u32 domain, u32 *level, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	if (dom->fc_info && dom->fc_info->level_get_addr) {
@@ -504,10 +529,19 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_level_get(handle, domain, level, poll);
+	return scmi_perf_mb_level_get(ph, domain, level, poll);
 }
 
-static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
+static int __scmi_perf_level_get(const struct scmi_handle *handle,
+				 u32 domain, u32 *level, bool poll)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_perf_level_get(ph, domain, level, poll);
+}
+
+static int scmi_perf_level_limits_notify(const struct scmi_protocol_handle *ph,
 					 u32 domain, int message_id,
 					 bool enable)
 {
@@ -515,8 +549,7 @@ static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_perf_notify_level_or_limits *notify;
 
-	ret = scmi_xfer_get_init(handle, message_id, SCMI_PROTOCOL_PERF,
-				 sizeof(*notify), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
 
@@ -524,9 +557,9 @@ static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
 	notify->domain = cpu_to_le32(domain);
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
@@ -540,7 +573,7 @@ static bool scmi_perf_fc_size_is_valid(u32 msg, u32 size)
 }
 
 static void
-scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
+scmi_perf_domain_desc_fc(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 message_id, void __iomem **p_addr,
 			 struct scmi_fc_db_info **p_db)
 {
@@ -557,9 +590,8 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 	if (!p_addr)
 		return;
 
-	ret = scmi_xfer_get_init(handle, PERF_DESCRIBE_FASTCHANNEL,
-				 SCMI_PROTOCOL_PERF,
-				 sizeof(*info), sizeof(*resp), &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_DESCRIBE_FASTCHANNEL,
+				      sizeof(*info), sizeof(*resp), &t);
 	if (ret)
 		return;
 
@@ -567,7 +599,7 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 	info->domain = cpu_to_le32(domain);
 	info->message_id = cpu_to_le32(message_id);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (ret)
 		goto err_xfer;
 
@@ -579,20 +611,20 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 
 	phys_addr = le32_to_cpu(resp->chan_addr_low);
 	phys_addr |= (u64)le32_to_cpu(resp->chan_addr_high) << 32;
-	addr = devm_ioremap(handle->dev, phys_addr, size);
+	addr = devm_ioremap(ph->dev, phys_addr, size);
 	if (!addr)
 		goto err_xfer;
 	*p_addr = addr;
 
 	if (p_db && SUPPORTS_DOORBELL(flags)) {
-		db = devm_kzalloc(handle->dev, sizeof(*db), GFP_KERNEL);
+		db = devm_kzalloc(ph->dev, sizeof(*db), GFP_KERNEL);
 		if (!db)
 			goto err_xfer;
 
 		size = 1 << DOORBELL_REG_WIDTH(flags);
 		phys_addr = le32_to_cpu(resp->db_addr_low);
 		phys_addr |= (u64)le32_to_cpu(resp->db_addr_high) << 32;
-		addr = devm_ioremap(handle->dev, phys_addr, size);
+		addr = devm_ioremap(ph->dev, phys_addr, size);
 		if (!addr)
 			goto err_xfer;
 
@@ -605,25 +637,25 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 		*p_db = db;
 	}
 err_xfer:
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 }
 
-static void scmi_perf_domain_init_fc(const struct scmi_handle *handle,
+static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 				     u32 domain, struct scmi_fc_info **p_fc)
 {
 	struct scmi_fc_info *fc;
 
-	fc = devm_kzalloc(handle->dev, sizeof(*fc), GFP_KERNEL);
+	fc = devm_kzalloc(ph->dev, sizeof(*fc), GFP_KERNEL);
 	if (!fc)
 		return;
 
-	scmi_perf_domain_desc_fc(handle, domain, PERF_LEVEL_SET,
+	scmi_perf_domain_desc_fc(ph, domain, PERF_LEVEL_SET,
 				 &fc->level_set_addr, &fc->level_set_db);
-	scmi_perf_domain_desc_fc(handle, domain, PERF_LEVEL_GET,
+	scmi_perf_domain_desc_fc(ph, domain, PERF_LEVEL_GET,
 				 &fc->level_get_addr, NULL);
-	scmi_perf_domain_desc_fc(handle, domain, PERF_LIMITS_SET,
+	scmi_perf_domain_desc_fc(ph, domain, PERF_LIMITS_SET,
 				 &fc->limit_set_addr, &fc->limit_set_db);
-	scmi_perf_domain_desc_fc(handle, domain, PERF_LIMITS_GET,
+	scmi_perf_domain_desc_fc(ph, domain, PERF_LIMITS_GET,
 				 &fc->limit_get_addr, NULL);
 	*p_fc = fc;
 }
@@ -640,14 +672,14 @@ static int scmi_dev_domain_id(struct device *dev)
 	return clkspec.args[0];
 }
 
-static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
+static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 				     struct device *dev)
 {
 	int idx, ret, domain;
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
@@ -672,11 +704,21 @@ static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
 	return 0;
 }
 
-static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
-					    struct device *dev)
+static int __scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
+				       struct device *dev)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_dvfs_device_opps_add(ph, dev);
+}
+
+static int
+scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
+				 struct device *dev)
 {
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	int domain = scmi_dev_domain_id(dev);
 
 	if (domain < 0)
@@ -687,35 +729,63 @@ static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
 }
 
-static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
+static int
+__scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
+				   struct device *dev)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_dvfs_transition_latency_get(ph, dev);
+}
+
+static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor,
-				   poll);
+	return scmi_perf_level_set(ph, domain, freq / dom->mult_factor, poll);
+}
+
+static int __scmi_dvfs_freq_set(const struct scmi_handle *handle,
+				u32 domain, unsigned long freq, bool poll)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_dvfs_freq_set(ph, domain, freq, poll);
 }
 
-static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
+static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long *freq, bool poll)
 {
 	int ret;
 	u32 level;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	ret = scmi_perf_level_get(handle, domain, &level, poll);
+	ret = scmi_perf_level_get(ph, domain, &level, poll);
 	if (!ret)
 		*freq = level * dom->mult_factor;
 
 	return ret;
 }
 
-static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
-				   unsigned long *freq, unsigned long *power)
+static int __scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
+				unsigned long *freq, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_dvfs_freq_get(ph, domain, freq, poll);
+}
+
+static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
+				   u32 domain, unsigned long *freq,
+				   unsigned long *power)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
@@ -739,18 +809,51 @@ static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
+static int __scmi_dvfs_est_power_get(const struct scmi_handle *handle,
+				     u32 domain, unsigned long *freq,
+				     unsigned long *power)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_dvfs_est_power_get(ph, domain, freq, power);
+}
+
+static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 				      struct device *dev)
 {
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	dom = pi->dom_info + scmi_dev_domain_id(dev);
 
 	return dom->fc_info && dom->fc_info->level_set_addr;
 }
 
+static bool __scmi_fast_switch_possible(const struct scmi_handle *handle,
+					struct device *dev)
+{
+	const struct scmi_protocol_handle *ph =
+		scmi_map_protocol_handle(handle, SCMI_PROTOCOL_PERF);
+
+	return scmi_fast_switch_possible(ph, dev);
+}
+
 static const struct scmi_perf_ops perf_ops = {
+	.limits_set = __scmi_perf_limits_set,
+	.limits_get = __scmi_perf_limits_get,
+	.level_set = __scmi_perf_level_set,
+	.level_get = __scmi_perf_level_get,
+	.device_domain_id = scmi_dev_domain_id,
+	.transition_latency_get = __scmi_dvfs_transition_latency_get,
+	.device_opps_add = __scmi_dvfs_device_opps_add,
+	.freq_set = __scmi_dvfs_freq_set,
+	.freq_get = __scmi_dvfs_freq_get,
+	.est_power_get = __scmi_dvfs_est_power_get,
+	.fast_switch_possible = __scmi_fast_switch_possible,
+};
+
+static const struct scmi_perf_proto_ops perf_proto_ops = {
 	.limits_set = scmi_perf_limits_set,
 	.limits_get = scmi_perf_limits_get,
 	.level_set = scmi_perf_level_set,
@@ -764,7 +867,7 @@ static const struct scmi_perf_ops perf_ops = {
 	.fast_switch_possible = scmi_fast_switch_possible,
 };
 
-static int scmi_perf_set_notify_enabled(const void *handle,
+static int scmi_perf_set_notify_enabled(const void *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret, cmd_id;
@@ -773,7 +876,7 @@ static int scmi_perf_set_notify_enabled(const void *handle,
 		return -EINVAL;
 
 	cmd_id = evt_2_cmd[evt_id];
-	ret = scmi_perf_level_limits_notify(handle, src_id, cmd_id, enable);
+	ret = scmi_perf_level_limits_notify(ph, src_id, cmd_id, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -781,7 +884,7 @@ static int scmi_perf_set_notify_enabled(const void *handle,
 	return ret;
 }
 
-static void *scmi_perf_fill_custom_report(const void *handle,
+static void *scmi_perf_fill_custom_report(const void *ph,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
@@ -829,10 +932,10 @@ static void *scmi_perf_fill_custom_report(const void *handle,
 	return rep;
 }
 
-static int scmi_perf_get_num_sources(const void *handle)
+static int scmi_perf_get_num_sources(const void *ph)
 {
 	struct scmi_perf_info *pi =
-		((const struct scmi_handle *)(handle))->perf_priv;
+		((const struct scmi_protocol_handle *)ph)->get_priv(ph);
 
 	if (!pi)
 		return -EINVAL;
@@ -866,24 +969,25 @@ static const struct scmi_protocol_events perf_protocol_events = {
 	.num_events = ARRAY_SIZE(perf_events),
 };
 
-static int scmi_perf_protocol_init(struct scmi_handle *handle)
+static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int domain;
 	u32 version;
 	struct scmi_perf_info *pinfo;
+	struct scmi_handle *handle;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Performance Version %d.%d\n",
+	dev_dbg(ph->dev, "Performance Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_perf_attributes_get(handle, pinfo);
+	scmi_perf_attributes_get(ph, pinfo);
 
-	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
+	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
 	if (!pinfo->dom_info)
 		return -ENOMEM;
@@ -891,24 +995,26 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct perf_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_perf_domain_attributes_get(handle, domain, dom);
-		scmi_perf_describe_levels_get(handle, domain, dom);
+		scmi_perf_domain_attributes_get(ph, domain, dom);
+		scmi_perf_describe_levels_get(ph, domain, dom);
 
 		if (dom->perf_fastchannels)
-			scmi_perf_domain_init_fc(handle, domain, &dom->fc_info);
+			scmi_perf_domain_init_fc(ph, domain, &dom->fc_info);
 	}
 
 	pinfo->version = version;
+
+	/* Transient code for legacy ops interface */
+	handle = scmi_map_scmi_handle(ph);
 	handle->perf_ops = &perf_ops;
-	handle->perf_priv = pinfo;
 
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_perf = {
 	.id = SCMI_PROTOCOL_PERF,
-	.init = &scmi_perf_protocol_init,
-	.ops = &perf_ops,
+	.init_instance = &scmi_perf_protocol_init,
+	.ops = &perf_proto_ops,
 	.events = &perf_protocol_events,
 };
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index c29f159c8b42..52481e5e45e0 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -85,7 +85,7 @@ struct scmi_clk_ops {
 };
 
 /**
- * struct scmi_perf_ops - represents the various operations provided
+ * struct scmi_perf_proto_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
  * @limits_set: sets limits on the performance level of a domain
@@ -102,6 +102,30 @@ struct scmi_clk_ops {
  * @est_power_get: gets the estimated power cost for a given performance domain
  *	at a given frequency
  */
+struct scmi_perf_proto_ops {
+	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
+			  u32 max_perf, u32 min_perf);
+	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
+			  u32 *max_perf, u32 *min_perf);
+	int (*level_set)(const struct scmi_protocol_handle *ph, u32 domain,
+			 u32 level, bool poll);
+	int (*level_get)(const struct scmi_protocol_handle *ph, u32 domain,
+			 u32 *level, bool poll);
+	int (*device_domain_id)(struct device *dev);
+	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
+				      struct device *dev);
+	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
+			       struct device *dev);
+	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
+			unsigned long rate, bool poll);
+	int (*freq_get)(const struct scmi_protocol_handle *ph, u32 domain,
+			unsigned long *rate, bool poll);
+	int (*est_power_get)(const struct scmi_protocol_handle *ph, u32 domain,
+			     unsigned long *rate, unsigned long *power);
+	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
+				     struct device *dev);
+};
+
 struct scmi_perf_ops {
 	int (*limits_set)(const struct scmi_handle *handle, u32 domain,
 			  u32 max_perf, u32 min_perf);
@@ -614,8 +638,6 @@ struct scmi_notify_ops {
  *	     dedicated protocol handler
  * @put_ops: method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
- * @perf_priv: pointer to private data structure specific to performance
- *	protocol(for internal use only)
  * @clk_priv: pointer to private data structure specific to clock
  *	protocol(for internal use only)
  * @power_priv: pointer to private data structure specific to power
@@ -651,7 +673,6 @@ struct scmi_handle {
 
 	const struct scmi_notify_ops *notify_ops;
 	/* for protocol internal use */
-	void *perf_priv;
 	void *clk_priv;
 	void *power_priv;
 	void *sensor_priv;
-- 
2.17.1


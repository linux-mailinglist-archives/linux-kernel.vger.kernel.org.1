Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6528E29D3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgJ1Vr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:47:26 -0400
Received: from foss.arm.com ([217.140.110.172]:38344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbgJ1VrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386ED1BD0;
        Wed, 28 Oct 2020 13:29:55 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68B763F66E;
        Wed, 28 Oct 2020 13:29:53 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 6/8] firmware: arm_scmi: port all protocols and drivers to the new API
Date:   Wed, 28 Oct 2020 20:29:12 +0000
Message-Id: <20201028202914.43662-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028202914.43662-1-cristian.marussi@arm.com>
References: <20201028202914.43662-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert core SCMI xfer operations to use protocol handles and expose them
via protocol handle to the protocol code itself so that it can be used to
generate at will all the related SCMI messages: using protocol handles
forbids protocol code from forging messages belonging to other protocols.

Port all protocols initialization routines, notifications core mechanisms
and SCMI drivers to the new protocol handle interface; protocols are now
initialized on first usage when an SCMI driver gets hold of the related
protocols operations and protocol handle: ported SCMI drivers use the
devres managed API to simplify their usage.

Finally, remove the old protocol-specific _ops and _priv references from
the handle structure: private data are now accessible only by protocol
code using the protocol handle methods.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c                     |  27 ++-
 drivers/cpufreq/scmi-cpufreq.c             |  38 ++--
 drivers/firmware/arm_scmi/base.c           | 115 +++++------
 drivers/firmware/arm_scmi/bus.c            |  24 ---
 drivers/firmware/arm_scmi/clock.c          | 115 ++++++-----
 drivers/firmware/arm_scmi/common.h         |  20 +-
 drivers/firmware/arm_scmi/driver.c         | 101 ++++++----
 drivers/firmware/arm_scmi/notify.c         |  13 +-
 drivers/firmware/arm_scmi/notify.h         |   7 +-
 drivers/firmware/arm_scmi/perf.c           | 224 ++++++++++-----------
 drivers/firmware/arm_scmi/power.c          |  99 +++++----
 drivers/firmware/arm_scmi/reset.c          | 111 +++++-----
 drivers/firmware/arm_scmi/scmi_pm_domain.c |  26 ++-
 drivers/firmware/arm_scmi/sensors.c        | 105 +++++-----
 drivers/firmware/arm_scmi/system.c         |  34 ++--
 drivers/hwmon/scmi-hwmon.c                 |  24 ++-
 drivers/reset/reset-scmi.c                 |  33 +--
 include/linux/scmi_protocol.h              |  91 +++------
 18 files changed, 596 insertions(+), 611 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index c754dfbb73fd..54b2043fa3fb 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Power Interface (SCMI) Protocol based clock driver
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  */
 
 #include <linux/clk-provider.h>
@@ -13,11 +13,13 @@
 #include <linux/scmi_protocol.h>
 #include <asm/div64.h>
 
+static const struct scmi_clk_ops *clk_ops;
+
 struct scmi_clk {
 	u32 id;
 	struct clk_hw hw;
 	const struct scmi_clock_info *info;
-	const struct scmi_handle *handle;
+	const struct scmi_protocol_handle *ph;
 };
 
 #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
@@ -29,7 +31,7 @@ static unsigned long scmi_clk_recalc_rate(struct clk_hw *hw,
 	u64 rate;
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	ret = clk->handle->clk_ops->rate_get(clk->handle, clk->id, &rate);
+	ret = clk_ops->rate_get(clk->ph, clk->id, &rate);
 	if (ret)
 		return 0;
 	return rate;
@@ -69,21 +71,21 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, rate);
+	return clk_ops->rate_set(clk->ph, clk->id, rate);
 }
 
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return clk->handle->clk_ops->enable(clk->handle, clk->id);
+	return clk_ops->enable(clk->ph, clk->id);
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	clk->handle->clk_ops->disable(clk->handle, clk->id);
+	clk_ops->disable(clk->ph, clk->id);
 }
 
 static const struct clk_ops scmi_clk_ops = {
@@ -142,11 +144,16 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->clk_ops)
+	if (!handle)
 		return -ENODEV;
 
-	count = handle->clk_ops->count_get(handle);
+	clk_ops = handle->devm_get_ops(sdev, SCMI_PROTOCOL_CLOCK, &ph);
+	if (IS_ERR(clk_ops))
+		return PTR_ERR(clk_ops);
+
+	count = clk_ops->count_get(ph);
 	if (count < 0) {
 		dev_err(dev, "%pOFn: invalid clock output count\n", np);
 		return -EINVAL;
@@ -167,14 +174,14 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		if (!sclk)
 			return -ENOMEM;
 
-		sclk->info = handle->clk_ops->info_get(handle, idx);
+		sclk->info = clk_ops->info_get(ph, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
 			continue;
 		}
 
 		sclk->id = idx;
-		sclk->handle = handle;
+		sclk->ph = ph;
 
 		err = scmi_clk_ops_init(dev, sclk);
 		if (err) {
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 46b268095421..89719dce973b 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -24,17 +24,17 @@ struct scmi_data {
 	struct device *cpu_dev;
 };
 
-static const struct scmi_handle *handle;
+static struct scmi_protocol_handle *ph;
+static const struct scmi_perf_ops *perf_ops;
 
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	struct scmi_data *priv = policy->driver_data;
 	unsigned long rate;
 	int ret;
 
-	ret = perf_ops->freq_get(handle, priv->domain_id, &rate, false);
+	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
 	return rate / 1000;
@@ -50,10 +50,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	int ret;
 	struct scmi_data *priv = policy->driver_data;
-	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 	u64 freq = policy->freq_table[index].frequency;
 
-	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
+	ret = perf_ops->freq_set(ph, priv->domain_id, freq * 1000, false);
 	if (!ret)
 		arch_set_freq_scale(policy->related_cpus, freq,
 				    policy->cpuinfo.max_freq);
@@ -64,9 +63,8 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					     unsigned int target_freq)
 {
 	struct scmi_data *priv = policy->driver_data;
-	const struct scmi_perf_ops *perf_ops = handle->perf_ops;
 
-	if (!perf_ops->freq_set(handle, priv->domain_id,
+	if (!perf_ops->freq_set(ph, priv->domain_id,
 				target_freq * 1000, true)) {
 		arch_set_freq_scale(policy->related_cpus, target_freq,
 				    policy->cpuinfo.max_freq);
@@ -82,7 +80,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	int cpu, domain, tdomain;
 	struct device *tcpu_dev;
 
-	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	domain = perf_ops->device_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -94,7 +92,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		if (!tcpu_dev)
 			continue;
 
-		tdomain = handle->perf_ops->device_domain_id(tcpu_dev);
+		tdomain = perf_ops->device_domain_id(tcpu_dev);
 		if (tdomain == domain)
 			cpumask_set_cpu(cpu, cpumask);
 	}
@@ -109,13 +107,13 @@ scmi_get_cpu_power(unsigned long *power, unsigned long *KHz,
 	unsigned long Hz;
 	int ret, domain;
 
-	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	domain = perf_ops->device_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
 	/* Get the power cost of the performance domain. */
 	Hz = *KHz * 1000;
-	ret = handle->perf_ops->est_power_get(handle, domain, &Hz, power);
+	ret = perf_ops->est_power_get(ph, domain, &Hz, power);
 	if (ret)
 		return ret;
 
@@ -140,7 +138,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
-	ret = handle->perf_ops->device_opps_add(handle, cpu_dev);
+	ret = perf_ops->device_opps_add(ph, cpu_dev);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to add opps to the device\n");
 		return ret;
@@ -179,7 +177,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = handle->perf_ops->device_domain_id(cpu_dev);
+	priv->domain_id = perf_ops->device_domain_id(cpu_dev);
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
@@ -187,14 +185,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = handle->perf_ops->transition_latency_get(handle, cpu_dev);
+	latency = perf_ops->transition_latency_get(ph, cpu_dev);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
 
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible =
-		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
+		perf_ops->fast_switch_possible(ph, cpu_dev);
 
 	em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, policy->cpus);
 
@@ -236,17 +234,21 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
+	const struct scmi_handle *handle;
 
 	handle = sdev->handle;
 
-	if (!handle || !handle->perf_ops)
+	if (!handle)
 		return -ENODEV;
 
+	perf_ops = handle->devm_get_ops(sdev, SCMI_PROTOCOL_PERF, &ph);
+	if (IS_ERR(perf_ops))
+		return PTR_ERR(perf_ops);
+
 	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
-	if (ret) {
+	if (ret)
 		dev_err(&sdev->dev, "%s: registering cpufreq failed, err: %d\n",
 			__func__, ret);
-	}
 
 	return ret;
 }
diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 634a6ec99464..745e475e6cc4 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -50,30 +50,30 @@ struct scmi_base_error_notify_payld {
  * scmi_base_attributes_get() - gets the implementation details
  *	that are associated with the base protocol.
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
-static int scmi_base_attributes_get(const struct scmi_handle *handle)
+static int scmi_base_attributes_get(const struct scmi_protocol_handle *ph)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_base_attributes *attr_info;
-	struct scmi_revision_info *rev = handle->version;
+	struct scmi_revision_info *rev = ph->get_priv(ph);
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_BASE, 0, sizeof(*attr_info), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr_info), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		attr_info = t->rx.buf;
 		rev->num_protocols = attr_info->num_protocols;
 		rev->num_agents = attr_info->num_agents;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -81,19 +81,20 @@ static int scmi_base_attributes_get(const struct scmi_handle *handle)
 /**
  * scmi_base_vendor_id_get() - gets vendor/subvendor identifier ASCII string.
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  * @sub_vendor: specify true if sub-vendor ID is needed
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
 static int
-scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
+scmi_base_vendor_id_get(const struct scmi_protocol_handle *ph, bool sub_vendor)
 {
 	u8 cmd;
 	int ret, size;
 	char *vendor_id;
 	struct scmi_xfer *t;
-	struct scmi_revision_info *rev = handle->version;
+	struct scmi_revision_info *rev = ph->get_priv(ph);
+
 
 	if (sub_vendor) {
 		cmd = BASE_DISCOVER_SUB_VENDOR;
@@ -105,15 +106,15 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
 		size = ARRAY_SIZE(rev->vendor_id);
 	}
 
-	ret = scmi_xfer_get_init(handle, cmd, SCMI_PROTOCOL_BASE, 0, size, &t);
+	ret = ph->xops->xfer_get_init(ph, cmd, 0, size, &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		memcpy(vendor_id, t->rx.buf, size);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -123,30 +124,30 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
  *	implementation 32-bit version. The format of the version number is
  *	vendor-specific
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
 static int
-scmi_base_implementation_version_get(const struct scmi_handle *handle)
+scmi_base_implementation_version_get(const struct scmi_protocol_handle *ph)
 {
 	int ret;
 	__le32 *impl_ver;
 	struct scmi_xfer *t;
-	struct scmi_revision_info *rev = handle->version;
+	struct scmi_revision_info *rev = ph->get_priv(ph);
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_IMPLEMENT_VERSION,
-				 SCMI_PROTOCOL_BASE, 0, sizeof(*impl_ver), &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_IMPLEMENT_VERSION,
+				      0, sizeof(*impl_ver), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		impl_ver = t->rx.buf;
 		rev->impl_ver = le32_to_cpu(*impl_ver);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -155,23 +156,24 @@ scmi_base_implementation_version_get(const struct scmi_handle *handle)
  * scmi_base_implementation_list_get() - gets the list of protocols it is
  *	OSPM is allowed to access
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  * @protocols_imp: pointer to hold the list of protocol identifiers
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
-static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
-					     u8 *protocols_imp)
+static int
+scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
+				  u8 *protocols_imp)
 {
 	u8 *list;
 	int ret, loop;
 	struct scmi_xfer *t;
 	__le32 *num_skip, *num_ret;
 	u32 tot_num_ret = 0, loop_num_ret;
-	struct device *dev = handle->dev;
+	struct device *dev = ph->dev;
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_LIST_PROTOCOLS,
-				 SCMI_PROTOCOL_BASE, sizeof(*num_skip), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_LIST_PROTOCOLS,
+				      sizeof(*num_skip), 0, &t);
 	if (ret)
 		return ret;
 
@@ -183,7 +185,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 		/* Set the number of protocols to be skipped/already read */
 		*num_skip = cpu_to_le32(tot_num_ret);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (ret)
 			break;
 
@@ -198,10 +200,10 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 
 		tot_num_ret += loop_num_ret;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ph->xops->reset_rx_to_maxsz(ph, t);
 	} while (loop_num_ret);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
@@ -209,7 +211,7 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 /**
  * scmi_base_discover_agent_get() - discover the name of an agent
  *
- * @handle: SCMI entity handle
+ * @ph: SCMI protocol handle
  * @id: Agent identifier
  * @name: Agent identifier ASCII string
  *
@@ -218,63 +220,63 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
-static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
+static int scmi_base_discover_agent_get(const struct scmi_protocol_handle *ph,
 					int id, char *name)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, BASE_DISCOVER_AGENT,
-				 SCMI_PROTOCOL_BASE, sizeof(__le32),
-				 SCMI_MAX_STR_SIZE, &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_AGENT,
+				      sizeof(__le32), SCMI_MAX_STR_SIZE, &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(id, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		strlcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 
 	return ret;
 }
 
-static int scmi_base_error_notify(const struct scmi_handle *handle, bool enable)
+static int scmi_base_error_notify(const struct scmi_protocol_handle *ph,
+				  bool enable)
 {
 	int ret;
 	u32 evt_cntl = enable ? BASE_TP_NOTIFY_ALL : 0;
 	struct scmi_xfer *t;
 	struct scmi_msg_base_error_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, BASE_NOTIFY_ERRORS,
-				 SCMI_PROTOCOL_BASE, sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, BASE_NOTIFY_ERRORS,
+				      sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
 	cfg = t->tx.buf;
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_base_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_base_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_base_error_notify(handle, enable);
+	ret = scmi_base_error_notify(ph, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] ret:%d\n", evt_id, ret);
 
 	return ret;
 }
 
-static void *scmi_base_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_base_fill_custom_report(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
@@ -326,17 +328,16 @@ static const struct scmi_protocol_events base_protocol_events = {
 	.num_sources = SCMI_BASE_NUM_SOURCES,
 };
 
-static int scmi_base_protocol_init(struct scmi_handle *h)
+static int scmi_base_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int id, ret;
 	u8 *prot_imp;
 	u32 version;
 	char name[SCMI_MAX_STR_SIZE];
-	const struct scmi_handle *handle = h;
-	struct device *dev = handle->dev;
-	struct scmi_revision_info *rev = handle->version;
+	struct device *dev = ph->dev;
+	struct scmi_revision_info *rev = scmi_get_revision_area(ph);
 
-	ret = scmi_version_get(handle, SCMI_PROTOCOL_BASE, &version);
+	ret = ph->xops->version_get(ph, &version);
 	if (ret)
 		return ret;
 
@@ -346,13 +347,15 @@ static int scmi_base_protocol_init(struct scmi_handle *h)
 
 	rev->major_ver = PROTOCOL_REV_MAJOR(version),
 	rev->minor_ver = PROTOCOL_REV_MINOR(version);
+	ph->set_priv(ph, rev);
+
+	scmi_base_attributes_get(ph);
+	scmi_base_vendor_id_get(ph, false);
+	scmi_base_vendor_id_get(ph, true);
+	scmi_base_implementation_version_get(ph);
+	scmi_base_implementation_list_get(ph, prot_imp);
 
-	scmi_base_attributes_get(handle);
-	scmi_base_vendor_id_get(handle, false);
-	scmi_base_vendor_id_get(handle, true);
-	scmi_base_implementation_version_get(handle);
-	scmi_base_implementation_list_get(handle, prot_imp);
-	scmi_setup_protocol_implemented(handle, prot_imp);
+	scmi_setup_protocol_implemented(ph, prot_imp);
 
 	dev_info(dev, "SCMI Protocol v%d.%d '%s:%s' Firmware version 0x%x\n",
 		 rev->major_ver, rev->minor_ver, rev->vendor_id,
@@ -361,7 +364,7 @@ static int scmi_base_protocol_init(struct scmi_handle *h)
 		rev->num_agents);
 
 	for (id = 0; id < rev->num_agents; id++) {
-		scmi_base_discover_agent_get(handle, id, name);
+		scmi_base_discover_agent_get(ph, id, name);
 		dev_dbg(dev, "Agent %d: %s\n", id, name);
 	}
 
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 0410cf77233c..25b191cfefc1 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -66,27 +66,11 @@ const struct scmi_protocol *scmi_get_protocol(int protocol_id)
 	return proto;
 }
 
-static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
-{
-	const struct scmi_protocol *proto;
-
-	proto = scmi_get_protocol(protocol_id);
-	if (!proto)
-		return -EINVAL;
-	return proto->init(handle);
-}
-
-static int scmi_protocol_dummy_init(struct scmi_handle *handle)
-{
-	return 0;
-}
-
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
 	const struct scmi_device_id *id;
-	int ret;
 
 	id = scmi_dev_match_id(scmi_dev, scmi_drv);
 	if (!id)
@@ -95,14 +79,6 @@ static int scmi_dev_probe(struct device *dev)
 	if (!scmi_dev->handle)
 		return -EPROBE_DEFER;
 
-	ret = scmi_protocol_init(scmi_dev->protocol_id, scmi_dev->handle);
-	if (ret)
-		return ret;
-
-	/* Skip protocol initialisation for additional devices */
-	idr_replace(&scmi_available_protocols, &scmi_protocol_dummy_init,
-		    scmi_dev->protocol_id);
-
 	return scmi_drv->probe(scmi_dev);
 }
 
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e8c84cff9922..00041dcb4d06 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -74,52 +74,53 @@ struct clock_info {
 	struct scmi_clock_info *clk;
 };
 
-static int scmi_clock_protocol_attributes_get(const struct scmi_handle *handle,
-					      struct clock_info *ci)
+static int
+scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
+				   struct clock_info *ci)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_protocol_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_CLOCK, 0, sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		ci->num_clocks = le16_to_cpu(attr->num_clocks);
 		ci->max_async_req = attr->max_async_req;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_clock_attributes_get(const struct scmi_handle *handle,
+static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_clock_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_ATTRIBUTES, SCMI_PROTOCOL_CLOCK,
-				 sizeof(clk_id), sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_ATTRIBUTES,
+				      sizeof(clk_id), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(clk_id, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
 	else
 		clk->name[0] = '\0';
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
@@ -136,7 +137,7 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
 }
 
 static int
-scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
+scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      struct scmi_clock_info *clk)
 {
 	u64 *rate = NULL;
@@ -148,8 +149,8 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	struct scmi_msg_clock_describe_rates *clk_desc;
 	struct scmi_msg_resp_clock_describe_rates *rlist;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_DESCRIBE_RATES,
-				 SCMI_PROTOCOL_CLOCK, sizeof(*clk_desc), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_DESCRIBE_RATES,
+				      sizeof(*clk_desc), 0, &t);
 	if (ret)
 		return ret;
 
@@ -161,7 +162,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		/* Set the number of rates to be skipped/already read */
 		clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (ret)
 			goto err;
 
@@ -171,7 +172,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		num_returned = NUM_RETURNED(rates_flag);
 
 		if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
-			dev_err(handle->dev, "No. of rates > MAX_NUM_RATES");
+			dev_err(ph->dev, "No. of rates > MAX_NUM_RATES");
 			break;
 		}
 
@@ -179,7 +180,7 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 			clk->range.min_rate = RATE_TO_U64(rlist->rate[0]);
 			clk->range.max_rate = RATE_TO_U64(rlist->rate[1]);
 			clk->range.step_size = RATE_TO_U64(rlist->rate[2]);
-			dev_dbg(handle->dev, "Min %llu Max %llu Step %llu Hz\n",
+			dev_dbg(ph->dev, "Min %llu Max %llu Step %llu Hz\n",
 				clk->range.min_rate, clk->range.max_rate,
 				clk->range.step_size);
 			break;
@@ -188,12 +189,12 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 		rate = &clk->list.rates[tot_rate_cnt];
 		for (cnt = 0; cnt < num_returned; cnt++, rate++) {
 			*rate = RATE_TO_U64(rlist->rate[cnt]);
-			dev_dbg(handle->dev, "Rate %llu Hz\n", *rate);
+			dev_dbg(ph->dev, "Rate %llu Hz\n", *rate);
 		}
 
 		tot_rate_cnt += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ph->xops->reset_rx_to_maxsz(ph, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
@@ -208,42 +209,42 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
 	clk->rate_discrete = rate_discrete;
 
 err:
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
+scmi_clock_rate_get(const struct scmi_protocol_handle *ph,
+		    u32 clk_id, u64 *value)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_RATE_GET, SCMI_PROTOCOL_CLOCK,
-				 sizeof(__le32), sizeof(u64), &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_GET,
+				      sizeof(__le32), sizeof(u64), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(clk_id, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		*value = get_unaligned_le64(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
-			       u64 rate)
+static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
+			       u32 clk_id, u64 rate)
 {
 	int ret;
 	u32 flags = 0;
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = ph->get_priv(ph);
 
-	ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
-				 sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -258,26 +259,27 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 	cfg->value_high = cpu_to_le32(rate >> 32);
 
 	if (flags & CLOCK_SET_ASYNC)
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ph->xops->do_xfer_with_response(ph, t);
 	else
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 
 	if (ci->max_async_req)
 		atomic_dec(&ci->cur_async_req);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
+scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      u32 config)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_clock_set_config *cfg;
 
-	ret = scmi_xfer_get_init(handle, CLOCK_CONFIG_SET, SCMI_PROTOCOL_CLOCK,
-				 sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, CLOCK_CONFIG_SET,
+				      sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -285,33 +287,33 @@ scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->attributes = cpu_to_le32(config);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_clock_enable(const struct scmi_handle *handle, u32 clk_id)
+static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
-	return scmi_clock_config_set(handle, clk_id, CLOCK_ENABLE);
+	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE);
 }
 
-static int scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
+static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
-	return scmi_clock_config_set(handle, clk_id, 0);
+	return scmi_clock_config_set(ph, clk_id, 0);
 }
 
-static int scmi_clock_count_get(const struct scmi_handle *handle)
+static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = ph->get_priv(ph);
 
 	return ci->num_clocks;
 }
 
 static const struct scmi_clock_info *
-scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
+scmi_clock_info_get(const struct scmi_protocol_handle *ph, u32 clk_id)
 {
-	struct clock_info *ci = handle->clk_priv;
+	struct clock_info *ci = ph->get_priv(ph);
 	struct scmi_clock_info *clk = ci->clk + clk_id;
 
 	if (!clk->name[0])
@@ -329,24 +331,24 @@ static const struct scmi_clk_ops clk_ops = {
 	.disable = scmi_clock_disable,
 };
 
-static int scmi_clock_protocol_init(struct scmi_handle *handle)
+static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	u32 version;
 	int clkid, ret;
 	struct clock_info *cinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Clock Version %d.%d\n",
+	dev_dbg(ph->dev, "Clock Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	cinfo = devm_kzalloc(handle->dev, sizeof(*cinfo), GFP_KERNEL);
+	cinfo = devm_kzalloc(ph->dev, sizeof(*cinfo), GFP_KERNEL);
 	if (!cinfo)
 		return -ENOMEM;
 
-	scmi_clock_protocol_attributes_get(handle, cinfo);
+	scmi_clock_protocol_attributes_get(ph, cinfo);
 
-	cinfo->clk = devm_kcalloc(handle->dev, cinfo->num_clocks,
+	cinfo->clk = devm_kcalloc(ph->dev, cinfo->num_clocks,
 				  sizeof(*cinfo->clk), GFP_KERNEL);
 	if (!cinfo->clk)
 		return -ENOMEM;
@@ -354,16 +356,13 @@ static int scmi_clock_protocol_init(struct scmi_handle *handle)
 	for (clkid = 0; clkid < cinfo->num_clocks; clkid++) {
 		struct scmi_clock_info *clk = cinfo->clk + clkid;
 
-		ret = scmi_clock_attributes_get(handle, clkid, clk);
+		ret = scmi_clock_attributes_get(ph, clkid, clk);
 		if (!ret)
-			scmi_clock_describe_rates_get(handle, clkid, clk);
+			scmi_clock_describe_rates_get(ph, clkid, clk);
 	}
 
 	cinfo->version = version;
-	handle->clk_ops = &clk_ops;
-	handle->clk_priv = cinfo;
-
-	return 0;
+	return ph->set_priv(ph, cinfo);
 }
 
 static const struct scmi_protocol scmi_clock = {
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 60ef6cfb81bf..995f19a07b5e 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -19,6 +19,8 @@
 
 #include <asm/unaligned.h>
 
+#include "notify.h"
+
 #define SCMI_MAX_PROTO		256
 
 #define PROTOCOL_REV_MINOR_MASK	GENMASK(15, 0)
@@ -143,15 +145,6 @@ struct scmi_xfer {
 	struct completion *async_done;
 };
 
-void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
-int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
-int scmi_do_xfer_with_response(const struct scmi_handle *h,
-			       struct scmi_xfer *xfer);
-int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
-		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
-void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
-			    struct scmi_xfer *xfer);
-
 struct scmi_xfer_ops;
 
 /**
@@ -215,11 +208,10 @@ scmi_get_revision_area(const struct scmi_protocol_handle *ph);
 int scmi_handle_put(const struct scmi_handle *handle);
 struct scmi_handle *scmi_handle_get(struct device *dev);
 void scmi_set_handle(struct scmi_device *scmi_dev);
-int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
-void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
+void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
-typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
+typedef int (*scmi_prot_init_fn_t)(const struct scmi_protocol_handle *);
 
 /**
  * struct scmi_protocol  - Protocol descriptor
@@ -265,8 +257,8 @@ void __exit scmi_##name##_unregister(void) \
 
 const struct scmi_protocol *scmi_get_protocol(int protocol_id);
 
-int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id);
-void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id);
+int scmi_acquire_protocol(const struct scmi_handle *handle, u8 protocol_id);
+void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id);
 
 /* SCMI Transport */
 /**
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 97f22278c5b6..87ceb235194b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -352,12 +352,14 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 /**
  * scmi_xfer_put() - Release a transmit message
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @xfer: message that was reserved by scmi_xfer_get
  */
-void scmi_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+static void scmi_xfer_put(const struct scmi_protocol_handle *ph,
+			  struct scmi_xfer *xfer)
 {
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 
 	__scmi_xfer_put(&info->tx_minfo, xfer);
 }
@@ -376,21 +378,30 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 /**
  * scmi_do_xfer() - Do one transfer
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @xfer: Transfer to initiate and wait for response
  *
  * Return: -ETIMEDOUT in case of no response, if transmit error,
  *	return corresponding error, else if all goes well,
  *	return 0.
  */
-int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
+static int scmi_do_xfer(const struct scmi_protocol_handle *ph,
+			struct scmi_xfer *xfer)
 {
 	int ret;
 	int timeout;
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	struct device *dev = info->dev;
 	struct scmi_chan_info *cinfo;
 
+	/*
+	 * Re-instate protocol id here from protocol handle so that cannot be
+	 * overridden by mistake (or malice) by the protocol code mangling with
+	 * the scmi_xfer structure.
+	 */
+	xfer->hdr.protocol_id = pi->proto->id;
+
 	cinfo = idr_find(&info->tx_idr, xfer->hdr.protocol_id);
 	if (unlikely(!cinfo))
 		return -EINVAL;
@@ -436,10 +447,11 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	return ret;
 }
 
-void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
-			    struct scmi_xfer *xfer)
+static void scmi_reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
+				   struct scmi_xfer *xfer)
 {
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 
 	xfer->rx.len = info->desc->max_msg_size;
 }
@@ -450,21 +462,24 @@ void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
  * scmi_do_xfer_with_response() - Do one transfer and wait until the delayed
  *	response is received
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @xfer: Transfer to initiate and wait for response
  *
  * Return: -ETIMEDOUT in case of no delayed response, if transmit error,
  *	return corresponding error, else if all goes well, return 0.
  */
-int scmi_do_xfer_with_response(const struct scmi_handle *handle,
-			       struct scmi_xfer *xfer)
+static int scmi_do_xfer_with_response(const struct scmi_protocol_handle *ph,
+				      struct scmi_xfer *xfer)
 {
 	int ret, timeout = msecs_to_jiffies(SCMI_MAX_RESPONSE_TIMEOUT);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 	DECLARE_COMPLETION_ONSTACK(async_response);
 
+	xfer->hdr.protocol_id = pi->proto->id;
+
 	xfer->async_done = &async_response;
 
-	ret = scmi_do_xfer(handle, xfer);
+	ret = scmi_do_xfer(ph, xfer);
 	if (!ret && !wait_for_completion_timeout(xfer->async_done, timeout))
 		ret = -ETIMEDOUT;
 
@@ -475,9 +490,8 @@ int scmi_do_xfer_with_response(const struct scmi_handle *handle,
 /**
  * scmi_xfer_get_init() - Allocate and initialise one message for transmit
  *
- * @handle: Pointer to SCMI entity handle
+ * @ph: Pointer to SCMI protocol handle
  * @msg_id: Message identifier
- * @prot_id: Protocol identifier for the message
  * @tx_size: transmit message size
  * @rx_size: receive message size
  * @p: pointer to the allocated and initialised message
@@ -488,12 +502,14 @@ int scmi_do_xfer_with_response(const struct scmi_handle *handle,
  * Return: 0 if all went fine with @p pointing to message, else
  *	corresponding error.
  */
-int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
-		       size_t tx_size, size_t rx_size, struct scmi_xfer **p)
+static int scmi_xfer_get_init(const struct scmi_protocol_handle *ph, u8 msg_id,
+			      size_t tx_size, size_t rx_size,
+			      struct scmi_xfer **p)
 {
 	int ret;
 	struct scmi_xfer *xfer;
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 	struct scmi_xfers_info *minfo = &info->tx_minfo;
 	struct device *dev = info->dev;
 
@@ -502,7 +518,7 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	    tx_size > info->desc->max_msg_size)
 		return -ERANGE;
 
-	xfer = scmi_xfer_get(handle, minfo);
+	xfer = scmi_xfer_get(pi->handle, minfo);
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
 		dev_err(dev, "failed to get free message slot(%d)\n", ret);
@@ -512,7 +528,7 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	xfer->tx.len = tx_size;
 	xfer->rx.len = rx_size ? : info->desc->max_msg_size;
 	xfer->hdr.id = msg_id;
-	xfer->hdr.protocol_id = prot_id;
+	xfer->hdr.protocol_id = pi->proto->id;
 	xfer->hdr.poll_completion = false;
 
 	*p = xfer;
@@ -523,33 +539,30 @@ int scmi_xfer_get_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 /**
  * scmi_version_get() - command to get the revision of the SCMI entity
  *
- * @handle: Pointer to SCMI entity handle
- * @protocol: Protocol identifier for the message
+ * @ph: Pointer to SCMI protocol handle
  * @version: Holds returned version of protocol.
  *
  * Updates the SCMI information in the internal data structure.
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
-int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
-		     u32 *version)
+static int scmi_version_get(const struct scmi_protocol_handle *ph, u32 *version)
 {
 	int ret;
 	__le32 *rev_info;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_VERSION, protocol, 0,
-				 sizeof(*version), &t);
+	ret = scmi_xfer_get_init(ph, PROTOCOL_VERSION, 0, sizeof(*version), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = scmi_do_xfer(ph, t);
 	if (!ret) {
 		rev_info = t->rx.buf;
 		*version = le32_to_cpu(*rev_info);
 	}
 
-	scmi_xfer_put(handle, t);
+	scmi_xfer_put(ph, t);
 	return ret;
 }
 
@@ -604,6 +617,15 @@ scmi_get_revision_area(const struct scmi_protocol_handle *ph)
 	return pi->handle->version;
 }
 
+static const struct scmi_xfer_ops xfer_ops = {
+	.version_get = scmi_version_get,
+	.xfer_get_init = scmi_xfer_get_init,
+	.reset_rx_to_maxsz = scmi_reset_rx_to_maxsz,
+	.do_xfer = scmi_do_xfer,
+	.do_xfer_with_response = scmi_do_xfer_with_response,
+	.xfer_put = scmi_xfer_put,
+};
+
 /**
  * scmi_get_protocol_instance  - Protocol initialization helper.
  * @handle: A reference to the SCMI platform instance.
@@ -616,7 +638,7 @@ scmi_get_revision_area(const struct scmi_protocol_handle *ph)
  * Return: A reference to an initialized protocol instance or error on failure.
  */
 static struct scmi_protocol_instance * __must_check
-scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
+scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 {
 	int ret = -ENOMEM;
 	void *gid;
@@ -651,11 +673,12 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
 		pi->proto = proto;
 		pi->handle = handle;
 		pi->ph.dev = handle->dev;
+		pi->ph.xops = &xfer_ops;
 		pi->ph.set_priv = scmi_set_protocol_priv;
 		pi->ph.get_priv = scmi_get_protocol_priv;
 		refcount_set(&pi->users, 1);
 		/* proto->init is assured NON NULL by scmi_protocol_register */
-		ret = pi->proto->init(handle);
+		ret = pi->proto->init(&pi->ph);
 		if (ret)
 			goto clean;
 
@@ -666,6 +689,7 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
 
 		if (pi->proto->events)
 			scmi_register_protocol_events(handle, pi->proto->id,
+						      &pi->ph,
 						      pi->proto->events);
 
 		devres_close_group(handle->dev, pi->gid);
@@ -693,7 +717,7 @@ scmi_get_protocol_instance(struct scmi_handle *handle, u8 protocol_id)
  *
  * Return: 0 if protocol was acquired successfully.
  */
-int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
+int scmi_acquire_protocol(const struct scmi_handle *handle, u8 protocol_id)
 {
 	return PTR_ERR_OR_ZERO(scmi_get_protocol_instance(handle, protocol_id));
 }
@@ -706,7 +730,7 @@ int scmi_acquire_protocol(struct scmi_handle *handle, u8 protocol_id)
  * Remove one user for the specified protocol and triggers de-initialization
  * and resources de-allocation once the last user has gone.
  */
-void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
+void scmi_release_protocol(const struct scmi_handle *handle, u8 protocol_id)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct scmi_protocol_instance *pi;
@@ -723,7 +747,7 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
 			scmi_deregister_protocol_events(handle, protocol_id);
 
 		if (pi->proto->deinit)
-			pi->proto->deinit(handle);
+			pi->proto->deinit(&pi->ph);
 
 		idr_remove(&info->protocols, protocol_id);
 
@@ -751,7 +775,7 @@ void scmi_release_protocol(struct scmi_handle *handle, u8 protocol_id)
  *	   Must be checked for errors by caller.
  */
 static const void __must_check *
-scmi_get_protocol_operations(struct scmi_handle *handle, u8 protocol_id,
+scmi_get_protocol_operations(const struct scmi_handle *handle, u8 protocol_id,
 			     struct scmi_protocol_handle **ph)
 {
 	struct scmi_protocol_instance *pi;
@@ -768,10 +792,11 @@ scmi_get_protocol_operations(struct scmi_handle *handle, u8 protocol_id,
 	return pi->proto->ops;
 }
 
-void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
+void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp)
 {
-	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+	struct scmi_info *info = handle_to_scmi_info(pi->handle);
 
 	info->protocols_imp = prot_imp;
 }
@@ -792,7 +817,7 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
 }
 
 struct scmi_protocol_devres {
-	struct scmi_handle *handle;
+	const struct scmi_handle *handle;
 	u8 protocol_id;
 };
 
@@ -827,7 +852,7 @@ scmi_devm_get_protocol_ops(struct scmi_device *sdev, u8 protocol_id,
 {
 	struct scmi_protocol_instance *pi;
 	struct scmi_protocol_devres *dres;
-	struct scmi_handle *handle = sdev->handle;
+	const struct scmi_handle *handle = sdev->handle;
 
 	if (!ph)
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 504f5b5d557e..6d4a1d78c22e 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -176,7 +176,7 @@
 #define REVT_NOTIFY_SET_STATUS(revt, eid, sid, state)		\
 ({								\
 	typeof(revt) r = revt;					\
-	r->proto->ops->set_notify_enabled(r->proto->ni->handle,	\
+	r->proto->ops->set_notify_enabled(r->proto->ph,		\
 					(eid), (sid), (state));	\
 })
 
@@ -189,7 +189,7 @@
 #define REVT_FILL_REPORT(revt, ...)				\
 ({								\
 	typeof(revt) r = revt;					\
-	r->proto->ops->fill_custom_report(r->proto->ni->handle,	\
+	r->proto->ops->fill_custom_report(r->proto->ph,		\
 					  __VA_ARGS__);		\
 })
 
@@ -277,6 +277,7 @@ struct scmi_registered_event;
  *		       events' descriptors, whose fixed-size is determined at
  *		       compile time.
  * @registered_mtx: A mutex to protect @registered_events_handlers
+ * @ph: SCMI protocol handle reference
  * @registered_events_handlers: An hashtable containing all events' handlers
  *				descriptors registered for this protocol
  *
@@ -301,6 +302,7 @@ struct scmi_registered_events_desc {
 	struct scmi_registered_event	**registered_events;
 	/* mutex to protect registered_events_handlers */
 	struct mutex			registered_mtx;
+	const struct scmi_protocol_handle	*ph;
 	DECLARE_HASHTABLE(registered_events_handlers, SCMI_REGISTERED_HASH_SZ);
 };
 
@@ -733,6 +735,7 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
  * @handle: The handle identifying the platform instance against which the
  *	    protocol's events are registered
  * @proto_id: Protocol ID
+ * @ph: SCMI protocol handle.
  * @ee: A structure describing the events supported by this protocol.
  *
  * Used by SCMI Protocols initialization code to register with the notification
@@ -743,6 +746,7 @@ scmi_allocate_registered_events_desc(struct scmi_notify_instance *ni,
  * Return: 0 on Success
  */
 int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
+				  const struct scmi_protocol_handle *ph,
 				  const struct scmi_protocol_events *ee)
 {
 	int i;
@@ -752,7 +756,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	struct scmi_notify_instance *ni;
 	const struct scmi_event *evt;
 
-	if (!ee || !ee->ops || !ee->evts ||
+	if (!ee || !ee->ops || !ee->evts || !ph ||
 	    (!ee->num_sources && !ee->ops->get_num_sources))
 		return -EINVAL;
 
@@ -766,7 +770,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	if (ee->num_sources) {
 		num_sources = ee->num_sources;
 	} else {
-		int nsrc = ee->ops->get_num_sources(handle);
+		int nsrc = ee->ops->get_num_sources(ph);
 
 		if (nsrc <= 0)
 			return -EINVAL;
@@ -784,6 +788,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	if (IS_ERR(pd))
 		goto err;
 
+	pd->ph = ph;
 	for (i = 0; i < ee->num_events; i++, evt++) {
 		struct scmi_registered_event *r_evt;
 
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index 97ddfe55d773..3915bcd76242 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -50,10 +50,10 @@ struct scmi_protocol_handle;
  *	    process context.
  */
 struct scmi_event_ops {
-	int (*get_num_sources)(const struct scmi_handle *handle);
-	int (*set_notify_enabled)(const struct scmi_handle *handle,
+	int (*get_num_sources)(const struct scmi_protocol_handle *ph);
+	int (*set_notify_enabled)(const struct scmi_protocol_handle *ph,
 				  u8 evt_id, u32 src_id, bool enabled);
-	void *(*fill_custom_report)(const struct scmi_handle *handle,
+	void *(*fill_custom_report)(const struct scmi_protocol_handle *ph,
 				    u8 evt_id, ktime_t timestamp,
 				    const void *payld, size_t payld_sz,
 				    void *report, u32 *src_id);
@@ -82,6 +82,7 @@ void scmi_notification_exit(struct scmi_handle *handle);
 
 struct scmi_protocol_handle;
 int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
+				  const struct scmi_protocol_handle *ph,
 				  const struct scmi_protocol_events *ee);
 void scmi_deregister_protocol_events(const struct scmi_handle *handle,
 				     u8 proto_id);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 298565cd4d6d..c1d0664aaf4a 100644
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
@@ -389,24 +388,24 @@ static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_limits_set(handle, domain, max_perf, min_perf);
+	return scmi_perf_mb_limits_set(ph, domain, max_perf, min_perf);
 }
 
-static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
-				   u32 *max_perf, u32 *min_perf)
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
 
@@ -414,14 +413,14 @@ static int scmi_perf_mb_limits_get(const struct scmi_handle *handle, u32 domain,
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
@@ -430,18 +429,17 @@ static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_limits_get(handle, domain, max_perf, min_perf);
+	return scmi_perf_mb_limits_get(ph, domain, max_perf, min_perf);
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
 
@@ -450,16 +448,16 @@ static int scmi_perf_mb_level_set(const struct scmi_handle *handle, u32 domain,
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
@@ -468,35 +466,35 @@ static int scmi_perf_level_set(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_level_set(handle, domain, level, poll);
+	return scmi_perf_mb_level_set(ph, domain, level, poll);
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
@@ -504,10 +502,10 @@ static int scmi_perf_level_get(const struct scmi_handle *handle, u32 domain,
 		return 0;
 	}
 
-	return scmi_perf_mb_level_get(handle, domain, level, poll);
+	return scmi_perf_mb_level_get(ph, domain, level, poll);
 }
 
-static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
+static int scmi_perf_level_limits_notify(const struct scmi_protocol_handle *ph,
 					 u32 domain, int message_id,
 					 bool enable)
 {
@@ -515,8 +513,7 @@ static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_perf_notify_level_or_limits *notify;
 
-	ret = scmi_xfer_get_init(handle, message_id, SCMI_PROTOCOL_PERF,
-				 sizeof(*notify), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, message_id, sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
 
@@ -524,9 +521,9 @@ static int scmi_perf_level_limits_notify(const struct scmi_handle *handle,
 	notify->domain = cpu_to_le32(domain);
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
@@ -540,7 +537,7 @@ static bool scmi_perf_fc_size_is_valid(u32 msg, u32 size)
 }
 
 static void
-scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
+scmi_perf_domain_desc_fc(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 message_id, void __iomem **p_addr,
 			 struct scmi_fc_db_info **p_db)
 {
@@ -557,9 +554,8 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 	if (!p_addr)
 		return;
 
-	ret = scmi_xfer_get_init(handle, PERF_DESCRIBE_FASTCHANNEL,
-				 SCMI_PROTOCOL_PERF,
-				 sizeof(*info), sizeof(*resp), &t);
+	ret = ph->xops->xfer_get_init(ph, PERF_DESCRIBE_FASTCHANNEL,
+				      sizeof(*info), sizeof(*resp), &t);
 	if (ret)
 		return;
 
@@ -567,7 +563,7 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 	info->domain = cpu_to_le32(domain);
 	info->message_id = cpu_to_le32(message_id);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (ret)
 		goto err_xfer;
 
@@ -579,20 +575,20 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
 
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
 
@@ -605,25 +601,25 @@ scmi_perf_domain_desc_fc(const struct scmi_handle *handle, u32 domain,
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
@@ -640,14 +636,14 @@ static int scmi_dev_domain_id(struct device *dev)
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
@@ -672,11 +668,12 @@ static int scmi_dvfs_device_opps_add(const struct scmi_handle *handle,
 	return 0;
 }
 
-static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
-					    struct device *dev)
+static int
+scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
+				 struct device *dev)
 {
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	int domain = scmi_dev_domain_id(dev);
 
 	if (domain < 0)
@@ -687,35 +684,35 @@ static int scmi_dvfs_transition_latency_get(const struct scmi_handle *handle,
 	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
 }
 
-static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
+static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom = pi->dom_info + domain;
 
-	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor,
-				   poll);
+	return scmi_perf_level_set(ph, domain, freq / dom->mult_factor, poll);
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
+static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
+				   u32 domain, unsigned long *freq,
+				   unsigned long *power)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
@@ -739,11 +736,11 @@ static int scmi_dvfs_est_power_get(const struct scmi_handle *handle, u32 domain,
 	return ret;
 }
 
-static bool scmi_fast_switch_possible(const struct scmi_handle *handle,
+static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 				      struct device *dev)
 {
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	dom = pi->dom_info + scmi_dev_domain_id(dev);
 
@@ -764,7 +761,7 @@ static const struct scmi_perf_ops perf_ops = {
 	.fast_switch_possible = scmi_fast_switch_possible,
 };
 
-static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
 	int ret, cmd_id;
@@ -773,7 +770,7 @@ static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
 		return -EINVAL;
 
 	cmd_id = evt_2_cmd[evt_id];
-	ret = scmi_perf_level_limits_notify(handle, src_id, cmd_id, enable);
+	ret = scmi_perf_level_limits_notify(ph, src_id, cmd_id, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -781,7 +778,7 @@ static int scmi_perf_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
+static void *scmi_perf_fill_custom_report(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, ktime_t timestamp,
 					  const void *payld, size_t payld_sz,
 					  void *report, u32 *src_id)
@@ -829,9 +826,9 @@ static void *scmi_perf_fill_custom_report(const struct scmi_handle *handle,
 	return rep;
 }
 
-static int scmi_perf_get_num_sources(const struct scmi_handle *handle)
+static int scmi_perf_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_perf_info *pi = handle->perf_priv;
+	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	if (!pi)
 		return -EINVAL;
@@ -865,24 +862,24 @@ static const struct scmi_protocol_events perf_protocol_events = {
 	.num_events = ARRAY_SIZE(perf_events),
 };
 
-static int scmi_perf_protocol_init(struct scmi_handle *handle)
+static int scmi_perf_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int domain;
 	u32 version;
 	struct scmi_perf_info *pinfo;
 
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
@@ -890,18 +887,15 @@ static int scmi_perf_protocol_init(struct scmi_handle *handle)
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
-	handle->perf_ops = &perf_ops;
-	handle->perf_priv = pinfo;
-
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_perf = {
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 6db02dc547a7..d9ce794d0299 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -68,21 +68,21 @@ struct scmi_power_info {
 	struct power_dom_info *dom_info;
 };
 
-static int scmi_power_attributes_get(const struct scmi_handle *handle,
+static int scmi_power_attributes_get(const struct scmi_protocol_handle *ph,
 				     struct scmi_power_info *pi)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_power_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_POWER, 0, sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		pi->num_domains = le16_to_cpu(attr->num_domains);
 		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
@@ -90,28 +90,27 @@ static int scmi_power_attributes_get(const struct scmi_handle *handle,
 		pi->stats_size = le32_to_cpu(attr->stats_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
-				 struct power_dom_info *dom_info)
+scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
+				 u32 domain, struct power_dom_info *dom_info)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_power_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, POWER_DOMAIN_ATTRIBUTES,
-				 SCMI_PROTOCOL_POWER, sizeof(domain),
-				 sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_DOMAIN_ATTRIBUTES,
+				      sizeof(domain), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		u32 flags = le32_to_cpu(attr->flags);
 
@@ -121,19 +120,18 @@ scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int
-scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
+static int scmi_power_state_set(const struct scmi_protocol_handle *ph,
+				u32 domain, u32 state)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_power_set_state *st;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_SET, SCMI_PROTOCOL_POWER,
-				 sizeof(*st), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_STATE_SET, sizeof(*st), 0, &t);
 	if (ret)
 		return ret;
 
@@ -142,43 +140,43 @@ scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
 	st->domain = cpu_to_le32(domain);
 	st->state = cpu_to_le32(state);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int
-scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
+static int scmi_power_state_get(const struct scmi_protocol_handle *ph,
+				u32 domain, u32 *state)
 {
 	int ret;
 	struct scmi_xfer *t;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_GET, SCMI_PROTOCOL_POWER,
-				 sizeof(u32), sizeof(u32), &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_STATE_GET, sizeof(u32), sizeof(u32), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		*state = get_unaligned_le32(t->rx.buf);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_power_num_domains_get(const struct scmi_handle *handle)
+static int scmi_power_num_domains_get(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	struct scmi_power_info *pi = ph->get_priv(ph);
 
 	return pi->num_domains;
 }
 
-static char *scmi_power_name_get(const struct scmi_handle *handle, u32 domain)
+static char *scmi_power_name_get(const struct scmi_protocol_handle *ph,
+				 u32 domain)
 {
-	struct scmi_power_info *pi = handle->power_priv;
+	struct scmi_power_info *pi = ph->get_priv(ph);
 	struct power_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
@@ -191,15 +189,15 @@ static const struct scmi_power_ops power_ops = {
 	.state_get = scmi_power_state_get,
 };
 
-static int scmi_power_request_notify(const struct scmi_handle *handle,
+static int scmi_power_request_notify(const struct scmi_protocol_handle *ph,
 				     u32 domain, bool enable)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_power_state_notify *notify;
 
-	ret = scmi_xfer_get_init(handle, POWER_STATE_NOTIFY,
-				 SCMI_PROTOCOL_POWER, sizeof(*notify), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, POWER_STATE_NOTIFY,
+				      sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
 
@@ -207,18 +205,18 @@ static int scmi_power_request_notify(const struct scmi_handle *handle,
 	notify->domain = cpu_to_le32(domain);
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_power_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_power_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_power_request_notify(handle, src_id, enable);
+	ret = scmi_power_request_notify(ph, src_id, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLE - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -226,10 +224,10 @@ static int scmi_power_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
-					   u8 evt_id, ktime_t timestamp,
-					   const void *payld, size_t payld_sz,
-					   void *report, u32 *src_id)
+static void *
+scmi_power_fill_custom_report(const struct scmi_protocol_handle *ph, u8 evt_id,
+			      ktime_t timestamp, const void *payld,
+			      size_t payld_sz, void *report, u32 *src_id)
 {
 	const struct scmi_power_state_notify_payld *p = payld;
 	struct scmi_power_state_changed_report *r = report;
@@ -246,9 +244,9 @@ static void *scmi_power_fill_custom_report(const struct scmi_handle *handle,
 	return r;
 }
 
-static int scmi_power_get_num_sources(const struct scmi_handle *handle)
+static int scmi_power_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_power_info *pinfo = handle->power_priv;
+	struct scmi_power_info *pinfo = ph->get_priv(ph);
 
 	if (!pinfo)
 		return -EINVAL;
@@ -278,24 +276,24 @@ static const struct scmi_protocol_events power_protocol_events = {
 	.num_events = ARRAY_SIZE(power_events),
 };
 
-static int scmi_power_protocol_init(struct scmi_handle *handle)
+static int scmi_power_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int domain;
 	u32 version;
 	struct scmi_power_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Power Version %d.%d\n",
+	dev_dbg(ph->dev, "Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_power_attributes_get(handle, pinfo);
+	scmi_power_attributes_get(ph, pinfo);
 
-	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
+	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
 	if (!pinfo->dom_info)
 		return -ENOMEM;
@@ -303,14 +301,11 @@ static int scmi_power_protocol_init(struct scmi_handle *handle)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct power_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_power_domain_attributes_get(handle, domain, dom);
+		scmi_power_domain_attributes_get(ph, domain, dom);
 	}
 
 	pinfo->version = version;
-	handle->power_ops = &power_ops;
-	handle->power_priv = pinfo;
-
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_power = {
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 7102cfeb2397..a183518baf18 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -64,46 +64,45 @@ struct scmi_reset_info {
 	struct reset_dom_info *dom_info;
 };
 
-static int scmi_reset_attributes_get(const struct scmi_handle *handle,
+static int scmi_reset_attributes_get(const struct scmi_protocol_handle *ph,
 				     struct scmi_reset_info *pi)
 {
 	int ret;
 	struct scmi_xfer *t;
 	u32 attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_RESET, 0, sizeof(attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(attr), &t);
 	if (ret)
 		return ret;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		attr = get_unaligned_le32(t->rx.buf);
 		pi->num_domains = attr & NUM_RESET_DOMAIN_MASK;
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
-				 struct reset_dom_info *dom_info)
+scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
+				 u32 domain, struct reset_dom_info *dom_info)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_reset_domain_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, RESET_DOMAIN_ATTRIBUTES,
-				 SCMI_PROTOCOL_RESET, sizeof(domain),
-				 sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, RESET_DOMAIN_ATTRIBUTES,
+				      sizeof(domain), sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(domain, t->tx.buf);
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		u32 attributes = le32_to_cpu(attr->attributes);
 
@@ -115,47 +114,49 @@ scmi_reset_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
 		strlcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_reset_num_domains_get(const struct scmi_handle *handle)
+static int scmi_reset_num_domains_get(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi = ph->get_priv(ph);
 
 	return pi->num_domains;
 }
 
-static char *scmi_reset_name_get(const struct scmi_handle *handle, u32 domain)
+static char *scmi_reset_name_get(const struct scmi_protocol_handle *ph,
+				 u32 domain)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi = ph->get_priv(ph);
+
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->name;
 }
 
-static int scmi_reset_latency_get(const struct scmi_handle *handle, u32 domain)
+static int scmi_reset_latency_get(const struct scmi_protocol_handle *ph,
+				  u32 domain)
 {
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi = ph->get_priv(ph);
 	struct reset_dom_info *dom = pi->dom_info + domain;
 
 	return dom->latency_us;
 }
 
-static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
+static int scmi_domain_reset(const struct scmi_protocol_handle *ph, u32 domain,
 			     u32 flags, u32 state)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_domain_reset *dom;
-	struct scmi_reset_info *pi = handle->reset_priv;
+	struct scmi_reset_info *pi = ph->get_priv(ph);
 	struct reset_dom_info *rdom = pi->dom_info + domain;
 
 	if (rdom->async_reset)
 		flags |= ASYNCHRONOUS_RESET;
 
-	ret = scmi_xfer_get_init(handle, RESET, SCMI_PROTOCOL_RESET,
-				 sizeof(*dom), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, RESET, sizeof(*dom), 0, &t);
 	if (ret)
 		return ret;
 
@@ -165,31 +166,32 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	dom->reset_state = cpu_to_le32(state);
 
 	if (rdom->async_reset)
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ph->xops->do_xfer_with_response(ph, t);
 	else
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_reset_domain_reset(const struct scmi_handle *handle, u32 domain)
+static int scmi_reset_domain_reset(const struct scmi_protocol_handle *ph,
+				   u32 domain)
 {
-	return scmi_domain_reset(handle, domain, AUTONOMOUS_RESET,
+	return scmi_domain_reset(ph, domain, AUTONOMOUS_RESET,
 				 ARCH_COLD_RESET);
 }
 
 static int
-scmi_reset_domain_assert(const struct scmi_handle *handle, u32 domain)
+scmi_reset_domain_assert(const struct scmi_protocol_handle *ph, u32 domain)
 {
-	return scmi_domain_reset(handle, domain, EXPLICIT_RESET_ASSERT,
+	return scmi_domain_reset(ph, domain, EXPLICIT_RESET_ASSERT,
 				 ARCH_COLD_RESET);
 }
 
 static int
-scmi_reset_domain_deassert(const struct scmi_handle *handle, u32 domain)
+scmi_reset_domain_deassert(const struct scmi_protocol_handle *ph, u32 domain)
 {
-	return scmi_domain_reset(handle, domain, 0, ARCH_COLD_RESET);
+	return scmi_domain_reset(ph, domain, 0, ARCH_COLD_RESET);
 }
 
 static const struct scmi_reset_ops reset_ops = {
@@ -201,16 +203,15 @@ static const struct scmi_reset_ops reset_ops = {
 	.deassert = scmi_reset_domain_deassert,
 };
 
-static int scmi_reset_notify(const struct scmi_handle *handle, u32 domain_id,
-			     bool enable)
+static int scmi_reset_notify(const struct scmi_protocol_handle *ph,
+			     u32 domain_id, bool enable)
 {
 	int ret;
 	u32 evt_cntl = enable ? RESET_TP_NOTIFY_ALL : 0;
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, RESET_NOTIFY,
-				 SCMI_PROTOCOL_RESET, sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, RESET_NOTIFY, sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -218,18 +219,18 @@ static int scmi_reset_notify(const struct scmi_handle *handle, u32 domain_id,
 	cfg->id = cpu_to_le32(domain_id);
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_reset_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_reset_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					 u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_reset_notify(handle, src_id, enable);
+	ret = scmi_reset_notify(ph, src_id, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -237,10 +238,11 @@ static int scmi_reset_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_reset_fill_custom_report(const struct scmi_handle *handle,
-					   u8 evt_id, ktime_t timestamp,
-					   const void *payld, size_t payld_sz,
-					   void *report, u32 *src_id)
+static void *
+scmi_reset_fill_custom_report(const struct scmi_protocol_handle *ph,
+			      u8 evt_id, ktime_t timestamp,
+			      const void *payld, size_t payld_sz,
+			      void *report, u32 *src_id)
 {
 	const struct scmi_reset_issued_notify_payld *p = payld;
 	struct scmi_reset_issued_report *r = report;
@@ -257,9 +259,9 @@ static void *scmi_reset_fill_custom_report(const struct scmi_handle *handle,
 	return r;
 }
 
-static int scmi_reset_get_num_sources(const struct scmi_handle *handle)
+static int scmi_reset_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct scmi_reset_info *pinfo = handle->reset_priv;
+	struct scmi_reset_info *pinfo = ph->get_priv(ph);
 
 	if (!pinfo)
 		return -EINVAL;
@@ -288,24 +290,24 @@ static const struct scmi_protocol_events reset_protocol_events = {
 	.num_events = ARRAY_SIZE(reset_events),
 };
 
-static int scmi_reset_protocol_init(struct scmi_handle *handle)
+static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	int domain;
 	u32 version;
 	struct scmi_reset_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_RESET, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Reset Version %d.%d\n",
+	dev_dbg(ph->dev, "Reset Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
-	scmi_reset_attributes_get(handle, pinfo);
+	scmi_reset_attributes_get(ph, pinfo);
 
-	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
+	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
 	if (!pinfo->dom_info)
 		return -ENOMEM;
@@ -313,14 +315,11 @@ static int scmi_reset_protocol_init(struct scmi_handle *handle)
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
 		struct reset_dom_info *dom = pinfo->dom_info + domain;
 
-		scmi_reset_domain_attributes_get(handle, domain, dom);
+		scmi_reset_domain_attributes_get(ph, domain, dom);
 	}
 
 	pinfo->version = version;
-	handle->reset_ops = &reset_ops;
-	handle->reset_priv = pinfo;
-
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_reset = {
diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
index 9e44479f0284..2866db5d7cf9 100644
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
 
+static const struct scmi_power_ops *power_ops;
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
+	power_ops = handle->devm_get_ops(sdev, SCMI_PROTOCOL_POWER, &ph);
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
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 827dc0aa519c..a74a7938cd78 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -87,21 +87,21 @@ struct sensors_info {
 	struct scmi_sensor_info *sensors;
 };
 
-static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
+static int scmi_sensor_attributes_get(const struct scmi_protocol_handle *ph,
 				      struct sensors_info *si)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_sensor_attributes *attr;
 
-	ret = scmi_xfer_get_init(handle, PROTOCOL_ATTRIBUTES,
-				 SCMI_PROTOCOL_SENSOR, 0, sizeof(*attr), &t);
+	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
+				      0, sizeof(*attr), &t);
 	if (ret)
 		return ret;
 
 	attr = t->rx.buf;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		si->num_sensors = le16_to_cpu(attr->num_sensors);
 		si->max_requests = attr->max_requests;
@@ -110,11 +110,11 @@ static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
 		si->reg_size = le32_to_cpu(attr->reg_size);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_sensor_description_get(const struct scmi_handle *handle,
+static int scmi_sensor_description_get(const struct scmi_protocol_handle *ph,
 				       struct sensors_info *si)
 {
 	int ret, cnt;
@@ -123,8 +123,8 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_sensor_description *buf;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_DESCRIPTION_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(__le32), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_DESCRIPTION_GET,
+				      sizeof(__le32), 0, &t);
 	if (ret)
 		return ret;
 
@@ -134,7 +134,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		/* Set the number of sensors to be skipped/already read */
 		put_unaligned_le32(desc_index, t->tx.buf);
 
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (ret)
 			break;
 
@@ -142,7 +142,7 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 		num_remaining = le16_to_cpu(buf->num_remaining);
 
 		if (desc_index + num_returned > si->num_sensors) {
-			dev_err(handle->dev, "No. of sensors can't exceed %d",
+			dev_err(ph->dev, "No. of sensors can't exceed %d",
 				si->num_sensors);
 			break;
 		}
@@ -167,18 +167,18 @@ static int scmi_sensor_description_get(const struct scmi_handle *handle,
 
 		desc_index += num_returned;
 
-		scmi_reset_rx_to_maxsz(handle, t);
+		ph->xops->reset_rx_to_maxsz(ph, t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
 		 */
 	} while (num_returned && num_remaining);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
+static int scmi_sensor_trip_point_notify(const struct scmi_protocol_handle *ph,
 					 u32 sensor_id, bool enable)
 {
 	int ret;
@@ -186,8 +186,8 @@ static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_trip_point_notify *cfg;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_NOTIFY,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*cfg), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_TRIP_POINT_NOTIFY,
+				      sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
@@ -195,23 +195,23 @@ static int scmi_sensor_trip_point_notify(const struct scmi_handle *handle,
 	cfg->id = cpu_to_le32(sensor_id);
 	cfg->event_control = cpu_to_le32(evt_cntl);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static int
-scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
-			      u8 trip_id, u64 trip_value)
+scmi_sensor_trip_point_config(const struct scmi_protocol_handle *ph,
+			      u32 sensor_id, u8 trip_id, u64 trip_value)
 {
 	int ret;
 	u32 evt_cntl = SENSOR_TP_BOTH;
 	struct scmi_xfer *t;
 	struct scmi_msg_set_sensor_trip_point *trip;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_TRIP_POINT_CONFIG,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*trip), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_TRIP_POINT_CONFIG,
+				      sizeof(*trip), 0, &t);
 	if (ret)
 		return ret;
 
@@ -221,24 +221,23 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
 	trip->value_low = cpu_to_le32(trip_value & 0xffffffff);
 	trip->value_high = cpu_to_le32(trip_value >> 32);
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_sensor_reading_get(const struct scmi_handle *handle,
+static int scmi_sensor_reading_get(const struct scmi_protocol_handle *ph,
 				   u32 sensor_id, u64 *value)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_sensor_reading_get *sensor;
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = ph->get_priv(ph);
 	struct scmi_sensor_info *s = si->sensors + sensor_id;
 
-	ret = scmi_xfer_get_init(handle, SENSOR_READING_GET,
-				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor),
-				 sizeof(u64), &t);
+	ret = ph->xops->xfer_get_init(ph, SENSOR_READING_GET,
+				      sizeof(*sensor), sizeof(u64), &t);
 	if (ret)
 		return ret;
 
@@ -247,32 +246,32 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
 
 	if (s->async) {
 		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
-		ret = scmi_do_xfer_with_response(handle, t);
+		ret = ph->xops->do_xfer_with_response(ph, t);
 		if (!ret)
 			*value = get_unaligned_le64((void *)
 						    ((__le32 *)t->rx.buf + 1));
 	} else {
 		sensor->flags = cpu_to_le32(0);
-		ret = scmi_do_xfer(handle, t);
+		ret = ph->xops->do_xfer(ph, t);
 		if (!ret)
 			*value = get_unaligned_le64(t->rx.buf);
 	}
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
 static const struct scmi_sensor_info *
-scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
+scmi_sensor_info_get(const struct scmi_protocol_handle *ph, u32 sensor_id)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = ph->get_priv(ph);
 
 	return si->sensors + sensor_id;
 }
 
-static int scmi_sensor_count_get(const struct scmi_handle *handle)
+static int scmi_sensor_count_get(const struct scmi_protocol_handle *ph)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = ph->get_priv(ph);
 
 	return si->num_sensors;
 }
@@ -284,12 +283,12 @@ static const struct scmi_sensor_ops sensor_ops = {
 	.reading_get = scmi_sensor_reading_get,
 };
 
-static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_sensor_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_sensor_trip_point_notify(handle, src_id, enable);
+	ret = scmi_sensor_trip_point_notify(ph, src_id, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLED - evt[%X] dom[%d] - ret:%d\n",
 			 evt_id, src_id, ret);
@@ -297,10 +296,11 @@ static int scmi_sensor_set_notify_enabled(const struct scmi_handle *handle,
 	return ret;
 }
 
-static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
-					    u8 evt_id, ktime_t timestamp,
-					    const void *payld, size_t payld_sz,
-					    void *report, u32 *src_id)
+static void *
+scmi_sensor_fill_custom_report(const struct scmi_protocol_handle *ph,
+			       u8 evt_id, ktime_t timestamp,
+			       const void *payld, size_t payld_sz,
+			       void *report, u32 *src_id)
 {
 	const struct scmi_sensor_trip_notify_payld *p = payld;
 	struct scmi_sensor_trip_point_report *r = report;
@@ -318,9 +318,9 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
 	return r;
 }
 
-static int scmi_sensor_get_num_sources(const struct scmi_handle *handle)
+static int scmi_sensor_get_num_sources(const struct scmi_protocol_handle *ph)
 {
-	struct sensors_info *si = handle->sensor_priv;
+	struct sensors_info *si = ph->get_priv(ph);
 
 	return si->num_sensors;
 }
@@ -346,34 +346,31 @@ static const struct scmi_protocol_events sensor_protocol_events = {
 	.num_events = ARRAY_SIZE(sensor_events),
 };
 
-static int scmi_sensors_protocol_init(struct scmi_handle *handle)
+static int scmi_sensors_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	u32 version;
 	struct sensors_info *sinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
+	dev_dbg(ph->dev, "Sensor Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	sinfo = devm_kzalloc(handle->dev, sizeof(*sinfo), GFP_KERNEL);
+	sinfo = devm_kzalloc(ph->dev, sizeof(*sinfo), GFP_KERNEL);
 	if (!sinfo)
 		return -ENOMEM;
 
-	scmi_sensor_attributes_get(handle, sinfo);
+	scmi_sensor_attributes_get(ph, sinfo);
 
-	sinfo->sensors = devm_kcalloc(handle->dev, sinfo->num_sensors,
+	sinfo->sensors = devm_kcalloc(ph->dev, sinfo->num_sensors,
 				      sizeof(*sinfo->sensors), GFP_KERNEL);
 	if (!sinfo->sensors)
 		return -ENOMEM;
 
-	scmi_sensor_description_get(handle, sinfo);
+	scmi_sensor_description_get(ph, sinfo);
 
 	sinfo->version = version;
-	handle->sensor_ops = &sensor_ops;
-	handle->sensor_priv = sinfo;
-
-	return 0;
+	return ph->set_priv(ph, sinfo);
 }
 
 static const struct scmi_protocol scmi_sensors = {
diff --git a/drivers/firmware/arm_scmi/system.c b/drivers/firmware/arm_scmi/system.c
index 167f539f7d95..23365ef334bf 100644
--- a/drivers/firmware/arm_scmi/system.c
+++ b/drivers/firmware/arm_scmi/system.c
@@ -32,43 +32,43 @@ struct scmi_system_info {
 	u32 version;
 };
 
-static int scmi_system_request_notify(const struct scmi_handle *handle,
+static int scmi_system_request_notify(const struct scmi_protocol_handle *ph,
 				      bool enable)
 {
 	int ret;
 	struct scmi_xfer *t;
 	struct scmi_system_power_state_notify *notify;
 
-	ret = scmi_xfer_get_init(handle, SYSTEM_POWER_STATE_NOTIFY,
-				 SCMI_PROTOCOL_SYSTEM, sizeof(*notify), 0, &t);
+	ret = ph->xops->xfer_get_init(ph, SYSTEM_POWER_STATE_NOTIFY,
+				      sizeof(*notify), 0, &t);
 	if (ret)
 		return ret;
 
 	notify = t->tx.buf;
 	notify->notify_enable = enable ? cpu_to_le32(BIT(0)) : 0;
 
-	ret = scmi_do_xfer(handle, t);
+	ret = ph->xops->do_xfer(ph, t);
 
-	scmi_xfer_put(handle, t);
+	ph->xops->xfer_put(ph, t);
 	return ret;
 }
 
-static int scmi_system_set_notify_enabled(const struct scmi_handle *handle,
+static int scmi_system_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					  u8 evt_id, u32 src_id, bool enable)
 {
 	int ret;
 
-	ret = scmi_system_request_notify(handle, enable);
+	ret = scmi_system_request_notify(ph, enable);
 	if (ret)
 		pr_debug("FAIL_ENABLE - evt[%X] - ret:%d\n", evt_id, ret);
 
 	return ret;
 }
 
-static void *scmi_system_fill_custom_report(const struct scmi_handle *handle,
-					    u8 evt_id, ktime_t timestamp,
-					    const void *payld, size_t payld_sz,
-					    void *report, u32 *src_id)
+static void *
+scmi_system_fill_custom_report(const struct scmi_protocol_handle *ph, u8 evt_id,
+			       ktime_t timestamp, const void *payld,
+			       size_t payld_sz, void *report, u32 *src_id)
 {
 	const struct scmi_system_power_state_notifier_payld *p = payld;
 	struct scmi_system_power_state_notifier_report *r = report;
@@ -109,24 +109,22 @@ static const struct scmi_protocol_events system_protocol_events = {
 	.num_sources = SCMI_SYSTEM_NUM_SOURCES,
 };
 
-static int scmi_system_protocol_init(struct scmi_handle *handle)
+static int scmi_system_protocol_init(const struct scmi_protocol_handle *ph)
 {
 	u32 version;
 	struct scmi_system_info *pinfo;
 
-	scmi_version_get(handle, SCMI_PROTOCOL_SYSTEM, &version);
+	ph->xops->version_get(ph, &version);
 
-	dev_dbg(handle->dev, "System Power Version %d.%d\n",
+	dev_dbg(ph->dev, "System Power Version %d.%d\n",
 		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
 
-	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	pinfo = devm_kzalloc(ph->dev, sizeof(*pinfo), GFP_KERNEL);
 	if (!pinfo)
 		return -ENOMEM;
 
 	pinfo->version = version;
-	handle->system_priv = pinfo;
-
-	return 0;
+	return ph->set_priv(ph, pinfo);
 }
 
 static const struct scmi_protocol scmi_system = {
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index d421e691318b..3cb9a5c3e560 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface(SCMI) based hwmon sensor driver
  *
- * Copyright (C) 2018 ARM Ltd.
+ * Copyright (C) 2018-2020 ARM Ltd.
  * Sudeep Holla <sudeep.holla@arm.com>
  */
 
@@ -13,8 +13,10 @@
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
 
+static const struct scmi_sensor_ops *sensor_ops;
+
 struct scmi_sensors {
-	const struct scmi_handle *handle;
+	const struct scmi_protocol_handle *ph;
 	const struct scmi_sensor_info **info[hwmon_max];
 };
 
@@ -69,10 +71,9 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	u64 value;
 	const struct scmi_sensor_info *sensor;
 	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
-	const struct scmi_handle *h = scmi_sensors->handle;
 
 	sensor = *(scmi_sensors->info[type] + channel);
-	ret = h->sensor_ops->reading_get(h, sensor->id, &value);
+	ret = sensor_ops->reading_get(scmi_sensors->ph, sensor->id, &value);
 	if (ret)
 		return ret;
 
@@ -169,11 +170,16 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	struct hwmon_channel_info *scmi_hwmon_chan;
 	const struct hwmon_channel_info **ptr_scmi_ci;
 	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->sensor_ops)
+	if (!handle)
 		return -ENODEV;
 
-	nr_sensors = handle->sensor_ops->count_get(handle);
+	sensor_ops = handle->devm_get_ops(sdev, SCMI_PROTOCOL_SENSOR, &ph);
+	if (IS_ERR(sensor_ops))
+		return PTR_ERR(sensor_ops);
+
+	nr_sensors = sensor_ops->count_get(ph);
 	if (!nr_sensors)
 		return -EIO;
 
@@ -181,10 +187,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	if (!scmi_sensors)
 		return -ENOMEM;
 
-	scmi_sensors->handle = handle;
+	scmi_sensors->ph = ph;
 
 	for (i = 0; i < nr_sensors; i++) {
-		sensor = handle->sensor_ops->info_get(handle, i);
+		sensor = sensor_ops->info_get(ph, i);
 		if (!sensor)
 			return -EINVAL;
 
@@ -234,7 +240,7 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
 	}
 
 	for (i = nr_sensors - 1; i >= 0 ; i--) {
-		sensor = handle->sensor_ops->info_get(handle, i);
+		sensor = sensor_ops->info_get(ph, i);
 		if (!sensor)
 			continue;
 
diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 8d3a858e3b19..c3d97dafdda4 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -2,7 +2,7 @@
 /*
  * ARM System Control and Management Interface (ARM SCMI) reset driver
  *
- * Copyright (C) 2019 ARM Ltd.
+ * Copyright (C) 2019-2020 ARM Ltd.
  */
 
 #include <linux/module.h>
@@ -11,18 +11,20 @@
 #include <linux/reset-controller.h>
 #include <linux/scmi_protocol.h>
 
+static const struct scmi_reset_ops *reset_ops;
+
 /**
  * struct scmi_reset_data - reset controller information structure
  * @rcdev: reset controller entity
- * @handle: ARM SCMI handle used for communication with system controller
+ * @ph: ARM SCMI protocol handle used for communication with system controller
  */
 struct scmi_reset_data {
 	struct reset_controller_dev rcdev;
-	const struct scmi_handle *handle;
+	const struct scmi_protocol_handle *ph;
 };
 
 #define to_scmi_reset_data(p)	container_of((p), struct scmi_reset_data, rcdev)
-#define to_scmi_handle(p)	(to_scmi_reset_data(p)->handle)
+#define to_scmi_handle(p)	(to_scmi_reset_data(p)->ph)
 
 /**
  * scmi_reset_assert() - assert device reset
@@ -37,9 +39,9 @@ struct scmi_reset_data {
 static int
 scmi_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	const struct scmi_handle *handle = to_scmi_handle(rcdev);
+	const struct scmi_protocol_handle *ph = to_scmi_handle(rcdev);
 
-	return handle->reset_ops->assert(handle, id);
+	return reset_ops->assert(ph, id);
 }
 
 /**
@@ -55,9 +57,9 @@ scmi_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
 static int
 scmi_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	const struct scmi_handle *handle = to_scmi_handle(rcdev);
+	const struct scmi_protocol_handle *ph = to_scmi_handle(rcdev);
 
-	return handle->reset_ops->deassert(handle, id);
+	return reset_ops->deassert(ph, id);
 }
 
 /**
@@ -73,9 +75,9 @@ scmi_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 static int
 scmi_reset_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	const struct scmi_handle *handle = to_scmi_handle(rcdev);
+	const struct scmi_protocol_handle *ph = to_scmi_handle(rcdev);
 
-	return handle->reset_ops->reset(handle, id);
+	return reset_ops->reset(ph, id);
 }
 
 static const struct reset_control_ops scmi_reset_ops = {
@@ -90,10 +92,15 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
 
-	if (!handle || !handle->reset_ops)
+	if (!handle)
 		return -ENODEV;
 
+	reset_ops = handle->devm_get_ops(sdev, SCMI_PROTOCOL_RESET, &ph);
+	if (IS_ERR(reset_ops))
+		return PTR_ERR(reset_ops);
+
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -101,8 +108,8 @@ static int scmi_reset_probe(struct scmi_device *sdev)
 	data->rcdev.ops = &scmi_reset_ops;
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.of_node = np;
-	data->rcdev.nr_resets = handle->reset_ops->num_domains_get(handle);
-	data->handle = handle;
+	data->rcdev.nr_resets = reset_ops->num_domains_get(ph);
+	data->ph = ph;
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index d95e43c3ea08..383b3d0ca383 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -71,16 +71,16 @@ struct scmi_protocol_handle;
  * @disable: disables the specified clock
  */
 struct scmi_clk_ops {
-	int (*count_get)(const struct scmi_handle *handle);
+	int (*count_get)(const struct scmi_protocol_handle *ph);
 
 	const struct scmi_clock_info *(*info_get)
-		(const struct scmi_handle *handle, u32 clk_id);
-	int (*rate_get)(const struct scmi_handle *handle, u32 clk_id,
+		(const struct scmi_protocol_handle *ph, u32 clk_id);
+	int (*rate_get)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			u64 *rate);
-	int (*rate_set)(const struct scmi_handle *handle, u32 clk_id,
+	int (*rate_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			u64 rate);
-	int (*enable)(const struct scmi_handle *handle, u32 clk_id);
-	int (*disable)(const struct scmi_handle *handle, u32 clk_id);
+	int (*enable)(const struct scmi_protocol_handle *ph, u32 clk_id);
+	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id);
 };
 
 /**
@@ -102,26 +102,26 @@ struct scmi_clk_ops {
  *	at a given frequency
  */
 struct scmi_perf_ops {
-	int (*limits_set)(const struct scmi_handle *handle, u32 domain,
+	int (*limits_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 max_perf, u32 min_perf);
-	int (*limits_get)(const struct scmi_handle *handle, u32 domain,
+	int (*limits_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			  u32 *max_perf, u32 *min_perf);
-	int (*level_set)(const struct scmi_handle *handle, u32 domain,
+	int (*level_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 level, bool poll);
-	int (*level_get)(const struct scmi_handle *handle, u32 domain,
+	int (*level_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 *level, bool poll);
 	int (*device_domain_id)(struct device *dev);
-	int (*transition_latency_get)(const struct scmi_handle *handle,
+	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
 				      struct device *dev);
-	int (*device_opps_add)(const struct scmi_handle *handle,
+	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
 			       struct device *dev);
-	int (*freq_set)(const struct scmi_handle *handle, u32 domain,
+	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			unsigned long rate, bool poll);
-	int (*freq_get)(const struct scmi_handle *handle, u32 domain,
+	int (*freq_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			unsigned long *rate, bool poll);
-	int (*est_power_get)(const struct scmi_handle *handle, u32 domain,
+	int (*est_power_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			     unsigned long *rate, unsigned long *power);
-	bool (*fast_switch_possible)(const struct scmi_handle *handle,
+	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
 				     struct device *dev);
 };
 
@@ -135,8 +135,8 @@ struct scmi_perf_ops {
  * @state_get: gets the power state of a power domain
  */
 struct scmi_power_ops {
-	int (*num_domains_get)(const struct scmi_handle *handle);
-	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
 #define SCMI_POWER_STATE_TYPE_SHIFT	30
 #define SCMI_POWER_STATE_ID_MASK	(BIT(28) - 1)
 #define SCMI_POWER_STATE_PARAM(type, id) \
@@ -144,9 +144,9 @@ struct scmi_power_ops {
 		((id) & SCMI_POWER_STATE_ID_MASK))
 #define SCMI_POWER_STATE_GENERIC_ON	SCMI_POWER_STATE_PARAM(0, 0)
 #define SCMI_POWER_STATE_GENERIC_OFF	SCMI_POWER_STATE_PARAM(1, 0)
-	int (*state_set)(const struct scmi_handle *handle, u32 domain,
+	int (*state_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 state);
-	int (*state_get)(const struct scmi_handle *handle, u32 domain,
+	int (*state_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			 u32 *state);
 };
 
@@ -182,12 +182,12 @@ enum scmi_sensor_class {
  * @reading_get: gets the current value of the sensor
  */
 struct scmi_sensor_ops {
-	int (*count_get)(const struct scmi_handle *handle);
+	int (*count_get)(const struct scmi_protocol_handle *ph);
 	const struct scmi_sensor_info *(*info_get)
-		(const struct scmi_handle *handle, u32 sensor_id);
-	int (*trip_point_config)(const struct scmi_handle *handle,
+		(const struct scmi_protocol_handle *ph, u32 sensor_id);
+	int (*trip_point_config)(const struct scmi_protocol_handle *ph,
 				 u32 sensor_id, u8 trip_id, u64 trip_value);
-	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
+	int (*reading_get)(const struct scmi_protocol_handle *ph, u32 sensor_id,
 			   u64 *value);
 };
 
@@ -203,12 +203,12 @@ struct scmi_sensor_ops {
  * @deassert: explicitly deassert reset signal of the specified reset domain
  */
 struct scmi_reset_ops {
-	int (*num_domains_get)(const struct scmi_handle *handle);
-	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
-	int (*latency_get)(const struct scmi_handle *handle, u32 domain);
-	int (*reset)(const struct scmi_handle *handle, u32 domain);
-	int (*assert)(const struct scmi_handle *handle, u32 domain);
-	int (*deassert)(const struct scmi_handle *handle, u32 domain);
+	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+	char *(*name_get)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*latency_get)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*reset)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*assert)(const struct scmi_protocol_handle *ph, u32 domain);
+	int (*deassert)(const struct scmi_protocol_handle *ph, u32 domain);
 };
 
 /**
@@ -272,11 +272,6 @@ struct scmi_notify_ops {
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
- * @power_ops: pointer to set of power protocol operations
- * @perf_ops: pointer to set of performance protocol operations
- * @clk_ops: pointer to set of clock protocol operations
- * @sensor_ops: pointer to set of sensor protocol operations
- * @reset_ops: pointer to set of reset protocol operations
  * @devm_get_ops: devres managed method to acquire a protocol and get specific
  *		  operations and a dedicated protocol handler
  * @devm_put_ops: devres managed method to release a protocol
@@ -284,27 +279,12 @@ struct scmi_notify_ops {
  *	     dedicated protocol handler
  * @put_ops: method to release a protocol
  * @notify_ops: pointer to set of notifications related operations
- * @perf_priv: pointer to private data structure specific to performance
- *	protocol(for internal use only)
- * @clk_priv: pointer to private data structure specific to clock
- *	protocol(for internal use only)
- * @power_priv: pointer to private data structure specific to power
- *	protocol(for internal use only)
- * @sensor_priv: pointer to private data structure specific to sensors
- *	protocol(for internal use only)
- * @reset_priv: pointer to private data structure specific to reset
- *	protocol(for internal use only)
  * @notify_priv: pointer to private data structure specific to notifications
  *	(for internal use only)
  */
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
-	const struct scmi_perf_ops *perf_ops;
-	const struct scmi_clk_ops *clk_ops;
-	const struct scmi_power_ops *power_ops;
-	const struct scmi_sensor_ops *sensor_ops;
-	const struct scmi_reset_ops *reset_ops;
 
 	const void __must_check *
 		(*devm_get_ops)(struct scmi_device *sdev, u8 proto,
@@ -312,19 +292,12 @@ struct scmi_handle {
 	void (*devm_put_ops)(struct scmi_device *sdev, u8 proto);
 
 	const void __must_check *
-		(*get_ops)(struct scmi_handle *handle, u8 proto,
+		(*get_ops)(const struct scmi_handle *handle, u8 proto,
 			   struct scmi_protocol_handle **ph);
-	void (*put_ops)(struct scmi_handle *handle, u8 proto);
+	void (*put_ops)(const struct scmi_handle *handle, u8 proto);
 
 	const struct scmi_notify_ops *notify_ops;
-	/* for protocol internal use */
-	void *perf_priv;
-	void *clk_priv;
-	void *power_priv;
-	void *sensor_priv;
-	void *reset_priv;
 	void *notify_priv;
-	void *system_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.17.1


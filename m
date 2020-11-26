Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CB72C51ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbgKZKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:18:55 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:10880 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387712AbgKZKSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:18:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606385933; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=B7LBpxIQgQFjP8GwwvZLTBgtnCZkRDCBJW0mPGTE5dw=; b=ERpTcaGXy5GSlKzN/2/iusaITMtX62xeJf23Gf4uhWBvFXNVVuCKlGDFfCsK7JY5haeV+onH
 atHODn9/uefp5z7d7e7/wJrigY34syt9BuVA4L3YJ57FweMhl73ave/XYwQJDKLChqAU+oK+
 UIMUtjrcNiAeCWcT1Mvq0D6tJ3Q=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fbf81071dba509aaedacc26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Nov 2020 10:18:47
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D869C43465; Thu, 26 Nov 2020 10:18:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D50CC43460;
        Thu, 26 Nov 2020 10:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D50CC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        tkjos@google.com, dianders@chromium.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH 1/3] drivers: qcom: rpmh: Disallow active requests in solver mode
Date:   Thu, 26 Nov 2020 15:48:16 +0530
Message-Id: <1606385898-8609-2-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606385898-8609-1-git-send-email-mkshah@codeaurora.org>
References: <1606385898-8609-1-git-send-email-mkshah@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Controllers may be in 'solver' state, where they could be in autonomous
mode executing low power modes for their hardware and as such are not
available for sending active votes. Device driver may notify RPMH
that the controller is in solver mode and when in such mode, disallow
requests from platform drivers for state change using the RSC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  5 ++++
 drivers/soc/qcom/rpmh-rsc.c      | 31 ++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          | 56 ++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/trace-rpmh.h    | 20 ++++++++++++++
 include/soc/qcom/rpmh.h          |  5 ++++
 5 files changed, 117 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 344ba68..79486d6 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -77,12 +77,14 @@ struct rpmh_request {
  * @cache: the list of cached requests
  * @cache_lock: synchronize access to the cache data
  * @dirty: was the cache updated since flush
+ * @in_solver_mode: Controller is busy in solver mode
  * @batch_cache: Cache sleep and wake requests sent as batch
  */
 struct rpmh_ctrlr {
 	struct list_head cache;
 	spinlock_t cache_lock;
 	bool dirty;
+	bool in_solver_mode;
 	struct list_head batch_cache;
 };
 
@@ -94,6 +96,7 @@ struct rpmh_ctrlr {
  * @tcs_base:           Start address of the TCS registers in this controller.
  * @id:                 Instance id in the controller (Direct Resource Voter).
  * @num_tcs:            Number of TCSes in this DRV.
+ * @in_solver_mode:     Controller is busy in solver mode
  * @rsc_pm:             CPU PM notifier for controller.
  *                      Used when solver mode is not present.
  * @cpus_in_pm:         Number of CPUs not in idle power collapse.
@@ -116,6 +119,7 @@ struct rsc_drv {
 	void __iomem *tcs_base;
 	int id;
 	int num_tcs;
+	bool in_solver_mode;
 	struct notifier_block rsc_pm;
 	atomic_t cpus_in_pm;
 	struct tcs_group tcs[TCS_TYPE_NR];
@@ -129,6 +133,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 void rpmh_rsc_invalidate(struct rsc_drv *drv);
+int rpmh_rsc_mode_solver_set(struct rsc_drv *drv, bool enable);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 int rpmh_flush(struct rpmh_ctrlr *ctrlr);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 37969dc..ffb4ca7 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -638,6 +638,12 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 
 	spin_lock_irqsave(&drv->lock, flags);
 
+	if (drv->in_solver_mode) {
+		/* Controller is busy in 'solver' mode */
+		spin_unlock_irqrestore(&drv->lock, flags);
+		return -EBUSY;
+	}
+
 	/* Wait forever for a free tcs. It better be there eventually! */
 	wait_event_lock_irq(drv->tcs_wait,
 			    (tcs_id = claim_tcs_for_req(drv, tcs, msg)) >= 0,
@@ -859,6 +865,31 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
 	return ret;
 }
 
+/**
+ * rpmh_rsc_mode_solver_set() - Enable/disable solver mode.
+ * @drv:     The controller.
+ * @enable:  Boolean state to be set - true/false
+ *
+ * Return:
+ * * 0			- success
+ * * -EBUSY		- AMCs are busy
+ */
+int rpmh_rsc_mode_solver_set(struct rsc_drv *drv, bool enable)
+{
+	int ret = -EBUSY;
+
+	if (spin_trylock(&drv->lock)) {
+		if (!enable || !rpmh_rsc_ctrlr_is_busy(drv)) {
+			drv->in_solver_mode = enable;
+			trace_rpmh_solver_set(drv, enable);
+			ret = 0;
+		}
+		spin_unlock(&drv->lock);
+	}
+
+	return ret;
+}
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv, void __iomem *base)
 {
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 01765ee..cbe6b96 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -76,6 +76,22 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
 	return &drv->client;
 }
 
+static int check_ctrlr_state(struct rpmh_ctrlr *ctrlr, enum rpmh_state state)
+{
+	int ret = 0;
+
+	if (state != RPMH_ACTIVE_ONLY_STATE)
+		return ret;
+
+	/* Do not allow sending active votes when in solver mode */
+	spin_lock(&ctrlr->cache_lock);
+	if (ctrlr->in_solver_mode)
+		ret = -EBUSY;
+	spin_unlock(&ctrlr->cache_lock);
+
+	return ret;
+}
+
 void rpmh_tx_done(const struct tcs_request *msg, int r)
 {
 	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
@@ -229,9 +245,14 @@ static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
 int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 n)
 {
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	struct rpmh_request *rpm_msg;
 	int ret;
 
+	ret = check_ctrlr_state(ctrlr, state);
+	if (ret)
+		return ret;
+
 	rpm_msg = kzalloc(sizeof(*rpm_msg), GFP_ATOMIC);
 	if (!rpm_msg)
 		return -ENOMEM;
@@ -262,8 +283,13 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 {
 	DECLARE_COMPLETION_ONSTACK(compl);
 	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	int ret;
 
+	ret = check_ctrlr_state(ctrlr, state);
+	if (ret)
+		return ret;
+
 	ret = __fill_rpmh_msg(&rpm_msg, state, cmd, n);
 	if (ret)
 		return ret;
@@ -338,6 +364,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	int ret, i;
 	void *ptr;
 
+	ret = check_ctrlr_state(ctrlr, state);
+	if (ret)
+		return ret;
+
 	if (!cmd || !n)
 		return -EINVAL;
 
@@ -505,3 +535,29 @@ void rpmh_invalidate(const struct device *dev)
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 }
 EXPORT_SYMBOL(rpmh_invalidate);
+
+/**
+ * rpmh_mode_solver_set() - Indicate that the RSC controller hardware has
+ * been configured to be in solver mode
+ *
+ * @dev: The device making the request
+ * @enable: Boolean value indicating if the controller is in solver mode.
+ *
+ * Return:
+ * * 0          - Success
+ * * Error code - Otherwise
+ */
+int rpmh_mode_solver_set(const struct device *dev, bool enable)
+{
+	int ret;
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	spin_lock(&ctrlr->cache_lock);
+	ret = rpmh_rsc_mode_solver_set(ctrlr_to_drv(ctrlr), enable);
+	if (!ret)
+		ctrlr->in_solver_mode = enable;
+	spin_unlock(&ctrlr->cache_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_mode_solver_set);
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
index feb0cb4..b2b934c 100644
--- a/drivers/soc/qcom/trace-rpmh.h
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -71,6 +71,26 @@ TRACE_EVENT(rpmh_send_msg,
 		  __entry->addr, __entry->data, __entry->wait)
 );
 
+TRACE_EVENT(rpmh_solver_set,
+
+	TP_PROTO(struct rsc_drv *d, bool set),
+
+	TP_ARGS(d, set),
+
+	TP_STRUCT__entry(
+			 __string(name, d->name)
+			 __field(bool, set)
+	),
+
+	TP_fast_assign(
+		       __assign_str(name, d->name);
+		       __entry->set = set;
+	),
+
+	TP_printk("%s: solver mode set: %d",
+		  __get_str(name), __entry->set)
+);
+
 #endif /* _TRACE_RPMH_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index bdbee1a..fa8bb53 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -20,6 +20,8 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 *n);
 
+int rpmh_mode_solver_set(const struct device *dev, bool enable);
+
 void rpmh_invalidate(const struct device *dev);
 
 #else
@@ -38,6 +40,9 @@ static inline int rpmh_write_batch(const struct device *dev,
 				   const struct tcs_cmd *cmd, u32 *n)
 { return -ENODEV; }
 
+static int rpmh_mode_solver_set(const struct device *dev, bool enable)
+{ return -ENODEV; }
+
 static inline void rpmh_invalidate(const struct device *dev)
 {
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


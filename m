Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1F01E4F23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 22:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgE0UWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 16:22:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54632 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbgE0UWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:22:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590610974; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kaXpJWySm8V8fWorli3+KZiQaHhCwHYGI4YHOvlKWA0=; b=pAphWKMwvjkVLNeKSnJ6cw4Ho4amA6caVTivVkIZgtwb7njssg3F3B7GCFR4Pl6xq4r0Isrq
 PL9XnvmwVVscoVndKvMYe0tPltCJyDSg3nvaEkiqHI5WxTSnVqajb0Rg+hvRDM3YkazKx3VC
 hqCuGJvpRQb33KXH7exxsX2DxUU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ececc0dbf0e32d254665e55 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 20:22:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69C3FC433AD; Wed, 27 May 2020 20:22:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 316FCC433CA;
        Wed, 27 May 2020 20:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 316FCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, mka@chromium.org
Cc:     nm@ti.com, bjorn.andersson@linaro.org, agross@kernel.org,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, smasetty@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 3/5] OPP: Add and export helper to set bandwidth
Date:   Thu, 28 May 2020 01:51:51 +0530
Message-Id: <20200527202153.11659-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200527202153.11659-1-sibis@codeaurora.org>
References: <20200527202153.11659-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and export 'dev_pm_opp_set_bw' to set the bandwidth
levels associated with an OPP.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v5:
https://lkml.org/lkml/2020/5/27/7
 * Rework the patch based on ^^

v4:
https://patchwork.kernel.org/patch/11019737/
 * Pass device opp to set bw levels [Bjorn]

 drivers/opp/core.c     | 31 +++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index df12c38045330..c87e69f26e976 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -831,6 +831,37 @@ static int _set_required_opps(struct device *dev,
 	return ret;
 }
 
+/**
+ * dev_pm_opp_set_bw() - sets bandwidth levels corresponding to an opp
+ * @dev:	device for which we do this operation
+ * @opp:	opp based on which the bandwidth levels are to be configured
+ *
+ * This configures the bandwidth to the levels specified by the OPP. However
+ * if the OPP specified is NULL the bandwidth levels are cleared out.
+ *
+ * Return: 0 on success or a negative error value.
+ */
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: device opp table doesn't exist\n", __func__);
+		return PTR_ERR(opp_table);
+	}
+
+	if (opp)
+		ret = _set_opp_bw(opp_table, opp, dev, false);
+	else
+		ret = _set_opp_bw(opp_table, opp, dev, true);
+
+	dev_pm_opp_put_opp_table(opp_table);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_bw);
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index d5c4a329321dd..ae68417c0ae00 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -151,6 +151,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
+int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 void dev_pm_opp_remove_table(struct device *dev);
@@ -342,6 +343,11 @@ static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_f
 	return -ENOTSUPP;
 }
 
+static inline int dev_pm_opp_set_bw(struct device *dev, struct dev_pm_opp *opp)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask)
 {
 	return -ENOTSUPP;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


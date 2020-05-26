Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906961D55CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 18:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgEOQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 12:23:14 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62934 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:23:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589559791; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/cjiKMtWjyQDHb/fWlonhViUa3h5d5yJ+6+0Knzjss0=; b=g+R8gxd1KRVSGmoZI+XxBscb3hVCoSBjyhdvUJigKHMQm2a4kg2KlrkWQPJi1mul9eEXON1E
 hiCx30K6mGRLOMKgkT0C3CLWzxNvKouQlVmrTzib/986ALBrhm0UFL28/gD7FttabbcwlVCv
 jwGEHKRv8LQmASgiZYEgsOn+sfs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebec1de.7f54e714ee30-smtp-out-n02;
 Fri, 15 May 2020 16:22:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 670B1C432C2; Fri, 15 May 2020 16:22:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0B23C433F2;
        Fri, 15 May 2020 16:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0B23C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        coresight@lists.linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv3 1/2] coresight: etm4x: Add support to skip trace unit power up
Date:   Fri, 15 May 2020 21:52:32 +0530
Message-Id: <d29a1d5a29541d216f4a6f184f2db27dfe7232b1.1589558615.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1589558615.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1589558615.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

On some Qualcomm Technologies Inc. SoCs like SC7180, there
exists a hardware errata where the APSS (Application Processor
SubSystem)/CPU watchdog counter is stopped when the trace unit
power up ETM register is set (TRCPDCR.PU = 1). Since the ETMs
share the same power domain as that of respective CPU cores,
they are powered on when the CPU core is powered on. So we can
skip powering up of trace unit after checking for this errata
via new property called "qcom,skip-power-up".

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 27 ++++++++++++-------
 drivers/hwtracing/coresight/coresight-etm4x.h |  3 +++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index fb0f5f4f3a91..c16532e1e968 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -196,12 +196,14 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(config->vmid_mask0, drvdata->base + TRCVMIDCCTLR0);
 	writel_relaxed(config->vmid_mask1, drvdata->base + TRCVMIDCCTLR1);
 
-	/*
-	 * Request to keep the trace unit powered and also
-	 * emulation of powerdown
-	 */
-	writel_relaxed(readl_relaxed(drvdata->base + TRCPDCR) | TRCPDCR_PU,
-		       drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up) {
+		/*
+		 * Request to keep the trace unit powered and also
+		 * emulation of powerdown
+		 */
+		writel_relaxed(readl_relaxed(drvdata->base + TRCPDCR) |
+			       TRCPDCR_PU, drvdata->base + TRCPDCR);
+	}
 
 	/* Enable the trace unit */
 	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
@@ -476,10 +478,12 @@ static void etm4_disable_hw(void *info)
 
 	CS_UNLOCK(drvdata->base);
 
-	/* power can be removed from the trace unit now */
-	control = readl_relaxed(drvdata->base + TRCPDCR);
-	control &= ~TRCPDCR_PU;
-	writel_relaxed(control, drvdata->base + TRCPDCR);
+	if (!drvdata->skip_power_up) {
+		/* power can be removed from the trace unit now */
+		control = readl_relaxed(drvdata->base + TRCPDCR);
+		control &= ~TRCPDCR_PU;
+		writel_relaxed(control, drvdata->base + TRCPDCR);
+	}
 
 	control = readl_relaxed(drvdata->base + TRCPRGCTLR);
 
@@ -1429,6 +1433,9 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 			return -ENOMEM;
 	}
 
+	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	/* Validity for the resource is already checked by the AMBA core */
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 4a695bf90582..72c9a55e67df 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -407,6 +407,8 @@ struct etmv4_save_state {
  * @config:	structure holding configuration parameters.
  * @save_state:	State to be preserved across power loss
  * @state_needs_restore: True when there is context to restore after PM exit
+ * @skip_power_up: Indicates if an implementation can skip powering up
+ *		   the trace unit.
  */
 struct etmv4_drvdata {
 	void __iomem			*base;
@@ -454,6 +456,7 @@ struct etmv4_drvdata {
 	struct etmv4_config		config;
 	struct etmv4_save_state		*save_state;
 	bool				state_needs_restore;
+	bool				skip_power_up;
 };
 
 /* Address comparator access types */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

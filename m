Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1CE2C65FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgK0Mum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:50:42 -0500
Received: from z5.mailgun.us ([104.130.96.5]:28797 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbgK0Mum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:50:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606481441; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=TaRZz9Bdo7Lgel06rJK7JrsCK6fVn7n/WrN3GD5UE3s=; b=EG+nSl9mLzfVgBuftoVQuzjXTCRBvGkHYYac+zYvug+GXVRg0hkVETScsIN1TmIo+XacoPV3
 5YJDZPFV5/5UCEohltIMEqcaUyfxG9fXP2+nmv7eMyBaT6aCX8dmgpjAsDZLHwfhmcMQXw14
 Rbmz8Zj6Z6dPq3nVrZ24JgKjU7M=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fc0f61b9e87e163521b7067 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Nov 2020 12:50:35
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E38FC43462; Fri, 27 Nov 2020 12:50:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akhilpo-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED286C433ED;
        Fri, 27 Nov 2020 12:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED286C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
From:   Akhil P Oommen <akhilpo@codeaurora.org>
To:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     robh@kernel.org, dri-devel@freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcrouse@codeaurora.org, mka@chromium.org, robdclark@gmail.com,
        dianders@chromium.org
Subject: [PATCH v2 1/3] drm/msm: adreno: Make speed-bin support generic
Date:   Fri, 27 Nov 2020 18:19:44 +0530
Message-Id: <1606481386-22867-1-git-send-email-akhilpo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far a530v2 gpu has support for detecting its supported opps
based on a fuse value called speed-bin. This patch makes this
support generic across gpu families. This is in preparation to
extend speed-bin support to a6x family.

Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
---
Changes from v1:
	1. Added the changes to support a618 sku to the series.
	2. Avoid failing probe in case of an unsupported sku. (Rob)

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 34 --------------
 drivers/gpu/drm/msm/adreno/adreno_device.c |  4 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 71 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  5 +++
 4 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 8fa5c91..7d42321 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1531,38 +1531,6 @@ static const struct adreno_gpu_funcs funcs = {
 	.get_timestamp = a5xx_get_timestamp,
 };
 
-static void check_speed_bin(struct device *dev)
-{
-	struct nvmem_cell *cell;
-	u32 val;
-
-	/*
-	 * If the OPP table specifies a opp-supported-hw property then we have
-	 * to set something with dev_pm_opp_set_supported_hw() or the table
-	 * doesn't get populated so pick an arbitrary value that should
-	 * ensure the default frequencies are selected but not conflict with any
-	 * actual bins
-	 */
-	val = 0x80;
-
-	cell = nvmem_cell_get(dev, "speed_bin");
-
-	if (!IS_ERR(cell)) {
-		void *buf = nvmem_cell_read(cell, NULL);
-
-		if (!IS_ERR(buf)) {
-			u8 bin = *((u8 *) buf);
-
-			val = (1 << bin);
-			kfree(buf);
-		}
-
-		nvmem_cell_put(cell);
-	}
-
-	dev_pm_opp_set_supported_hw(dev, &val, 1);
-}
-
 struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -1588,8 +1556,6 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	a5xx_gpu->lm_leakage = 0x4E001A;
 
-	check_speed_bin(&pdev->dev);
-
 	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 4);
 	if (ret) {
 		a5xx_destroy(&(a5xx_gpu->base.base));
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 87c8b03..e0ff16c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -18,6 +18,8 @@ bool snapshot_debugbus = false;
 MODULE_PARM_DESC(snapshot_debugbus, "Include debugbus sections in GPU devcoredump (if not fused off)");
 module_param_named(snapshot_debugbus, snapshot_debugbus, bool, 0600);
 
+const u32 a530v2_speedbins[] = {0, 1, 2, 3, 4, 5, 6, 7};
+
 static const struct adreno_info gpulist[] = {
 	{
 		.rev   = ADRENO_REV(2, 0, 0, 0),
@@ -163,6 +165,8 @@ static const struct adreno_info gpulist[] = {
 			ADRENO_QUIRK_FAULT_DETECT_MASK,
 		.init = a5xx_gpu_init,
 		.zapfw = "a530_zap.mdt",
+		.speedbins = a530v2_speedbins,
+		.speedbins_count = ARRAY_SIZE(a530v2_speedbins),
 	}, {
 		.rev = ADRENO_REV(5, 4, 0, 2),
 		.revn = 540,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f21561d..b342fa4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -14,6 +14,7 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/nvmem-consumer.h>
 #include <soc/qcom/ocmem.h>
 #include "adreno_gpu.h"
 #include "msm_gem.h"
@@ -891,6 +892,69 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
 			   adreno_ocmem->hdl);
 }
 
+static int adreno_set_supported_hw(struct device *dev,
+		struct adreno_gpu *adreno_gpu)
+{
+	u8 speedbins_count = adreno_gpu->info->speedbins_count;
+	const u32 *speedbins = adreno_gpu->info->speedbins;
+	struct nvmem_cell *cell;
+	u32 bin, i;
+	u32 val = 0;
+	void *buf, *opp_table;
+
+	cell = nvmem_cell_get(dev, "speed_bin");
+	/*
+	 * -ENOENT means that the platform doesn't support speedbin which is
+	 * fine
+	 */
+	if (PTR_ERR(cell) == -ENOENT)
+		return 0;
+	else if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	if (!speedbins)
+		goto done;
+
+	buf = nvmem_cell_read(cell, NULL);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+
+	bin = *((u32 *) buf);
+
+	for (i = 0; i < speedbins_count; i++) {
+		if (bin == speedbins[i]) {
+			val = (1 << i);
+			break;
+		}
+	}
+
+	kfree(buf);
+done:
+	nvmem_cell_put(cell);
+
+	if (!val) {
+		DRM_DEV_ERROR(dev,
+				"missing support for speed-bin: %u. Some OPPs may not be supported by hardware",
+				bin);
+		val = ~0U;
+	}
+
+	opp_table = dev_pm_opp_set_supported_hw(dev, &val, 1);
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
+
+	adreno_gpu->opp_table = opp_table;
+	return 0;
+}
+
+static void adreno_put_supported_hw(struct opp_table *opp_table)
+{
+	if (opp_table)
+		dev_pm_opp_put_supported_hw(opp_table);
+}
+
 int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct adreno_gpu *adreno_gpu,
 		const struct adreno_gpu_funcs *funcs, int nr_rings)
@@ -899,6 +963,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	struct adreno_platform_config *config = dev->platform_data;
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
+	int ret;
 
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = adreno_info(config->rev);
@@ -910,6 +975,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	adreno_gpu_config.nr_rings = nr_rings;
 
+	ret = adreno_set_supported_hw(dev, adreno_gpu);
+	if (ret)
+		return ret;
+
 	adreno_get_pwrlevels(dev, gpu);
 
 	pm_runtime_set_autosuspend_delay(dev,
@@ -936,4 +1005,6 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 
 	icc_put(gpu->icc_path);
 	icc_put(gpu->ocmem_icc_path);
+
+	adreno_put_supported_hw(adreno_gpu->opp_table);
 }
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index c3775f7..a756ad7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -55,6 +55,7 @@ struct adreno_reglist {
 };
 
 extern const struct adreno_reglist a630_hwcg[], a640_hwcg[], a650_hwcg[];
+extern const u32 a618_speedbins[];
 
 struct adreno_info {
 	struct adreno_rev rev;
@@ -67,6 +68,8 @@ struct adreno_info {
 	const char *zapfw;
 	u32 inactive_period;
 	const struct adreno_reglist *hwcg;
+	const u32 *speedbins;
+	const u8 speedbins_count;
 };
 
 const struct adreno_info *adreno_info(struct adreno_rev rev);
@@ -112,6 +115,8 @@ struct adreno_gpu {
 	 * code (a3xx_gpu.c) and stored in this common location.
 	 */
 	const unsigned int *reg_offsets;
+
+	struct opp_table *opp_table;
 };
 #define to_adreno_gpu(x) container_of(x, struct adreno_gpu, base)
 
-- 
2.7.4


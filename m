Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C912B6788
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgKQOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:32:13 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:31872 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbgKQOcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:32:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605623530; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5cMiLOwjnXkXLEoeEW3HBR1e+Az/sjHxgoRRiQBvOOA=; b=LwBPcINA6JKa6lWY7zNuCNMdPML3gdzCUlr+wv/qaY9syFIl2bT8rDs7xa3o6C0aaXRyTB5b
 gX0B5gDtt/DoqTTv1Ogb37pZ9ENJBpQEMZvP3eUn3BssBoStaLU4Ko2zkU2g3KAeVeSs7wa2
 Bctq9Ldq4mIMrOS4JCQYXZqFD3E=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5fb3ded2135ce186e9907ed5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 17 Nov 2020 14:31:46
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 376EEC433ED; Tue, 17 Nov 2020 14:31:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB47BC43460;
        Tue, 17 Nov 2020 14:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB47BC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv8 6/8] drm/msm/a6xx: Add support for using system cache on MMU500 based targets
Date:   Tue, 17 Nov 2020 20:00:45 +0530
Message-Id: <1ceab1d57e4846a0f4179afe769ad1adc463758b.1605621785.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1605621785.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

GPU targets with an MMU-500 attached have a slightly different process for
enabling system cache. Use the compatible string on the IOMMU phandle
to see if an MMU-500 is attached and modify the programming sequence
accordingly.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 46 +++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 95c98c642876..3f8b92da8cba 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1042,6 +1042,8 @@ static void a6xx_llc_deactivate(struct a6xx_gpu *a6xx_gpu)
 
 static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
 {
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
 	u32 cntl1_regval = 0;
 
 	if (IS_ERR(a6xx_gpu->llc_mmio))
@@ -1055,11 +1057,17 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
 			       (gpu_scid << 15) | (gpu_scid << 20);
 	}
 
+	/*
+	 * For targets with a MMU500, activate the slice but don't program the
+	 * register.  The XBL will take care of that.
+	 */
 	if (!llcc_slice_activate(a6xx_gpu->htw_llc_slice)) {
-		u32 gpuhtw_scid = llcc_get_slice_id(a6xx_gpu->htw_llc_slice);
+		if (!a6xx_gpu->have_mmu500) {
+			u32 gpuhtw_scid = llcc_get_slice_id(a6xx_gpu->htw_llc_slice);
 
-		gpuhtw_scid &= 0x1f;
-		cntl1_regval |= FIELD_PREP(GENMASK(29, 25), gpuhtw_scid);
+			gpuhtw_scid &= 0x1f;
+			cntl1_regval |= FIELD_PREP(GENMASK(29, 25), gpuhtw_scid);
+		}
 	}
 
 	if (cntl1_regval) {
@@ -1067,13 +1075,20 @@ static void a6xx_llc_activate(struct a6xx_gpu *a6xx_gpu)
 		 * Program the slice IDs for the various GPU blocks and GPU MMU
 		 * pagetables
 		 */
-		a6xx_llc_write(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_1, cntl1_regval);
-
-		/*
-		 * Program cacheability overrides to not allocate cache lines on
-		 * a write miss
-		 */
-		a6xx_llc_rmw(a6xx_gpu, REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_0, 0xF, 0x03);
+		if (a6xx_gpu->have_mmu500)
+			gpu_rmw(gpu, REG_A6XX_GBIF_SCACHE_CNTL1, GENMASK(24, 0),
+				cntl1_regval);
+		else {
+			a6xx_llc_write(a6xx_gpu,
+				REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_1, cntl1_regval);
+
+			/*
+			 * Program cacheability overrides to not allocate cache
+			 * lines on a write miss
+			 */
+			a6xx_llc_rmw(a6xx_gpu,
+				REG_A6XX_CX_MISC_SYSTEM_CACHE_CNTL_0, 0xF, 0x03);
+		}
 	}
 }
 
@@ -1086,10 +1101,21 @@ static void a6xx_llc_slices_destroy(struct a6xx_gpu *a6xx_gpu)
 static void a6xx_llc_slices_init(struct platform_device *pdev,
 		struct a6xx_gpu *a6xx_gpu)
 {
+	struct device_node *phandle;
+
 	a6xx_gpu->llc_mmio = msm_ioremap(pdev, "cx_mem", "gpu_cx");
 	if (IS_ERR(a6xx_gpu->llc_mmio))
 		return;
 
+	/*
+	 * There is a different programming path for targets with an mmu500
+	 * attached, so detect if that is the case
+	 */
+	phandle = of_parse_phandle(pdev->dev.of_node, "iommus", 0);
+	a6xx_gpu->have_mmu500 = (phandle &&
+		of_device_is_compatible(phandle, "arm,mmu-500"));
+	of_node_put(phandle);
+
 	a6xx_gpu->llc_slice = llcc_slice_getd(LLCC_GPU);
 	a6xx_gpu->htw_llc_slice = llcc_slice_getd(LLCC_GPUHTW);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 9e6079af679c..e793d329e77b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -32,6 +32,7 @@ struct a6xx_gpu {
 	void __iomem *llc_mmio;
 	void *llc_slice;
 	void *htw_llc_slice;
+	bool have_mmu500;
 };
 
 #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


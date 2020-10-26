Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2132298C77
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774182AbgJZLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:55:26 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:17811 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774149AbgJZLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:55:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603713322; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=F5WbtFXNYasHm3DkTz7boOrEycyNzj6ImMrOzRsPD5s=; b=jHXSfc1rSfBOXVXRyasjwTV2q4qLhrrvvQLtRmO3WXO6h3zFknrVHx6LO1UNgkJeFlXINIpx
 eRTZdDZ+Xenul9ERuxZQhvdaxcGyjN909jzr6GZv/0mX+zisvzKxR3X9geKumENf2MEuXCJF
 rGBZvpYvMfeaydDpXhspoYMcEZs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f96b9072421c5ebfb3b6379 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 11:54:47
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 43360C4344A; Mon, 26 Oct 2020 11:54:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 242A3C433B7;
        Mon, 26 Oct 2020 11:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 242A3C433B7
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv6 5/6] iommu: arm-smmu-impl: Use table to list QCOM implementations
Date:   Mon, 26 Oct 2020 17:24:04 +0530
Message-Id: <8b8f31fcf283124deee335012affe5bc527f6694.1603448364.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1603448364.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1603448364.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use table and of_match_node() to match qcom implementation
instead of multiple of_device_compatible() calls for each
QCOM SMMU implementation.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c |  9 +--------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 21 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 -
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index d199b4bff15d..ffaf3f91ba52 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -217,14 +217,7 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	if (of_device_is_compatible(np, "nvidia,tegra194-smmu"))
 		return nvidia_smmu_impl_init(smmu);
 
-	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
-	    of_device_is_compatible(np, "qcom,sc7180-smmu-500") ||
-	    of_device_is_compatible(np, "qcom,sm8150-smmu-500") ||
-	    of_device_is_compatible(np, "qcom,sm8250-smmu-500"))
-		return qcom_smmu_impl_init(smmu);
-
-	if (of_device_is_compatible(smmu->dev->of_node, "qcom,adreno-smmu"))
-		return qcom_adreno_smmu_impl_init(smmu);
+	smmu = qcom_smmu_impl_init(smmu);
 
 	if (of_device_is_compatible(np, "marvell,ap806-smmu-500"))
 		smmu->impl = &mrvl_mmu500_impl;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 0663d7d26908..9c40fb7a2241 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -224,12 +224,23 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
 	return &qsmmu->smmu;
 }
 
+static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
+	{ .compatible = "qcom,sc7180-smmu-500" },
+	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sm8150-smmu-500" },
+	{ .compatible = "qcom,sm8250-smmu-500" },
+	{ }
+};
+
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 {
-	return qcom_smmu_create(smmu, &qcom_smmu_impl);
-}
+	const struct device_node *np = smmu->dev->of_node;
 
-struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu)
-{
-	return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
+	if (of_match_node(qcom_smmu_impl_of_match, np))
+		return qcom_smmu_create(smmu, &qcom_smmu_impl);
+
+	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
+		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
+
+	return smmu;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 93593e164e44..94f3e439c082 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -524,7 +524,6 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
-struct arm_smmu_device *qcom_adreno_smmu_impl_init(struct arm_smmu_device *smmu);
 
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


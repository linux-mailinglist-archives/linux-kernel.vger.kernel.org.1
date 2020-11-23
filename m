Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1F2C1196
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390311AbgKWRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:06:57 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:62837 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390294AbgKWRG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:06:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606151215; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=799A6+ZaYQkSrv/xSn1SdxT1I1wEW2HfwO6hBn15u3c=; b=AJB38a/8si2Qj/Ae294T/uJ/EEqoZrPB4RbH9lCq3Y/exZ57EzICDeARrUbpuFAJ+HUhRb3R
 cwwBNNTZ3srjhjpv/BlupR85U5+J4Di6585vD12BNFU6gomDTn6pY2h0241/oARQtWvsnbVg
 FNaYvBfG987TZy99XrWnWBlvyac=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fbbec27a5a29b56a1e066d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 17:06:47
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA0AFC4346B; Mon, 23 Nov 2020 17:06:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06613C433C6;
        Mon, 23 Nov 2020 17:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06613C433C6
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
Subject: [PATCHv9 3/8] iommu/arm-smmu: Move non-strict mode to use io_pgtable_domain_attr
Date:   Mon, 23 Nov 2020 22:35:56 +0530
Message-Id: <47f8e9760a7fba8b58ea89c9add96f5615f97014.1606150259.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1606150259.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1606150259.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a struct io_pgtable_domain_attr with quirks,
use that for non_strict mode as well thereby removing the need
for more members of arm_smmu_domain in the future.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 8 +++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 1 -
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4b9b10fe50ed..f56f266ebdf7 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -786,9 +786,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			goto out_clear_smmu;
 	}
 
-	if (smmu_domain->non_strict)
-		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
-
 	if (smmu_domain->pgtbl_cfg.quirks)
 		pgtbl_cfg.quirks |= smmu_domain->pgtbl_cfg.quirks;
 
@@ -1527,7 +1524,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_DMA:
 		switch (attr) {
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
-			*(int *)data = smmu_domain->non_strict;
+			if (smmu_domain->pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_NON_STRICT)
+				*(int *)data = smmu_domain->pgtbl_cfg.quirks;
 			return 0;
 		default:
 			return -ENODEV;
@@ -1578,7 +1576,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_DMA:
 		switch (attr) {
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
-			smmu_domain->non_strict = *(int *)data;
+			smmu_domain->pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 			break;
 		default:
 			ret = -ENODEV;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index bb5a419f240f..cb7ca3a444c9 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -368,7 +368,6 @@ struct arm_smmu_domain {
 	const struct iommu_flush_ops	*flush_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
-	bool				non_strict;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


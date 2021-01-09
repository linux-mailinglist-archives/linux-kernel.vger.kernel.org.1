Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5707A2EFCE7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 02:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAIBvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 20:51:39 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:60486 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbhAIBvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 20:51:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610157079; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=K+f2Q/EJdasBNYVD+EspGT3ZOBQETm0mWhfK3z06MvA=; b=lcxk7J4V61vLSRJSZ5yR7ghtlOKs8x3+rCPxQhmwQmudjEAqFuMXTdXkIeYgw6u/+YTcLJLi
 l3EVl9p/XRJtCOxWBlluBzBWSJZwpUXv8c4Mk2mL2XaP23wwDUeAXhcIpUVFoiKVLfiMssff
 X/EqxPtfI5RzuvRTMMYDbyOcFQk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ff90bfa4dcca1247515d8f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 09 Jan 2021 01:50:50
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72DA5C43464; Sat,  9 Jan 2021 01:50:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D904C43462;
        Sat,  9 Jan 2021 01:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D904C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
        pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iommu/arm-smmu: Hook up map_sg()
Date:   Fri,  8 Jan 2021 17:50:31 -0800
Message-Id: <1610157031-26301-6-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
References: <1610157031-26301-1-git-send-email-isaacm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everything is in place for iommu_map_sg() to defer
mapping a scatter-gather list to the io-pgtable layer, implement
the map_sg() callback in the SMMU driver, so that iommu_map_sg()
can invoke it with the entire scatter-gather list that will be
mapped.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d8c6bfd..52acc68 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1208,6 +1208,24 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
+static int arm_smmu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			   struct scatterlist *sg, unsigned int nents, int prot,
+			   gfp_t gfp, size_t *mapped)
+{
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
+	int ret;
+
+	if (!ops)
+		return -ENODEV;
+
+	arm_smmu_rpm_get(smmu);
+	ret = ops->map_sg(ops, iova, sg, nents, prot, gfp, mapped);
+	arm_smmu_rpm_put(smmu);
+
+	return ret;
+}
+
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			     size_t size, struct iommu_iotlb_gather *gather)
 {
@@ -1624,6 +1642,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_free		= arm_smmu_domain_free,
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
+	.map_sg			= arm_smmu_map_sg,
 	.unmap			= arm_smmu_unmap,
 	.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
 	.iotlb_sync		= arm_smmu_iotlb_sync,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


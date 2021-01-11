Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E82F18CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbhAKOz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:55:26 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:43912 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbhAKOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:55:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610376907; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=uUan/3Y+TTfqjIpnFPtAg7RTHJJUPTCSTIPd9F4F9f4=; b=gyvYimZBzNpOEHAdEhMx0/cdXkNvhgVz/X3R5p9mhOLxW8Rjl7ur2mYt+DY+HnFjFsv++VJ6
 b8zKlIddncsl+9jR4p8I7CAkcA4IwN02DvEfN1TRSCFYqVCx55EcssGQEIh8uE8G6Wrj9/h5
 ZcojAggMMeQp/PFD1aOGWfbv9z0=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ffc66ac8fb3cda82ff063af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 14:54:36
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88965C433ED; Mon, 11 Jan 2021 14:54:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EF9AC43465;
        Mon, 11 Jan 2021 14:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EF9AC43465
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
        pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
Date:   Mon, 11 Jan 2021 06:54:21 -0800
Message-Id: <1610376862-927-5-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for IOMMU drivers to have their own map_sg() callbacks.
This completes the path for having iommu_map_sg() invoke an IOMMU
driver's map_sg() callback, which can then invoke the io-pgtable
map_sg() callback with the entire scatter-gather list, so that it
can be processed entirely in the io-pgtable layer.

For IOMMU drivers that do not provide a callback, the default
implementation of iterating through the scatter-gather list, while
calling iommu_map() will be used.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/iommu.c | 13 +++++++++++++
 include/linux/iommu.h |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0da0687..46acd5c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2535,11 +2535,24 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			     struct scatterlist *sg, unsigned int nents, int prot,
 			     gfp_t gfp)
 {
+	const struct iommu_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
 	unsigned int i = 0;
 	int ret;
 
+	if (ops->map_sg) {
+		ret = ops->map_sg(domain, iova, sg, nents, prot, gfp, &mapped);
+
+		if (ops->iotlb_sync_map)
+			ops->iotlb_sync_map(domain);
+
+		if (ret)
+			goto out_err;
+
+		return mapped;
+	}
+
 	while (i <= nents) {
 		phys_addr_t s_phys = sg_phys(sg);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0e40a38..bac7681 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -192,6 +192,8 @@ struct iommu_iotlb_gather {
  * @attach_dev: attach device to an iommu domain
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
+ * @map_sg: map a scatter-gather list of physically contiguous chunks to
+ *          an iommu domain.
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
@@ -243,6 +245,9 @@ struct iommu_ops {
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+	int (*map_sg)(struct iommu_domain *domain, unsigned long iova,
+		      struct scatterlist *sg, unsigned int nents, int prot,
+		      gfp_t gfp, size_t *mapped);
 	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
 		     size_t size, struct iommu_iotlb_gather *iotlb_gather);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


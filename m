Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CBC2F18D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbhAKOzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:55:41 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:17775 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbhAKOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:55:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610376916; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=lcdCbZ/HefWFY1EY5oisa6OgB6flXojUYnzfIUpb3XU=; b=dfyH4ASXu49lb54mYeP1u64Bg61ZxjHBGOwqJ12MMG3Fe+uKUEEHHFCO1Vk86CV9NuMmlXqh
 51QT6a9yfMJXOyMw6d6kPjGQgSPOwlNCUGDFp+tL69Jf1ws77VylXxdve6Z39hTy4vlfS9Uo
 bCgd4r/Bk1yJ0F6NWHRemdrVrIc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ffc66a88fb3cda82ff05576 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 14:54:32
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1410C43463; Mon, 11 Jan 2021 14:54:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 891F3C433CA;
        Mon, 11 Jan 2021 14:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 891F3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, pdaly@codeaurora.org,
        pratikp@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] iommu/io-pgtable: Introduce map_sg() as a page table op
Date:   Mon, 11 Jan 2021 06:54:18 -0800
Message-Id: <1610376862-927-2-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While mapping a scatter-gather list, iommu_map_sg() calls
into the IOMMU driver through an indirect call, which can
call into the io-pgtable code through another indirect call.

This sequence of going through the IOMMU core code, the IOMMU
driver, and finally the io-pgtable code, occurs for every
element in the scatter-gather list, in the worse case, which
is not optimal.

Introduce a map_sg callback in the io-pgtable ops so that
IOMMU drivers can invoke it with the complete scatter-gather
list, so that it can be processed within the io-pgtable
code entirely, reducing the number of indirect calls, and
boosting overall iommu_map_sg() performance.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 include/linux/io-pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index ea727eb..6d0e731 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -147,6 +147,9 @@ struct io_pgtable_cfg {
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
  * @map:          Map a physically contiguous memory region.
+ * @map_sg:       Map a scatter-gather list of physically contiguous memory
+ *                chunks. The mapped pointer argument is used to store how
+ *                many bytes are mapped.
  * @unmap:        Unmap a physically contiguous memory region.
  * @iova_to_phys: Translate iova to physical address.
  *
@@ -156,6 +159,9 @@ struct io_pgtable_cfg {
 struct io_pgtable_ops {
 	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+	int (*map_sg)(struct io_pgtable_ops *ops, unsigned long iova,
+		      struct scatterlist *sg, unsigned int nents, int prot,
+		      gfp_t gfp, size_t *mapped);
 	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 			size_t size, struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


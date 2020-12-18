Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C882DE003
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgLRIj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:39:58 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:54600 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbgLRIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:39:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608280774; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=R1+sdiecBPkdPUhA6bSf5mYFLSBm7PNyWnxgAPqB4pQ=; b=rbAKlOlLSUSoJ8bkSsJYQChfH2ZmVEUc6i29PqbDUuLxRl5xSTddGDQR0dPt+701XjmZZ8UH
 /aIiHd8Vbwe4Dc50qeF0D8MLD+40V9iUY5mciI1VGMwB7cwi27M6t8B8S5lETw4vLhl/kF8B
 s3gN/Q0mRAZ+JeZRXP/wrTRuUTk=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fdc6aa9031793dcb42d5db2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 08:39:05
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0E2B1C433CA; Fri, 18 Dec 2020 08:39:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2990EC433C6;
        Fri, 18 Dec 2020 08:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2990EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
        joro@8bytes.org, robin.murphy@arm.com, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com
Subject: [PATCH 1/3] iommu/io-pgtable-arm: Prepare for modularization
Date:   Fri, 18 Dec 2020 00:38:40 -0800
Message-Id: <1608280722-19841-2-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
References: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io-pgtable-arm and io-pgtable-arm-v7s source files will
be compiled as separate modules, along with the io-pgtable
source. Export the symbols for the io-pgtable init function
structures for the io-pgtable module to use.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 4 ++++
 drivers/iommu/io-pgtable-arm.c     | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 1d92ac9..f062c1c 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/kmemleak.h>
+#include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -839,6 +840,7 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 	.alloc	= arm_v7s_alloc_pgtable,
 	.free	= arm_v7s_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_v7s_init_fns);
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
@@ -984,3 +986,5 @@ static int __init arm_v7s_do_selftests(void)
 }
 subsys_initcall(arm_v7s_do_selftests);
 #endif
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58..2623d57 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1047,26 +1048,31 @@ struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s1_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s2_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
 	.alloc	= arm_32_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s1_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
 	.alloc	= arm_32_lpae_alloc_pgtable_s2,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s2_init_fns);
 
 struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.alloc	= arm_mali_lpae_alloc_pgtable,
 	.free	= arm_lpae_free_pgtable,
 };
+EXPORT_SYMBOL_GPL(io_pgtable_arm_mali_lpae_init_fns);
 
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
@@ -1252,3 +1258,5 @@ static int __init arm_lpae_do_selftests(void)
 }
 subsys_initcall(arm_lpae_do_selftests);
 #endif
+
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


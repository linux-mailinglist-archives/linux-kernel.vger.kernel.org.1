Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48232DE004
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbgLRIkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:40:01 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:53231 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbgLRIkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:40:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608280776; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KTUphJmvon2mltyw0OoY02nZ5K7J0Ceqc5udY/Pam+Q=; b=lx9fzSmCLRRJP3d/HKCSb2Op9ODP+iZJvuIlivjnex9RzFc+uiaUOk25LwrWfF+WiUEcTpJo
 7nlLbKQRpnVNLAWP3g+qtCX5BesGa3ZsMK7wTfQIG6YWvgI9HVV2qVBUsouWZRbBfYI58RmA
 GzgJsu43YKNKUJrkyVAc5nIb9tw=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fdc6aabf5e9af65f8315e11 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 08:39:07
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CC5B6C43464; Fri, 18 Dec 2020 08:39:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 322ACC433CA;
        Fri, 18 Dec 2020 08:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 322ACC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
        joro@8bytes.org, robin.murphy@arm.com, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com
Subject: [PATCH 2/3] iommu/io-pgtable: Prepare for modularization
Date:   Fri, 18 Dec 2020 00:38:41 -0800
Message-Id: <1608280722-19841-3-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
References: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io-pgtable source file uses the #ifdef preprocessor macro
to construct the io_pgtable_init_table structure. However,
the #ifdef macro evaluates to true if the config it is testing
is set to y. This is not ideal when the configs that the
io-pgtable code checks for can be m, so use IS_ENABLED() instead.
Also, add the GPL v2 module license to the io-pgtable source file.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
---
 drivers/iommu/io-pgtable.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 94394c8..867ecb4 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -10,18 +10,19 @@
 #include <linux/bug.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/types.h>
 
 static const struct io_pgtable_init_fns *
 io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
-#ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE
+#if IS_ENABLED(CONFIG_IOMMU_IO_PGTABLE_LPAE)
 	[ARM_32_LPAE_S1] = &io_pgtable_arm_32_lpae_s1_init_fns,
 	[ARM_32_LPAE_S2] = &io_pgtable_arm_32_lpae_s2_init_fns,
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
 	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
 #endif
-#ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
+#if IS_ENABLED(CONFIG_IOMMU_IO_PGTABLE_ARMV7S)
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
 #endif
 };
@@ -68,3 +69,5 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops)
 	io_pgtable_init_table[iop->fmt]->free(iop);
 }
 EXPORT_SYMBOL_GPL(free_io_pgtable_ops);
+
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


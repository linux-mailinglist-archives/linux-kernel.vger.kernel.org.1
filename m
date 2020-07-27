Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F0F22F7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgG0Sgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 14:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgG0Sgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:36:39 -0400
Received: from localhost.localdomain (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132B32074F;
        Mon, 27 Jul 2020 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595874999;
        bh=REyX7sYO8cBj8Z4eVm4euOusP1EBARA9iuGH/ZQYyZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pv4nTJWKipLej8QRQzP8XH2RFQx3XdSR+QDJEcMr8jZBq+eQ3qN49HIQSgwLHp+kQ
         32NzMYhz9xzTKgEHUZjrSCAmOt2Ah2WKZxH16ig6Koi3+8fyGXQomAM70X20YC+1MI
         O5DB/fgwSmJUfvYLyJqzrcrF7NDk/PM3N3We1Fgw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] iommu: amd: Add missing function prototypes to fix -Wmissing-prototypes
Date:   Mon, 27 Jul 2020 20:36:31 +0200
Message-Id: <20200727183631.16744-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few exported functions from AMD IOMMU driver are missing prototypes.
They have declaration in arch/x86/events/amd/iommu.h but this file
cannot be included in the driver.  Add prototypes to fix W=1 warnings
like:

    drivers/iommu/amd/init.c:3066:19: warning:
        no previous prototype for 'get_amd_iommu' [-Wmissing-prototypes]
     3066 | struct amd_iommu *get_amd_iommu(unsigned int idx)

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/amd/amd_iommu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 57309716fd18..0781b7112467 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,6 +41,15 @@ extern int amd_iommu_guest_ir;
 struct iommu_domain;
 
 extern bool amd_iommu_v2_supported(void);
+extern struct amd_iommu *get_amd_iommu(unsigned int idx);
+extern u8 amd_iommu_pc_get_max_banks(unsigned int idx);
+extern bool amd_iommu_pc_supported(void);
+extern u8 amd_iommu_pc_get_max_counters(unsigned int idx);
+extern int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value);
+extern int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+				u8 fxn, u64 *value);
+
 extern int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
-- 
2.17.1


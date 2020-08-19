Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1745124A54A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHSRyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 13:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgHSRx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:53:58 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB2820758;
        Wed, 19 Aug 2020 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597859637;
        bh=REyX7sYO8cBj8Z4eVm4euOusP1EBARA9iuGH/ZQYyZQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=wLPAPYRwpltu3VW0bVUOD96vLGjXwrNSaz+RLccK+Phvh5dLo3t5bDRQiqQTrIVYd
         1pM8/WOpxVfWSEPmpUgYhUAYvJgRtYRZ6sa/6Wh+83LntvHVksz9n8XSLWzQBfA6Ut
         CeO+/5g+068DwMYaDArW+kDKTOchVtJ/TxaKUc14=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH 2/5] iommu: amd: Add missing function prototypes to fix -Wmissing-prototypes
Date:   Wed, 19 Aug 2020 19:53:42 +0200
Message-Id: <20200819175345.20833-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819175345.20833-1-krzk@kernel.org>
References: <20200819175345.20833-1-krzk@kernel.org>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6DC2E7B08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 17:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgL3QYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 11:24:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgL3QYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 11:24:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4334220799;
        Wed, 30 Dec 2020 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609345439;
        bh=Sos7eBBZapqKzxmK4SglDEbzFEnH7xFlI0CCKzTV/No=;
        h=From:To:Cc:Subject:Date:From;
        b=F9uhTI+34/NrZyu6qcF/mEolvgTL9PRh+y+dmT07Ohlz0EsK+KU06jiX6DwMIRayq
         CAH95QB+O3UYgYrS7L52iw3Y+wEb18oH/csJa5Vzw46FY5nUrJwAzjs2AzGnBnXEmf
         Oz74FUQv/o2zdoyWQZ7d3O1KMHkNDrxfv0iC8+7m7B+8ojIOKXe4pypEHn8cveDOyE
         13PO2V6JKays/+cAokjMsIr1ACfJu+4X3b2WglMb2jMU/Q3BI/+ybXhRBGe215xbTi
         koqvrR0WNJ70MtFOSwtPXtMSmm6v3J4l6NfGbe91DScG803lPXmQiCGBuNn4+Fwpgg
         R1Vr3RBu4QTOA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: remove access to kernel memory using debugfs
Date:   Wed, 30 Dec 2020 18:23:52 +0200
Message-Id: <20201230162353.4672-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Accessing kernel allocated memory through debugfs should not
be allowed as it introduces a security vulnerability.
We remove the option to read/write kernel memory for all asics.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c |  8 --------
 drivers/misc/habanalabs/goya/goya.c   | 12 ------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index af49a855d7d6..ac5ad01186c1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5733,8 +5733,6 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
 	} else {
 		rc = -EFAULT;
 	}
@@ -5780,8 +5778,6 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 	} else {
 		rc = -EFAULT;
 	}
@@ -5831,8 +5827,6 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
 	} else {
 		rc = -EFAULT;
 	}
@@ -5881,8 +5875,6 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 	} else {
 		rc = -EFAULT;
 	}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index da12462bd888..71d5a2620421 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4121,9 +4121,6 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
-
 	} else {
 		rc = -EFAULT;
 	}
@@ -4177,9 +4174,6 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
-
 	} else {
 		rc = -EFAULT;
 	}
@@ -4222,9 +4216,6 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
-
 	} else {
 		rc = -EFAULT;
 	}
@@ -4265,9 +4256,6 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
-	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
-		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
-
 	} else {
 		rc = -EFAULT;
 	}
-- 
2.25.1


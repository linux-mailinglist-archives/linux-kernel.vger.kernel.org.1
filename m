Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484322A65E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgKDOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgKDOJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:25 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7F4223AB;
        Wed,  4 Nov 2020 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498964;
        bh=i4FSiLopgyTrDK7ErpUJd4YfTgHbeJqIq0k0frGQUeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5KAqIYAyTRGP2balaJIEhm8JQUhWjjm8fH/18sZ+HsKdvgHyGMnD8UwwDZ4+mMC9
         zj9yTmAoSetQPHd2nFsGCD2ZRS6lQyUOlVylb/14yg1qM4WU9EZ7uebtBR2+87DGDj
         wMrcvb24XUUQC/1D6vqVDtb9SeHz0/KDSmxUPjVc=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH] habanalabs: Move repeatedly included headers to habanalabs.h
Date:   Wed,  4 Nov 2020 16:09:01 +0200
Message-Id: <20201104140908.10178-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Several header files are repeatedly included in many files.
Move these files to habanalabs.h which is included by all.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_buffer.c | 1 -
 drivers/misc/habanalabs/common/device.c         | 1 -
 drivers/misc/habanalabs/common/firmware_if.c    | 2 --
 drivers/misc/habanalabs/common/habanalabs.h     | 4 ++++
 drivers/misc/habanalabs/common/memory.c         | 1 -
 drivers/misc/habanalabs/common/mmu_v1.c         | 1 -
 drivers/misc/habanalabs/gaudi/gaudi.c           | 2 --
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c | 2 --
 drivers/misc/habanalabs/goya/goya.c             | 2 --
 drivers/misc/habanalabs/goya/goya_coresight.c   | 2 --
 10 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 901e213daf40..1fb05bf02340 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -11,7 +11,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#include <linux/genalloc.h>
 
 static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 {
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 20572224099a..421e37123b03 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -10,7 +10,6 @@
 #include "habanalabs.h"
 
 #include <linux/pci.h>
-#include <linux/sched/signal.h>
 #include <linux/hwmon.h>
 #include <uapi/misc/habanalabs.h>
 
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index d84a70ec0ce1..fb9d901d5059 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -9,8 +9,6 @@
 #include "../include/common/hl_boot_if.h"
 
 #include <linux/firmware.h>
-#include <linux/genalloc.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/slab.h>
 
 #define FW_FILE_MAX_SIZE	0x1400000 /* maximum size of 20MB */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ce516e9e1ebe..9f5a3c07f421 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -19,6 +19,10 @@
 #include <linux/scatterlist.h>
 #include <linux/hashtable.h>
 #include <linux/bitfield.h>
+#include <linux/genalloc.h>
+#include <linux/sched/signal.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/coresight.h>
 
 #define HL_NAME				"habanalabs"
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 75e269bc42a7..5c1dae6aaf4d 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -11,7 +11,6 @@
 
 #include <linux/uaccess.h>
 #include <linux/slab.h>
-#include <linux/genalloc.h>
 
 #define HL_MMU_DEBUG	0
 
diff --git a/drivers/misc/habanalabs/common/mmu_v1.c b/drivers/misc/habanalabs/common/mmu_v1.c
index ec7e8a3c37b8..ac3784523baa 100644
--- a/drivers/misc/habanalabs/common/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu_v1.c
@@ -8,7 +8,6 @@
 #include "habanalabs.h"
 #include "../include/hw_ip/mmu/mmu_general.h"
 
-#include <linux/genalloc.h>
 #include <linux/slab.h>
 
 static inline u64 get_phys_addr(struct hl_ctx *ctx, u64 shadow_addr);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9e38ac6f7264..ae73ffb4ad64 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -17,8 +17,6 @@
 #include <linux/pci.h>
 #include <linux/firmware.h>
 #include <linux/hwmon.h>
-#include <linux/genalloc.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iommu.h>
 #include <linux/seq_file.h>
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 881531d4d9da..1f0edf78fba1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -11,8 +11,6 @@
 #include "../include/gaudi/gaudi_masks.h"
 
 #include <uapi/misc/habanalabs.h>
-#include <linux/coresight.h>
-
 #define SPMU_SECTION_SIZE		MME0_ACC_SPMU_MAX_OFFSET
 #define SPMU_EVENT_TYPES_OFFSET		0x400
 #define SPMU_MAX_COUNTERS		6
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 80df2f3d438c..1b81102d1bec 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -12,9 +12,7 @@
 #include "../include/goya/goya_reg_map.h"
 
 #include <linux/pci.h>
-#include <linux/genalloc.h>
 #include <linux/hwmon.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iommu.h>
 #include <linux/seq_file.h>
 
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 4027a6a334d7..6fa03933b438 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -12,8 +12,6 @@
 
 #include <uapi/misc/habanalabs.h>
 
-#include <linux/coresight.h>
-
 #define GOYA_PLDM_CORESIGHT_TIMEOUT_USEC	(CORESIGHT_TIMEOUT_USEC * 100)
 
 #define SPMU_SECTION_SIZE		DMA_CH_0_CS_SPMU_MAX_OFFSET
-- 
2.17.1


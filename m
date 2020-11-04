Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B72A60A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgKDJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgKDJjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:39:20 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60457221F8;
        Wed,  4 Nov 2020 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604482759;
        bh=PNGJw62Hoc0i1O5P7sHKK7fIniJSrbftHq8Py7Xvb1c=;
        h=From:To:Cc:Subject:Date:From;
        b=GN9lOYJx7L/a3WMejt1JOH5raMjBNzTJaQEEoXEZIFFZU80UNq2r+FabQY4UQanbV
         31hRqWdM0elDvpA5sA+fShT702HNlf/LoOZ7bNeM45Fgkh7X6BMD6TgBHlooU157cO
         5BBumTKSS7WpqrbecB/8lUTwE+yButGnx8rQssJM=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, farah kassabri <fkassabri@habana.ai>
Subject: [PATCH] habanalabs/gaudi: scrub all memory upon closing FD
Date:   Wed,  4 Nov 2020 11:39:12 +0200
Message-Id: <20201104093912.7085-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

In cases of multi-tenants, administrators may want to prevent data
leakage between users running on the same device one after another.

To do that the driver can scrub the internal memory (both SRAM and
DRAM) after a user finish to use the memory.

Because in GAUDI the driver allows only one application to use the
device at a time, it can scrub the memory when user app close FD.

In future devices where we have MMU on the DRAM, we can scrub the DRAM
memory with a finer granularity (page granularity) when the user
allocates the memory.

This feature is not supported in Goya.

To allow users that want to debug their applications, we add a kernel
module parameter to load the driver with this feature disabled.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c      |   3 +
 drivers/misc/habanalabs/common/habanalabs.h   |   5 +
 .../misc/habanalabs/common/habanalabs_drv.c   |   6 +
 drivers/misc/habanalabs/common/memory.c       |  23 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 131 ++++++++++++++++--
 drivers/misc/habanalabs/goya/goya.c           |   6 +
 drivers/misc/habanalabs/goya/goyaP.h          |   1 +
 7 files changed, 161 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 2077bbe3606a..f65e6559149b 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -45,6 +45,9 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		hl_vm_ctx_fini(ctx);
 		hl_asid_free(hdev, ctx->asid);
 
+		/* Scrub both SRAM and DRAM */
+		hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
+
 		if ((!hdev->pldm) && (hdev->pdev) &&
 				(!hdev->asic_funcs->is_device_idle(hdev,
 							&idle_mask, NULL)))
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d814ff69eb01..54600443ebc7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -746,6 +746,7 @@ enum div_select_defs {
  *                           dma_free_coherent(). This is ASIC function because
  *                           its implementation is not trivial when the driver
  *                           is loaded in simulation mode (not upstreamed).
+ * @scrub_device_mem: Scrub device memory given an address and size
  * @get_int_queue_base: get the internal queue base address.
  * @test_queues: run simple test on all queues for sanity check.
  * @asic_dma_pool_zalloc: small DMA allocation of coherent memory from DMA pool.
@@ -837,6 +838,7 @@ struct hl_asic_funcs {
 					dma_addr_t *dma_handle, gfp_t flag);
 	void (*asic_dma_free_coherent)(struct hl_device *hdev, size_t size,
 					void *cpu_addr, dma_addr_t dma_handle);
+	int (*scrub_device_mem)(struct hl_device *hdev, u64 addr, u64 size);
 	void* (*get_int_queue_base)(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle, u16 *queue_len);
 	int (*test_queues)(struct hl_device *hdev);
@@ -1698,6 +1700,8 @@ struct hl_mmu_funcs {
  *                   otherwise.
  * @dram_supports_virtual_memory: is MMU enabled towards DRAM.
  * @dram_default_page_mapping: is DRAM default page mapping enabled.
+ * @memory_scrub: true to perform device memory scrub in various locations,
+ *                such as context-switch, context close, page free, etc.
  * @pmmu_huge_range: is a different virtual addresses range used for PMMU with
  *                   huge pages.
  * @init_done: is the initialization of the device done.
@@ -1802,6 +1806,7 @@ struct hl_device {
 	u8				reset_on_lockup;
 	u8				dram_supports_virtual_memory;
 	u8				dram_default_page_mapping;
+	u8				memory_scrub;
 	u8				pmmu_huge_range;
 	u8				init_done;
 	u8				device_cpu_disabled;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 4c49d6cefa98..20458bd82c5a 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -29,6 +29,7 @@ static DEFINE_MUTEX(hl_devs_idr_lock);
 
 static int timeout_locked = 5;
 static int reset_on_lockup = 1;
+static int memory_scrub = 1;
 
 module_param(timeout_locked, int, 0444);
 MODULE_PARM_DESC(timeout_locked,
@@ -38,6 +39,10 @@ module_param(reset_on_lockup, int, 0444);
 MODULE_PARM_DESC(reset_on_lockup,
 	"Do device reset on lockup (0 = no, 1 = yes, default yes)");
 
+module_param(memory_scrub, int, 0444);
+MODULE_PARM_DESC(memory_scrub,
+	"Scrub device memory in various states (0 = no, 1 = yes, default yes)");
+
 #define PCI_VENDOR_ID_HABANALABS	0x1da3
 
 #define PCI_IDS_GOYA			0x0001
@@ -284,6 +289,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	hdev->major = hl_major;
 	hdev->reset_on_lockup = reset_on_lockup;
+	hdev->memory_scrub = memory_scrub;
 	hdev->pldm = 0;
 
 	set_driver_behavior_per_device(hdev);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index f885812d9939..75e269bc42a7 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -46,7 +46,7 @@
  * @ret_handle          : result handle
  *
  * This function does the following:
- * - Allocate the requested size rounded up to 2MB pages
+ * - Allocate the requested size rounded up to 'dram_page_size' pages
  * - Return unique handle
  */
 static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
@@ -81,6 +81,16 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 				num_pgs, total_size);
 			return -ENOMEM;
 		}
+
+		if (hdev->memory_scrub) {
+			rc = hdev->asic_funcs->scrub_device_mem(hdev, paddr,
+					total_size);
+			if (rc) {
+				dev_err(hdev->dev,
+					"Failed to scrub contiguous device memory\n");
+				goto pages_pack_err;
+			}
+		}
 	}
 
 	phys_pg_pack = kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
@@ -118,6 +128,17 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 				goto page_err;
 			}
 
+			if (hdev->memory_scrub) {
+				rc = hdev->asic_funcs->scrub_device_mem(hdev,
+						phys_pg_pack->pages[i],
+						page_size);
+				if (rc) {
+					dev_err(hdev->dev,
+						"Failed to scrub device memory\n");
+					goto page_err;
+				}
+			}
+
 			num_curr_pgs++;
 		}
 	}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9017c712766c..5df06c63ceb8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -103,6 +103,8 @@
 		BIT(GAUDI_ENGINE_ID_MME_2) |\
 		GENMASK_ULL(GAUDI_ENGINE_ID_TPC_7, GAUDI_ENGINE_ID_TPC_0))
 
+#define HBM_SCRUBBING_TIMEOUT_US	1000000 /* 1s */
+
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -4401,6 +4403,121 @@ static void gaudi_dma_free_coherent(struct hl_device *hdev, size_t size,
 	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, fixed_dma_handle);
 }
 
+static int gaudi_hbm_scrubbing(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64  cur_addr = DRAM_BASE_ADDR_USER;
+	u32 val;
+	u32 chunk_size;
+	int rc, dma_id;
+
+	while (cur_addr < prop->dram_end_address) {
+		for (dma_id = 0 ; dma_id < DMA_NUMBER_OF_CHANNELS ; dma_id++) {
+			u32 dma_offset = dma_id * DMA_CORE_OFFSET;
+
+			chunk_size =
+			min((u64)SZ_2G, prop->dram_end_address - cur_addr);
+
+			dev_dbg(hdev->dev,
+				"Doing HBM scrubbing for 0x%09llx - 0x%09llx\n",
+				cur_addr, cur_addr + chunk_size);
+
+			WREG32(mmDMA0_CORE_SRC_BASE_LO + dma_offset, 0);
+			WREG32(mmDMA0_CORE_SRC_BASE_HI + dma_offset, 0);
+			WREG32(mmDMA0_CORE_DST_BASE_LO + dma_offset,
+						lower_32_bits(cur_addr));
+			WREG32(mmDMA0_CORE_DST_BASE_HI + dma_offset,
+						upper_32_bits(cur_addr));
+			WREG32(mmDMA0_CORE_DST_TSIZE_0 + dma_offset,
+					chunk_size);
+			WREG32(mmDMA0_CORE_COMMIT + dma_offset,
+					((1 << DMA0_CORE_COMMIT_LIN_SHIFT) |
+					(1 << DMA0_CORE_COMMIT_MEM_SET_SHIFT)));
+
+			cur_addr += chunk_size;
+
+			if (cur_addr == prop->dram_end_address)
+				break;
+		}
+
+		for (dma_id = 0 ; dma_id < DMA_NUMBER_OF_CHANNELS ; dma_id++) {
+			u32 dma_offset = dma_id * DMA_CORE_OFFSET;
+
+			rc = hl_poll_timeout(
+				hdev,
+				mmDMA0_CORE_STS0 + dma_offset,
+				val,
+				((val & DMA0_CORE_STS0_BUSY_MASK) == 0),
+				1000,
+				HBM_SCRUBBING_TIMEOUT_US);
+
+			if (rc) {
+				dev_err(hdev->dev,
+					"DMA Timeout during HBM scrubbing of DMA #%d\n",
+					dma_id);
+				return -EIO;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int gaudi_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	u64 idle_mask = 0;
+	int rc = 0;
+	u64 val = 0;
+
+	if (!hdev->memory_scrub)
+		return 0;
+
+	if (!addr && !size) {
+		/* Wait till device is idle */
+		rc = hl_poll_timeout(
+				hdev,
+				mmDMA0_CORE_STS0/* dummy */,
+				val/* dummy */,
+				(hdev->asic_funcs->is_device_idle(hdev,
+						&idle_mask, NULL)),
+						1000,
+						HBM_SCRUBBING_TIMEOUT_US);
+		if (rc) {
+			dev_err(hdev->dev, "waiting for idle timeout\n");
+			return -EIO;
+		}
+
+		/* Scrub SRAM */
+		addr = prop->sram_user_base_address;
+		size = hdev->pldm ? 0x10000 :
+				(prop->sram_size - SRAM_USER_BASE_OFFSET);
+		val = 0x7777777777777777ull;
+
+		rc = gaudi_memset_device_memory(hdev, addr, size, val);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to clear SRAM in mem scrub all\n");
+			return rc;
+		}
+
+		mutex_lock(&gaudi->clk_gate_mutex);
+		hdev->asic_funcs->disable_clock_gating(hdev);
+
+		/* Scrub HBM using all DMA channels in parallel */
+		rc = gaudi_hbm_scrubbing(hdev);
+		if (rc)
+			dev_err(hdev->dev,
+				"Failed to clear HBM in mem scrub all\n");
+
+		hdev->asic_funcs->set_clock_gating(hdev);
+		mutex_unlock(&gaudi->clk_gate_mutex);
+	}
+
+	return rc;
+}
+
 static void *gaudi_get_int_queue_base(struct hl_device *hdev,
 				u32 queue_id, dma_addr_t *dma_handle,
 				u16 *queue_len)
@@ -5505,19 +5622,6 @@ static void gaudi_restore_user_registers(struct hl_device *hdev)
 
 static int gaudi_context_switch(struct hl_device *hdev, u32 asid)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 addr = prop->sram_user_base_address;
-	u32 size = hdev->pldm ? 0x10000 :
-			(prop->sram_size - SRAM_USER_BASE_OFFSET);
-	u64 val = 0x7777777777777777ull;
-	int rc;
-
-	rc = gaudi_memset_device_memory(hdev, addr, size, val);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to clear SRAM in context switch\n");
-		return rc;
-	}
-
 	gaudi_restore_user_registers(hdev);
 
 	return 0;
@@ -8119,6 +8223,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.pqe_write = gaudi_pqe_write,
 	.asic_dma_alloc_coherent = gaudi_dma_alloc_coherent,
 	.asic_dma_free_coherent = gaudi_dma_free_coherent,
+	.scrub_device_mem = gaudi_scrub_device_mem,
 	.get_int_queue_base = gaudi_get_int_queue_base,
 	.test_queues = gaudi_test_queues,
 	.asic_dma_pool_zalloc = gaudi_dma_pool_zalloc,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5b0f02a1b8ee..80df2f3d438c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2795,6 +2795,11 @@ static void goya_dma_free_coherent(struct hl_device *hdev, size_t size,
 	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, fixed_dma_handle);
 }
 
+int goya_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
+{
+	return 0;
+}
+
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle,	u16 *queue_len)
 {
@@ -5374,6 +5379,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.pqe_write = goya_pqe_write,
 	.asic_dma_alloc_coherent = goya_dma_alloc_coherent,
 	.asic_dma_free_coherent = goya_dma_free_coherent,
+	.scrub_device_mem = goya_scrub_device_mem,
 	.get_int_queue_base = goya_get_int_queue_base,
 	.test_queues = goya_test_queues,
 	.asic_dma_pool_zalloc = goya_dma_pool_zalloc,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 09b4006d4dc3..6a9fcf3871fa 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -221,6 +221,7 @@ void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
 				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec,
 				bool eb);
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
+int goya_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size);
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle,	u16 *queue_len);
 u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt);
-- 
2.17.1


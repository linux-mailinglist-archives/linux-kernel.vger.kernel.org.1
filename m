Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA0D301D63
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 17:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbhAXQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 11:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAXQGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 11:06:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5E442087D;
        Sun, 24 Jan 2021 16:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611504323;
        bh=MGbe+b4Vv+evYTzJSd/xU7zthJ2iaogjpr54wxqHEws=;
        h=From:To:Cc:Subject:Date:From;
        b=bUVDO+GOG0jfL2gQwy2xPyYqjcitcuB9tkUdDwLUM0xRBbd5Y6NUUVaX88pEpSuFu
         DV9XoIY+VkokbJY2sB9AElN3f27uxXYjfhElARwV8214NpWjYGDBnwrGytLDzRKszX
         mQ492c5qmIIRqhqRVuo4UmV7dF2NA3ZC+QjOCC3pGsUoAovr7X3zlHmCjk3vs7AvMR
         WwSMVcx+5K9hHjwEbNvbIuSu1itva7U/2YB1gkVj3WcZYmxL3yLfn/c7aw7aJKPsWA
         JvaKCV8DRsFO2OxNChCfObT87+xje0xB8Nv6T/p6VzFKrch9wpDHf6wZhxRMIoaQsI
         Y0i1TGgxtfAqw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: add new mem ioctl op for mapping hw blocks
Date:   Sun, 24 Jan 2021 18:05:17 +0200
Message-Id: <20210124160517.2251-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

For future ASIC support the driver allows user to map certain regions
in the device's configuration space for direct access from userspace.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     |  3 +
 drivers/misc/habanalabs/common/habanalabs.h | 16 +++-
 drivers/misc/habanalabs/common/memory.c     | 93 ++++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       | 15 +++-
 drivers/misc/habanalabs/goya/goya.c         | 15 +++-
 include/uapi/misc/habanalabs.h              | 18 +++-
 6 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index a438279b8691..0926cfb256ef 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -142,6 +142,9 @@ static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 	switch (vm_pgoff & HL_MMAP_TYPE_MASK) {
 	case HL_MMAP_TYPE_CB:
 		return hl_cb_mmap(hpriv, vma);
+
+	case HL_MMAP_TYPE_BLOCK:
+		return hl_hw_block_mmap(hpriv, vma);
 	}
 
 	return -EINVAL;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4129e4e6a7b5..e105612ed577 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -28,17 +28,18 @@
 #define HL_NAME				"habanalabs"
 
 /* Use upper bits of mmap offset to store habana driver specific information.
- * bits[63:62] - Encode mmap type
+ * bits[63:61] - Encode mmap type
  * bits[45:0]  - mmap offset value
  *
  * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, these
  *  defines are w.r.t to PAGE_SIZE
  */
-#define HL_MMAP_TYPE_SHIFT		(62 - PAGE_SHIFT)
-#define HL_MMAP_TYPE_MASK		(0x3ull << HL_MMAP_TYPE_SHIFT)
+#define HL_MMAP_TYPE_SHIFT		(61 - PAGE_SHIFT)
+#define HL_MMAP_TYPE_MASK		(0x7ull << HL_MMAP_TYPE_SHIFT)
+#define HL_MMAP_TYPE_BLOCK		(0x4ull << HL_MMAP_TYPE_SHIFT)
 #define HL_MMAP_TYPE_CB			(0x2ull << HL_MMAP_TYPE_SHIFT)
 
-#define HL_MMAP_OFFSET_VALUE_MASK	(0x3FFFFFFFFFFFull >> PAGE_SHIFT)
+#define HL_MMAP_OFFSET_VALUE_MASK	(0x1FFFFFFFFFFFull >> PAGE_SHIFT)
 #define HL_MMAP_OFFSET_VALUE_GET(off)	(off & HL_MMAP_OFFSET_VALUE_MASK)
 
 #define HL_PENDING_RESET_PER_SEC	10
@@ -856,6 +857,8 @@ enum div_select_defs {
  * @descramble_addr: Routine to de-scramble the address prior of
  *                  showing it to users.
  * @ack_protection_bits_errors: ack and dump all security violations
+ * @get_hw_block_id: retrieve a HW block id to be used by the user to mmap it.
+ * @hw_block_mmap: mmap a HW block with a given id.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -968,6 +971,10 @@ struct hl_asic_funcs {
 	u64 (*scramble_addr)(struct hl_device *hdev, u64 addr);
 	u64 (*descramble_addr)(struct hl_device *hdev, u64 addr);
 	void (*ack_protection_bits_errors)(struct hl_device *hdev);
+	int (*get_hw_block_id)(struct hl_device *hdev, u64 block_addr,
+			u32 *block_id);
+	int (*hw_block_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
+			u32 block_id, u32 block_size);
 };
 
 
@@ -2167,6 +2174,7 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 			bool map_cb, u64 *handle);
 int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle);
 int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
+int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
 struct hl_cb *hl_cb_get(struct hl_device *hdev,	struct hl_cb_mgr *mgr,
 			u32 handle);
 void hl_cb_put(struct hl_cb *cb);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 36de0d05d3a2..7171e8820a2d 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1289,11 +1289,88 @@ static int unmap_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	return rc;
 }
 
+static int map_block(struct hl_device *hdev, u64 address, u64 *handle)
+{
+	u32 block_id = 0;
+	int rc;
+
+	rc = hdev->asic_funcs->get_hw_block_id(hdev, address, &block_id);
+
+	*handle = block_id | HL_MMAP_TYPE_BLOCK;
+	*handle <<= PAGE_SHIFT;
+
+	return rc;
+}
+
+static void hw_block_vm_close(struct vm_area_struct *vma)
+{
+	struct hl_ctx *ctx = (struct hl_ctx *) vma->vm_private_data;
+
+	hl_ctx_put(ctx);
+	vma->vm_private_data = NULL;
+}
+
+static const struct vm_operations_struct hw_block_vm_ops = {
+	.close = hw_block_vm_close
+};
+
+/**
+ * hl_hw_block_mmap() - mmap a hw block to user.
+ * @hpriv: pointer to the private data of the fd
+ * @vma: pointer to vm_area_struct of the process
+ *
+ * Driver increments context reference for every HW block mapped in order
+ * to prevent user from closing FD without unmapping first
+ */
+int hl_hw_block_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 block_id, block_size;
+	int rc;
+
+	/* We use the page offset to hold the block id and thus we need to clear
+	 * it before doing the mmap itself
+	 */
+	block_id = vma->vm_pgoff;
+	vma->vm_pgoff = 0;
+
+	/* Driver only allows mapping of a complete HW block */
+	block_size = vma->vm_end - vma->vm_start;
+
+#ifdef _HAS_TYPE_ARG_IN_ACCESS_OK
+	if (!access_ok(VERIFY_WRITE,
+		(void __user *) (uintptr_t) vma->vm_start, block_size)) {
+#else
+	if (!access_ok((void __user *) (uintptr_t) vma->vm_start, block_size)) {
+#endif
+		dev_err(hdev->dev,
+			"user pointer is invalid - 0x%lx\n",
+			vma->vm_start);
+
+		return -EINVAL;
+	}
+
+	vma->vm_ops = &hw_block_vm_ops;
+	vma->vm_private_data = hpriv->ctx;
+
+	hl_ctx_get(hdev, hpriv->ctx);
+
+	rc = hdev->asic_funcs->hw_block_mmap(hdev, vma, block_id, block_size);
+	if (rc) {
+		hl_ctx_put(hpriv->ctx);
+		return rc;
+	}
+
+	vma->vm_pgoff = block_id;
+
+	return 0;
+}
+
 static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_ctx *ctx = hpriv->ctx;
-	u64 device_addr = 0;
+	u64 block_handle, device_addr = 0;
 	u32 handle = 0;
 	int rc;
 
@@ -1337,6 +1414,12 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 		rc = 0;
 		break;
 
+	case HL_MEM_OP_MAP_BLOCK:
+		rc = map_block(hdev, args->in.map_block.block_addr,
+							&block_handle);
+		args->out.handle = block_handle;
+		break;
+
 	default:
 		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
 		rc = -ENOTTY;
@@ -1353,7 +1436,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 	union hl_mem_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_ctx *ctx = hpriv->ctx;
-	u64 device_addr = 0;
+	u64 block_handle, device_addr = 0;
 	u32 handle = 0;
 	int rc;
 
@@ -1439,6 +1522,12 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		rc = unmap_device_va(ctx, &args->in, false);
 		break;
 
+	case HL_MEM_OP_MAP_BLOCK:
+		rc = map_block(hdev, args->in.map_block.block_addr,
+							&block_handle);
+		args->out.handle = block_handle;
+		break;
+
 	default:
 		dev_err(hdev->dev, "Unknown opcode for memory IOCTL\n");
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b49e10394ed4..d02c8fb86332 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8471,6 +8471,17 @@ static u64 gaudi_get_device_time(struct hl_device *hdev)
 	return device_time | RREG32(mmPSOC_TIMESTAMP_CNTCVL);
 }
 
+int gaudi_get_hw_block_id(struct hl_device *hdev, u64 block_addr, u32 *block_id)
+{
+	return -EPERM;
+}
+
+int gaudi_block_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+			u32 block_id, u32 block_size)
+{
+	return -EPERM;
+}
+
 static const struct hl_asic_funcs gaudi_funcs = {
 	.early_init = gaudi_early_init,
 	.early_fini = gaudi_early_fini,
@@ -8550,7 +8561,9 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs,
 	.scramble_addr = hl_mmu_scramble_addr,
 	.descramble_addr = hl_mmu_descramble_addr,
-	.ack_protection_bits_errors = gaudi_ack_protection_bits_errors
+	.ack_protection_bits_errors = gaudi_ack_protection_bits_errors,
+	.get_hw_block_id = gaudi_get_hw_block_id,
+	.hw_block_mmap = gaudi_block_mmap
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index db951d622ad5..13f31f5d413d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5382,6 +5382,17 @@ static void goya_ctx_fini(struct hl_ctx *ctx)
 
 }
 
+int goya_get_hw_block_id(struct hl_device *hdev, u64 block_addr, u32 *block_id)
+{
+	return -EPERM;
+}
+
+int goya_block_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+			u32 block_id, u32 block_size)
+{
+	return -EPERM;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5461,7 +5472,9 @@ static const struct hl_asic_funcs goya_funcs = {
 	.collective_wait_create_jobs = goya_collective_wait_create_jobs,
 	.scramble_addr = hl_mmu_scramble_addr,
 	.descramble_addr = hl_mmu_descramble_addr,
-	.ack_protection_bits_errors = goya_ack_protection_bits_errors
+	.ack_protection_bits_errors = goya_ack_protection_bits_errors,
+	.get_hw_block_id = goya_get_hw_block_id,
+	.hw_block_mmap = goya_block_mmap
 };
 
 /*
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 866355a53188..b1c09eba8ac2 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -718,6 +718,8 @@ union hl_wait_cs_args {
 #define HL_MEM_OP_MAP			2
 /* Opcode to unmap previously mapped host and device memory */
 #define HL_MEM_OP_UNMAP			3
+/* Opcode to map a hw block */
+#define HL_MEM_OP_MAP_BLOCK		4
 
 /* Memory flags */
 #define HL_MEM_CONTIGUOUS	0x1
@@ -772,6 +774,17 @@ struct hl_mem_in {
 			__u64 mem_size;
 		} map_host;
 
+		/* HL_MEM_OP_MAP_BLOCK - map a hw block */
+		struct {
+			/*
+			 * HW block address to map, a handle will be returned
+			 * to the user and will be used to mmap the relevant
+			 * block. Only addresses from configuration space are
+			 * allowed.
+			 */
+			__u64 block_addr;
+		} map_block;
+
 		/* HL_MEM_OP_UNMAP - unmap host memory */
 		struct {
 			/* Virtual address returned from HL_MEM_OP_MAP */
@@ -798,8 +811,9 @@ struct hl_mem_out {
 		__u64 device_virt_addr;
 
 		/*
-		 * Used for HL_MEM_OP_ALLOC. This is the assigned
-		 * handle for the allocated memory
+		 * Used for HL_MEM_OP_ALLOC and HL_MEM_OP_MAP_BLOCK.
+		 * This is the assigned handle for the allocated memory
+		 * or mapped block
 		 */
 		__u64 handle;
 	};
-- 
2.25.1


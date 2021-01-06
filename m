Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC122EB883
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAFDm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbhAFDm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:42:27 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD9C061359
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:41:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n25so1325369pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dj8JKlKorbjSOdwS0lvNYWFk7amT5kVhimzXI22aOmo=;
        b=nyHDRg7Vmv1AYnOmtvFMyhhjPOqDXplXsE46O+JQcnB7v+fs3ZJWBBx1UfSrKuJzD/
         qiFZ8JU9bombqMxXDm/lZSO/uU9UIeCy/s4FTWAcP6gjSJdtc1DTG2nFcQh6/7gh/rE4
         s4F6iUuPmIjkPdKaCf1nMPPcD/1GvLZGYzHJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dj8JKlKorbjSOdwS0lvNYWFk7amT5kVhimzXI22aOmo=;
        b=CarCOFYTBIHpGidkyn5R/I2jcVbf20xsIbHU13De76vvsc7zVYfeLPEy16oEqM9Rvu
         yrHpP1btByc6p3npq8JT7jHPC8E3HNeTESdwrjOdfxSIlQWZLKPIjuRBjqz0gEtpvWYp
         q62Bj6LF7lYN3cK1NUv5DxkbK2RDtokwcnLTXWk12RVRdgi0C+4+mbHl3fnaZb5pLuZe
         Hntwtv5QhzXOyvHlz/2AK4EX1Vd81q8NOBPQ0YmkVQPMLNOrd3XkfeMux0+sZAe4KyK1
         AOh5GBlSf/BpBOsCLub3ngdPRvvxryzYoYlgriaLf+NcrIPlUO8qS1TKlu+noQ4HYyhr
         kHkg==
X-Gm-Message-State: AOAM532cZWfFN52r0bu43C8FPRpHTYX1AkzhAwrnmbjqFKBFcJQsQplJ
        1tJFi5KkyX3/K0aKcTPj6Suv6w==
X-Google-Smtp-Source: ABdhPJz99z2RdIIx1bNT47v5aDKOf5A60/F7kX7ZvEglTd1/imvNFy1tfXVN1FEQPH8zUfX6RY9tlA==
X-Received: by 2002:aa7:810a:0:b029:1a6:501b:19ed with SMTP id b10-20020aa7810a0000b02901a6501b19edmr1942562pfi.17.1609904506706;
        Tue, 05 Jan 2021 19:41:46 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id x23sm631878pgk.14.2021.01.05.19.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:41:46 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, joro@8bytes.org, will@kernel.org,
        frowand.list@gmail.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Cc:     grant.likely@arm.com, xypron.glpk@gmx.de, treding@nvidia.com,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, saravanak@google.com,
        rafael.j.wysocki@intel.com, heikki.krogerus@linux.intel.com,
        andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, tfiga@chromium.org,
        drinkcat@chromium.org, Claire Chang <tientzu@chromium.org>
Subject: [RFC PATCH v3 2/6] swiotlb: Add restricted DMA pool
Date:   Wed,  6 Jan 2021 11:41:20 +0800
Message-Id: <20210106034124.30560-3-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210106034124.30560-1-tientzu@chromium.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initialization function to create restricted DMA pools from
matching reserved-memory nodes in the device tree.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 include/linux/device.h  |   4 ++
 include/linux/swiotlb.h |   7 +-
 kernel/dma/Kconfig      |   1 +
 kernel/dma/swiotlb.c    | 144 ++++++++++++++++++++++++++++++++++------
 4 files changed, 131 insertions(+), 25 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 89bb8b84173e..ca6f71ec8871 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -413,6 +413,7 @@ struct dev_links_info {
  * @dma_pools:	Dma pools (if dma'ble device).
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
+ * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -515,6 +516,9 @@ struct device {
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
+#endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem	*dma_io_tlb_mem;
 #endif
 	/* arch specific additions */
 	struct dev_archdata	archdata;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index dd8eb57cbb8f..a1bbd7788885 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -76,12 +76,13 @@ extern enum swiotlb_force swiotlb_force;
  *
  * @start:	The start address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
- *		API.
+ *		API. For restricted DMA pool, this is device tree adjustable.
  * @end:	The end address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
- *		API.
+ *		API. For restricted DMA pool, this is device tree adjustable.
  * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
- *		@end. This is command line adjustable via setup_io_tlb_npages.
+ *		@end. For default swiotlb, this is command line adjustable via
+ *		setup_io_tlb_npages.
  * @used:	The number of used IO TLB block.
  * @list:	The free list describing the number of free entries available
  *		from each index.
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 479fc145acfc..131a0a66781b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -82,6 +82,7 @@ config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
+	select OF_EARLY_FLATTREE
 
 #
 # Should be selected if we can mmap non-coherent mappings to userspace.
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e4368159f88a..7fb2ac087d23 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -36,6 +36,11 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/slab.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -319,20 +324,21 @@ static void swiotlb_cleanup(void)
 	max_segment = 0;
 }
 
-int
-swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+static int swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
+				   size_t size)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-	unsigned long i, bytes;
+	unsigned long i;
+	void *vaddr = phys_to_virt(start);
 
-	bytes = nslabs << IO_TLB_SHIFT;
+	size = ALIGN(size, 1 << IO_TLB_SHIFT);
+	mem->nslabs = size >> IO_TLB_SHIFT;
+	mem->nslabs = ALIGN(mem->nslabs, IO_TLB_SEGSIZE);
 
-	mem->nslabs = nslabs;
-	mem->start = virt_to_phys(tlb);
-	mem->end = mem->start + bytes;
+	mem->start = start;
+	mem->end = mem->start + size;
 
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
-	memset(tlb, 0, bytes);
+	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
+	memset(vaddr, 0, size);
 
 	/*
 	 * Allocate and initialize the free list array.  This array is used
@@ -356,13 +362,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 		mem->orig_addr[i] = INVALID_PHYS_ADDR;
 	}
 	mem->index = 0;
-	no_iotlb_memory = false;
-
-	swiotlb_print_info();
-
-	late_alloc = 1;
-
-	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
 
 	return 0;
 
@@ -375,6 +374,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
+int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
+{
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	unsigned long bytes = nslabs << IO_TLB_SHIFT;
+	int ret;
+
+	ret = swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), bytes);
+	if (ret)
+		return ret;
+
+	no_iotlb_memory = false;
+
+	swiotlb_print_info();
+
+	late_alloc = 1;
+
+	swiotlb_set_max_segment(bytes);
+
+	return 0;
+}
+
 void __init swiotlb_exit(void)
 {
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
@@ -703,16 +723,96 @@ bool is_swiotlb_active(void)
 
 #ifdef CONFIG_DEBUG_FS
 
-static int __init swiotlb_create_debugfs(void)
+static void swiotlb_create_debugfs(struct io_tlb_mem *mem, const char *name,
+				   struct dentry *node)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
-
-	mem->debugfs = debugfs_create_dir("swiotlb", NULL);
+	mem->debugfs = debugfs_create_dir(name, node);
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
 	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
+}
+
+static int __init swiotlb_create_default_debugfs(void)
+{
+	swiotlb_create_debugfs(&io_tlb_default_mem, "swiotlb", NULL);
+
 	return 0;
 }
 
-late_initcall(swiotlb_create_debugfs);
+late_initcall(swiotlb_create_default_debugfs);
 
 #endif
+
+static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
+				    struct device *dev)
+{
+	struct io_tlb_mem *mem = rmem->priv;
+	int ret;
+
+	if (dev->dma_io_tlb_mem)
+		return -EBUSY;
+
+	if (!mem) {
+		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+		if (!mem)
+			return -ENOMEM;
+
+		if (!memremap(rmem->base, rmem->size, MEMREMAP_WB)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
+		ret = swiotlb_init_io_tlb_mem(mem, rmem->base, rmem->size);
+		if (ret)
+			goto cleanup;
+
+		rmem->priv = mem;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	swiotlb_create_debugfs(mem, dev_name(dev), io_tlb_default_mem.debugfs);
+#endif
+
+	dev->dma_io_tlb_mem = mem;
+
+	return 0;
+
+cleanup:
+	kfree(mem);
+
+	return ret;
+}
+
+static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
+					struct device *dev)
+{
+	if (!dev)
+		return;
+
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(dev->dma_io_tlb_mem->debugfs);
+#endif
+	dev->dma_io_tlb_mem = NULL;
+}
+
+static const struct reserved_mem_ops rmem_swiotlb_ops = {
+	.device_init	= rmem_swiotlb_device_init,
+	.device_release	= rmem_swiotlb_device_release,
+};
+
+static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+
+	if (of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	rmem->ops = &rmem_swiotlb_ops;
+	pr_info("Reserved memory: created device swiotlb memory pool at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	return 0;
+}
+
+RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", rmem_swiotlb_setup);
-- 
2.29.2.729.g45daf8777d-goog


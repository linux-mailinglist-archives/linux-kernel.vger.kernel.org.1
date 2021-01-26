Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EDA304DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbhAZXM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbhAZEzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:55:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA1C0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lw17so802566pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGEryhrm5c1wqfxot2kAYpl/XWvHAkbpC5WQ3NIWIAU=;
        b=qfwpbyqlt6zOAaUEZxTqpvbXz5OoP0/xUb0/QnP2xTRAo/J5CCB31Sei5jFQPW/gnO
         FCqSgCivxck59xSdPwNpioaxmWln/fz5+wnCaEZYOvbu5+mb3IGG1alccVcPCG/PT12P
         +Xyaf2XClLgEcFa6T/wEVmauzmybyPi8xiXtBXN72jW+Y4SGCYnyZ3s2awnhFgH04ufp
         qADTTnUlYxcVOoRL6nZ3hgIZpHAfCJIk85NQkT73UiTc2nrHbgIh0jIl33zn0V2xihOr
         +gysALVmTiTksdyT/AbJm3XERhqzZnVLfE5rtpYcNAw9c43nhqqRD+njK7yKcrsmD5nE
         INJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGEryhrm5c1wqfxot2kAYpl/XWvHAkbpC5WQ3NIWIAU=;
        b=iqtoaKvSqnpDFjXy1xqlDk4lk5GZf17dRoogoePdFJpgaMOjSryvdvk4EDMWCsz7I+
         jwdmew/kBGwZ7Mm9/MtX5EztdTxSOggTTupphGFvt913C/Wze4iOJYjO5kQSLxtwsNRd
         vuPm36pxoA0uJROWCIK1/v7ZeqI0uAQlOX7ZrsKlXeAItExlSUu1jrlZfc7H21y8Dr4p
         k5PV7nBB7jviTHmLMb5D+ica/pqOGjLjYcV6mW/zgE/V7Or80QchLAAGLAUwSMXHX97M
         Lvq165pw9N1naSRiP3FPb+Wamy+Yy4IjUw8ZSt/BD+zNQKvq8QzIFhXeL13WKn0tW1BU
         ukMg==
X-Gm-Message-State: AOAM533xepazolcQqnPL4Jw2638Wk3u+T0+O28iJjzjQ0f4alJRIt45i
        uc2r/UDP2bDmQtoEYPF1wLU=
X-Google-Smtp-Source: ABdhPJzmZbawnaJ6T51tQobT8KneXcFflspxxOZksfckoxk0gdsxd/RQkXROfH4VVEHDTAzSOOS6jQ==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr4087606pjs.176.1611636866026;
        Mon, 25 Jan 2021 20:54:26 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id w184sm18803382pgb.71.2021.01.25.20.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:54:25 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/5] mm/vmalloc: remove unmap_kernel_range
Date:   Tue, 26 Jan 2021 14:54:03 +1000
Message-Id: <20210126045404.2492588-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126045404.2492588-1-npiggin@gmail.com>
References: <20210126045404.2492588-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a shim around vunmap_range, get rid of it.

Move the main API comment from the _noflush variant to the normal
variant, and make _noflush internal to mm/.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/core-api/cachetlb.rst |  2 +-
 arch/arm64/mm/init.c                |  2 +-
 arch/powerpc/kernel/isa-bridge.c    |  4 +-
 arch/powerpc/kernel/pci_64.c        |  2 +-
 arch/powerpc/mm/ioremap.c           |  2 +-
 drivers/pci/pci.c                   |  2 +-
 include/linux/vmalloc.h             |  8 +---
 mm/internal.h                       |  1 +
 mm/percpu-vm.c                      |  2 +-
 mm/vmalloc.c                        | 59 ++++++++++++++---------------
 10 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index 756f7bcf8191..fe4290e26729 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -215,7 +215,7 @@ Here are the routines, one by one:
 
 	The first of these two routines is invoked after vmap_range()
 	has installed the page table entries.  The second is invoked
-	before unmap_kernel_range() deletes the page table entries.
+	before vunmap_range() deletes the page table entries.
 
 There exists another whole class of cpu cache issues which currently
 require a whole different set of interfaces to handle properly.
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 709d98fea90c..7fe0a5074205 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -498,7 +498,7 @@ void free_initmem(void)
 	 * prevents the region from being reused for kernel modules, which
 	 * is not supported by kallsyms.
 	 */
-	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
+	vunmap_range((u64)__init_begin, (u64)__init_end);
 }
 
 void dump_mem_limit(void)
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index 2257d24e6a26..39c625737c09 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -48,7 +48,7 @@ static void remap_isa_base(phys_addr_t pa, unsigned long size)
 	if (slab_is_available()) {
 		if (ioremap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
 				pgprot_noncached(PAGE_KERNEL)))
-			unmap_kernel_range(ISA_IO_BASE, size);
+			vunmap_range(ISA_IO_BASE, ISA_IO_BASE + size);
 	} else {
 		early_ioremap_range(ISA_IO_BASE, pa, size,
 				pgprot_noncached(PAGE_KERNEL));
@@ -311,7 +311,7 @@ static void isa_bridge_remove(void)
 	isa_bridge_pcidev = NULL;
 
 	/* Unmap the ISA area */
-	unmap_kernel_range(ISA_IO_BASE, 0x10000);
+	vunmap_range(ISA_IO_BASE, ISA_IO_BASE + 0x10000);
 }
 
 /**
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 9312e6eda7ff..3fb7e572abed 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -140,7 +140,7 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
 	addr = (unsigned long)area->addr;
 	if (ioremap_page_range(addr, addr + size, paddr,
 			pgprot_noncached(PAGE_KERNEL))) {
-		unmap_kernel_range(addr, size);
+		vunmap_range(addr, addr + size);
 		return NULL;
 	}
 
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index b1a0aebe8c48..57342154d2b0 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -93,7 +93,7 @@ void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
 	if (!ret)
 		return (void __iomem *)area->addr + offset;
 
-	unmap_kernel_range(va, size);
+	vunmap_range(va, va + size);
 	free_vm_area(area);
 
 	return NULL;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d213..d1e5ee09b381 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4107,7 +4107,7 @@ void pci_unmap_iospace(struct resource *res)
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
 
-	unmap_kernel_range(vaddr, resource_size(res));
+	vunmap_range(vaddr, vaddr + resource_size(res));
 #endif
 }
 EXPORT_SYMBOL(pci_unmap_iospace);
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 913c9d4f5e03..b569a13c9960 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -217,8 +217,7 @@ static inline bool is_vm_area_hugepages(const void *addr)
 int vmap_range(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift);
-extern void unmap_kernel_range_noflush(unsigned long addr, unsigned long size);
-extern void unmap_kernel_range(unsigned long addr, unsigned long size);
+void vunmap_range(unsigned long addr, unsigned long end);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 	struct vm_struct *vm = find_vm_area(addr);
@@ -228,11 +227,6 @@ static inline void set_vm_flush_reset_perms(void *addr)
 }
 
 #else
-static inline void
-unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
-{
-}
-#define unmap_kernel_range unmap_kernel_range_noflush
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 }
diff --git a/mm/internal.h b/mm/internal.h
index 3ce246945882..3d4449f79582 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -628,5 +628,6 @@ struct migration_target_control {
  */
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                 pgprot_t prot, struct page **pages, unsigned int page_shift);
+void vunmap_range_noflush(unsigned long start, unsigned long end);
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 88a53eb68a94..8d3844bc0c7c 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -134,7 +134,7 @@ static void pcpu_pre_unmap_flush(struct pcpu_chunk *chunk,
 
 static void __pcpu_unmap_pages(unsigned long addr, int nr_pages)
 {
-	unmap_kernel_range_noflush(addr, nr_pages << PAGE_SHIFT);
+	vunmap_range_noflush(addr, addr + (nr_pages << PAGE_SHIFT));
 }
 
 /**
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 78dc3ec457ef..5ff190590fe4 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -378,22 +378,20 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	} while (p4d++, addr = next, addr != end);
 }
 
-/**
- * unmap_kernel_range_noflush - unmap kernel VM area
- * @start: start of the VM area to unmap
- * @size: size of the VM area to unmap
+/*
+ * vunmap_range_noflush is similar to vunmap_range, but does not
+ * flush caches or TLBs.
  *
- * Unmap PFN_UP(@size) pages at @addr.  The VM area @addr and @size specify
- * should have been allocated using get_vm_area() and its friends.
+ * The caller is responsible for calling flush_cache_vmap() before calling
+ * this function, and flush_tlb_kernel_range after it has returned
+ * successfully (and before the addresses are expected to cause a page fault
+ * or be re-mapped for something else, if TLB flushes are being delayed or
+ * coalesced).
  *
- * NOTE:
- * This function does NOT do any cache flushing.  The caller is responsible
- * for calling flush_cache_vunmap() on to-be-mapped areas before calling this
- * function and flush_tlb_kernel_range() after.
+ * This is an internal function only. Do not use outside mm/.
  */
-void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
+void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
-	unsigned long end = start + size;
 	unsigned long next;
 	pgd_t *pgd;
 	unsigned long addr = start;
@@ -414,6 +412,22 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 		arch_sync_kernel_mappings(start, end);
 }
 
+/**
+ * vunmap_range_noflush - unmap kernel virtual addresses
+ * @addr: start of the VM area to unmap
+ * @end: end of the VM area to unmap (non-inclusive)
+ *
+ * Clears any present PTEs in the virtual address range, flushes TLBs and
+ * caches. Any subsequent access to the address before it has been re-mapped
+ * is a kernel bug.
+ */
+void vunmap_range(unsigned long addr, unsigned long end)
+{
+	flush_cache_vunmap(addr, end);
+	vunmap_range_noflush(addr, end);
+	flush_tlb_kernel_range(addr, end);
+}
+
 static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
@@ -1712,7 +1726,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 static void free_unmap_vmap_area(struct vmap_area *va)
 {
 	flush_cache_vunmap(va->va_start, va->va_end);
-	unmap_kernel_range_noflush(va->va_start, va->va_end - va->va_start);
+	vunmap_range_noflush(va->va_start, va->va_end);
 	if (debug_pagealloc_enabled_static())
 		flush_tlb_kernel_range(va->va_start, va->va_end);
 
@@ -1990,7 +2004,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
 	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
 
-	unmap_kernel_range_noflush(addr, size);
+	vunmap_range_noflush(addr, addr + size);
 
 	if (debug_pagealloc_enabled_static())
 		flush_tlb_kernel_range(addr, addr + size);
@@ -2307,23 +2321,6 @@ void __init vmalloc_init(void)
 	vmap_initialized = true;
 }
 
-/**
- * unmap_kernel_range - unmap kernel VM area and flush cache and TLB
- * @addr: start of the VM area to unmap
- * @size: size of the VM area to unmap
- *
- * Similar to unmap_kernel_range_noflush() but flushes vcache before
- * the unmapping and tlb after.
- */
-void unmap_kernel_range(unsigned long addr, unsigned long size)
-{
-	unsigned long end = addr + size;
-
-	flush_cache_vunmap(addr, end);
-	unmap_kernel_range_noflush(addr, size);
-	flush_tlb_kernel_range(addr, end);
-}
-
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
 {
-- 
2.23.0


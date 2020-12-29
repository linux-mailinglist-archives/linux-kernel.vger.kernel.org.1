Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8252E74D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgL2Vhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgL2Vhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:37:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7A0D221F8;
        Tue, 29 Dec 2020 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277819;
        bh=4+XVuUBVbuDdiVzAL+2N3gTETnQsM5IfaNCkZRUJcis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pepclksIOBM2ECeX1f4p1V5qVN8qF05zcyv6oO2h+4xZ4Fz7iWV5+pByoBnI7YGSi
         DvoLG0JDGfEo8benn2MADLrBWbSrdPrE3EmPK5HHzpFy6o0i5dbVKsTYfSdEnRQNvy
         HCfwSzjXGmC+cpMUpJ3x+Bpk0Zo/VaAwf0+yiOtWbWbuIojGHSI7yOkfQpTcoYzOsd
         01T8qVveA3yBbv9K4SA8+uq9oZ8/0gUeW1Rp2uww0d6/ccwqtgrAiDNIEsSbL4ectg
         bm276zmG7U/aAW0YzM2HKP3YoCw8aueZ211Sq70PIrZBML4UAr+aAYt7LVgrz9eKw+
         rdrONSiugZ9Ow==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 2/8] habanalabs: kernel doc format in memory functions
Date:   Tue, 29 Dec 2020 23:36:47 +0200
Message-Id: <20201229213653.29749-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229213653.29749-1-ogabbay@kernel.org>
References: <20201229213653.29749-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Change all memory functions documentation according to kernel doc
format.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 377 +++++++++++-------------
 1 file changed, 180 insertions(+), 197 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index c16c829bfbf2..6efd90d25ff5 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -38,15 +38,14 @@
  */
 
 /*
- * alloc_device_memory - allocate device memory
- *
- * @ctx                 : current context
- * @args                : host parameters containing the requested size
- * @ret_handle          : result handle
+ * alloc_device_memory() - allocate device memory.
+ * @ctx: pointer to the context structure.
+ * @args: host parameters containing the requested size.
+ * @ret_handle: result handle.
  *
  * This function does the following:
- * - Allocate the requested size rounded up to 'dram_page_size' pages
- * - Return unique handle
+ * - Allocate the requested size rounded up to 'dram_page_size' pages.
+ * - Return unique handle for later map/unmap/free.
  */
 static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 				u32 *ret_handle)
@@ -182,17 +181,17 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	return rc;
 }
 
-/*
- * dma_map_host_va - DMA mapping of the given host virtual address.
- * @hdev: habanalabs device structure
- * @addr: the host virtual address of the memory area
- * @size: the size of the memory area
- * @p_userptr: pointer to result userptr structure
+/**
+ * dma_map_host_va() - DMA mapping of the given host virtual address.
+ * @hdev: habanalabs device structure.
+ * @addr: the host virtual address of the memory area.
+ * @size: the size of the memory area.
+ * @p_userptr: pointer to result userptr structure.
  *
  * This function does the following:
- * - Allocate userptr structure
- * - Pin the given host memory using the userptr structure
- * - Perform DMA mapping to have the DMA addresses of the pages
+ * - Allocate userptr structure.
+ * - Pin the given host memory using the userptr structure.
+ * - Perform DMA mapping to have the DMA addresses of the pages.
  */
 static int dma_map_host_va(struct hl_device *hdev, u64 addr, u64 size,
 				struct hl_userptr **p_userptr)
@@ -236,14 +235,14 @@ static int dma_map_host_va(struct hl_device *hdev, u64 addr, u64 size,
 	return rc;
 }
 
-/*
- * dma_unmap_host_va - DMA unmapping of the given host virtual address.
- * @hdev: habanalabs device structure
- * @userptr: userptr to free
+/**
+ * dma_unmap_host_va() - DMA unmapping of the given host virtual address.
+ * @hdev: habanalabs device structure.
+ * @userptr: userptr to free.
  *
  * This function does the following:
- * - Unpins the physical pages
- * - Frees the userptr structure
+ * - Unpins the physical pages.
+ * - Frees the userptr structure.
  */
 static void dma_unmap_host_va(struct hl_device *hdev,
 				struct hl_userptr *userptr)
@@ -252,14 +251,13 @@ static void dma_unmap_host_va(struct hl_device *hdev,
 	kfree(userptr);
 }
 
-/*
- * dram_pg_pool_do_release - free DRAM pages pool
- *
- * @ref                 : pointer to reference object
+/**
+ * dram_pg_pool_do_release() - free DRAM pages pool
+ * @ref: pointer to reference object.
  *
  * This function does the following:
- * - Frees the idr structure of physical pages handles
- * - Frees the generic pool of DRAM physical pages
+ * - Frees the idr structure of physical pages handles.
+ * - Frees the generic pool of DRAM physical pages.
  */
 static void dram_pg_pool_do_release(struct kref *ref)
 {
@@ -274,15 +272,15 @@ static void dram_pg_pool_do_release(struct kref *ref)
 	gen_pool_destroy(vm->dram_pg_pool);
 }
 
-/*
- * free_phys_pg_pack - free physical page pack
- * @hdev: habanalabs device structure
- * @phys_pg_pack: physical page pack to free
+/**
+ * free_phys_pg_pack() - free physical page pack.
+ * @hdev: habanalabs device structure.
+ * @phys_pg_pack: physical page pack to free.
  *
  * This function does the following:
  * - For DRAM memory only, iterate over the pack and free each physical block
- *   structure by returning it to the general pool
- * - Free the hl_vm_phys_pg_pack structure
+ *   structure by returning it to the general pool.
+ * - Free the hl_vm_phys_pg_pack structure.
  */
 static void free_phys_pg_pack(struct hl_device *hdev,
 				struct hl_vm_phys_pg_pack *phys_pg_pack)
@@ -313,14 +311,13 @@ static void free_phys_pg_pack(struct hl_device *hdev,
 	kfree(phys_pg_pack);
 }
 
-/*
- * free_device_memory - free device memory
- *
- * @ctx                  : current context
- * @handle              : handle of the memory chunk to free
+/**
+ * free_device_memory() - free device memory.
+ * @ctx: pointer to the context structure.
+ * @handle: handle of the memory chunk to free.
  *
  * This function does the following:
- * - Free the device memory related to the given handle
+ * - Free the device memory related to the given handle.
  */
 static int free_device_memory(struct hl_ctx *ctx, u32 handle)
 {
@@ -361,16 +358,15 @@ static int free_device_memory(struct hl_ctx *ctx, u32 handle)
 	return 0;
 }
 
-/*
- * clear_va_list_locked - free virtual addresses list
- *
- * @hdev                : habanalabs device structure
- * @va_list             : list of virtual addresses to free
+/**
+ * clear_va_list_locked() - free virtual addresses list.
+ * @hdev: habanalabs device structure.
+ * @va_list: list of virtual addresses to free.
  *
  * This function does the following:
- * - Iterate over the list and free each virtual addresses block
+ * - Iterate over the list and free each virtual addresses block.
  *
- * This function should be called only when va_list lock is taken
+ * This function should be called only when va_list lock is taken.
  */
 static void clear_va_list_locked(struct hl_device *hdev,
 		struct list_head *va_list)
@@ -383,16 +379,15 @@ static void clear_va_list_locked(struct hl_device *hdev,
 	}
 }
 
-/*
- * print_va_list_locked    - print virtual addresses list
- *
- * @hdev                : habanalabs device structure
- * @va_list             : list of virtual addresses to print
+/**
+ * print_va_list_locked() - print virtual addresses list.
+ * @hdev: habanalabs device structure.
+ * @va_list: list of virtual addresses to print.
  *
  * This function does the following:
- * - Iterate over the list and print each virtual addresses block
+ * - Iterate over the list and print each virtual addresses block.
  *
- * This function should be called only when va_list lock is taken
+ * This function should be called only when va_list lock is taken.
  */
 static void print_va_list_locked(struct hl_device *hdev,
 		struct list_head *va_list)
@@ -409,18 +404,17 @@ static void print_va_list_locked(struct hl_device *hdev,
 #endif
 }
 
-/*
- * merge_va_blocks_locked - merge a virtual block if possible
- *
- * @hdev                : pointer to the habanalabs device structure
- * @va_list             : pointer to the virtual addresses block list
- * @va_block            : virtual block to merge with adjacent blocks
+/**
+ * merge_va_blocks_locked() - merge a virtual block if possible.
+ * @hdev: pointer to the habanalabs device structure.
+ * @va_list: pointer to the virtual addresses block list.
+ * @va_block: virtual block to merge with adjacent blocks.
  *
  * This function does the following:
  * - Merge the given blocks with the adjacent blocks if their virtual ranges
- *   create a contiguous virtual range
+ *   create a contiguous virtual range.
  *
- * This Function should be called only when va_list lock is taken
+ * This Function should be called only when va_list lock is taken.
  */
 static void merge_va_blocks_locked(struct hl_device *hdev,
 		struct list_head *va_list, struct hl_vm_va_block *va_block)
@@ -445,19 +439,18 @@ static void merge_va_blocks_locked(struct hl_device *hdev,
 	}
 }
 
-/*
- * add_va_block_locked - add a virtual block to the virtual addresses list
- *
- * @hdev                : pointer to the habanalabs device structure
- * @va_list             : pointer to the virtual addresses block list
- * @start               : start virtual address
- * @end                 : end virtual address
+/**
+ * add_va_block_locked() - add a virtual block to the virtual addresses list.
+ * @hdev: pointer to the habanalabs device structure.
+ * @va_list: pointer to the virtual addresses block list.
+ * @start: start virtual address.
+ * @end: end virtual address.
  *
  * This function does the following:
- * - Add the given block to the virtual blocks list and merge with other
- * blocks if a contiguous virtual block can be created
+ * - Add the given block to the virtual blocks list and merge with other blocks
+ *   if a contiguous virtual block can be created.
  *
- * This Function should be called only when va_list lock is taken
+ * This Function should be called only when va_list lock is taken.
  */
 static int add_va_block_locked(struct hl_device *hdev,
 		struct list_head *va_list, u64 start, u64 end)
@@ -501,16 +494,15 @@ static int add_va_block_locked(struct hl_device *hdev,
 	return 0;
 }
 
-/*
- * add_va_block - wrapper for add_va_block_locked
- *
- * @hdev                : pointer to the habanalabs device structure
- * @va_list             : pointer to the virtual addresses block list
- * @start               : start virtual address
- * @end                 : end virtual address
+/**
+ * add_va_block() - wrapper for add_va_block_locked.
+ * @hdev: pointer to the habanalabs device structure.
+ * @va_list: pointer to the virtual addresses block list.
+ * @start: start virtual address.
+ * @end: end virtual address.
  *
  * This function does the following:
- * - Takes the list lock and calls add_va_block_locked
+ * - Takes the list lock and calls add_va_block_locked.
  */
 static inline int add_va_block(struct hl_device *hdev,
 		struct hl_va_range *va_range, u64 start, u64 end)
@@ -524,7 +516,7 @@ static inline int add_va_block(struct hl_device *hdev,
 	return rc;
 }
 
-/*
+/**
  * get_va_block() - get a virtual block for the given size and alignment.
  * @hdev: pointer to the habanalabs device structure.
  * @va_range: pointer to the virtual addresses range.
@@ -620,7 +612,7 @@ static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
 	return res_valid_start;
 }
 
-/*
+/**
  * hl_reserve_va_block() - reserve a virtual block of a given size.
  * @hdev: pointer to the habanalabs device structure.
  * @ctx: current context
@@ -644,9 +636,9 @@ u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 
 /**
  * hl_get_va_range_type() - get va_range type for the given address and size.
- * @address: The start address of the area we want to validate.
- * @size: The size in bytes of the area we want to validate.
- * @type: returned va_range type
+ * @address: the start address of the area we want to validate.
+ * @size: the size in bytes of the area we want to validate.
+ * @type: returned va_range type.
  *
  * Return: true if the area is inside a valid range, false otherwise.
  */
@@ -667,16 +659,15 @@ static int hl_get_va_range_type(struct hl_ctx *ctx, u64 address, u64 size,
 	return -EINVAL;
 }
 
-/*
- * hl_unreserve_va_block - wrapper for add_va_block for unreserving a va block
- *
+/**
+ * hl_unreserve_va_block() - wrapper for add_va_block to unreserve a va block.
  * @hdev: pointer to the habanalabs device structure
- * @ctx: current context
- * @start: start virtual address
- * @end: end virtual address
+ * @ctx: pointer to the context structure.
+ * @start: start virtual address.
+ * @end: end virtual address.
  *
  * This function does the following:
- * - Takes the list lock and calls add_va_block_locked
+ * - Takes the list lock and calls add_va_block_locked.
  */
 int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 		u64 start_addr, u64 size)
@@ -701,11 +692,10 @@ int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 	return rc;
 }
 
-/*
- * get_sg_info - get number of pages and the DMA address from SG list
- *
- * @sg                 : the SG list
- * @dma_addr           : pointer to DMA address to return
+/**
+ * get_sg_info() - get number of pages and the DMA address from SG list.
+ * @sg: the SG list.
+ * @dma_addr: pointer to DMA address to return.
  *
  * Calculate the number of consecutive pages described by the SG list. Take the
  * offset of the address in the first page, add to it the length and round it up
@@ -719,17 +709,17 @@ static u32 get_sg_info(struct scatterlist *sg, dma_addr_t *dma_addr)
 			(PAGE_SIZE - 1)) >> PAGE_SHIFT;
 }
 
-/*
- * init_phys_pg_pack_from_userptr - initialize physical page pack from host
- *                                  memory
- * @ctx: current context
- * @userptr: userptr to initialize from
- * @pphys_pg_pack: result pointer
+/**
+ * init_phys_pg_pack_from_userptr() - initialize physical page pack from host
+ *                                    memory
+ * @ctx: pointer to the context structure.
+ * @userptr: userptr to initialize from.
+ * @pphys_pg_pack: result pointer.
  *
  * This function does the following:
- * - Pin the physical pages related to the given virtual block
+ * - Pin the physical pages related to the given virtual block.
  * - Create a physical page pack from the physical pages related to the given
- *   virtual block
+ *   virtual block.
  */
 static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 				struct hl_userptr *userptr,
@@ -821,16 +811,16 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 	return rc;
 }
 
-/*
- * map_phys_pg_pack - maps the physical page pack.
- * @ctx: current context
- * @vaddr: start address of the virtual area to map from
- * @phys_pg_pack: the pack of physical pages to map to
+/**
+ * map_phys_pg_pack() - maps the physical page pack..
+ * @ctx: pointer to the context structure.
+ * @vaddr: start address of the virtual area to map from.
+ * @phys_pg_pack: the pack of physical pages to map to.
  *
  * This function does the following:
- * - Maps each chunk of virtual memory to matching physical chunk
- * - Stores number of successful mappings in the given argument
- * - Returns 0 on success, error code otherwise
+ * - Maps each chunk of virtual memory to matching physical chunk.
+ * - Stores number of successful mappings in the given argument.
+ * - Returns 0 on success, error code otherwise.
  */
 static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 				struct hl_vm_phys_pg_pack *phys_pg_pack)
@@ -875,11 +865,11 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 	return rc;
 }
 
-/*
- * unmap_phys_pg_pack - unmaps the physical page pack
- * @ctx: current context
- * @vaddr: start address of the virtual area to unmap
- * @phys_pg_pack: the pack of physical pages to unmap
+/**
+ * unmap_phys_pg_pack() - unmaps the physical page pack.
+ * @ctx: pointer to the context structure.
+ * @vaddr: start address of the virtual area to unmap.
+ * @phys_pg_pack: the pack of physical pages to unmap.
  */
 static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 				struct hl_vm_phys_pg_pack *phys_pg_pack)
@@ -907,7 +897,7 @@ static void unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 }
 
 static int get_paddr_from_handle(struct hl_ctx *ctx, struct hl_mem_in *args,
-				u64 *paddr)
+					u64 *paddr)
 {
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_vm *vm = &hdev->vm;
@@ -930,19 +920,18 @@ static int get_paddr_from_handle(struct hl_ctx *ctx, struct hl_mem_in *args,
 	return 0;
 }
 
-/*
- * map_device_va - map the given memory
- *
- * @ctx	         : current context
- * @args         : host parameters with handle/host virtual address
- * @device_addr	 : pointer to result device virtual address
+/**
+ * map_device_va() - map the given memory.
+ * @ctx: pointer to the context structure.
+ * @args: host parameters with handle/host virtual address.
+ * @device_addr: pointer to result device virtual address.
  *
  * This function does the following:
  * - If given a physical device memory handle, map to a device virtual block
- *   and return the start address of this block
+ *   and return the start address of this block.
  * - If given a host virtual address and size, find the related physical pages,
  *   map a device virtual block to this pages and return the start address of
- *   this block
+ *   this block.
  */
 static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		u64 *device_addr)
@@ -1119,16 +1108,15 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	return rc;
 }
 
-/*
- * unmap_device_va      - unmap the given device virtual address
- *
- * @ctx                 : current context
- * @vaddr               : device virtual address to unmap
- * @ctx_free            : true if in context free flow, false otherwise.
+/**
+ * unmap_device_va() - unmap the given device virtual address.
+ * @ctx: pointer to the context structure.
+ * @vaddr: device virtual address to unmap.
+ * @ctx_free: true if in context free flow, false otherwise.
  *
  * This function does the following:
- * - Unmap the physical pages related to the given virtual address
- * - return the device virtual block to the virtual block list
+ * - unmap the physical pages related to the given virtual address.
+ * - return the device virtual block to the virtual block list.
  */
 static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 {
@@ -1295,7 +1283,7 @@ static int mem_ioctl_no_mmu(struct hl_fpriv *hpriv, union hl_mem_args *args)
 			rc = 0;
 		} else {
 			rc = get_paddr_from_handle(ctx, &args->in,
-					&device_addr);
+							&device_addr);
 		}
 
 		memset(args, 0, sizeof(*args));
@@ -1472,16 +1460,16 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
 	return rc;
 }
 
-/*
- * hl_pin_host_memory - pins a chunk of host memory.
- * @hdev: pointer to the habanalabs device structure
- * @addr: the host virtual address of the memory area
- * @size: the size of the memory area
- * @userptr: pointer to hl_userptr structure
+/**
+ * hl_pin_host_memory() - pins a chunk of host memory.
+ * @hdev: pointer to the habanalabs device structure.
+ * @addr: the host virtual address of the memory area.
+ * @size: the size of the memory area.
+ * @userptr: pointer to hl_userptr structure.
  *
  * This function does the following:
- * - Pins the physical pages
- * - Create an SG list from those pages
+ * - Pins the physical pages.
+ * - Create an SG list from those pages.
  */
 int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 					struct hl_userptr *userptr)
@@ -1579,11 +1567,10 @@ void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
 	kfree(userptr->sgt);
 }
 
-/*
- * hl_userptr_delete_list - clear userptr list
- *
- * @hdev                : pointer to the habanalabs device structure
- * @userptr_list        : pointer to the list to clear
+/**
+ * hl_userptr_delete_list() - clear userptr list.
+ * @hdev: pointer to the habanalabs device structure.
+ * @userptr_list: pointer to the list to clear.
  *
  * This function does the following:
  * - Iterates over the list and unpins the host memory and frees the userptr
@@ -1602,12 +1589,11 @@ void hl_userptr_delete_list(struct hl_device *hdev,
 	INIT_LIST_HEAD(userptr_list);
 }
 
-/*
- * hl_userptr_is_pinned - returns whether the given userptr is pinned
- *
- * @hdev                : pointer to the habanalabs device structure
- * @userptr_list        : pointer to the list to clear
- * @userptr             : pointer to userptr to check
+/**
+ * hl_userptr_is_pinned() - returns whether the given userptr is pinned.
+ * @hdev: pointer to the habanalabs device structure.
+ * @userptr_list: pointer to the list to clear.
+ * @userptr: pointer to userptr to check.
  *
  * This function does the following:
  * - Iterates over the list and checks if the given userptr is in it, means is
@@ -1625,12 +1611,12 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr,
 	return false;
 }
 
-/*
- * va_range_init - initialize virtual addresses range
- * @hdev: pointer to the habanalabs device structure
- * @va_range: pointer to the range to initialize
- * @start: range start address
- * @end: range end address
+/**
+ * va_range_init() - initialize virtual addresses range.
+ * @hdev: pointer to the habanalabs device structure.
+ * @va_range: pointer to the range to initialize.
+ * @start: range start address.
+ * @end: range end address.
  *
  * This function does the following:
  * - Initializes the virtual addresses list of the given range with the given
@@ -1672,13 +1658,13 @@ static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_range,
 	return 0;
 }
 
-/*
- * va_range_fini() - clear a virtual addresses range
- * @hdev: pointer to the habanalabs structure
- * va_range: pointer to virtual addresses range
+/**
+ * va_range_fini() - clear a virtual addresses range.
+ * @hdev: pointer to the habanalabs structure.
+ * va_range: pointer to virtual addresses rang.e
  *
  * This function does the following:
- * - Frees the virtual addresses block list and its lock
+ * - Frees the virtual addresses block list and its lock.
  */
 static void va_range_fini(struct hl_device *hdev, struct hl_va_range *va_range)
 {
@@ -1690,22 +1676,22 @@ static void va_range_fini(struct hl_device *hdev, struct hl_va_range *va_range)
 	kfree(va_range);
 }
 
-/*
- * vm_ctx_init_with_ranges() - initialize virtual memory for context
- * @ctx: pointer to the habanalabs context structure
+/**
+ * vm_ctx_init_with_ranges() - initialize virtual memory for context.
+ * @ctx: pointer to the habanalabs context structure.
  * @host_range_start: host virtual addresses range start.
  * @host_range_end: host virtual addresses range end.
  * @host_huge_range_start: host virtual addresses range start for memory
- *                          allocated with huge pages.
+ *                         allocated with huge pages.
  * @host_huge_range_end: host virtual addresses range end for memory allocated
  *                        with huge pages.
  * @dram_range_start: dram virtual addresses range start.
  * @dram_range_end: dram virtual addresses range end.
  *
  * This function initializes the following:
- * - MMU for context
- * - Virtual address to area descriptor hashtable
- * - Virtual block list of available virtual memory
+ * - MMU for context.
+ * - Virtual address to area descriptor hashtable.
+ * - Virtual block list of available virtual memory.
  */
 static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
 					u64 host_range_start,
@@ -1840,15 +1826,14 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
 			dram_range_start, dram_range_end, dram_page_size);
 }
 
-/*
- * hl_vm_ctx_fini       - virtual memory teardown of context
- *
- * @ctx                 : pointer to the habanalabs context structure
+/**
+ * hl_vm_ctx_fini() - virtual memory teardown of context.
+ * @ctx: pointer to the habanalabs context structure.
  *
  * This function perform teardown the following:
- * - Virtual block list of available virtual memory
- * - Virtual address to area descriptor hashtable
- * - MMU for context
+ * - Virtual block list of available virtual memory.
+ * - Virtual address to area descriptor hashtable.
+ * - MMU for context.
  *
  * In addition this function does the following:
  * - Unmaps the existing hashtable nodes if the hashtable is not empty. The
@@ -1869,7 +1854,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	struct hlist_node *tmp_node;
 	int i;
 
-	if (!ctx->hdev->mmu_enable)
+	if (!hdev->mmu_enable)
 		return;
 
 	hl_debugfs_remove_ctx_mem_hash(hdev, ctx);
@@ -1924,19 +1909,18 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	 * all DRAM is available
 	 */
 	if (ctx->asid != HL_KERNEL_ASID_ID &&
-			!ctx->hdev->asic_prop.dram_supports_virtual_memory)
-		atomic64_set(&ctx->hdev->dram_used_mem, 0);
+			!hdev->asic_prop.dram_supports_virtual_memory)
+		atomic64_set(&hdev->dram_used_mem, 0);
 }
 
-/*
- * hl_vm_init           - initialize virtual memory module
- *
- * @hdev                : pointer to the habanalabs device structure
+/**
+ * hl_vm_init() - initialize virtual memory module.
+ * @hdev: pointer to the habanalabs device structure.
  *
  * This function initializes the following:
- * - MMU module
- * - DRAM physical pages pool of 2MB
- * - Idr for device memory allocation handles
+ * - MMU module.
+ * - DRAM physical pages pool of 2MB.
+ * - Idr for device memory allocation handles.
  */
 int hl_vm_init(struct hl_device *hdev)
 {
@@ -1977,15 +1961,14 @@ int hl_vm_init(struct hl_device *hdev)
 	return rc;
 }
 
-/*
- * hl_vm_fini           - virtual memory module teardown
- *
- * @hdev                : pointer to the habanalabs device structure
+/**
+ * hl_vm_fini() - virtual memory module teardown.
+ * @hdev: pointer to the habanalabs device structure.
  *
  * This function perform teardown to the following:
- * - Idr for device memory allocation handles
- * - DRAM physical pages pool of 2MB
- * - MMU module
+ * - Idr for device memory allocation handles.
+ * - DRAM physical pages pool of 2MB.
+ * - MMU module.
  */
 void hl_vm_fini(struct hl_device *hdev)
 {
-- 
2.25.1


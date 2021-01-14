Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34182F68B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbhANSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbhANSBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:01:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14F0B23B5D;
        Thu, 14 Jan 2021 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610647255;
        bh=T1FT59fyyGaYIatRj6MfOo2QJe6qpfqe6RI7v9GRH9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOPT9dieURry3zHlbd5AkBh/XVUmFFRpctFNNQTv1F7CfbpyCgxAcYFEA9T/9GyY/
         eGOc3q6U/KfCDdUWFkmVD6/+HEYKjAayMBoh1m6B7TZEGtHkT95FjyiyXT136qsXL7
         vud+DA6aHdQhXHleclRjKl+FfAIL9upwcOswVljU2qsjS3fC8lFiZo60WN9yoHM+DW
         1SKBLiRGae6xvlpGHjqSPwI4CcbRedMufsjX+756rJ6tFFLURS1651ijZarHxkKZTi
         ZZAmb9fQ82ogldOXezwuBeto0k7QM2XR39iGJcO68ZZTvIN5EAfIinz2KE06GlRQ2J
         HODJci8Ev3ZdQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
Date:   Thu, 14 Jan 2021 17:59:30 +0000
Message-Id: <20210114175934.13070-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114175934.13070-1-will@kernel.org>
References: <20210114175934.13070-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct vm_fault' contains both information about the fault being serviced
alongside mutable fields contributing to the state of the fault-handling
logic. Unfortunately, the distinction between the two is not clear-cut,
and a number of callers end up manipulating the structure temporarily
before restoring it when returning.

Try to clean this up by splitting the immutable fault information out
into a new 'struct vm_fault_info' which is embedded in 'struct vm_fault'
and will later be made 'const'. The vast majority of this change was
performed with a coccinelle patch:

// SPDX-License-Identifier: GPL-2.0

virtual context
virtual patch
virtual org
virtual report

@r_patch depends on !context && patch && !org && !report@
struct vm_fault *vmf;
@@

(
- vmf->vma
+ vmf->info.vma
|
- vmf->gfp_mask
+ vmf->info.gfp_mask
|
- vmf->pgoff
+ vmf->info.pgoff
|
- vmf->address
+ vmf->info.address
)

@r2_patch depends on !context && patch && !org && !report@
struct vm_fault vmf;
@@

(
- vmf.vma
+ vmf.info.vma
|
- vmf.gfp_mask
+ vmf.info.gfp_mask
|
- vmf.pgoff
+ vmf.info.pgoff
|
- vmf.address
+ vmf.info.address
)

but I ended up having to fix up some stragglers by hand.

Ideally, the 'flags' field would be part of the new structure too, but
it seems as though the ->page_mkwrite() path is not ready for this yet.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vdso.c                   |   4 +-
 arch/powerpc/kvm/book3s_64_vio.c           |   6 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c         |   4 +-
 arch/powerpc/kvm/book3s_xive_native.c      |  13 +-
 arch/powerpc/platforms/cell/spufs/file.c   |  16 +-
 arch/s390/kernel/vdso.c                    |   4 +-
 arch/s390/kvm/kvm-s390.c                   |   2 +-
 arch/x86/entry/vdso/vma.c                  |  22 +-
 arch/x86/kernel/cpu/sgx/encl.c             |   4 +-
 drivers/char/agp/alpha-agp.c               |   2 +-
 drivers/char/mspec.c                       |   6 +-
 drivers/dax/device.c                       |  37 ++--
 drivers/dma-buf/heaps/cma_heap.c           |   6 +-
 drivers/dma-buf/udmabuf.c                  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |   4 +-
 drivers/gpu/drm/armada/armada_gem.c        |   6 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c     |   8 +-
 drivers/gpu/drm/drm_vm.c                   |  18 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c      |  10 +-
 drivers/gpu/drm/gma500/framebuffer.c       |   4 +-
 drivers/gpu/drm/gma500/gem.c               |   8 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c   |   8 +-
 drivers/gpu/drm/msm/msm_gem.c              |  11 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c     |   8 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c      |   2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c         |  20 +-
 drivers/gpu/drm/radeon/radeon_ttm.c        |   4 +-
 drivers/gpu/drm/tegra/gem.c                |   6 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  10 +-
 drivers/gpu/drm/vc4/vc4_bo.c               |   2 +-
 drivers/gpu/drm/vgem/vgem_drv.c            |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |  12 +-
 drivers/hsi/clients/cmt_speech.c           |   2 +-
 drivers/hwtracing/intel_th/msu.c           |   8 +-
 drivers/infiniband/core/uverbs_main.c      |  10 +-
 drivers/infiniband/hw/hfi1/file_ops.c      |   2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c   |   2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c  |   6 +-
 drivers/misc/cxl/context.c                 |   9 +-
 drivers/misc/ocxl/context.c                |  10 +-
 drivers/misc/ocxl/sysfs.c                  |   8 +-
 drivers/misc/sgi-gru/grumain.c             |   4 +-
 drivers/scsi/cxlflash/ocxl_hw.c            |   6 +-
 drivers/scsi/cxlflash/superpipe.c          |   2 +-
 drivers/scsi/sg.c                          |   4 +-
 drivers/target/target_core_user.c          |   6 +-
 drivers/uio/uio.c                          |   6 +-
 drivers/usb/mon/mon_bin.c                  |   4 +-
 drivers/vfio/pci/vfio_pci.c                |   2 +-
 drivers/vfio/pci/vfio_pci_nvlink2.c        |   8 +-
 drivers/vhost/vdpa.c                       |   6 +-
 drivers/video/fbdev/core/fb_defio.c        |  14 +-
 drivers/xen/privcmd-buf.c                  |   5 +-
 drivers/xen/privcmd.c                      |   4 +-
 fs/9p/vfs_file.c                           |   2 +-
 fs/afs/write.c                             |   2 +-
 fs/btrfs/inode.c                           |   4 +-
 fs/ceph/addr.c                             |   6 +-
 fs/dax.c                                   |  53 ++---
 fs/ext2/file.c                             |   6 +-
 fs/ext4/file.c                             |   6 +-
 fs/ext4/inode.c                            |   4 +-
 fs/f2fs/file.c                             |   8 +-
 fs/fuse/dax.c                              |   2 +-
 fs/fuse/file.c                             |   4 +-
 fs/gfs2/file.c                             |   8 +-
 fs/iomap/buffered-io.c                     |   2 +-
 fs/kernfs/file.c                           |   4 +-
 fs/nfs/file.c                              |   2 +-
 fs/nilfs2/file.c                           |   2 +-
 fs/ocfs2/mmap.c                            |   8 +-
 fs/orangefs/file.c                         |   2 +-
 fs/orangefs/inode.c                        |   4 +-
 fs/proc/vmcore.c                           |   4 +-
 fs/ubifs/file.c                            |   2 +-
 fs/userfaultfd.c                           |  17 +-
 fs/xfs/xfs_file.c                          |  12 +-
 fs/zonefs/super.c                          |   6 +-
 include/linux/huge_mm.h                    |   6 +-
 include/linux/mm.h                         |   9 +-
 include/trace/events/fs_dax.h              |  28 +--
 ipc/shm.c                                  |   2 +-
 kernel/events/core.c                       |  12 +-
 kernel/relay.c                             |   4 +-
 lib/test_hmm.c                             |   4 +-
 mm/filemap.c                               |  49 +++--
 mm/huge_memory.c                           |  57 ++---
 mm/hugetlb.c                               |   6 +-
 mm/internal.h                              |   4 +-
 mm/khugepaged.c                            |  16 +-
 mm/memory.c                                | 245 +++++++++++----------
 mm/mmap.c                                  |   6 +-
 mm/shmem.c                                 |  12 +-
 mm/swap_state.c                            |  19 +-
 mm/swapfile.c                              |   4 +-
 samples/vfio-mdev/mbochs.c                 |  10 +-
 security/selinux/selinuxfs.c               |   4 +-
 sound/core/pcm_native.c                    |   8 +-
 sound/usb/usx2y/us122l.c                   |   4 +-
 sound/usb/usx2y/usX2Yhwdep.c               |   8 +-
 sound/usb/usx2y/usx2yhwdeppcm.c            |   4 +-
 virt/kvm/kvm_main.c                        |  12 +-
 102 files changed, 574 insertions(+), 534 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index cee5d04ea9ad..5b4d40ac22eb 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -183,7 +183,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	struct page *timens_page = find_timens_vvar_page(vma);
 	unsigned long pfn;
 
-	switch (vmf->pgoff) {
+	switch (vmf->info.pgoff) {
 	case VVAR_DATA_PAGE_OFFSET:
 		if (timens_page)
 			pfn = page_to_pfn(timens_page);
@@ -208,7 +208,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		return VM_FAULT_SIGBUS;
 	}
 
-	return vmf_insert_pfn(vma, vmf->address, pfn);
+	return vmf_insert_pfn(vma, vmf->info.address, pfn);
 }
 
 static int __setup_additional_pages(enum vdso_abi abi,
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 8da93fdfa59e..233f39176a7a 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -218,13 +218,13 @@ static struct page *kvm_spapr_get_tce_page(struct kvmppc_spapr_tce_table *stt,
 
 static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
 {
-	struct kvmppc_spapr_tce_table *stt = vmf->vma->vm_file->private_data;
+	struct kvmppc_spapr_tce_table *stt = vmf->info.vma->vm_file->private_data;
 	struct page *page;
 
-	if (vmf->pgoff >= kvmppc_tce_pages(stt->size))
+	if (vmf->info.pgoff >= kvmppc_tce_pages(stt->size))
 		return VM_FAULT_SIGBUS;
 
-	page = kvm_spapr_get_tce_page(stt, vmf->pgoff);
+	page = kvm_spapr_get_tce_page(stt, vmf->info.pgoff);
 	if (!page)
 		return VM_FAULT_OOM;
 
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 84e5a2dc8be5..bea979ef8117 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -989,8 +989,8 @@ static vm_fault_t kvmppc_uvmem_migrate_to_ram(struct vm_fault *vmf)
 {
 	struct kvmppc_uvmem_page_pvt *pvt = vmf->page->zone_device_data;
 
-	if (kvmppc_svm_page_out(vmf->vma, vmf->address,
-				vmf->address + PAGE_SIZE, PAGE_SHIFT,
+	if (kvmppc_svm_page_out(vmf->info.vma, vmf->info.address,
+				vmf->info.address + PAGE_SIZE, PAGE_SHIFT,
 				pvt->kvm, pvt->gpa))
 		return VM_FAULT_SIGBUS;
 	else
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 76800c84f2a3..1be041cbdfaa 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -222,7 +222,7 @@ static struct kvmppc_xive_ops kvmppc_xive_native_ops =  {
 
 static vm_fault_t xive_native_esb_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct kvm_device *dev = vma->vm_file->private_data;
 	struct kvmppc_xive *xive = dev->private;
 	struct kvmppc_xive_src_block *sb;
@@ -238,7 +238,7 @@ static vm_fault_t xive_native_esb_fault(struct vm_fault *vmf)
 	 * Linux/KVM uses a two pages ESB setting, one for trigger and
 	 * one for EOI
 	 */
-	page_offset = vmf->pgoff - vma->vm_pgoff;
+	page_offset = vmf->info.pgoff - vma->vm_pgoff;
 	irq = page_offset / 2;
 
 	sb = kvmppc_xive_find_source(xive, irq, &src);
@@ -272,7 +272,7 @@ static vm_fault_t xive_native_esb_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 
-	vmf_insert_pfn(vma, vmf->address, page >> PAGE_SHIFT);
+	vmf_insert_pfn(vma, vmf->info.address, page >> PAGE_SHIFT);
 	return VM_FAULT_NOPAGE;
 }
 
@@ -282,14 +282,15 @@ static const struct vm_operations_struct xive_native_esb_vmops = {
 
 static vm_fault_t xive_native_tima_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 
-	switch (vmf->pgoff - vma->vm_pgoff) {
+	switch (vmf->info.pgoff - vma->vm_pgoff) {
 	case 0: /* HW - forbid access */
 	case 1: /* HV - forbid access */
 		return VM_FAULT_SIGBUS;
 	case 2: /* OS */
-		vmf_insert_pfn(vma, vmf->address, xive_tima_os >> PAGE_SHIFT);
+		vmf_insert_pfn(vma, vmf->info.address,
+			       xive_tima_os >> PAGE_SHIFT);
 		return VM_FAULT_NOPAGE;
 	case 3: /* USER - TODO */
 	default:
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 62d90a5e23d1..8c77752e76e3 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -229,17 +229,17 @@ spufs_mem_write(struct file *file, const char __user *buffer,
 static vm_fault_t
 spufs_mem_mmap_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct spu_context *ctx	= vma->vm_file->private_data;
 	unsigned long pfn, offset;
 	vm_fault_t ret;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	if (offset >= LS_SIZE)
 		return VM_FAULT_SIGBUS;
 
 	pr_debug("spufs_mem_mmap_fault address=0x%lx, offset=0x%lx\n",
-			vmf->address, offset);
+			vmf->info.address, offset);
 
 	if (spu_acquire(ctx))
 		return VM_FAULT_NOPAGE;
@@ -251,7 +251,7 @@ spufs_mem_mmap_fault(struct vm_fault *vmf)
 		vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
 		pfn = (ctx->spu->local_store_phys + offset) >> PAGE_SHIFT;
 	}
-	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+	ret = vmf_insert_pfn(vma, vmf->info.address, pfn);
 
 	spu_release(ctx);
 
@@ -311,8 +311,8 @@ static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
 				    unsigned long ps_offs,
 				    unsigned long ps_size)
 {
-	struct spu_context *ctx = vmf->vma->vm_file->private_data;
-	unsigned long area, offset = vmf->pgoff << PAGE_SHIFT;
+	struct spu_context *ctx = vmf->info.vma->vm_file->private_data;
+	unsigned long area, offset = vmf->info.pgoff << PAGE_SHIFT;
 	int err = 0;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 
@@ -350,8 +350,8 @@ static vm_fault_t spufs_ps_fault(struct vm_fault *vmf,
 		mmap_read_lock(current->mm);
 	} else {
 		area = ctx->spu->problem_phys + ps_offs;
-		ret = vmf_insert_pfn(vmf->vma, vmf->address,
-				(area + offset) >> PAGE_SHIFT);
+		ret = vmf_insert_pfn(vmf->info.vma, vmf->info.address,
+				     (area + offset) >> PAGE_SHIFT);
 		spu_context_trace(spufs_ps_fault__insert, ctx, ctx->spu);
 	}
 
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 8bc269c55fd3..f2f08932942f 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -51,10 +51,10 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 	vdso_pagelist = vdso64_pagelist;
 	vdso_pages = vdso64_pages;
 
-	if (vmf->pgoff >= vdso_pages)
+	if (vmf->info.pgoff >= vdso_pages)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = vdso_pagelist[vmf->pgoff];
+	vmf->page = vdso_pagelist[vmf->info.pgoff];
 	get_page(vmf->page);
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index dbafd057ca6a..906d87984b40 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4952,7 +4952,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 {
 #ifdef CONFIG_KVM_S390_UCONTROL
-	if ((vmf->pgoff == KVM_S390_SIE_PAGE_OFFSET)
+	if ((vmf->info.pgoff == KVM_S390_SIE_PAGE_OFFSET)
 		 && (kvm_is_ucontrol(vcpu->kvm))) {
 		vmf->page = virt_to_page(vcpu->arch.sie_block);
 		get_page(vmf->page);
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 825e829ffff1..4c4834360b1f 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -61,10 +61,10 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
 
-	if (!image || (vmf->pgoff << PAGE_SHIFT) >= image->size)
+	if (!image || (vmf->info.pgoff << PAGE_SHIFT) >= image->size)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = virt_to_page(image->data + (vmf->pgoff << PAGE_SHIFT));
+	vmf->page = virt_to_page(image->data + (vmf->info.pgoff << PAGE_SHIFT));
 	get_page(vmf->page);
 	return 0;
 }
@@ -157,7 +157,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	if (!image)
 		return VM_FAULT_SIGBUS;
 
-	sym_offset = (long)(vmf->pgoff << PAGE_SHIFT) +
+	sym_offset = (long)(vmf->info.pgoff << PAGE_SHIFT) +
 		image->sym_vvar_start;
 
 	/*
@@ -192,7 +192,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			 * offsets for clocks on VVAR, it'll be faulted
 			 * shortly by VDSO code.
 			 */
-			addr = vmf->address + (image->sym_timens_page - sym_offset);
+			addr = vmf->info.address + (image->sym_timens_page - sym_offset);
 			err = vmf_insert_pfn(vma, addr, pfn);
 			if (unlikely(err & VM_FAULT_ERROR))
 				return err;
@@ -200,21 +200,21 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			pfn = page_to_pfn(timens_page);
 		}
 
-		return vmf_insert_pfn(vma, vmf->address, pfn);
+		return vmf_insert_pfn(vma, vmf->info.address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
 		struct pvclock_vsyscall_time_info *pvti =
 			pvclock_get_pvti_cpu0_va();
 		if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK)) {
-			return vmf_insert_pfn_prot(vma, vmf->address,
-					__pa(pvti) >> PAGE_SHIFT,
-					pgprot_decrypted(vma->vm_page_prot));
+			return vmf_insert_pfn_prot(vma, vmf->info.address,
+						   __pa(pvti) >> PAGE_SHIFT,
+						   pgprot_decrypted(vma->vm_page_prot));
 		}
 	} else if (sym_offset == image->sym_hvclock_page) {
 		struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
 
 		if (tsc_pg && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
-			return vmf_insert_pfn(vma, vmf->address,
-					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
+			return vmf_insert_pfn(vma, vmf->info.address,
+					      virt_to_phys(tsc_pg) >> PAGE_SHIFT);
 	} else if (sym_offset == image->sym_timens_page) {
 		struct page *timens_page = find_timens_vvar_page(vma);
 
@@ -222,7 +222,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			return VM_FAULT_SIGBUS;
 
 		pfn = __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
-		return vmf_insert_pfn(vma, vmf->address, pfn);
+		return vmf_insert_pfn(vma, vmf->info.address, pfn);
 	}
 
 	return VM_FAULT_SIGBUS;
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index ee50a5010277..26b31f2c0cdd 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -136,8 +136,8 @@ static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 
 static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
 {
-	unsigned long addr = (unsigned long)vmf->address;
-	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = (unsigned long) vmf->info.address;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct sgx_encl_page *entry;
 	unsigned long phys_addr;
 	struct sgx_encl *encl;
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index c9bf2c219841..ff319b859aa7 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -18,7 +18,7 @@ static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
 	unsigned long pa;
 	struct page *page;
 
-	dma_addr = vmf->address - vmf->vma->vm_start + agp->aperture.bus_base;
+	dma_addr = vmf->info.address - vmf->info.vma->vm_start + agp->aperture.bus_base;
 	pa = agp->ops->translate(agp, dma_addr);
 
 	if (pa == (unsigned long)-EINVAL)
diff --git a/drivers/char/mspec.c b/drivers/char/mspec.c
index f8231e2e84be..c769aa7a6aeb 100644
--- a/drivers/char/mspec.c
+++ b/drivers/char/mspec.c
@@ -138,8 +138,8 @@ mspec_fault(struct vm_fault *vmf)
 {
 	unsigned long paddr, maddr;
 	unsigned long pfn;
-	pgoff_t index = vmf->pgoff;
-	struct vma_data *vdata = vmf->vma->vm_private_data;
+	pgoff_t index = vmf->info.pgoff;
+	struct vma_data *vdata = vmf->info.vma->vm_private_data;
 
 	maddr = (volatile unsigned long) vdata->maddr[index];
 	if (maddr == 0) {
@@ -161,7 +161,7 @@ mspec_fault(struct vm_fault *vmf)
 	paddr = maddr & ~__IA64_UNCACHED_OFFSET;
 	pfn = paddr >> PAGE_SHIFT;
 
-	return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+	return vmf_insert_pfn(vmf->info.vma, vmf->info.address, pfn);
 }
 
 static const struct vm_operations_struct mspec_vm_ops = {
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 5da2980bb16b..c6de3f175f34 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -80,7 +80,7 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 	phys_addr_t phys;
 	unsigned int fault_size = PAGE_SIZE;
 
-	if (check_vma(dev_dax, vmf->vma, __func__))
+	if (check_vma(dev_dax, vmf->info.vma, __func__))
 		return VM_FAULT_SIGBUS;
 
 	if (dev_dax->align > PAGE_SIZE) {
@@ -92,27 +92,27 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 	if (fault_size != dev_dax->align)
 		return VM_FAULT_SIGBUS;
 
-	phys = dax_pgoff_to_phys(dev_dax, vmf->pgoff, PAGE_SIZE);
+	phys = dax_pgoff_to_phys(dev_dax, vmf->info.pgoff, PAGE_SIZE);
 	if (phys == -1) {
-		dev_dbg(dev, "pgoff_to_phys(%#lx) failed\n", vmf->pgoff);
+		dev_dbg(dev, "pgoff_to_phys(%#lx) failed\n", vmf->info.pgoff);
 		return VM_FAULT_SIGBUS;
 	}
 
 	*pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
-	return vmf_insert_mixed(vmf->vma, vmf->address, *pfn);
+	return vmf_insert_mixed(vmf->info.vma, vmf->info.address, *pfn);
 }
 
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 				struct vm_fault *vmf, pfn_t *pfn)
 {
-	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	unsigned long pmd_addr = vmf->info.address & PMD_MASK;
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
 	unsigned int fault_size = PMD_SIZE;
 
-	if (check_vma(dev_dax, vmf->vma, __func__))
+	if (check_vma(dev_dax, vmf->info.vma, __func__))
 		return VM_FAULT_SIGBUS;
 
 	if (dev_dax->align > PMD_SIZE) {
@@ -127,11 +127,11 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
-	if (pmd_addr < vmf->vma->vm_start ||
-			(pmd_addr + PMD_SIZE) > vmf->vma->vm_end)
+	if (pmd_addr < vmf->info.vma->vm_start ||
+			(pmd_addr + PMD_SIZE) > vmf->info.vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	pgoff = linear_page_index(vmf->vma, pmd_addr);
+	pgoff = linear_page_index(vmf->info.vma, pmd_addr);
 	phys = dax_pgoff_to_phys(dev_dax, pgoff, PMD_SIZE);
 	if (phys == -1) {
 		dev_dbg(dev, "pgoff_to_phys(%#lx) failed\n", pgoff);
@@ -147,14 +147,14 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 				struct vm_fault *vmf, pfn_t *pfn)
 {
-	unsigned long pud_addr = vmf->address & PUD_MASK;
+	unsigned long pud_addr = vmf->info.address & PUD_MASK;
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
 	pgoff_t pgoff;
 	unsigned int fault_size = PUD_SIZE;
 
 
-	if (check_vma(dev_dax, vmf->vma, __func__))
+	if (check_vma(dev_dax, vmf->info.vma, __func__))
 		return VM_FAULT_SIGBUS;
 
 	if (dev_dax->align > PUD_SIZE) {
@@ -169,11 +169,11 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 		return VM_FAULT_FALLBACK;
 
 	/* if we are outside of the VMA */
-	if (pud_addr < vmf->vma->vm_start ||
-			(pud_addr + PUD_SIZE) > vmf->vma->vm_end)
+	if (pud_addr < vmf->info.vma->vm_start ||
+			(pud_addr + PUD_SIZE) > vmf->info.vma->vm_end)
 		return VM_FAULT_SIGBUS;
 
-	pgoff = linear_page_index(vmf->vma, pud_addr);
+	pgoff = linear_page_index(vmf->info.vma, pud_addr);
 	phys = dax_pgoff_to_phys(dev_dax, pgoff, PUD_SIZE);
 	if (phys == -1) {
 		dev_dbg(dev, "pgoff_to_phys(%#lx) failed\n", pgoff);
@@ -195,7 +195,7 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size)
 {
-	struct file *filp = vmf->vma->vm_file;
+	struct file *filp = vmf->info.vma->vm_file;
 	unsigned long fault_size;
 	vm_fault_t rc = VM_FAULT_SIGBUS;
 	int id;
@@ -204,7 +204,8 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 
 	dev_dbg(&dev_dax->dev, "%s: %s (%#lx - %#lx) size = %d\n", current->comm,
 			(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
-			vmf->vma->vm_start, vmf->vma->vm_end, pe_size);
+			vmf->info.vma->vm_start, vmf->info.vma->vm_end,
+			pe_size);
 
 	id = dax_read_lock();
 	switch (pe_size) {
@@ -234,8 +235,8 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 		 * mapped. No need to consider the zero page, or racing
 		 * conflicting mappings.
 		 */
-		pgoff = linear_page_index(vmf->vma, vmf->address
-				& ~(fault_size - 1));
+		pgoff = linear_page_index(vmf->info.vma, vmf->info.address
+					  & ~(fault_size - 1));
 		for (i = 0; i < fault_size / PAGE_SIZE; i++) {
 			struct page *page;
 
diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index 3c4e34301172..196df251a5e5 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -160,13 +160,13 @@ static int cma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 
 static vm_fault_t cma_heap_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct cma_heap_buffer *buffer = vma->vm_private_data;
 
-	if (vmf->pgoff > buffer->pagecount)
+	if (vmf->info.pgoff > buffer->pagecount)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = buffer->pages[vmf->pgoff];
+	vmf->page = buffer->pages[vmf->info.pgoff];
 	get_page(vmf->page);
 
 	return 0;
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index db732f71e59a..122780d4e268 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -24,10 +24,10 @@ struct udmabuf {
 
 static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct udmabuf *ubuf = vma->vm_private_data;
 
-	vmf->page = ubuf->pages[vmf->pgoff];
+	vmf->page = ubuf->pages[vmf->info.pgoff];
 	get_page(vmf->page);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4d8f19ab1014..feea4da13bc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1983,7 +1983,7 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 
 static vm_fault_t amdgpu_ttm_fault(struct vm_fault *vmf)
 {
-	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
+	struct ttm_buffer_object *bo = vmf->info.vma->vm_private_data;
 	vm_fault_t ret;
 
 	ret = ttm_bo_vm_reserve(bo, vmf);
@@ -1994,7 +1994,7 @@ static vm_fault_t amdgpu_ttm_fault(struct vm_fault *vmf)
 	if (ret)
 		goto unlock;
 
-	ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
+	ret = ttm_bo_vm_fault_reserved(vmf, vmf->info.vma->vm_page_prot,
 				       TTM_BO_VM_NUM_PREFAULT, 1);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 21909642ee4c..6e3378b44b03 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -17,12 +17,12 @@
 
 static vm_fault_t armada_gem_vm_fault(struct vm_fault *vmf)
 {
-	struct drm_gem_object *gobj = vmf->vma->vm_private_data;
+	struct drm_gem_object *gobj = vmf->info.vma->vm_private_data;
 	struct armada_gem_object *obj = drm_to_armada_gem(gobj);
 	unsigned long pfn = obj->phys_addr >> PAGE_SHIFT;
 
-	pfn += (vmf->address - vmf->vma->vm_start) >> PAGE_SHIFT;
-	return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
+	pfn += (vmf->info.address - vmf->info.vma->vm_start) >> PAGE_SHIFT;
+	return vmf_insert_pfn(vmf->info.vma, vmf->info.address, pfn);
 }
 
 static const struct vm_operations_struct armada_gem_vm_ops = {
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 9825c378dfa6..68028a902a22 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -521,18 +521,18 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 
 static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
 	loff_t num_pages = obj->size >> PAGE_SHIFT;
 	struct page *page;
 
-	if (vmf->pgoff >= num_pages || WARN_ON_ONCE(!shmem->pages))
+	if (vmf->info.pgoff >= num_pages || WARN_ON_ONCE(!shmem->pages))
 		return VM_FAULT_SIGBUS;
 
-	page = shmem->pages[vmf->pgoff];
+	page = shmem->pages[vmf->info.pgoff];
 
-	return vmf_insert_page(vma, vmf->address, page);
+	return vmf_insert_page(vma, vmf->info.address, page);
 }
 
 static void drm_gem_shmem_vm_open(struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 6d5a03b32238..8893adc53a12 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -111,7 +111,7 @@ static pgprot_t drm_dma_prot(uint32_t map_type, struct vm_area_struct *vma)
 #if IS_ENABLED(CONFIG_AGP)
 static vm_fault_t drm_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_file *priv = vma->vm_file->private_data;
 	struct drm_device *dev = priv->minor->dev;
 	struct drm_local_map *map = NULL;
@@ -138,7 +138,7 @@ static vm_fault_t drm_vm_fault(struct vm_fault *vmf)
 		 * Using vm_pgoff as a selector forces us to use this unusual
 		 * addressing scheme.
 		 */
-		resource_size_t offset = vmf->address - vma->vm_start;
+		resource_size_t offset = vmf->info.address - vma->vm_start;
 		resource_size_t baddr = map->offset + offset;
 		struct drm_agp_mem *agpmem;
 		struct page *page;
@@ -200,7 +200,7 @@ static vm_fault_t drm_vm_fault(struct vm_fault *vmf)
  */
 static vm_fault_t drm_vm_shm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_local_map *map = vma->vm_private_data;
 	unsigned long offset;
 	unsigned long i;
@@ -209,7 +209,7 @@ static vm_fault_t drm_vm_shm_fault(struct vm_fault *vmf)
 	if (!map)
 		return VM_FAULT_SIGBUS;	/* Nothing allocated */
 
-	offset = vmf->address - vma->vm_start;
+	offset = vmf->info.address - vma->vm_start;
 	i = (unsigned long)map->handle + offset;
 	page = vmalloc_to_page((void *)i);
 	if (!page)
@@ -300,7 +300,7 @@ static void drm_vm_shm_close(struct vm_area_struct *vma)
  */
 static vm_fault_t drm_vm_dma_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_file *priv = vma->vm_file->private_data;
 	struct drm_device *dev = priv->minor->dev;
 	struct drm_device_dma *dma = dev->dma;
@@ -313,9 +313,9 @@ static vm_fault_t drm_vm_dma_fault(struct vm_fault *vmf)
 	if (!dma->pagelist)
 		return VM_FAULT_SIGBUS;	/* Nothing allocated */
 
-	offset = vmf->address - vma->vm_start;
+	offset = vmf->info.address - vma->vm_start;
 					/* vm_[pg]off[set] should be 0 */
-	page_nr = offset >> PAGE_SHIFT; /* page_nr could just be vmf->pgoff */
+	page_nr = offset >> PAGE_SHIFT; /* page_nr could just be vmf->info.pgoff */
 	page = virt_to_page((void *)dma->pagelist[page_nr]);
 
 	get_page(page);
@@ -335,7 +335,7 @@ static vm_fault_t drm_vm_dma_fault(struct vm_fault *vmf)
  */
 static vm_fault_t drm_vm_sg_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_local_map *map = vma->vm_private_data;
 	struct drm_file *priv = vma->vm_file->private_data;
 	struct drm_device *dev = priv->minor->dev;
@@ -350,7 +350,7 @@ static vm_fault_t drm_vm_sg_fault(struct vm_fault *vmf)
 	if (!entry->pagelist)
 		return VM_FAULT_SIGBUS;	/* Nothing allocated */
 
-	offset = vmf->address - vma->vm_start;
+	offset = vmf->info.address - vma->vm_start;
 	map_offset = map->offset - (unsigned long)dev->sg->virtual;
 	page_offset = (offset >> PAGE_SHIFT) + (map_offset >> PAGE_SHIFT);
 	page = entry->pagelist[page_offset];
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 6d38c5c17f23..718fbafbf0cd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -171,7 +171,7 @@ int etnaviv_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 
 static vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
 	struct page **pages, *page;
@@ -195,15 +195,15 @@ static vm_fault_t etnaviv_gem_fault(struct vm_fault *vmf)
 		return vmf_error(err);
 	}
 
-	/* We don't use vmf->pgoff since that has the fake offset: */
-	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	/* We don't use vmf->info.pgoff since that has the fake offset: */
+	pgoff = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 
 	page = pages[pgoff];
 
-	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
+	VERB("Inserting %p pfn %lx, pa %lx", (void *) vmf->info.address,
 	     page_to_pfn(page), page_to_pfn(page) << PAGE_SHIFT);
 
-	return vmf_insert_page(vma, vmf->address, page);
+	return vmf_insert_page(vma, vmf->info.address, page);
 }
 
 int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset)
diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index fc4fda1d258b..251eb7d08fea 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -78,7 +78,7 @@ static int psbfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 static vm_fault_t psbfb_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_framebuffer *fb = vma->vm_private_data;
 	struct drm_device *dev = fb->dev;
 	struct drm_psb_private *dev_priv = dev->dev_private;
@@ -92,7 +92,7 @@ static vm_fault_t psbfb_vm_fault(struct vm_fault *vmf)
 				  gtt->offset;
 
 	page_num = vma_pages(vma);
-	address = vmf->address - (vmf->pgoff << PAGE_SHIFT);
+	address = vmf->info.address - (vmf->info.pgoff << PAGE_SHIFT);
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index db827e591403..b5035b48d136 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -133,7 +133,7 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
  */
 static vm_fault_t psb_gem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_gem_object *obj;
 	struct gtt_range *r;
 	int err;
@@ -166,15 +166,15 @@ static vm_fault_t psb_gem_fault(struct vm_fault *vmf)
 	}
 
 	/* Page relative to the VMA start - we must calculate this ourselves
-	   because vmf->pgoff is the fake GEM offset */
-	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	   because vmf->info.pgoff is the fake GEM offset */
+	page_offset = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 
 	/* CPU view of the page, don't go via the GART for CPU writes */
 	if (r->stolen)
 		pfn = (dev_priv->stolen_base + r->offset) >> PAGE_SHIFT;
 	else
 		pfn = page_to_pfn(r->pages[page_offset]);
-	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+	ret = vmf_insert_pfn(vma, vmf->info.address, pfn);
 fail:
 	mutex_unlock(&dev_priv->mmap_mutex);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index ec28a6cde49b..d7080c220c12 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -235,7 +235,7 @@ static vm_fault_t i915_error_to_vmf_fault(int err)
 
 static vm_fault_t vm_fault_cpu(struct vm_fault *vmf)
 {
-	struct vm_area_struct *area = vmf->vma;
+	struct vm_area_struct *area = vmf->info.vma;
 	struct i915_mmap_offset *mmo = area->vm_private_data;
 	struct drm_i915_gem_object *obj = mmo->obj;
 	resource_size_t iomap;
@@ -275,7 +275,7 @@ static vm_fault_t vm_fault_cpu(struct vm_fault *vmf)
 static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 {
 #define MIN_CHUNK_PAGES (SZ_1M >> PAGE_SHIFT)
-	struct vm_area_struct *area = vmf->vma;
+	struct vm_area_struct *area = vmf->info.vma;
 	struct i915_mmap_offset *mmo = area->vm_private_data;
 	struct drm_i915_gem_object *obj = mmo->obj;
 	struct drm_device *dev = obj->base.dev;
@@ -290,8 +290,8 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 	int srcu;
 	int ret;
 
-	/* We don't use vmf->pgoff since that has the fake offset */
-	page_offset = (vmf->address - area->vm_start) >> PAGE_SHIFT;
+	/* We don't use vmf->info.pgoff since that has the fake offset */
+	page_offset = (vmf->info.address - area->vm_start) >> PAGE_SHIFT;
 
 	trace_i915_gem_object_fault(obj, page_offset, true, write);
 
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 9d10739c4eb2..d3ed8961fb3b 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -237,7 +237,7 @@ int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
 
 static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct page **pages;
@@ -268,15 +268,16 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 		goto out_unlock;
 	}
 
-	/* We don't use vmf->pgoff since that has the fake offset: */
-	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	/* We don't use vmf->info.pgoff since that has the fake offset: */
+	pgoff = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 
 	pfn = page_to_pfn(pages[pgoff]);
 
-	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
+	VERB("Inserting %p pfn %lx, pa %lx", (void *) vmf->info.address,
 			pfn, pfn << PAGE_SHIFT);
 
-	ret = vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
+	ret = vmf_insert_mixed(vma, vmf->info.address,
+			       __pfn_to_pfn_t(pfn, PFN_DEV));
 out_unlock:
 	msm_gem_unlock(obj);
 out:
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 92987daa5e17..0f411724f9aa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -149,7 +149,7 @@ static vm_fault_t nouveau_dmem_fault_copy_one(struct nouveau_drm *drm,
 	if (!spage || !(args->src[0] & MIGRATE_PFN_MIGRATE))
 		return 0;
 
-	dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
+	dpage = alloc_page_vma(GFP_HIGHUSER, vmf->info.vma, vmf->info.address);
 	if (!dpage)
 		return VM_FAULT_SIGBUS;
 	lock_page(dpage);
@@ -186,9 +186,9 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 	dma_addr_t dma_addr = 0;
 	vm_fault_t ret;
 	struct migrate_vma args = {
-		.vma		= vmf->vma,
-		.start		= vmf->address,
-		.end		= vmf->address + PAGE_SIZE,
+		.vma		= vmf->info.vma,
+		.start		= vmf->info.address,
+		.end		= vmf->info.address + PAGE_SIZE,
 		.src		= &src,
 		.dst		= &dst,
 		.pgmap_owner	= drm->dev,
diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index a37bc3d7b38b..aedd62dfb983 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -129,7 +129,7 @@ const struct ttm_resource_manager_func nv04_gart_manager = {
 
 static vm_fault_t nouveau_ttm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
 	pgprot_t prot;
 	vm_fault_t ret;
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 30d299ca8795..41505b0649e3 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -350,8 +350,8 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 	unsigned long pfn;
 	pgoff_t pgoff;
 
-	/* We don't use vmf->pgoff since that has the fake offset: */
-	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	/* We don't use vmf->info.pgoff since that has the fake offset: */
+	pgoff = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 
 	if (omap_obj->pages) {
 		omap_gem_cpu_sync_page(obj, pgoff);
@@ -361,11 +361,11 @@ static vm_fault_t omap_gem_fault_1d(struct drm_gem_object *obj,
 		pfn = (omap_obj->dma_addr >> PAGE_SHIFT) + pgoff;
 	}
 
-	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
+	VERB("Inserting %p pfn %lx, pa %lx", (void *) vmf->info.address,
 			pfn, pfn << PAGE_SHIFT);
 
-	return vmf_insert_mixed(vma, vmf->address,
-			__pfn_to_pfn_t(pfn, PFN_DEV));
+	return vmf_insert_mixed(vma, vmf->info.address,
+				__pfn_to_pfn_t(pfn, PFN_DEV));
 }
 
 /* Special handling for the case of faulting in 2d tiled buffers */
@@ -399,8 +399,8 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 	 */
 	const int m = DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
 
-	/* We don't use vmf->pgoff since that has the fake offset: */
-	pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	/* We don't use vmf->info.pgoff since that has the fake offset: */
+	pgoff = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 
 	/*
 	 * Actual address we start mapping at is rounded down to previous slot
@@ -411,7 +411,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 	/* figure out buffer width in slots */
 	slots = omap_obj->width >> priv->usergart[fmt].slot_shift;
 
-	vaddr = vmf->address - ((pgoff - base_pgoff) << PAGE_SHIFT);
+	vaddr = vmf->info.address - ((pgoff - base_pgoff) << PAGE_SHIFT);
 
 	entry = &priv->usergart[fmt].entry[priv->usergart[fmt].last];
 
@@ -456,7 +456,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
 
 	pfn = entry->dma_addr >> PAGE_SHIFT;
 
-	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
+	VERB("Inserting %p pfn %lx, pa %lx", (void *) vmf->info.address,
 			pfn, pfn << PAGE_SHIFT);
 
 	for (i = n; i > 0; i--) {
@@ -489,7 +489,7 @@ static vm_fault_t omap_gem_fault_2d(struct drm_gem_object *obj,
  */
 static vm_fault_t omap_gem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct omap_gem_object *omap_obj = to_omap_bo(obj);
 	int err;
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 23195d5d4e91..db435b10a323 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -811,7 +811,7 @@ void radeon_ttm_set_active_vram_size(struct radeon_device *rdev, u64 size)
 
 static vm_fault_t radeon_ttm_fault(struct vm_fault *vmf)
 {
-	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
+	struct ttm_buffer_object *bo = vmf->info.vma->vm_private_data;
 	struct radeon_device *rdev = radeon_get_rdev(bo->bdev);
 	vm_fault_t ret;
 
@@ -825,7 +825,7 @@ static vm_fault_t radeon_ttm_fault(struct vm_fault *vmf)
 	if (ret)
 		goto unlock_resv;
 
-	ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
+	ret = ttm_bo_vm_fault_reserved(vmf, vmf->info.vma->vm_page_prot,
 				       TTM_BO_VM_NUM_PREFAULT, 1);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		goto unlock_mclk;
diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 26af8daa9a16..0ffc8964ff36 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -486,7 +486,7 @@ int tegra_bo_dumb_create(struct drm_file *file, struct drm_device *drm,
 
 static vm_fault_t tegra_bo_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_gem_object *gem = vma->vm_private_data;
 	struct tegra_bo *bo = to_tegra_bo(gem);
 	struct page *page;
@@ -495,10 +495,10 @@ static vm_fault_t tegra_bo_fault(struct vm_fault *vmf)
 	if (!bo->pages)
 		return VM_FAULT_SIGBUS;
 
-	offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	offset = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 	page = bo->pages[offset];
 
-	return vmf_insert_page(vma, vmf->address, page);
+	return vmf_insert_page(vma, vmf->info.address, page);
 }
 
 const struct vm_operations_struct tegra_bo_vm_ops = {
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 2944fa0af493..b727532c9352 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -68,7 +68,7 @@ static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
 			goto out_unlock;
 
 		ttm_bo_get(bo);
-		mmap_read_unlock(vmf->vma->vm_mm);
+		mmap_read_unlock(vmf->info.vma->vm_mm);
 		(void) dma_fence_wait(bo->moving, true);
 		dma_resv_unlock(bo->base.resv);
 		ttm_bo_put(bo);
@@ -143,7 +143,7 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
 		if (fault_flag_allow_retry_first(vmf->flags)) {
 			if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT)) {
 				ttm_bo_get(bo);
-				mmap_read_unlock(vmf->vma->vm_mm);
+				mmap_read_unlock(vmf->info.vma->vm_mm);
 				if (!dma_resv_lock_interruptible(bo->base.resv,
 								 NULL))
 					dma_resv_unlock(bo->base.resv);
@@ -277,7 +277,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgoff_t num_prefault,
 				    pgoff_t fault_page_size)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
 	struct ttm_bo_device *bdev = bo->bdev;
 	unsigned long page_offset;
@@ -288,7 +288,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 	int err;
 	pgoff_t i;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
-	unsigned long address = vmf->address;
+	unsigned long address = vmf->info.address;
 
 	/*
 	 * Wait for buffer data in transit, due to a pipelined
@@ -383,7 +383,7 @@ EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
 
 vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	pgprot_t prot;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
 	vm_fault_t ret;
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 469d1b4f2643..de6401eb1c1b 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -704,7 +704,7 @@ struct dma_buf * vc4_prime_export(struct drm_gem_object *obj, int flags)
 
 static vm_fault_t vc4_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_gem_object *obj = vma->vm_private_data;
 	struct vc4_bo *bo = to_vc4_bo(obj);
 
diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index f8635ccaf9a1..a5413bcac1ad 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -73,10 +73,10 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
 
 static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct drm_vgem_gem_object *obj = vma->vm_private_data;
-	/* We don't use vmf->pgoff since that has the fake offset */
-	unsigned long vaddr = vmf->address;
+	/* We don't use vmf->info.pgoff since that has the fake offset */
+	unsigned long vaddr = vmf->info.address;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	loff_t num_pages;
 	pgoff_t page_offset;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 0b76b3d17d4c..42dd1df14121 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -392,7 +392,7 @@ void vmw_bo_dirty_clear_res(struct vmw_resource *res)
 
 vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
 	    vma->vm_private_data;
 	vm_fault_t ret;
@@ -412,7 +412,7 @@ vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 	if (ret)
 		return ret;
 
-	page_offset = vmf->pgoff - drm_vma_node_start(&bo->base.vma_node);
+	page_offset = vmf->info.pgoff - drm_vma_node_start(&bo->base.vma_node);
 	if (unlikely(page_offset >= bo->num_pages)) {
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
@@ -434,7 +434,7 @@ vm_fault_t vmw_bo_vm_mkwrite(struct vm_fault *vmf)
 
 vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
 	    vma->vm_private_data;
 	struct vmw_buffer_object *vbo =
@@ -454,7 +454,7 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 		pgoff_t allowed_prefault;
 		unsigned long page_offset;
 
-		page_offset = vmf->pgoff -
+		page_offset = vmf->info.pgoff -
 			drm_vma_node_start(&bo->base.vma_node);
 		if (page_offset >= bo->num_pages ||
 		    vmw_resources_clean(vbo, page_offset,
@@ -491,7 +491,7 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
 				enum page_entry_size pe_size)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
 	    vma->vm_private_data;
 	struct vmw_buffer_object *vbo =
@@ -529,7 +529,7 @@ vm_fault_t vmw_bo_vm_huge_fault(struct vm_fault *vmf,
 		pgoff_t allowed_prefault;
 		unsigned long page_offset;
 
-		page_offset = vmf->pgoff -
+		page_offset = vmf->info.pgoff -
 			drm_vma_node_start(&bo->base.vma_node);
 		if (page_offset >= bo->num_pages ||
 		    vmw_resources_clean(vbo, page_offset,
diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
index 89869c66fb9d..09674972dfb7 100644
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -1086,7 +1086,7 @@ static void cs_hsi_stop(struct cs_hsi_iface *hi)
 
 static vm_fault_t cs_char_vma_fault(struct vm_fault *vmf)
 {
-	struct cs_char *csdata = vmf->vma->vm_private_data;
+	struct cs_char *csdata = vmf->info.vma->vm_private_data;
 	struct page *page;
 
 	page = virt_to_page(csdata->mmap_base);
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 7d95242db900..20ffb8f59503 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1583,16 +1583,16 @@ static void msc_mmap_close(struct vm_area_struct *vma)
 
 static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 {
-	struct msc_iter *iter = vmf->vma->vm_file->private_data;
+	struct msc_iter *iter = vmf->info.vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
 
-	vmf->page = msc_buffer_get_page(msc, vmf->pgoff);
+	vmf->page = msc_buffer_get_page(msc, vmf->info.pgoff);
 	if (!vmf->page)
 		return VM_FAULT_SIGBUS;
 
 	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index = vmf->pgoff;
+	vmf->page->mapping = vmf->info.vma->vm_file->f_mapping;
+	vmf->page->index = vmf->info.pgoff;
 
 	return 0;
 }
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index f173ecd102dc..fc06e5666f83 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -768,16 +768,16 @@ static void rdma_umap_close(struct vm_area_struct *vma)
  */
 static vm_fault_t rdma_umap_fault(struct vm_fault *vmf)
 {
-	struct ib_uverbs_file *ufile = vmf->vma->vm_file->private_data;
-	struct rdma_umap_priv *priv = vmf->vma->vm_private_data;
+	struct ib_uverbs_file *ufile = vmf->info.vma->vm_file->private_data;
+	struct rdma_umap_priv *priv = vmf->info.vma->vm_private_data;
 	vm_fault_t ret = 0;
 
 	if (!priv)
 		return VM_FAULT_SIGBUS;
 
 	/* Read only pages can just use the system zero page. */
-	if (!(vmf->vma->vm_flags & (VM_WRITE | VM_MAYWRITE))) {
-		vmf->page = ZERO_PAGE(vmf->address);
+	if (!(vmf->info.vma->vm_flags & (VM_WRITE | VM_MAYWRITE))) {
+		vmf->page = ZERO_PAGE(vmf->info.address);
 		get_page(vmf->page);
 		return 0;
 	}
@@ -785,7 +785,7 @@ static vm_fault_t rdma_umap_fault(struct vm_fault *vmf)
 	mutex_lock(&ufile->umap_lock);
 	if (!ufile->disassociate_page)
 		ufile->disassociate_page =
-			alloc_pages(vmf->gfp_mask | __GFP_ZERO, 0);
+			alloc_pages(vmf->info.gfp_mask | __GFP_ZERO, 0);
 
 	if (ufile->disassociate_page) {
 		/*
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index 329ee4f48d95..3174652fe4e7 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -604,7 +604,7 @@ static vm_fault_t vma_fault(struct vm_fault *vmf)
 {
 	struct page *page;
 
-	page = vmalloc_to_page((void *)(vmf->pgoff << PAGE_SHIFT));
+	page = vmalloc_to_page((void *)(vmf->info.pgoff << PAGE_SHIFT));
 	if (!page)
 		return VM_FAULT_SIGBUS;
 
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index ff87a67dd7b7..0bd881234f8a 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -876,7 +876,7 @@ static vm_fault_t qib_file_vma_fault(struct vm_fault *vmf)
 {
 	struct page *page;
 
-	page = vmalloc_to_page((void *)(vmf->pgoff << PAGE_SHIFT));
+	page = vmalloc_to_page((void *)(vmf->info.pgoff << PAGE_SHIFT));
 	if (!page)
 		return VM_FAULT_SIGBUS;
 
diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
index 8dd0562de287..4b85fd671944 100644
--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -434,16 +434,16 @@ static void videobuf_vm_close(struct vm_area_struct *vma)
  */
 static vm_fault_t videobuf_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page;
 
 	dprintk(3, "fault: fault @ %08lx [vma %08lx-%08lx]\n",
-		vmf->address, vma->vm_start, vma->vm_end);
+		vmf->info.address, vma->vm_start, vma->vm_end);
 
 	page = alloc_page(GFP_USER | __GFP_DMA32);
 	if (!page)
 		return VM_FAULT_OOM;
-	clear_user_highpage(page, vmf->address);
+	clear_user_highpage(page, vmf->info.address);
 	vmf->page = page;
 
 	return 0;
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index fb2eff69e449..6b2d8a06d2c5 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -125,15 +125,15 @@ void cxl_context_set_mapping(struct cxl_context *ctx,
 
 static vm_fault_t cxl_mmap_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct cxl_context *ctx = vma->vm_file->private_data;
 	u64 area, offset;
 	vm_fault_t ret;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 
 	pr_devel("%s: pe: %i address: 0x%lx offset: 0x%llx\n",
-			__func__, ctx->pe, vmf->address, offset);
+			__func__, ctx->pe, vmf->info.address, offset);
 
 	if (ctx->afu->current_mode == CXL_MODE_DEDICATED) {
 		area = ctx->afu->psn_phys;
@@ -165,7 +165,8 @@ static vm_fault_t cxl_mmap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 
-	ret = vmf_insert_pfn(vma, vmf->address, (area + offset) >> PAGE_SHIFT);
+	ret = vmf_insert_pfn(vma, vmf->info.address,
+			     (area + offset) >> PAGE_SHIFT);
 
 	mutex_unlock(&ctx->status_mutex);
 
diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 9eb0d93b01c6..fafa0795253f 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -138,19 +138,19 @@ static vm_fault_t map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
 
 static vm_fault_t ocxl_mmap_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ocxl_context *ctx = vma->vm_file->private_data;
 	u64 offset;
 	vm_fault_t ret;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
-		ctx->pasid, vmf->address, offset);
+		ctx->pasid, vmf->info.address, offset);
 
 	if (offset < ctx->afu->irq_base_offset)
-		ret = map_pp_mmio(vma, vmf->address, offset, ctx);
+		ret = map_pp_mmio(vma, vmf->info.address, offset, ctx);
 	else
-		ret = map_afu_irq(vma, vmf->address, offset, ctx);
+		ret = map_afu_irq(vma, vmf->info.address, offset, ctx);
 	return ret;
 }
 
diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
index 25c78df8055d..791d346b4109 100644
--- a/drivers/misc/ocxl/sysfs.c
+++ b/drivers/misc/ocxl/sysfs.c
@@ -108,16 +108,16 @@ static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
 
 static vm_fault_t global_mmio_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ocxl_afu *afu = vma->vm_private_data;
 	unsigned long offset;
 
-	if (vmf->pgoff >= (afu->config.global_mmio_size >> PAGE_SHIFT))
+	if (vmf->info.pgoff >= (afu->config.global_mmio_size >> PAGE_SHIFT))
 		return VM_FAULT_SIGBUS;
 
-	offset = vmf->pgoff;
+	offset = vmf->info.pgoff;
 	offset += (afu->global_mmio_start >> PAGE_SHIFT);
-	return vmf_insert_pfn(vma, vmf->address, offset);
+	return vmf_insert_pfn(vma, vmf->info.address, offset);
 }
 
 static const struct vm_operations_struct global_mmio_vmops = {
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 40ac59dd018c..05c2a437d5e4 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -915,12 +915,12 @@ struct gru_state *gru_assign_gru_context(struct gru_thread_state *gts)
  */
 vm_fault_t gru_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct gru_thread_state *gts;
 	unsigned long paddr, vaddr;
 	unsigned long expires;
 
-	vaddr = vmf->address;
+	vaddr = vmf->info.address;
 	gru_dbg(grudev, "vma %p, vaddr 0x%lx (0x%lx)\n",
 		vma, vaddr, GSEG_BASE(vaddr));
 	STAT(nopfn);
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 244fc27215dc..c19f5e05913b 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -1123,12 +1123,12 @@ static int afu_release(struct inode *inode, struct file *file)
  */
 static vm_fault_t ocxlflash_mmap_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct ocxlflash_context *ctx = vma->vm_file->private_data;
 	struct device *dev = ctx->hw_afu->dev;
 	u64 mmio_area, offset;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	if (offset >= ctx->psn_size)
 		return VM_FAULT_SIGBUS;
 
@@ -1144,7 +1144,7 @@ static vm_fault_t ocxlflash_mmap_fault(struct vm_fault *vmf)
 	mmio_area = ctx->psn_phys;
 	mmio_area += offset;
 
-	return vmf_insert_pfn(vma, vmf->address, mmio_area >> PAGE_SHIFT);
+	return vmf_insert_pfn(vma, vmf->info.address, mmio_area >> PAGE_SHIFT);
 }
 
 static const struct vm_operations_struct ocxlflash_vmops = {
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 5dddf67dfa24..e091a580d774 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -1101,7 +1101,7 @@ static struct page *get_err_page(struct cxlflash_cfg *cfg)
  */
 static vm_fault_t cxlflash_mmap_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct file *file = vma->vm_file;
 	struct cxlflash_cfg *cfg = container_of(file->f_op, struct cxlflash_cfg,
 						cxl_fops);
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index bfa8d77322d7..fadbd629baa5 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1241,7 +1241,7 @@ sg_fasync(int fd, struct file *filp, int mode)
 static vm_fault_t
 sg_vma_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	Sg_fd *sfp;
 	unsigned long offset, len, sa;
 	Sg_scatter_hold *rsv_schp;
@@ -1250,7 +1250,7 @@ sg_vma_fault(struct vm_fault *vmf)
 	if ((NULL == vma) || (!(sfp = (Sg_fd *) vma->vm_private_data)))
 		return VM_FAULT_SIGBUS;
 	rsv_schp = &sfp->reserve;
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	if (offset >= rsv_schp->bufflen)
 		return VM_FAULT_SIGBUS;
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sfp->parentdp,
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 6b171fff007b..84392e4fafe4 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1676,13 +1676,13 @@ static struct page *tcmu_try_get_block_page(struct tcmu_dev *udev, uint32_t dbi)
 
 static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 {
-	struct tcmu_dev *udev = vmf->vma->vm_private_data;
+	struct tcmu_dev *udev = vmf->info.vma->vm_private_data;
 	struct uio_info *info = &udev->uio_info;
 	struct page *page;
 	unsigned long offset;
 	void *addr;
 
-	int mi = tcmu_find_mem_index(vmf->vma);
+	int mi = tcmu_find_mem_index(vmf->info.vma);
 	if (mi < 0)
 		return VM_FAULT_SIGBUS;
 
@@ -1690,7 +1690,7 @@ static vm_fault_t tcmu_vma_fault(struct vm_fault *vmf)
 	 * We need to subtract mi because userspace uses offset = N*PAGE_SIZE
 	 * to use mem[N].
 	 */
-	offset = (vmf->pgoff - mi) << PAGE_SHIFT;
+	offset = (vmf->info.pgoff - mi) << PAGE_SHIFT;
 
 	if (offset < udev->data_off) {
 		/* For the vmalloc()ed cmd area pages */
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index ea96e319c8a0..1abc785184d0 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -666,7 +666,7 @@ static int uio_find_mem_index(struct vm_area_struct *vma)
 
 static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
 {
-	struct uio_device *idev = vmf->vma->vm_private_data;
+	struct uio_device *idev = vmf->info.vma->vm_private_data;
 	struct page *page;
 	unsigned long offset;
 	void *addr;
@@ -679,7 +679,7 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
 		goto out;
 	}
 
-	mi = uio_find_mem_index(vmf->vma);
+	mi = uio_find_mem_index(vmf->info.vma);
 	if (mi < 0) {
 		ret = VM_FAULT_SIGBUS;
 		goto out;
@@ -689,7 +689,7 @@ static vm_fault_t uio_vma_fault(struct vm_fault *vmf)
 	 * We need to subtract mi because userspace uses offset = N*PAGE_SIZE
 	 * to use mem[N].
 	 */
-	offset = (vmf->pgoff - mi) << PAGE_SHIFT;
+	offset = (vmf->info.pgoff - mi) << PAGE_SHIFT;
 
 	addr = (void *)(unsigned long)idev->info->mem[mi].addr + offset;
 	if (idev->info->mem[mi].memtype == UIO_MEM_LOGICAL)
diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index f48a23adbc35..069cb5a913ce 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1244,11 +1244,11 @@ static void mon_bin_vma_close(struct vm_area_struct *vma)
  */
 static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
 {
-	struct mon_reader_bin *rp = vmf->vma->vm_private_data;
+	struct mon_reader_bin *rp = vmf->info.vma->vm_private_data;
 	unsigned long offset, chunk_idx;
 	struct page *pageptr;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	if (offset >= rp->b_size)
 		return VM_FAULT_SIGBUS;
 	chunk_idx = offset / CHUNK_SIZE;
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 706de3ef94bb..4c8b02049c41 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1612,7 +1612,7 @@ static void vfio_pci_mmap_close(struct vm_area_struct *vma)
 
 static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct vfio_pci_device *vdev = vma->vm_private_data;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 
diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
index 9adcf6a8f888..a87a5be33079 100644
--- a/drivers/vfio/pci/vfio_pci_nvlink2.c
+++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
@@ -116,18 +116,18 @@ static void vfio_pci_nvgpu_release(struct vfio_pci_device *vdev,
 static vm_fault_t vfio_pci_nvgpu_mmap_fault(struct vm_fault *vmf)
 {
 	vm_fault_t ret;
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct vfio_pci_region *region = vma->vm_private_data;
 	struct vfio_pci_nvgpu_data *data = region->data;
-	unsigned long vmf_off = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long vmf_off = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 	unsigned long nv2pg = data->gpu_hpa >> PAGE_SHIFT;
 	unsigned long vm_pgoff = vma->vm_pgoff &
 		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
 	unsigned long pfn = nv2pg + vm_pgoff + vmf_off;
 
-	ret = vmf_insert_pfn(vma, vmf->address, pfn);
+	ret = vmf_insert_pfn(vma, vmf->info.address, pfn);
 	trace_vfio_pci_nvgpu_mmap_fault(data->gpdev, pfn << PAGE_SHIFT,
-			vmf->address, ret);
+			vmf->info.address, ret);
 
 	return ret;
 }
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ef688c8c0e0e..ff35f8b06beb 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -936,17 +936,17 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 #ifdef CONFIG_MMU
 static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
 {
-	struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
+	struct vhost_vdpa *v = vmf->info.vma->vm_file->private_data;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct vdpa_notification_area notify;
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	u16 index = vma->vm_pgoff;
 
 	notify = ops->get_vq_notification(vdpa, index);
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
+	if (remap_pfn_range(vma, vmf->info.address & PAGE_MASK,
 			    notify.addr >> PAGE_SHIFT, PAGE_SIZE,
 			    vma->vm_page_prot))
 		return VM_FAULT_SIGBUS;
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a591d291b231..c0680b9db421 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -41,9 +41,9 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	struct page *page;
-	struct fb_info *info = vmf->vma->vm_private_data;
+	struct fb_info *info = vmf->info.vma->vm_private_data;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	if (offset >= info->fix.smem_len)
 		return VM_FAULT_SIGBUS;
 
@@ -53,13 +53,13 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
 
 	get_page(page);
 
-	if (vmf->vma->vm_file)
-		page->mapping = vmf->vma->vm_file->f_mapping;
+	if (vmf->info.vma->vm_file)
+		page->mapping = vmf->info.vma->vm_file->f_mapping;
 	else
 		printk(KERN_ERR "no mapping available\n");
 
 	BUG_ON(!page->mapping);
-	page->index = vmf->pgoff;
+	page->index = vmf->info.pgoff;
 
 	vmf->page = page;
 	return 0;
@@ -93,7 +93,7 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct fb_info *info = vmf->vma->vm_private_data;
+	struct fb_info *info = vmf->info.vma->vm_private_data;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct page *cur;
 
@@ -103,7 +103,7 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	deferred framebuffer IO. then if userspace touches a page
 	again, we repeat the same scheme */
 
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(vmf->info.vma->vm_file);
 
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index dd5bbb6e1b6b..cffe912a371d 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -117,8 +117,9 @@ static void privcmd_buf_vma_close(struct vm_area_struct *vma)
 static vm_fault_t privcmd_buf_vma_fault(struct vm_fault *vmf)
 {
 	pr_debug("fault: vma=%p %lx-%lx, pgoff=%lx, uv=%p\n",
-		 vmf->vma, vmf->vma->vm_start, vmf->vma->vm_end,
-		 vmf->pgoff, (void *)vmf->address);
+		 vmf->info.vma, vmf->info.vma->vm_start,
+		 vmf->info.vma->vm_end,
+		 vmf->info.pgoff, (void *) vmf->info.address);
 
 	return VM_FAULT_SIGBUS;
 }
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b0c73c58f987..7c181310ac5d 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -905,8 +905,8 @@ static void privcmd_close(struct vm_area_struct *vma)
 static vm_fault_t privcmd_fault(struct vm_fault *vmf)
 {
 	printk(KERN_DEBUG "privcmd_fault: vma=%p %lx-%lx, pgoff=%lx, uv=%p\n",
-	       vmf->vma, vmf->vma->vm_start, vmf->vma->vm_end,
-	       vmf->pgoff, (void *)vmf->address);
+	       vmf->info.vma, vmf->info.vma->vm_start, vmf->info.vma->vm_end,
+	       vmf->info.pgoff, (void *) vmf->info.address);
 
 	return VM_FAULT_SIGBUS;
 }
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 649f04f112dc..b8b2435bf284 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -548,7 +548,7 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct v9fs_inode *v9inode;
 	struct page *page = vmf->page;
-	struct file *filp = vmf->vma->vm_file;
+	struct file *filp = vmf->info.vma->vm_file;
 	struct inode *inode = file_inode(filp);
 
 
diff --git a/fs/afs/write.c b/fs/afs/write.c
index c9195fc67fd8..f240de3bf136 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -834,7 +834,7 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	unsigned long priv;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 070716650df8..6c52d6d6c325 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8297,7 +8297,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
@@ -8332,7 +8332,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ret2 = btrfs_delalloc_reserve_space(BTRFS_I(inode), &data_reserved,
 					    page_start, reserved_space);
 	if (!ret2) {
-		ret2 = file_update_time(vmf->vma->vm_file);
+		ret2 = file_update_time(vmf->info.vma->vm_file);
 		reserved = 1;
 	}
 	if (ret2) {
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 950552944436..b867313a44eb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1466,12 +1466,12 @@ static void ceph_restore_sigs(sigset_t *oldset)
  */
 static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	struct page *pinned_page = NULL;
-	loff_t off = (loff_t)vmf->pgoff << PAGE_SHIFT;
+	loff_t off = (loff_t) vmf->info.pgoff << PAGE_SHIFT;
 	int want, got, err;
 	sigset_t oldset;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -1558,7 +1558,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
  */
 static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
diff --git a/fs/dax.c b/fs/dax.c
index 26d5dcd2d69e..cf8f83ca7c11 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -754,7 +754,8 @@ static void *dax_insert_entry(struct xa_state *xas,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
+		dax_associate_entry(new_entry, mapping, vmf->info.vma,
+				    vmf->info.address);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -1041,14 +1042,14 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 		struct vm_fault *vmf)
 {
 	struct inode *inode = mapping->host;
-	unsigned long vaddr = vmf->address;
+	unsigned long vaddr = vmf->info.address;
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
 	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
 			DAX_ZERO_PAGE, false);
 
-	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+	ret = vmf_insert_mixed(vmf->info.vma, vaddr, pfn);
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1246,12 +1247,12 @@ static bool dax_fault_is_synchronous(unsigned long flags,
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			       int *iomap_errp, const struct iomap_ops *ops)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
+	XA_STATE(xas, &mapping->i_pages, vmf->info.pgoff);
 	struct inode *inode = mapping->host;
-	unsigned long vaddr = vmf->address;
-	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
+	unsigned long vaddr = vmf->info.address;
+	loff_t pos = (loff_t) vmf->info.pgoff << PAGE_SHIFT;
 	struct iomap iomap = { .type = IOMAP_HOLE };
 	struct iomap srcmap = { .type = IOMAP_HOLE };
 	unsigned flags = IOMAP_FAULT;
@@ -1416,9 +1417,9 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		struct iomap *iomap, void **entry)
 {
-	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	unsigned long pmd_addr = vmf->address & PMD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
+	struct address_space *mapping = vmf->info.vma->vm_file->f_mapping;
+	unsigned long pmd_addr = vmf->info.address & PMD_MASK;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct inode *inode = mapping->host;
 	pgtable_t pgtable = NULL;
 	struct page *zero_page;
@@ -1426,7 +1427,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	pmd_t pmd_entry;
 	pfn_t pfn;
 
-	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
+	zero_page = mm_get_huge_zero_page(vmf->info.vma->vm_mm);
 
 	if (unlikely(!zero_page))
 		goto fallback;
@@ -1441,7 +1442,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 			return VM_FAULT_OOM;
 	}
 
-	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
+	ptl = pmd_lock(vmf->info.vma->vm_mm, vmf->pmd);
 	if (!pmd_none(*(vmf->pmd))) {
 		spin_unlock(ptl);
 		goto fallback;
@@ -1451,9 +1452,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
 		mm_inc_nr_ptes(vma->vm_mm);
 	}
-	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
+	pmd_entry = mk_pmd(zero_page, vmf->info.vma->vm_page_prot);
 	pmd_entry = pmd_mkhuge(pmd_entry);
-	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
+	set_pmd_at(vmf->info.vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
 	spin_unlock(ptl);
 	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
 	return VM_FAULT_NOPAGE;
@@ -1468,10 +1469,10 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			       const struct iomap_ops *ops)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
-	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->info.pgoff, PMD_ORDER);
+	unsigned long pmd_addr = vmf->info.address & PMD_MASK;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool sync;
 	unsigned int iomap_flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
@@ -1500,8 +1501,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * that a PMD range in the page table overlaps exactly with a PMD
 	 * range in the page cache.
 	 */
-	if ((vmf->pgoff & PG_PMD_COLOUR) !=
-	    ((vmf->address >> PAGE_SHIFT) & PG_PMD_COLOUR))
+	if ((vmf->info.pgoff & PG_PMD_COLOUR) !=
+	    ((vmf->info.address >> PAGE_SHIFT) & PG_PMD_COLOUR))
 		goto fallback;
 
 	/* Fall back to PTEs if we're going to COW */
@@ -1619,7 +1620,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	dax_unlock_entry(&xas, entry);
  fallback:
 	if (result == VM_FAULT_FALLBACK) {
-		split_huge_pmd(vma, vmf->pmd, vmf->address);
+		split_huge_pmd(vma, vmf->pmd, vmf->info.address);
 		count_vm_event(THP_FAULT_FALLBACK);
 	}
 out:
@@ -1673,8 +1674,8 @@ EXPORT_SYMBOL_GPL(dax_iomap_fault);
 static vm_fault_t
 dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 {
-	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, order);
+	struct address_space *mapping = vmf->info.vma->vm_file->f_mapping;
+	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->info.pgoff, order);
 	void *entry;
 	vm_fault_t ret;
 
@@ -1693,7 +1694,8 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	dax_lock_entry(&xas, entry);
 	xas_unlock_irq(&xas);
 	if (order == 0)
-		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+		ret = vmf_insert_mixed_mkwrite(vmf->info.vma,
+					       vmf->info.address, pfn);
 #ifdef CONFIG_FS_DAX_PMD
 	else if (order == PMD_ORDER)
 		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
@@ -1719,11 +1721,12 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
 		enum page_entry_size pe_size, pfn_t pfn)
 {
 	int err;
-	loff_t start = ((loff_t)vmf->pgoff) << PAGE_SHIFT;
+	loff_t start = ((loff_t) vmf->info.pgoff) << PAGE_SHIFT;
 	unsigned int order = pe_order(pe_size);
 	size_t len = PAGE_SIZE << order;
 
-	err = vfs_fsync_range(vmf->vma->vm_file, start, start + len - 1, 1);
+	err = vfs_fsync_range(vmf->info.vma->vm_file, start, start + len - 1,
+			      1);
 	if (err)
 		return VM_FAULT_SIGBUS;
 	return dax_insert_pfn_mkwrite(vmf, pfn, order);
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 96044f5dbc0e..88a4496bb49e 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -90,15 +90,15 @@ static ssize_t ext2_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
  */
 static vm_fault_t ext2_dax_fault(struct vm_fault *vmf)
 {
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	vm_fault_t ret;
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
-		(vmf->vma->vm_flags & VM_SHARED);
+		(vmf->info.vma->vm_flags & VM_SHARED);
 
 	if (write) {
 		sb_start_pagefault(inode->i_sb);
-		file_update_time(vmf->vma->vm_file);
+		file_update_time(vmf->info.vma->vm_file);
 	}
 	down_read(&ei->dax_sem);
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 3ed8c048fb12..cb036e287d8a 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -672,7 +672,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	vm_fault_t result;
 	int retries = 0;
 	handle_t *handle = NULL;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct super_block *sb = inode->i_sb;
 
 	/*
@@ -687,12 +687,12 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	 * we eventually come back with a COW page.
 	 */
 	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
-		(vmf->vma->vm_flags & VM_SHARED);
+		(vmf->info.vma->vm_flags & VM_SHARED);
 	pfn_t pfn;
 
 	if (write) {
 		sb_start_pagefault(sb);
-		file_update_time(vmf->vma->vm_file);
+		file_update_time(vmf->info.vma->vm_file);
 		down_read(&EXT4_I(inode)->i_mmap_sem);
 retry:
 		handle = ext4_journal_start_sb(sb, EXT4_HT_WRITE_PAGE,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 27946882d4ce..328ffbf3684e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6051,7 +6051,7 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
 
 vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page = vmf->page;
 	loff_t size;
 	unsigned long len;
@@ -6194,7 +6194,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 
 vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
 {
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	vm_fault_t ret;
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f585545277d7..ed7739819f64 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -35,7 +35,7 @@
 
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	vm_fault_t ret;
 
 	down_read(&F2FS_I(inode)->i_mmap_sem);
@@ -46,7 +46,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 		f2fs_update_iostat(F2FS_I_SB(inode), APP_MAPPED_READ_IO,
 							F2FS_BLKSIZE);
 
-	trace_f2fs_filemap_fault(inode, vmf->pgoff, (unsigned long)ret);
+	trace_f2fs_filemap_fault(inode, vmf->info.pgoff, (unsigned long)ret);
 
 	return ret;
 }
@@ -54,7 +54,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = true;
@@ -94,7 +94,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(vmf->info.vma->vm_file);
 	down_read(&F2FS_I(inode)->i_mmap_sem);
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping ||
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ff99ab2a3c43..c8e1156d6b34 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -792,7 +792,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 				   enum page_entry_size pe_size, bool write)
 {
 	vm_fault_t ret;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct super_block *sb = inode->i_sb;
 	pfn_t pfn;
 	int error = 0;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..fa17695b2d56 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2336,9 +2336,9 @@ static void fuse_vma_close(struct vm_area_struct *vma)
 static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(vmf->info.vma->vm_file);
 	lock_page(page);
 	if (page->mapping != inode->i_mapping) {
 		unlock_page(page);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b39b339feddc..e3a538d9b95b 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -445,7 +445,7 @@ static int gfs2_allocate_page_backing(struct page *page, unsigned int length)
 static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_alloc_parms ap = { .aflags = 0, };
@@ -471,7 +471,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	/* Update file times before taking page lock */
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(vmf->info.vma->vm_file);
 
 	/* page is wholly or partially inside EOF */
 	if (offset > size - PAGE_SIZE)
@@ -479,7 +479,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	else
 		length = PAGE_SIZE;
 
-	gfs2_size_hint(vmf->vma->vm_file, offset, length);
+	gfs2_size_hint(vmf->info.vma->vm_file, offset, length);
 
 	set_bit(GLF_DIRTY, &ip->i_gl->gl_flags);
 	set_bit(GIF_SW_PAGED, &ip->i_flags);
@@ -560,7 +560,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 
 static vm_fault_t gfs2_fault(struct vm_fault *vmf)
 {
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
 	vm_fault_t ret;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..5197649aa9ad 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1007,7 +1007,7 @@ iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	unsigned long length;
 	loff_t offset;
 	ssize_t ret;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd..ff11c1cd14ce 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -349,7 +349,7 @@ static void kernfs_vma_open(struct vm_area_struct *vma)
 
 static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	struct kernfs_open_file *of = kernfs_of(file);
 	vm_fault_t ret;
 
@@ -369,7 +369,7 @@ static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 
 static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	struct kernfs_open_file *of = kernfs_of(file);
 	vm_fault_t ret;
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 63940a7a70be..5288c347f433 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -542,7 +542,7 @@ const struct address_space_operations nfs_file_aops = {
 static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct file *filp = vmf->vma->vm_file;
+	struct file *filp = vmf->info.vma->vm_file;
 	struct inode *inode = file_inode(filp);
 	unsigned pagelen;
 	vm_fault_t ret = VM_FAULT_NOPAGE;
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 64bc81363c6c..302c0cb9fa70 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -44,7 +44,7 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct nilfs_transaction_info ti;
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 25cabbfe87fc..adf7c8f10071 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -32,7 +32,7 @@
 
 static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	sigset_t oldset;
 	vm_fault_t ret;
 
@@ -41,7 +41,7 @@ static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 	ocfs2_unblock_signals(&oldset);
 
 	trace_ocfs2_fault(OCFS2_I(vma->vm_file->f_mapping->host)->ip_blkno,
-			  vma, vmf->page, vmf->pgoff);
+			  vma, vmf->page, vmf->info.pgoff);
 	return ret;
 }
 
@@ -115,7 +115,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 static vm_fault_t ocfs2_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct buffer_head *di_bh = NULL;
 	sigset_t oldset;
 	int err;
@@ -143,7 +143,7 @@ static vm_fault_t ocfs2_page_mkwrite(struct vm_fault *vmf)
 	 */
 	down_write(&OCFS2_I(inode)->ip_alloc_sem);
 
-	ret = __ocfs2_page_mkwrite(vmf->vma->vm_file, di_bh, page);
+	ret = __ocfs2_page_mkwrite(vmf->info.vma->vm_file, di_bh, page);
 
 	up_write(&OCFS2_I(inode)->ip_alloc_sem);
 
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index ec8ae4257975..6f4c3c3c179c 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -455,7 +455,7 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 
 static vm_fault_t orangefs_fault(struct vm_fault *vmf)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	int ret;
 	ret = orangefs_inode_getattr(file->f_mapping->host,
 	    ORANGEFS_GETATTR_SIZE);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 48f0547d4850..9601db6a9f9b 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -674,7 +674,7 @@ static const struct address_space_operations orangefs_address_operations = {
 vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	unsigned long *bitlock = &orangefs_inode->bitlock;
 	vm_fault_t ret;
@@ -725,7 +725,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 	attach_page_private(page, wr);
 okay:
 
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(vmf->info.vma->vm_file);
 	if (page->mapping != inode->i_mapping) {
 		unlock_page(page);
 		ret = VM_FAULT_LOCKED|VM_FAULT_NOPAGE;
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index c3a345c28a93..b40063405807 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -411,8 +411,8 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 {
 #ifdef CONFIG_S390
-	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	pgoff_t index = vmf->pgoff;
+	struct address_space *mapping = vmf->info.vma->vm_file->f_mapping;
+	pgoff_t index = vmf->info.pgoff;
 	struct page *page;
 	loff_t offset;
 	char *buf;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2bc7780d2963..b6bdd6d94ae6 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1507,7 +1507,7 @@ static int ubifs_releasepage(struct page *page, gfp_t unused_gfp_flags)
 static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct timespec64 now = current_time(inode);
 	struct ubifs_budget_req req = { .new_page = 1 };
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 894cc28142e7..cc1e89cdb118 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -367,7 +367,7 @@ static inline long userfaultfd_get_blocking_state(unsigned int flags)
  */
 vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 {
-	struct mm_struct *mm = vmf->vma->vm_mm;
+	struct mm_struct *mm = vmf->info.vma->vm_mm;
 	struct userfaultfd_ctx *ctx;
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -394,7 +394,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 */
 	mmap_assert_locked(mm);
 
-	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
+	ctx = vmf->info.vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
 		goto out;
 
@@ -480,8 +480,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	init_waitqueue_func_entry(&uwq.wq, userfaultfd_wake_function);
 	uwq.wq.private = current;
-	uwq.msg = userfault_msg(vmf->address, vmf->flags, reason,
-			ctx->features);
+	uwq.msg = userfault_msg(vmf->info.address, vmf->flags, reason,
+				ctx->features);
 	uwq.ctx = ctx;
 	uwq.waken = false;
 
@@ -501,12 +501,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	set_current_state(blocking_state);
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
-	if (!is_vm_hugetlb_page(vmf->vma))
-		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
+	if (!is_vm_hugetlb_page(vmf->info.vma))
+		must_wait = userfaultfd_must_wait(ctx, vmf->info.address,
+						  vmf->flags,
 						  reason);
 	else
-		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
-						       vmf->address,
+		must_wait = userfaultfd_huge_must_wait(ctx, vmf->info.vma,
+						       vmf->info.address,
 						       vmf->flags, reason);
 	mmap_read_unlock(mm);
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 111fe73bb8a7..3cebf73154f7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1233,7 +1233,7 @@ __xfs_filemap_fault(
 	enum page_entry_size	pe_size,
 	bool			write_fault)
 {
-	struct inode		*inode = file_inode(vmf->vma->vm_file);
+	struct inode		*inode = file_inode(vmf->info.vma->vm_file);
 	struct xfs_inode	*ip = XFS_I(inode);
 	vm_fault_t		ret;
 
@@ -1241,7 +1241,7 @@ __xfs_filemap_fault(
 
 	if (write_fault) {
 		sb_start_pagefault(inode->i_sb);
-		file_update_time(vmf->vma->vm_file);
+		file_update_time(vmf->info.vma->vm_file);
 	}
 
 	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
@@ -1273,7 +1273,7 @@ xfs_is_write_fault(
 	struct vm_fault		*vmf)
 {
 	return (vmf->flags & FAULT_FLAG_WRITE) &&
-	       (vmf->vma->vm_flags & VM_SHARED);
+	       (vmf->info.vma->vm_flags & VM_SHARED);
 }
 
 static vm_fault_t
@@ -1282,7 +1282,7 @@ xfs_filemap_fault(
 {
 	/* DAX can shortcut the normal fault path on write faults! */
 	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
-			IS_DAX(file_inode(vmf->vma->vm_file)) &&
+			IS_DAX(file_inode(vmf->info.vma->vm_file)) &&
 			xfs_is_write_fault(vmf));
 }
 
@@ -1291,7 +1291,7 @@ xfs_filemap_huge_fault(
 	struct vm_fault		*vmf,
 	enum page_entry_size	pe_size)
 {
-	if (!IS_DAX(file_inode(vmf->vma->vm_file)))
+	if (!IS_DAX(file_inode(vmf->info.vma->vm_file)))
 		return VM_FAULT_FALLBACK;
 
 	/* DAX can shortcut the normal fault path on write faults! */
@@ -1325,7 +1325,7 @@ xfs_filemap_map_pages(
 	pgoff_t			start_pgoff,
 	pgoff_t			end_pgoff)
 {
-	struct inode		*inode = file_inode(vmf->vma->vm_file);
+	struct inode		*inode = file_inode(vmf->info.vma->vm_file);
 	vm_fault_t ret;
 
 	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..565baa1547da 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -551,7 +551,7 @@ static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
 
 static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)
 {
-	struct zonefs_inode_info *zi = ZONEFS_I(file_inode(vmf->vma->vm_file));
+	struct zonefs_inode_info *zi = ZONEFS_I(file_inode(vmf->info.vma->vm_file));
 	vm_fault_t ret;
 
 	down_read(&zi->i_mmap_sem);
@@ -563,7 +563,7 @@ static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)
 
 static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
-	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct inode *inode = file_inode(vmf->info.vma->vm_file);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	vm_fault_t ret;
 
@@ -578,7 +578,7 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 		return VM_FAULT_NOPAGE;
 
 	sb_start_pagefault(inode->i_sb);
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(vmf->info.vma->vm_file);
 
 	/* Serialize against truncates */
 	down_read(&zi->i_mmap_sem);
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 6a19f35f836b..94fc4ab55e27 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -55,7 +55,8 @@ vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
 static inline vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn,
 					    bool write)
 {
-	return vmf_insert_pfn_pmd_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
+	struct vm_area_struct *vma = vmf->info.vma;
+	return vmf_insert_pfn_pmd_prot(vmf, pfn, vma->vm_page_prot, write);
 }
 vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
 				   pgprot_t pgprot, bool write);
@@ -74,7 +75,8 @@ vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
 static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
 					    bool write)
 {
-	return vmf_insert_pfn_pud_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
+	struct vm_area_struct *vma = vmf->info.vma;
+	return vmf_insert_pfn_pud_prot(vmf, pfn, vma->vm_page_prot, write);
 }
 
 enum transparent_hugepage_flag {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 251a2339befb..15e8dd77b8ff 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -516,12 +516,17 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
  *
  * pgoff should be used in favour of virtual_address, if possible.
  */
-struct vm_fault {
+struct vm_fault_info {
 	struct vm_area_struct *vma;	/* Target VMA */
-	unsigned int flags;		/* FAULT_FLAG_xxx flags */
 	gfp_t gfp_mask;			/* gfp mask to be used for allocations */
 	pgoff_t pgoff;			/* Logical page offset based on vma */
 	unsigned long address;		/* Faulting virtual address */
+};
+
+struct vm_fault {
+	struct vm_fault_info info;
+	unsigned int flags;		/* FAULT_FLAG_xxx flags
+					 * XXX: should be in vm_fault_info */
 	pmd_t *pmd;			/* Pointer to pmd entry matching
 					 * the 'address' */
 	pud_t *pud;			/* Pointer to pud entry matching
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 97b09fcf7e52..5bd694dc879c 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -26,12 +26,12 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->vm_start = vmf->vma->vm_start;
-		__entry->vm_end = vmf->vma->vm_end;
-		__entry->vm_flags = vmf->vma->vm_flags;
-		__entry->address = vmf->address;
+		__entry->vm_start = vmf->info.vma->vm_start;
+		__entry->vm_end = vmf->info.vma->vm_end;
+		__entry->vm_flags = vmf->info.vma->vm_flags;
+		__entry->address = vmf->info.address;
 		__entry->flags = vmf->flags;
-		__entry->pgoff = vmf->pgoff;
+		__entry->pgoff = vmf->info.pgoff;
 		__entry->max_pgoff = max_pgoff;
 		__entry->result = result;
 	),
@@ -76,8 +76,8 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->vm_flags = vmf->vma->vm_flags;
-		__entry->address = vmf->address;
+		__entry->vm_flags = vmf->info.vma->vm_flags;
+		__entry->address = vmf->info.address;
 		__entry->zero_page = zero_page;
 		__entry->radix_entry = radix_entry;
 	),
@@ -119,8 +119,8 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->vm_flags = vmf->vma->vm_flags;
-		__entry->address = vmf->address;
+		__entry->vm_flags = vmf->info.vma->vm_flags;
+		__entry->address = vmf->info.address;
 		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
 		__entry->length = length;
 		__entry->pfn_val = pfn.val;
@@ -165,10 +165,10 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->vm_flags = vmf->vma->vm_flags;
-		__entry->address = vmf->address;
+		__entry->vm_flags = vmf->info.vma->vm_flags;
+		__entry->address = vmf->info.address;
 		__entry->flags = vmf->flags;
-		__entry->pgoff = vmf->pgoff;
+		__entry->pgoff = vmf->info.pgoff;
 		__entry->result = result;
 	),
 	TP_printk("dev %d:%d ino %#lx %s %s address %#lx pgoff %#lx %s",
@@ -208,8 +208,8 @@ TRACE_EVENT(dax_insert_mapping,
 	TP_fast_assign(
 		__entry->dev = inode->i_sb->s_dev;
 		__entry->ino = inode->i_ino;
-		__entry->vm_flags = vmf->vma->vm_flags;
-		__entry->address = vmf->address;
+		__entry->vm_flags = vmf->info.vma->vm_flags;
+		__entry->address = vmf->info.address;
 		__entry->write = vmf->flags & FAULT_FLAG_WRITE;
 		__entry->radix_entry = radix_entry;
 	),
diff --git a/ipc/shm.c b/ipc/shm.c
index febd88daba8c..f2dddad68b52 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -428,7 +428,7 @@ void exit_shm(struct task_struct *task)
 
 static vm_fault_t shm_fault(struct vm_fault *vmf)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	struct shm_file_data *sfd = shm_file_data(file);
 
 	return sfd->vm_ops->fault(vmf);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d18791a72d..b14325edbe14 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5740,12 +5740,12 @@ EXPORT_SYMBOL_GPL(perf_event_update_userpage);
 
 static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
 {
-	struct perf_event *event = vmf->vma->vm_file->private_data;
+	struct perf_event *event = vmf->info.vma->vm_file->private_data;
 	struct perf_buffer *rb;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	if (vmf->flags & FAULT_FLAG_MKWRITE) {
-		if (vmf->pgoff == 0)
+		if (vmf->info.pgoff == 0)
 			ret = 0;
 		return ret;
 	}
@@ -5755,16 +5755,16 @@ static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
 	if (!rb)
 		goto unlock;
 
-	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
+	if (vmf->info.pgoff && (vmf->flags & FAULT_FLAG_WRITE))
 		goto unlock;
 
-	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
+	vmf->page = perf_mmap_to_page(rb, vmf->info.pgoff);
 	if (!vmf->page)
 		goto unlock;
 
 	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
+	vmf->page->mapping = vmf->info.vma->vm_file->f_mapping;
+	vmf->page->index   = vmf->info.pgoff;
 
 	ret = 0;
 unlock:
diff --git a/kernel/relay.c b/kernel/relay.c
index d1a67fbb819d..b5a2d312134b 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -33,8 +33,8 @@ static LIST_HEAD(relay_channels);
 static vm_fault_t relay_buf_fault(struct vm_fault *vmf)
 {
 	struct page *page;
-	struct rchan_buf *buf = vmf->vma->vm_private_data;
-	pgoff_t pgoff = vmf->pgoff;
+	struct rchan_buf *buf = vmf->info.vma->vm_private_data;
+	pgoff_t pgoff = vmf->info.pgoff;
 
 	if (!buf)
 		return VM_FAULT_OOM;
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 80a78877bd93..0e72ed33258f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1040,8 +1040,8 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
 	dmirror = rpage->zone_device_data;
 
 	/* FIXME demonstrate how we can adjust migrate range */
-	args.vma = vmf->vma;
-	args.start = vmf->address;
+	args.vma = vmf->info.vma;
+	args.start = vmf->info.address;
 	args.end = args.start + PAGE_SIZE;
 	args.src = &src_pfns;
 	args.dst = &dst_pfns;
diff --git a/mm/filemap.c b/mm/filemap.c
index a6dc97906c8e..c192e103843f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2674,7 +2674,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 			 * mmap_lock here and return 0 if we don't have a fpin.
 			 */
 			if (*fpin == NULL)
-				mmap_read_unlock(vmf->vma->vm_mm);
+				mmap_read_unlock(vmf->info.vma->vm_mm);
 			return 0;
 		}
 	} else
@@ -2692,20 +2692,20 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
  */
 static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
-	DEFINE_READAHEAD(ractl, file, mapping, vmf->pgoff);
+	DEFINE_READAHEAD(ractl, file, mapping, vmf->info.pgoff);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ)
+	if (vmf->info.vma->vm_flags & VM_RAND_READ)
 		return fpin;
 	if (!ra->ra_pages)
 		return fpin;
 
-	if (vmf->vma->vm_flags & VM_SEQ_READ) {
+	if (vmf->info.vma->vm_flags & VM_SEQ_READ) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_sync_ra(&ractl, ra, ra->ra_pages);
 		return fpin;
@@ -2727,7 +2727,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 * mmap read-around
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
+	ra->start = max_t(long, 0, vmf->info.pgoff - ra->ra_pages / 2);
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
@@ -2743,15 +2743,15 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 					    struct page *page)
 {
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
-	pgoff_t offset = vmf->pgoff;
+	pgoff_t offset = vmf->info.pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
-	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
+	if (vmf->info.vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
 	mmap_miss = READ_ONCE(ra->mmap_miss);
 	if (mmap_miss)
@@ -2790,12 +2790,12 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 vm_fault_t filemap_fault(struct vm_fault *vmf)
 {
 	int error;
-	struct file *file = vmf->vma->vm_file;
+	struct file *file = vmf->info.vma->vm_file;
 	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
 	struct file_ra_state *ra = &file->f_ra;
 	struct inode *inode = mapping->host;
-	pgoff_t offset = vmf->pgoff;
+	pgoff_t offset = vmf->info.pgoff;
 	pgoff_t max_off;
 	struct page *page;
 	vm_fault_t ret = 0;
@@ -2817,13 +2817,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	} else if (!page) {
 		/* No page in the page cache at all */
 		count_vm_event(PGMAJFAULT);
-		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
+		count_memcg_event_mm(vmf->info.vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
 		fpin = do_sync_mmap_readahead(vmf);
 retry_find:
 		page = pagecache_get_page(mapping, offset,
 					  FGP_CREAT|FGP_FOR_MMAP,
-					  vmf->gfp_mask);
+					  vmf->info.gfp_mask);
 		if (!page) {
 			if (fpin)
 				goto out_retry;
@@ -2914,7 +2914,7 @@ EXPORT_SYMBOL(filemap_fault);
 
 static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 {
-	struct mm_struct *mm = vmf->vma->vm_mm;
+	struct mm_struct *mm = vmf->info.vma->vm_mm;
 
 	/* Huge page is mapped? No need to proceed. */
 	if (pmd_trans_huge(*vmf->pmd)) {
@@ -3014,11 +3014,11 @@ static inline struct page *next_map_page(struct address_space *mapping,
 vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			     pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
 	pgoff_t last_pgoff = start_pgoff;
-	unsigned long address = vmf->address;
+	unsigned long address = vmf->info.address;
 	unsigned long flags = vmf->flags;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct page *head, *page;
@@ -3035,8 +3035,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	vmf->address = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address, &vmf->ptl);
+	vmf->info.address = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->info.address, &vmf->ptl);
 	do {
 		page = find_subpage(head, xas.xa_index);
 		if (PageHWPoison(page))
@@ -3045,7 +3046,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		if (mmap_miss > 0)
 			mmap_miss--;
 
-		vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
+		vmf->info.address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
 
@@ -3053,7 +3054,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			goto unlock;
 
 		/* We're about to handle the fault */
-		if (vmf->address == address) {
+		if (vmf->info.address == address) {
 			vmf->flags &= ~FAULT_FLAG_PREFAULT;
 			ret = VM_FAULT_NOPAGE;
 		} else {
@@ -3062,7 +3063,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 		do_set_pte(vmf, page);
 		/* no need to invalidate: a not-present page won't be cached */
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_cache(vma, vmf->info.address, vmf->pte);
 		unlock_page(head);
 		continue;
 unlock:
@@ -3073,7 +3074,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 out:
 	rcu_read_unlock();
 	vmf->flags = flags;
-	vmf->address = address;
+	vmf->info.address = address;
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 	return ret;
 }
@@ -3081,12 +3082,12 @@ EXPORT_SYMBOL(filemap_map_pages);
 
 vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
-	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	struct address_space *mapping = vmf->info.vma->vm_file->f_mapping;
 	struct page *page = vmf->page;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
 	sb_start_pagefault(mapping->host->i_sb);
-	file_update_time(vmf->vma->vm_file);
+	file_update_time(vmf->info.vma->vm_file);
 	lock_page(page);
 	if (page->mapping != mapping) {
 		unlock_page(page);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9237976abe72..b07066d98fa5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -579,9 +579,9 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			struct page *page, gfp_t gfp)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	pgtable_t pgtable;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	unsigned long haddr = vmf->info.address & HPAGE_PMD_MASK;
 	vm_fault_t ret = 0;
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
@@ -600,7 +600,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		goto release;
 	}
 
-	clear_huge_page(page, vmf->address, HPAGE_PMD_NR);
+	clear_huge_page(page, vmf->info.address, HPAGE_PMD_NR);
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
 	 * clear_huge_page writes become visible before the set_pmd_at()
@@ -708,10 +708,10 @@ static bool set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
 
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	gfp_t gfp;
 	struct page *page;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	unsigned long haddr = vmf->info.address & HPAGE_PMD_MASK;
 
 	if (!transhuge_vma_suitable(vma, haddr))
 		return VM_FAULT_FALLBACK;
@@ -823,15 +823,15 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
  *
  * Insert a pmd size pfn. See vmf_insert_pfn() for additional info and
  * also consult the vmf_insert_mixed_prot() documentation when
- * @pgprot != @vmf->vma->vm_page_prot.
+ * @pgprot != @vmf->info.vma->vm_page_prot.
  *
  * Return: vm_fault_t value.
  */
 vm_fault_t vmf_insert_pfn_pmd_prot(struct vm_fault *vmf, pfn_t pfn,
 				   pgprot_t pgprot, bool write)
 {
-	unsigned long addr = vmf->address & PMD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->info.address & PMD_MASK;
+	struct vm_area_struct *vma = vmf->info.vma;
 	pgtable_t pgtable = NULL;
 
 	/*
@@ -914,15 +914,15 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
  *
  * Insert a pud size pfn. See vmf_insert_pfn() for additional info and
  * also consult the vmf_insert_mixed_prot() documentation when
- * @pgprot != @vmf->vma->vm_page_prot.
+ * @pgprot != @vmf->info.vma->vm_page_prot.
  *
  * Return: vm_fault_t value.
  */
 vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
 				   pgprot_t pgprot, bool write)
 {
-	unsigned long addr = vmf->address & PUD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->info.address & PUD_MASK;
+	struct vm_area_struct *vma = vmf->info.vma;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1235,16 +1235,17 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 	unsigned long haddr;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 
-	vmf->ptl = pud_lock(vmf->vma->vm_mm, vmf->pud);
+	vmf->ptl = pud_lock(vmf->info.vma->vm_mm, vmf->pud);
 	if (unlikely(!pud_same(*vmf->pud, orig_pud)))
 		goto unlock;
 
 	entry = pud_mkyoung(orig_pud);
 	if (write)
 		entry = pud_mkdirty(entry);
-	haddr = vmf->address & HPAGE_PUD_MASK;
-	if (pudp_set_access_flags(vmf->vma, haddr, vmf->pud, entry, write))
-		update_mmu_cache_pud(vmf->vma, vmf->address, vmf->pud);
+	haddr = vmf->info.address & HPAGE_PUD_MASK;
+	if (pudp_set_access_flags(vmf->info.vma, haddr, vmf->pud, entry, write))
+		update_mmu_cache_pud(vmf->info.vma, vmf->info.address,
+				     vmf->pud);
 
 unlock:
 	spin_unlock(vmf->ptl);
@@ -1257,16 +1258,17 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
 	unsigned long haddr;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 
-	vmf->ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
+	vmf->ptl = pmd_lock(vmf->info.vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
 		goto unlock;
 
 	entry = pmd_mkyoung(orig_pmd);
 	if (write)
 		entry = pmd_mkdirty(entry);
-	haddr = vmf->address & HPAGE_PMD_MASK;
-	if (pmdp_set_access_flags(vmf->vma, haddr, vmf->pmd, entry, write))
-		update_mmu_cache_pmd(vmf->vma, vmf->address, vmf->pmd);
+	haddr = vmf->info.address & HPAGE_PMD_MASK;
+	if (pmdp_set_access_flags(vmf->info.vma, haddr, vmf->pmd, entry, write))
+		update_mmu_cache_pmd(vmf->info.vma, vmf->info.address,
+				     vmf->pmd);
 
 unlock:
 	spin_unlock(vmf->ptl);
@@ -1274,9 +1276,9 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
 
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	unsigned long haddr = vmf->info.address & HPAGE_PMD_MASK;
 
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
@@ -1318,7 +1320,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		entry = pmd_mkyoung(orig_pmd);
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
-			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
+			update_mmu_cache_pmd(vma, vmf->info.address, vmf->pmd);
 		unlock_page(page);
 		spin_unlock(vmf->ptl);
 		return VM_FAULT_WRITE;
@@ -1327,7 +1329,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 	unlock_page(page);
 	spin_unlock(vmf->ptl);
 fallback:
-	__split_huge_pmd(vma, vmf->pmd, vmf->address, false, NULL);
+	__split_huge_pmd(vma, vmf->pmd, vmf->info.address, false, NULL);
 	return VM_FAULT_FALLBACK;
 }
 
@@ -1414,10 +1416,10 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 /* NUMA hinting page fault entry point for trans huge pmds */
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct anon_vma *anon_vma = NULL;
 	struct page *page;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	unsigned long haddr = vmf->info.address & HPAGE_PMD_MASK;
 	int page_nid = NUMA_NO_NODE, this_nid = numa_node_id();
 	int target_nid, last_cpupid = -1;
 	bool page_locked;
@@ -1536,7 +1538,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	spin_unlock(vmf->ptl);
 
 	migrated = migrate_misplaced_transhuge_page(vma->vm_mm, vma,
-				vmf->pmd, pmd, vmf->address, page, target_nid);
+				vmf->pmd, pmd, vmf->info.address, page,
+				target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
@@ -1552,7 +1555,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	if (was_writable)
 		pmd = pmd_mkwrite(pmd);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
-	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
+	update_mmu_cache_pmd(vma, vmf->info.address, vmf->pmd);
 	unlock_page(page);
 out_unlock:
 	spin_unlock(vmf->ptl);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a2602969873d..7e386fd4b794 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4294,8 +4294,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		if (userfaultfd_missing(vma)) {
 			u32 hash;
 			struct vm_fault vmf = {
-				.vma = vma,
-				.address = haddr,
+				.info = {
+					.vma = vma,
+					.address = haddr,
+				},
 				.flags = flags,
 				/*
 				 * Hard to debug if it ends up being
diff --git a/mm/internal.h b/mm/internal.h
index 25d2b2439f19..201135a2d8bc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -422,8 +422,8 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 	 */
 	if (fault_flag_allow_retry_first(flags) &&
 	    !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
-		fpin = get_file(vmf->vma->vm_file);
-		mmap_read_unlock(vmf->vma->vm_mm);
+		fpin = get_file(vmf->info.vma->vm_file);
+		mmap_read_unlock(vmf->info.vma->vm_mm);
 	}
 	return fpin;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 67ab391a5373..4494c90075fb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -997,16 +997,18 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 	int swapped_in = 0;
 	vm_fault_t ret = 0;
 	struct vm_fault vmf = {
-		.vma = vma,
-		.address = address,
+		.info = {
+			.vma = vma,
+			.address = address,
+			.pgoff = linear_page_index(vma, address),
+		},
 		.flags = FAULT_FLAG_ALLOW_RETRY,
 		.pmd = pmd,
-		.pgoff = linear_page_index(vma, address),
 	};
 
 	vmf.pte = pte_offset_map(pmd, address);
-	for (; vmf.address < address + HPAGE_PMD_NR*PAGE_SIZE;
-			vmf.pte++, vmf.address += PAGE_SIZE) {
+	for (; vmf.info.address < address + HPAGE_PMD_NR*PAGE_SIZE;
+			vmf.pte++, vmf.info.address += PAGE_SIZE) {
 		vmf.orig_pte = *vmf.pte;
 		if (!is_swap_pte(vmf.orig_pte))
 			continue;
@@ -1016,7 +1018,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 		/* do_swap_page returns VM_FAULT_RETRY with released mmap_lock */
 		if (ret & VM_FAULT_RETRY) {
 			mmap_read_lock(mm);
-			if (hugepage_vma_revalidate(mm, address, &vmf.vma)) {
+			if (hugepage_vma_revalidate(mm, address, &vmf.info.vma)) {
 				/* vma is no longer available, don't continue to swapin */
 				trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 0);
 				return false;
@@ -1032,7 +1034,7 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 			return false;
 		}
 		/* pte is unmapped now, we need to map it */
-		vmf.pte = pte_offset_map(pmd, vmf.address);
+		vmf.pte = pte_offset_map(pmd, vmf.info.address);
 	}
 	vmf.pte--;
 	pte_unmap(vmf.pte);
diff --git a/mm/memory.c b/mm/memory.c
index f0e7c589ca9d..ffb7598046fc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2603,9 +2603,9 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	void *kaddr;
 	void __user *uaddr;
 	bool locked = false;
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long addr = vmf->address;
+	unsigned long addr = vmf->info.address;
 
 	if (likely(src)) {
 		copy_user_highpage(dst, src, addr, vma);
@@ -2719,11 +2719,11 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
 
-	if (vmf->vma->vm_file &&
-	    IS_SWAPFILE(vmf->vma->vm_file->f_mapping->host))
+	if (vmf->info.vma->vm_file &&
+	    IS_SWAPFILE(vmf->info.vma->vm_file->f_mapping->host))
 		return VM_FAULT_SIGBUS;
 
-	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
+	ret = vmf->info.vma->vm_ops->page_mkwrite(vmf);
 	/* Restore original flags so that caller is not surprised */
 	vmf->flags = old_flags;
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
@@ -2747,7 +2747,7 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
  */
 static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct address_space *mapping;
 	struct page *page = vmf->page;
 	bool dirtied;
@@ -2801,7 +2801,7 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
 static inline void wp_page_reuse(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page = vmf->page;
 	pte_t entry;
 	/*
@@ -2812,11 +2812,11 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	if (page)
 		page_cpupid_xchg_last(page, (1 << LAST_CPUPID_SHIFT) - 1);
 
-	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
+	flush_cache_page(vma, vmf->info.address, pte_pfn(vmf->orig_pte));
 	entry = pte_mkyoung(vmf->orig_pte);
 	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
-	if (ptep_set_access_flags(vma, vmf->address, vmf->pte, entry, 1))
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+	if (ptep_set_access_flags(vma, vmf->info.address, vmf->pte, entry, 1))
+		update_mmu_cache(vma, vmf->info.address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	count_vm_event(PGREUSE);
 }
@@ -2839,7 +2839,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
  */
 static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct mm_struct *mm = vma->vm_mm;
 	struct page *old_page = vmf->page;
 	struct page *new_page = NULL;
@@ -2852,12 +2852,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 
 	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
 		new_page = alloc_zeroed_user_highpage_movable(vma,
-							      vmf->address);
+							      vmf->info.address);
 		if (!new_page)
 			goto oom;
 	} else {
 		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
-				vmf->address);
+				vmf->info.address);
 		if (!new_page)
 			goto oom;
 
@@ -2882,14 +2882,15 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	__SetPageUptodate(new_page);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
-				vmf->address & PAGE_MASK,
-				(vmf->address & PAGE_MASK) + PAGE_SIZE);
+				vmf->info.address & PAGE_MASK,
+				(vmf->info.address & PAGE_MASK) + PAGE_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 
 	/*
 	 * Re-check the pte - we dropped the lock
 	 */
-	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
+	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->info.address,
+				       &vmf->ptl);
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_page) {
 			if (!PageAnon(old_page)) {
@@ -2900,7 +2901,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		} else {
 			inc_mm_counter_fast(mm, MM_ANONPAGES);
 		}
-		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
+		flush_cache_page(vma, vmf->info.address,
+				 pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
@@ -2912,16 +2914,17 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * that left a window where the new PTE could be loaded into
 		 * some TLBs while the old PTE remains in others.
 		 */
-		ptep_clear_flush_notify(vma, vmf->address, vmf->pte);
-		page_add_new_anon_rmap(new_page, vma, vmf->address, false);
+		ptep_clear_flush_notify(vma, vmf->info.address, vmf->pte);
+		page_add_new_anon_rmap(new_page, vma, vmf->info.address,
+				       false);
 		lru_cache_add_inactive_or_unevictable(new_page, vma);
 		/*
 		 * We call the notify macro here because, when using secondary
 		 * mmu page tables (such as kvm shadow page tables), we want the
 		 * new page to be mapped directly into the secondary page table.
 		 */
-		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		set_pte_at_notify(mm, vmf->info.address, vmf->pte, entry);
+		update_mmu_cache(vma, vmf->info.address, vmf->pte);
 		if (old_page) {
 			/*
 			 * Only after switching the pte to the new page may
@@ -2952,7 +2955,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		new_page = old_page;
 		page_copied = 1;
 	} else {
-		update_mmu_tlb(vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vma, vmf->info.address, vmf->pte);
 	}
 
 	if (new_page)
@@ -3004,15 +3007,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
  */
 vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
 {
-	WARN_ON_ONCE(!(vmf->vma->vm_flags & VM_SHARED));
-	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address,
+	WARN_ON_ONCE(!(vmf->info.vma->vm_flags & VM_SHARED));
+	vmf->pte = pte_offset_map_lock(vmf->info.vma->vm_mm, vmf->pmd,
+				       vmf->info.address,
 				       &vmf->ptl);
 	/*
 	 * We might have raced with another page fault while we released the
 	 * pte_offset_map_lock.
 	 */
 	if (!pte_same(*vmf->pte, vmf->orig_pte)) {
-		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vmf->info.vma, vmf->info.address, vmf->pte);
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return VM_FAULT_NOPAGE;
 	}
@@ -3026,7 +3030,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf)
  */
 static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 
 	if (vma->vm_ops && vma->vm_ops->pfn_mkwrite) {
 		vm_fault_t ret;
@@ -3045,7 +3049,7 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	vm_fault_t ret = VM_FAULT_WRITE;
 
 	get_page(vmf->page);
@@ -3097,14 +3101,14 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 
 	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
 
-	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
+	vmf->page = vm_normal_page(vma, vmf->info.address, vmf->orig_pte);
 	if (!vmf->page) {
 		/*
 		 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
@@ -3265,7 +3269,7 @@ EXPORT_SYMBOL(unmap_mapping_range);
  */
 vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page = NULL, *swapcache;
 	swp_entry_t entry;
 	pte_t pte;
@@ -3281,14 +3285,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
-					     vmf->address);
+					     vmf->info.address);
 		} else if (is_device_private_entry(entry)) {
 			vmf->page = device_private_entry_to_page(entry);
 			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
 		} else {
-			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
+			print_bad_pte(vma, vmf->info.address, vmf->orig_pte,
+				      NULL);
 			ret = VM_FAULT_SIGBUS;
 		}
 		goto out;
@@ -3296,7 +3301,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 
 	delayacct_set_flag(DELAYACCT_PF_SWAPIN);
-	page = lookup_swap_cache(entry, vma, vmf->address);
+	page = lookup_swap_cache(entry, vma, vmf->info.address);
 	swapcache = page;
 
 	if (!page) {
@@ -3306,7 +3311,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
 			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
-							vmf->address);
+							vmf->info.address);
 			if (page) {
 				int err;
 
@@ -3343,7 +3348,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 * while we released the pte lock.
 			 */
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
+					vmf->info.address, &vmf->ptl);
 			if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 				ret = VM_FAULT_OOM;
 			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
@@ -3382,7 +3387,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			page_private(page) != entry.val)) && swapcache)
 		goto out_page;
 
-	page = ksm_might_need_to_copy(page, vma, vmf->address);
+	page = ksm_might_need_to_copy(page, vma, vmf->info.address);
 	if (unlikely(!page)) {
 		ret = VM_FAULT_OOM;
 		page = swapcache;
@@ -3394,8 +3399,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	/*
 	 * Back out if somebody else already faulted in this pte.
 	 */
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->info.address,
+				       &vmf->ptl);
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
 		goto out_nomap;
 
@@ -3430,16 +3436,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte = pte_mkuffd_wp(pte);
 		pte = pte_wrprotect(pte);
 	}
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+	set_pte_at(vma->vm_mm, vmf->info.address, vmf->pte, pte);
+	arch_do_swap_page(vma->vm_mm, vma, vmf->info.address, pte,
+			  vmf->orig_pte);
 	vmf->orig_pte = pte;
 
 	/* ksm created a completely new copy */
 	if (unlikely(page != swapcache && swapcache)) {
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->info.address, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
-		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
+		do_page_add_anon_rmap(page, vma, vmf->info.address, exclusive);
 	}
 
 	swap_free(entry);
@@ -3468,7 +3475,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	update_mmu_cache(vma, vmf->info.address, vmf->pte);
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
@@ -3493,7 +3500,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
  */
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page;
 	vm_fault_t ret = 0;
 	pte_t entry;
@@ -3522,12 +3529,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Use the zero-page for reads */
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm)) {
-		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
+		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->info.address),
 						vma->vm_page_prot));
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				vmf->address, &vmf->ptl);
+				vmf->info.address, &vmf->ptl);
 		if (!pte_none(*vmf->pte)) {
-			update_mmu_tlb(vma, vmf->address, vmf->pte);
+			update_mmu_tlb(vma, vmf->info.address, vmf->pte);
 			goto unlock;
 		}
 		ret = check_stable_address_space(vma->vm_mm);
@@ -3544,7 +3551,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	/* Allocate our own private page. */
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
-	page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
+	page = alloc_zeroed_user_highpage_movable(vma, vmf->info.address);
 	if (!page)
 		goto oom;
 
@@ -3564,10 +3571,11 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (vma->vm_flags & VM_WRITE)
 		entry = pte_mkwrite(pte_mkdirty(entry));
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				       vmf->info.address,
+				       &vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_cache(vma, vmf->info.address, vmf->pte);
 		goto release;
 	}
 
@@ -3583,13 +3591,13 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	}
 
 	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-	page_add_new_anon_rmap(page, vma, vmf->address, false);
+	page_add_new_anon_rmap(page, vma, vmf->info.address, false);
 	lru_cache_add_inactive_or_unevictable(page, vma);
 setpte:
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+	set_pte_at(vma->vm_mm, vmf->info.address, vmf->pte, entry);
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	update_mmu_cache(vma, vmf->info.address, vmf->pte);
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
@@ -3609,7 +3617,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
  */
 static vm_fault_t __do_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	vm_fault_t ret;
 
 	/*
@@ -3658,7 +3666,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void deposit_prealloc_pte(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 
 	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, vmf->prealloc_pte);
 	/*
@@ -3671,9 +3679,9 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	unsigned long haddr = vmf->info.address & HPAGE_PMD_MASK;
 	pmd_t entry;
 	int i;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
@@ -3735,7 +3743,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 
 void do_set_pte(struct vm_fault *vmf, struct page *page)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->flags & FAULT_FLAG_PREFAULT;
 	pte_t entry;
@@ -3753,13 +3761,13 @@ void do_set_pte(struct vm_fault *vmf, struct page *page)
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
-		page_add_new_anon_rmap(page, vma, vmf->address, false);
+		page_add_new_anon_rmap(page, vma, vmf->info.address, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
 	}
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
+	set_pte_at(vma->vm_mm, vmf->info.address, vmf->pte, entry);
 }
 
 /**
@@ -3779,7 +3787,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page)
  */
 vm_fault_t finish_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page;
 	vm_fault_t ret;
 
@@ -3815,7 +3823,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		return 0;
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				      vmf->address, &vmf->ptl);
+				      vmf->info.address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
 	if (likely(pte_none(*vmf->pte)))
@@ -3823,7 +3831,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	else
 		ret = VM_FAULT_NOPAGE;
 
-	update_mmu_tlb(vma, vmf->address, vmf->pte);
+	update_mmu_tlb(vma, vmf->info.address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
 }
@@ -3890,16 +3898,16 @@ late_initcall(fault_around_debugfs);
  */
 static vm_fault_t do_fault_around(struct vm_fault *vmf)
 {
-	unsigned long address = vmf->address, nr_pages, mask;
-	pgoff_t start_pgoff = vmf->pgoff;
+	unsigned long address = vmf->info.address, nr_pages, mask;
+	pgoff_t start_pgoff = vmf->info.pgoff;
 	pgoff_t end_pgoff;
 	int off;
 
 	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
 	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
 
-	address = max(address & mask, vmf->vma->vm_start);
-	off = ((vmf->address - address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
+	address = max(address & mask, vmf->info.vma->vm_start);
+	off = ((vmf->info.address - address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
 	start_pgoff -= off;
 
 	/*
@@ -3909,22 +3917,23 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	end_pgoff = start_pgoff -
 		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)) +
 		PTRS_PER_PTE - 1;
-	end_pgoff = min3(end_pgoff, vma_pages(vmf->vma) + vmf->vma->vm_pgoff - 1,
-			start_pgoff + nr_pages - 1);
+	end_pgoff = min3(end_pgoff,
+			 vma_pages(vmf->info.vma) + vmf->info.vma->vm_pgoff - 1,
+			 start_pgoff + nr_pages - 1);
 
 	if (pmd_none(*vmf->pmd)) {
-		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
+		vmf->prealloc_pte = pte_alloc_one(vmf->info.vma->vm_mm);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 		smp_wmb(); /* See comment in __pte_alloc() */
 	}
 
-	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
+	return vmf->info.vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
 }
 
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	vm_fault_t ret = 0;
 
 	/*
@@ -3951,13 +3960,14 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 
 static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	vm_fault_t ret;
 
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
 
-	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
+	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
+				       vmf->info.address);
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
@@ -3973,7 +3983,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (ret & VM_FAULT_DONE_COW)
 		return ret;
 
-	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
+	copy_user_highpage(vmf->cow_page, vmf->page, vmf->info.address, vma);
 	__SetPageUptodate(vmf->cow_page);
 
 	ret |= finish_fault(vmf);
@@ -3989,7 +3999,7 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 
 static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	vm_fault_t ret, tmp;
 
 	ret = __do_fault(vmf);
@@ -4032,7 +4042,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
  */
 static vm_fault_t do_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct mm_struct *vm_mm = vma->vm_mm;
 	vm_fault_t ret;
 
@@ -4047,9 +4057,9 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
 		if (unlikely(!pmd_present(*vmf->pmd)))
 			ret = VM_FAULT_SIGBUS;
 		else {
-			vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm,
+			vmf->pte = pte_offset_map_lock(vmf->info.vma->vm_mm,
 						       vmf->pmd,
-						       vmf->address,
+						       vmf->info.address,
 						       &vmf->ptl);
 			/*
 			 * Make sure this is not a temporary clearing of pte
@@ -4097,7 +4107,7 @@ static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page = NULL;
 	int page_nid = NUMA_NO_NODE;
 	int last_cpupid;
@@ -4123,15 +4133,16 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Make it present again, Depending on how arch implementes non
 	 * accessible ptes, some can allow access by kernel mode.
 	 */
-	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	old_pte = ptep_modify_prot_start(vma, vmf->info.address, vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (was_writable)
 		pte = pte_mkwrite(pte);
-	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	ptep_modify_prot_commit(vma, vmf->info.address, vmf->pte, old_pte,
+				pte);
+	update_mmu_cache(vma, vmf->info.address, vmf->pte);
 
-	page = vm_normal_page(vma, vmf->address, pte);
+	page = vm_normal_page(vma, vmf->info.address, pte);
 	if (!page) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return 0;
@@ -4163,8 +4174,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	last_cpupid = page_cpupid_last(page);
 	page_nid = page_to_nid(page);
-	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
-			&flags);
+	target_nid = numa_migrate_prep(page, vma, vmf->info.address, page_nid,
+				       &flags);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	if (target_nid == NUMA_NO_NODE) {
 		put_page(page);
@@ -4187,30 +4198,31 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 {
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_anonymous(vmf->info.vma))
 		return do_huge_pmd_anonymous_page(vmf);
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+	if (vmf->info.vma->vm_ops->huge_fault)
+		return vmf->info.vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
 	return VM_FAULT_FALLBACK;
 }
 
 /* `inline' is required to avoid gcc 4.1.2 build error */
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
-	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
+	if (vma_is_anonymous(vmf->info.vma)) {
+		if (userfaultfd_huge_pmd_wp(vmf->info.vma, orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
 	}
-	if (vmf->vma->vm_ops->huge_fault) {
-		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+	if (vmf->info.vma->vm_ops->huge_fault) {
+		vm_fault_t ret = vmf->info.vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
 
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	}
 
 	/* COW or write-notify handled on pte level: split pmd. */
-	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
+	__split_huge_pmd(vmf->info.vma, vmf->pmd, vmf->info.address, false,
+			 NULL);
 
 	return VM_FAULT_FALLBACK;
 }
@@ -4220,17 +4232,17 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) &&			\
 	defined(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 	/* No support for anonymous transparent PUD pages yet */
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_anonymous(vmf->info.vma))
 		goto split;
-	if (vmf->vma->vm_ops->huge_fault) {
-		vm_fault_t ret = vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+	if (vmf->info.vma->vm_ops->huge_fault) {
+		vm_fault_t ret = vmf->info.vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
 
 		if (!(ret & VM_FAULT_FALLBACK))
 			return ret;
 	}
 split:
 	/* COW or write-notify not handled on PUD level: split pud.*/
-	__split_huge_pud(vmf->vma, vmf->pud, vmf->address);
+	__split_huge_pud(vmf->info.vma, vmf->pud, vmf->info.address);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
@@ -4239,10 +4251,10 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* No support for anonymous transparent PUD pages yet */
-	if (vma_is_anonymous(vmf->vma))
+	if (vma_is_anonymous(vmf->info.vma))
 		return VM_FAULT_FALLBACK;
-	if (vmf->vma->vm_ops->huge_fault)
-		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+	if (vmf->info.vma->vm_ops->huge_fault)
+		return vmf->info.vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
@@ -4295,7 +4307,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * mmap_lock read mode and khugepaged takes it in write mode.
 		 * So now it's safe to run pte_offset_map().
 		 */
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		vmf->pte = pte_offset_map(vmf->pmd, vmf->info.address);
 		vmf->orig_pte = *vmf->pte;
 
 		/*
@@ -4314,7 +4326,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	}
 
 	if (!vmf->pte) {
-		if (vma_is_anonymous(vmf->vma))
+		if (vma_is_anonymous(vmf->info.vma))
 			return do_anonymous_page(vmf);
 		else
 			return do_fault(vmf);
@@ -4323,14 +4335,14 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->info.vma))
 		return do_numa_page(vmf);
 
-	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+	vmf->ptl = pte_lockptr(vmf->info.vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
 	if (unlikely(!pte_same(*vmf->pte, entry))) {
-		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vmf->info.vma, vmf->info.address, vmf->pte);
 		goto unlock;
 	}
 	if (vmf->flags & FAULT_FLAG_WRITE) {
@@ -4339,9 +4351,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
-				vmf->flags & FAULT_FLAG_WRITE)) {
-		update_mmu_cache(vmf->vma, vmf->address, vmf->pte);
+	if (ptep_set_access_flags(vmf->info.vma, vmf->info.address, vmf->pte, entry,
+				  vmf->flags & FAULT_FLAG_WRITE)) {
+		update_mmu_cache(vmf->info.vma, vmf->info.address, vmf->pte);
 	} else {
 		/* Skip spurious TLB flush for retried page fault */
 		if (vmf->flags & FAULT_FLAG_TRIED)
@@ -4353,7 +4365,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * with threads.
 		 */
 		if (vmf->flags & FAULT_FLAG_WRITE)
-			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address);
+			flush_tlb_fix_spurious_fault(vmf->info.vma,
+						     vmf->info.address);
 	}
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4370,11 +4383,13 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		unsigned long address, unsigned int flags)
 {
 	struct vm_fault vmf = {
-		.vma = vma,
-		.address = address & PAGE_MASK,
+		.info = {
+			.vma = vma,
+			.address = address & PAGE_MASK,
+			.pgoff = linear_page_index(vma, address),
+			.gfp_mask = __get_fault_gfp_mask(vma),
+		},
 		.flags = flags,
-		.pgoff = linear_page_index(vma, address),
-		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
 	unsigned int dirty = flags & FAULT_FLAG_WRITE;
 	struct mm_struct *mm = vma->vm_mm;
diff --git a/mm/mmap.c b/mm/mmap.c
index dc7206032387..826ab533358e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3450,7 +3450,7 @@ static const struct vm_operations_struct legacy_special_mapping_vmops = {
 
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	pgoff_t pgoff;
 	struct page **pages;
 
@@ -3460,12 +3460,12 @@ static vm_fault_t special_mapping_fault(struct vm_fault *vmf)
 		struct vm_special_mapping *sm = vma->vm_private_data;
 
 		if (sm->fault)
-			return sm->fault(sm, vmf->vma, vmf);
+			return sm->fault(sm, vmf->info.vma, vmf);
 
 		pages = sm->pages;
 	}
 
-	for (pgoff = vmf->pgoff; pgoff && *pages; ++pages)
+	for (pgoff = vmf->info.pgoff; pgoff && *pages; ++pages)
 		pgoff--;
 
 	if (*pages) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 7c6b6d8f6c39..6831d662fe01 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1523,8 +1523,8 @@ static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
 	struct vm_fault vmf;
 
 	shmem_pseudo_vma_init(&pvma, info, index);
-	vmf.vma = &pvma;
-	vmf.address = 0;
+	vmf.info.vma = &pvma;
+	vmf.info.address = 0;
 	page = swap_cluster_readahead(swap, gfp, &vmf);
 	shmem_pseudo_vma_destroy(&pvma);
 
@@ -2037,7 +2037,7 @@ static int synchronous_wake_function(wait_queue_entry_t *wait, unsigned mode, in
 
 static vm_fault_t shmem_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
 	enum sgp_type sgp;
@@ -2068,8 +2068,8 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 		shmem_falloc = inode->i_private;
 		if (shmem_falloc &&
 		    shmem_falloc->waitq &&
-		    vmf->pgoff >= shmem_falloc->start &&
-		    vmf->pgoff < shmem_falloc->next) {
+		    vmf->info.pgoff >= shmem_falloc->start &&
+		    vmf->info.pgoff < shmem_falloc->next) {
 			struct file *fpin;
 			wait_queue_head_t *shmem_falloc_waitq;
 			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
@@ -2111,7 +2111,7 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	else if (vma->vm_flags & VM_HUGEPAGE)
 		sgp = SGP_HUGE;
 
-	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, sgp,
+	err = shmem_getpage_gfp(inode, vmf->info.pgoff, &vmf->page, sgp,
 				  gfp, vma, vmf, &ret);
 	if (err)
 		return vmf_error(err);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 751c1ef2fe0e..2675ccc46b2f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -644,7 +644,7 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * This has been extended to use the NUMA policies from the mm triggering
  * the readahead.
  *
- * Caller must hold read mmap_lock if vmf->vma is not NULL.
+ * Caller must hold read mmap_lock if vmf->info.vma is not NULL.
  */
 struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				struct vm_fault *vmf)
@@ -657,8 +657,8 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
 	bool do_poll = true, page_allocated;
-	struct vm_area_struct *vma = vmf->vma;
-	unsigned long addr = vmf->address;
+	struct vm_area_struct *vma = vmf->info.vma;
+	unsigned long addr = vmf->info.address;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
@@ -750,7 +750,7 @@ static inline void swap_ra_clamp_pfn(struct vm_area_struct *vma,
 static void swap_ra_info(struct vm_fault *vmf,
 			struct vma_swap_readahead *ra_info)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	unsigned long ra_val;
 	swp_entry_t entry;
 	unsigned long faddr, pfn, fpfn;
@@ -768,7 +768,7 @@ static void swap_ra_info(struct vm_fault *vmf,
 		return;
 	}
 
-	faddr = vmf->address;
+	faddr = vmf->info.address;
 	orig_pte = pte = pte_offset_map(vmf->pmd, faddr);
 	entry = pte_to_swp_entry(*pte);
 	if ((unlikely(non_swap_entry(entry)))) {
@@ -826,14 +826,14 @@ static void swap_ra_info(struct vm_fault *vmf,
  * Primitive swap readahead code. We simply read in a few pages whoes
  * virtual addresses are around the fault address in the same vma.
  *
- * Caller must hold read mmap_lock if vmf->vma is not NULL.
+ * Caller must hold read mmap_lock if vmf->info.vma is not NULL.
  *
  */
 static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 				       struct vm_fault *vmf)
 {
 	struct blk_plug plug;
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct page *page;
 	pte_t *pte, pentry;
 	swp_entry_t entry;
@@ -859,7 +859,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		if (unlikely(non_swap_entry(entry)))
 			continue;
 		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       vmf->address, &page_allocated);
+					       vmf->info.address,
+					       &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -874,7 +875,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	blk_finish_plug(&plug);
 	lru_add_drain();
 skip:
-	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
+	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->info.address,
 				     ra_info.win == 1);
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9fffc5af29d1..96ac0725feff 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1968,8 +1968,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		swap_map = &si->swap_map[offset];
 		page = lookup_swap_cache(entry, vma, addr);
 		if (!page) {
-			vmf.vma = vma;
-			vmf.address = addr;
+			vmf.info.vma = vma;
+			vmf.info.address = addr;
 			vmf.pmd = pmd;
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						&vmf);
diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index e03068917273..6c2bf5f8e73f 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -747,9 +747,9 @@ static void mbochs_put_pages(struct mdev_state *mdev_state)
 
 static vm_fault_t mbochs_region_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct mdev_state *mdev_state = vma->vm_private_data;
-	pgoff_t page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
+	pgoff_t page_offset = (vmf->info.address - vma->vm_start) >> PAGE_SHIFT;
 
 	if (page_offset >= mdev_state->pagecount)
 		return VM_FAULT_SIGBUS;
@@ -785,13 +785,13 @@ static int mbochs_mmap(struct mdev_device *mdev, struct vm_area_struct *vma)
 
 static vm_fault_t mbochs_dmabuf_vm_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	struct vm_area_struct *vma = vmf->info.vma;
 	struct mbochs_dmabuf *dmabuf = vma->vm_private_data;
 
-	if (WARN_ON(vmf->pgoff >= dmabuf->pagecount))
+	if (WARN_ON(vmf->info.pgoff >= dmabuf->pagecount))
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = dmabuf->pages[vmf->pgoff];
+	vmf->page = dmabuf->pages[vmf->info.pgoff];
 	get_page(vmf->page);
 	return 0;
 }
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4bde570d56a2..d422b7a2d946 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -473,14 +473,14 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 
 static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
 {
-	struct policy_load_memory *plm = vmf->vma->vm_file->private_data;
+	struct policy_load_memory *plm = vmf->info.vma->vm_file->private_data;
 	unsigned long offset;
 	struct page *page;
 
 	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
 		return VM_FAULT_SIGBUS;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	if (offset >= roundup(plm->len, PAGE_SIZE))
 		return VM_FAULT_SIGBUS;
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9f3f8e953ff0..d43de9aa2eeb 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3525,7 +3525,7 @@ static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
  */
 static vm_fault_t snd_pcm_mmap_status_fault(struct vm_fault *vmf)
 {
-	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
+	struct snd_pcm_substream *substream = vmf->info.vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
 	
 	if (substream == NULL)
@@ -3561,7 +3561,7 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
  */
 static vm_fault_t snd_pcm_mmap_control_fault(struct vm_fault *vmf)
 {
-	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
+	struct snd_pcm_substream *substream = vmf->info.vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
 	
 	if (substream == NULL)
@@ -3659,7 +3659,7 @@ snd_pcm_default_page_ops(struct snd_pcm_substream *substream, unsigned long ofs)
  */
 static vm_fault_t snd_pcm_mmap_data_fault(struct vm_fault *vmf)
 {
-	struct snd_pcm_substream *substream = vmf->vma->vm_private_data;
+	struct snd_pcm_substream *substream = vmf->info.vma->vm_private_data;
 	struct snd_pcm_runtime *runtime;
 	unsigned long offset;
 	struct page * page;
@@ -3668,7 +3668,7 @@ static vm_fault_t snd_pcm_mmap_data_fault(struct vm_fault *vmf)
 	if (substream == NULL)
 		return VM_FAULT_SIGBUS;
 	runtime = substream->runtime;
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
 	if (offset > dma_bytes - PAGE_SIZE)
 		return VM_FAULT_SIGBUS;
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 6e1bfe894dd5..5a9a631f004e 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -104,7 +104,7 @@ static vm_fault_t usb_stream_hwdep_vm_fault(struct vm_fault *vmf)
 	unsigned long offset;
 	struct page *page;
 	void *vaddr;
-	struct us122l *us122l = vmf->vma->vm_private_data;
+	struct us122l *us122l = vmf->info.vma->vm_private_data;
 	struct usb_stream *s;
 
 	mutex_lock(&us122l->mutex);
@@ -112,7 +112,7 @@ static vm_fault_t usb_stream_hwdep_vm_fault(struct vm_fault *vmf)
 	if (!s)
 		goto unlock;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
 	if (offset < PAGE_ALIGN(s->read_size))
 		vaddr = (char *)s + offset;
 	else {
diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 22412cd69e98..bb198d69b6d5 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -25,11 +25,11 @@ static vm_fault_t snd_us428ctls_vm_fault(struct vm_fault *vmf)
 	void *vaddr;
 
 	snd_printdd("ENTER, start %lXh, pgoff %ld\n",
-		   vmf->vma->vm_start,
-		   vmf->pgoff);
+		   vmf->info.vma->vm_start,
+		   vmf->info.pgoff);
 	
-	offset = vmf->pgoff << PAGE_SHIFT;
-	vaddr = (char *)((struct usX2Ydev *)vmf->vma->vm_private_data)->us428ctls_sharedmem + offset;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
+	vaddr = (char *)((struct usX2Ydev *) vmf->info.vma->vm_private_data)->us428ctls_sharedmem + offset;
 	page = virt_to_page(vaddr);
 	get_page(page);
 	vmf->page = page;
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 8253669c6a7d..96ed23af6355 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -646,8 +646,8 @@ static vm_fault_t snd_usX2Y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
 	unsigned long offset;
 	void *vaddr;
 
-	offset = vmf->pgoff << PAGE_SHIFT;
-	vaddr = (char *)((struct usX2Ydev *)vmf->vma->vm_private_data)->hwdep_pcm_shm + offset;
+	offset = vmf->info.pgoff << PAGE_SHIFT;
+	vaddr = (char *)((struct usX2Ydev *) vmf->info.vma->vm_private_data)->hwdep_pcm_shm + offset;
 	vmf->page = virt_to_page(vaddr);
 	get_page(vmf->page);
 	return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fa9e3614d30e..584319d448b1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3037,23 +3037,23 @@ static bool kvm_page_in_dirty_ring(struct kvm *kvm, unsigned long pgoff)
 
 static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 {
-	struct kvm_vcpu *vcpu = vmf->vma->vm_file->private_data;
+	struct kvm_vcpu *vcpu = vmf->info.vma->vm_file->private_data;
 	struct page *page;
 
-	if (vmf->pgoff == 0)
+	if (vmf->info.pgoff == 0)
 		page = virt_to_page(vcpu->run);
 #ifdef CONFIG_X86
-	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
+	else if (vmf->info.pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
 #ifdef CONFIG_KVM_MMIO
-	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
+	else if (vmf->info.pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
-	else if (kvm_page_in_dirty_ring(vcpu->kvm, vmf->pgoff))
+	else if (kvm_page_in_dirty_ring(vcpu->kvm, vmf->info.pgoff))
 		page = kvm_dirty_ring_get_page(
 		    &vcpu->dirty_ring,
-		    vmf->pgoff - KVM_DIRTY_LOG_PAGE_OFFSET);
+		    vmf->info.pgoff - KVM_DIRTY_LOG_PAGE_OFFSET);
 	else
 		return kvm_arch_vcpu_fault(vcpu, vmf);
 	get_page(page);
-- 
2.30.0.284.gd98b1dd5eaa7-goog


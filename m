Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400CE2F68B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbhANSB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbhANSB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:01:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8631A23B54;
        Thu, 14 Jan 2021 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610647243;
        bh=G3ARswVyqp23HZWDNA9hDqr3zRmuJAHlm2iWSEqrmWg=;
        h=From:To:Cc:Subject:Date:From;
        b=i5iosR+wUNY1CTBNSdAnMM6JSYTxumiNwGv8gudF0Pp5CnikJZDGQJFdMzQlYwV5t
         hRruhhi6M82xR1UIJ8oHjI/kL0um5NLNV0ZJ1zAlkPz5OAn7ZyMyaEg9ezT1BolZx3
         7PggPcRyicD8H/fGsqjIcoXXjuOKZ9oA+Jj78sjZDuD4RXV4vK+TQ0t4ChNBFHRNbp
         GyXHhdU7zc+HDkxRPbwLCXcSawPPLI4SW0MNhy8JNRrSLCAkG4QKPcxN92rHYe9wcy
         O7hwO4YlhORADMBQIBXI4u+8wbbGXz7AQfIW8rGWOSVlyydK5lUCiZMD47QUaVbsUF
         HHkw5+tF+L7ug==
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
Subject: [PATCH v3 0/8] Create 'old' ptes for faultaround mappings on arm64 with hardware access flag
Date:   Thu, 14 Jan 2021 17:59:26 +0000
Message-Id: <20210114175934.13070-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again folks,

This is the third version of the patches I previously posted here:

  v1: https://lore.kernel.org/r/20201209163950.8494-1-will@kernel.org
  v2: https://lore.kernel.org/r/20210108171517.5290-1-will@kernel.org

The patches allow architectures to opt-in at runtime for faultaround
mappings to be created as 'old' instead of 'young'. Although there have
been previous attempts at this, they failed either because the decision
was deferred to userspace [1] or because it was done unconditionally and
shown to regress benchmarks for particular architectures [2].

Minor changes since v2 include:

  * Update commit messages
  * Remove repeated word 'from from' in a comment
  * Restore 'vmf->flags' in filemap_map_pages()

The major additions are in the five RFC patches at the end of the
series, which attempt to implement a suggestion from Linus to split up
'struct vm_fault', clearly separating the mutable and immutable fields
in the data structure. I used Coccinelle to do most of the mechanical
work, but I also ran into some tricky problems along the way:

1. 'vmf->flags' is modified on the '->page_mkwrite()' path so I couldn't
   find a satisfactory way to move it to the new const structure. I toyed
   with getting rid of FAULT_FLAG_[MK]WRITE completely and just tracking
   these as bools, but there's also a weird piece of code in
   vmw_bo_vm_mkwrite() which modifies FAULT_FLAG_ALLOW_RETRY, so I gave
   up and left the 'flags' field alone.

2. I had to perform terrifying surgery on __collapse_huge_page_swapin()
   and, in doing so, I'm a bit wary about the initialisation of 'pgoff',
   as it isn't updated along with the address (this matches the old code).

3. vmf_insert_pfn_pmd() and friends take both a 'struct vm_fault' _and_
   a 'bool write'. I have left them alone, but that FAULT_FLAG_WRITE is
   causing trouble again.

4. Turns out 'struct vm_fault' is popular, so the diffstat is bloody
   massive.

Anyway, be good to hear any thoughts on this lot, particular with regards
to my comments above. I've also pushed the series here:

  https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=faultaround

Cheers

Will

[1] https://www.spinics.net/lists/linux-mm/msg143831.html
[2] 315d09bf30c2 ("Revert "mm: make faultaround produce old ptes"")

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vinayak Menon <vinmenon@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: <kernel-team@android.com>

--->8

Kirill A. Shutemov (1):
  mm: Cleanup faultaround and finish_fault() codepaths

Will Deacon (7):
  mm: Allow architectures to request 'old' entries when prefaulting
  arm64: mm: Implement arch_wants_old_prefaulted_pte()
  mm: Separate fault info out of 'struct vm_fault'
  mm: Pass 'address' to map to do_set_pte() and drop FAULT_FLAG_PREFAULT
  mm: Avoid modifying vmf.info.address in __collapse_huge_page_swapin()
  mm: Use static initialisers for 'info' field of 'struct vm_fault'
  mm: Mark 'info' field of 'struct vm_fault' as 'const'

 arch/arm64/include/asm/pgtable.h           |  12 +-
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
 drivers/dax/device.c                       |  37 +-
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
 fs/dax.c                                   |  53 +--
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
 fs/xfs/xfs_file.c                          |  18 +-
 fs/zonefs/super.c                          |   6 +-
 include/linux/huge_mm.h                    |   6 +-
 include/linux/mm.h                         |  21 +-
 include/linux/pgtable.h                    |  11 +
 include/trace/events/fs_dax.h              |  28 +-
 ipc/shm.c                                  |   2 +-
 kernel/events/core.c                       |  12 +-
 kernel/relay.c                             |   4 +-
 lib/test_hmm.c                             |   4 +-
 mm/filemap.c                               | 208 +++++++---
 mm/huge_memory.c                           |  57 +--
 mm/hugetlb.c                               |   6 +-
 mm/internal.h                              |   4 +-
 mm/khugepaged.c                            |  39 +-
 mm/memory.c                                | 452 +++++++++------------
 mm/mmap.c                                  |   6 +-
 mm/shmem.c                                 |  16 +-
 mm/swap_state.c                            |  19 +-
 mm/swapfile.c                              |  13 +-
 samples/vfio-mdev/mbochs.c                 |  10 +-
 security/selinux/selinuxfs.c               |   4 +-
 sound/core/pcm_native.c                    |   8 +-
 sound/usb/usx2y/us122l.c                   |   4 +-
 sound/usb/usx2y/usX2Yhwdep.c               |   8 +-
 sound/usb/usx2y/usx2yhwdeppcm.c            |   4 +-
 virt/kvm/kvm_main.c                        |  12 +-
 104 files changed, 821 insertions(+), 730 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog


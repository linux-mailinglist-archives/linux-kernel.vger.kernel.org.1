Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785E31A8FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 02:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634607AbgDOAoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 20:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407887AbgDOAn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:43:58 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F9EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:43:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t17so1390010plo.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IRAOmpUvzzA7bc0bIQpN0DCM6X43FqUQgTM1nsdyGUs=;
        b=ao9yIhLkGUh3Km8WkoKAEeuPTP9tXLALooA+3FGMyxmrZo39dvAZORhYU2+/4xjBHm
         HXr1QAsGlxkVtNy/yda3SMwFGmFtlLQE1M76h/V1Mxr4a2u7FNwxkutkUhe0oJl5oFhK
         uz3X4bZ01znYIpGQK3miKw2xvFxbAfs+Mh5Y0uIFSADWMrukxgkVSdyxtyAuBubJ+hwH
         t+VUsNb2Osy8XQqBOFqmtvjpZWID4pMKl47Kt64dJif0tBVLsKeY/jZ+p7FGZDxNUN23
         mMszxsGpJV04HqIpr5xvQpgXqP94Pb6liaRWGo1Dc18RyBH+QC2+AciY2jPrrYfEmRZT
         cwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IRAOmpUvzzA7bc0bIQpN0DCM6X43FqUQgTM1nsdyGUs=;
        b=Uj4emmwoeNteiPWryQtsdTepNwLa18O4hgc0txSOnaLnK8Fhhk+U1J0DtB4iB/mW4G
         t8k72tW44dWDdHWn5ZaXcsUQKPTdrukoeiIejEmH3FRe1lwyzsj/Mj9A4CZsLAI0wKoP
         KhdTCMSnUA+Grqay5Qy7XGgBAeIGPSonUQhj1tNtCZhxTacLJlxOtbs3QcRk+b9mNzl5
         QjPVQEfi3TpW7rjNqu2kJrqZKLWnZtJKsN3DcEg4I/NA7ImcYrdZuwoMXPbBPMNWr8vP
         EV6gXOT3FSkWbltABV/n8OqW+sIzap1gIuBvimP3g4LfOiqIndwzPE9GBpb5QoFQDV4a
         VsMg==
X-Gm-Message-State: AGi0PuYmIGeP0rDE5pgtp3L88meukO57PpU5NMCXZE8SM/WxjsB8x6+8
        0ItFg4+loSeNkcK4BbTn4mPFaFVIJ3M=
X-Google-Smtp-Source: APiQypLUf0YYJmX+6MU7adXctu9WVXNaqyx42QHiYP/IVgCtWwLPW4WGLedobnCR22xziDhUSzok+bJ4JOE=
X-Received: by 2002:a17:90a:e515:: with SMTP id t21mr3016913pjy.123.1586911436045;
 Tue, 14 Apr 2020 17:43:56 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:43:43 -0700
Message-Id: <20200415004353.130248-1-walken@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v4 00/10] Add a new mmap locking API wrapping mmap_sem calls
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting this patch series on top of v5.7-rc1. I think this would be
a good time for the series to be picked up in -mm tree for integration
into v5.8. I also made minor changes to patches 6 and 7 based on
reviewer feedback on the previous revisions.


This patch series adds a new mmap locking API replacing the existing
mmap_sem lock and unlocks. Initially the API is just implemente in terms
of inlined rwsem calls, so it doesn't provide any new functionality.

There are two justifications for the new API:

- At first, it provides an easy hooking point to instrument mmap_sem
  locking latencies independently of any other rwsems.

- In the future, it may be a starting point for replacing the rwsem
  implementation with a different one, such as range locks. This is
  something that is being explored, even though there is no wide concensus
  about this possible direction yet.
  (see https://patchwork.kernel.org/cover/11401483/)


Changes since v3 of the patchset:

- The changes now apply on top of v5.7-rc1. This was a straight rebase
  except for changes noted here.

- Re-generated the coccinelle changes (patch 04/10).

- Patch 06/10: removed the mmap_write_unlock_nested API;
  mmap_write_lock_nested() calls now pair with the regular mmap_write_unlock()
  as was suggested by many people.

- Patch 07/10: removed the mmap_read_release API; this is replaced with
  mmap_read_trylock_non_owner() which pairs with mmap_read_unlock_non_owner()
  Thanks to Peter Zijlstra for the suggestion.


Changes since v2 of the patchset:

- Removed the mmap_is_locked API - v2 had removed all uses of it,
  but the actual function definition was still there unused.
  Thanks to Jason Gunthorpe for noticing the unused mmap_is_locked function.


Changes since v1 of the patchset:

- Manually convert drivers/dma-buf/dma-resv.c ahead of the automated
  coccinelle conversion as this file requires a new include statement.
  Thanks to Intel's kbuild test bot for finding the issue.

- In coccinelle automated conversion, apply a single coccinelle rule
  as suggested by Markus Elfring.

- In manual conversion of sites missed by coccinelle, fix an issue where
  I had used mm_read_unlock (from an older version of my patchset) instead
  of mmap_read_unlock in some arch/mips code.
  This was also identified by Intel's kbuild test bot.

- Do not add a new mmap_is_locked API, and use lockdep_assert_held instead.
  Thanks to Jason Gunthorpe and Matthew Wilcox for the suggestion.


The changes apply on top of v5.7-rc1.

I think these changes are ready for integration into the -mm tree now
(for integration into v5.8). The coccinelle part of the change is
relatively invasive, but can be skipped over on a file by file basis
if it causes any conflicts with other pending changes. The new mmap
locking API can interoperate with new code that is still using direct
rwsem calls, until the last patch in the series which renames mmap_sem
to enforce using the new API. Maybe that last patch could be delayed for
a bit, so that we'd get a chance to convert any new code that locks
mmap_sem in the -rc1 release before applying that last patch.


Michel Lespinasse (10):
  mmap locking API: initial implementation as rwsem wrappers
  MMU notifier: use the new mmap locking API
  DMA  reservations: use the new mmap locking API
  mmap locking API: use coccinelle to convert mmap_sem rwsem call sites
  mmap locking API: convert mmap_sem call sites missed by coccinelle
  mmap locking API: convert nested write lock sites
  mmap locking API: add mmap_read_trylock_non_owner()
  mmap locking API: add MMAP_LOCK_INITIALIZER
  mmap locking API: use lockdep_assert_held
  mmap locking API: rename mmap_sem to mmap_lock

 arch/alpha/kernel/traps.c                     |  4 +-
 arch/alpha/mm/fault.c                         | 10 +--
 arch/arc/kernel/process.c                     |  4 +-
 arch/arc/kernel/troubleshoot.c                |  4 +-
 arch/arc/mm/fault.c                           |  4 +-
 arch/arm/kernel/process.c                     |  4 +-
 arch/arm/kernel/swp_emulate.c                 |  4 +-
 arch/arm/lib/uaccess_with_memcpy.c            | 16 ++--
 arch/arm/mm/fault.c                           |  6 +-
 arch/arm64/kernel/traps.c                     |  4 +-
 arch/arm64/kernel/vdso.c                      |  8 +-
 arch/arm64/mm/fault.c                         |  8 +-
 arch/csky/kernel/vdso.c                       |  4 +-
 arch/csky/mm/fault.c                          |  8 +-
 arch/hexagon/kernel/vdso.c                    |  4 +-
 arch/hexagon/mm/vm_fault.c                    |  8 +-
 arch/ia64/kernel/perfmon.c                    |  8 +-
 arch/ia64/mm/fault.c                          | 12 +--
 arch/ia64/mm/init.c                           | 12 +--
 arch/m68k/kernel/sys_m68k.c                   | 14 ++--
 arch/m68k/mm/fault.c                          |  8 +-
 arch/microblaze/mm/fault.c                    | 12 +--
 arch/mips/kernel/traps.c                      |  4 +-
 arch/mips/kernel/vdso.c                       |  4 +-
 arch/mips/mm/fault.c                          | 10 +--
 arch/nds32/kernel/vdso.c                      |  6 +-
 arch/nds32/mm/fault.c                         | 12 +--
 arch/nios2/mm/fault.c                         | 12 +--
 arch/nios2/mm/init.c                          |  4 +-
 arch/openrisc/mm/fault.c                      | 10 +--
 arch/parisc/kernel/traps.c                    |  6 +-
 arch/parisc/mm/fault.c                        |  8 +-
 arch/powerpc/kernel/vdso.c                    |  6 +-
 arch/powerpc/kvm/book3s_hv.c                  |  6 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c            | 12 +--
 arch/powerpc/kvm/e500_mmu_host.c              |  4 +-
 arch/powerpc/mm/book3s64/iommu_api.c          |  4 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       | 12 +--
 arch/powerpc/mm/copro_fault.c                 |  4 +-
 arch/powerpc/mm/fault.c                       | 12 +--
 arch/powerpc/oprofile/cell/spu_task_sync.c    |  6 +-
 arch/powerpc/platforms/cell/spufs/file.c      |  4 +-
 arch/riscv/kernel/vdso.c                      |  4 +-
 arch/riscv/mm/fault.c                         | 10 +--
 arch/s390/kernel/uv.c                         |  4 +-
 arch/s390/kernel/vdso.c                       |  4 +-
 arch/s390/kvm/gaccess.c                       |  4 +-
 arch/s390/kvm/interrupt.c                     |  4 +-
 arch/s390/kvm/kvm-s390.c                      | 28 +++----
 arch/s390/kvm/priv.c                          | 32 ++++----
 arch/s390/mm/fault.c                          | 14 ++--
 arch/s390/mm/gmap.c                           | 44 +++++------
 arch/s390/pci/pci_mmio.c                      |  4 +-
 arch/sh/kernel/sys_sh.c                       |  6 +-
 arch/sh/kernel/vsyscall/vsyscall.c            |  4 +-
 arch/sh/mm/fault.c                            | 10 +--
 arch/sparc/mm/fault_32.c                      | 18 ++---
 arch/sparc/mm/fault_64.c                      | 12 +--
 arch/sparc/vdso/vma.c                         |  4 +-
 arch/um/include/asm/mmu_context.h             |  5 +-
 arch/um/kernel/tlb.c                          |  2 +-
 arch/um/kernel/trap.c                         |  6 +-
 arch/unicore32/mm/fault.c                     |  6 +-
 arch/x86/entry/vdso/vma.c                     | 14 ++--
 arch/x86/events/core.c                        |  4 +-
 arch/x86/kernel/tboot.c                       |  2 +-
 arch/x86/kernel/vm86_32.c                     |  4 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |  8 +-
 arch/x86/mm/fault.c                           | 10 +--
 arch/x86/um/vdso/vma.c                        |  4 +-
 arch/xtensa/mm/fault.c                        | 10 +--
 drivers/android/binder_alloc.c                | 10 +--
 drivers/dma-buf/dma-resv.c                    |  5 +-
 drivers/firmware/efi/efi.c                    |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 10 +--
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c      |  4 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c   |  8 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c         | 22 +++---
 drivers/gpu/drm/radeon/radeon_cs.c            |  4 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |  6 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c               |  4 +-
 drivers/infiniband/core/umem_odp.c            |  4 +-
 drivers/infiniband/core/uverbs_main.c         |  4 +-
 drivers/infiniband/hw/mlx4/mr.c               |  4 +-
 drivers/infiniband/hw/qib/qib_user_pages.c    |  6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c      |  4 +-
 drivers/infiniband/sw/siw/siw_mem.c           |  4 +-
 drivers/iommu/amd_iommu_v2.c                  |  4 +-
 drivers/iommu/intel-svm.c                     |  4 +-
 drivers/media/v4l2-core/videobuf-core.c       |  4 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |  4 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c     |  4 +-
 drivers/misc/cxl/cxllib.c                     |  4 +-
 drivers/misc/cxl/fault.c                      |  4 +-
 drivers/misc/sgi-gru/grufault.c               | 16 ++--
 drivers/misc/sgi-gru/grufile.c                |  4 +-
 drivers/oprofile/buffer_sync.c                | 10 +--
 drivers/staging/kpc2000/kpc_dma/fileops.c     |  4 +-
 drivers/tee/optee/call.c                      |  4 +-
 drivers/vfio/vfio_iommu_type1.c               |  8 +-
 drivers/vhost/vdpa.c                          |  4 +-
 drivers/xen/gntdev.c                          |  4 +-
 drivers/xen/privcmd.c                         | 14 ++--
 fs/aio.c                                      |  4 +-
 fs/coredump.c                                 |  4 +-
 fs/exec.c                                     | 16 ++--
 fs/io_uring.c                                 |  4 +-
 fs/proc/base.c                                | 18 ++---
 fs/proc/task_mmu.c                            | 28 +++----
 fs/proc/task_nommu.c                          | 18 ++---
 fs/userfaultfd.c                              | 26 +++----
 include/linux/mm.h                            |  1 +
 include/linux/mm_types.h                      |  2 +-
 include/linux/mmap_lock.h                     | 75 +++++++++++++++++++
 include/linux/mmu_notifier.h                  |  5 +-
 ipc/shm.c                                     |  8 +-
 kernel/acct.c                                 |  4 +-
 kernel/bpf/stackmap.c                         | 17 ++---
 kernel/events/core.c                          |  4 +-
 kernel/events/uprobes.c                       | 16 ++--
 kernel/exit.c                                 |  8 +-
 kernel/fork.c                                 | 14 ++--
 kernel/futex.c                                |  4 +-
 kernel/sched/fair.c                           |  4 +-
 kernel/sys.c                                  | 18 ++---
 kernel/trace/trace_output.c                   |  4 +-
 lib/test_lockup.c                             |  8 +-
 mm/filemap.c                                  |  6 +-
 mm/frame_vector.c                             |  4 +-
 mm/gup.c                                      | 20 ++---
 mm/hmm.c                                      |  2 +-
 mm/init-mm.c                                  |  2 +-
 mm/internal.h                                 |  2 +-
 mm/khugepaged.c                               | 36 ++++-----
 mm/ksm.c                                      | 34 ++++-----
 mm/madvise.c                                  | 18 ++---
 mm/memcontrol.c                               |  8 +-
 mm/memory.c                                   | 16 ++--
 mm/mempolicy.c                                | 22 +++---
 mm/migrate.c                                  |  8 +-
 mm/mincore.c                                  |  4 +-
 mm/mlock.c                                    | 16 ++--
 mm/mmap.c                                     | 36 ++++-----
 mm/mmu_notifier.c                             | 22 +++---
 mm/mprotect.c                                 | 12 +--
 mm/mremap.c                                   |  6 +-
 mm/msync.c                                    |  8 +-
 mm/nommu.c                                    | 16 ++--
 mm/oom_kill.c                                 |  4 +-
 mm/pagewalk.c                                 | 15 ++--
 mm/process_vm_access.c                        |  4 +-
 mm/ptdump.c                                   |  4 +-
 mm/swapfile.c                                 |  4 +-
 mm/userfaultfd.c                              | 18 ++---
 mm/util.c                                     | 12 +--
 net/ipv4/tcp.c                                |  4 +-
 net/xdp/xdp_umem.c                            |  4 +-
 virt/kvm/arm/mmu.c                            | 14 ++--
 virt/kvm/async_pf.c                           |  4 +-
 virt/kvm/kvm_main.c                           |  8 +-
 163 files changed, 788 insertions(+), 715 deletions(-)
 create mode 100644 include/linux/mmap_lock.h

-- 
2.26.0.110.g2183baf09c-goog


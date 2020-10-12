Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456D228B212
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgJLKPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:33474 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLKPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:15:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 477E3AC6C;
        Mon, 12 Oct 2020 10:15:29 +0000 (UTC)
Date:   Mon, 12 Oct 2020 12:15:25 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/pasid updates for v5.10
Message-ID: <20201012101525.GE25311@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/pasid pile.

Thx.

---

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_pasid_for_5.10

for you to fetch changes up to 7f5933f81bd85a0bf6a87d65c7327ea048a75e54:

  x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction (2020-10-07 17:53:08 +0200)

----------------------------------------------------------------
Initial support for sharing virtual addresses between the CPU and
devices which doesn't need pinning of pages for DMA anymore. Add support
for the command submission to devices using new x86 instructions like
ENQCMD{,S} and MOVDIR64B. In addition, add support for process address
space identifiers (PASIDs) which are referenced by those command
submission instructions along with the handling of the PASID state on
context switch as another extended state. Work by Fenghua Yu, Ashok Raj,
Yu-cheng Yu and Dave Jiang.

----------------------------------------------------------------
Ashok Raj (1):
      Documentation/x86: Add documentation for SVA (Shared Virtual Addressing)

Dave Jiang (2):
      x86/asm: Carve out a generic movdir64b() helper for general usage
      x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction

Fenghua Yu (7):
      drm, iommu: Change type of pasid to u32
      iommu/vt-d: Change flags type to unsigned int in binding mm
      x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
      x86/msr-index: Define an IA32_PASID MSR
      mm: Add a pasid member to struct mm_struct
      x86/cpufeatures: Mark ENQCMD as disabled when configured out
      x86/mmu: Allocate/free a PASID

Yu-cheng Yu (1):
      x86/fpu/xstate: Add supervisor PASID state for ENQCMD

 Documentation/x86/index.rst                        |   1 +
 Documentation/x86/sva.rst                          | 257 +++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/disabled-features.h           |   9 +-
 arch/x86/include/asm/fpu/api.h                     |  12 +
 arch/x86/include/asm/fpu/internal.h                |   7 +
 arch/x86/include/asm/fpu/types.h                   |  11 +-
 arch/x86/include/asm/fpu/xstate.h                  |   2 +-
 arch/x86/include/asm/io.h                          |  17 +-
 arch/x86/include/asm/msr-index.h                   |   3 +
 arch/x86/include/asm/special_insns.h               |  64 +++++
 arch/x86/kernel/cpu/cpuid-deps.c                   |   1 +
 arch/x86/kernel/fpu/xstate.c                       |  63 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |   8 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h            |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h            |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c             |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  20 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   2 +-
 drivers/iommu/amd/amd_iommu.h                      |  10 +-
 drivers/iommu/amd/iommu.c                          |  31 +--
 drivers/iommu/amd/iommu_v2.c                       |  20 +-
 drivers/iommu/intel/dmar.c                         |   7 +-
 drivers/iommu/intel/iommu.c                        |   4 +-
 drivers/iommu/intel/pasid.c                        |  31 ++-
 drivers/iommu/intel/pasid.h                        |  24 +-
 drivers/iommu/intel/svm.c                          |  47 +++-
 drivers/iommu/iommu.c                              |   2 +-
 drivers/misc/uacce/uacce.c                         |   2 +-
 include/linux/amd-iommu.h                          |   8 +-
 include/linux/intel-iommu.h                        |  14 +-
 include/linux/intel-svm.h                          |   2 +-
 include/linux/iommu.h                              |  10 +-
 include/linux/mm_types.h                           |   4 +
 include/linux/uacce.h                              |   2 +-
 52 files changed, 607 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/x86/sva.rst

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

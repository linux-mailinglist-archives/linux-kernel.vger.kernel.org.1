Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36F31F7FF3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 02:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFMAlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 20:41:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:1251 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgFMAls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:41:48 -0400
IronPort-SDR: Fef97bZtOzL7O6ZL+NivrKiTluysoXtFYnB97onx0Y1Tq94lgwCTWnYttDYuDjKogV8a3xBRJ/
 YMYZszy7BQcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 17:41:48 -0700
IronPort-SDR: WoMIso8V3FWKsyb0lsLDQ19+StbXXOz/wr1ZYkSEcwHPO/sUHfIYWLyoBTkUnHZP/SoPKwj3QZ
 JJzYB65jcoVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; 
   d="scan'208";a="261011182"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2020 17:41:47 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Frederic Barrat" <fbarrat@linux.ibm.com>,
        "Andrew Donnellan" <ajd@linux.ibm.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 00/12] x86: tag application address space for devices
Date:   Fri, 12 Jun 2020 17:41:21 -0700
Message-Id: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typical hardware devices require a driver stack to translate application
buffers to hardware addresses, and a kernel-user transition to notify the
hardware of new work. What if both the translation and transition overhead
could be eliminated? This is what Shared Virtual Address (SVA) and ENQCMD
enabled hardware like Data Streaming Accelerator (DSA) aims to achieve.
Applications map portals in their local-address-space and directly submit
work to them using a new instruction.

This series enables ENQCMD and associated management of the new MSR
(MSR_IA32_PASID). This new MSR allows an application address space to be
associated with what the PCIe spec calls a Process Address Space ID (PASID).
This PASID tag is carried along with all requests between applications and
devices and allows devices to interact with the process address space.

SVA and ENQCMD enabled device drivers need this series. The phase 2 DSA
patches with SVA and ENQCMD support was released on the top of this series:
https://lore.kernel.org/patchwork/cover/1244060/

This series only provides simple and basic support for ENQCMD and the MSR:
1. Clean up type definitions (patch 1-3). These patches can be in a
   separate series.
   - Define "pasid" as "unsigned int" consistently (patch 1 and 2).
   - Define "flags" as "unsigned int"
2. Explain different various technical terms used in the series (patch 4).
3. Enumerate support for ENQCMD in the processor (patch 5).
4. Handle FPU PASID state and the MSR during context switch (patches 6-7).
5. Define "pasid" in mm_struct (patch 8).
5. Clear PASID state for new mm and forked and cloned thread (patch 9-10).
6. Allocate and free PASID for a process (patch 11).
7. Fix up the PASID MSR in #GP handler when one thread in a process
   executes ENQCMD for the first time (patches 12).

This patch series and the DSA phase 2 series are in
https://github.com/intel/idxd-driver/tree/idxd-stage2

References:
1. Detailed information on the ENQCMD/ENQCMDS instructions and the
IA32_PASID MSR can be found in Intel Architecture Instruction Set
Extensions and Future Features Programming Reference:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf

2. Detailed information on DSA can be found in DSA specification:
https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification

Chang log:
v2:
- Add patches 1-3 to define "pasid" and "flags" as "unsigned int"
  consistently (Thomas)
  (these 3 patches could be in a separate patch set)
- Add patch 8 to move "pasid" to generic mm_struct (Christoph).
  Jean-Philippe Brucker released a virtually same patch. Upstream only
  needs one of the two.
- Add patch 9 to initialize PASID in a new mm.
- Plus other changes described in each patch (Thomas)

Ashok Raj (1):
  docs: x86: Add documentation for SVA (Shared Virtual Addressing)

Fenghua Yu (10):
  iommu: Change type of pasid to unsigned int
  ocxl: Change type of pasid to unsigned int
  iommu/vt-d: Change flags type to unsigned int in binding mm
  x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
  x86/msr-index: Define IA32_PASID MSR
  mm: Define pasid in mm
  fork: Clear PASID for new mm
  x86/process: Clear PASID state for a newly forked/cloned thread
  x86/mmu: Allocate/free PASID
  x86/traps: Fix up invalid PASID

Yu-cheng Yu (1):
  x86/fpu/xstate: Add supervisor PASID state for ENQCMD feature

 Documentation/x86/index.rst            |   1 +
 Documentation/x86/sva.rst              | 287 +++++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h     |   1 +
 arch/x86/include/asm/fpu/types.h       |  10 +
 arch/x86/include/asm/fpu/xstate.h      |   2 +-
 arch/x86/include/asm/iommu.h           |   3 +
 arch/x86/include/asm/mmu_context.h     |  14 ++
 arch/x86/include/asm/msr-index.h       |   3 +
 arch/x86/kernel/cpu/cpuid-deps.c       |   1 +
 arch/x86/kernel/fpu/xstate.c           |   4 +
 arch/x86/kernel/process.c              |  18 ++
 arch/x86/kernel/traps.c                |  23 ++
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   2 +-
 drivers/iommu/amd/amd_iommu.h          |  13 +-
 drivers/iommu/amd/amd_iommu_types.h    |  12 +-
 drivers/iommu/amd/init.c               |   4 +-
 drivers/iommu/amd/iommu.c              |  41 ++--
 drivers/iommu/amd/iommu_v2.c           |  22 +-
 drivers/iommu/intel/debugfs.c          |   2 +-
 drivers/iommu/intel/dmar.c             |  13 +-
 drivers/iommu/intel/intel-pasid.h      |  21 +-
 drivers/iommu/intel/iommu.c            |   4 +-
 drivers/iommu/intel/pasid.c            |  36 ++--
 drivers/iommu/intel/svm.c              | 159 ++++++++++++--
 drivers/iommu/iommu.c                  |   2 +-
 drivers/misc/ocxl/config.c             |   3 +-
 drivers/misc/ocxl/link.c               |   6 +-
 drivers/misc/ocxl/ocxl_internal.h      |   6 +-
 drivers/misc/ocxl/pasid.c              |   2 +-
 drivers/misc/ocxl/trace.h              |  20 +-
 drivers/misc/uacce/uacce.c             |   2 +-
 include/linux/amd-iommu.h              |   9 +-
 include/linux/intel-iommu.h            |  20 +-
 include/linux/intel-svm.h              |   2 +-
 include/linux/iommu.h                  |   8 +-
 include/linux/mm_types.h               |   6 +
 include/linux/uacce.h                  |   2 +-
 include/misc/ocxl.h                    |   6 +-
 kernel/fork.c                          |   8 +
 40 files changed, 656 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/x86/sva.rst

-- 
2.19.1


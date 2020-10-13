Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3B328D1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgJMQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgJMQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:04:03 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47722C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 09:04:03 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1C949887; Tue, 13 Oct 2020 18:04:00 +0200 (CEST)
Date:   Tue, 13 Oct 2020 18:03:58 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Updates for Linux v5.10
Message-ID: <20201013160353.GA19438@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

there is a minor conflict this time in include/linux/iommu.h which
should be easy to resolve. I would attach my resolution, but somehow git
[show|log] didn't show it to me.

The conflict is in a function signature, specifically the type of the
pasid parameter. My resolution used iopasid_t.

With that in mind:

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.10

for you to fetch changes up to 7e3c3883c381aeda903778d7e99fc4cd523be610:

  Merge branches 'arm/allwinner', 'arm/mediatek', 'arm/renesas', 'arm/tegra', 'arm/qcom', 'arm/smmu', 'ppc/pamu', 'x86/amd', 'x86/vt-d' and 'core' into next (2020-10-07 11:51:59 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v5.10

Including:

	- ARM-SMMU Updates from Will:

	  - Continued SVM enablement, where page-table is shared with
	    CPU

	  - Groundwork to support integrated SMMU with Adreno GPU

	  - Allow disabling of MSI-based polling on the kernel
	    command-line

	  - Minor driver fixes and cleanups (octal permissions, error
	    messages, ...)

	- Secure Nested Paging Support for AMD IOMMU. The IOMMU will
	  fault when a device tries DMA on memory owned by a guest. This
	  needs new fault-types as well as a rewrite of the IOMMU memory
	  semaphore for command completions.

	- Allow broken Intel IOMMUs (wrong address widths reported) to
	  still be used for interrupt remapping.

	- IOMMU UAPI updates for supporting vSVA, where the IOMMU can
	  access address spaces of processes running in a VM.

	- Support for the MT8167 IOMMU in the Mediatek IOMMU driver.

	- Device-tree updates for the Renesas driver to support r8a7742.

	- Several smaller fixes and cleanups all over the place.

----------------------------------------------------------------
Alex Dewar (1):
      iommu/pamu: Replace use of kzfree with kfree_sensitive

Andy Shevchenko (1):
      iommu/vt-d: Move intel_iommu_gfx_mapped to Intel IOMMU header

Barry Song (3):
      iommu/arm-smmu-v3: replace symbolic permissions by octal permissions for module parameter
      iommu/arm-smmu-v3: replace module_param_named by module_param for disable_bypass
      iommu/arm-smmu-v3: permit users to disable msi polling

David Woodhouse (1):
      iommu/vt-d: Gracefully handle DMAR units with no supported address widths

Dmitry Osipenko (1):
      iommu/tegra-smmu: Add locking around mapping operations

Fabien Parent (3):
      dt-bindings: iommu: Add binding for MediaTek MT8167 IOMMU
      iommu/mediatek: Add flag for legacy ivrp paddr
      iommu/mediatek: Add support for MT8167

Jacob Pan (6):
      docs: IOMMU user API
      iommu/uapi: Add argsz for user filled data
      iommu/uapi: Use named union for user data
      iommu/uapi: Rename uapi functions
      iommu/uapi: Handle data and argsz filled by users
      iommu/vt-d: Check UAPI data processed by IOMMU core

Jean-Philippe Brucker (9):
      iommu/arm-smmu-v3: Fix endianness annotations
      arm64: mm: Pin down ASIDs for sharing mm with devices
      arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
      iommu/io-pgtable-arm: Move some definitions to a header
      iommu/arm-smmu-v3: Move definitions to a header
      iommu/arm-smmu-v3: Share process page tables
      iommu/arm-smmu-v3: Seize private ASID
      iommu/arm-smmu-v3: Check for SVA features
      iommu/arm-smmu-v3: Add SVA device feature

Joerg Roedel (3):
      iommu/sun50i: Fix set-but-not-used variable warning
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/.../will/linux into arm/smmu
      Merge branches 'arm/allwinner', 'arm/mediatek', 'arm/renesas', 'arm/tegra', 'arm/qcom', 'arm/smmu', 'ppc/pamu', 'x86/amd', 'x86/vt-d' and 'core' into next

Jordan Crouse (3):
      iommu/arm-smmu: Pass io-pgtable config to implementation specific function
      iommu/arm-smmu: Add support for split pagetables
      iommu/arm-smmu: Prepare for the adreno-smmu implementation

Krzysztof Kozlowski (5):
      iommu/mediatek: Drop of_match_ptr to fix -Wunused-const-variable
      iommu/amd: Add missing function prototypes to fix -Wmissing-prototypes
      iommu/amd: Fix kerneldoc comments
      iommu/vt-d: Drop kerneldoc marker from regular comment
      iommu/qcom: Drop of_match_ptr to fix -Wunused-const-variable

Lad Prabhakar (4):
      dt-bindings: iommu: renesas,ipmmu-vmsa: Sort compatible string in increasing number of the SoC
      dt-bindings: iommu: renesas,ipmmu-vmsa: Add r8a7742 support
      ARM: dts: r8a7742: Add IPMMU DT nodes
      iommu/renesas: Update help description for IPMMU_VMSA config

Lu Baolu (1):
      iommu/vt-d: Use device numa domain if RHSA is missing

Miles Chen (1):
      iommu/mediatek: Check 4GB mode by reading infracfg

Nicolin Chen (5):
      iommu/tegra-smmu: Fix tlb_mask
      memory: tegra: Correct num_tlb_lines for tegra210
      iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
      iommu/tegra-smmu: Fix iova->phys translation
      iommu/tegra-smmu: Allow to group clients in same swgroup

Rob Clark (1):
      iommu/arm-smmu: Constify some helpers

Robin Murphy (1):
      iommu/dma: Remove broken huge page handling

Suravee Suthikulpanit (3):
      iommu/amd: Use 4K page for completion wait write-back semaphore
      iommu/amd: Add support for RMP_PAGE_FAULT and RMP_HW_ERR
      iommu/amd: Re-purpose Exclusion range registers to support SNP CWWB

Thierry Reding (3):
      iommu/tegra-smmu: Set IOMMU group name
      iommu/tegra-smmu: Balance IOMMU group reference count
      iommu/tegra-smmu: Prune IOMMU group when it is released

Tom Murphy (2):
      iommu: Rename iommu_tlb_* functions to iommu_iotlb_*
      iommu/dma: Handle init_iova_flush_queue() failure in dma-iommu path

Will Deacon (1):
      Merge branch 'for-next/svm' of git://git.kernel.org/.../arm64/linux into for-joerg/arm-smmu/updates

Yu Kuai (1):
      iommu/qcom: add missing put_device() call in qcom_iommu_of_xlate()

Yuqi Jin (1):
      iommu/iova: Replace cmpxchg with xchg in queue_iova

Zenghui Yu (1):
      iommu/arm-smmu-v3: Fix l1 stream table size in the error message

Zhou Wang (1):
      iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   2 +
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   3 +-
 Documentation/userspace-api/iommu.rst              | 209 +++++
 MAINTAINERS                                        |   4 +-
 arch/arm/boot/dts/r8a7742.dtsi                     |  48 ++
 arch/arm64/include/asm/barrier.h                   |   1 +
 arch/arm64/include/asm/io.h                        |   1 +
 arch/arm64/include/asm/mmu.h                       |   3 +
 arch/arm64/include/asm/mmu_context.h               |  11 +-
 arch/arm64/kernel/cpufeature.c                     |   1 +
 arch/arm64/mm/context.c                            | 105 ++-
 drivers/iommu/Kconfig                              |  12 +-
 drivers/iommu/amd/amd_iommu.h                      |   9 +
 drivers/iommu/amd/amd_iommu_types.h                |   6 +-
 drivers/iommu/amd/init.c                           |  48 +-
 drivers/iommu/amd/iommu.c                          |  90 ++-
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 248 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 843 ++++-----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        | 723 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |   3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 102 +--
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  84 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |  12 +-
 drivers/iommu/dma-iommu.c                          |  22 +-
 drivers/iommu/fsl_pamu.c                           |   2 +-
 drivers/iommu/intel/dmar.c                         |  48 +-
 drivers/iommu/intel/iommu.c                        |  62 +-
 drivers/iommu/intel/svm.c                          |  13 +-
 drivers/iommu/io-pgtable-arm.c                     |  27 +-
 drivers/iommu/io-pgtable-arm.h                     |  30 +
 drivers/iommu/iommu.c                              | 200 ++++-
 drivers/iommu/iova.c                               |   2 +-
 drivers/iommu/mtk_iommu.c                          |  49 +-
 drivers/iommu/mtk_iommu.h                          |   1 +
 drivers/iommu/sun50i-iommu.c                       |  15 +-
 drivers/iommu/tegra-smmu.c                         | 138 +++-
 drivers/memory/tegra/tegra210.c                    |   2 +-
 drivers/vfio/vfio_iommu_type1.c                    |   2 +-
 include/drm/intel-gtt.h                            |   5 +-
 include/dt-bindings/memory/mt8167-larb-port.h      |  51 ++
 include/linux/intel-iommu.h                        |   1 +
 include/linux/io-pgtable.h                         |   2 +-
 include/linux/iommu.h                              |  45 +-
 include/linux/soc/mediatek/infracfg.h              |   3 +
 include/uapi/linux/iommu.h                         |  18 +-
 46 files changed, 2372 insertions(+), 939 deletions(-)
 create mode 100644 Documentation/userspace-api/iommu.rst
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 include/dt-bindings/memory/mt8167-larb-port.h

Please pull.

Thanks,

	Joerg

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl+Fz+UACgkQK/BELZcB
GuNK9Q/+LA/PvSOH7mzLzCkFAlynU/Ltqf0SwZQ6tZHTyWuR+kvouReUOHZ3yved
SqvEw6zJ2lceVkICREAIE1qhXO28bFXdrFK84t8rFD80tT6EKt1N/ENNFLYPDKvi
B4LwEnbiGb+kUg4y7tybrIa1+ID58a8VNodE2WfXSCrrXo/2sVE10eEqduYLPPjy
uWKY6wyARB4dEk70LhYsi9W7O3r3d4ocAYlum9pkkdEvND7ZKOlzkd3KBnyLX28i
VY+NFLBPPWJHKbiZo4+ai2Zz3wuyCxkAj6yA5CcNTcXVFKPiq/pSMtVPKtu/lI61
P2v+45BNNd3JjjRc2EUHVJF6PGuL3o5SyaL4UNaEqJxnE7Fpp1p6BQotq3jSDPeF
aDpSdBfOb/vrptzTPbuJi+PjjNUzXh9YYAdOjp2UkvTvTXLGeAthSDEisO6Ga8zB
ph9S1HwjScjo69KsrHqWFOwBqiHLLXoZVvAiJcUb+aRQtfZYwgu9XjnrKc11Vwpv
b5xw/oZaFv3iOADS8VhHhBnXFkUyhiC8uTXUUwAc553cCg4KTQW8TfqfIUDnBcr+
f7Ln0BwAWySEIdmIhUdeCZYcv/CuCRHew829dKu4Q7ZFELQVJV+XqmicLz1Oqenm
ZxNczoI1HbKo/KwBGczImB+Ao95vdKe6frYmhrVufmR+4a3WXZQ=
=zi+7
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

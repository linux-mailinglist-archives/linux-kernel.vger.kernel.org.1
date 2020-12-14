Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6A2DA45A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgLNXqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgLNXqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:46:04 -0500
Date:   Mon, 14 Dec 2020 23:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607989523;
        bh=nmVeZbOM6GWp/MXK73GTwAScW4A9C2OsxbBerJBRXas=;
        h=From:To:Cc:Subject:From;
        b=FdUBnG1NApEfaJr5cv6kBs6jNS711Qv5k1lQt/6T9JMtcxqZKXg30CN7TKkzynr9S
         qDsXOmfuo9F7n+Y2qA+ARBVrS+q3QWIsCunKpl36tG6W0Nmh18GatjkhxtOLnioddV
         YjMHhnzum23SJozCcYl/UWimaqnB5vNxvZYIPPy9Ywy8DeEF5TIXWj3OGwYx4JLxMa
         CXtG3y80bdPwjyBqhIHcZPL86QfeAGlPizyrHdgrNvEkoYY/lPOZxIYKBGIr7q6Lzv
         LGnB01nvtXDGTkzRPw/iJyHoV0Wx0sMpqUm98bC+o6+FOgpa+AJBsV98RB1GRtTnnu
         gmtafSxcrJn9w==
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, kernel-team@android.com
Subject: [GIT PULL] IOMMU updates for 5.11
Message-ID: <20201214234518.GA14575@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these IOMMU updates for 5.11: there's a good mixture of
improvements to the core code and driver changes across the board.
Summary in the tag and merge commits.

One thing worth pointing out is that this includes a quirk to work
around behaviour in the i915 driver (see 65f746e8285f ("iommu: Add quirk
for Intel graphic devices in map_sg")), which otherwise interacts badly
with the conversion of the intel IOMMU driver over to the DMA-IOMMU APU
but has being fixed properly in the DRM tree. We'll revert the quirk
later this cycle once we've confirmed that things don't fall apart
without it.

Cheers,

Will

--->8

The following changes since commit 4165bf015ba9454f45beaad621d16c516d5c5afe:

  iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs (2020-12-07 11:00:24 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-updates-v5.11

for you to fetch changes up to 5ae9a046a452d60b6a6c076f6df7e3f8e34f918f:

  iommu/amd: Add sanity check for interrupt remapping table length macros (2020-12-11 12:47:22 +0000)

----------------------------------------------------------------
IOMMU updates for 5.11

- IOVA allocation optimisations and removal of unused code

- Introduction of DOMAIN_ATTR_IO_PGTABLE_CFG for parameterising the
  page-table of an IOMMU domain

- Support for changing the default domain type in sysfs

- Optimisation to the way in which identity-mapped regions are created

- Driver updates:
  * Arm SMMU updates, including continued work on Shared Virtual Memory
  * Tegra SMMU updates, including support for PCI devices
  * Intel VT-D updates, including conversion to the IOMMU-DMA API

- Cleanup, kerneldoc and minor refactoring

----------------------------------------------------------------
Bjorn Andersson (3):
      iommu/arm-smmu: Allow implementation specific write_s2cr
      iommu/arm-smmu-qcom: Read back stream mappings
      iommu/arm-smmu-qcom: Implement S2CR quirk

Chen Jun (1):
      iommu: Modify the description of iommu_sva_unbind_device

Christoph Hellwig (1):
      dma-iommu: remove __iommu_dma_mmap

Christophe JAILLET (1):
      iommu/vt-d: Avoid GFP_ATOMIC where it is not needed

Cong Wang (1):
      iommu: avoid taking iova_rbtree_lock twice

Jean-Philippe Brucker (4):
      iommu/ioasid: Add ioasid references
      iommu/sva: Add PASID helpers
      iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
      iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops

John Garry (3):
      iommu: Delete split_and_remove_iova()
      iommu: Stop exporting alloc_iova_mem()
      iommu: Stop exporting free_iova_mem()

Jordan Crouse (2):
      iommu/arm-smmu-qcom: Add implementation for the adreno GPU SMMU
      dt-bindings: arm-smmu: Add compatible string for Adreno GPU SMMU

Kaixu Xia (1):
      iommu/arm-smmu-v3: Assign boolean values to a bool variable

Keqian Zhu (1):
      iommu: Defer the early return in arm_(v7s/lpae)_map

Kunkun Jiang (1):
      iommu/io-pgtable-arm: Remove unused 'level' parameter from iopte_type() macro

Lu Baolu (6):
      iommu: Add quirk for Intel graphic devices in map_sg
      iommu/vt-d: Update domain geometry in iommu_ops.at(de)tach_dev
      iommu/vt-d: Cleanup after converting to dma-iommu ops
      iommu: Move def_domain type check for untrusted device into core
      iommu: Fix htmldocs warnings in sysfs-kernel-iommu_groups
      iommu/vt-d: Remove set but not used variable

Lukas Bulwahn (1):
      iommu/vt-d: include conditionally on CONFIG_INTEL_IOMMU_SVM

Nicolin Chen (5):
      iommu/tegra-smmu: Unwrap tegra_smmu_group_get
      iommu/tegra-smmu: Expand mutex protection range
      iommu/tegra-smmu: Use fwspec in tegra_smmu_(de)attach_dev
      iommu/tegra-smmu: Rework tegra_smmu_probe_device()
      iommu/tegra-smmu: Add PCI support

Rob Clark (1):
      iommu/arm-smmu: Add a way for implementations to influence SCTLR

Robin Murphy (2):
      iommu/arm-smmu: Use new devm_krealloc()
      iommu/io-pgtable: Remove tlb_flush_leaf

Sai Prakash Ranjan (4):
      iommu/arm-smmu: Add support for pagetable config domain attribute
      iommu/arm-smmu: Move non-strict mode to use io_pgtable_domain_attr
      iommu: arm-smmu-impl: Use table to list QCOM implementations
      iommu: arm-smmu-impl: Add a space before open parenthesis

Sai Praneeth Prakhya (3):
      iommu: Add support to change default domain of an iommu group
      iommu: Take lock before reading iommu group default domain type
      iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file

Suravee Suthikulpanit (1):
      iommu/amd: Add sanity check for interrupt remapping table length macros

Tom Murphy (4):
      iommu: Handle freelists when using deferred flushing in iommu drivers
      iommu: Add iommu_dma_free_cpu_cached_iovas()
      iommu: Allow the dma-iommu api to use bounce buffers
      iommu/vt-d: Convert intel iommu driver to the iommu ops

Vijayanand Jitta (2):
      iommu/iova: Retry from last rb tree node if iova search fails
      iommu/iova: Free global iova rcache on iova alloc failure

Will Deacon (10):
      Merge branch 'stable/for-linus-5.10-rc2' of git://git.kernel.org/.../konrad/swiotlb into for-next/iommu/vt-d
      Merge branch 'for-next/iommu/io-pgtable-domain-attr' into for-next/iommu/arm-smmu
      Merge branch 'for-next/iommu/arm-smmu' into for-next/iommu/core
      Merge branch 'for-next/iommu/default-domains' into for-next/iommu/core
      Merge branch 'for-next/iommu/iova' into for-next/iommu/core
      Merge branch 'for-next/iommu/misc' into for-next/iommu/core
      Merge branch 'for-next/iommu/svm' into for-next/iommu/core
      Merge branch 'for-next/iommu/tegra-smmu' into for-next/iommu/core
      Merge branch 'for-next/iommu/vt-d' into for-next/iommu/core
      Merge branch 'for-next/iommu/fixes' into for-next/iommu/core

Yang Yingliang (1):
      iommu: return error code when it can't get group

Yong Wu (1):
      iommu: Improve the performance for direct_mapping

 .../ABI/testing/sysfs-kernel-iommu_groups          |  30 +
 Documentation/admin-guide/kernel-parameters.txt    |   5 -
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   9 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   1 -
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |   7 -
 drivers/iommu/Kconfig                              |   7 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd/amd_iommu_types.h                |  19 +-
 drivers/iommu/amd/init.c                           |   6 +-
 drivers/iommu/amd/iommu.c                          |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 244 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  59 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  30 +
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |  13 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c       |  17 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 270 +++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  76 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   5 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   8 -
 drivers/iommu/dma-iommu.c                          | 244 +++++-
 drivers/iommu/intel/Kconfig                        |   1 +
 drivers/iommu/intel/iommu.c                        | 919 +++------------------
 drivers/iommu/intel/svm.c                          |   6 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 |  11 +-
 drivers/iommu/io-pgtable-arm.c                     |  29 +-
 drivers/iommu/ioasid.c                             |  38 +-
 drivers/iommu/iommu-sva-lib.c                      |  86 ++
 drivers/iommu/iommu-sva-lib.h                      |  15 +
 drivers/iommu/iommu.c                              | 276 ++++++-
 drivers/iommu/iova.c                               | 100 ++-
 drivers/iommu/ipmmu-vmsa.c                         |   1 -
 drivers/iommu/msm_iommu.c                          |   7 -
 drivers/iommu/mtk_iommu.c                          |   1 -
 drivers/iommu/tegra-smmu.c                         | 240 ++----
 drivers/xen/swiotlb-xen.c                          |   3 +-
 include/linux/dma-iommu.h                          |   8 +
 include/linux/io-pgtable.h                         |  19 +-
 include/linux/ioasid.h                             |  10 +-
 include/linux/iommu.h                              |   2 +
 include/linux/iova.h                               |  21 -
 include/linux/swiotlb.h                            |  10 +-
 kernel/dma/swiotlb.c                               |  22 +-
 42 files changed, 1613 insertions(+), 1265 deletions(-)
 create mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva-lib.h

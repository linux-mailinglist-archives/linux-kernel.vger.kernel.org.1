Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6B2F7878
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbhAOMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:14:40 -0500
Received: from foss.arm.com ([217.140.110.172]:37426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAOMOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:14:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A55A11B3;
        Fri, 15 Jan 2021 04:13:52 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C64663F70D;
        Fri, 15 Jan 2021 04:13:47 -0800 (PST)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
Subject: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
Date:   Fri, 15 Jan 2021 17:43:27 +0530
Message-Id: <20210115121342.15093-1-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-series aims at enabling Nested stage translation in guests
using virtio-iommu as the paravirtualized iommu. The backend is supported
with Arm SMMU-v3 that provides nested stage-1 and stage-2 translation.

This series derives its purpose from various efforts happening to add
support for Shared Virtual Addressing (SVA) in host and guest. On Arm,
most of the support for SVA has already landed. The support for nested
stage translation and fault reporting to guest has been proposed [1].
The related changes required in VFIO [2] framework have also been put
forward.

This series proposes changes in virtio-iommu to program PASID tables
and related stage-1 page tables. A simple iommu-pasid-table library
is added for this purpose that interacts with vendor drivers to
allocate and populate PASID tables.
In Arm SMMUv3 we propose to pull the Context Descriptor (CD) management
code out of the arm-smmu-v3 driver and add that as a glue vendor layer
to support allocating CD tables, and populating them with right values.
These CD tables are essentially the PASID tables and contain stage-1
page table configurations too.
A request to setup these CD tables come from virtio-iommu driver using
the iommu-pasid-table library when running on Arm. The virtio-iommu
then pass these PASID tables to the host using the right virtio backend
and support in VMM.

For testing we have added necessary support in kvmtool. The changes in
kvmtool are based on virtio-iommu development branch by Jean-Philippe
Brucker [3].

The tested kernel branch contains following in the order bottom to top
on the git hash -
a) v5.11-rc3
b) arm-smmu-v3 [1] and vfio [2] changes from Eric to add nested page
   table support for Arm.
c) Smmu test engine patches from Jean-Philippe's branch [4]
d) This series
e) Domain nesting info patches [5][6][7].
f) Changes to add arm-smmu-v3 specific nesting info (to be sent to
   the list).

This kernel is tested on Neoverse reference software stack with
Fixed virtual platform. Public version of the software stack and
FVP is available here[8][9].

A big thanks to Jean-Philippe for his contributions towards this work
and for his valuable guidance.

[1] https://lore.kernel.org/linux-iommu/20201118112151.25412-1-eric.auger@redhat.com/T/
[2] https://lore.kernel.org/kvmarm/20201116110030.32335-12-eric.auger@redhat.com/T/
[3] https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
[4] https://jpbrucker.net/git/linux/log/?h=sva/smmute
[5] https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu@intel.com/
[6] https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu@intel.com/
[7] https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu@intel.com/
[8] https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps
[9] https://git.linaro.org/landing-teams/working/arm/arm-reference-platforms.git/about/docs/rdn1edge/user-guide.rst

Jean-Philippe Brucker (6):
  iommu/virtio: Add headers for table format probing
  iommu/virtio: Add table format probing
  iommu/virtio: Add headers for binding pasid table in iommu
  iommu/virtio: Add support for INVALIDATE request
  iommu/virtio: Attach Arm PASID tables when available
  iommu/virtio: Add support for Arm LPAE page table format

Vivek Gautam (9):
  iommu/arm-smmu-v3: Create a Context Descriptor library
  iommu: Add a simple PASID table library
  iommu/arm-smmu-v3: Update drivers to work with iommu-pasid-table
  iommu/arm-smmu-v3: Update CD base address info for user-space
  iommu/arm-smmu-v3: Set sync op from consumer driver of cd-lib
  iommu: Add asid_bits to arm smmu-v3 stage1 table info
  iommu/virtio: Update table format probing header
  iommu/virtio: Prepare to add attach pasid table infrastructure
  iommu/virtio: Update fault type and reason info for viommu fault

 drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      | 283 +++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  16 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 268 +------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
 drivers/iommu/iommu-pasid-table.h             | 140 ++++
 drivers/iommu/virtio-iommu.c                  | 692 +++++++++++++++++-
 include/uapi/linux/iommu.h                    |   2 +-
 include/uapi/linux/virtio_iommu.h             | 158 +++-
 9 files changed, 1303 insertions(+), 262 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
 create mode 100644 drivers/iommu/iommu-pasid-table.h

-- 
2.17.1


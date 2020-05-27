Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B281E408C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgE0Lxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:53:30 -0400
Received: from 8bytes.org ([81.169.241.247]:44868 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbgE0Lx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:27 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4D05D374; Wed, 27 May 2020 13:53:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 00/10] iommu/amd: Updates and Cleanups
Date:   Wed, 27 May 2020 13:53:03 +0200
Message-Id: <20200527115313.7426-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is a collection of patches that clean up a few things
in the AMD IOMMU driver. Foremost, it moves all related
files of the driver into a separate subdirectory.

But the patches also remove usage of dev->archdata.iommu and
clean up dev_data handling and domain allocation.

Patches are runtime-tested, including device-assignment.

Please review.

Regards,

	Joerg

Joerg Roedel (10):
  iommu/amd: Move AMD IOMMU driver to a subdirectory
  iommu/amd: Unexport get_dev_data()
  iommu/amd: Let free_pagetable() not rely on domain->pt_root
  iommu/amd: Allocate page-table in protection_domain_init()
  iommu/amd: Free page-table in protection_domain_free()
  iommu/amd: Consolidate domain allocation/freeing
  iommu/amd: Remove PD_DMA_OPS_MASK
  iommu/amd: Merge private header files
  iommu/amd: Store dev_data as device iommu private data
  iommu/amd: Remove redundant devid checks

 MAINTAINERS                                   |   2 +-
 drivers/iommu/Makefile                        |   6 +-
 .../{amd_iommu_proto.h => amd/amd_iommu.h}    |  20 +-
 drivers/iommu/{ => amd}/amd_iommu_types.h     |   0
 .../{amd_iommu_debugfs.c => amd/debugfs.c}    |   5 +-
 .../iommu/{amd_iommu_init.c => amd/init.c}    |   6 +-
 drivers/iommu/{amd_iommu.c => amd/iommu.c}    | 265 ++++++------------
 .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}  |  14 +-
 .../{amd_iommu_quirks.c => amd/quirks.c}      |   0
 drivers/iommu/amd_iommu.h                     |  14 -
 10 files changed, 117 insertions(+), 215 deletions(-)
 rename drivers/iommu/{amd_iommu_proto.h => amd/amd_iommu.h} (88%)
 rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
 rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (89%)
 rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
 rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (95%)
 rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (98%)
 rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
 delete mode 100644 drivers/iommu/amd_iommu.h

-- 
2.17.1


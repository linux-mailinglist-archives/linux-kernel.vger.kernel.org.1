Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F41F3B54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 15:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgFINDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 09:03:11 -0400
Received: from 8bytes.org ([81.169.241.247]:46776 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgFINDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:03:11 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C9A372C3; Tue,  9 Jun 2020 15:03:09 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Qian Cai <cai@lca.pw>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iommu: Move Intel and AMD drivers into their own subdirectory
Date:   Tue,  9 Jun 2020 15:03:01 +0200
Message-Id: <20200609130303.26974-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the updated version of the changes to move the Intel and AMD
IOMMU drivers into their own subdirectories. This time with updated
MAINTAINERS file entries.

Regards,

	Joerg

Joerg Roedel (2):
  iommu/amd: Move AMD IOMMU driver into subdirectory
  iommu/vt-d: Move Intel IOMMU driver into subdirectory

 MAINTAINERS                                    |  5 ++---
 drivers/iommu/Makefile                         | 18 +++++++++---------
 drivers/iommu/{ => amd}/amd_iommu.h            |  0
 drivers/iommu/{ => amd}/amd_iommu_types.h      |  0
 .../{amd_iommu_debugfs.c => amd/debugfs.c}     |  0
 drivers/iommu/{amd_iommu_init.c => amd/init.c} |  2 +-
 drivers/iommu/{amd_iommu.c => amd/iommu.c}     |  2 +-
 .../iommu/{amd_iommu_v2.c => amd/iommu_v2.c}   |  0
 .../iommu/{amd_iommu_quirks.c => amd/quirks.c} |  0
 .../{intel-iommu-debugfs.c => intel/debugfs.c} |  0
 drivers/iommu/{ => intel}/dmar.c               |  2 +-
 drivers/iommu/{ => intel}/intel-pasid.h        |  0
 drivers/iommu/{intel-iommu.c => intel/iommu.c} |  2 +-
 .../irq_remapping.c}                           |  2 +-
 drivers/iommu/{intel-pasid.c => intel/pasid.c} |  0
 drivers/iommu/{intel-svm.c => intel/svm.c}     |  0
 drivers/iommu/{intel-trace.c => intel/trace.c} |  0
 17 files changed, 16 insertions(+), 17 deletions(-)
 rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
 rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
 rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
 rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
 rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
 rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
 rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
 rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
 rename drivers/iommu/{ => intel}/dmar.c (99%)
 rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
 rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
 rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
 rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
 rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
 rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)

-- 
2.17.1


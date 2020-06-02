Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5F91EB872
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 11:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFBJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 05:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:26:25 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B45C05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 02:26:25 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 163952F0; Tue,  2 Jun 2020 11:26:22 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Qian Cai <cai@lca.pw>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu: Move Intel and AMD drivers into their own subdirectory
Date:   Tue,  2 Jun 2020 11:26:14 +0200
Message-Id: <20200602092616.24638-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

two small patches to move the Intel and AMD IOMMU drivers into their own
subdirectory under drivers/iommu/ to make the file structure a bit less
cluttered.

Regards,

	Joerg

Joerg Roedel (2):
  iommu/amd: Move AMD IOMMU driver into subdirectory
  iommu/vt-d: Move Intel IOMMU driver into subdirectory

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
 16 files changed, 14 insertions(+), 14 deletions(-)
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


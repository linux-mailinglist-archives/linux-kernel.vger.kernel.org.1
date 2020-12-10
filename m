Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A190B2D54B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 08:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbgLJHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 02:36:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9573 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLJHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:36:18 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cs5KN6PFMzM2xM;
        Thu, 10 Dec 2020 15:34:48 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 15:35:24 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH 0/7] vfio: iommu_type1: Some fixes and optimization
Date:   Thu, 10 Dec 2020 15:34:18 +0800
Message-ID: <20201210073425.25960-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This patch series aim to fix up or optimize some code about vfio
dirty log tracking.

patch   1: Optimize dirty log when unwind pin pages.
patch 2-3: Optimize promoting pinned_page_dirty_scope.
patch   4: Fix up dirty log missing when promote pinned_page_dirty_scope.
patch 5-7: Drop superfluous parameter "pgsize" of some functions.

Wish they improves the robustness of vfio dirty log tracking.

Thanks,
Keqian

Keqian Zhu (7):
  vfio: iommu_type1: Clear added dirty bit when unwind pin
  vfio: iommu_type1: Initially set the pinned_page_dirty_scope
  vfio: iommu_type1: Make an explicit "promote" semantic
  vfio: iommu_type1: Fix missing dirty page when promote pinned_scope
  vfio: iommu_type1: Drop parameter "pgsize" of
    vfio_dma_bitmap_alloc_all
  vfio: iommu_type1: Drop parameter "pgsize" of vfio_iova_dirty_bitmap.
  vfio: iommu_type1: Drop parameter "pgsize" of update_user_bitmap

 drivers/vfio/vfio_iommu_type1.c | 108 +++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 43 deletions(-)

-- 
2.23.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D612EBEED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhAFNkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:40:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10400 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAFNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:39:54 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D9r6F6dVDz7Qnm;
        Wed,  6 Jan 2021 21:38:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/6] IOMMU: Some more IOVA and core code tidy-up
Date:   Wed, 6 Jan 2021 21:35:05 +0800
Message-ID: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some tidy-up to IOVA and core code.

Based on v5.11-rc2

Differences to v1:
- Add core IOMMU patches

John Garry (6):
  iova: Make has_iova_flush_queue() private
  iova: Delete copy_reserved_iova()
  iova: Stop exporting some more functions
  iommu: Stop exporting iommu_map_sg_atomic()
  iommu: Delete iommu_domain_window_disable()
  iommu: Delete iommu_dev_has_feature()

 drivers/iommu/iommu.c | 21 ---------------------
 drivers/iommu/iova.c  | 36 +-----------------------------------
 include/linux/iommu.h | 13 -------------
 include/linux/iova.h  | 12 ------------
 4 files changed, 1 insertion(+), 81 deletions(-)

-- 
2.26.2


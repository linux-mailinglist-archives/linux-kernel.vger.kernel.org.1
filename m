Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C42969E7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375416AbgJWGsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:48:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S373117AbgJWGsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:48:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3CAF515D61C03B0106FB;
        Fri, 23 Oct 2020 14:48:29 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 23 Oct 2020 14:48:22 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <rui.xiang@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH] iommu: Modify the description of iommu_sva_unbind_device
Date:   Fri, 23 Oct 2020 06:48:27 +0000
Message-ID: <20201023064827.74794-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Jun <c00424029@huawei.com>

iommu_sva_unbind_device has no return value.

Remove the description of the return value of the function.

Signed-off-by: Chen Jun <c00424029@huawei.com>
---
 drivers/iommu/iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c470f4..bb51d53 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2995,8 +2995,6 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  * Put reference to a bond between device and address space. The device should
  * not be issuing any more transaction for this PASID. All outstanding page
  * requests for this PASID must have been flushed to the IOMMU.
- *
- * Returns 0 on success, or an error value
  */
 void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
-- 
2.7.4


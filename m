Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA741EB330
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 04:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFBCCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 22:02:33 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47609 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgFBCCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:02:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U-Ka7of_1591063350;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U-Ka7of_1591063350)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Jun 2020 10:02:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     joro@8bytes.org
Cc:     baolin.wang@linux.alibaba.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu: Improve exception handling in iommu_group_alloc()
Date:   Tue,  2 Jun 2020 10:02:23 +0800
Message-Id: <8bfd018ef4add083a35a6a94a8da045cf3af51b6.1591063271.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the exception handling to free the resources correctly when
failed to allocate an iommu group.

Fixes: bc7d12b91bd3 ("iommu: Implement reserved_regions iommu-group sysfs file")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Improve the commmit message.
 - Add Fixes tag.
---
 drivers/iommu/iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 03d6a26..ac91024 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -529,12 +529,18 @@ struct iommu_group *iommu_group_alloc(void)
 
 	ret = iommu_group_create_file(group,
 				      &iommu_group_attr_reserved_regions);
-	if (ret)
+	if (ret) {
+		kobject_put(group->devices_kobj);
 		return ERR_PTR(ret);
+	}
 
 	ret = iommu_group_create_file(group, &iommu_group_attr_type);
-	if (ret)
+	if (ret) {
+		iommu_group_remove_file(group,
+					&iommu_group_attr_reserved_regions);
+		kobject_put(group->devices_kobj);
 		return ERR_PTR(ret);
+	}
 
 	pr_debug("Allocated group %d\n", group->id);
 
-- 
1.8.3.1


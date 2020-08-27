Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6618C254123
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 10:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgH0IqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 04:46:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbgH0IqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:46:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28EC4C060D18D32208B2;
        Thu, 27 Aug 2020 16:46:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 27 Aug 2020 16:46:12 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Yuqi Jin <jinyuqi@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        "Shaokun Zhang" <zhangshaokun@hisilicon.com>
Subject: [PATCH] iommu/iova: Replace cmpxchg with xchg in queue_iova
Date:   Thu, 27 Aug 2020 16:43:54 +0800
Message-ID: <1598517834-30275-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuqi Jin <jinyuqi@huawei.com>

The performance of the atomic_xchg is better than atomic_cmpxchg because
no comparison is required. While the value of @fq_timer_on can only be 0
or 1. Let's use atomic_xchg instead of atomic_cmpxchg here because we
only need to check that the value changes from 0 to 1 or from 1 to 1.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 45a251da5453..30d969a4c5fd 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -579,7 +579,7 @@ void queue_iova(struct iova_domain *iovad,
 
 	/* Avoid false sharing as much as possible. */
 	if (!atomic_read(&iovad->fq_timer_on) &&
-	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
+	    !atomic_xchg(&iovad->fq_timer_on, 1))
 		mod_timer(&iovad->fq_timer,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
-- 
2.7.4


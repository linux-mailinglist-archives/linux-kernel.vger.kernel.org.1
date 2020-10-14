Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E163A28D80E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbgJNBkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:40:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731036AbgJNBkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:40:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D5738FD5C3064CE3E903;
        Wed, 14 Oct 2020 09:39:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 09:39:49 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <mika.westerberg@linux.intel.com>, <YehezkelShB@gmail.com>,
        <andriy.shevchenko@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH v2] thunderbolt: Add the missed ida_simple_remove() in ring_request_msix()
Date:   Wed, 14 Oct 2020 09:46:04 +0800
Message-ID: <20201014014604.167968-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ring_request_msix() misses to call ida_simple_remove() in an error path.
Add a label 'err_ida_remove' and jump to it.

Fixes: 046bee1f9ab8 ("thunderbolt: Add MSI-X support")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/thunderbolt/nhi.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 5f7489fa1327..e066888c4b41 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -406,11 +406,22 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	ring->vector = ret;
 
 	ring->irq = pci_irq_vector(ring->nhi->pdev, ring->vector);
-	if (ring->irq < 0)
-		return ring->irq;
+	if (ring->irq < 0) {
+		ret = ring->irq;
+		goto err_ida_remove;
+	}
 
 	irqflags = no_suspend ? IRQF_NO_SUSPEND : 0;
-	return request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);
+	ret = request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);
+	if (ret)
+		goto err_ida_remove;
+
+	return 0;
+
+err_ida_remove:
+	ida_simple_remove(&nhi->msix_ida, ring->vector);
+
+	return ret;
 }
 
 static void ring_release_msix(struct tb_ring *ring)
-- 
2.17.1


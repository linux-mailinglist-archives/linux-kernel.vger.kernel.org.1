Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2511AD714
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgDQHJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 03:09:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728155AbgDQHJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:09:48 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6BE99B2A999737E74F7D;
        Fri, 17 Apr 2020 15:09:46 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:09:39 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] dma-debug: make __dma_entry_alloc_check_leak() static
Date:   Fri, 17 Apr 2020 15:36:05 +0800
Message-ID: <20200417073605.43039-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

kernel/dma/debug.c:659:6: warning: symbol '__dma_entry_alloc_check_leak'
was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 9e1777c81f55..36c962a86bf2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -656,7 +656,7 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
-void __dma_entry_alloc_check_leak(void)
+static void __dma_entry_alloc_check_leak(void)
 {
 	u32 tmp = nr_total_entries % nr_prealloc_entries;
 
-- 
2.21.1


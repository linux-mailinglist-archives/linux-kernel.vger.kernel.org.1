Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728751AEB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDRJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 05:33:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgDRJdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:33:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B8A30C4901436DD4F0F3;
        Sat, 18 Apr 2020 17:32:59 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 17:32:50 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <linux@armlinux.org.uk>, <tglx@linutronix.de>,
        <yanaijie@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] arm: remove NULL check before some freeing functions
Date:   Sat, 18 Apr 2020 17:59:16 +0800
Message-ID: <20200418095916.35290-1-yanaijie@huawei.com>
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

Fix the following coccicheck warning:

arch/arm/common/dmabounce.c:564:2-18: WARNING: NULL check before some
freeing functions is not needed.
arch/arm/common/dmabounce.c:566:2-18: WARNING: NULL check before some
freeing functions is not needed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/arm/common/dmabounce.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index f4b719bde763..a7c776cdc38f 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -560,10 +560,8 @@ void dmabounce_unregister_dev(struct device *dev)
 		BUG();
 	}
 
-	if (device_info->small.pool)
-		dma_pool_destroy(device_info->small.pool);
-	if (device_info->large.pool)
-		dma_pool_destroy(device_info->large.pool);
+	dma_pool_destroy(device_info->small.pool);
+	dma_pool_destroy(device_info->large.pool);
 
 #ifdef STATS
 	if (device_info->attr_res == 0)
-- 
2.21.1


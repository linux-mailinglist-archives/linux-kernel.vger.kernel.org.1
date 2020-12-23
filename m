Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E92E1D42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgLWOPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:15:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9681 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgLWOPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:15:17 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1FYZ2WmWzkvSY;
        Wed, 23 Dec 2020 22:13:38 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:14:23 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <qiang.zhao@nxp.com>, <leoyang.li@nxp.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] soc: fsl: qe: Use DEFINE_SPINLOCK() for spinlock
Date:   Wed, 23 Dec 2020 22:14:59 +0800
Message-ID: <20201223141459.1058-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/soc/fsl/qe/qe_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
index 75075591f630..111a36be6983 100644
--- a/drivers/soc/fsl/qe/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -26,7 +26,7 @@
 #include <soc/fsl/qe/qe.h>
 
 static struct gen_pool *muram_pool;
-static spinlock_t cpm_muram_lock;
+static DEFINE_SPINLOCK(cpm_muram_lock);
 static u8 __iomem *muram_vbase;
 static phys_addr_t muram_pbase;
 
@@ -54,7 +54,6 @@ int cpm_muram_init(void)
 	if (muram_pbase)
 		return 0;
 
-	spin_lock_init(&cpm_muram_lock);
 	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
 	if (!np) {
 		/* try legacy bindings */
-- 
2.22.0


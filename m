Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA6F1BB6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 08:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgD1GdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 02:33:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726256AbgD1GdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:33:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4771C4C215F03E66B01A;
        Tue, 28 Apr 2020 14:33:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:32:58 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <rth@twiddle.net>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <linux-alpha@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] alpha: remove unneeded semicolon in sys_eiger.c
Date:   Tue, 28 Apr 2020 14:32:25 +0800
Message-ID: <20200428063225.24882-1-yanaijie@huawei.com>
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

arch/alpha/kernel/sys_eiger.c:179:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/alpha/kernel/sys_eiger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index 016f79251141..7e852c08cef2 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -176,7 +176,7 @@ eiger_swizzle(struct pci_dev *dev, u8 *pinp)
 	   case 0x03: bridge_count = 2; break; /* 2 */
 	   case 0x07: bridge_count = 3; break; /* 3 */
 	   case 0x0f: bridge_count = 4; break; /* 4 */
-	};
+	}
 
 	slot = PCI_SLOT(dev->devfn);
 	while (dev->bus->self) {
-- 
2.21.1


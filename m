Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BD12CE995
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgLDI3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:29:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8685 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgLDI3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:29:18 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnQnW45h2zkkCN;
        Fri,  4 Dec 2020 16:27:59 +0800 (CST)
Received: from compute.localdomain (10.175.112.70) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Dec 2020 16:28:26 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Smith <alex.smith@imgtec.com>
CC:     Zhang Changzhong <zhangchangzhong@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] memory: jz4780_nemc: Fix potential NULL dereference in jz4780_nemc_probe()
Date:   Fri, 4 Dec 2020 16:31:57 +0800
Message-ID: <1607070717-32880-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource() may fail and return NULL, so we should
better check it's return value to avoid a NULL pointer dereference
a bit later in the code.

This is detected by Coccinelle semantic patch.

@@
expression pdev, res, n, t, e, e1, e2;
@@

res = \(platform_get_resource\|platform_get_resource_byname\)(pdev, t,
n);
+ if (!res)
+   return -EINVAL;
... when != res == NULL
e = devm_ioremap(e1, res->start, e2);

Fixes: 911a88829725 ("memory: jz4780-nemc: driver for the NEMC on JZ4780 SoCs")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/memory/jz4780-nemc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index 3ec5cb0..465ea92 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -291,6 +291,8 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	nemc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 
 	/*
 	 * The driver currently only uses the registers up to offset
-- 
2.9.5


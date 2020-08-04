Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE123B6B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgHDIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 04:21:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgHDIVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:21:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF172A16A63BE924F049;
        Tue,  4 Aug 2020 16:21:14 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 4 Aug 2020 16:21:03 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] memory: jz4780-nemc: Fix return value check in jz4780_nemc_probe()
Date:   Tue, 4 Aug 2020 08:24:03 +0000
Message-ID: <20200804082403.76297-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: f046e4a3f0b9 ("memory: jz4780_nemc: Only request IO memory the driver will use")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/memory/jz4780-nemc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index 3ec5cb0fce1e..608ae925e641 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -304,9 +304,9 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
 	}
 
 	nemc->base = devm_ioremap(dev, res->start, NEMC_REG_LEN);
-	if (IS_ERR(nemc->base)) {
+	if (!nemc->base) {
 		dev_err(dev, "failed to get I/O memory\n");
-		return PTR_ERR(nemc->base);
+		return -ENOMEM;
 	}
 
 	writel(0, nemc->base + NEMC_NFCSR);




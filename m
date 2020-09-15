Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECA726A04C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgIOH72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:59:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12285 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbgIOH5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:57:13 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E86FA538C5EECBD3BFB2;
        Tue, 15 Sep 2020 15:56:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 15:56:47 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] soc: ti: pruss: Fix return value check
Date:   Tue, 15 Sep 2020 07:57:32 +0000
Message-ID: <20200915075732.100804-1-weiyongjun1@huawei.com>
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

In case of error, the function of_device_get_match_data() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: ba59c9b43c86 ("soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/ti/pruss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index cc0b4ad7a3d3..582f48051c30 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -126,7 +126,7 @@ static int pruss_clk_init(struct pruss *pruss, struct device_node *cfg_node)
 	int ret = 0;
 
 	data = of_device_get_match_data(dev);
-	if (IS_ERR(data))
+	if (!data)
 		return -ENODEV;
 
 	clks_np = of_get_child_by_name(cfg_node, "clocks");
@@ -175,7 +175,7 @@ static int pruss_probe(struct platform_device *pdev)
 	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
 
 	data = of_device_get_match_data(&pdev->dev);
-	if (IS_ERR(data)) {
+	if (!data) {
 		dev_err(dev, "missing private data\n");
 		return -ENODEV;
 	}




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9A12BBC23
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKUCLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:11:18 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8379 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgKUCLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:11:18 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CdH2R2PhFz708k;
        Sat, 21 Nov 2020 10:10:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 21 Nov 2020
 10:11:00 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <ulf.hansson@linaro.org>, <linus.walleij@linaro.org>,
        <robert.jarzmik@free.fr>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] mmc: pxamci: Fix error return code in pxamci_probe
Date:   Sat, 21 Nov 2020 10:14:31 +0800
Message-ID: <20201121021431.3168506-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return the error code from devm_gpiod_get_optional() instaed
of 0 in pxamci_probe().

Fixes: f54005b508b9a9d9c ("mmc: pxa: Use GPIO descriptor for power")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mmc/host/pxamci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 29f6180a0036..316393c694d7 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -731,6 +731,7 @@ static int pxamci_probe(struct platform_device *pdev)
 
 		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
 		if (IS_ERR(host->power)) {
+			ret = PTR_ERR(host->power);
 			dev_err(dev, "Failed requesting gpio_power\n");
 			goto out;
 		}
-- 
2.25.4


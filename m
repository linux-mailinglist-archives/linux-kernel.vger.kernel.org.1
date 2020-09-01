Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF57258DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIAMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 08:11:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727944AbgIAMBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:01:06 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5FEB41847D5DC89B8F1;
        Tue,  1 Sep 2020 20:00:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Sep 2020 20:00:50 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>
CC:     <alistair@popple.id.au>, <linux-fsi@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] fsi: Fix an IS_ERR() vs NULL check in occ_probe()
Date:   Tue, 1 Sep 2020 20:01:56 +0800
Message-ID: <20200901120156.140522-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_device_register_full() function returns error pointers,
it never returns NULL.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/fsi/fsi-occ.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 7da9c81759ac..9eeb856c8905 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -555,7 +555,7 @@ static int occ_probe(struct platform_device *pdev)
 
 	hwmon_dev_info.id = occ->idx;
 	hwmon_dev = platform_device_register_full(&hwmon_dev_info);
-	if (!hwmon_dev)
+	if (IS_ERR(hwmon_dev))
 		dev_warn(dev, "failed to create hwmon device\n");
 
 	return 0;
-- 
2.17.1


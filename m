Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861CD260C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgIHHcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 03:32:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53920 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729373AbgIHHco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:32:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3DF52FB945566D075C61;
        Tue,  8 Sep 2020 15:32:43 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 15:32:34 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <Al.Grant@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] coresight: Don't allocate pdata->conns when there is no output port
Date:   Tue, 8 Sep 2020 15:31:28 +0800
Message-ID: <1599550288-41724-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is no output port, coresight_alloc_conns() still do the following
copy connection information to pdata->conns, and this may cause kernel panic.
Let's fix it.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index bfd4423..cdc8824 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -26,12 +26,13 @@
 static int coresight_alloc_conns(struct device *dev,
 				 struct coresight_platform_data *pdata)
 {
-	if (pdata->nr_outport) {
-		pdata->conns = devm_kcalloc(dev, pdata->nr_outport,
-					    sizeof(*pdata->conns), GFP_KERNEL);
-		if (!pdata->conns)
-			return -ENOMEM;
-	}
+	if (!pdata->nr_outport)
+		return -ENOMEM;
+
+	pdata->conns = devm_kcalloc(dev, pdata->nr_outport,
+				    sizeof(*pdata->conns), GFP_KERNEL);
+	if (!pdata->conns)
+		return -ENOMEM;

 	return 0;
 }
--
2.8.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED92C0313
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgKWKPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:15:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7666 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKWKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:15:01 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cfjgh1Xn2z15RBb;
        Mon, 23 Nov 2020 18:14:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Nov 2020
 18:14:56 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <sre@kernel.org>
CC:     <gustavoars@kernel.org>, <carlos.chinea@nokia.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] HSI: Fix PM usage counter unbalance in ssi_hw_init
Date:   Mon, 23 Nov 2020 18:18:27 +0800
Message-ID: <20201123101827.3863792-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter
even it failed. Forgetting to putting operation will
result in reference leak here. We fix it by replacing
it with pm_runtime_resume_and_get to keep usage counter
balanced.

Fixes: b209e047bc743 ("HSI: Introduce OMAP SSI driver")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index fa69b94debd9..b4ac2f8cb9f9 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -424,7 +424,7 @@ static int ssi_hw_init(struct hsi_controller *ssi)
 	struct omap_ssi_controller *omap_ssi = hsi_controller_drvdata(ssi);
 	int err;
 
-	err = pm_runtime_get_sync(ssi->device.parent);
+	err = pm_runtime_resume_and_get(ssi->device.parent);
 	if (err < 0) {
 		dev_err(&ssi->device, "runtime PM failed %d\n", err);
 		return err;
-- 
2.25.4


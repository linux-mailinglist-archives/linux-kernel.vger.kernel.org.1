Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26A2BA3C7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgKTHpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:45:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8376 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgKTHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:45:38 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CcpVm0hcKz6yxL;
        Fri, 20 Nov 2020 15:45:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 15:45:29 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <jfrederich@gmail.com>, <dsd@laptop.org>,
        <jon.nettleton@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] staging: olpc_dcon: Do not call platform_device_unregister() in dcon_probe()
Date:   Fri, 20 Nov 2020 15:49:32 +0800
Message-ID: <20201120074932.31871-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dcon_probe(), when platform_device_add() failes to add the device,
it jumps to call platform_device_unregister() to remove the device,
which is unnecessary. So use platform_device_put() instead.

Fixes: 53c43c5ca133 ("Revert "Staging: olpc_dcon: Remove obsolete driver"")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index a0d6d90f4cc8..e7281212db5b 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -659,8 +659,9 @@ static int dcon_probe(struct i2c_client *client, const struct i2c_device_id *id)
  ecreate:
 	for (j = 0; j < i; j++)
 		device_remove_file(&dcon_device->dev, &dcon_device_files[j]);
+	platform_device_del(dcon_device);
  edev:
-	platform_device_unregister(dcon_device);
+	platform_device_put(dcon_device);
 	dcon_device = NULL;
  eirq:
 	free_irq(DCON_IRQ, dcon);
-- 
2.17.1


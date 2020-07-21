Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1D227AED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 10:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgGUIkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 04:40:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8343 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbgGUIke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:40:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1339A8827B0523C5260B;
        Tue, 21 Jul 2020 16:40:31 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 16:40:24 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH] tipc: remove set but not used variable 'no_warn'
Date:   Tue, 21 Jul 2020 16:40:23 +0800
Message-ID: <20200721084023.13402-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/base/module.c: In function 'module_add_driver':
drivers/base/module.c:33: warning:
variable 'no_warn' set but not used [-Wunused-but-set-variable]

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/base/module.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..d1060c504c1b 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -33,7 +33,6 @@ static void module_create_drivers_dir(struct module_kobject *mk)
 void module_add_driver(struct module *mod, struct device_driver *drv)
 {
 	char *driver_name;
-	int no_warn;
 	struct module_kobject *mk = NULL;
 
 	if (!drv)
@@ -59,11 +58,11 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 		return;
 
 	/* Don't check return codes; these calls are idempotent */
-	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
+	sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
 	driver_name = make_driver_name(drv);
 	if (driver_name) {
 		module_create_drivers_dir(mk);
-		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
+		sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
 					    driver_name);
 		kfree(driver_name);
 	}
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D232D24EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgLHHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:51:30 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9394 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLHHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:51:30 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cqsm85g5Vz7BCm;
        Tue,  8 Dec 2020 15:50:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Dec 2020 15:50:45 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/tidss: Use the new api devm_drm_irq_install
Date:   Tue, 8 Dec 2020 15:50:59 +0800
Message-ID: <1607413859-63365-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_drm_irq_install to register interrupts so that
drm_irq_uninstall is not needed to be called.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 66e3c86e..48e1f9d 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -173,7 +173,7 @@ static int tidss_probe(struct platform_device *pdev)
 		goto err_runtime_suspend;
 	}
 
-	ret = drm_irq_install(ddev, irq);
+	ret = devm_irq_install(ddev, irq);
 	if (ret) {
 		dev_err(dev, "drm_irq_install failed: %d\n", ret);
 		goto err_runtime_suspend;
@@ -219,8 +219,6 @@ static int tidss_remove(struct platform_device *pdev)
 
 	drm_atomic_helper_shutdown(ddev);
 
-	drm_irq_uninstall(ddev);
-
 #ifndef CONFIG_PM
 	/* If we don't have PM, we need to call suspend manually */
 	dispc_runtime_suspend(tidss->dispc);
-- 
2.7.4


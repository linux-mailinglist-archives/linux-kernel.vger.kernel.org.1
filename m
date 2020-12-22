Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86622E09E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 12:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgLVL4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 06:56:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10058 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgLVL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 06:56:40 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D0ZX46bZ1zM73H;
        Tue, 22 Dec 2020 19:55:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 19:55:51 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/hisilicon: Remove drm_dev_put in hibmc
Date:   Tue, 22 Dec 2020 19:55:56 +0800
Message-ID: <1608638156-7879-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hibmc use the devm_drm_dev_alloc function in hibmc_pci_probe, if
hibmc_pci_probe returns non-zero, devm_drm_dev_alloc will call
devm_drm_dev_init, which will call devm_drm_dev_init_release to
release drm_dev_put. There is no need for hibmc to call
drm_dev_put separately.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 7159018..0d4e902 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -332,13 +332,13 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	ret = pcim_enable_device(pdev);
 	if (ret) {
 		drm_err(dev, "failed to enable pci device: %d\n", ret);
-		goto err_free;
+		goto err_return;
 	}
 
 	ret = hibmc_load(dev);
 	if (ret) {
 		drm_err(dev, "failed to load hibmc: %d\n", ret);
-		goto err_free;
+		goto err_return;
 	}
 
 	ret = drm_dev_register(dev, 0);
@@ -354,9 +354,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 
 err_unload:
 	hibmc_unload(dev);
-err_free:
-	drm_dev_put(dev);
-
+err_return:
 	return ret;
 }
 
-- 
2.7.4


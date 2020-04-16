Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08DA1AB535
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405924AbgDPBEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 21:04:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbgDPBD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:03:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 511AECE2DF5AD434AC1E;
        Thu, 16 Apr 2020 09:03:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Apr 2020 09:03:44 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/hisilicon: Add the shutdown for hibmc_pci_driver
Date:   Thu, 16 Apr 2020 09:02:54 +0800
Message-ID: <1586998974-24234-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the shutdown function to release the resource.

v2:
Remove the unnecessary unmap function.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index a6fd0c2..0250a10 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -337,7 +337,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret) {
 		DRM_ERROR("failed to enable pci device: %d\n", ret);
 		goto err_free;
@@ -376,6 +376,11 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 	drm_dev_put(dev);
 }
 
+static void hibmc_pci_shutdown(struct pci_dev *pdev)
+{
+	hibmc_pci_remove(pdev);
+}
+
 static struct pci_device_id hibmc_pci_table[] = {
 	{ PCI_VDEVICE(HUAWEI, 0x1711) },
 	{0,}
@@ -386,6 +391,7 @@ static struct pci_driver hibmc_pci_driver = {
 	.id_table =	hibmc_pci_table,
 	.probe =	hibmc_pci_probe,
 	.remove =	hibmc_pci_remove,
+	.shutdown =	hibmc_pci_shutdown,
 	.driver.pm =    &hibmc_pm_ops,
 };
 
-- 
2.7.4


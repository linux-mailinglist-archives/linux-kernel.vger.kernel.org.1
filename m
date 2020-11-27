Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047EC2C5EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 04:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392305AbgK0DOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 22:14:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8598 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbgK0DOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 22:14:25 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cj08K4S4TzLt25;
        Fri, 27 Nov 2020 11:13:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 11:14:21 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <hdegoede@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/vboxvideo: Used the vram helper
Date:   Fri, 27 Nov 2020 11:14:42 +0800
Message-ID: <1606446882-36335-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if the driver uses drmm_vram_helper_init, there is no need to
call drm_vram_helper_release_mm when the drm module get unloaded,
as this will done automagically.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/vboxvideo/vbox_ttm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_ttm.c b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
index f5a0667..e1909a8 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_ttm.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
@@ -16,8 +16,8 @@ int vbox_mm_init(struct vbox_private *vbox)
 	int ret;
 	struct drm_device *dev = &vbox->ddev;
 
-	vmm = drm_vram_helper_alloc_mm(dev, pci_resource_start(dev->pdev, 0),
-				       vbox->available_vram_size);
+	vmm = drmm_vram_helper_init(dev, pci_resource_start(dev->pdev, 0),
+				    vbox->available_vram_size);
 	if (IS_ERR(vmm)) {
 		ret = PTR_ERR(vmm);
 		DRM_ERROR("Error initializing VRAM MM; %d\n", ret);
@@ -32,5 +32,4 @@ int vbox_mm_init(struct vbox_private *vbox)
 void vbox_mm_fini(struct vbox_private *vbox)
 {
 	arch_phys_wc_del(vbox->fb_mtrr);
-	drm_vram_helper_release_mm(&vbox->ddev);
 }
-- 
2.7.4


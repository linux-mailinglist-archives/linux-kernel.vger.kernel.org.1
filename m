Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0229E411
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgJ2Hac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:30:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6666 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgJ2H3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:29:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMGnW4lsVz15NwL;
        Thu, 29 Oct 2020 15:11:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 15:11:07 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/hisilicon: Adding a const declaration to an invariant construct
Date:   Thu, 29 Oct 2020 15:11:45 +0800
Message-ID: <1603955505-43942-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some constructs cannot be changed after being assigned a value,
so add const declarations to invariant constructs.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c  | 2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index a1eabad..ef18b47 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -139,7 +139,7 @@ static const u32 channel_formats1[] = {
 	DRM_FORMAT_ABGR8888
 };
 
-static struct drm_plane_funcs hibmc_plane_funcs = {
+static const struct drm_plane_funcs hibmc_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_cleanup,
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 0c1b40d..fee6fe8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -369,7 +369,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 	drm_dev_put(dev);
 }
 
-static struct pci_device_id hibmc_pci_table[] = {
+static const struct pci_device_id hibmc_pci_table[] = {
 	{ PCI_VDEVICE(HUAWEI, 0x1711) },
 	{0,}
 };
-- 
2.7.4


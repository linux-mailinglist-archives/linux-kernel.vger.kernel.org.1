Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68B2DA69C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 04:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgLODCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 22:02:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9446 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgLODCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:02:21 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cw31D2XWXzhs5l;
        Tue, 15 Dec 2020 11:01:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 11:01:29 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/hisilicon: Fix rmmod hibmc_drm failed
Date:   Tue, 15 Dec 2020 11:01:39 +0800
Message-ID: <1608001299-7237-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_irq_uninstall should be called before pci_disable_msi, if use
devm_drm_irq_install to register the interrupt, the system will
call pci_disable_msi first and then call drm_irq_uninstall, which
 will result in the following callstack.

kernel BUG at drivers/pci/msi.c:376!
Internal error: Oops - BUG: 0 [#1] SMP
CPU: 93 PID: 173814 Comm: rmmod Tainted:
pstate: a0400009 (NzCv daif +PAN -UAO -TCO BTYPE=--)
pc : free_msi_irqs+0x17c/0x1a0
lr : free_msi_irqs+0x16c/0x1a0
sp : ffff2028157f7bd0
x29: ffff2028157f7bd0 x28: ffff202849edab00
x27: 0000000000000000 x26: 0000000000000000
x25: 0000000000000000 x24: 0000000000000000
x23: ffff0020851da000 x22: ffff0020851da2d8
x21: ffff0020cc829000 x20: 0000000000000000
x19: ffff0020d6714800 x18: 0000000000000010
x17: 0000000000000000 x16: 0000000000000000
x15: ffffffffffffffff x14: ffff2028957f77df
x13: ffff2028157f77ed x12: 0000000000000000
x11: 0000000000000040 x10: ffff800011b2f8e0
x9 : ffff800011b2f8d8 x8 : ffff2020203fc458
x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff2020203fc430 x4 : ffff2020203fc4a0
x3 : 0000000000000000 x2 : 0000000000000000
x1 : 00000000000002c9 x0 : ffff0020d6719500
Call trace:
 free_msi_irqs+0x17c/0x1a0
 pci_disable_msi+0xe4/0x118
 hibmc_unload+0x44/0x80 [hibmc_drm]
 hibmc_pci_remove+0x2c/0x38 [hibmc_drm]
 pci_device_remove+0x48/0x108
 device_release_driver_internal+0x118/0x1f0
 driver_detach+0x6c/0xe0
 bus_remove_driver+0x74/0x100
 driver_unregister+0x34/0x60
 pci_unregister_driver+0x24/0xd8
 hibmc_pci_driver_exit+0x14/0xe768 [hibmc_drm]
 __arm64_sys_delete_module+0x1fc/0x2d0
 el0_svc_common.constprop.3+0xa8/0x188
 do_el0_svc+0x80/0xa0
 el0_sync_handler+0x8c/0xb0
 el0_sync+0x15c/0x180
Code: f940b400 b4ffff00 a903e7b8 f90013b5 (d4210000)
---[ end trace 310d94ee8abef44f ]---
Kernel panic - not syncing: Oops - BUG: Fatal exception

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index e3ab765b..02f3bd1 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -251,6 +251,10 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
 static int hibmc_unload(struct drm_device *dev)
 {
 	drm_atomic_helper_shutdown(dev);
+
+	if (dev->irq_enabled)
+		drm_irq_uninstall(dev);
+
 	pci_disable_msi(dev->pdev);
 
 	return 0;
@@ -286,7 +290,7 @@ static int hibmc_load(struct drm_device *dev)
 	if (ret) {
 		drm_warn(dev, "enabling MSI failed: %d\n", ret);
 	} else {
-		ret = devm_drm_irq_install(dev, dev->pdev->irq);
+		ret = drm_irq_install(dev, dev->pdev->irq);
 		if (ret)
 			drm_warn(dev, "install irq failed: %d\n", ret);
 	}
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4992DAC62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLOLuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:50:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9891 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgLOLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:49:52 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CwGjb2W9Kz7GgC;
        Tue, 15 Dec 2020 19:48:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 19:48:45 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH drm/hisilicon 1/2] drm/irq: Add the new api to enable pci msi
Date:   Tue, 15 Dec 2020 19:48:52 +0800
Message-ID: <1608032933-50187-2-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608032933-50187-1-git-send-email-tiantao6@hisilicon.com>
References: <1608032933-50187-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new api devm_drm_msi_install() to register interrupts,
no need to call pci_disable_msi() when the drm module is removed.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/drm_irq.c | 33 +++++++++++++++++++++++++++++++++
 include/drm/drm_irq.h     |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index 803af4b..da58b2c 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -246,6 +246,39 @@ int devm_drm_irq_install(struct drm_device *dev, int irq)
 }
 EXPORT_SYMBOL(devm_drm_irq_install);
 
+static void devm_drm_msi_uninstall(void *data)
+{
+	struct drm_device *dev = (struct drm_device *)data;
+
+	pci_disable_msi(dev->pdev);
+}
+
+/**
+ * devm_drm_msi_install - install IRQ handler
+ * @dev: DRM device
+ *
+ * devm_drm_msi_install is a  help function of pci_enable_msi.
+ *
+ * if the driver uses devm_drm_msi_install, there is no need
+ * to call pci_disable_msi when the drm module get unloaded,
+ * as this will done automagically.
+ *
+ * Returns:
+ * Zero on success or a negative error code on failure.
+ */
+int devm_drm_msi_install(struct drm_device *dev)
+{
+	int ret;
+
+	ret = pci_enable_msi(dev->pdev);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev->dev,
+					devm_drm_msi_uninstall, dev);
+}
+EXPORT_SYMBOL(devm_drm_msi_install);
+
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
 int drm_legacy_irq_control(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv)
diff --git a/include/drm/drm_irq.h b/include/drm/drm_irq.h
index 631b22f..c8dff45 100644
--- a/include/drm/drm_irq.h
+++ b/include/drm/drm_irq.h
@@ -29,4 +29,5 @@ struct drm_device;
 int drm_irq_install(struct drm_device *dev, int irq);
 int drm_irq_uninstall(struct drm_device *dev);
 int devm_drm_irq_install(struct drm_device *dev, int irq);
+int devm_drm_msi_install(struct drm_device *dev);
 #endif
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F112CB8C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgLBJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:27:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9092 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgLBJ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:27:20 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CmD9R4CxNzLy8c;
        Wed,  2 Dec 2020 17:26:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 17:26:35 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v2 2/3] drm/irq: Add the new api to install irq
Date:   Wed, 2 Dec 2020 17:26:51 +0800
Message-ID: <1606901212-8214-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606901212-8214-1-git-send-email-tiantao6@hisilicon.com>
References: <1606901212-8214-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new api devm_drm_irq_install() to register interrupts,
no need to call drm_irq_uninstall() when the drm module is removed.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/drm_irq.c | 32 ++++++++++++++++++++++++++++++++
 include/drm/drm_irq.h     |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index 09d6e9e..803af4b 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -214,6 +214,38 @@ int drm_irq_uninstall(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_irq_uninstall);
 
+static void devm_drm_irq_uninstall(void *data)
+{
+	drm_irq_uninstall(data);
+}
+
+/**
+ * devm_drm_irq_install - install IRQ handler
+ * @dev: DRM device
+ * @irq: IRQ number to install the handler for
+ *
+ * devm_drm_irq_install is a  help function of drm_irq_install.
+ *
+ * if the driver uses devm_drm_irq_install, there is no need
+ * to call drm_irq_uninstall when the drm module get unloaded,
+ * as this will done automagically.
+ *
+ * Returns:
+ * Zero on success or a negative error code on failure.
+ */
+int devm_drm_irq_install(struct drm_device *dev, int irq)
+{
+	int ret;
+
+	ret = drm_irq_install(dev, irq);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev->dev,
+					devm_drm_irq_uninstall, dev);
+}
+EXPORT_SYMBOL(devm_drm_irq_install);
+
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
 int drm_legacy_irq_control(struct drm_device *dev, void *data,
 			   struct drm_file *file_priv)
diff --git a/include/drm/drm_irq.h b/include/drm/drm_irq.h
index d77f6e6..631b22f 100644
--- a/include/drm/drm_irq.h
+++ b/include/drm/drm_irq.h
@@ -28,5 +28,5 @@ struct drm_device;
 
 int drm_irq_install(struct drm_device *dev, int irq);
 int drm_irq_uninstall(struct drm_device *dev);
-
+int devm_drm_irq_install(struct drm_device *dev, int irq);
 #endif
-- 
2.7.4


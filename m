Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B442CA1F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgLAL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:56:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8173 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgLAL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:56:27 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ClgX445Qmz15VtD;
        Tue,  1 Dec 2020 19:55:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 19:55:37 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v2 3/4] drm/irq: Add the new api to install irq
Date:   Tue, 1 Dec 2020 19:55:53 +0800
Message-ID: <1606823754-52451-4-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606823754-52451-1-git-send-email-tiantao6@hisilicon.com>
References: <1606823754-52451-1-git-send-email-tiantao6@hisilicon.com>
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
 drivers/gpu/drm/drm_irq.c | 35 +++++++++++++++++++++++++++++++++++
 include/drm/drm_irq.h     |  2 +-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index 09d6e9e..b363dec 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -214,6 +214,41 @@ int drm_irq_uninstall(struct drm_device *dev)
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
+	ret = devm_add_action_or_reset(dev->dev, devm_drm_irq_uninstall, dev);
+	if (ret)
+		devm_drm_irq_uninstall(dev);
+
+	return ret;
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


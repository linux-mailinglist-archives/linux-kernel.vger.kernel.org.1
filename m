Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2CE2A3814
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKCA4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:56:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6691 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCA4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:56:41 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQBF03mq6z15Qnf;
        Tue,  3 Nov 2020 08:56:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 08:56:37 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: Add the new api to install irq
Date:   Tue, 3 Nov 2020 08:57:13 +0800
Message-ID: <1604365033-60277-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
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
 drivers/gpu/drm/drm_drv.c | 23 +++++++++++++++++++++++
 include/drm/drm_drv.h     |  3 ++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index cd162d4..f4a15b5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -39,6 +39,7 @@
 #include <drm/drm_color_mgmt.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
+#include <drm/drm_irq.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_mode_object.h>
 #include <drm/drm_print.h>
@@ -678,6 +679,28 @@ static int devm_drm_dev_init(struct device *parent,
 	return ret;
 }
 
+static void devm_drm_dev_irq_uninstall(void *data)
+{
+	drm_irq_uninstall(data);
+}
+
+int devm_drm_irq_install(struct device *parent,
+			 struct drm_device *dev, int irq)
+{
+	int ret;
+
+	ret = drm_irq_install(dev, irq);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action(parent, devm_drm_dev_irq_uninstall, &irq);
+	if (ret)
+		devm_drm_dev_irq_uninstall(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(devm_drm_irq_install);
+
 void *__devm_drm_dev_alloc(struct device *parent, struct drm_driver *driver,
 			   size_t size, size_t offset)
 {
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 0230762..fec1776 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -513,7 +513,8 @@ struct drm_driver {
 
 void *__devm_drm_dev_alloc(struct device *parent, struct drm_driver *driver,
 			   size_t size, size_t offset);
-
+int devm_drm_irq_install(struct device *parent, struct drm_device *dev,
+			 int irq);
 /**
  * devm_drm_dev_alloc - Resource managed allocation of a &drm_device instance
  * @parent: Parent device object
-- 
2.7.4


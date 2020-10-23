Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B5296874
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 04:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374518AbgJWCLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 22:11:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S374437AbgJWCLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 22:11:04 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 99216345CE1515F6B48B;
        Fri, 23 Oct 2020 10:11:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Fri, 23 Oct 2020 10:10:53 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <sam@ravnborg.org>, <andrzej.p@collabora.com>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] drm: Add the missed device_unregister() in drm_sysfs_connector_add()
Date:   Fri, 23 Oct 2020 10:16:48 +0800
Message-ID: <20201023021648.39214-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_sysfs_connector_add() misses to call device_unregister() when
sysfs_create_link() fails to create. Add the missed function call
to fix it.

Fixes: e1a29c6c5955 ("drm: Add ddc link in sysfs created by drm_connector")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/gpu/drm/drm_sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index f0336c804639..39e173e10cf7 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -274,6 +274,7 @@ static const struct attribute_group *connector_dev_groups[] = {
 int drm_sysfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	int ret = 0;
 
 	if (connector->kdev)
 		return 0;
@@ -291,10 +292,16 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 		return PTR_ERR(connector->kdev);
 	}
 
-	if (connector->ddc)
-		return sysfs_create_link(&connector->kdev->kobj,
+	if (connector->ddc) {
+		ret = sysfs_create_link(&connector->kdev->kobj,
 				 &connector->ddc->dev.kobj, "ddc");
-	return 0;
+		if (ret) {
+			device_unregister(connector->kdev);
+			connector->kdev = NULL;
+		}
+	}
+
+	return ret;
 }
 
 void drm_sysfs_connector_remove(struct drm_connector *connector)
-- 
2.17.1


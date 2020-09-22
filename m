Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B602741DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIVMOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:14:35 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:33187 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVMOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:14:35 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id BC3364E1651;
        Tue, 22 Sep 2020 20:14:32 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernie Thompson <bernie@plugable.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] video: use kobj_to_dev()
Date:   Tue, 22 Sep 2020 20:14:24 +0800
Message-Id: <1600776867-24226-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGU1NT0pNSE5MT01IVkpNS0tMTE1DTEhKS0NVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6Ljo4HD8YAg4wMA5IOEkV
        LEkwCjJVSlVKTUtLTExNQ0xITktNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFISkhJNwY+
X-HM-Tid: 0a74b5bca43c9376kuwsbc3364e1651
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 4 ++--
 drivers/video/fbdev/udlfb.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 3fe509c..878c39a
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2200,7 +2200,7 @@ static ssize_t radeon_show_edid1(struct file *filp, struct kobject *kobj,
 				 struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
@@ -2212,7 +2212,7 @@ static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
 				 struct bin_attribute *bin_attr,
 				 char *buf, loff_t off, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct fb_info *info = dev_get_drvdata(dev);
         struct radeonfb_info *rinfo = info->par;
 
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 5b014b4..f9b3c1c
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1457,7 +1457,7 @@ static ssize_t edid_show(
 			struct file *filp,
 			struct kobject *kobj, struct bin_attribute *a,
 			 char *buf, loff_t off, size_t count) {
-	struct device *fbdev = container_of(kobj, struct device, kobj);
+	struct device *fbdev = kobj_to_dev(kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
 
@@ -1479,7 +1479,7 @@ static ssize_t edid_store(
 			struct file *filp,
 			struct kobject *kobj, struct bin_attribute *a,
 			char *src, loff_t src_off, size_t src_size) {
-	struct device *fbdev = container_of(kobj, struct device, kobj);
+	struct device *fbdev = kobj_to_dev(kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
 	int ret;
-- 
2.7.4


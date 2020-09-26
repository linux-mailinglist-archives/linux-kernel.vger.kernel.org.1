Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE027976C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 09:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIZHDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 03:03:49 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:35455 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 03:03:49 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 9256D4E1559;
        Sat, 26 Sep 2020 15:03:46 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] chrome: Use kobj_to_dev() instead
Date:   Sat, 26 Sep 2020 15:03:37 +0800
Message-Id: <1601103820-14002-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT08YQkJMQ00aGEhKVkpNS0pKS0hDSU1DSEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRQ6PQw6TD8vPAECSjczHh8a
        DhIaCS5VSlVKTUtKSktIQ0lMT05KVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJTEpDNwY+
X-HM-Tid: 0a74c9398f4b9376kuws9256d4e1559
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() instead of container_of().

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 2 +-
 drivers/platform/chrome/cros_ec_vbc.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index d45ea5d..a643ea8
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -326,7 +326,7 @@ static struct attribute *__ec_attrs[] = {
 static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
 				    struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
 	if (a == &dev_attr_kb_wake_angle.attr && !ec->has_kb_wake_angle)
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 46482d1..f3a70a3
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -17,7 +17,7 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
 				  struct bin_attribute *att, char *buf,
 				  loff_t pos, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct cros_ec_device *ecdev = ec->ec_dev;
 	struct ec_params_vbnvcontext *params;
@@ -57,7 +57,7 @@ static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
 				   struct bin_attribute *attr, char *buf,
 				   loff_t pos, size_t count)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct cros_ec_device *ecdev = ec->ec_dev;
 	struct ec_params_vbnvcontext *params;
-- 
2.7.4


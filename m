Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CACA2FD81E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391837AbhATSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:17:27 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:41062 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391916AbhATSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:10:07 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CB7D030E75;
        Wed, 20 Jan 2021 09:58:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CB7D030E75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611165517;
        bh=bQd0SIEIkVCWGxUXiM5yxBPv/iyhr01PKnBuwTbvuyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcpiVIgmmMmjMRySgrIAd2rTE18e0Reevv3kPhhVmL6ywMxJYCVBdKRZzNttQDtLO
         g/WxRW7cg0z9Qe/8E6KUUXQrvZDas4QEXUtTfWeS0KdXkmSu/XXWRyQO6tVlbGGErB
         CGWpXVft1YDNIMrlIgPemhfGfDKoaYZi9TnakE0g=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        James Hu <james.hu@broadcom.com>
Subject: [PATCH v9 07/13] misc: bcm-vk: add ioctl load_image
Date:   Wed, 20 Jan 2021 09:58:21 -0800
Message-Id: <20210120175827.14820-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210120175827.14820-1-scott.branden@broadcom.com>
References: <20210120175827.14820-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ioctl support to issue load_image operation to VK card.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Co-developed-by: James Hu <james.hu@broadcom.com>
Signed-off-by: James Hu <james.hu@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Olof Johansson <olof@lixom.net>
---
 drivers/misc/bcm-vk/bcm_vk.h     |  3 +
 drivers/misc/bcm-vk/bcm_vk_dev.c | 95 ++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 5f0fcfdaf265..726aab71bb6b 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/sched/signal.h>
+#include <linux/uaccess.h>
 #include <uapi/linux/misc/bcm_vk.h>
 
 #include "bcm_vk_msg.h"
@@ -220,6 +221,8 @@ struct bcm_vk {
 
 	struct bcm_vk_dauth_info dauth_info;
 
+	/* mutex to protect the ioctls */
+	struct mutex mutex;
 	struct miscdevice miscdev;
 	int devid; /* dev id allocated */
 
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index 79fffb1e6f84..203a1cf2bae3 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -10,6 +10,7 @@
 #include <linux/idr.h>
 #include <linux/kref.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <uapi/linux/misc/bcm_vk.h>
@@ -580,6 +581,71 @@ static void bcm_vk_wq_handler(struct work_struct *work)
 	}
 }
 
+static long bcm_vk_load_image(struct bcm_vk *vk,
+			      const struct vk_image __user *arg)
+{
+	struct device *dev = &vk->pdev->dev;
+	const char *image_name;
+	struct vk_image image;
+	u32 next_loadable;
+	enum soc_idx idx;
+	int image_idx;
+	int ret = -EPERM;
+
+	if (copy_from_user(&image, arg, sizeof(image)))
+		return -EACCES;
+
+	if ((image.type != VK_IMAGE_TYPE_BOOT1) &&
+	    (image.type != VK_IMAGE_TYPE_BOOT2)) {
+		dev_err(dev, "invalid image.type %u\n", image.type);
+		return ret;
+	}
+
+	next_loadable = bcm_vk_next_boot_image(vk);
+	if (next_loadable != image.type) {
+		dev_err(dev, "Next expected image %u, Loading %u\n",
+			next_loadable, image.type);
+		return ret;
+	}
+
+	/*
+	 * if something is pending download already.  This could only happen
+	 * for now when the driver is being loaded, or if someone has issued
+	 * another download command in another shell.
+	 */
+	if (test_and_set_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload) != 0) {
+		dev_err(dev, "Download operation already pending.\n");
+		return ret;
+	}
+
+	image_name = image.filename;
+	if (image_name[0] == '\0') {
+		/* Use default image name if NULL */
+		idx = get_soc_idx(vk);
+		if (idx == VK_IDX_INVALID)
+			goto err_idx;
+
+		/* Image idx starts with boot1 */
+		image_idx = image.type - VK_IMAGE_TYPE_BOOT1;
+		image_name = get_load_fw_name(vk, &image_tab[idx][image_idx]);
+		if (!image_name) {
+			dev_err(dev, "No suitable image found for type %d",
+				image.type);
+			ret = -ENOENT;
+			goto err_idx;
+		}
+	} else {
+		/* Ensure filename is NULL terminated */
+		image.filename[sizeof(image.filename) - 1] = '\0';
+	}
+	ret = bcm_vk_load_image_by_type(vk, image.type, image_name);
+	dev_info(dev, "Load %s, ret %d\n", image_name, ret);
+err_idx:
+	clear_bit(BCM_VK_WQ_DWNLD_PEND, vk->wq_offload);
+
+	return ret;
+}
+
 static void bcm_to_v_reset_doorbell(struct bcm_vk *vk, u32 db_val)
 {
 	vkwrite32(vk, db_val, BAR_0, VK_BAR0_RESET_DB_BASE);
@@ -636,10 +702,38 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
 	return 0;
 }
 
+static long bcm_vk_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	long ret = -EINVAL;
+	struct bcm_vk_ctx *ctx = file->private_data;
+	struct bcm_vk *vk = container_of(ctx->miscdev, struct bcm_vk, miscdev);
+	void __user *argp = (void __user *)arg;
+
+	dev_dbg(&vk->pdev->dev,
+		"ioctl, cmd=0x%02x, arg=0x%02lx\n",
+		cmd, arg);
+
+	mutex_lock(&vk->mutex);
+
+	switch (cmd) {
+	case VK_IOCTL_LOAD_IMAGE:
+		ret = bcm_vk_load_image(vk, argp);
+		break;
+
+	default:
+		break;
+	}
+
+	mutex_unlock(&vk->mutex);
+
+	return ret;
+}
+
 static const struct file_operations bcm_vk_fops = {
 	.owner = THIS_MODULE,
 	.open = bcm_vk_open,
 	.release = bcm_vk_release,
+	.unlocked_ioctl = bcm_vk_ioctl,
 };
 
 static int bcm_vk_on_panic(struct notifier_block *nb,
@@ -670,6 +764,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 
 	kref_init(&vk->kref);
+	mutex_init(&vk->mutex);
 
 	err = pci_enable_device(pdev);
 	if (err) {
-- 
2.17.1


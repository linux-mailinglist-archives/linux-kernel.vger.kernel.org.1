Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0427F761
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgJAB3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbgJAB2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:28:52 -0400
Received: from mail-vk1-xa62.google.com (mail-vk1-xa62.google.com [IPv6:2607:f8b0:4864:20::a62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A3C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:51 -0700 (PDT)
Received: by mail-vk1-xa62.google.com with SMTP id b4so741266vkh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HQs2Qnt4yBrCD1+M7eU08HdvBhWQd9QwBfGtQr/7WFI=;
        b=JS8ez8p3Nbh3wLq4IeyXlvL7bULGRQuy8jlrXINixGeOsd8ohYjzZWyDxzoBdIoWLD
         c8YYDXgjT/dQFQJMGSgehMVnhTE6Ii1xyVcBDI8BZUSH/Ov+PfUiWQ8uX4XnIeTPxwxh
         LKFpJ0oV9T1ThRn1mFwrG3gn3NWTLaIDFB3Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HQs2Qnt4yBrCD1+M7eU08HdvBhWQd9QwBfGtQr/7WFI=;
        b=Vvwmk15WAxRyyvHxSdjVpVuBXsdsV80p/7gY3DLnsUZnMvQD1BNHefqJIcocs/zHMb
         O8uS1v9mUXbMcRp/VMkV2ap/Ojupx3bvl22dohcA67YqZKlG5NKtCv0y7yeeNpd8w1bI
         uodAMHyIsE4GDuDzsDTsDP9neRH1qvgwGPmBcmtd2eBfx74iI22XHLOG5x+OutWaidXg
         R3SjNKc93kqL+VuucDB7nIbQL3AiFR0e0olFYoB4SOSgAH4wJPSJlNmKqbzoYy+6MhgJ
         b4Esl1jB/gxDJHHtUS80hYn+sCs6clTJFtWvxnyIn5O0+lSBpO6GBq62qruvdfHDvj7g
         l8nQ==
X-Gm-Message-State: AOAM532JQwg9fHk7ZcjQcSS8jZS50bPb7qUlRRTjan/9PRYhnydz7WVy
        Tww4enkaK2Ea9t6/L0LnLUFOJi5pF+YmfHwGy9SXSP3wh2q5
X-Google-Smtp-Source: ABdhPJxb1sUqqcmb86r0eTTNT2y2PT82yyewnQvy0zJMSrGTNjkfeeIWZ45vkWajUcbAnHMyAWqdwWUkUFYl
X-Received: by 2002:a1f:bf8c:: with SMTP id p134mr3514043vkf.12.1601515731048;
        Wed, 30 Sep 2020 18:28:51 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id r25sm520472vkq.14.2020.09.30.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:28:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: [PATCH v5 07/15] misc: bcm-vk: add ioctl load_image
Date:   Wed, 30 Sep 2020 18:28:02 -0700
Message-Id: <20201001012810.4172-8-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001012810.4172-1-scott.branden@broadcom.com>
References: <20201001012810.4172-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ioctl support to issue load_image operation to VK card.

Co-developed-by: Desmond Yan <desmond.yan@broadcom.com>
Signed-off-by: Desmond Yan <desmond.yan@broadcom.com>
Co-developed-by: James Hu <james.hu@broadcom.com>
Signed-off-by: James Hu <james.hu@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
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
index 4bcbd507803d..77af701cf579 100644
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
@@ -631,10 +697,38 @@ static int bcm_vk_trigger_reset(struct bcm_vk *vk)
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
@@ -665,6 +759,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -ENOMEM;
 
 	kref_init(&vk->kref);
+	mutex_init(&vk->mutex);
 
 	err = pci_enable_device(pdev);
 	if (err) {
-- 
2.17.1


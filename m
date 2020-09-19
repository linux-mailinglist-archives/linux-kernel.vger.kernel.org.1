Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F368270FA8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgISQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 12:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgISQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 12:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600534297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UFAsa3tRCTxoYQqS5npiFBGpHrLn/BNkxVqCHi9t7lQ=;
        b=hIuLI5mxXiCS9/xd03eblMrNqgYqcHefv/EY+bSy4njsH4ADrBV0aIEAx4oh2roq07G+OO
        YigC4UrwZRz/IUrirUSj9QpPlDlzbFE4ST5A+ITjQTtJ94zerwvuC2Xw4WRY9R3AxIzmwV
        6j41ShSt/bo8ZgWSuIvLfZtjq8Bkf3Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-H6frdDSENyKxjzaSZ9U11w-1; Sat, 19 Sep 2020 12:51:35 -0400
X-MC-Unique: H6frdDSENyKxjzaSZ9U11w-1
Received: by mail-qv1-f71.google.com with SMTP id t7so5874299qvz.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 09:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UFAsa3tRCTxoYQqS5npiFBGpHrLn/BNkxVqCHi9t7lQ=;
        b=YE8mI9QZ3spDHgfx6gq7zPI+dsYeQ73w9XMVaa5eadV8yderiLN5NYqAscoINA2z2D
         iIADdAtxTB8990K79d3oeoJ49PouEidYdlekGc0wX0H6dmV4hSlPAmfI9n2BHOndcwu/
         FZmrgB5JBroJSF2cS153kxtW+BOOsi77kzvMg6Ypp729pLHVWXwuFh+VCjeWSB9cnM+M
         C1MKrQuDCUxb3lWvSYOUFNEs1wLNdsKHRVdt4V0m+mtdZp3USQu2uDp9wmGpg9n006h0
         9IDveY5xRJEBgD8chvSoWu2iIX0h4dw40RmRI025P9qFCM+vb4Hyv8KdMvl78VCPl7EN
         RVmA==
X-Gm-Message-State: AOAM532UFT7KHs/qCzHUOrz8Pr2rdRS4G/3RM8gTtZ9oGJy2n0SkM2dY
        jrfhYLvELkLDRtJLFNm9LoFl11FzrpaPiMqVGEpJnZY2eNI90thTo5kU3DfPgvH6MVmR2mO6h8/
        OA/5EIa+V2subaG3os4ClUVO+
X-Received: by 2002:a37:a887:: with SMTP id r129mr35517758qke.263.1600534295051;
        Sat, 19 Sep 2020 09:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2tJKcHoL3ryORmXmYIVv38yj+uItZt/LP5bMwyyhrOXJv+itP6uV1bBu0d8gZKzMEGANXGg==
X-Received: by 2002:a37:a887:: with SMTP id r129mr35517739qke.263.1600534294707;
        Sat, 19 Sep 2020 09:51:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d5sm5283381qtm.36.2020.09.19.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 09:51:34 -0700 (PDT)
From:   trix@redhat.com
To:     yilun.xu@intel.com, alex.williamson@redhat.com, hao.wu@intel.com,
        mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [RFC] fpga: dfl: a prototype uio driver
Date:   Sat, 19 Sep 2020 09:51:13 -0700
Message-Id: <20200919165113.5219-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

I following up on Moritz asking for early RFC's by showing how this
could be done with the concrete example of around

[PATCH 0/3] add VFIO mdev support for DFL devices

I hacked this together, it barely works. Do not expect that this
patch to apply anywhere.  It has enough to show where I want
to go and people can comment without me having invested a lot of
effort.  I am not expecting to carry this forward, it only
addresses the issues I had with the origin patch.

This change adds a uio driver for any unclaimed dfl feature

During the normal matching of feature id's to drivers, some
of the features are not claimed because there neither a
builtin driver nor a module driver that matches the feature
id.  For these unclaimed features, provide a uio driver to a
possible user space driver.

I have doubts that a uio for an afu feature is approptiate as these
can be any device.

Another possible problem is if the number of interrupts for the
feature is greater than 1.  Uio seems to only support 1. My guess
is this would need some hackery in the open() to add to the
interrupt handler.

It is for this type of reason I think a dfl-uio driver is needed
rather than reusing an existing generic uio driver.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-main.c |   9 ++-
 drivers/fpga/dfl-uio.c      | 107 ++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.c          |  47 +++++++++++++++-
 drivers/fpga/dfl.h          |   8 +++
 4 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 drivers/fpga/dfl-uio.c

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 037dc4f..3323e90 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -709,12 +709,18 @@ static int fme_probe(struct platform_device *pdev)
 	if (ret)
 		goto dev_destroy;
 
-	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
+	ret = dfl_fpga_dev_feature_init_uio(pdev, DFH_TYPE_FIU);
 	if (ret)
 		goto feature_uinit;
 
+	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
+	if (ret)
+		goto feature_uinit_uio;
+
 	return 0;
 
+feature_uinit_uio:
+	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
 feature_uinit:
 	dfl_fpga_dev_feature_uinit(pdev);
 dev_destroy:
@@ -726,6 +732,7 @@ exit:
 static int fme_remove(struct platform_device *pdev)
 {
 	dfl_fpga_dev_ops_unregister(pdev);
+	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
 	dfl_fpga_dev_feature_uinit(pdev);
 	fme_dev_destroy(pdev);
 
diff --git a/drivers/fpga/dfl-uio.c b/drivers/fpga/dfl-uio.c
new file mode 100644
index 0000000..185fbab
--- /dev/null
+++ b/drivers/fpga/dfl-uio.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * prototype dfl uio driver
+ *
+ * Copyright Tom Rix 2020
+ */
+#include <linux/module.h>
+#include "dfl.h"
+
+static irqreturn_t dfl_uio_handler(int irq, struct uio_info *dev_info)
+{
+	return IRQ_HANDLED;
+}
+
+static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static int dfl_uio_open(struct uio_info *info, struct inode *inode)
+{
+	return 0;
+}
+
+static int dfl_uio_release(struct uio_info *info, struct inode *inode)
+{
+	return 0;
+}
+
+static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
+{
+	return 0;
+}
+
+int dfl_uio_add(struct dfl_feature *feature)
+{
+	struct uio_info *uio;
+	struct resource *res =
+		&feature->dev->resource[feature->resource_index];
+	int ret = 0;
+
+	uio = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
+	if (!uio) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	uio->name = kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
+	if (!uio->name) {
+		ret = -ENOMEM;
+		goto err_name;
+	}
+
+	uio->version = "0.1";
+	uio->mem[0].memtype = UIO_MEM_PHYS;
+	uio->mem[0].addr = res->start & PAGE_MASK;
+	uio->mem[0].offs = res->start & ~PAGE_MASK;
+	uio->mem[0].size = (uio->mem[0].offs + resource_size(res)
+			    + PAGE_SIZE - 1) & PAGE_MASK;
+	/* How are nr_irqs > 1 handled ??? */
+	if (feature->nr_irqs == 1)
+		uio->irq = feature->irq_ctx[0].irq;
+	uio->handler = dfl_uio_handler;
+	uio->mmap = dfl_uio_mmap;
+	uio->open = dfl_uio_open;
+	uio->release = dfl_uio_release;
+	uio->irqcontrol = dfl_uio_irqcontrol;
+
+	ret = uio_register_device(&feature->dev->dev, uio);
+	if (ret)
+		goto err_register;
+
+	feature->uio = uio;
+exit:
+	return ret;
+err_register:
+	kfree(uio->name);
+err_name:
+	kfree(uio);
+	goto exit;
+}
+EXPORT_SYMBOL_GPL(dfl_uio_add);
+
+int dfl_uio_remove(struct dfl_feature *feature)
+{
+	uio_unregister_device(feature->uio);
+	kfree(feature->uio->name);
+	kfree(feature->uio);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dfl_uio_remove);
+
+static int __init dfl_uio_init(void)
+{
+	return 0;
+}
+
+static void __exit dfl_uio_exit(void)
+{
+}
+
+module_init(dfl_uio_init);
+module_exit(dfl_uio_exit);
+
+MODULE_DESCRIPTION("DFL UIO prototype driver");
+MODULE_AUTHOR("Tom");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 1305be4..26de8e1 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -663,10 +664,57 @@ exit:
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init);
 
+int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int dfh_type)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature *feature;
+	int ret;
+
+	dfl_fpga_dev_for_each_feature(pdata, feature) {
+		if (dfh_type == DFH_TYPE_FIU) {
+			if (feature->id == FEATURE_ID_FIU_HEADER ||
+			    feature->id == FEATURE_ID_AFU)
+			continue;
+
+			/* give the unclamined feature to uio */
+			if (!feature->ioaddr) {
+				ret = dfl_uio_add(feature);
+				if (ret)
+					goto exit;
+			}
+		}
+	}
+
+	return 0;
+exit:
+	dfl_fpga_dev_feature_uinit_uio(pdev, dfh_type);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init_uio);
+
+int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int dfh_type)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature *feature;
+	int ret = 0;
+
+	dfl_fpga_dev_for_each_feature(pdata, feature) {
+		if (dfh_type == DFH_TYPE_FIU) {
+			if (feature->id == FEATURE_ID_FIU_HEADER ||
+			    feature->id == FEATURE_ID_AFU)
+				continue;
+
+			if (feature->uio)
+				ret |= dfl_uio_remove(feature);
+		}
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit_uio);
+
 static void dfl_chardev_uinit(void)
 {
 	int i;
-
 	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
 		if (MAJOR(dfl_chrdevs[i].devt)) {
 			unregister_chrdev_region(dfl_chrdevs[i].devt,
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index a85d1cd..6e37aef 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/uuid.h>
+#include <linux/uio_driver.h>
 #include <linux/fpga/fpga-region.h>
 
 /* maximum supported number of ports */
@@ -232,6 +233,7 @@ struct dfl_feature_irq_ctx {
  * struct dfl_feature - sub feature of the feature devices
  *
  * @dev: ptr to pdev of the feature device which has the sub feature.
+ * @uio: for fallback uio driver.
  * @id: sub feature id.
  * @index: unique identifier for an sub feature within the feature device.
  *	   It is possible that multiply sub features with same feature id are
@@ -248,6 +250,7 @@ struct dfl_feature_irq_ctx {
  */
 struct dfl_feature {
 	struct platform_device *dev;
+	struct uio_info *uio;
 	u64 id;
 	int index;
 	int resource_index;
@@ -360,6 +363,11 @@ void dfl_fpga_dev_feature_uinit(struct platform_device *pdev);
 int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 			      struct dfl_feature_driver *feature_drvs);
 
+int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int dfh_type);
+int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int dfh_type);
+int dfl_uio_add(struct dfl_feature *feature);
+int dfl_uio_remove(struct dfl_feature *feature);
+
 int dfl_fpga_dev_ops_register(struct platform_device *pdev,
 			      const struct file_operations *fops,
 			      struct module *owner);
-- 
2.18.1


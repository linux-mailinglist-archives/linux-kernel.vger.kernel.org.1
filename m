Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9632947A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 07:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440306AbgJUFCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 01:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407064AbgJUFCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 01:02:32 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004EC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:02:31 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j185so775573qkf.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 22:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=H1Lpn6UoEj5PVWYB2Wejig2mFfb8Z0BbDdfzCVtYiCc=;
        b=g5N7TOKLZhmTRS1gD/CUDfbKoK+laACC7HVqyVNgMlzZWgozLj0UiBbSDzi9aRHYKv
         Txc9sGsjStTuOKb3rw4S4kwOsbKNf5XfB4xXHcyb01B+p9qV1JJ5oVYoCVVsHDFSkylA
         I5YHc4iSVxh5Isa1f9mVA5KbQKGWIQCg0+SjcU0cGKl3FH6AwQrLNabRcM//fDR0yu+g
         JnkIC4SKdSGdYPsMDfbI1hou7fkghTprrg8JABnPsGyVgv8iGBaRGJQV+U8DykK3clY2
         K/QhiyKxDzRh2SwBTkLuPElbuE7PU6EJ40+e+a/RJqYmSapWN2sF8KxPeYAs5YESREkk
         zRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=H1Lpn6UoEj5PVWYB2Wejig2mFfb8Z0BbDdfzCVtYiCc=;
        b=gG7S10HfxneN3UpE6fvNKexVVADpC9Yox8IAQjMEL/5Mhlo5zps/Fjaff6/5CHFQg/
         HicL6/ypOykK3TJULoTGzHFjUcx81fmckbpULO4cfh6wpftRWlkZTeYLMpsPNzhQTpaL
         PsP8oXcO4MHSELpbgpVpoEO1FB8qAvb88jQ4lWm7rvA2v3YlRnjNCS1gU2hG15CqHROs
         8XN419dQvb6fYR9VyN3+coH15/gGctjSCB5clHyNPMNNdxZfxptfHcA2Mez2YAa0p7xy
         9KVF7TM3kZu4DvBRpwZntz6TToFNIgHPbf+7BDqMm5wGdQdW0Fwfj1A3yIajY/DQqjhz
         81Qw==
X-Gm-Message-State: AOAM530jjPSMhYfAvQGrdSyzHHEPiI7hetw73RLnG1ezJGrqIQT+roP3
        P6w4syqyWfpKuHhheTea0jF1/VdfAtRIM9graIN0HjjhHTnVaU2vuC6xp+qLoZLSQ9bGwkc/z2n
        M2XDGOlBoDm3ZMDloR3oQzwN5oz0GHjsOmctNySDI30ZN/S2atSE7DqboW41pORLIUgprbXu0
X-Google-Smtp-Source: ABdhPJzGluMbB77e4TuBR4xiexEUTa76snso3Y5djnfXv2WiWykQv2WuwxnecAtbxeNnOedmiRV5EZYoYNb8
Sender: "furquan via sendgmr" <furquan@furquan.mtv.corp.google.com>
X-Received: from furquan.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:ad4:59cf:: with SMTP id
 el15mr1321502qvb.17.1603256550949; Tue, 20 Oct 2020 22:02:30 -0700 (PDT)
Date:   Tue, 20 Oct 2020 22:01:41 -0700
Message-Id: <20201021050141.377787-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] firmware: gsmi: Drop the use of dma_pool_* API functions
From:   Furquan Shaikh <furquan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Ard Biesheuvel <ardb@kernel.org>, dlaurie@google.com,
        Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSMI driver uses dma_pool_* API functions for buffer allocation
because it requires that the SMI buffers are allocated within 32-bit
physical address space. However, this does not work well with IOMMU
since there is no real device and hence no domain associated with the
device.

Since this is not a real device, it does not require any device
address(IOVA) for the buffer allocations. The only requirement is to
ensure that the physical address allocated to the buffer is within
32-bit physical address space. This change allocates a page using
`get_zeroed_page()` and passes in GFP_DMA32 flag to ensure that the
page allocation is done in the DMA32 zone. All the buffer allocation
requests for gsmi_buf are then satisfed using this pre-allocated page
for the device.

In addition to that, all the code for managing the dma_pool for GSMI
platform device is dropped.

Signed-off-by: Furquan Shaikh <furquan@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/firmware/google/gsmi.c | 100 +++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 7d9367b22010..054c47346900 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -17,7 +17,6 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
-#include <linux/dmapool.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/ioctl.h>
@@ -46,7 +45,6 @@
 #define DRIVER_VERSION		"1.0"
 #define GSMI_GUID_SIZE		16
 #define GSMI_BUF_SIZE		1024
-#define GSMI_BUF_ALIGN		sizeof(u64)
 #define GSMI_CALLBACK		0xef
 
 /* SMI return codes */
@@ -85,10 +83,15 @@
 struct gsmi_buf {
 	u8 *start;			/* start of buffer */
 	size_t length;			/* length of buffer */
-	dma_addr_t handle;		/* dma allocation handle */
 	u32 address;			/* physical address of buffer */
 };
 
+struct gsmi_page {
+	unsigned long base_address;	/* Base address of allocated page */
+	size_t alloc_size;		/* Size of allocation */
+	size_t alloc_used;		/* Amount of allocation that is used */
+};
+
 static struct gsmi_device {
 	struct platform_device *pdev;	/* platform device */
 	struct gsmi_buf *name_buf;	/* variable name buffer */
@@ -97,7 +100,7 @@ static struct gsmi_device {
 	spinlock_t lock;		/* serialize access to SMIs */
 	u16 smi_cmd;			/* SMI command port */
 	int handshake_type;		/* firmware handler interlock type */
-	struct dma_pool *dma_pool;	/* DMA buffer pool */
+	struct gsmi_page *page_info;	/* page allocated for GSMI buffers */
 } gsmi_dev;
 
 /* Packed structures for communicating with the firmware */
@@ -146,9 +149,57 @@ MODULE_PARM_DESC(spincount,
 static bool s0ix_logging_enable;
 module_param(s0ix_logging_enable, bool, 0600);
 
+static struct gsmi_page *gsmi_page_alloc(void)
+{
+	struct gsmi_page *page_info;
+
+	page_info = kzalloc(sizeof(*page_info), GFP_KERNEL);
+	if (!page_info) {
+		printk(KERN_ERR "gsmi: out of memory\n");
+		return NULL;
+	}
+
+	page_info->base_address = get_zeroed_page(GFP_KERNEL | GFP_DMA32);
+	if (!page_info->base_address) {
+		printk(KERN_ERR "gsmi: failed to allocate page for buffers\n");
+		return NULL;
+	}
+
+	/* Ensure the entire buffer is allocated within 32bit address space */
+	if (virt_to_phys((void *)(page_info->base_address + PAGE_SIZE - 1))
+	    >> 32) {
+		printk(KERN_ERR "gsmi: allocation not within 32-bit physical address space\n");
+		free_page(page_info->base_address);
+		kfree(page_info);
+		return NULL;
+	}
+
+	page_info->alloc_size = PAGE_SIZE;
+
+	return page_info;
+}
+
+static unsigned long gsmi_page_allocate_buffer(void)
+{
+	struct gsmi_page *page_info = gsmi_dev.page_info;
+	unsigned long buf_offset = page_info->alloc_used;
+
+	if (buf_offset + GSMI_BUF_SIZE > page_info->alloc_size) {
+		printk(KERN_ERR "gsmi: out of space for buffer allocation\n");
+		return 0;
+	}
+
+	page_info->alloc_used = buf_offset + GSMI_BUF_SIZE;
+	return page_info->base_address + buf_offset;
+}
+
 static struct gsmi_buf *gsmi_buf_alloc(void)
 {
 	struct gsmi_buf *smibuf;
+	u8 *buf_addr = (u8 *)gsmi_page_allocate_buffer();
+
+	if (!buf_addr)
+		return NULL;
 
 	smibuf = kzalloc(sizeof(*smibuf), GFP_KERNEL);
 	if (!smibuf) {
@@ -156,14 +207,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 		return NULL;
 	}
 
-	/* allocate buffer in 32bit address space */
-	smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
-				       &smibuf->handle);
-	if (!smibuf->start) {
-		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
-		kfree(smibuf);
-		return NULL;
-	}
+	smibuf->start = buf_addr;
 
 	/* fill in the buffer handle */
 	smibuf->length = GSMI_BUF_SIZE;
@@ -172,13 +216,15 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 	return smibuf;
 }
 
-static void gsmi_buf_free(struct gsmi_buf *smibuf)
+static void gsmi_free_alloc(void)
 {
-	if (smibuf) {
-		if (smibuf->start)
-			dma_pool_free(gsmi_dev.dma_pool, smibuf->start,
-				      smibuf->handle);
-		kfree(smibuf);
+	kfree(gsmi_dev.param_buf);
+	kfree(gsmi_dev.data_buf);
+	kfree(gsmi_dev.name_buf);
+
+	if (gsmi_dev.page_info) {
+		free_page(gsmi_dev.page_info->base_address);
+		kfree(gsmi_dev.page_info);
 	}
 }
 
@@ -914,10 +960,12 @@ static __init int gsmi_init(void)
 	spin_lock_init(&gsmi_dev.lock);
 
 	ret = -ENOMEM;
-	gsmi_dev.dma_pool = dma_pool_create("gsmi", &gsmi_dev.pdev->dev,
-					     GSMI_BUF_SIZE, GSMI_BUF_ALIGN, 0);
-	if (!gsmi_dev.dma_pool)
+
+	gsmi_dev.page_info = gsmi_page_alloc();
+	if (!gsmi_dev.page_info) {
+		printk(KERN_ERR "gsmi: failed to allocate page\n");
 		goto out_err;
+	}
 
 	/*
 	 * pre-allocate buffers because sometimes we are called when
@@ -1029,10 +1077,7 @@ static __init int gsmi_init(void)
 	sysfs_remove_bin_file(gsmi_kobj, &eventlog_bin_attr);
 out_err:
 	kobject_put(gsmi_kobj);
-	gsmi_buf_free(gsmi_dev.param_buf);
-	gsmi_buf_free(gsmi_dev.data_buf);
-	gsmi_buf_free(gsmi_dev.name_buf);
-	dma_pool_destroy(gsmi_dev.dma_pool);
+	gsmi_free_alloc();
 	platform_device_unregister(gsmi_dev.pdev);
 	pr_info("gsmi: failed to load: %d\n", ret);
 #ifdef CONFIG_PM
@@ -1054,10 +1099,7 @@ static void __exit gsmi_exit(void)
 	sysfs_remove_files(gsmi_kobj, gsmi_attrs);
 	sysfs_remove_bin_file(gsmi_kobj, &eventlog_bin_attr);
 	kobject_put(gsmi_kobj);
-	gsmi_buf_free(gsmi_dev.param_buf);
-	gsmi_buf_free(gsmi_dev.data_buf);
-	gsmi_buf_free(gsmi_dev.name_buf);
-	dma_pool_destroy(gsmi_dev.dma_pool);
+	gsmi_free_alloc();
 	platform_device_unregister(gsmi_dev.pdev);
 #ifdef CONFIG_PM
 	platform_driver_unregister(&gsmi_driver_info);
-- 
2.29.0.rc1.297.gfa9743e501-goog


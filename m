Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97AF2958E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505951AbgJVHQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505859AbgJVHQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:16:19 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F83C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:16:19 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id i39so501785qtb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ssrbKCfMPAjxzYbf9o/0gIkN7bnphajxsBoDslYwatw=;
        b=sdof8g2kr+EAe1mBDbdOxyrVQ1kkkiHfmDFdtlaqj5e6rneUXVoBDD7nYgdHyq4d/d
         QpOFbj9sD2MwQ23+xRIiwTFN+YDthS63cfI06LePsaW7l7u3n98mGz5SXaAtStxOGc8e
         I4FQB3KbC6V6w9Ra+HH7s2hsDYPINoaU4dQa01XgcKrPU0NFRr81zuHHDo4NfvpxYaIu
         nz+vTmjGzAw7Zz0vujb/GHisV15xHUvz4Qbe8XeU/Ys8HdsncvXi5B8X36xO7/vqaaOo
         C6s/l1nGPAb0mGtCnqkbutOzrzd1sljFaV4uE39yiesFNNQEhOcsVsTAqShHouBQ2Hbx
         simw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ssrbKCfMPAjxzYbf9o/0gIkN7bnphajxsBoDslYwatw=;
        b=hCwxSsDLdaWnWK5la2OFlDkNVyweWnDlAL5SC7g7yTDIQ/wfoCeqyST0Kd9zArotlf
         FL2ZR+ss2//NaVjd8j9pGb5a6iluzQdkgwoweVAvQv6q56jeRaNareUFWVLrzjxXqBE7
         LCfxP4zmjW41MfZ324dOBPsg7CmWfcQIUBhSSZ9OYbSFwLR/6s6/SFIZDY25rdBSS+dg
         k5bJ2Brahpm72evpdoSEEXLyJzw1pl5AUlQelpbScU2TcsIONVpoTqN4+KzJxZlj60jf
         0aKVW7Ke+bkluxV46Kf+MJbk2wQsxtUX5kprWtUcE/DsQOFFqLvRYfRYXs4vgWwmTbto
         1WMg==
X-Gm-Message-State: AOAM530G22QhhhOYAzjmor5EMzZJ0WlwgmyFIE7eofU+gPm7JOL6/96I
        YM+BdI1UXmRUvtg93z1K6f0ykDCLRiSEbqpJgFZGuWKSqH62JT2qtxtWGoFnPQ429FOiIAfwXA1
        TSVxDO3pzs8hysacFdbq8GyXPKNHG98AITCEWsx65YmNEgHtLe8fGs7RBAgKR4ZSEIXW87dTx
X-Google-Smtp-Source: ABdhPJyg1OmKQzjfHWENt3Z02PhB1Ct/dkjs4xsb+f+8HABGuxcKWBBn+0y3/ChVHPlUit/EvglB1svA9lu3
Sender: "furquan via sendgmr" <furquan@furquan.mtv.corp.google.com>
X-Received: from furquan.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:ad4:4e47:: with SMTP id
 eb7mr1130118qvb.34.1603350978111; Thu, 22 Oct 2020 00:16:18 -0700 (PDT)
Date:   Thu, 22 Oct 2020 00:15:50 -0700
In-Reply-To: <CAMj1kXFUEjs9UYjCe+LB7s=O_jwLaeYdr51rU6HS_q_Vd65yuw@mail.gmail.com>
Message-Id: <20201022071550.1192947-1-furquan@google.com>
Mime-Version: 1.0
References: <CAMj1kXFUEjs9UYjCe+LB7s=O_jwLaeYdr51rU6HS_q_Vd65yuw@mail.gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v3] firmware: gsmi: Drop the use of dma_pool_* API functions
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
32-bit physical address space. This is because the buffers have
nothing to do with DMA at all. It is required for communication with
firmware executing in SMI mode which has access only to the bottom
4GiB of memory. Hence, this change switches to using a SLAB cache
created with SLAB_CACHE_DMA32 that guarantees that the allocation
happens from the DMA32 memory zone. All calls to dma_pool_* are
replaced with kmem_cache_*.

In addition to that, all the code for managing the dma_pool for GSMI
platform device is dropped.

Signed-off-by: Furquan Shaikh <furquan@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
Changelog since v2:
- Dropped the check to ensure allocation done by kmem_cache_alloc is
below the 4GiB boundary since DMA32 memory zone guarantees that.
- Added Reviewed-by based on response from Ard.

Changelog since v1:
- Switched to using SLAB cache with SLAB_CACHE_DMA32.
- Added comment to code and commit message explaining the reason for
using DMA32 memory zone.

 drivers/firmware/google/gsmi.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 7d9367b22010..3d77f26c1e8c 100644
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
@@ -85,7 +84,6 @@
 struct gsmi_buf {
 	u8 *start;			/* start of buffer */
 	size_t length;			/* length of buffer */
-	dma_addr_t handle;		/* dma allocation handle */
 	u32 address;			/* physical address of buffer */
 };
 
@@ -97,7 +95,7 @@ static struct gsmi_device {
 	spinlock_t lock;		/* serialize access to SMIs */
 	u16 smi_cmd;			/* SMI command port */
 	int handshake_type;		/* firmware handler interlock type */
-	struct dma_pool *dma_pool;	/* DMA buffer pool */
+	struct kmem_cache *mem_pool;	/* kmem cache for gsmi_buf allocations */
 } gsmi_dev;
 
 /* Packed structures for communicating with the firmware */
@@ -157,8 +155,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 	}
 
 	/* allocate buffer in 32bit address space */
-	smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
-				       &smibuf->handle);
+	smibuf->start = kmem_cache_alloc(gsmi_dev.mem_pool, GFP_KERNEL);
 	if (!smibuf->start) {
 		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
 		kfree(smibuf);
@@ -176,8 +173,7 @@ static void gsmi_buf_free(struct gsmi_buf *smibuf)
 {
 	if (smibuf) {
 		if (smibuf->start)
-			dma_pool_free(gsmi_dev.dma_pool, smibuf->start,
-				      smibuf->handle);
+			kmem_cache_free(gsmi_dev.mem_pool, smibuf->start);
 		kfree(smibuf);
 	}
 }
@@ -914,9 +910,20 @@ static __init int gsmi_init(void)
 	spin_lock_init(&gsmi_dev.lock);
 
 	ret = -ENOMEM;
-	gsmi_dev.dma_pool = dma_pool_create("gsmi", &gsmi_dev.pdev->dev,
-					     GSMI_BUF_SIZE, GSMI_BUF_ALIGN, 0);
-	if (!gsmi_dev.dma_pool)
+
+	/*
+	 * SLAB cache is created using SLAB_CACHE_DMA32 to ensure that the
+	 * allocations for gsmi_buf come from the DMA32 memory zone. These
+	 * buffers have nothing to do with DMA. They are required for
+	 * communication with firmware executing in SMI mode which can only
+	 * access the bottom 4GiB of physical memory. Since DMA32 memory zone
+	 * guarantees allocation under the 4GiB boundary, this driver creates
+	 * a SLAB cache with SLAB_CACHE_DMA32 flag.
+	 */
+	gsmi_dev.mem_pool = kmem_cache_create("gsmi", GSMI_BUF_SIZE,
+					      GSMI_BUF_ALIGN,
+					      SLAB_CACHE_DMA32, NULL);
+	if (!gsmi_dev.mem_pool)
 		goto out_err;
 
 	/*
@@ -1032,7 +1039,7 @@ static __init int gsmi_init(void)
 	gsmi_buf_free(gsmi_dev.param_buf);
 	gsmi_buf_free(gsmi_dev.data_buf);
 	gsmi_buf_free(gsmi_dev.name_buf);
-	dma_pool_destroy(gsmi_dev.dma_pool);
+	kmem_cache_destroy(gsmi_dev.mem_pool);
 	platform_device_unregister(gsmi_dev.pdev);
 	pr_info("gsmi: failed to load: %d\n", ret);
 #ifdef CONFIG_PM
@@ -1057,7 +1064,7 @@ static void __exit gsmi_exit(void)
 	gsmi_buf_free(gsmi_dev.param_buf);
 	gsmi_buf_free(gsmi_dev.data_buf);
 	gsmi_buf_free(gsmi_dev.name_buf);
-	dma_pool_destroy(gsmi_dev.dma_pool);
+	kmem_cache_destroy(gsmi_dev.mem_pool);
 	platform_device_unregister(gsmi_dev.pdev);
 #ifdef CONFIG_PM
 	platform_driver_unregister(&gsmi_driver_info);
-- 
2.29.0.rc1.297.gfa9743e501-goog


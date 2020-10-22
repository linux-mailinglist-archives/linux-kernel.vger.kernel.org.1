Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B1295759
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507584AbgJVEiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444118AbgJVEiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:38:51 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD23C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:38:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a12so455559ybc.20
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3UykBvsQ09dE5s+oiOG4eNmRYLZ38L3j98qXIP/unS4=;
        b=uLYVEaKQNGAqWRlKq8Dk8YFTT0JFmMdelpifOaQfFW60zfqH01R8RBCgZ7UOz/idmv
         5owh98r7v0rHMUzZ+1581jsLytkJ6vYu9l0BAImoPDgOYcs+vNHeb5aty9UhBa7vsvJq
         zJDcprbJ573cCBDG7J2BjiBLbJ8nO4Hl40a9smUfNgfWv3ZHB6JRXxEu/PZF8SQGnzhq
         bNVanQ0jQAvo7yWcOotQJoyK3o9S1XHj5uPkIAkiJ0V+84dJoKF8WSDFphv9aOxEjjkE
         OeJSSVCYjrdk7OwISuqQRh1XFv2KVebUAwB4HV2n6tEkHBy5a5G6e9b/ysucC+MozLeT
         o5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3UykBvsQ09dE5s+oiOG4eNmRYLZ38L3j98qXIP/unS4=;
        b=dFJF6KKg4LUl++UDim4oSD4R0ZeCLRIBmpbJEv4AkESGFqtHpwkWj9bj7hSe+zUDwZ
         gEW4JqQT1oBblobTsVJATL4yMykvlBiIzzPg5aYN/sHgv4n0Q6myCwrOnOoS+wyTYhMU
         CciNIRZ4D8CMwTktqEFY0+GE7vpCcvXoCIOSm6Jlm7upTK9FJJ82mCJfyQROP+SmXz62
         qXn5sng5wao0zbU3DoHtJBewAPu93xdZpikzqrLCwej4A0PFHX1AFI91eCt+ES7EXZoA
         wBUnvcc0G+UFzHm3uBpIfsBue+5kLcJThubH0OgFyD7sZbe0mywy/CCtbJzqUTfte5LW
         sr1Q==
X-Gm-Message-State: AOAM530vAWDJg0aWpMb45Pn46OYwbXCGkNUZcWh+nAyRAozMBAJ2hMVu
        o/hAvDCXXFuFv9B9BBioCM4TpLfJk08KUG7zWFSRI1y6h/a5nrHM3MdImukBxbMltt2xIpMhEd0
        TIZu9zO05Ck61gV6msJs0MT8hXuLs1aC8oQ36ac3CApntFu+ahfeS8B5dR3TgrYbnshb9dtTx
X-Google-Smtp-Source: ABdhPJyAQkCoWPKqbYXld7YyQSbTiqQNSTcmFSw+vZxAjk0IQh255RJzIgPxppNvL032BvQKFSZpuEziDZn/
Sender: "furquan via sendgmr" <furquan@furquan.mtv.corp.google.com>
X-Received: from furquan.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:a25:4c1:: with SMTP id 184mr833541ybe.318.1603341530642;
 Wed, 21 Oct 2020 21:38:50 -0700 (PDT)
Date:   Wed, 21 Oct 2020 21:38:36 -0700
In-Reply-To: <CAEGmHFGDLvySk83Y8n_NdPEqAvNSVCnjt++eWQ5sMFRuzJ19dA@mail.gmail.com>
Message-Id: <20201022043836.1120024-1-furquan@google.com>
Mime-Version: 1.0
References: <CAEGmHFGDLvySk83Y8n_NdPEqAvNSVCnjt++eWQ5sMFRuzJ19dA@mail.gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2] firmware: gsmi: Drop the use of dma_pool_* API functions
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
---
Changelog since v1:
- Switched to using SLAB cache with SLAB_CACHE_DMA32.
- Added comment to code and commit message explaining the reason for
using DMA32 memory zone.

 drivers/firmware/google/gsmi.c | 38 +++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 7d9367b22010..092d8cb209a3 100644
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
@@ -157,14 +155,20 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 	}
 
 	/* allocate buffer in 32bit address space */
-	smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
-				       &smibuf->handle);
+	smibuf->start = kmem_cache_alloc(gsmi_dev.mem_pool, GFP_KERNEL);
 	if (!smibuf->start) {
 		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
 		kfree(smibuf);
 		return NULL;
 	}
 
+	if ((u64)virt_to_phys(smibuf->start) >> 32) {
+		printk(KERN_ERR "gsmi: allocation not within 32-bit physical address space\n");
+		kfree(smibuf->start);
+		kfree(smibuf);
+		return NULL;
+	}
+
 	/* fill in the buffer handle */
 	smibuf->length = GSMI_BUF_SIZE;
 	smibuf->address = (u32)virt_to_phys(smibuf->start);
@@ -176,8 +180,7 @@ static void gsmi_buf_free(struct gsmi_buf *smibuf)
 {
 	if (smibuf) {
 		if (smibuf->start)
-			dma_pool_free(gsmi_dev.dma_pool, smibuf->start,
-				      smibuf->handle);
+			kmem_cache_free(gsmi_dev.mem_pool, smibuf->start);
 		kfree(smibuf);
 	}
 }
@@ -914,9 +917,20 @@ static __init int gsmi_init(void)
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
@@ -1032,7 +1046,7 @@ static __init int gsmi_init(void)
 	gsmi_buf_free(gsmi_dev.param_buf);
 	gsmi_buf_free(gsmi_dev.data_buf);
 	gsmi_buf_free(gsmi_dev.name_buf);
-	dma_pool_destroy(gsmi_dev.dma_pool);
+	kmem_cache_destroy(gsmi_dev.mem_pool);
 	platform_device_unregister(gsmi_dev.pdev);
 	pr_info("gsmi: failed to load: %d\n", ret);
 #ifdef CONFIG_PM
@@ -1057,7 +1071,7 @@ static void __exit gsmi_exit(void)
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


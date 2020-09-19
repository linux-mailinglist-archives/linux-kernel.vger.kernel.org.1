Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114DA270B91
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgISHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:49:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E7DC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:49:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d6so4943930pfn.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=euqT8lAbNK8yda4fe5ZlU/VWsoGMJIaK1lu2B8reCtQ=;
        b=BC0RhrRGJPXpvemnBxslClbKPymkQ96oYf+Ai2v1b9MBEc/maqL371OqqQNo2CodWJ
         mm0oLv6j/1w3gIGZhSaiCsDSmRG3HLyEYkWnAjoKBVCaOsVuKUccSOhB2ZSCJcoH0mpH
         5OsqBadth/QUJ+Dbun88ZdJdIqF71ZRO3hXeUItJponIoDnbJggTBJWHlH2Klu8/gRKY
         zwspEdA+z589VELkXJrvK39rwLhaJ9dJ6uHrHGwmcZZn8auZeDR5My5bTHUzcCCQpEUf
         G0Mo514LawqFo8uCYoOWMDWbYwphOV3MHTsTkhw2wCFgq8mYa4RudKbxURJQbUPkqzRl
         BmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=euqT8lAbNK8yda4fe5ZlU/VWsoGMJIaK1lu2B8reCtQ=;
        b=c2VpN+xjAkdbauzZg2ZvCU5362gErL3z41HQP8N2X1R+zC0afwg6tljKjlSLCAreqU
         k4gas5pK1kVfZHilx7xv+sxPEZMlKcJT8Q/k1BXqZO+7deAjjDbvKoHZCx+z7zlWQcKP
         JkuXCAAyMCwH7gIAKVyUCvk2ccZ8CxfQfZAxmnT27V/0hcXNsoc7zusGd+b8fjNvstiQ
         K1RyfRoZf9fq+Bjagi25dJsVXME1nEepbjFNH1EpOglcVo4YAa8yjapf3Ul9ZZTX9CtI
         VOEnuE1pkk51vFuMExkO8EtZjHJK2LBpbtlVP2u4iV0yPTdzbI40HQN9LN8PU8fLjq+Y
         VV1w==
X-Gm-Message-State: AOAM532WrsMxt+ro8GCsmK/6z54oauLXeNYCJZkWhN1W5rtk33jbbGuD
        Xy7HaPtuh7d5XAdDiqXn3Bd40fhoztDmvA==
X-Google-Smtp-Source: ABdhPJxpKPIvszjM3OQE3v39tCZq8Ro9FvcwzLrJYNhAyKJA0YoP0JQIOlLxT75zeuGDZwscO0GLHw==
X-Received: by 2002:a62:1c96:0:b029:142:4bf7:15f3 with SMTP id c144-20020a621c960000b02901424bf715f3mr14299830pfc.75.1600501763512;
        Sat, 19 Sep 2020 00:49:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id m13sm5688151pfk.103.2020.09.19.00.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 00:49:22 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/2] dma-heap: Keep track of the heap device struct
Date:   Sat, 19 Sep 2020 07:49:04 +0000
Message-Id: <20200919074905.82036-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of the heap device struct.

This will be useful for special DMA allocations
and actions.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: James Jones <jajones@nvidia.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/dma-buf/dma-heap.c | 33 +++++++++++++++++++++++++--------
 include/linux/dma-heap.h   |  9 +++++++++
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index afd22c9dbdcf..72c746755d89 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -30,6 +30,7 @@
  * @heap_devt		heap device node
  * @list		list head connecting to list of heaps
  * @heap_cdev		heap char device
+ * @heap_dev		heap device struct
  *
  * Represents a heap of memory from which buffers can be made.
  */
@@ -40,6 +41,7 @@ struct dma_heap {
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
+	struct device *heap_dev;
 };
 
 static LIST_HEAD(heap_list);
@@ -190,10 +192,21 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
 	return heap->priv;
 }
 
+/**
+ * dma_heap_get_dev() - get device struct for the heap
+ * @heap: DMA-Heap to retrieve device struct from
+ *
+ * Returns:
+ * The device struct for the heap.
+ */
+struct device *dma_heap_get_dev(struct dma_heap *heap)
+{
+	return heap->heap_dev;
+}
+
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
-	struct device *dev_ret;
 	unsigned int minor;
 	int ret;
 
@@ -247,16 +260,20 @@ struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 		goto err1;
 	}
 
-	dev_ret = device_create(dma_heap_class,
-				NULL,
-				heap->heap_devt,
-				NULL,
-				heap->name);
-	if (IS_ERR(dev_ret)) {
+	heap->heap_dev = device_create(dma_heap_class,
+				       NULL,
+				       heap->heap_devt,
+				       NULL,
+				       heap->name);
+	if (IS_ERR(heap->heap_dev)) {
 		pr_err("dma_heap: Unable to create device\n");
-		err_ret = ERR_CAST(dev_ret);
+		err_ret = ERR_CAST(heap->heap_dev);
 		goto err2;
 	}
+
+	/* Make sure it doesn't disappear on us */
+	heap->heap_dev = get_device(heap->heap_dev);
+
 	/* Add heap to the list */
 	mutex_lock(&heap_list_lock);
 	list_add(&heap->list, &heap_list);
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 454e354d1ffb..82857e096910 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -50,6 +50,15 @@ struct dma_heap_export_info {
  */
 void *dma_heap_get_drvdata(struct dma_heap *heap);
 
+/**
+ * dma_heap_get_dev() - get device struct for the heap
+ * @heap: DMA-Heap to retrieve device struct from
+ *
+ * Returns:
+ * The device struct for the heap.
+ */
+struct device *dma_heap_get_dev(struct dma_heap *heap);
+
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
  * @exp_info:		information needed to register this heap
-- 
2.17.1


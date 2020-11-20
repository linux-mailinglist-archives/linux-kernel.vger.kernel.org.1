Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB42B9FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgKTB2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgKTB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:28:09 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04967C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:28:09 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id cu18so5934471qvb.17
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lK0xAgnqnFlKaValXVa+KwtGL7PSxTSCBTzwbu0iobI=;
        b=KQ4eOTwhgUo10eJlVVLVGUDH3sWNKajxu3x9BVxOBLT8YFeUdiXb9KqX7CC8fSQZn2
         Ib6zq2ftRSnDPAvCB35gqCoP8snEJTtPuFSxmmrSopU5llloGetTUTykmU5LnzzpS/Sd
         Eqc8VhXWNuv465Nqbmh5Mez1PuIVaFg8k92MKpmQjxCppNbbTRFOibip654xHkMDB2Tp
         U1GJKDO/KOjz1IHyjWqDr8iZIoLyMyzsWxO9U7/Mh+0g06k8nSw+cPFy2714dpuDCrVo
         3VJ9W5ws0hmXS2+Sklv0y0djPifhPSjaWJ/GxiVxdQrftP5RQkDVnXfnXOoq7uwxlXCN
         vp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lK0xAgnqnFlKaValXVa+KwtGL7PSxTSCBTzwbu0iobI=;
        b=OxNlmXNS7I9LlFH84xtywBfqO/gThGXPu+it3cwx8t019jP6zhW/YM6uWF7I7ZcnsR
         e4LsmwxXAxmMa9hOdTdnn24P/R77x+6pOJTorI/sbmt1qqyzhjpr12SdWt22w5ZVvta5
         Dxe/DrUjwmA7gVGQW+tM4pkO3u0rWrQ9yHKii9I0CIqJF/avgVEDYIu14jF4lnyTXnTr
         c2OZq9vlhO8Plm5JN1K+jWTrV4e8FjERXi0lc5K2u+tY7CNkF2zEgoZTg02S6eX8Wbrs
         UHU3neJU7+IFt20XcNKt7PtJmiJB4JHFTZB2nedgTjyenFSQBaeV8YDtOw33rq3qnJL5
         bEiQ==
X-Gm-Message-State: AOAM533OYVNWcqVov5ID/+3scd1gB8PJNgedsxXXTiMiEl/gb3+uRCI8
        ywr5BdS5NBdVmbBGTSY6Ivt8XjNHz4l26g==
X-Google-Smtp-Source: ABdhPJy3thbcQda3qTSamHoN14zSoMqlE5FrSw5T5Rl4P3mib92c8R3jPpQikTCaiYgC8wczkE5ClkRj7537vQ==
Sender: "tmroeder via sendgmr" <tmroeder@tmroeder.kir.corp.google.com>
X-Received: from tmroeder.kir.corp.google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
 (user=tmroeder job=sendgmr) by 2002:a05:6214:aab:: with SMTP id
 ew11mr14234348qvb.4.1605835688035; Thu, 19 Nov 2020 17:28:08 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:27:37 -0800
Message-Id: <20201120012738.2953282-1-tmroeder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] nvme: Cache DMA descriptors to prevent corruption.
From:   Tom Roeder <tmroeder@google.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Peter Gonda <pgonda@google.com>,
        Marios Pomonis <pomonis@google.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Roeder <tmroeder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the NVMe PCI implementation to cache host_mem_descs
in non-DMA memory instead of depending on descriptors stored in DMA
memory. This change is needed under the malicious-hypervisor threat
model assumed by the AMD SEV and Intel TDX architectures, which encrypt
guest memory to make it unreadable. Some versions of these architectures
also make it cryptographically hard to modify guest memory without
detection.

On these architectures, Linux generally leaves DMA memory unencrypted so
that devices can still communicate directly with the kernel: DMA memory
remains readable to and modifiable by devices. This means that this
memory is also accessible to a hypervisor.

However, this means that a malicious hypervisor could modify the addr or
size fields of descriptors and cause the NVMe driver to call
dma_free_attrs on arbitrary addresses or on the right addresses but with
the wrong size. To prevent this attack, this commit changes the code to
cache those descriptors in non-DMA memory and to use the cached values
when freeing the memory they describe.

Tested: Built and ran with Google-internal NVMe tests.
Tested-by: Tom Roeder <tmroeder@google.com>
Signed-off-by: Tom Roeder <tmroeder@google.com>
---
Changes from v1:
- Use native integers instead of __le{32,64} for the addr and size.
- Rename added fields/variables for better consistency.
- Make comment style consistent with other comments in pci.c.

 drivers/nvme/host/pci.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/nvme.h    |  5 +++++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839..4c55a96f9e34 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -148,6 +148,11 @@ struct nvme_dev {
 	u32 nr_host_mem_descs;
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
+	/*
+	 * A cache for the host_mem_descs in non-DMA memory so a malicious
+	 * hypervisor can't change them.
+	 */
+	struct nvme_host_mem_buf_cached_desc *host_mem_cached_descs;
 	void **host_mem_desc_bufs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
@@ -1874,11 +1879,16 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nr_host_mem_descs; i++) {
-		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
-		size_t size = le32_to_cpu(desc->size) * NVME_CTRL_PAGE_SIZE;
+		/*
+		 * Use the cached version to free the DMA allocations, not a
+		 * version that could be controlled by a malicious hypervisor.
+		 */
+		struct nvme_host_mem_buf_cached_desc *desc =
+			&dev->host_mem_cached_descs[i];
+		size_t size = desc->size * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
-			       le64_to_cpu(desc->addr),
+			       desc->addr,
 			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
@@ -1888,6 +1898,8 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 			dev->nr_host_mem_descs * sizeof(*dev->host_mem_descs),
 			dev->host_mem_descs, dev->host_mem_descs_dma);
 	dev->host_mem_descs = NULL;
+	kfree(dev->host_mem_cached_descs);
+	dev->host_mem_cached_descs = NULL;
 	dev->nr_host_mem_descs = 0;
 }
 
@@ -1895,6 +1907,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 		u32 chunk_size)
 {
 	struct nvme_host_mem_buf_desc *descs;
+	struct nvme_host_mem_buf_cached_desc *cached_descs;
 	u32 max_entries, len;
 	dma_addr_t descs_dma;
 	int i = 0;
@@ -1913,9 +1926,13 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	if (!descs)
 		goto out;
 
+	cached_descs = kcalloc(max_entries, sizeof(*cached_descs), GFP_KERNEL);
+	if (!cached_descs)
+		goto out_free_descs;
+
 	bufs = kcalloc(max_entries, sizeof(*bufs), GFP_KERNEL);
 	if (!bufs)
-		goto out_free_descs;
+		goto out_free_cached_descs;
 
 	for (size = 0; size < preferred && i < max_entries; size += len) {
 		dma_addr_t dma_addr;
@@ -1928,6 +1945,8 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 		descs[i].addr = cpu_to_le64(dma_addr);
 		descs[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
+		cached_descs[i].addr = dma_addr;
+		cached_descs[i].size = len / NVME_CTRL_PAGE_SIZE;
 		i++;
 	}
 
@@ -1937,20 +1956,22 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	dev->nr_host_mem_descs = i;
 	dev->host_mem_size = size;
 	dev->host_mem_descs = descs;
+	dev->host_mem_cached_descs = cached_descs;
 	dev->host_mem_descs_dma = descs_dma;
 	dev->host_mem_desc_bufs = bufs;
 	return 0;
 
 out_free_bufs:
 	while (--i >= 0) {
-		size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
+		size_t size = cached_descs[i].size * NVME_CTRL_PAGE_SIZE;
 
-		dma_free_attrs(dev->dev, size, bufs[i],
-			       le64_to_cpu(descs[i].addr),
+		dma_free_attrs(dev->dev, size, bufs[i], cached_descs[i].addr,
 			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(bufs);
+out_free_cached_descs:
+	kfree(cached_descs);
 out_free_descs:
 	dma_free_coherent(dev->dev, max_entries * sizeof(*descs), descs,
 			descs_dma);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d92535997687..e9e14df417bc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1114,6 +1114,11 @@ struct nvme_host_mem_buf_desc {
 	__u32			rsvd;
 };
 
+struct nvme_host_mem_buf_cached_desc {
+	__u64			addr;
+	__u32			size;
+};
+
 struct nvme_create_cq {
 	__u8			opcode;
 	__u8			flags;
-- 
2.29.2.454.gaff20da3a2-goog


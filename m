Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025AE2B9B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgKSS76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgKSS76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:59:58 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25367C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:59:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id w79so4680305pfc.14
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4NQ6c9PbczcRRj9m9KRIAxy4jOOsHq5Kj8nNFjb7lO4=;
        b=EDeks+8y/2oi8p/ZM9GfjZ4lFPQ4AbB77veyqzI763yelEmXmsp1veJYkFa97lw9ES
         2m1teZUTvcz0tSLLtbchbMlvcxGwKdIpDaWWrqSrSuJPdWX+ZD2sN8RzTBMJteMKHmw6
         Cj7AI5zwkBkxPygkHOBvt/1e4P1DKvvA+SxQ6w9auyczmqZwYh6l+aocYHICiAr10M4E
         Jpm0TIRIH6eLhE9BvuQpd6GmbrwyffsFe2TTx8DS09JyLdoa0akXaU+49XlkqeHEI+vO
         NukLo+VWEjmo9e+vJd+U9qDYJ0b8DkHyv+q8gPOb3F6caMc13zof9t15TlT1pFF6vlWo
         OdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4NQ6c9PbczcRRj9m9KRIAxy4jOOsHq5Kj8nNFjb7lO4=;
        b=tupUTjLJlRp+Ab+s02XGmcr3tnbbAzGa1xhSfvyPpsDmYLhPodeUwKq5b82pANAHJ9
         pYnF1NBxAs6j2ZshEkXYcHY2McxzhNXW1EcVyDxr1VK9LQPjM/IJQSdsASFalwF87mNZ
         YRgFM0aUqF299NK3ip8toJFVYdOH4WBuVlYfKPPQ2n/ydFZQld0Fvtm24F0ssm2NMk/S
         lOsBSpJtt7/+KbRP9HGjiGk6cW4rupYsvwcd/z3X5lPtekLoZOJbffZD0fl9jBudGxJT
         s027NieFIhpMJt+ItrO0Fr3iHpHp+PTTUtDFkmU8ExU+NgZ6abQJwVwDhCJLNJYyG7rR
         kHpQ==
X-Gm-Message-State: AOAM533hqTv5DoUog8HWYHsKkM7k3WcKp+EYC7MMyZ7i62r4TG/wuRba
        pIbXarh8RTajEkZ1lFzosJ/hx+WRHECgUw==
X-Google-Smtp-Source: ABdhPJxkB4/gxQnf9XoWsnt47FLC9597nxJR/IWx2y1uaU/rGn9qnek8Oe/5gBPqVkiz7cDZmuQCLjMb6FSa6w==
Sender: "tmroeder via sendgmr" <tmroeder@tmroeder.kir.corp.google.com>
X-Received: from tmroeder.kir.corp.google.com ([2620:0:1008:11:7220:84ff:fe09:dc21])
 (user=tmroeder job=sendgmr) by 2002:a17:902:6b07:b029:d8:ccb8:10c5 with SMTP
 id o7-20020a1709026b07b02900d8ccb810c5mr10265260plk.43.1605812397384; Thu, 19
 Nov 2020 10:59:57 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:59:19 -0800
Message-Id: <20201119185919.2742954-1-tmroeder@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] nvme: Cache DMA descriptors to prevent corruption.
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
 drivers/nvme/host/pci.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3be352403839..28ebe1304cae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -148,6 +148,10 @@ struct nvme_dev {
 	u32 nr_host_mem_descs;
 	dma_addr_t host_mem_descs_dma;
 	struct nvme_host_mem_buf_desc *host_mem_descs;
+	/* Cache the host_mem_descs in non-DMA memory so a malicious hypervisor
+	 * can't change them.
+	 */
+	struct nvme_host_mem_buf_desc *host_mem_descs_cache;
 	void **host_mem_desc_bufs;
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
@@ -1874,7 +1878,11 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nr_host_mem_descs; i++) {
-		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
+		/* Use the cached version to free the DMA allocations, not a
+		 * version that could be controlled by a malicious hypervisor.
+		 */
+		struct nvme_host_mem_buf_desc *desc =
+			&dev->host_mem_descs_cache[i];
 		size_t size = le32_to_cpu(desc->size) * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
@@ -1888,6 +1896,8 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 			dev->nr_host_mem_descs * sizeof(*dev->host_mem_descs),
 			dev->host_mem_descs, dev->host_mem_descs_dma);
 	dev->host_mem_descs = NULL;
+	kfree(dev->host_mem_descs_cache);
+	dev->host_mem_descs_cache = NULL;
 	dev->nr_host_mem_descs = 0;
 }
 
@@ -1895,6 +1905,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 		u32 chunk_size)
 {
 	struct nvme_host_mem_buf_desc *descs;
+	struct nvme_host_mem_buf_desc *descs_cache;
 	u32 max_entries, len;
 	dma_addr_t descs_dma;
 	int i = 0;
@@ -1913,9 +1924,13 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	if (!descs)
 		goto out;
 
+	descs_cache = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
+	if (!descs_cache)
+		goto out_free_descs;
+
 	bufs = kcalloc(max_entries, sizeof(*bufs), GFP_KERNEL);
 	if (!bufs)
-		goto out_free_descs;
+		goto out_free_descs_cache;
 
 	for (size = 0; size < preferred && i < max_entries; size += len) {
 		dma_addr_t dma_addr;
@@ -1928,6 +1943,8 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 		descs[i].addr = cpu_to_le64(dma_addr);
 		descs[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
+		descs_cache[i].addr = cpu_to_le64(dma_addr);
+		descs_cache[i].size = cpu_to_le32(len / NVME_CTRL_PAGE_SIZE);
 		i++;
 	}
 
@@ -1937,20 +1954,24 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	dev->nr_host_mem_descs = i;
 	dev->host_mem_size = size;
 	dev->host_mem_descs = descs;
+	dev->host_mem_descs_cache = descs_cache;
 	dev->host_mem_descs_dma = descs_dma;
 	dev->host_mem_desc_bufs = bufs;
 	return 0;
 
 out_free_bufs:
 	while (--i >= 0) {
-		size_t size = le32_to_cpu(descs[i].size) * NVME_CTRL_PAGE_SIZE;
+		size_t size =
+			le32_to_cpu(descs_cache[i].size) * NVME_CTRL_PAGE_SIZE;
 
 		dma_free_attrs(dev->dev, size, bufs[i],
-			       le64_to_cpu(descs[i].addr),
+			       le64_to_cpu(descs_cache[i].addr),
 			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(bufs);
+out_free_descs_cache:
+	kfree(descs_cache);
 out_free_descs:
 	dma_free_coherent(dev->dev, max_entries * sizeof(*descs), descs,
 			descs_dma);
-- 
2.29.2.299.gdc1121823c-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1902C184E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgKWWSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgKWWSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:18:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA0CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:18:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id f3so12056979plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=YXylx3GCNHyHYBMQqsysdmzOVSsOtZin9cWyUbZGeSg=;
        b=B2IBeB19zTfs1xYaSNHLZDMsX3f0wvPupU1x6jQPo5zn0gD36JBXuYQIEFhSNZxQVc
         C+cutJyz7ixR0Zct99A8r8T+So46A9nmiDQAiQPQ5yQjyxNdxDFUrysbVUSvhoni3QWw
         qUNVsxjAQfDFmPr/HsEzGJYkQnVTRasJjwEaq22nHHkqnYRTLt+shTBNv1s7AsybXR/Q
         824VelCSQrO4ugrRqHUlEk05gL3618qDH7DQJgTrPp+XFCkLDAXfPJGZuCyUvB/ENZaN
         2sVT81n9zsSeivwzCcBMIGwGmXPrm13GhQHUsNjzlDceRfzYvC0buQx2dzAsdSmshJuR
         IjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=YXylx3GCNHyHYBMQqsysdmzOVSsOtZin9cWyUbZGeSg=;
        b=dqpCsT1ZjmfcN8SBUFyy5J5rJPEUesRv1xTZgwASBQTNKZVWjTRDFmmfAzpExdmCE7
         lsz0DZl3NmV/WB6G7STcuGQxqJKT1PdSQ4FFTrf3tIjJ+qEW5MK+ipJTBBxUalD3+Wxt
         xYNsxjj6CxojBBq4hgTKBVMKUqxAndbiKHc8StOo4uE5pE5gN55bFbFmR2Jw/bGeTYij
         q6xo7I61fh8XBSRpNlaQpn6BZ376OyDYx2vd8QHrLbwcTNoX5jR+Lg1rGQih8S8d/UXj
         TByFBoaZGEnP44elPCkcrTRNc6pibNeY7eMj492e37TgTuB/PlsK1TOKRZfh10cBKuSk
         2ROg==
X-Gm-Message-State: AOAM531uNIUgPwv3iYC0uYwlufZF610d2yX3O/34mGDlwN/aKs+6Y4yO
        aqh90ov6Aco5bIOkCpzMPnDyhXJ7Sg==
X-Google-Smtp-Source: ABdhPJwaHIC5Agde+mPQGxwaVJCi4Ya+RC1h3w/HtrSv/HBYs4qc50kEx9QHD7poWbsARQ0erwEZDcV4cA==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:3e52:82ff:fe62:cb61])
 (user=jxgao job=sendgmr) by 2002:a17:90a:5b07:: with SMTP id
 o7mr1213160pji.58.1606169891131; Mon, 23 Nov 2020 14:18:11 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:18:07 -0800
Message-Id: <20201123221807.3344263-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] [PATCH] Adding offset keeping option when mapping data via SWIOTLB.
From:   Jianxiong Gao <jxgao@google.com>
To:     kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        konrad.wilk@oracle.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jianxiong Gao <jxgao@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
booting with --swiotlb=force option and using NVMe as interface,
running mkfs.xfs on Rhel fails because of the unalignment issue.
This patch adds an option to make sure the mapped data preserves
its offset of the orginal addrss. Tested on latest kernel that
this patch fixes the issue.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 drivers/nvme/host/pci.c     |  3 ++-
 include/linux/dma-mapping.h |  8 ++++++++
 kernel/dma/swiotlb.c        | 13 +++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..a366fb8a1ff0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -833,7 +833,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
+				rq_dma_dir(req),
+			       	DMA_ATTR_NO_WARN|DMA_ATTR_SWIOTLB_KEEP_OFFSET);
 	if (!nr_mapped)
 		goto out;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 956151052d45..e46d23d9fa20 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,6 +61,14 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_SWIOTLB_KEEP_OFFSET: used to indicate that the buffer has to keep
+ * its offset when mapped via SWIOTLB. Some application functionality depends
+ * on the address offset, thus when buffers are mapped via SWIOTLB, the offset
+ * needs to be preserved.
+ */
+#define DMA_ATTR_SWIOTLB_KEEP_OFFSET	(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..f43d7be1342d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	max_slots = mask + 1
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+ 
+	/*
+	 * If we need to keep the offset when mapping, we need to add the offset
+	 * to the total set we need to allocate in SWIOTLB
+	 */
+	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
+		alloc_size += offset_in_page(orig_addr);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
@@ -567,6 +574,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
+		tlb_addr += orig_addr & (PAGE_SIZE - 1);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-- 
2.27.0



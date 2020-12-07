Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C5B2D1C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLGVnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLGVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:43:23 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B8C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 13:42:37 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id c4so9999433pgb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 13:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pDfU68hJbVrMhlby67/fptgGuh7zYii/tAwKwJs5ABQ=;
        b=XdTC5hS/AEdpujA2auDl0oiHQKAaDQNA+nqMfmnrCYYh60Dkvw/1dR+Uqim2ZTfKsp
         txd6ggR8/zez7Zopxjyt7hFhg16FOh9vUa/pXxIDhK+3h4EDtFXrjhqL5cntIgghjp78
         ulJUbMrWsBU+5TEyIgHX8fexxcALt9nHZBo3XCOJPIqefrFS0wzdLA7WXahxLjvxiGkl
         v0n+2BtTMPhtMBsVBEKn3ddkOgQDAN6kf3O1t4yOqCsAkjcSdX1RYDrxh56ZF07FMCyl
         cdYnuWXwrQg9M7pCQyE28aW30Zxaev8zo58FYDpaSSNWOoUB952tGlfLyFT5aFK2dMyW
         hpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pDfU68hJbVrMhlby67/fptgGuh7zYii/tAwKwJs5ABQ=;
        b=pQCfzu2cCV/dXdP2FBrnvelqljvgM8FCuijzTnjB2KIAs5YYBlUvXWZ7pit/8zemAw
         kPq2s9gWpK93pHOIoPn/+jsC52nSOITgrju0fK/Zq9GFofO2Ki56LwjZZiym0kSsRBda
         o7p3Wy8A1bGVatsr1+rGhZcUB5qPB3UjVZIJDFE/LaDw3Fbxr/BVwwxQosCtIEpVoJ0o
         8YvN/tMj2C9/Xx8CBGRAVqO0DXYdWh9dpi4kaHJeps8PBRrF5QtJNMyA2aBz/camZyZ5
         61GtM72l+tswLpxFRKmMtI9wNpH6zA7LlPTtuRHvrLUkGLuIWOgAkeG8Qsb8AO/6TKQE
         dx9Q==
X-Gm-Message-State: AOAM5321ECJZ1w9Hi1o+Oe8NxQpznKA/rU99hXc7eY2+WzM3/RccyT5/
        psOGFUljovbR6G+EfDvuHmWM2b9g7A==
X-Google-Smtp-Source: ABdhPJw1DKVB1ysvlps113dHRHd8Gdmd9wuw9y2HR7LIJxoQyNpy8ztEFdTjgj9WPEQ8k+rl387OW7IIVw==
Sender: "jxgao via sendgmr" <jxgao@jxgao.kir.corp.google.com>
X-Received: from jxgao.kir.corp.google.com ([2620:0:1008:11:3e52:82ff:fe62:cb61])
 (user=jxgao job=sendgmr) by 2002:a17:902:b70d:b029:da:5196:1181 with SMTP id
 d13-20020a170902b70db02900da51961181mr18297299pls.81.1607377356798; Mon, 07
 Dec 2020 13:42:36 -0800 (PST)
Date:   Mon,  7 Dec 2020 13:42:04 -0800
Message-Id: <20201207214204.1839028-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] [PATCH] Keep offset when mapping data via SWIOTLB.
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

NVMe driver and other applications depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
booting with --swiotlb=force option and using NVMe as interface,
running mkfs.xfs on Rhel fails because of the unalignment issue.
This patch makes sure the mapped data preserves
its offset of the orginal address. Tested on latest kernel that
this patch fixes the issue.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..56a35e71b3fd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	max_slots = mask + 1
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+ 
+	/*
+	 * We need to keep the offset when mapping, so adding the offset
+	 * to the total set we need to allocate in SWIOTLB
+	 */
+	alloc_size += offset_in_page(orig_addr);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
@@ -567,6 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	tlb_addr += orig_addr & (PAGE_SIZE - 1);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-- 
2.27.0



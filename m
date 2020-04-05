Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5819E824
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 02:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDEAv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Apr 2020 20:51:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50818 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDEAv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 20:51:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so4870551pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jxbeYfDO2Dzs1Qxjg6uhV0oWTScSLyrhcb9XrgOOWV0=;
        b=QJ1kps7fuwQPwxDWTmKliqra/mE4ScvXBKpwN0B00JcwQE4WKtOALnCSWssnLfBdpd
         +qHHtZK8qXOutKY5g/q+Lg/QZjPbBy9UsYU5qWJBEdOR64yGsAfN21GFCRdp0hGvjPQQ
         hEcK7tpV7+0J9RRQLFE2mOd/FgfQO/NEEj7hPwbvsj4yqwrnserPnfJFPOSl3+7sCvmz
         1QzauZt5cbSRh37miX9DxVj/kvGnQS3qa0oB5wa+CU0MEQYtiMULiZWYRliY529/pigJ
         pJnFd9MxeZlRYP6rrAcz4/S7MXwCmJDy9psyyZHFJebktIrAbzaGf892hssXjw0B5XwL
         ExIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jxbeYfDO2Dzs1Qxjg6uhV0oWTScSLyrhcb9XrgOOWV0=;
        b=UFTPOcqdNPYR7D7/XfQ8X/hmqkOVyNqyIVsjDGaeu10tRr4qIXD2LJDRYllFrg69dq
         uevSz3ZCWKSuMTr+HNBZGB0zsUNyoUmg2H0f7vUDy0Al3uUOJttXxDATpKv3iCKcY1J7
         9w5n2LIQ76emthK25s+00GaK5IAUsyK1DyQ7+fCjM62753dDqrUFlFMMTj0npJR4YjzQ
         90bMOZ9f5TXc7Lru4FVQ/hx7nHycsQZSnsBmPcWHOunM7MVe749PPM6MeXZzD4brZnBX
         M4ie+EDHr2b2Ik21uJ9++tZR8D02IPCYPOPpZgCjbDL68orzwCUQdvliKTLolq1KXPkc
         e+aQ==
X-Gm-Message-State: AGi0PubaBHXs8jkhiNAvmiA+ZgYBj5GpO5OfYAdHZDlMETW7TxEzGtdV
        Fb3gNpnO8IebCyt5eGLRuHk=
X-Google-Smtp-Source: APiQypLB+X3qujTRRAtf81QwHvLmDeFWiaoG2f+FG4jSKLujTRniCz57ihn3csNG3jtUKJ0+DbLTGA==
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr13360515plb.299.1586047916448;
        Sat, 04 Apr 2020 17:51:56 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j17sm8528122pfd.175.2020.04.04.17.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 17:51:55 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC/RFT][PATCH] dma-mapping: set default segment_boundary_mask to ULONG_MAX
Date:   Sat,  4 Apr 2020 17:51:57 -0700
Message-Id: <20200405005157.1318-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
a decade ago by referencing SCSI/block subsystem, as a 32-bit
mask was good enough for most of the devices.

Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
while only a handful of them call dma_set_seg_boundary(). This
means that most drivers have a 4GB segmention boundary because
DMA API returns a 32-bit default value, though they might not
really have such a limit.

The default segment_boundary_mask should mean "no limit" since
the device doesn't explicitly set the mask. But a 32-bit mask
certainly limits those devices capable of 32+ bits addressing.

And this 32-bit boundary mask might result in a situation that
when dma-iommu maps a DMA buffer (size > 4GB), iommu_map_sg()
cuts the IOVA region into discontiguous pieces, and creates a
faulty IOVA mapping that overlaps some physical memory outside
the scatter list, which might lead to some random kernel panic
after DMA overwrites that faulty IOVA space.

So this patch sets default segment_boundary_mask to ULONG_MAX.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..ff8cefe85f30 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
 		return dev->dma_parms->segment_boundary_mask;
-	return DMA_BIT_MASK(32);
+	return ULONG_MAX;
 }
 
 static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
-- 
2.17.1


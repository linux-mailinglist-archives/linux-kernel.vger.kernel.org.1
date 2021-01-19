Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDA2FBFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392161AbhASTD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392138AbhASR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:56:23 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEDC061383
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:53:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id a18so491214pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=evd2Y/DETLO7S33y5Cn5jun9AsciH/vlQsPeXswPTGQ=;
        b=HsVue5Ec3+MrJYXrnCqsn8cYHjurJmmuwHbecRCPMCjed8Z3anU7CJsk4YWTgakhmL
         6+HG7jvR1vAR+6jwws8n2dJuR7UYWO7GaMeRGcK1b/UGAYO/j71736fK6SFYQbzHInbv
         OoHEpgixpTK/i+cqp/q8x0ZoBlOe1mYRTBa25C/U/3KDPmn8CuuuLUSGvQv9EHRsMAoI
         f8NJt34GvNY7S6iYgsUtNWH9Jeb80v5M6bInxNX7tYp583NoURKWEVofkDZBB2ihiZWv
         K4eK2RZ2LDSlY0TUgmGep8OrjYWJN2gI5TlKBDTC9g/HMIOlXfoi58vTIbfcQiSQzotP
         IZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=evd2Y/DETLO7S33y5Cn5jun9AsciH/vlQsPeXswPTGQ=;
        b=NpO2kjV3TtxsXuQeCZBzopc4CpV9/2AZ1yvmyXYTTrUXhKewWgzbRD9WUYf+ix78U4
         sPmm//Kth3CaR+bt51EIYomsd244cdR5TKUz0BOmuBaiLg5E6E5h7sevZXaCgmoKU2QN
         nns8FkzXTks1tBFBm0aBGivxN4GyuPd2wpvk/84yHVpsLVubtugJRwCvJZU9v4K7edP+
         7gypd+QPBHpNFCcmWPX7U0dNumjm7JUmZSJBW/gyRh4QwwHD9fZyph9sP8Hp8GNQPz1w
         W2gFUem9sqwMJH1UyKyIQvyQLcxKdPqp56dAfMsGDKTiUr9LuEZ03gwg08xTkOkR020a
         fdHg==
X-Gm-Message-State: AOAM533VzZwdG68QWPc9Ng3V7AT2sLwvDSS1h8vM9r6X22ygnORhkhuN
        8ZCVMEK0dlJLd6s+40ndm7jNRJjYXmwU
X-Google-Smtp-Source: ABdhPJy8kP3297v4O+ic7h8Vn1AVl9EHEVxp7Np60JfNXH60DUd06lHscGscPMlsO4VRIYba1WUePUUbq9iK
Sender: "marcorr via sendgmr" <marcorr@marcorr.c.googlers.com>
X-Received: from marcorr.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1d18])
 (user=marcorr job=sendgmr) by 2002:a17:902:c115:b029:de:8961:47e5 with SMTP
 id 21-20020a170902c115b02900de896147e5mr5803698pli.46.1611078823356; Tue, 19
 Jan 2021 09:53:43 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:53:36 -0800
Message-Id: <20210119175336.4016923-1-marcorr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] nvme: fix handling mapping failure
From:   Marc Orr <marcorr@google.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        jxgao@google.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Orr <marcorr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that when `nvme_map_data()` fails to map the
addresses in a scatter/gather list:

* The addresses are not incorrectly unmapped. The underlying
scatter/gather code unmaps the addresses after detecting a failure.
Thus, unmapping them again in the driver is a bug.
* The DMA pool allocations are not deallocated when they were never
allocated.

The bug that motivated this patch was the following sequence, which
occurred within the NVMe driver, with the kernel flag `swiotlb=force`.

* NVMe driver calls dma_direct_map_sg()
* dma_direct_map_sg() fails part way through the scatter gather/list
* dma_direct_map_sg() calls dma_direct_unmap_sg() to unmap any entries
  succeeded.
* NVMe driver calls dma_direct_unmap_sg(), redundantly, leading to a
  double unmap, which is a bug.

Before this patch, I observed intermittent application- and VM-level
failures when running a benchmark, fio, in an AMD SEV guest. This patch
resolves the failures.

Tested-by: Marc Orr <marcorr@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Orr <marcorr@google.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9b1fc8633cfe..8b504ed08321 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -543,11 +543,14 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 
 	WARN_ON_ONCE(!iod->nents);
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
-				    rq_dma_dir(req));
-	else
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+	if (!dma_mapping_error(dev->dev, iod->first_dma)) {
+		if (is_pci_p2pdma_page(sg_page(iod->sg)))
+			pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
+					    rq_dma_dir(req));
+		else
+			dma_unmap_sg(dev->dev, iod->sg, iod->nents,
+				     rq_dma_dir(req));
+	}
 
 
 	if (iod->npages == 0)
@@ -836,8 +839,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
-	if (!nr_mapped)
+	if (!nr_mapped) {
+		iod->first_dma = DMA_MAPPING_ERROR;
+		iod->npages = -1;
 		goto out;
+	}
 
 	iod->use_sgl = nvme_pci_use_sgls(dev, req);
 	if (iod->use_sgl)
-- 
2.30.0.284.gd98b1dd5eaa7-goog


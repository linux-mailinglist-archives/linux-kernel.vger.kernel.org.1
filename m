Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CC12F395D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392791AbhALTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:02:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391614AbhALTCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:02:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8126B23102
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610478113;
        bh=NuTiCEzB6VvihSN5FcVPWivT1c2UbWiAeK3ZOazD3UY=;
        h=From:To:Subject:Date:From;
        b=UiMfJs+trywbUGUwsSzCa+1ovPjX6qcb5nvYdjA1IKvGOQLNjUrntREiNA2YwnEDC
         Y33xL7XffrSrb043ImCI2EIb7cVMzDmFThqKywVmlReMFnjrkXBXJFYDIUMkXaEaeu
         m/AgWnuoNAKG1zL9hhCzwgHEJBck+OEV0z5JkDd2STEFm+D/C/HzgBsY57MtFl/wJq
         kLXp4tUA3MDp9fPlplMWia0FGB4u7agJNS5gQntdkpVNBfIjvz9QTlSM2ph6IxSkkk
         xGg7LYbWPfRnhM+9/D8b9E7yZfrazYt1oHd/l5E4yOPm8AMA9eJR8cH4Ary8JpgclA
         +s1z31Mxa4kXA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] habanalabs: fix dma_addr passed to dma_mmap_coherent
Date:   Tue, 12 Jan 2021 21:01:47 +0200
Message-Id: <20210112190149.11661-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing dma_alloc_coherent in the driver, we add a certain hard-coded
offset to the DMA address before returning to the callee function. This
offset is needed when our device use this DMA address to perform
outbound transactions to the host.

However, if we want to map the DMA'able memory to the user via
dma_mmap_coherent(), we need to pass the original dma address, without
this offset. Otherwise, we will get erronouos mapping.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 ++-
 drivers/misc/habanalabs/goya/goya.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8c09e4466af8..b328ddaa64ee 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4002,7 +4002,8 @@ static int gaudi_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
 			VM_DONTCOPY | VM_NORESERVE;
 
-	rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
+	rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr,
+				(dma_addr - HOST_PHYS_BASE), size);
 	if (rc)
 		dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index b8b4aa636b7c..63679a747d2c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2719,7 +2719,8 @@ static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
 			VM_DONTCOPY | VM_NORESERVE;
 
-	rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
+	rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr,
+				(dma_addr - HOST_PHYS_BASE), size);
 	if (rc)
 		dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
 
-- 
2.25.1


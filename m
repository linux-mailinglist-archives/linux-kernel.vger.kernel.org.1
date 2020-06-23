Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECD8205355
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbgFWNYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 09:24:51 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41561 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgFWNYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:24:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0Vwuho_1592918684;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0Vwuho_1592918684)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 21:24:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nvme-pci: Add controller memory buffer supported macro
Date:   Tue, 23 Jun 2020 21:24:33 +0800
Message-Id: <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new capability macro to indicate if the controller
supports the memory buffer or not, instead of reading the
NVME_REG_CMBSZ register.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 2 +-
 include/linux/nvme.h    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b4b7b7..00c2701 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1760,7 +1760,7 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int bar;
 
-	if (dev->cmb_size)
+	if (!NVME_CAP_CMBS(dev->ctrl.cap) || dev->cmb_size)
 		return;
 
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5ce51ab..e3726be 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -134,6 +134,7 @@ enum {
 #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+#define NVME_CAP_CMBS(cap)	(((cap) >> 57) & 0x1)
 
 #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
 #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
-- 
1.8.3.1


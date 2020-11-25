Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE722C4176
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKYNzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:55:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39213 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKYNzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:55:47 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khvGi-0007zQ-17; Wed, 25 Nov 2020 13:55:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: fix an uninitialized pointer read due to typo in argp assignment
Date:   Wed, 25 Nov 2020 13:55:35 +0000
Message-Id: <20201125135535.1880307-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of argp is currently using argp as the source because of
a typo. Fix this by assigning it the value passed in arg instead.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: bfd2defed94d ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/dma/map_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index ca616b664f72..e1e37603d01b 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -192,7 +192,7 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
 	struct map_benchmark_data *map = file->private_data;
-	void __user *argp = (void __user *)argp;
+	void __user *argp = (void __user *)arg;
 	u64 old_dma_mask;
 
 	int ret;
-- 
2.29.2


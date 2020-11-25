Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C92C41C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgKYOFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:05:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39456 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYOFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:05:36 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khvQB-0000Hp-Df; Wed, 25 Nov 2020 14:05:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: Fix sizeof() mismatch on tsk allocation
Date:   Wed, 25 Nov 2020 14:05:23 +0000
Message-Id: <20201125140523.1880669-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An incorrect sizeof() is being used, sizeof(tsk) is not correct, it should
be sizeof(*tsk). Fix it.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: bfd2defed94d ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/dma/map_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index e1e37603d01b..b1496e744c68 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -121,7 +121,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	int ret = 0;
 	int i;
 
-	tsk = kmalloc_array(threads, sizeof(tsk), GFP_KERNEL);
+	tsk = kmalloc_array(threads, sizeof(*tsk), GFP_KERNEL);
 	if (!tsk)
 		return -ENOMEM;
 
-- 
2.29.2


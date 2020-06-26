Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2626620ADB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgFZICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgFZICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:15 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF991C08C5DB;
        Fri, 26 Jun 2020 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Gfq1cduFYABDR3Fkx1QZk2YcbgFvT9xrFNMNKHVTMCk=; b=BFVCZMiF66jSFs2WZSzt5u3sXh
        Kt0mRsvbQWMJLalnuF8CWJe1ijTXjYfPsErTxAMsV5Qpw5yrjZxInpPpEIaR5MNjozZecaTXlSsER
        hEZW0EIdKutG50THPjik/dvqEtBmXzSwAf9vuRqGEpKHZmPvW8z9XauIB/G9pRU2ZS7blhdyWEInS
        LYpn6ompzFdQbQI/PZcThONE996q4V6fXk/3VtVPMB4/GTFOPqhfAmjSmIFdqhJqufOAjB06B6yZt
        28poHFKuOZoyKbRyoA8hX71XP4c+XFPf1mCI59JVPSdbjkoPzS96yRJPD4PjvGGhdDk4Zn5L5JOgo
        kfMj9HRQ==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJA-0007U7-Fd; Fri, 26 Jun 2020 08:02:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] floppy: use block_size
Date:   Fri, 26 Jun 2020 10:01:52 +0200
Message-Id: <20200626080158.1998621-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
References: <20200626080158.1998621-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the block_size helper instead of open coding it.  Also remove the
check for a 0 block size, as that can't happen.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/floppy.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3e9db22db2a8f5..09079aee8dc430 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4205,7 +4205,6 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 	struct bio_vec bio_vec;
 	struct page *page;
 	struct rb0_cbdata cbdata;
-	size_t size;
 
 	page = alloc_page(GFP_NOIO);
 	if (!page) {
@@ -4213,15 +4212,11 @@ static int __floppy_read_block_0(struct block_device *bdev, int drive)
 		return -ENOMEM;
 	}
 
-	size = bdev->bd_block_size;
-	if (!size)
-		size = 1024;
-
 	cbdata.drive = drive;
 
 	bio_init(&bio, &bio_vec, 1);
 	bio_set_dev(&bio, bdev);
-	bio_add_page(&bio, page, size, 0);
+	bio_add_page(&bio, page, block_size(bdev), 0);
 
 	bio.bi_iter.bi_sector = 0;
 	bio.bi_flags |= (1 << BIO_QUIET);
-- 
2.26.2


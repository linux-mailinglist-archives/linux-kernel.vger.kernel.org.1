Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223A42946ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 05:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411698AbgJUDVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 23:21:54 -0400
Received: from smtp.h3c.com ([60.191.123.50]:7189 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411693AbgJUDVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:21:54 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 09L3LSHn097935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Oct 2020 11:21:28 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 21 Oct 2020 11:21:29 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] mm: bio_alloc never fails when set GFP_NOIO, GFP_KERNEL
Date:   Wed, 21 Oct 2020 11:11:28 +0800
Message-ID: <20201021031128.14100-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09L3LSHn097935
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bio_alloc with __GFP_DIRECT_RECLAIM(which is included in GFP_NOIO,
GFP_KERNEL) never fails, as stated in the comments of bio_alloc_bioset.

So we can remove multiple unneeded null checks of bio_alloc and simplify
the code.

We have done it in fs/ext4/readpage.c, fs/ext4/page-io.c, fs/direct-io.c,
and so forth.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 mm/page_io.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index e485a6e8a..9215bb356 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -30,18 +30,20 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 				struct page *page, bio_end_io_t end_io)
 {
 	struct bio *bio;
+	struct block_device *bdev;
 
+	/*
+	 * bio_alloc will _always_ be able to allocate a bio if
+	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
+	 */
 	bio = bio_alloc(gfp_flags, 1);
-	if (bio) {
-		struct block_device *bdev;
+	bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
+	bio->bi_end_io = end_io;
 
-		bio->bi_iter.bi_sector = map_swap_page(page, &bdev);
-		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
-		bio->bi_end_io = end_io;
+	bio_add_page(bio, page, thp_size(page), 0);
 
-		bio_add_page(bio, page, thp_size(page), 0);
-	}
 	return bio;
 }
 
@@ -351,19 +353,13 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 
 	ret = 0;
 	bio = get_swap_bio(GFP_NOIO, page, end_write_func);
-	if (bio == NULL) {
-		set_page_dirty(page);
-		unlock_page(page);
-		ret = -ENOMEM;
-		goto out;
-	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
 	bio_associate_blkg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
 	submit_bio(bio);
-out:
+
 	return ret;
 }
 
@@ -416,11 +412,6 @@ int swap_readpage(struct page *page, bool synchronous)
 
 	ret = 0;
 	bio = get_swap_bio(GFP_KERNEL, page, end_swap_bio_read);
-	if (bio == NULL) {
-		unlock_page(page);
-		ret = -ENOMEM;
-		goto out;
-	}
 	disk = bio->bi_disk;
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
-- 
2.17.1


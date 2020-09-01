Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07903258DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgIAMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 08:10:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728036AbgIAMBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:01:45 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8EF14AABD7F2EA51D1C1;
        Tue,  1 Sep 2020 20:01:27 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 1 Sep 2020
 20:01:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] block: Fix potential page reference leak in __bio_iov_iter_get_pages()
Date:   Tue, 1 Sep 2020 08:00:06 -0400
Message-ID: <20200901120006.9545-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bio is full, __bio_iov_iter_get_pages() would return error directly
while left page reference still held in pages. Release these references.
Also advance the iov_iter according to what we have done successfully.

Fixes: 576ed9135489 ("block: use bio_add_page in bio_iov_iter_get_pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/bio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a9931f23d933..e113073958cb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1023,7 +1023,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 				put_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
-                                return -EINVAL;
+				goto put_pages;
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
@@ -1031,6 +1031,19 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	iov_iter_advance(iter, size);
 	return 0;
+
+put_pages:
+	/* Advance iov_iter to what we have done yet. */
+	iov_iter_advance(iter, size - left);
+	/* Put the page references still held by pages. */
+	for (; left > 0; left -= len, i++) {
+		struct page *page = pages[i];
+
+		len = min_t(size_t, PAGE_SIZE - offset, left);
+		put_page(page);
+		offset = 0;
+	}
+	return -EINVAL;
 }
 
 static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
-- 
2.19.1


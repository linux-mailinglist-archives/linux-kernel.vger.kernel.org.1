Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E32640AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgIJI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 04:56:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730361AbgIJIzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:55:14 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C72DC8F70750B2E79B9A;
        Thu, 10 Sep 2020 16:55:07 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 16:54:57 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <kbusch@kernel.org>, <johannes.thumshirn@wdc.com>, <hare@suse.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] block: Fix potential page reference leak in __bio_iov_append_get_pages()
Date:   Thu, 10 Sep 2020 04:53:42 -0400
Message-ID: <20200910085342.61200-1-linmiaohe@huawei.com>
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

When bio_add_hw_page() failed, we left page reference still held in pages
from iov_iter_get_pages(). Release these references and also advance the
iov_iter according to what we have done successfully yet.

Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 block/bio.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index e113073958cb..a323a5446221 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1080,7 +1080,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 		len = min_t(size_t, PAGE_SIZE - offset, left);
 		if (bio_add_hw_page(q, bio, page, len, offset,
 				max_append_sectors, &same_page) != len)
-			return -EINVAL;
+			goto put_pages;
 		if (same_page)
 			put_page(page);
 		offset = 0;
@@ -1088,6 +1088,16 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	iov_iter_advance(iter, size);
 	return 0;
+put_pages:
+	iov_iter_advance(iter, size - left);
+	for (; left > 0; left -= len, i++) {
+		struct page *page = pages[i];
+
+		len = min_t(size_t, PAGE_SIZE - offset, left);
+		put_page(page);
+		offset = 0;
+	}
+	return -EINVAL;
 }
 
 /**
-- 
2.19.1


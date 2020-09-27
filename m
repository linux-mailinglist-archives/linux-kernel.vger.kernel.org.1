Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A82727A105
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI0MmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 08:42:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgI0MmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:42:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12B14D26EE607A6A0263;
        Sun, 27 Sep 2020 20:42:03 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sun, 27 Sep 2020
 20:41:54 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: Remove useless out label in __swap_writepage()
Date:   Sun, 27 Sep 2020 08:40:32 -0400
Message-ID: <20200927124032.22521-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The out label is only used in one place and return ret directly without
something like resource cleanup or lock release and so on. So we should
remove this jump label and do some cleanup.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index ae33d0b77dc9..35eac34cbd93 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -359,13 +359,11 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	ret = 0;
 	bio = get_swap_bio(GFP_NOIO, page, end_write_func);
 	if (bio == NULL) {
 		set_page_dirty(page);
 		unlock_page(page);
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
 	bio_associate_blkg_from_page(bio, page);
@@ -373,8 +371,8 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	set_page_writeback(page);
 	unlock_page(page);
 	submit_bio(bio);
-out:
-	return ret;
+
+	return 0;
 }
 
 int swap_readpage(struct page *page, bool synchronous)
-- 
2.19.1


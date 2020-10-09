Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A30828898A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgJINEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:04:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732468AbgJINEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:04:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 388E0FBD45FB23536C0D;
        Fri,  9 Oct 2020 21:04:15 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 21:03:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/swapfile.c: remove unnecessary out label in __swap_duplicate()
Date:   Fri, 9 Oct 2020 09:03:37 -0400
Message-ID: <20201009130337.29698-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the code went to the out label, it must have p == NULL. So what out
label really does is redundant if check and return err. We should Remove
this unnecessary out label because it does not handle resource free and so
on.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 06984de4cb9a..22c63beb10da 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3441,11 +3441,11 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 	unsigned long offset;
 	unsigned char count;
 	unsigned char has_cache;
-	int err = -EINVAL;
+	int err;
 
 	p = get_swap_device(entry);
 	if (!p)
-		goto out;
+		return -EINVAL;
 
 	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
@@ -3492,7 +3492,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
-out:
 	if (p)
 		put_swap_device(p);
 	return err;
-- 
2.19.1


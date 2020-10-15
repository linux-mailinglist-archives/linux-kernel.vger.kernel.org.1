Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4C28F2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgJONBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:01:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgJONBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:01:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 98E657D511BA10B261F0;
        Thu, 15 Oct 2020 21:01:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 15 Oct 2020
 21:01:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <ngupta@vflare.org>, <sergey.senozhatsky.work@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] zsmalloc: Rework the list_add code in insert_zspage()
Date:   Thu, 15 Oct 2020 09:01:07 -0400
Message-ID: <20201015130107.65195-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the list_add code to make it more readable and simplicity.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zsmalloc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 918c7b019b3d..b03bee2e1b5f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -730,13 +730,10 @@ static void insert_zspage(struct size_class *class,
 	 * We want to see more ZS_FULL pages and less almost empty/full.
 	 * Put pages with higher ->inuse first.
 	 */
-	if (head) {
-		if (get_zspage_inuse(zspage) < get_zspage_inuse(head)) {
-			list_add(&zspage->list, &head->list);
-			return;
-		}
-	}
-	list_add(&zspage->list, &class->fullness_list[fullness]);
+	if (head && get_zspage_inuse(zspage) < get_zspage_inuse(head))
+		list_add(&zspage->list, &head->list);
+	else
+		list_add(&zspage->list, &class->fullness_list[fullness]);
 }
 
 /*
-- 
2.19.1


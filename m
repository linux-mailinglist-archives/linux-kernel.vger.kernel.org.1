Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD125E695
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 10:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgIEIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 04:46:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgIEIqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:46:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5E04CB9627187484886C;
        Sat,  5 Sep 2020 16:46:12 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 16:46:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: swap: Fix confusing comment in release_pages()
Date:   Sat, 5 Sep 2020 04:44:53 -0400
Message-ID: <20200905084453.19353-1-linmiaohe@huawei.com>
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

Since commit 07d802699528 ("mm: devmap: refactor 1-based refcounting for
ZONE_DEVICE pages"), we have renamed the func put_devmap_managed_page() to
page_is_devmap_managed().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 999a84dbe12c..041e4e31fb01 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -859,7 +859,7 @@ void release_pages(struct page **pages, int nr)
 			}
 			/*
 			 * ZONE_DEVICE pages that return 'false' from
-			 * put_devmap_managed_page() do not require special
+			 * page_is_devmap_managed() do not require special
 			 * processing, and instead, expect a call to
 			 * put_page_testzero().
 			 */
-- 
2.19.1


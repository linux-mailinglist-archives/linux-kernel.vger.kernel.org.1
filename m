Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E667826DA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgIQLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:40:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726874AbgIQLiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:38:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 48287A420ECFB0813089;
        Thu, 17 Sep 2020 19:37:57 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 19:37:46 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/page_counter: Correct the obsolete func name in the comment of page_counter_try_charge()
Date:   Thu, 17 Sep 2020 07:36:29 -0400
Message-ID: <20200917113629.14382-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bbec2e15170a ("mm: rename page_counter's count/limit into
usage/max"), page_counter_limit() is renamed to page_counter_set_max().
So replace page_counter_limit with page_counter_set_max in comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index afe22ad335cc..b24a60b28bb0 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -109,7 +109,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 *
 		 * The atomic_long_add_return() implies a full memory
 		 * barrier between incrementing the count and reading
-		 * the limit.  When racing with page_counter_limit(),
+		 * the limit.  When racing with page_counter_set_max(),
 		 * we either see the new limit or the setter sees the
 		 * counter has changed and retries.
 		 */
-- 
2.19.1


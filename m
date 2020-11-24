Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE92C2444
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbgKXLfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:35:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbgKXLfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:35:37 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CgMQ80k0Tzhfl9;
        Tue, 24 Nov 2020 19:35:12 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 19:35:23 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mm/swap.c: Mark sort_page_lruvec with static keyword
Date:   Tue, 24 Nov 2020 19:47:05 +0800
Message-ID: <1606218425-3874-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

mm/swap.c:1018:5: warning: symbol 'sort_page_lruvec' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index c787b38..5022dfe 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1015,7 +1015,7 @@ struct lruvecs {
 };
 
 /* Sort pvec pages on their lruvec */
-int sort_page_lruvec(struct lruvecs *lruvecs, struct pagevec *pvec)
+static int sort_page_lruvec(struct lruvecs *lruvecs, struct pagevec *pvec)
 {
 	int i, j, nr_lruvec;
 	struct page *page;
-- 
2.6.2


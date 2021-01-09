Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFFB2EFE96
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbhAIIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:15:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10858 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbhAIIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:15:42 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DCXmp75fVz7Q5f;
        Sat,  9 Jan 2021 16:14:02 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Sat, 9 Jan 2021
 16:14:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/compaction: Remove duplicated VM_BUG_ON_PAGE !PageLocked
Date:   Sat, 9 Jan 2021 03:14:20 -0500
Message-ID: <20210109081420.46030-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VM_BUG_ON_PAGE(!PageLocked(page), page) is also done in PageMovable.
Remove this explicitly one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/compaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 02af220fb992..6d316eb99913 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -137,7 +137,6 @@ EXPORT_SYMBOL(__SetPageMovable);
 
 void __ClearPageMovable(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	/*
 	 * Clear registered address_space val with keeping PAGE_MAPPING_MOVABLE
-- 
2.19.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14F1B38B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgDVHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:18:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgDVHS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:18:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BE0974A871E92F672D4;
        Wed, 22 Apr 2020 15:18:56 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:18:47 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] mm: return true in cpupid_pid_unset()
Date:   Wed, 22 Apr 2020 15:18:16 +0800
Message-ID: <20200422071816.48879-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

include/linux/mm.h:1371:8-9: WARNING: return of 0/1 in function
'cpupid_pid_unset' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2b0390017633..35f58a3601ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1368,7 +1368,7 @@ static inline int cpu_pid_to_cpupid(int nid, int pid)
 
 static inline bool cpupid_pid_unset(int cpupid)
 {
-	return 1;
+	return true;
 }
 
 static inline void page_cpupid_reset_last(struct page *page)
-- 
2.21.1


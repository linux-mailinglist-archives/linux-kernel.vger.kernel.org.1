Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67416270A65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgISD0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 23:26:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgISD0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 23:26:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5430AEF173E634A95E96;
        Sat, 19 Sep 2020 11:26:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 11:26:37 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] mm: fix some doc warnings in workingset.c
Date:   Sat, 19 Sep 2020 11:25:13 +0800
Message-ID: <1600485913-11192-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warnings caused by mismatch bewteen function parameters
and comments.
mm/workingset.c:228: warning: Function parameter or member 'lruvec' not described in 'workingset_age_nonresident'
mm/workingset.c:228: warning: Excess function parameter 'memcg' description in 'workingset_age_nonresident'

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 mm/workingset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 92e6611..8ed8e62 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -216,7 +216,7 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 
 /**
  * workingset_age_nonresident - age non-resident entries as LRU ages
- * @memcg: the lruvec that was aged
+ * @lruvec: the lruvec that was aged
  * @nr_pages: the number of pages to count
  *
  * As in-memory pages are aged, non-resident pages need to be aged as
-- 
2.8.1


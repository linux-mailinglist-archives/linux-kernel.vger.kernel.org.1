Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6202F751E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAOJVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:21:14 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10971 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbhAOJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:21:13 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DHFxl3l02zj6rd;
        Fri, 15 Jan 2021 17:19:39 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 15 Jan 2021
 17:20:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/hugetlb: avoid unnecessary hugetlb_acct_memory() call
Date:   Fri, 15 Jan 2021 04:20:13 -0500
Message-ID: <20210115092013.61012-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
and releasing hugetlb_lock. We should avoid this unnecessary hugetlb_lock
lock/unlock cycle which is happening on 'most' hugetlb munmap operations by
check delta against 0 at the beginning of hugetlb_acct_memory.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/hugetlb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4f67f6b159c7..da064cb8fd53 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3591,6 +3591,9 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
 {
 	int ret = -ENOMEM;
 
+	if (!delta)
+		return 0;
+
 	spin_lock(&hugetlb_lock);
 	/*
 	 * When cpuset is configured, it breaks the strict hugetlb page
-- 
2.19.1


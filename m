Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC8A268836
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgINJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:23:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbgINJXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:23:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D32DC8FB69E25E8480B9;
        Mon, 14 Sep 2020 17:23:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 17:23:24 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <akpm@linux-foundation.org>, <christian@brauner.io>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH] mm/madvise.c: Remove the unused variable in function madvise_inject_error
Date:   Mon, 14 Sep 2020 17:22:16 +0800
Message-ID: <1600075336-43414-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable zone is unused in function madvise_inject_error, let's remove it.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 mm/madvise.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 460e19d..94b9d17 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -879,7 +879,6 @@ static long madvise_remove(struct vm_area_struct *vma,
 static int madvise_inject_error(int behavior,
 		unsigned long start, unsigned long end)
 {
-	struct zone *zone;
 	unsigned long size;

 	if (!capable(CAP_SYS_ADMIN))
--
2.8.1


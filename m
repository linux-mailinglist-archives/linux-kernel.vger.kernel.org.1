Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85702AB777
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgKILr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:47:27 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36524 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbgKILr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:47:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UEjNPeQ_1604922442;
Received: from aliy8.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEjNPeQ_1604922442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Nov 2020 19:47:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linmiaohe@huawei.com, akpm@linux-foundation.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [REF PATCH] mm/swap: fix swapon failure
Date:   Mon,  9 Nov 2020 19:47:16 +0800
Message-Id: <1604922436-16597-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of my VM guest has a swapon issue:
root #swapon -v -f /swap1
swapon /swap1
swapon: /swap1: found swap signature: version 1, page-size 4, same byte order
swapon: /swap1: pagesize=4096, swapsize=1607467008, devsize=1607467008
swapon: /swap1: swapon failed: Invalid argument

and bisection report commit 822bca52ee7e "mm/swapfile.c: fix potential
memory leak in sys_swapon" cause the trouble.

Go through the context I found the exit_swap_address_space(p->type)
shouldn't be used in good result path. So just move it to error path.

Fixes: 822bca52ee7e ("mm/swapfile.c: fix potential memory leak in
sys_swapon")
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: "Darrick J. Wong" <darrick.wong@oracle.com> 
Cc: Miaohe Lin <linmiaohe@huawei.com> 
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/swapfile.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c8966b8fc6ac..1ac1f737fee3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3339,7 +3339,8 @@ static bool swap_discardable(struct swap_info_struct *si)
 	error = inode_drain_writes(inode);
 	if (error) {
 		inode->i_flags &= ~S_SWAPFILE;
-		goto free_swap_address_space;
+		exit_swap_address_space(p->type);
+		goto bad_swap_unlock_inode;
 	}
 
 	mutex_lock(&swapon_mutex);
@@ -3364,8 +3365,6 @@ static bool swap_discardable(struct swap_info_struct *si)
 
 	error = 0;
 	goto out;
-free_swap_address_space:
-	exit_swap_address_space(p->type);
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
-- 
1.8.3.1


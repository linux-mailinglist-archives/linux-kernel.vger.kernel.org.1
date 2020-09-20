Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D212715EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgITQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:30:10 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52494 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgITQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:30:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U9VT.Ya_1600619405;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U9VT.Ya_1600619405)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 00:30:05 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] mm/shmem.c: Fix the missing unaccount on the failed path
Date:   Mon, 21 Sep 2020 00:30:05 +0800
Message-Id: <20200920163005.97079-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function __shmem_file_setup(), shmem_unacct_size() is forgotten
on the failed path, so add it.

Fixes: 93dec2da7b234 ("... and switch shmem_file_setup() to alloc_file_pseudo()")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 mm/shmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8e2b35ba93ad..591410dc3541 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4200,8 +4200,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	if (!IS_ERR(res))
 		res = alloc_file_pseudo(inode, mnt, name, O_RDWR,
 				&shmem_file_operations);
-	if (IS_ERR(res))
+	if (IS_ERR(res)) {
 		iput(inode);
+		shmem_unacct_size(flags, size);
+	}
 	return res;
 }
 
-- 
2.19.1.3.ge56e4f7


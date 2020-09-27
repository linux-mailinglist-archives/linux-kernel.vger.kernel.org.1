Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F6E27A209
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI0Rbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:31:36 -0400
Received: from m12-17.163.com ([220.181.12.17]:46387 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgI0Rbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:31:35 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 13:31:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=mP41w
        MntnvCkgDJ2Rd05Ypjo+YzOxqhfwWCbhE4V/aw=; b=b7pgi4fczi05mOffcE3Gk
        Yx9p5M/SiTptdbHBa65W7S1RQTB8wr/NQx09mxFM7QK1re6H24vaRuqgKAMM5xOB
        /M4Z6zjm7cgtJr44SL/5siS+BVOYrB9v7fMwH9QP9GpHjFMucubq2SvK1+FUrxht
        semEuPim5P17Yior2JoE04=
Received: from localhost (unknown [101.86.214.224])
        by smtp13 (Coremail) with SMTP id EcCowAAnlDjJyHBfD238Kg--.18710S2;
        Mon, 28 Sep 2020 01:15:53 +0800 (CST)
Date:   Mon, 28 Sep 2020 01:15:53 +0800
From:   Hui Su <sh_def@163.com>
To:     peterz@infradead.org, mingo@kernel.org, willy@infradead.org,
        sh_def@163.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] radix-tree: fix the comment of radix_tree_next_slot()
Message-ID: <20200927171553.GA6910@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowAAnlDjJyHBfD238Kg--.18710S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryfCrW8Ar1kWFyxKr1Utrb_yoW3XFg_Ca
        yxAr4kuw4xJrnrX340yF1aqF1Fqr13GrZaqa1fGFn5XF4DCan8uwn7GF9rtF4furn8Kas7
        JFZ2gFy8Zw1Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbKsj7UUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWQmsX1WBsxrbigAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the comment of radix_tree_next_slot():
interator --> iterator.

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/radix-tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index c2a9f7c90727..03591b18215f 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -376,7 +376,7 @@ radix_tree_chunk_size(struct radix_tree_iter *iter)
  * radix_tree_next_slot - find next slot in chunk
  *
  * @slot:	pointer to current slot
- * @iter:	pointer to interator state
+ * @iter:	pointer to iterator state
  * @flags:	RADIX_TREE_ITER_*, should be constant
  * Returns:	pointer to next slot, or NULL if there no more left
  *
-- 
2.25.1



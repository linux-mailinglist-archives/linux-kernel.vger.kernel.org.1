Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2581F8CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 06:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgFOEAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 00:00:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgFOEAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 00:00:39 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BDD5E5499FB0A399A876;
        Mon, 15 Jun 2020 12:00:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 12:00:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <xiang@kernel.org>, <chao@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel-hardening@lists.openwall.com>,
        Jason Yan <yanaijie@huawei.com>,
        Kees Cook <keescook@chromium.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] erofs: Eliminate usage of uninitialized_var() macro
Date:   Mon, 15 Jun 2020 12:01:41 +0800
Message-ID: <20200615040141.3627746-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an effort to eliminate the uninitialized_var() macro[1].

The use of this macro is the wrong solution because it forces off ANY
analysis by the compiler for a given variable. It even masks "unused
variable" warnings.

Quoted from Linus[2]:

"It's a horrible thing to use, in that it adds extra cruft to the
source code, and then shuts up a compiler warning (even the _reliable_
warnings from gcc)."

The gcc option "-Wmaybe-uninitialized" has been disabled and this change
will not produce any warnnings even with "make W=1".

[1] https://github.com/KSPP/linux/issues/81
[2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Cc: Kees Cook <keescook@chromium.org>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/erofs/data.c  | 4 ++--
 fs/erofs/zdata.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 64b56c7df023..d0542151e8c4 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -265,7 +265,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
  */
 static int erofs_raw_access_readpage(struct file *file, struct page *page)
 {
-	erofs_off_t uninitialized_var(last_block);
+	erofs_off_t last_block;
 	struct bio *bio;
 
 	trace_erofs_readpage(page, true);
@@ -282,7 +282,7 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 
 static void erofs_raw_access_readahead(struct readahead_control *rac)
 {
-	erofs_off_t uninitialized_var(last_block);
+	erofs_off_t last_block;
 	struct bio *bio = NULL;
 	struct page *page;
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index be50a4d9d273..24a26aaf847f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1161,7 +1161,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 	struct z_erofs_decompressqueue *q[NR_JOBQUEUES];
 	void *bi_private;
 	/* since bio will be NULL, no need to initialize last_index */
-	pgoff_t uninitialized_var(last_index);
+	pgoff_t last_index;
 	unsigned int nr_bios = 0;
 	struct bio *bio = NULL;
 
-- 
2.25.4


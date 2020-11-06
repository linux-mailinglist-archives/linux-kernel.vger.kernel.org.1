Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382742A8BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 01:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgKFAxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 19:53:40 -0500
Received: from smtp.infotech.no ([82.134.31.41]:34843 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732706AbgKFAxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 19:53:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 51E58204190;
        Fri,  6 Nov 2020 01:53:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DH-V2AzAhCmg; Fri,  6 Nov 2020 01:53:36 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 9037C204238;
        Fri,  6 Nov 2020 01:53:35 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bodo Stroesser <bostroesser@gmail.com>
Subject: [PATCH v4 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free() warning
Date:   Thu,  5 Nov 2020 19:53:30 -0500
Message-Id: <20201106005333.24281-2-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106005333.24281-1-dgilbert@interlog.com>
References: <20201106005333.24281-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check done by sgl_alloc_order() before it starts
any allocations. The comment in the original said: "Check for integer
overflow" but the check itself contained an integer overflow! The
right hand side (rhs) of the expression in the condition is resolved
as u32 so it could not exceed UINT32_MAX (4 GiB) which means 'length'
could not exceed that value. If that was the intention then the
comment above it could be dropped and the condition rewritten more
clearly as:
     if (length > UINT32_MAX) <<failure path >>;

Get around the integer overflow problem in the rhs of the original
check by taking ilog2() of both sides.

This function may be used to replace vmalloc(unsigned long) for a
large allocation (e.g. a ramdisk). vmalloc has no limit at 4 GiB so
it seems unreasonable that:
    sgl_alloc_order(unsigned long long length, ....)
does. sgl_s made with sgl_alloc_order() have equally sized segments
placed in a scatter gather array. That allows O(1) navigation around
a big sgl using some simple integer arithmetic.

Revise some of this function's description to more accurately reflect
what this function is doing.

An earlier patch fixed a memory leak in sg_alloc_order() due to the
misuse of sgl_free(). Take the opportunity to put a one line comment
above sgl_free()'s declaration warning that it is not suitable when
order > 0 .

Reviewed-by: Bodo Stroesser <bostroesser@gmail.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 include/linux/scatterlist.h |  1 +
 lib/scatterlist.c           | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 36c47e7e66a2..d9443ebd0a8e 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -308,6 +308,7 @@ struct scatterlist *sgl_alloc(unsigned long long length, gfp_t gfp,
 			      unsigned int *nent_p);
 void sgl_free_n_order(struct scatterlist *sgl, int nents, int order);
 void sgl_free_order(struct scatterlist *sgl, int order);
+/* Only use sgl_free() when order is 0 */
 void sgl_free(struct scatterlist *sgl);
 #endif /* CONFIG_SGL_ALLOC */
 
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a59778946404..4986545beef9 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -554,13 +554,15 @@ EXPORT_SYMBOL(sg_alloc_table_from_pages);
 #ifdef CONFIG_SGL_ALLOC
 
 /**
- * sgl_alloc_order - allocate a scatterlist and its pages
+ * sgl_alloc_order - allocate a scatterlist with equally sized elements
  * @length: Length in bytes of the scatterlist. Must be at least one
- * @order: Second argument for alloc_pages()
+ * @order: Second argument for alloc_pages(). Each sgl element size will
+ *	   be (PAGE_SIZE*2^order) bytes
  * @chainable: Whether or not to allocate an extra element in the scatterlist
- *	for scatterlist chaining purposes
+ *	       for scatterlist chaining purposes
  * @gfp: Memory allocation flags
- * @nent_p: [out] Number of entries in the scatterlist that have pages
+ * @nent_p: [out] Number of entries in the scatterlist that have pages.
+ *		  Ignored if NULL is given.
  *
  * Returns: A pointer to an initialized scatterlist or %NULL upon failure.
  */
@@ -574,8 +576,8 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 	u32 elem_len;
 
 	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
-	/* Check for integer overflow */
-	if (length > (nent << (PAGE_SHIFT + order)))
+	/* Integer overflow if:  length > nent*2^(PAGE_SHIFT+order) */
+	if (ilog2(length) > ilog2(nent) + PAGE_SHIFT + order)
 		return NULL;
 	nalloc = nent;
 	if (chainable) {
-- 
2.25.1


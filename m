Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA61F0390
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 01:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgFEXmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 19:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgFEXmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:42:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C35207DF;
        Fri,  5 Jun 2020 23:42:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jhLyg-002sDy-VX; Fri, 05 Jun 2020 19:42:22 -0400
Message-ID: <20200605234222.837956181@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Jun 2020 19:41:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 7/8] mm/zswap: Use local lock to protect per-CPU data
References: <20200605234149.965509211@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.4.44-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is an incremental update of the zswap patch. Addtional spots were
identified, which were lacking proper locking, during the rework of the
patch for upstream.
The complete patch description is available as commit
   79410590ae87e ("mm/zswap: Use local lock to protect per-CPU data")

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 mm/zswap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 21d2d3ed3d6d..3c9644b51f3f 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -372,6 +372,8 @@ static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
 * per-cpu code
 **********************************/
 static DEFINE_PER_CPU(u8 *, zswap_dstmem);
+/* Used for zswap_dstmem and tfm */
+static DEFINE_LOCAL_IRQ_LOCK(zswap_cpu_lock);
 
 static int zswap_dstmem_prepare(unsigned int cpu)
 {
@@ -889,10 +891,11 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		dlen = PAGE_SIZE;
 		src = (u8 *)zhdr + sizeof(struct zswap_header);
 		dst = kmap_atomic(page);
-		tfm = *get_cpu_ptr(entry->pool->tfm);
+		local_lock(zswap_cpu_lock);
+		tfm = *this_cpu_ptr(entry->pool->tfm);
 		ret = crypto_comp_decompress(tfm, src, entry->length,
 					     dst, &dlen);
-		put_cpu_ptr(entry->pool->tfm);
+		local_unlock(zswap_cpu_lock);
 		kunmap_atomic(dst);
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);
@@ -981,8 +984,6 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
-/* protect zswap_dstmem from concurrency */
-static DEFINE_LOCAL_IRQ_LOCK(zswap_dstmem_lock);
 /*********************************
 * frontswap hooks
 **********************************/
@@ -1060,7 +1061,8 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* compress */
-	dst = get_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_lock(zswap_cpu_lock);
+	dst = *this_cpu_ptr(&zswap_dstmem);
 	tfm = *this_cpu_ptr(entry->pool->tfm);
 	src = kmap_atomic(page);
 	ret = crypto_comp_compress(tfm, src, PAGE_SIZE, dst, &dlen);
@@ -1088,7 +1090,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
-	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
 
 	/* populate entry */
 	entry->offset = offset;
@@ -1116,7 +1118,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	return 0;
 
 put_dstmem:
-	put_locked_var(zswap_dstmem_lock, zswap_dstmem);
+	local_unlock(zswap_cpu_lock);
 	zswap_pool_put(entry->pool);
 freepage:
 	zswap_entry_cache_free(entry);
@@ -1161,9 +1163,10 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	if (zpool_evictable(entry->pool->zpool))
 		src += sizeof(struct zswap_header);
 	dst = kmap_atomic(page);
-	tfm = *get_cpu_ptr(entry->pool->tfm);
+	local_lock(zswap_cpu_lock);
+	tfm = *this_cpu_ptr(entry->pool->tfm);
 	ret = crypto_comp_decompress(tfm, src, entry->length, dst, &dlen);
-	put_cpu_ptr(entry->pool->tfm);
+	local_unlock(zswap_cpu_lock);
 	kunmap_atomic(dst);
 	zpool_unmap_handle(entry->pool->zpool, entry->handle);
 	BUG_ON(ret);
-- 
2.26.2



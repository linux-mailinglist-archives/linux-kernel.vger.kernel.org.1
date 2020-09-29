Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4369F27B932
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgI2BMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgI2BMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:12:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB26821D43;
        Tue, 29 Sep 2020 01:12:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kN4C2-002ItO-NV; Mon, 28 Sep 2020 21:12:34 -0400
Message-ID: <20200929011234.613169116@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 28 Sep 2020 21:11:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [for-next][PATCH 3/4] mm/page_ref: Convert the open coded tracepoint enabled to the new
 helper
References: <20200929011156.807392552@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As more use cases of checking if a tracepoint is enabled in a header are
coming to fruition, a helper macro, tracepoint_enabled(), has been added to
check if a tracepoint is enabled or not, and can be used with minimal header
requirements (avoid "include hell"). Convert the page_ref logic over to the
new helper macro.

Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/page_ref.h | 42 ++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index d27701199a4d..f3318f34fc54 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -7,13 +7,13 @@
 #include <linux/page-flags.h>
 #include <linux/tracepoint-defs.h>
 
-extern struct tracepoint __tracepoint_page_ref_set;
-extern struct tracepoint __tracepoint_page_ref_mod;
-extern struct tracepoint __tracepoint_page_ref_mod_and_test;
-extern struct tracepoint __tracepoint_page_ref_mod_and_return;
-extern struct tracepoint __tracepoint_page_ref_mod_unless;
-extern struct tracepoint __tracepoint_page_ref_freeze;
-extern struct tracepoint __tracepoint_page_ref_unfreeze;
+DECLARE_TRACEPOINT(page_ref_set);
+DECLARE_TRACEPOINT(page_ref_mod);
+DECLARE_TRACEPOINT(page_ref_mod_and_test);
+DECLARE_TRACEPOINT(page_ref_mod_and_return);
+DECLARE_TRACEPOINT(page_ref_mod_unless);
+DECLARE_TRACEPOINT(page_ref_freeze);
+DECLARE_TRACEPOINT(page_ref_unfreeze);
 
 #ifdef CONFIG_DEBUG_PAGE_REF
 
@@ -24,7 +24,7 @@ extern struct tracepoint __tracepoint_page_ref_unfreeze;
  *
  * See trace_##name##_enabled(void) in include/linux/tracepoint.h
  */
-#define page_ref_tracepoint_active(t) static_key_false(&(t).key)
+#define page_ref_tracepoint_active(t) tracepoint_enabled(t)
 
 extern void __page_ref_set(struct page *page, int v);
 extern void __page_ref_mod(struct page *page, int v);
@@ -75,7 +75,7 @@ static inline int page_count(struct page *page)
 static inline void set_page_count(struct page *page, int v)
 {
 	atomic_set(&page->_refcount, v);
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_set))
+	if (page_ref_tracepoint_active(page_ref_set))
 		__page_ref_set(page, v);
 }
 
@@ -91,14 +91,14 @@ static inline void init_page_count(struct page *page)
 static inline void page_ref_add(struct page *page, int nr)
 {
 	atomic_add(nr, &page->_refcount);
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
+	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, nr);
 }
 
 static inline void page_ref_sub(struct page *page, int nr)
 {
 	atomic_sub(nr, &page->_refcount);
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
+	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, -nr);
 }
 
@@ -106,7 +106,7 @@ static inline int page_ref_sub_return(struct page *page, int nr)
 {
 	int ret = atomic_sub_return(nr, &page->_refcount);
 
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_return))
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
 		__page_ref_mod_and_return(page, -nr, ret);
 	return ret;
 }
@@ -114,14 +114,14 @@ static inline int page_ref_sub_return(struct page *page, int nr)
 static inline void page_ref_inc(struct page *page)
 {
 	atomic_inc(&page->_refcount);
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
+	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, 1);
 }
 
 static inline void page_ref_dec(struct page *page)
 {
 	atomic_dec(&page->_refcount);
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
+	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, -1);
 }
 
@@ -129,7 +129,7 @@ static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
 	int ret = atomic_sub_and_test(nr, &page->_refcount);
 
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_test))
+	if (page_ref_tracepoint_active(page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -nr, ret);
 	return ret;
 }
@@ -138,7 +138,7 @@ static inline int page_ref_inc_return(struct page *page)
 {
 	int ret = atomic_inc_return(&page->_refcount);
 
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_return))
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
 		__page_ref_mod_and_return(page, 1, ret);
 	return ret;
 }
@@ -147,7 +147,7 @@ static inline int page_ref_dec_and_test(struct page *page)
 {
 	int ret = atomic_dec_and_test(&page->_refcount);
 
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_test))
+	if (page_ref_tracepoint_active(page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -1, ret);
 	return ret;
 }
@@ -156,7 +156,7 @@ static inline int page_ref_dec_return(struct page *page)
 {
 	int ret = atomic_dec_return(&page->_refcount);
 
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_and_return))
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
 		__page_ref_mod_and_return(page, -1, ret);
 	return ret;
 }
@@ -165,7 +165,7 @@ static inline int page_ref_add_unless(struct page *page, int nr, int u)
 {
 	int ret = atomic_add_unless(&page->_refcount, nr, u);
 
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod_unless))
+	if (page_ref_tracepoint_active(page_ref_mod_unless))
 		__page_ref_mod_unless(page, nr, ret);
 	return ret;
 }
@@ -174,7 +174,7 @@ static inline int page_ref_freeze(struct page *page, int count)
 {
 	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
 
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_freeze))
+	if (page_ref_tracepoint_active(page_ref_freeze))
 		__page_ref_freeze(page, count, ret);
 	return ret;
 }
@@ -185,7 +185,7 @@ static inline void page_ref_unfreeze(struct page *page, int count)
 	VM_BUG_ON(count == 0);
 
 	atomic_set_release(&page->_refcount, count);
-	if (page_ref_tracepoint_active(__tracepoint_page_ref_unfreeze))
+	if (page_ref_tracepoint_active(page_ref_unfreeze))
 		__page_ref_unfreeze(page, count);
 }
 
-- 
2.28.0



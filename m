Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D71F5907
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 18:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgFJQbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 12:31:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgFJQbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1CABAD6B;
        Wed, 10 Jun 2020 16:31:53 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vinmenon@codeaurora.org,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: [PATCH 4/9] mm, slub: make remaining slub_debug related attributes read-only
Date:   Wed, 10 Jun 2020 18:31:30 +0200
Message-Id: <20200610163135.17364-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610163135.17364-1-vbabka@suse.cz>
References: <20200610163135.17364-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB_DEBUG creates several files under /sys/kernel/slab/<cache>/ that can be
read to check if the respective debugging options are enabled for given cache.
Some options, namely sanity_checks, trace, and failslab can be also enabled and
disabled at runtime by writing into the files.

The runtime toggling is racy. Some options disable __CMPXCHG_DOUBLE when
enabled, which means that in case of concurrent allocations, some can still use
__CMPXCHG_DOUBLE and some not, leading to potential corruption. The s->flags
field is also not updated or checked atomically. The simplest solution is to
remove the runtime toggling. The extended slub_debug boot parameter syntax
introduced by earlier patch should allow to fine-tune the debugging
configuration during boot with same granularity.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Roman Gushchin <guro@fb.com>
---
 Documentation/vm/slub.rst |  7 ++---
 mm/slub.c                 | 62 ++-------------------------------------
 2 files changed, 5 insertions(+), 64 deletions(-)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 36241dfba024..289d231cee97 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -116,11 +116,8 @@ If the file contains 1, the option is enabled, 0 means disabled. The debug
 	T	trace
 	A	failslab
 
-The sanity_checks, trace and failslab files are writable, so writing 1 or 0
-will enable or disable the option at runtime. The writes to trace and failslab
-may return -EINVAL if the cache is subject to slab merging. Careful with
-tracing: It may spew out lots of information and never stop if used on the
-wrong slab.
+Careful with tracing: It may spew out lots of information and never stop if
+used on the wrong slab.
 
 Slab merging
 ============
diff --git a/mm/slub.c b/mm/slub.c
index c5f3f2424392..0108829838e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5056,20 +5056,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 	return x + sprintf(buf + x, "\n");
 }
 
-#ifdef CONFIG_SLUB_DEBUG
-static int any_slab_objects(struct kmem_cache *s)
-{
-	int node;
-	struct kmem_cache_node *n;
-
-	for_each_kmem_cache_node(s, node, n)
-		if (atomic_long_read(&n->total_objects))
-			return 1;
-
-	return 0;
-}
-#endif
-
 #define to_slab_attr(n) container_of(n, struct slab_attribute, attr)
 #define to_slab(n) container_of(n, struct kmem_cache, kobj)
 
@@ -5291,43 +5277,13 @@ static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECKS));
 }
-
-static ssize_t sanity_checks_store(struct kmem_cache *s,
-				const char *buf, size_t length)
-{
-	s->flags &= ~SLAB_CONSISTENCY_CHECKS;
-	if (buf[0] == '1') {
-		s->flags &= ~__CMPXCHG_DOUBLE;
-		s->flags |= SLAB_CONSISTENCY_CHECKS;
-	}
-	return length;
-}
-SLAB_ATTR(sanity_checks);
+SLAB_ATTR_RO(sanity_checks);
 
 static ssize_t trace_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%d\n", !!(s->flags & SLAB_TRACE));
 }
-
-static ssize_t trace_store(struct kmem_cache *s, const char *buf,
-							size_t length)
-{
-	/*
-	 * Tracing a merged cache is going to give confusing results
-	 * as well as cause other issues like converting a mergeable
-	 * cache into an umergeable one.
-	 */
-	if (s->refcount > 1)
-		return -EINVAL;
-
-	s->flags &= ~SLAB_TRACE;
-	if (buf[0] == '1') {
-		s->flags &= ~__CMPXCHG_DOUBLE;
-		s->flags |= SLAB_TRACE;
-	}
-	return length;
-}
-SLAB_ATTR(trace);
+SLAB_ATTR_RO(trace);
 
 static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
 {
@@ -5391,19 +5347,7 @@ static ssize_t failslab_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%d\n", !!(s->flags & SLAB_FAILSLAB));
 }
-
-static ssize_t failslab_store(struct kmem_cache *s, const char *buf,
-							size_t length)
-{
-	if (s->refcount > 1)
-		return -EINVAL;
-
-	s->flags &= ~SLAB_FAILSLAB;
-	if (buf[0] == '1')
-		s->flags |= SLAB_FAILSLAB;
-	return length;
-}
-SLAB_ATTR(failslab);
+SLAB_ATTR_RO(failslab);
 #endif
 
 static ssize_t shrink_show(struct kmem_cache *s, char *buf)
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127B11F5908
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgFJQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 12:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbgFJQbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1388AC79;
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
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 2/9] mm, slub: make some slub_debug related attributes read-only
Date:   Wed, 10 Jun 2020 18:31:28 +0200
Message-Id: <20200610163135.17364-3-vbabka@suse.cz>
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
The options can be also toggled at runtime by writing into the files. Some of
those, namely red_zone, poison, and store_user can be toggled only when no
objects yet exist in the cache.

Vijayanand reports [1] that there is a problem with freelist randomization if
changing the debugging option's state results in different number of objects
per page, and the random sequence cache needs thus needs to be recomputed.

However, another problem is that the check for "no objects yet exist in the
cache" is racy, as noted by Jann [2] and fixing that would add overhead or
otherwise complicate the allocation/freeing paths. Thus it would be much
simpler just to remove the runtime toggling support. The documentation
describes it's "In case you forgot to enable debugging on the kernel command
line", but the neccessity of having no objects limits its usefulness anyway for
many caches.

Vijayanand describes an use case [3] where debugging is enabled for all but
zram caches for memory overhead reasons, and using the runtime toggles was the
only way to achieve such configuration. After the previous patch it's now
possible to do that directly from the kernel boot option, so we can remove the
dangerous runtime toggles by making the /sys attribute files read-only.

While updating it, also improve the documentation of the debugging /sys files.

[1] https://lkml.kernel.org/r/1580379523-32272-1-git-send-email-vjitta@codeaurora.org
[2] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com
[3] https://lore.kernel.org/r/1383cd32-1ddc-4dac-b5f8-9c42282fa81c@codeaurora.org

Reported-by: Vijayanand Jitta <vjitta@codeaurora.org>
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Roman Gushchin <guro@fb.com>
---
 Documentation/vm/slub.rst | 28 ++++++++++++++----------
 mm/slub.c                 | 46 +++------------------------------------
 2 files changed, 20 insertions(+), 54 deletions(-)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index cfccb258cf42..36241dfba024 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -101,20 +101,26 @@ debugged by specifying global debug options followed by a list of slab names
 
 	slub_debug=FZ;-,zs_handle,zspage
 
-In case you forgot to enable debugging on the kernel command line: It is
-possible to enable debugging manually when the kernel is up. Look at the
-contents of::
+The state of each debug option for a slab can be found in the respective files
+under::
 
 	/sys/kernel/slab/<slab name>/
 
-Look at the writable files. Writing 1 to them will enable the
-corresponding debug option. All options can be set on a slab that does
-not contain objects. If the slab already contains objects then sanity checks
-and tracing may only be enabled. The other options may cause the realignment
-of objects.
-
-Careful with tracing: It may spew out lots of information and never stop if
-used on the wrong slab.
+If the file contains 1, the option is enabled, 0 means disabled. The debug
+options from the ``slub_debug`` parameter translate to the following files::
+
+	F	sanity_checks
+	Z	red_zone
+	P	poison
+	U	store_user
+	T	trace
+	A	failslab
+
+The sanity_checks, trace and failslab files are writable, so writing 1 or 0
+will enable or disable the option at runtime. The writes to trace and failslab
+may return -EINVAL if the cache is subject to slab merging. Careful with
+tracing: It may spew out lots of information and never stop if used on the
+wrong slab.
 
 Slab merging
 ============
diff --git a/mm/slub.c b/mm/slub.c
index a53371426e06..e254164d6cae 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5351,61 +5351,21 @@ static ssize_t red_zone_show(struct kmem_cache *s, char *buf)
 	return sprintf(buf, "%d\n", !!(s->flags & SLAB_RED_ZONE));
 }
 
-static ssize_t red_zone_store(struct kmem_cache *s,
-				const char *buf, size_t length)
-{
-	if (any_slab_objects(s))
-		return -EBUSY;
-
-	s->flags &= ~SLAB_RED_ZONE;
-	if (buf[0] == '1') {
-		s->flags |= SLAB_RED_ZONE;
-	}
-	calculate_sizes(s, -1);
-	return length;
-}
-SLAB_ATTR(red_zone);
+SLAB_ATTR_RO(red_zone);
 
 static ssize_t poison_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%d\n", !!(s->flags & SLAB_POISON));
 }
 
-static ssize_t poison_store(struct kmem_cache *s,
-				const char *buf, size_t length)
-{
-	if (any_slab_objects(s))
-		return -EBUSY;
-
-	s->flags &= ~SLAB_POISON;
-	if (buf[0] == '1') {
-		s->flags |= SLAB_POISON;
-	}
-	calculate_sizes(s, -1);
-	return length;
-}
-SLAB_ATTR(poison);
+SLAB_ATTR_RO(poison);
 
 static ssize_t store_user_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%d\n", !!(s->flags & SLAB_STORE_USER));
 }
 
-static ssize_t store_user_store(struct kmem_cache *s,
-				const char *buf, size_t length)
-{
-	if (any_slab_objects(s))
-		return -EBUSY;
-
-	s->flags &= ~SLAB_STORE_USER;
-	if (buf[0] == '1') {
-		s->flags &= ~__CMPXCHG_DOUBLE;
-		s->flags |= SLAB_STORE_USER;
-	}
-	calculate_sizes(s, -1);
-	return length;
-}
-SLAB_ATTR(store_user);
+SLAB_ATTR_RO(store_user);
 
 static ssize_t validate_show(struct kmem_cache *s, char *buf)
 {
-- 
2.26.2


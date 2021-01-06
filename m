Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E72EC289
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAFRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:41:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:43844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbhAFRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:41:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93798AD7A;
        Wed,  6 Jan 2021 17:40:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 2/3] mm, slab, slub: stop taking cpu hotplug lock
Date:   Wed,  6 Jan 2021 18:40:28 +0100
Message-Id: <20210106174029.12654-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106174029.12654-1-vbabka@suse.cz>
References: <20210106174029.12654-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLAB has been using get/put_online_cpus() around creating, destroying and
shrinking kmem caches since 95402b382901 ("cpu-hotplug: replace per-subsystem
mutexes with get_online_cpus()") in 2008, which is supposed to be replacing
a private mutex (cache_chain_mutex, called slab_mutex today) with system-wide
mechanism, but in case of SLAB it's in fact used in addition to the existing
mutex, without explanation why.

SLUB appears to have avoided the cpu hotplug lock initially, but gained it due
to common code unification, such as 20cea9683ecc ("mm, sl[aou]b: Move
kmem_cache_create mutex handling to common code").

Regardless of the history, checking if the hotplug lock is actually needed
today suggests that it's not, and therefore it's better to avoid this
system-wide lock and the ordering this imposes wrt other locks (such as
slab_mutex).

Specifically, in SLAB we have for_each_online_cpu() in do_tune_cpucache()
protected by slab_mutex, and cpu hotplug callbacks that also take the
slab_mutex, which is also taken by the common slab function that currently also
take the hotplug lock. Thus the slab_mutex protection should be sufficient.
Also per-cpu array caches are allocated for each possible cpu, so not affected
by their online/offline state.

In SLUB we have for_each_online_cpu() in functions that show statistics and are
already unprotected today, as racing with hotplug is not harmful. Otherwise
SLUB relies on percpu allocator. The slub_cpu_dead() hotplug callback takes the
slab_mutex.

To sum up, this patch removes get/put_online_cpus() calls from slab as it
should be safe without further adjustments.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e728265c8b7d..0f29a2b59dac 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -310,8 +310,6 @@ kmem_cache_create_usercopy(const char *name,
 	const char *cache_name;
 	int err;
 
-	get_online_cpus();
-
 	mutex_lock(&slab_mutex);
 
 	err = kmem_cache_sanity_check(name, size);
@@ -360,8 +358,6 @@ kmem_cache_create_usercopy(const char *name,
 out_unlock:
 	mutex_unlock(&slab_mutex);
 
-	put_online_cpus();
-
 	if (err) {
 		if (flags & SLAB_PANIC)
 			panic("kmem_cache_create: Failed to create slab '%s'. Error %d\n",
@@ -487,8 +483,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
-	get_online_cpus();
-
 	mutex_lock(&slab_mutex);
 
 	s->refcount--;
@@ -503,8 +497,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	}
 out_unlock:
 	mutex_unlock(&slab_mutex);
-
-	put_online_cpus();
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
@@ -521,14 +513,12 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 {
 	int ret;
 
-	get_online_cpus();
 	mutex_lock(&slab_mutex);
 
 	kasan_cache_shrink(cachep);
 	ret = __kmem_cache_shrink(cachep);
 
 	mutex_unlock(&slab_mutex);
-	put_online_cpus();
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_shrink);
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482E3274465
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIVOhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgIVOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34205B11F;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 5/9] mm, page_alloc: make per_cpu_pageset accessible only after init
Date:   Tue, 22 Sep 2020 16:37:08 +0200
Message-Id: <20200922143712.12048-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922143712.12048-1-vbabka@suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

setup_zone_pageset() replaces the boot_pageset by allocating and initializing a
proper percpu one. Currently it assigns zone->pageset with the newly allocated
one before initializing it. That's currently not an issue, because the zone
should not be in any zonelist, thus not visible to allocators at this point.

Memory ordering between the pcplist contents and its visibility is also not
guaranteed here, but that also shouldn't be an issue because online_pages()
does a spin_unlock(pgdat->node_size_lock) before building the zonelists.

However it's best that we don't silently rely on operations that can be changed
in the future. Make sure only properly initialized pcplists are visible, using
smp_store_release(). The read side has a data dependency via the zone->pageset
pointer instead of an explicit read barrier.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 99b74c1c2b0a..de3b48bda45c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6246,15 +6246,17 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
 
 void __meminit setup_zone_pageset(struct zone *zone)
 {
+	struct per_cpu_pageset __percpu * new_pageset;
 	struct per_cpu_pageset *p;
 	int cpu;
 
-	zone->pageset = alloc_percpu(struct per_cpu_pageset);
+	new_pageset = alloc_percpu(struct per_cpu_pageset);
 	for_each_possible_cpu(cpu) {
-		p = per_cpu_ptr(zone->pageset, cpu);
+		p = per_cpu_ptr(new_pageset, cpu);
 		pageset_init(p);
 	}
 
+	smp_store_release(&zone->pageset, new_pageset);
 	zone_set_pageset_high_and_batch(zone);
 }
 
-- 
2.28.0


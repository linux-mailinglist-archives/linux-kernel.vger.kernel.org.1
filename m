Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C27274460
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIVOhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVOhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 008C9ACC2;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 3/9] mm, page_alloc: remove setup_pageset()
Date:   Tue, 22 Sep 2020 16:37:06 +0200
Message-Id: <20200922143712.12048-4-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922143712.12048-1-vbabka@suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We initialize boot-time pagesets with setup_pageset(), which sets high and
batch values that effectively disable pcplists.

We can remove this wrapper if we just set these values for all pagesets in
pageset_init(). Non-boot pagesets then subsequently update them to the proper
values.

No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 26069c8d1b19..76c2b4578723 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5823,7 +5823,7 @@ static void build_zonelists(pg_data_t *pgdat)
  * not check if the processor is online before following the pageset pointer.
  * Other parts of the kernel may not check if the zone is available.
  */
-static void setup_pageset(struct per_cpu_pageset *p);
+static void pageset_init(struct per_cpu_pageset *p);
 static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
@@ -5891,7 +5891,7 @@ build_all_zonelists_init(void)
 	 * (a chicken-egg dilemma).
 	 */
 	for_each_possible_cpu(cpu)
-		setup_pageset(&per_cpu(boot_pageset, cpu));
+		pageset_init(&per_cpu(boot_pageset, cpu));
 
 	mminit_verify_zonelist();
 	cpuset_init_current_mems_allowed();
@@ -6210,12 +6210,15 @@ static void pageset_init(struct per_cpu_pageset *p)
 	pcp = &p->pcp;
 	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++)
 		INIT_LIST_HEAD(&pcp->lists[migratetype]);
-}
 
-static void setup_pageset(struct per_cpu_pageset *p)
-{
-	pageset_init(p);
-	pageset_update(&p->pcp, 0, 1);
+	/*
+	 * Set batch and high values safe for a boot pageset. A true percpu
+	 * pageset's initialization will update them subsequently. Here we don't
+	 * need to be as careful as pageset_update() as nobody can access the
+	 * pageset yet.
+	 */
+	pcp->high = 0;
+	pcp->batch = 1;
 }
 
 /*
-- 
2.28.0


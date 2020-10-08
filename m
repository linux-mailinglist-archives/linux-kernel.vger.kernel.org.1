Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182F7287B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgJHRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:55:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgJHRzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:55:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 299F6AEEE;
        Thu,  8 Oct 2020 17:55:04 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] mm, page_alloc: cache pageset high and batch in
 struct zone
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20201008114201.18824-1-vbabka@suse.cz>
 <20201008114201.18824-6-vbabka@suse.cz>
 <20201008123129.GC4967@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fb44322e-c1b1-83e1-de94-e3837c363b95@suse.cz>
Date:   Thu, 8 Oct 2020 19:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008123129.GC4967@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 2:31 PM, Michal Hocko wrote:
> On Thu 08-10-20 13:41:59, Vlastimil Babka wrote:
>> All per-cpu pagesets for a zone use the same high and batch values, that are
>> duplicated there just for performance (locality) reasons. This patch adds the
>> same variables also to struct zone as a shared copy.
>> 
>> This will be useful later for making possible to disable pcplists temporarily
>> by setting high value to 0, while remembering the values for restoring them
>> later. But we can also immediately benefit from not updating pagesets of all
>> possible cpus in case the newly recalculated values (after sysctl change or
>> memory online/offline) are actually unchanged from the previous ones.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> I would consider the check flipped with early return more pleasing to my
> eyes but nothing to lose sleep over.

Right, here's updated patch:

----8<----
 From 6ab0f03762d122a896349d5e568f75c20875eb42 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 7 Sep 2020 14:20:08 +0200
Subject: [PATCH v2 5/7] mm, page_alloc: cache pageset high and batch in struct
  zone

All per-cpu pagesets for a zone use the same high and batch values, that are
duplicated there just for performance (locality) reasons. This patch adds the
same variables also to struct zone as a shared copy.

This will be useful later for making possible to disable pcplists temporarily
by setting high value to 0, while remembering the values for restoring them
later. But we can also immediately benefit from not updating pagesets of all
possible cpus in case the newly recalculated values (after sysctl change or
memory online/offline) are actually unchanged from the previous ones.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
---
  include/linux/mmzone.h |  6 ++++++
  mm/page_alloc.c        | 16 ++++++++++++++--
  2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..c63863794afc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -470,6 +470,12 @@ struct zone {
  #endif
  	struct pglist_data	*zone_pgdat;
  	struct per_cpu_pageset __percpu *pageset;
+	/*
+	 * the high and batch values are copied to individual pagesets for
+	 * faster access
+	 */
+	int pageset_high;
+	int pageset_batch;

  #ifndef CONFIG_SPARSEMEM
  	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f33c36312eb5..057baefba8f3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5900,6 +5900,9 @@ static void build_zonelists(pg_data_t *pgdat)
   * Other parts of the kernel may not check if the zone is available.
   */
  static void pageset_init(struct per_cpu_pageset *p);
+/* These effectively disable the pcplists in the boot pageset completely */
+#define BOOT_PAGESET_HIGH	0
+#define BOOT_PAGESET_BATCH	1
  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);

@@ -6289,8 +6292,8 @@ static void pageset_init(struct per_cpu_pageset *p)
  	 * need to be as careful as pageset_update() as nobody can access the
  	 * pageset yet.
  	 */
-	pcp->high = 0;
-	pcp->batch = 1;
+	pcp->high = BOOT_PAGESET_HIGH;
+	pcp->batch = BOOT_PAGESET_BATCH;
  }

  /*
@@ -6314,6 +6317,13 @@ static void zone_set_pageset_high_and_batch(struct zone 
*zone)
  		new_batch = max(1UL, 1 * new_batch);
  	}

+	if (zone->pageset_high == new_high &&
+	    zone->pageset_batch == new_batch)
+		return;
+
+	zone->pageset_high = new_high;
+	zone->pageset_batch = new_batch;
+
  	for_each_possible_cpu(cpu) {
  		p = per_cpu_ptr(zone->pageset, cpu);
  		pageset_update(&p->pcp, new_high, new_batch);
@@ -6374,6 +6384,8 @@ static __meminit void zone_pcp_init(struct zone *zone)
  	 * offset of a (static) per cpu variable into the per cpu area.
  	 */
  	zone->pageset = &boot_pageset;
+	zone->pageset_high = BOOT_PAGESET_HIGH;
+	zone->pageset_batch = BOOT_PAGESET_BATCH;

  	if (populated_zone(zone))
  		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%u\n",
-- 
2.28.0




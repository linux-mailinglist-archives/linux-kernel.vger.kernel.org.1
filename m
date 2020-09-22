Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07475274463
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIVOhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgIVOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03AE1B0B3;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/9] disable pcplists during memory offline
Date:   Tue, 22 Sep 2020 16:37:03 +0200
Message-Id: <20200922143712.12048-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the discussions [1] [2] this is an attempt to implement David's
suggestion that page isolation should disable pcplists to avoid races with page
freeing in progress. This is done without extra checks in fast paths, as
explained in Patch 9. The repeated draining done by [2] is then no longer
needed. Previous version (RFC) is at [3].

The RFC tried to hide pcplists disabling/enabling into page isolation, but it
wasn't completely possible, as memory offline does not unisolation. Michal
suggested an explicit API in [4] so that's the current implementation and it
seems indeed nicer.

Once we accept that page isolation users need to do explicit actions around it
depending on the needed guarantees, we can also IMHO accept that the current
pcplist draining can be also done by the callers, which is more effective.
After all, there are only two users of page isolation. So patch 7 does
effectively the same thing as Pavel proposed in [5], and patches 8-9 implement
stronger guarantees only for memory offline. If CMA decides to opt-in to the
stronger guarantee, it's easy to do so.

Patches 1-6 are preparatory cleanups for pcplist disabling.

Patchset was briefly tested in QEMU so that memory online/offline works, but
I haven't done a stress test that would prove the race fixed by [2] is
eliminated.

Note that patch 9 could be avoided if we instead adjusted page freeing in shown
in [6], but I believe the current implementation of disabling pcplists is not
too much complex, so I would prefer this instead of adding new checks and
longer irq-disabled section into page freeing hotpaths.

[1] https://lore.kernel.org/linux-mm/20200901124615.137200-1-pasha.tatashin@soleen.com/
[2] https://lore.kernel.org/linux-mm/20200903140032.380431-1-pasha.tatashin@soleen.com/
[3] https://lore.kernel.org/linux-mm/20200907163628.26495-1-vbabka@suse.cz/
[4] https://lore.kernel.org/linux-mm/20200909113647.GG7348@dhcp22.suse.cz/
[5] https://lore.kernel.org/linux-mm/20200904151448.100489-3-pasha.tatashin@soleen.com/
[6] https://lore.kernel.org/linux-mm/3d3b53db-aeaa-ff24-260b-36427fac9b1c@suse.cz/

Vlastimil Babka (9):
  mm, page_alloc: clean up pageset high and batch update
  mm, page_alloc: calculate pageset high and batch once per zone
  mm, page_alloc: remove setup_pageset()
  mm, page_alloc: simplify pageset_update()
  mm, page_alloc: make per_cpu_pageset accessible only after init
  mm, page_alloc: cache pageset high and batch in struct zone
  mm, page_alloc: move draining pcplists to page isolation users
  mm, page_alloc: drain all pcplists during memory offline
  mm, page_alloc: optionally disable pcplists during page isolation

 include/linux/gfp.h            |   1 +
 include/linux/mmzone.h         |   8 ++
 include/linux/page-isolation.h |   2 +
 mm/internal.h                  |   4 +
 mm/memory_hotplug.c            |  27 +++--
 mm/page_alloc.c                | 190 ++++++++++++++++++---------------
 mm/page_isolation.c            |  26 ++++-
 7 files changed, 152 insertions(+), 106 deletions(-)

-- 
2.28.0


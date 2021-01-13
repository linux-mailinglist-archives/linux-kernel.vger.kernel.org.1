Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83832F4C23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhAMNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:17:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:56768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbhAMNR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:17:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61F64B7D4;
        Wed, 13 Jan 2021 13:16:46 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Qian Cai <cai@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 0/3] mm, slab, slub: remove cpu and memory hotplug locks
Date:   Wed, 13 Jan 2021 14:16:31 +0100
Message-Id: <20210113131634.3671-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC:
- lockdep didn't like reintroducing slab_mutex in kmem_cache_shrink(), so
  instead explain why it's not needed after all (in Patch 2)
- the above is only safe with Patch 1 already in place, so order it first
  (current Patch 1 was Patch 3 in RFC)

Some related work caused me to look at how we use get/put_mems_online() and
get/put_online_cpus() during kmem cache creation/descruction/shrinking, and
realize that it should be actually safe to remove all of that with rather small
effort (as e.g. Michal Hocko suspected in some of the past discussions
already). This has the benefit to avoid rather heavy locks that have caused
locking order issues already in the past. So this is the result, Patches 2 and
3 remove memory hotplug and cpu hotplug locking, respectively. Patch 1 is due
to realization that in fact some races exist despite the locks (even if not
removed), but the most sane solution is not to introduce more of them, but
rather accept some wasted memory in scenarios that should be rare anyway (full
memory hot remove), as we do the same in other contexts already.

Vlastimil Babka (3):
  mm, slub: stop freeing kmem_cache_node structures on node offline
  mm, slab, slub: stop taking memory hotplug lock
  mm, slab, slub: stop taking cpu hotplug lock

 mm/slab_common.c | 18 ++--------------
 mm/slub.c        | 56 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 38 insertions(+), 36 deletions(-)

-- 
2.29.2


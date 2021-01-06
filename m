Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB32EC286
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbhAFRlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:41:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:43806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbhAFRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:41:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92CD9AD64;
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
Subject: [RFC 0/3] mm, slab, slub: remove cpu and memory hotplug locks
Date:   Wed,  6 Jan 2021 18:40:26 +0100
Message-Id: <20210106174029.12654-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some related work caused me to look at how we use get/put_mems_online() and
get/put_online_cpus() during kmem cache creation/descruction/shrinking, and
realize that it should be actually safe to remove all of that with rather small
effort (as e.g. Michal Hocko suspected in some of the past discussions
already). This has the benefit to avoid rather heavy locks that have caused
locking order issues already in the past. So this is the result, Patches 1 and
2 remove memory hotplug and cpu hotplug locking, respectively. Patch 3 is due
to realization that in fact some races exist despite the locks (even if not
removed), but the most sane solution is not to introduce more of them, but
rather accept some wasted memory in scenarios that should be rare anyway (full
memory hot remove), as we do the same in other contexts already. It's all RFC
for now, as I might have missed some reason why it's not safe.

Vlastimil Babka (3):
  mm, slab, slub: stop taking memory hotplug lock
  mm, slab, slub: stop taking cpu hotplug lock
  mm, slub: stop freeing kmem_cache_node structures on node offline

 mm/slab_common.c | 20 ++++--------------
 mm/slub.c        | 54 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 34 deletions(-)

-- 
2.29.2


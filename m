Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75CB2B1936
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKMKkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:40:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:39658 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgKMKkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:40:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB395ABD1;
        Fri, 13 Nov 2020 10:40:47 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 0/5] cleanup page poisoning
Date:   Fri, 13 Nov 2020 11:40:28 +0100
Message-Id: <20201113104033.22907-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [2]

- rebase to next-20201113
- apply review feedback from David
- acks from David and Rafael (thanks!)

The first version was called "optimize handling of memory debugging parameters"
[1], changes are:

- apply review feedback
- drop former Patch 3
- add new patches 3-5, change name and cover letter of series

I have identified a number of issues and opportunities for cleanup with
CONFIG_PAGE_POISON and friends:
- interaction with init_on_alloc and init_on_free parameters depends on
  the order of parameters (Patch 1)
- the boot time enabling uses static key, but inefficienty (Patch 2)
- sanity checking is incompatible with hibernation (Patch 3)
- CONFIG_PAGE_POISONING_NO_SANITY can be removed now that we have init_on_free
  (Patch 4)
- CONFIG_PAGE_POISONING_ZERO can be most likely removed now that we have
  init_on_free (Patch 5)

[1] https://lore.kernel.org/r/20201026173358.14704-1-vbabka@suse.cz
[2] https://lore.kernel.org/linux-mm/20201103152237.9853-1-vbabka@suse.cz/

Vlastimil Babka (5):
  mm, page_alloc: do not rely on the order of page_poison and
    init_on_alloc/free parameters
  mm, page_poison: use static key more efficiently
  kernel/power: allow hibernation with page_poison sanity checking
  mm, page_poison: remove CONFIG_PAGE_POISONING_NO_SANITY
  mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO

 drivers/virtio/virtio_balloon.c |   4 +-
 include/linux/mm.h              |  54 +++++++++------
 include/linux/poison.h          |   4 --
 init/main.c                     |   2 +-
 kernel/power/hibernate.c        |   2 +-
 kernel/power/power.h            |   2 +-
 kernel/power/snapshot.c         |  14 +++-
 mm/Kconfig.debug                |  28 ++------
 mm/page_alloc.c                 | 112 ++++++++++++++++----------------
 mm/page_poison.c                |  56 ++--------------
 tools/include/linux/poison.h    |   6 +-
 11 files changed, 117 insertions(+), 167 deletions(-)

-- 
2.29.2


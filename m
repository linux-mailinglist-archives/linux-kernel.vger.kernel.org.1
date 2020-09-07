Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9424125FFDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgIGQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 12:40:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730905AbgIGQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:36:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D76DB00E;
        Mon,  7 Sep 2020 16:36:43 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC 0/5] disable pcplists during page isolation
Date:   Mon,  7 Sep 2020 18:36:23 +0200
Message-Id: <20200907163628.26495-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the discussions [1] [2] this is an attempt to implement David's
suggestion that page isolation should disable pcplists to avoid races. This is
done without extra checks in fast paths, as I mentioned should be possible in
the discussion, and explained in patch 5. Patches 1-4 are preparatory cleanups.

Note this is untested RFC for now. Based on v5.9-rc4 plus Pavel's patch [2]
(slated as a quick fix for mainline+stable).

[1] https://lore.kernel.org/linux-mm/20200901124615.137200-1-pasha.tatashin@soleen.com/
[2] https://lore.kernel.org/linux-mm/20200903140032.380431-1-pasha.tatashin@soleen.com/

Vlastimil Babka (5):
  mm, page_alloc: clean up pageset high and batch update
  mm, page_alloc: calculate pageset high and batch once per zone
  mm, page_alloc(): remove setup_pageset()
  mm, page_alloc: cache pageset high and batch in struct zone
  mm, page_alloc: disable pcplists during page isolation

 include/linux/gfp.h    |   1 +
 include/linux/mmzone.h |   2 +
 mm/internal.h          |   4 ++
 mm/memory_hotplug.c    |  24 +++----
 mm/page_alloc.c        | 138 ++++++++++++++++++++++-------------------
 mm/page_isolation.c    |  45 +++++++++++---
 6 files changed, 127 insertions(+), 87 deletions(-)

-- 
2.28.0


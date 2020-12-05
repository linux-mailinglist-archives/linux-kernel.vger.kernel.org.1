Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE32CF8A4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgLEBeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:34:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728100AbgLEBeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607131968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pu0zTKndkBixewwk8Qvv8hZiW9lm9BrjATafjEDa54k=;
        b=IB/hG/mFbxc6+uCj+YUL3g23C7QTIg3i6cIfhTNNaYOssBeU28uOa3o3weF0kJG7S24F2K
        yb+LORa0CzqyytatHrNeDgflIXT6jpabehIePA+qRbfF3kPblDvbbnkyIHhQdH/cGFLkim
        QuGXrs9QOckzBYbl82gpCK+qT2bmysM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-kMt-KyMCP0i8GfsHXaGpmw-1; Fri, 04 Dec 2020 20:32:45 -0500
X-MC-Unique: kMt-KyMCP0i8GfsHXaGpmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D96EC287;
        Sat,  5 Dec 2020 01:32:44 +0000 (UTC)
Received: from mail (ovpn-112-148.rdu2.redhat.com [10.10.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A73685D9CC;
        Sat,  5 Dec 2020 01:32:38 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Mike Rapoport Baoquan He <"rppt@kernel.orgbhe"@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] mm: initialize struct pages in reserved regions outside of the zone ranges
Date:   Fri,  4 Dec 2020 20:32:37 -0500
Message-Id: <20201205013238.21663-1-aarcange@redhat.com>
In-Reply-To: <20201201181502.2340-1-rppt@kernel.org>
References: <20201201181502.2340-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running with these patch applied on all instances as solution to
the compaction crashes that started to trigger after the v5.9
upgrade. It's applied on top of
https://lore.kernel.org/lkml/20201201181502.2340-1-rppt@kernel.org so
that it boots and works fine even when there are memblock.reserved
regions that don't overlap with the memblock.memory (as pfn 0 which is
in memblock.reserved but not added to memblock.memory).

To facilitate any testing:
https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git

===
# grep -A1  -i e820  /proc/iomem
39619000-397f4fff : Unknown E820 type
397f5000-3be55fff : System RAM

DMA      zone_start_pfn 0            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0     
Normal   zone_start_pfn 1048576      zone_end_pfn() 4909056      contiguous 1     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

235508 0x397f4000 0x4000000000001000 reserved True pfn_valid True
235509 0x397f5000 0x4000000000000000 reserved False pfn_valid True
===
# grep -A1  -i e820  /proc/iomem 
7a17b000-7a216fff : Unknown E820 type
7a217000-7bffffff : System RAM

DMA      zone_start_pfn 0            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguous 0     
Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguous 1     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

500246 0x7a216000 0x3fff000000001000 reserved True pfn_valid True
500247 0x7a217000 0x3fff000000000000 reserved False pfn_valid True
===

I dislike the fix for pfn 0 merged in -mm so that it will still boot
with DEBUG_VM=y, posted in
https://lkml.kernel.org/r/20201203105107.GR123287@linux.ibm.com,
because in addition of looping every 2m from the start at every
memblock for every zone in a O(N*2) way, it'll keep assigning a
"wrong" zoneid to pfn 0 and it literally reintroduces the problem that
https://lore.kernel.org/lkml/20201201181502.2340-1-rppt@kernel.org was
meant to solve.

This patch implements a more significant change since it alters the
zone boundaries.

If there's any problem with extending the zone spans to include
memblock.reserved regions it'd be good to know now, because if there's
no problem with that, I only see benefits in being able to guarantee a
proper zoneid and nid of all struct page that are in reserved
memblocks too and where reserve_bootmem_region will attempt to call
__SetPageReserved later expecting to deal with a "functional" page
structure.

An alternative to this patch, which still sounds preferable than
https://lkml.kernel.org/r/20201203105107.GR123287@linux.ibm.com, is to
just teach reserve_bootmem_region not try to set PageReserved on
uninitialized PagePoison pages and to learn how to deal with "non
functional" page structures, and to just leave them alone. PagePoison
conceptually would act as a NO_ZONEID setting in such case and
orthogonal with all the rest, it'd be nice if it was set also with
DEBUG_VM=n.

Overall anything looks preferable than once again assigning a wrong
zoneid to a page struct that belongs to a pfn that is not part of the
zone in order to boot with the very fix that was meant to prevent such
invariant to be broken in the first place.

I don't think pfn 0 deserves a magic exception and a pass to break the
invariant (even ignoring it may happen that the first pfn in nid > 0
might then also get the pass).

Andrea Arcangeli (1):
  mm: initialize struct pages in reserved regions outside of the zone
    ranges

 include/linux/memblock.h | 17 +++++++++---
 mm/debug.c               |  3 ++-
 mm/memblock.c            |  4 +--
 mm/page_alloc.c          | 57 ++++++++++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 18 deletions(-)


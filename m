Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB4723C030
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 21:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHDTmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 15:42:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23467 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728038AbgHDTmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596570119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pa4qNJzeWyr5swO/Fgzdcp9uwaMLEtjwjzZ0NY9JDmI=;
        b=ODGNBQm6tSnRGF5AyQBrCH4APBByAWq+T313miDu9An/rcyjBdJEOBillqbTkgL9FNsz+/
        oW2chYN03dQq+wdueuRDJdwkmpuF2HPnK+4cS1UcBTJIPzCuFYPnEtdVlnmJN4KMnNgSLV
        rqrxumnPwVKWB6B2917j5fQ/nn7FL+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-6RGpfs2yNAmXmZGGCCkU8g-1; Tue, 04 Aug 2020 15:41:56 -0400
X-MC-Unique: 6RGpfs2yNAmXmZGGCCkU8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F94B1DE1;
        Tue,  4 Aug 2020 19:41:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB10D88D71;
        Tue,  4 Aug 2020 19:41:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v4 0/6] mm / virtio-mem: support ZONE_MOVABLE
Date:   Tue,  4 Aug 2020 21:41:36 +0200
Message-Id: <20200804194142.28279-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andrew can we give this a churn and consider it for v5.9 in case there
are no more comments?

Patch #1-#4,#6 have RBss or ACKs, patch #5 is virtio-mem stuff maintained
by me (and MST is aware).

---

When introducing virtio-mem, the semantics of ZONE_MOVABLE were rather
unclear, which is why we special-cased ZONE_MOVABLE such that partially
plugged blocks would never end up in ZONE_MOVABLE.

Now that the semantics are much clearer (and are documented in patch #6),
let's support partially plugged memory blocks in ZONE_MOVABLE, allowing
partially plugged memory blocks to be online to ZONE_MOVABLE and also
unplugging from such memory blocks. This avoids surprises when onlining
of memory blocks suddenly fails, just because they are not completely
populated by virtio-mem (yet).

This is especially helpful for testing, but also paves the way for
virtio-mem optimizations, allowing more memory to get reliably unplugged.

Cleanup has_unmovable_pages() and set_migratetype_isolate(), providing
better documentation of how ZONE_MOVABLE interacts with different kind of
unmovable pages (memory offlining vs. alloc_contig_range()).

v3 -> v4:
- "mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()"
-- Fix typo in description
- "virtio-mem: don't special-case ZONE_MOVABLE"
-- Add more details why we initialli special-cased ZONE_MOVABLE (via MST)
- "mm: document semantics of ZONE_MOVABLE"
-- Rephrase some parts of documentation (via Mike)

v2 -> v3:
- "mm: document semantics of ZONE_MOVABLE"
-- Fix a typo

v1 -> v2:
- "mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()"
-- Move to position 1, add Fixes: tag
-- Drop unused "out:" label
- "mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()"
-- Keep curly braces on "else" case
- Replace "[PATCH v1 5/6] mm/page_alloc: restrict ZONE_MOVABLE optimization
           in has_unmovable_pages() to memory offlining"
  by "mm: document semantics of ZONE_MOVABLE"
-- Brain dump of what I know about ZONE_MOVABLE

David Hildenbrand (6):
  mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()
  mm/page_alloc: tweak comments in has_unmovable_pages()
  mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
  mm/page_isolation: cleanup set_migratetype_isolate()
  virtio-mem: don't special-case ZONE_MOVABLE
  mm: document semantics of ZONE_MOVABLE

 drivers/virtio/virtio_mem.c | 47 +++++++------------------------------
 include/linux/mmzone.h      | 35 +++++++++++++++++++++++++++
 mm/page_alloc.c             | 22 +++++------------
 mm/page_isolation.c         | 39 ++++++++++++++----------------
 4 files changed, 66 insertions(+), 77 deletions(-)

-- 
2.26.2


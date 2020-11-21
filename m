Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CB2BC1CF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgKUTpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbgKUTpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605987916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5TSZdv1C1Sf5BmSqrheKQjbY5+AL7XHbY+4WinPvY4=;
        b=Cq71/uc0oeosvXn832+F+vjzgoQfNpcddywNYdRYlpYHanvPwVvZcz4bC9ZagDm6v5IM07
        0JwnqVy1J7QJvpT8oTbPoJjxiD3/3OmQQSZ1YXMmZeacKSbjuHFd6HdGB6XQfHdi7+0KrM
        46ewE/0o+PbGw45pTxx1MVeB8djuoZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-kEKxEcHhPnmnd_I7XyZ39g-1; Sat, 21 Nov 2020 14:45:12 -0500
X-MC-Unique: kEKxEcHhPnmnd_I7XyZ39g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF92D184215F;
        Sat, 21 Nov 2020 19:45:10 +0000 (UTC)
Received: from mail (ovpn-112-35.rdu2.redhat.com [10.10.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2917A5D6BA;
        Sat, 21 Nov 2020 19:45:07 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set pageblock_skip on reserved pages
Date:   Sat, 21 Nov 2020 14:45:06 -0500
Message-Id: <20201121194506.13464-2-aarcange@redhat.com>
In-Reply-To: <20201121194506.13464-1-aarcange@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A corollary issue was fixed in
e577c8b64d58fe307ea4d5149d31615df2d90861. A second issue remained in
v5.7:

	https://lkml.kernel.org/r/8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw

==
page:ffffea0000aa0000 refcount:1 mapcount:0 mapping:000000002243743b index:0x0
flags: 0x1fffe000001000(reserved)
==

73a6e474cb376921a311786652782155eac2fdf0 was applied to supposedly the
second issue, but I still reproduced it twice with v5.9 on two
different systems:

==
page:0000000062b3e92f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x39800
flags: 0x1000(reserved)
==
page:000000002a7114f8 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a200
flags: 0x1fff000000001000(reserved)
==

I actually never reproduced it until v5.9, but it's still the same bug
as it was reported first for v5.7.

See the page is "reserved" in all 3 cases. In the last two crashes
with the pfn:

pfn 0x39800 -> 0x39800000 min_pfn hit non-RAM:

39639000-39814fff : Unknown E820 type

pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:

7a17b000-7a216fff : Unknown E820 type

This actually seems a false positive bugcheck, the page structures are
valid and the zones are correct, just it's non-RAM but setting
pageblockskip should do no harm. However it's possible to solve the
crash without lifting the bugcheck, by enforcing the invariant that
the free_pfn cursor doesn't point to reserved pages (which would be
otherwise implicitly achieved through the PageBuddy check, except in
the new fast_isolate_around() path).

Fixes: 5a811889de10 ("mm, compaction: use free lists to quickly locate a migration target")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/compaction.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 13cb7a961b31..d17e69549d34 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1433,7 +1433,10 @@ fast_isolate_freepages(struct compact_control *cc)
 					page = pageblock_pfn_to_page(min_pfn,
 						pageblock_end_pfn(min_pfn),
 						cc->zone);
-					cc->free_pfn = min_pfn;
+					if (likely(!PageReserved(page)))
+						cc->free_pfn = min_pfn;
+					else
+						page = NULL;
 				}
 			}
 		}


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B7302115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAYE0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbhAYE0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611548705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=NJKeXKo9ji3apRDxYLUo7qLmSQ5zOKD0xOisj0yxalw=;
        b=CSesqzHSUXt/F83R4boUPnPSOP6IfmfoAJmXto+aJV2BUCRVG3t/bePQUhLNSL9LrMJuuo
        9Aok05MsZos1u80zYVgu8D+peOParnWZod6C6zGU1VHD/Ei6i+DqzwMBb8Vz3aK7abV/IX
        QoV6b8yH3Ir7SWRjbBzkRqGJ2u+N8pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-7ZWhumgUMNSQpoqC2w29-A-1; Sun, 24 Jan 2021 23:25:01 -0500
X-MC-Unique: 7ZWhumgUMNSQpoqC2w29-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDA54180A095;
        Mon, 25 Jan 2021 04:24:59 +0000 (UTC)
Received: from llong.com (ovpn-112-78.rdu2.redhat.com [10.10.112.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0280D6A253;
        Mon, 25 Jan 2021 04:24:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to __add_to_page_cache_locked()
Date:   Sun, 24 Jan 2021 23:24:41 -0500
Message-Id: <20210125042441.20030-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3fea5a499d57 ("mm: memcontrol: convert page
cache to a new mem_cgroup_charge() API") introduced a bug in
__add_to_page_cache_locked() causing the following splat:

 [ 1570.068330] page dumped because: VM_BUG_ON_PAGE(page_memcg(page))
 [ 1570.068333] pages's memcg:ffff8889a4116000
 [ 1570.068343] ------------[ cut here ]------------
 [ 1570.068346] kernel BUG at mm/memcontrol.c:2924!
 [ 1570.068355] invalid opcode: 0000 [#1] SMP KASAN PTI
 [ 1570.068359] CPU: 35 PID: 12345 Comm: cat Tainted: G S      W I       5.11.0-rc4-debug+ #1
 [ 1570.068363] Hardware name: HP HP Z8 G4 Workstation/81C7, BIOS P60 v01.25 12/06/2017
 [ 1570.068365] RIP: 0010:commit_charge+0xf4/0x130
   :
 [ 1570.068375] RSP: 0018:ffff8881b38d70e8 EFLAGS: 00010286
 [ 1570.068379] RAX: 0000000000000000 RBX: ffffea00260ddd00 RCX: 0000000000000027
 [ 1570.068382] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88907ebe05a8
 [ 1570.068384] RBP: ffffea00260ddd00 R08: ffffed120fd7c0b6 R09: ffffed120fd7c0b6
 [ 1570.068386] R10: ffff88907ebe05ab R11: ffffed120fd7c0b5 R12: ffffea00260ddd38
 [ 1570.068389] R13: ffff8889a4116000 R14: ffff8889a4116000 R15: 0000000000000001
 [ 1570.068391] FS:  00007ff039638680(0000) GS:ffff88907ea00000(0000) knlGS:0000000000000000
 [ 1570.068394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [ 1570.068396] CR2: 00007f36f354cc20 CR3: 00000008a0126006 CR4: 00000000007706e0
 [ 1570.068398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [ 1570.068400] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [ 1570.068402] PKRU: 55555554
 [ 1570.068404] Call Trace:
 [ 1570.068407]  mem_cgroup_charge+0x175/0x770
 [ 1570.068413]  __add_to_page_cache_locked+0x712/0xad0
 [ 1570.068439]  add_to_page_cache_lru+0xc5/0x1f0
 [ 1570.068461]  cachefiles_read_or_alloc_pages+0x895/0x2e10 [cachefiles]
 [ 1570.068524]  __fscache_read_or_alloc_pages+0x6c0/0xa00 [fscache]
 [ 1570.068540]  __nfs_readpages_from_fscache+0x16d/0x630 [nfs]
 [ 1570.068585]  nfs_readpages+0x24e/0x540 [nfs]
 [ 1570.068693]  read_pages+0x5b1/0xc40
 [ 1570.068711]  page_cache_ra_unbounded+0x460/0x750
 [ 1570.068729]  generic_file_buffered_read_get_pages+0x290/0x1710
 [ 1570.068756]  generic_file_buffered_read+0x2a9/0xc30
 [ 1570.068832]  nfs_file_read+0x13f/0x230 [nfs]
 [ 1570.068872]  new_sync_read+0x3af/0x610
 [ 1570.068901]  vfs_read+0x339/0x4b0
 [ 1570.068909]  ksys_read+0xf1/0x1c0
 [ 1570.068920]  do_syscall_64+0x33/0x40
 [ 1570.068926]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 [ 1570.068930] RIP: 0033:0x7ff039135595

Before that commit, there was a try_charge() and commit_charge()
in __add_to_page_cache_locked(). These 2 separated charge functions
were replaced by a single mem_cgroup_charge(). However, it forgot
to add a matching mem_cgroup_uncharge() when the xarray insertion
failed with the page released back to the pool. Fix this by adding a
mem_cgroup_uncharge() call when insertion error happens.

Fixes: 3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/filemap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5c9d564317a5..aa0e0fb04670 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -835,6 +835,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	XA_STATE(xas, &mapping->i_pages, offset);
 	int huge = PageHuge(page);
 	int error;
+	bool charged = false;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
@@ -848,6 +849,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 		error = mem_cgroup_charge(page, current->mm, gfp);
 		if (error)
 			goto error;
+		charged = true;
 	}
 
 	gfp &= GFP_RECLAIM_MASK;
@@ -896,6 +898,8 @@ noinline int __add_to_page_cache_locked(struct page *page,
 
 	if (xas_error(&xas)) {
 		error = xas_error(&xas);
+		if (charged)
+			mem_cgroup_uncharge(page);
 		goto error;
 	}
 
-- 
2.18.1


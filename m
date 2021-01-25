Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40226302774
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbhAYQGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:06:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:46024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbhAYQEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:04:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611590609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+6bodJQRo+iWbKOZEafqjsVuHw++l+fPGEUt0hmR5YI=;
        b=uujkUUWahilWoJuSxLXnVRqbS84mq9YrarM3h3tiF0McP85a5RlohrCtE8TUilgpKKay2E
        t0W9Htgq1f2VQrHxHnNCYy4clgm4bn1+q+l8nbo6OdCo0LNoCnETi8kFQkxTJq07T+7hA9
        GHcHX/VwIGSQ2EEgAD5eaPl+VSmu2ms=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B5C8ACFB;
        Mon, 25 Jan 2021 16:03:29 +0000 (UTC)
Date:   Mon, 25 Jan 2021 17:03:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
Message-ID: <20210125160328.GP827@dhcp22.suse.cz>
References: <20210125042441.20030-1-longman@redhat.com>
 <20210125092815.GB827@dhcp22.suse.cz>
 <de87d009-985a-87d3-08fb-c688e23d60a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de87d009-985a-87d3-08fb-c688e23d60a9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-01-21 10:57:54, Waiman Long wrote:
> On 1/25/21 4:28 AM, Michal Hocko wrote:
> > On Sun 24-01-21 23:24:41, Waiman Long wrote:
> > > The commit 3fea5a499d57 ("mm: memcontrol: convert page
> > > cache to a new mem_cgroup_charge() API") introduced a bug in
> > > __add_to_page_cache_locked() causing the following splat:
> > > 
> > >   [ 1570.068330] page dumped because: VM_BUG_ON_PAGE(page_memcg(page))
> > >   [ 1570.068333] pages's memcg:ffff8889a4116000
> > >   [ 1570.068343] ------------[ cut here ]------------
> > >   [ 1570.068346] kernel BUG at mm/memcontrol.c:2924!
> > >   [ 1570.068355] invalid opcode: 0000 [#1] SMP KASAN PTI
> > >   [ 1570.068359] CPU: 35 PID: 12345 Comm: cat Tainted: G S      W I       5.11.0-rc4-debug+ #1
> > >   [ 1570.068363] Hardware name: HP HP Z8 G4 Workstation/81C7, BIOS P60 v01.25 12/06/2017
> > >   [ 1570.068365] RIP: 0010:commit_charge+0xf4/0x130
> > >     :
> > >   [ 1570.068375] RSP: 0018:ffff8881b38d70e8 EFLAGS: 00010286
> > >   [ 1570.068379] RAX: 0000000000000000 RBX: ffffea00260ddd00 RCX: 0000000000000027
> > >   [ 1570.068382] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88907ebe05a8
> > >   [ 1570.068384] RBP: ffffea00260ddd00 R08: ffffed120fd7c0b6 R09: ffffed120fd7c0b6
> > >   [ 1570.068386] R10: ffff88907ebe05ab R11: ffffed120fd7c0b5 R12: ffffea00260ddd38
> > >   [ 1570.068389] R13: ffff8889a4116000 R14: ffff8889a4116000 R15: 0000000000000001
> > >   [ 1570.068391] FS:  00007ff039638680(0000) GS:ffff88907ea00000(0000) knlGS:0000000000000000
> > >   [ 1570.068394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >   [ 1570.068396] CR2: 00007f36f354cc20 CR3: 00000008a0126006 CR4: 00000000007706e0
> > >   [ 1570.068398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >   [ 1570.068400] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >   [ 1570.068402] PKRU: 55555554
> > >   [ 1570.068404] Call Trace:
> > >   [ 1570.068407]  mem_cgroup_charge+0x175/0x770
> > >   [ 1570.068413]  __add_to_page_cache_locked+0x712/0xad0
> > >   [ 1570.068439]  add_to_page_cache_lru+0xc5/0x1f0
> > >   [ 1570.068461]  cachefiles_read_or_alloc_pages+0x895/0x2e10 [cachefiles]
> > >   [ 1570.068524]  __fscache_read_or_alloc_pages+0x6c0/0xa00 [fscache]
> > >   [ 1570.068540]  __nfs_readpages_from_fscache+0x16d/0x630 [nfs]
> > >   [ 1570.068585]  nfs_readpages+0x24e/0x540 [nfs]
> > >   [ 1570.068693]  read_pages+0x5b1/0xc40
> > >   [ 1570.068711]  page_cache_ra_unbounded+0x460/0x750
> > >   [ 1570.068729]  generic_file_buffered_read_get_pages+0x290/0x1710
> > >   [ 1570.068756]  generic_file_buffered_read+0x2a9/0xc30
> > >   [ 1570.068832]  nfs_file_read+0x13f/0x230 [nfs]
> > >   [ 1570.068872]  new_sync_read+0x3af/0x610
> > >   [ 1570.068901]  vfs_read+0x339/0x4b0
> > >   [ 1570.068909]  ksys_read+0xf1/0x1c0
> > >   [ 1570.068920]  do_syscall_64+0x33/0x40
> > >   [ 1570.068926]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >   [ 1570.068930] RIP: 0033:0x7ff039135595
> > > 
> > > Before that commit, there was a try_charge() and commit_charge()
> > > in __add_to_page_cache_locked(). These 2 separated charge functions
> > > were replaced by a single mem_cgroup_charge(). However, it forgot
> > > to add a matching mem_cgroup_uncharge() when the xarray insertion
> > > failed with the page released back to the pool. Fix this by adding a
> > > mem_cgroup_uncharge() call when insertion error happens.
> > > 
> > > Fixes: 3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > OK, this is indeed a subtle bug. The patch aimed at simplifying the
> > charge lifetime so that users do not really have to think about when to
> > uncharge as that happens when the page is freed. fscache somehow breaks
> > that assumption because it doesn't free up pages but it keeps some of
> > them in the cache.
> > 
> > I have tried to wrap my head around the cached object life time in
> > fscache but failed and got lost in the maze. Is this the only instance
> > of the problem? Would it make more sense to explicitly handle charges in
> > the fscache code or there are other potential users to fall into this
> > trap?
> 
> There may be other places that have similar problem. I focus on the
> filemap.c case as I have a test case that can reliably produce the bug
> splat. This patch does fix it for my test case.

I believe this needs a more general fix than catching a random places
which you can trigger. Would it make more sense to address this at the
fscache level and always make sure that a page returned to the pool is
always uncharged instead?
-- 
Michal Hocko
SUSE Labs

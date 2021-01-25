Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5B303992
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 10:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391655AbhAZJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 04:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731244AbhAYSxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:53:15 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:52:34 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id n3so3159620qvf.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j3Xw/oUQa+S/aBSbggXK87Od8rLNAanZ/b3oUBXYjEc=;
        b=e7cR0ZkUc3Squxu4N7tsIG9B42FgOGrFNiImW0dWiyrg4zUJwTidbZpK7W1xVvuWaf
         8NKPqVsud++RW0sBib73ddkSGhobD087cDBYGuf5QhJ/xlNqq+rrPkJ0SWngm6FJobkh
         VeLEzapz9YCa/4UUQkV69cotn7GPF9O3MhrJubQ1M+AqJdFN3jT5Yn5x4hrOXpZcJavJ
         8veR72HThrqFdVoZg6jkt7sfbDqtqjczpjkn5MdD6M8AvctDpQ9PYGAKja8s0EuiWQJZ
         04ieqY8h9fLKRAZslQd4fBz3oZ4cSu6wnANCxjBvkzpkLJpHFQyw4hZkkjvfUIENMpf9
         nvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j3Xw/oUQa+S/aBSbggXK87Od8rLNAanZ/b3oUBXYjEc=;
        b=F2h81dgfxYDykGYD5TR64snjIcuDbDWFZlcWMFzisY4AeFYcUkA4wHvZ7nISJ9eQwk
         eUvCDIzc9O5+0mERvkRJRSJSLxqnkMtI+c1suY4rGc5vSgujMHx+TkgPBZF+X6x6bmnK
         DGlf9XgjtZui2oaX4QX91t+2GFUvKZVNQrYeRkyY/ijoAuLpbl+ensEN/5kT3VOTK4S5
         hB8brVoPd7a6EPayQYA3g/9bqTfei6sE46eL88uXmvp3sNRHvTzok5FeVpNCpygbVO8C
         o9o6mS128e4mBQucXQaQLdOIEu0JvG56AP5ozcCdeIh4Afs40WOYrpkT8aSvU3gZI5o2
         BgSg==
X-Gm-Message-State: AOAM5336eXimgFXyIsfpoxLdYBa9v3jairpa8o48ja2Q9sHXGxG/pfHp
        GWoUPMKjAzcXXJzQdzaqE48cxQ==
X-Google-Smtp-Source: ABdhPJz61WKW7+3RRnYPymhLMqo8u5vUDYq80GJjjeVR0iW65AN/hvww8VxkZYxc+3aPrzkQemHA+w==
X-Received: by 2002:a0c:fa4c:: with SMTP id k12mr2118880qvo.16.1611600754187;
        Mon, 25 Jan 2021 10:52:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:f735])
        by smtp.gmail.com with ESMTPSA id c17sm12772425qkb.13.2021.01.25.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:52:33 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:52:32 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
Message-ID: <YA8TcICO1OpFwKsj@cmpxchg.org>
References: <20210125042441.20030-1-longman@redhat.com>
 <20210125092815.GB827@dhcp22.suse.cz>
 <de87d009-985a-87d3-08fb-c688e23d60a9@redhat.com>
 <20210125160328.GP827@dhcp22.suse.cz>
 <20210125162506.GF308988@casper.infradead.org>
 <20210125164118.GS827@dhcp22.suse.cz>
 <20210125181436.GV827@dhcp22.suse.cz>
 <53eb7692-e559-a914-e103-adfe951d7a7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53eb7692-e559-a914-e103-adfe951d7a7c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 01:23:58PM -0500, Waiman Long wrote:
> On 1/25/21 1:14 PM, Michal Hocko wrote:
> > On Mon 25-01-21 17:41:19, Michal Hocko wrote:
> > > On Mon 25-01-21 16:25:06, Matthew Wilcox wrote:
> > > > On Mon, Jan 25, 2021 at 05:03:28PM +0100, Michal Hocko wrote:
> > > > > On Mon 25-01-21 10:57:54, Waiman Long wrote:
> > > > > > On 1/25/21 4:28 AM, Michal Hocko wrote:
> > > > > > > On Sun 24-01-21 23:24:41, Waiman Long wrote:
> > > > > > > > The commit 3fea5a499d57 ("mm: memcontrol: convert page
> > > > > > > > cache to a new mem_cgroup_charge() API") introduced a bug in
> > > > > > > > __add_to_page_cache_locked() causing the following splat:
> > > > > > > > 
> > > > > > > >    [ 1570.068330] page dumped because: VM_BUG_ON_PAGE(page_memcg(page))
> > > > > > > >    [ 1570.068333] pages's memcg:ffff8889a4116000
> > > > > > > >    [ 1570.068343] ------------[ cut here ]------------
> > > > > > > >    [ 1570.068346] kernel BUG at mm/memcontrol.c:2924!
> > > > > > > >    [ 1570.068355] invalid opcode: 0000 [#1] SMP KASAN PTI
> > > > > > > >    [ 1570.068359] CPU: 35 PID: 12345 Comm: cat Tainted: G S      W I       5.11.0-rc4-debug+ #1
> > > > > > > >    [ 1570.068363] Hardware name: HP HP Z8 G4 Workstation/81C7, BIOS P60 v01.25 12/06/2017
> > > > > > > >    [ 1570.068365] RIP: 0010:commit_charge+0xf4/0x130
> > > > > > > >      :
> > > > > > > >    [ 1570.068375] RSP: 0018:ffff8881b38d70e8 EFLAGS: 00010286
> > > > > > > >    [ 1570.068379] RAX: 0000000000000000 RBX: ffffea00260ddd00 RCX: 0000000000000027
> > > > > > > >    [ 1570.068382] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88907ebe05a8
> > > > > > > >    [ 1570.068384] RBP: ffffea00260ddd00 R08: ffffed120fd7c0b6 R09: ffffed120fd7c0b6
> > > > > > > >    [ 1570.068386] R10: ffff88907ebe05ab R11: ffffed120fd7c0b5 R12: ffffea00260ddd38
> > > > > > > >    [ 1570.068389] R13: ffff8889a4116000 R14: ffff8889a4116000 R15: 0000000000000001
> > > > > > > >    [ 1570.068391] FS:  00007ff039638680(0000) GS:ffff88907ea00000(0000) knlGS:0000000000000000
> > > > > > > >    [ 1570.068394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > >    [ 1570.068396] CR2: 00007f36f354cc20 CR3: 00000008a0126006 CR4: 00000000007706e0
> > > > > > > >    [ 1570.068398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > > >    [ 1570.068400] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > > >    [ 1570.068402] PKRU: 55555554
> > > > > > > >    [ 1570.068404] Call Trace:
> > > > > > > >    [ 1570.068407]  mem_cgroup_charge+0x175/0x770
> > > > > > > >    [ 1570.068413]  __add_to_page_cache_locked+0x712/0xad0
> > > > > > > >    [ 1570.068439]  add_to_page_cache_lru+0xc5/0x1f0
> > > > > > > >    [ 1570.068461]  cachefiles_read_or_alloc_pages+0x895/0x2e10 [cachefiles]
> > > > > > > >    [ 1570.068524]  __fscache_read_or_alloc_pages+0x6c0/0xa00 [fscache]
> > > > > > > >    [ 1570.068540]  __nfs_readpages_from_fscache+0x16d/0x630 [nfs]
> > > > > > > >    [ 1570.068585]  nfs_readpages+0x24e/0x540 [nfs]
> > > > > > > >    [ 1570.068693]  read_pages+0x5b1/0xc40
> > > > > > > >    [ 1570.068711]  page_cache_ra_unbounded+0x460/0x750
> > > > > > > >    [ 1570.068729]  generic_file_buffered_read_get_pages+0x290/0x1710
> > > > > > > >    [ 1570.068756]  generic_file_buffered_read+0x2a9/0xc30
> > > > > > > >    [ 1570.068832]  nfs_file_read+0x13f/0x230 [nfs]
> > > > > > > >    [ 1570.068872]  new_sync_read+0x3af/0x610
> > > > > > > >    [ 1570.068901]  vfs_read+0x339/0x4b0
> > > > > > > >    [ 1570.068909]  ksys_read+0xf1/0x1c0
> > > > > > > >    [ 1570.068920]  do_syscall_64+0x33/0x40
> > > > > > > >    [ 1570.068926]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > > > > >    [ 1570.068930] RIP: 0033:0x7ff039135595
> > > > > > > > 
> > > > > > > > Before that commit, there was a try_charge() and commit_charge()
> > > > > > > > in __add_to_page_cache_locked(). These 2 separated charge functions
> > > > > > > > were replaced by a single mem_cgroup_charge(). However, it forgot
> > > > > > > > to add a matching mem_cgroup_uncharge() when the xarray insertion
> > > > > > > > failed with the page released back to the pool. Fix this by adding a
> > > > > > > > mem_cgroup_uncharge() call when insertion error happens.
> > > > > > > > 
> > > > > > > > Fixes: 3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
> > > > > > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > > > > > OK, this is indeed a subtle bug. The patch aimed at simplifying the
> > > > > > > charge lifetime so that users do not really have to think about when to
> > > > > > > uncharge as that happens when the page is freed. fscache somehow breaks
> > > > > > > that assumption because it doesn't free up pages but it keeps some of
> > > > > > > them in the cache.
> > > > > > > 
> > > > > > > I have tried to wrap my head around the cached object life time in
> > > > > > > fscache but failed and got lost in the maze. Is this the only instance
> > > > > > > of the problem? Would it make more sense to explicitly handle charges in
> > > > > > > the fscache code or there are other potential users to fall into this
> > > > > > > trap?
> > > > > > There may be other places that have similar problem. I focus on the
> > > > > > filemap.c case as I have a test case that can reliably produce the bug
> > > > > > splat. This patch does fix it for my test case.
> > > > > I believe this needs a more general fix than catching a random places
> > > > > which you can trigger. Would it make more sense to address this at the
> > > > > fscache level and always make sure that a page returned to the pool is
> > > > > always uncharged instead?
> > > > I believe you mean "page cache" -- there is a separate thing called
> > > > 'fscache' which is used to cache network filesystems.
> > > Yes, I really had fscache in mind because it does have an "unusual" page
> > > life time rules.
> > > 
> > > > I don't understand the memcg code at all, so I have no useful feedback
> > > > on what you're saying other than this.
> > > Well the memcg accounting rules after the rework should have simplified
> > > the API usage for most users. You will get memory charged when it is
> > > used and it will go away when the page is freed. If a page is not really
> > > freed in some cases and it can be reused then it doesn't really fit into
> > > this scheme automagically. I do undestand that this puts some additional
> > > burden on those special cases. I am not really sure what is the right
> > > way here myself but considering there might be other similar cases like
> > > that I would lean towards special casing where the pool is implemented.
> > > I would expect there is some state to be maintain for that purpose
> > > already.
> > After some more thinking I've came to conclusion that the patch as
> > proposed is the proper way forward. It is easier to follow if the
> > unwinding of state changes are local to the function.
> I think so. It is easier to understand if the charge and uncharge functions
> are grouped together in the same function.
> > 
> > With the proposed simplification by Willy
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thank for the ack. However, I am a bit confused about what you mean by
> simplification. There is another linux-next patch that changes the condition
> for mem_cgroup_charge() to
> 
> -       if (!huge) {
> +       if (!huge && !page_is_secretmem(page)) {
>                 error = mem_cgroup_charge(page, current->mm, gfp);
> 
> That is the main reason why I introduced the boolean variable as I don't
> want to call the external page_is_secretmem() function twice.

The variable works for me.

On the other hand, as Michal points out, the uncharge function will be
called again on the page when it's being freed (in non-fscache cases),
so you're already relying on being able to call it on any page -
charged, uncharged, never charged. It would be fine to call it
unconditionally in the error path. Aesthetic preference, I guess.

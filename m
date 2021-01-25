Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E03038B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 10:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbhAZJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 04:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730567AbhAYSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611600335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlaIkfhXcJ/uPtIW2l6YlE/lolJADayHnVq6CqXK13Q=;
        b=NGTQTAJ3U7Jp8X90TcICUbv3dr64J76CFoZONQD0x6Z1UPN36IFFOehi/ME6P6XqTssxvg
        bvliu+Rr3sWg7QsULZR9eZDhk4vuPmFp9lvjZ30BX9BhT0QB6yLXRv4Z8k2/8GpTHIRfsE
        NXrydPvjELDiPh+9QoDupBBxRcN8LYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558--B4cMj3EMr6o6v5hUXZuFA-1; Mon, 25 Jan 2021 13:45:31 -0500
X-MC-Unique: -B4cMj3EMr6o6v5hUXZuFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E320107ACE3;
        Mon, 25 Jan 2021 18:45:30 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-163.rdu2.redhat.com [10.10.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A42B36F973;
        Mon, 25 Jan 2021 18:45:28 +0000 (UTC)
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210125042441.20030-1-longman@redhat.com>
 <20210125092815.GB827@dhcp22.suse.cz>
 <de87d009-985a-87d3-08fb-c688e23d60a9@redhat.com>
 <20210125160328.GP827@dhcp22.suse.cz>
 <20210125162506.GF308988@casper.infradead.org>
 <20210125164118.GS827@dhcp22.suse.cz> <20210125181436.GV827@dhcp22.suse.cz>
 <53eb7692-e559-a914-e103-adfe951d7a7c@redhat.com>
 <20210125182921.GG308988@casper.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <58a0a706-4320-1297-7763-68532e721e04@redhat.com>
Date:   Mon, 25 Jan 2021 13:45:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210125182921.GG308988@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 1:29 PM, Matthew Wilcox wrote:
> On Mon, Jan 25, 2021 at 01:23:58PM -0500, Waiman Long wrote:
>> On 1/25/21 1:14 PM, Michal Hocko wrote:
>>> On Mon 25-01-21 17:41:19, Michal Hocko wrote:
>>>> On Mon 25-01-21 16:25:06, Matthew Wilcox wrote:
>>>>> On Mon, Jan 25, 2021 at 05:03:28PM +0100, Michal Hocko wrote:
>>>>>> On Mon 25-01-21 10:57:54, Waiman Long wrote:
>>>>>>> On 1/25/21 4:28 AM, Michal Hocko wrote:
>>>>>>>> On Sun 24-01-21 23:24:41, Waiman Long wrote:
>>>>>>>>> The commit 3fea5a499d57 ("mm: memcontrol: convert page
>>>>>>>>> cache to a new mem_cgroup_charge() API") introduced a bug in
>>>>>>>>> __add_to_page_cache_locked() causing the following splat:
>>>>>>>>>
>>>>>>>>>     [ 1570.068330] page dumped because: VM_BUG_ON_PAGE(page_memcg(page))
>>>>>>>>>     [ 1570.068333] pages's memcg:ffff8889a4116000
>>>>>>>>>     [ 1570.068343] ------------[ cut here ]------------
>>>>>>>>>     [ 1570.068346] kernel BUG at mm/memcontrol.c:2924!
>>>>>>>>>     [ 1570.068355] invalid opcode: 0000 [#1] SMP KASAN PTI
>>>>>>>>>     [ 1570.068359] CPU: 35 PID: 12345 Comm: cat Tainted: G S      W I       5.11.0-rc4-debug+ #1
>>>>>>>>>     [ 1570.068363] Hardware name: HP HP Z8 G4 Workstation/81C7, BIOS P60 v01.25 12/06/2017
>>>>>>>>>     [ 1570.068365] RIP: 0010:commit_charge+0xf4/0x130
>>>>>>>>>       :
>>>>>>>>>     [ 1570.068375] RSP: 0018:ffff8881b38d70e8 EFLAGS: 00010286
>>>>>>>>>     [ 1570.068379] RAX: 0000000000000000 RBX: ffffea00260ddd00 RCX: 0000000000000027
>>>>>>>>>     [ 1570.068382] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88907ebe05a8
>>>>>>>>>     [ 1570.068384] RBP: ffffea00260ddd00 R08: ffffed120fd7c0b6 R09: ffffed120fd7c0b6
>>>>>>>>>     [ 1570.068386] R10: ffff88907ebe05ab R11: ffffed120fd7c0b5 R12: ffffea00260ddd38
>>>>>>>>>     [ 1570.068389] R13: ffff8889a4116000 R14: ffff8889a4116000 R15: 0000000000000001
>>>>>>>>>     [ 1570.068391] FS:  00007ff039638680(0000) GS:ffff88907ea00000(0000) knlGS:0000000000000000
>>>>>>>>>     [ 1570.068394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>>>>     [ 1570.068396] CR2: 00007f36f354cc20 CR3: 00000008a0126006 CR4: 00000000007706e0
>>>>>>>>>     [ 1570.068398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>>>>>     [ 1570.068400] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>>>>>>     [ 1570.068402] PKRU: 55555554
>>>>>>>>>     [ 1570.068404] Call Trace:
>>>>>>>>>     [ 1570.068407]  mem_cgroup_charge+0x175/0x770
>>>>>>>>>     [ 1570.068413]  __add_to_page_cache_locked+0x712/0xad0
>>>>>>>>>     [ 1570.068439]  add_to_page_cache_lru+0xc5/0x1f0
>>>>>>>>>     [ 1570.068461]  cachefiles_read_or_alloc_pages+0x895/0x2e10 [cachefiles]
>>>>>>>>>     [ 1570.068524]  __fscache_read_or_alloc_pages+0x6c0/0xa00 [fscache]
>>>>>>>>>     [ 1570.068540]  __nfs_readpages_from_fscache+0x16d/0x630 [nfs]
>>>>>>>>>     [ 1570.068585]  nfs_readpages+0x24e/0x540 [nfs]
>>>>>>>>>     [ 1570.068693]  read_pages+0x5b1/0xc40
>>>>>>>>>     [ 1570.068711]  page_cache_ra_unbounded+0x460/0x750
>>>>>>>>>     [ 1570.068729]  generic_file_buffered_read_get_pages+0x290/0x1710
>>>>>>>>>     [ 1570.068756]  generic_file_buffered_read+0x2a9/0xc30
>>>>>>>>>     [ 1570.068832]  nfs_file_read+0x13f/0x230 [nfs]
>>>>>>>>>     [ 1570.068872]  new_sync_read+0x3af/0x610
>>>>>>>>>     [ 1570.068901]  vfs_read+0x339/0x4b0
>>>>>>>>>     [ 1570.068909]  ksys_read+0xf1/0x1c0
>>>>>>>>>     [ 1570.068920]  do_syscall_64+0x33/0x40
>>>>>>>>>     [ 1570.068926]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>>>>>     [ 1570.068930] RIP: 0033:0x7ff039135595
>>>>>>>>>
>>>>>>>>> Before that commit, there was a try_charge() and commit_charge()
>>>>>>>>> in __add_to_page_cache_locked(). These 2 separated charge functions
>>>>>>>>> were replaced by a single mem_cgroup_charge(). However, it forgot
>>>>>>>>> to add a matching mem_cgroup_uncharge() when the xarray insertion
>>>>>>>>> failed with the page released back to the pool. Fix this by adding a
>>>>>>>>> mem_cgroup_uncharge() call when insertion error happens.
>>>>>>>>>
>>>>>>>>> Fixes: 3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
>>>>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>>>> OK, this is indeed a subtle bug. The patch aimed at simplifying the
>>>>>>>> charge lifetime so that users do not really have to think about when to
>>>>>>>> uncharge as that happens when the page is freed. fscache somehow breaks
>>>>>>>> that assumption because it doesn't free up pages but it keeps some of
>>>>>>>> them in the cache.
>>>>>>>>
>>>>>>>> I have tried to wrap my head around the cached object life time in
>>>>>>>> fscache but failed and got lost in the maze. Is this the only instance
>>>>>>>> of the problem? Would it make more sense to explicitly handle charges in
>>>>>>>> the fscache code or there are other potential users to fall into this
>>>>>>>> trap?
>>>>>>> There may be other places that have similar problem. I focus on the
>>>>>>> filemap.c case as I have a test case that can reliably produce the bug
>>>>>>> splat. This patch does fix it for my test case.
>>>>>> I believe this needs a more general fix than catching a random places
>>>>>> which you can trigger. Would it make more sense to address this at the
>>>>>> fscache level and always make sure that a page returned to the pool is
>>>>>> always uncharged instead?
>>>>> I believe you mean "page cache" -- there is a separate thing called
>>>>> 'fscache' which is used to cache network filesystems.
>>>> Yes, I really had fscache in mind because it does have an "unusual" page
>>>> life time rules.
>>>>
>>>>> I don't understand the memcg code at all, so I have no useful feedback
>>>>> on what you're saying other than this.
>>>> Well the memcg accounting rules after the rework should have simplified
>>>> the API usage for most users. You will get memory charged when it is
>>>> used and it will go away when the page is freed. If a page is not really
>>>> freed in some cases and it can be reused then it doesn't really fit into
>>>> this scheme automagically. I do undestand that this puts some additional
>>>> burden on those special cases. I am not really sure what is the right
>>>> way here myself but considering there might be other similar cases like
>>>> that I would lean towards special casing where the pool is implemented.
>>>> I would expect there is some state to be maintain for that purpose
>>>> already.
>>> After some more thinking I've came to conclusion that the patch as
>>> proposed is the proper way forward. It is easier to follow if the
>>> unwinding of state changes are local to the function.
>> I think so. It is easier to understand if the charge and uncharge functions
>> are grouped together in the same function.
>>> With the proposed simplification by Willy
>>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Thank for the ack. However, I am a bit confused about what you mean by
>> simplification. There is another linux-next patch that changes the condition
>> for mem_cgroup_charge() to
>>
>> -       if (!huge) {
>> +       if (!huge && !page_is_secretmem(page)) {
>>                  error = mem_cgroup_charge(page, current->mm, gfp);
>>
>> That is the main reason why I introduced the boolean variable as I don't
>> want to call the external page_is_secretmem() function twice.
> See earlier emails to Mike suggesting that the accounting of secretmem
> here is wrong.
>
I am not in the secretmem discussion and so I am not aware of the issue 
with that patchset. Anyway, my goal is to minimize potential conflict 
with other patches.

Cheers,
Longman


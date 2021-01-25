Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1B30369E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbhAZGe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729255AbhAYOOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611583983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIynMtgnRqz+VkJaiVKyd+A9flrqqThOoONtrV6hF3o=;
        b=E5M474vPL4YVTA6est2JlqY8CVztf6KZ5FUWPL+I4WspQd3voZdajx4Xcn5aSxzXYfvSFF
        zjLlrV9c+k0oc++XdB2WaaM/WGrmK6z43LMkJ4MaeHu1LBEOk2tQ+8k7gF+SRnH3YWhgrX
        iwPDnX+5WYHBvie8nXpzjJNQY5fWIs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-jzWJGVMcOC29gBSl7bsUKw-1; Mon, 25 Jan 2021 09:12:59 -0500
X-MC-Unique: jzWJGVMcOC29gBSl7bsUKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 862261005513;
        Mon, 25 Jan 2021 14:12:57 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-163.rdu2.redhat.com [10.10.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A37711981B;
        Mon, 25 Jan 2021 14:12:56 +0000 (UTC)
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
References: <20210125042441.20030-1-longman@redhat.com>
 <3b3f2b56-e66a-db5e-8d8e-95f3812c6838@huawei.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4367cc87-1ebf-6df2-d2d4-939c548ca790@redhat.com>
Date:   Mon, 25 Jan 2021 09:12:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3b3f2b56-e66a-db5e-8d8e-95f3812c6838@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 1:30 AM, Miaohe Lin wrote:
> On 2021/1/25 12:24, Waiman Long wrote:
>> The commit 3fea5a499d57 ("mm: memcontrol: convert page
>> cache to a new mem_cgroup_charge() API") introduced a bug in
>> __add_to_page_cache_locked() causing the following splat:
>>
>>   [ 1570.068330] page dumped because: VM_BUG_ON_PAGE(page_memcg(page))
>>   [ 1570.068333] pages's memcg:ffff8889a4116000
>>   [ 1570.068343] ------------[ cut here ]------------
>>   [ 1570.068346] kernel BUG at mm/memcontrol.c:2924!
>>   [ 1570.068355] invalid opcode: 0000 [#1] SMP KASAN PTI
>>   [ 1570.068359] CPU: 35 PID: 12345 Comm: cat Tainted: G S      W I       5.11.0-rc4-debug+ #1
>>   [ 1570.068363] Hardware name: HP HP Z8 G4 Workstation/81C7, BIOS P60 v01.25 12/06/2017
>>   [ 1570.068365] RIP: 0010:commit_charge+0xf4/0x130
>>     :
>>   [ 1570.068375] RSP: 0018:ffff8881b38d70e8 EFLAGS: 00010286
>>   [ 1570.068379] RAX: 0000000000000000 RBX: ffffea00260ddd00 RCX: 0000000000000027
>>   [ 1570.068382] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88907ebe05a8
>>   [ 1570.068384] RBP: ffffea00260ddd00 R08: ffffed120fd7c0b6 R09: ffffed120fd7c0b6
>>   [ 1570.068386] R10: ffff88907ebe05ab R11: ffffed120fd7c0b5 R12: ffffea00260ddd38
>>   [ 1570.068389] R13: ffff8889a4116000 R14: ffff8889a4116000 R15: 0000000000000001
>>   [ 1570.068391] FS:  00007ff039638680(0000) GS:ffff88907ea00000(0000) knlGS:0000000000000000
>>   [ 1570.068394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [ 1570.068396] CR2: 00007f36f354cc20 CR3: 00000008a0126006 CR4: 00000000007706e0
>>   [ 1570.068398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   [ 1570.068400] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   [ 1570.068402] PKRU: 55555554
>>   [ 1570.068404] Call Trace:
>>   [ 1570.068407]  mem_cgroup_charge+0x175/0x770
>>   [ 1570.068413]  __add_to_page_cache_locked+0x712/0xad0
>>   [ 1570.068439]  add_to_page_cache_lru+0xc5/0x1f0
>>   [ 1570.068461]  cachefiles_read_or_alloc_pages+0x895/0x2e10 [cachefiles]
>>   [ 1570.068524]  __fscache_read_or_alloc_pages+0x6c0/0xa00 [fscache]
>>   [ 1570.068540]  __nfs_readpages_from_fscache+0x16d/0x630 [nfs]
>>   [ 1570.068585]  nfs_readpages+0x24e/0x540 [nfs]
>>   [ 1570.068693]  read_pages+0x5b1/0xc40
>>   [ 1570.068711]  page_cache_ra_unbounded+0x460/0x750
>>   [ 1570.068729]  generic_file_buffered_read_get_pages+0x290/0x1710
>>   [ 1570.068756]  generic_file_buffered_read+0x2a9/0xc30
>>   [ 1570.068832]  nfs_file_read+0x13f/0x230 [nfs]
>>   [ 1570.068872]  new_sync_read+0x3af/0x610
>>   [ 1570.068901]  vfs_read+0x339/0x4b0
>>   [ 1570.068909]  ksys_read+0xf1/0x1c0
>>   [ 1570.068920]  do_syscall_64+0x33/0x40
>>   [ 1570.068926]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   [ 1570.068930] RIP: 0033:0x7ff039135595
>>
>> Before that commit, there was a try_charge() and commit_charge()
>> in __add_to_page_cache_locked(). These 2 separated charge functions
>> were replaced by a single mem_cgroup_charge(). However, it forgot
>> to add a matching mem_cgroup_uncharge() when the xarray insertion
>> failed with the page released back to the pool. Fix this by adding a
>> mem_cgroup_uncharge() call when insertion error happens.
>>
>> Fixes: 3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Cc stable should be needed.

Yes, this patch should go to stable. I think the stable tree maintainers 
will automatically pick up patches with the "Fixes" tag. That is why I 
don't explicitly put a "cc:stable" line in the patch.

Thanks,
Longman


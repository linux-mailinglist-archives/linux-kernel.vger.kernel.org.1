Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E46293470
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 07:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391756AbgJTFwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 01:52:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391744AbgJTFwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 01:52:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE8A2AD7C;
        Tue, 20 Oct 2020 05:52:09 +0000 (UTC)
References: <87lfg2ob83.fsf@suse.de>
 <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Reply-To: rpalethorpe@suse.de
In-reply-to: <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
Date:   Tue, 20 Oct 2020 06:52:08 +0100
Message-ID: <87mu0hwik7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shakeel,

Shakeel Butt <shakeelb@google.com> writes:
>>
>> V3: Handle common case where use_hierarchy=1 and update description.
>>
>>  mm/memcontrol.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 6877c765b8d0..34b8c4a66853 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -291,7 +291,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>>
>>         spin_lock_irqsave(&css_set_lock, flags);
>>         memcg = obj_cgroup_memcg(objcg);
>> -       if (nr_pages)
>> +       if (nr_pages && (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy))
>
> If we have non-root memcg with use_hierarchy as 0 and this objcg was
> reparented then this __memcg_kmem_uncharge() can potentially underflow
> the page counter and give the same warning.

Yes, although the kernel considers such a config to be broken, and
prints a warning to the log, it does allow it.

>
> We never set root_mem_cgroup->objcg, so, no need to check for root

I don't think that is relevant as we get the memcg from objcg->memcg
which is set during reparenting. I suppose however, we can determine if
the objcg was reparented by inspecting memcg->objcg.

> here. I think checking just memcg->use_hierarchy should be sufficient.

If we just check use_hierarchy then objects directly charged to the
memcg where use_hierarchy=0 will not be uncharged. However, maybe it is
better to check if it was reparented and if use_hierarchy=0.

>
>>                 __memcg_kmem_uncharge(memcg, nr_pages);
>>         list_del(&objcg->list);
>>         mem_cgroup_put(memcg);
>> @@ -3100,6 +3100,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>>  static void drain_obj_stock(struct memcg_stock_pcp *stock)
>>  {
>>         struct obj_cgroup *old = stock->cached_objcg;
>> +       struct mem_cgroup *memcg;
>>
>>         if (!old)
>>                 return;
>> @@ -3110,7 +3111,9 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>>
>>                 if (nr_pages) {
>>                         rcu_read_lock();
>> -                       __memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
>> +                       memcg = obj_cgroup_memcg(old);
>> +                       if (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy)
>> +                               __memcg_kmem_uncharge(memcg, nr_pages);
>>                         rcu_read_unlock();
>>                 }
>>
>> --
>> 2.28.0
>>


-- 
Thank you,
Richard.

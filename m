Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC81AE013
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDQOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:41:00 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:44814 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbgDQOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:41:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=39;SR=0;TI=SMTPD_---0TvqIRjz_1587134450;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvqIRjz_1587134450)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Apr 2020 22:40:52 +0800
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
 <20200414163114.GA136578@cmpxchg.org>
 <54af0662-cbb4-88c7-7eae-f969684025dd@linux.alibaba.com>
 <0bed9f1a-400d-d9a9-aeb4-de1dd9ccbb45@linux.alibaba.com>
 <20200416152830.GA195132@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <2403add7-d468-7615-22c5-3fafb1264d54@linux.alibaba.com>
Date:   Fri, 17 Apr 2020 22:39:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416152830.GA195132@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/4/16 下午11:28, Johannes Weiner 写道:
> Hi Alex,
> 
> On Thu, Apr 16, 2020 at 04:01:20PM +0800, Alex Shi wrote:
>>
>>
>> 在 2020/4/15 下午9:42, Alex Shi 写道:
>>> Hi Johannes,
>>>
>>> Thanks a lot for point out!
>>>
>>> Charging in __read_swap_cache_async would ask for 3 layers function arguments
>>> pass, that would be a bit ugly. Compare to this, could we move out the
>>> lru_cache add after commit_charge, like ksm copied pages?
>>>
>>> That give a bit extra non lru list time, but the page just only be used only
>>> after add_anon_rmap setting. Could it cause troubles?
>>
>> Hi Johannes & Andrew,
>>
>> Doing lru_cache_add_anon during swapin_readahead can give a very short timing 
>> for possible page reclaiming for these few pages.
>>
>> If we delay these few pages lru adding till after the vm_fault target page 
>> get memcg charging(mem_cgroup_commit_charge) and activate, we could skip the 
>> mem_cgroup_try_charge/commit_charge/cancel_charge process in __read_swap_cache_async().
>> But the cost is maximum SWAP_RA_ORDER_CEILING number pages on each cpu miss
>> page reclaiming in a short time. On the other hand, save the target vm_fault
>> page from reclaiming before activate it during that time.
> 
> The readahead pages surrounding the faulting page might never get
> accessed and pile up to large amounts. Users can also trigger
> non-faulting readahead with MADV_WILLNEED.
> 
> So unfortunately, I don't see a way to keep these pages off the
> LRU. They do need to be reclaimable, or they become a DoS vector.
> 
> I'm currently preparing a small patch series to make swap ownership
> tracking an integral part of memcg and change the swapin charging
> sequence, then you don't have to worry about it. This will also
> unblock Joonsoo's "workingset protection/detection on the anonymous
> LRU list" patch series, since he is blocked on the same problem - he
> needs the correct LRU available at swapin time to process refaults
> correctly. Both of your patch series are already pretty large, they
> shouldn't need to also deal with that.
> 

That sounds great!
BTW, the swapin target page will add into inactive_anon list and then activate
after chaged. that left a minum time slot for this page to be reclaimed.
May better activate it early?

Also I have 2 clean up patches, which may or may not useful for you. will send
it to you. :)

Thanks
Alex

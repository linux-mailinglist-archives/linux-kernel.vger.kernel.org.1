Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA66290F81
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436591AbgJQFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:41:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2411653AbgJQFlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:41:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F35DD5519210D144968;
        Sat, 17 Oct 2020 09:55:49 +0800 (CST)
Received: from [10.174.177.6] (10.174.177.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 17 Oct 2020
 09:55:42 +0800
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
To:     <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>,
        <linfeilong@huawei.com>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
 <20201016123137.GH22589@dhcp22.suse.cz>
 <f99d9457ae88f3692e57cce86d0e22e8@suse.de>
 <20201016131112.GJ22589@dhcp22.suse.cz>
 <20201016131531.GK22589@dhcp22.suse.cz>
 <20201016134215.GL22589@dhcp22.suse.cz>
 <8b1e52b7a07b9ff1be9badb73209abda@suse.de>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <bc1ea882-9434-0009-0dc1-849954f80a3a@huawei.com>
Date:   Sat, 17 Oct 2020 09:55:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8b1e52b7a07b9ff1be9badb73209abda@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/16 22:05, osalvador@suse.de wrote:
> On 2020-10-16 15:42, Michal Hocko wrote:
>> OK, I finally managed to convince my friday brain to think and grasped
>> what the code is intended to do. The loop is hairy and we want to
>> prevent from spurious EIO when all the pages are on a proper node. So
>> the check has to be done inside the loop. Anyway I would find the
>> following fix less error prone and easier to follow
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index eddbe4e56c73..8cc1fc9c4d13 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -525,7 +525,7 @@ static int queue_pages_pte_range(pmd_t *pmd,
>> unsigned long addr,
>>      unsigned long flags = qp->flags;
>>      int ret;
>>      bool has_unmovable = false;
>> -    pte_t *pte;
>> +    pte_t *pte, *mapped_pte;
>>      spinlock_t *ptl;
>>
>>      ptl = pmd_trans_huge_lock(pmd, vma);
>> @@ -539,7 +539,7 @@ static int queue_pages_pte_range(pmd_t *pmd,
>> unsigned long addr,
>>      if (pmd_trans_unstable(pmd))
>>          return 0;
>>
>> -    pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>> +    mapped_pte = pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>>      for (; addr != end; pte++, addr += PAGE_SIZE) {
>>          if (!pte_present(*pte))
>>              continue;
>> @@ -571,7 +571,7 @@ static int queue_pages_pte_range(pmd_t *pmd,
>> unsigned long addr,
>>          } else
>>              break;
>>      }
>> -    pte_unmap_unlock(pte - 1, ptl);
>> +    pte_unmap_unlock(mapped_pte, ptl);
>>      cond_resched();
>>
>>      if (has_unmovable)
>
> It is more clear to grasp, definitely.
Yeah, this one is more comprehensible, I 'll send a v2 patch, thank you.

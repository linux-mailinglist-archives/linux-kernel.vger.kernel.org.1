Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688062F587F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbhANCfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:35:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10722 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbhANCfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:35:41 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DGSzm4Pmdzl4qj;
        Thu, 14 Jan 2021 10:33:40 +0800 (CST)
Received: from [10.174.176.197] (10.174.176.197) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 10:34:57 +0800
Subject: Re: [PATCH] mm/swap_slots.c: Remove unnecessary NULL pointer check
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210109080943.34832-1-linmiaohe@huawei.com>
 <20210109174016.GA35215@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <404e6c17-dd1f-84f9-86ca-8a39cbdbffd1@huawei.com>
Date:   Thu, 14 Jan 2021 10:34:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109174016.GA35215@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/10 1:40, Matthew Wilcox wrote:
> On Sat, Jan 09, 2021 at 03:09:43AM -0500, Miaohe Lin wrote:
>> The cache->slots and cache->slots_ret is already checked before we try to
>> drain it. And kvfree can handle the NULL pointer itself. So remove the
>> NULL pointer check here.
> 
>> @@ -178,7 +178,7 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
>>  		swapcache_free_entries(cache->slots + cache->cur, cache->nr);
>>  		cache->cur = 0;
>>  		cache->nr = 0;
>> -		if (free_slots && cache->slots) {
>> +		if (free_slots) {
> 
> Prove that swapcache_free_entries() doesn't change cache->slots.
> 

Yeh... I see. I thought swap_slots_cache_mutex could totally guard against this.

>> @@ -188,13 +188,12 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
>>  		spin_lock_irq(&cache->free_lock);
>>  		swapcache_free_entries(cache->slots_ret, cache->n_ret);
>>  		cache->n_ret = 0;
>> -		if (free_slots && cache->slots_ret) {
>> +		if (free_slots) {
> 
> ... or ->slots_ret
> 
>> -		if (slots)
>> -			kvfree(slots);
>> +		kvfree(slots);
> 
> This is fine.
> .
> 

Many thanks for your review and reply!

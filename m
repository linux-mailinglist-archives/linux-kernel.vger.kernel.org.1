Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13F2C5297
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgKZLFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:05:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:39538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgKZLFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:05:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DC73AC23;
        Thu, 26 Nov 2020 11:05:30 +0000 (UTC)
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <b92a1a50-b7cd-0b33-de2e-52d74c91925c@suse.cz>
 <df62191b-e694-1928-2ffc-c4cfb4dea14d@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a6d5613c-2fb7-15fe-a5cc-74e2453c3e21@suse.cz>
Date:   Thu, 26 Nov 2020 12:05:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <df62191b-e694-1928-2ffc-c4cfb4dea14d@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/20 4:12 AM, Alex Shi wrote:
> 
> 
> 在 2020/11/25 下午11:38, Vlastimil Babka 写道:
>> On 11/20/20 9:27 AM, Alex Shi wrote:
>>> The current relock logical will change lru_lock when found a new
>>> lruvec, so if 2 memcgs are reading file or alloc page at same time,
>>> they could hold the lru_lock alternately, and wait for each other for
>>> fairness attribute of ticket spin lock.
>>>
>>> This patch will sort that all lru_locks and only hold them once in
>>> above scenario. That could reduce fairness waiting for lock reget.
>>> Than, vm-scalability/case-lru-file-readtwice could get ~5% performance
>>> gain on my 2P*20core*HT machine.
>> 
>> Hm, once you sort the pages like this, it's a shame not to splice them instead of more list_del() + list_add() iterations. update_lru_size() could be also called once?
> 
> Yes, looks it's a good idea to use splice instead of list_del/add, but pages
> may on different lru list in a same lruvec, and also may come from different
> zones. That could involve 5 cycles for different lists, and more for zones...

Hmm, zones wouldn't affect splicing (there's a per-node lru these days), but 
would affect accounting. And yeah, there are 5 lru lists, and we probably need 
to be under lru lock to stabilize where a page belongs, so pre-sorting without 
lock wouldn't be safe? Bummer.

> I give up the try.
> 


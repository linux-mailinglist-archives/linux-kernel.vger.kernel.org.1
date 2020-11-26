Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7162B2C4DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbgKZDMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:12:43 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:8944 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732389AbgKZDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:12:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UGYkbqq_1606360350;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGYkbqq_1606360350)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 11:12:31 +0800
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <b92a1a50-b7cd-0b33-de2e-52d74c91925c@suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <df62191b-e694-1928-2ffc-c4cfb4dea14d@linux.alibaba.com>
Date:   Thu, 26 Nov 2020 11:12:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b92a1a50-b7cd-0b33-de2e-52d74c91925c@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/25 下午11:38, Vlastimil Babka 写道:
> On 11/20/20 9:27 AM, Alex Shi wrote:
>> The current relock logical will change lru_lock when found a new
>> lruvec, so if 2 memcgs are reading file or alloc page at same time,
>> they could hold the lru_lock alternately, and wait for each other for
>> fairness attribute of ticket spin lock.
>>
>> This patch will sort that all lru_locks and only hold them once in
>> above scenario. That could reduce fairness waiting for lock reget.
>> Than, vm-scalability/case-lru-file-readtwice could get ~5% performance
>> gain on my 2P*20core*HT machine.
> 
> Hm, once you sort the pages like this, it's a shame not to splice them instead of more list_del() + list_add() iterations. update_lru_size() could be also called once?

Yes, looks it's a good idea to use splice instead of list_del/add, but pages
may on different lru list in a same lruvec, and also may come from different
zones. That could involve 5 cycles for different lists, and more for zones...

I give up the try.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6172C5EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 04:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392312AbgK0DOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 22:14:53 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39752 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388682AbgK0DOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 22:14:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UGeo63._1606446889;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGeo63._1606446889)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 Nov 2020 11:14:50 +0800
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
To:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Yu Zhao <yuzhao@google.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201126045234.GA1014081@google.com>
 <ed19e3f7-33cb-20ae-537e-a7ada2036895@linux.alibaba.com>
 <20201126072402.GA1047005@google.com>
 <464fa387-9dfd-a8c7-3d86-040f26fd4115@suse.cz>
 <c3d53633-af28-79c1-f42c-d5b851af4d56@suse.cz>
 <20201126155553.GT4327@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <5f8300ea-2abc-5cee-d837-f20e535f19c2@linux.alibaba.com>
Date:   Fri, 27 Nov 2020 11:14:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201126155553.GT4327@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/26 ÏÂÎç11:55, Matthew Wilcox Ð´µÀ:
> On Thu, Nov 26, 2020 at 04:44:04PM +0100, Vlastimil Babka wrote:
>> However, Matthew wanted to increase pagevec size [1] and once 15^2 becomes
>> 63^2, it starts to be somewhat more worrying.
>>
>> [1] https://lore.kernel.org/linux-mm/20201105172651.2455-1-willy@infradead.org/
> 
> Well, Tim wanted it ;-)
> 
> I would suggest that rather than an insertion sort (or was it a bubble
> sort?), we should be using a Shell sort.  It's ideal for these kinds of
> smallish arrays.
> 
> https://en.wikipedia.org/wiki/Shellsort
> 

Uh, looks perfect good!. I gonna look into it. :)

Thanks!

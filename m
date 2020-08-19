Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88C2497FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgHSILR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 04:11:17 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37318 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgHSILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:11:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U6D2.Qz_1597824663;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6D2.Qz_1597824663)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Aug 2020 16:11:04 +0800
Subject: Re: [PATCH v2 2/2] mm/pageblock: remove false sharing in
 pageblock_flags
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597816075-61091-2-git-send-email-alex.shi@linux.alibaba.com>
 <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a7376a9c-82e8-7dc1-b656-9c0516738801@linux.alibaba.com>
Date:   Wed, 19 Aug 2020 16:09:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <715f1588-9cd5-b845-51a5-ca58549c4d28@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/19 下午3:57, Anshuman Khandual 写道:
> 
> 
> On 08/19/2020 11:17 AM, Alex Shi wrote:
>> Current pageblock_flags is only 4 bits, so it has to share a char size
>> in cmpxchg when get set, the false sharing cause perf drop.
>>
>> If we incrase the bits up to 8, false sharing would gone in cmpxchg. and
>> the only cost is half char per pageblock, which is half char per 128MB
>> on x86, 4 chars in 1 GB.
> 
> Agreed that increase in memory utilization is negligible here but does
> this really improve performance ?
> 

It's no doubt in theory. and it would had a bad impact according to 
commit e380bebe4771548  mm, compaction: keep migration source private to a single 

but I do have some problem in running thpscale/mmtest. I'd like to see if anyone
could give a try.

BTW, I naturally hate the false sharing even it's in theory. Anyone who doesn't? :)

Thanks
Alex 

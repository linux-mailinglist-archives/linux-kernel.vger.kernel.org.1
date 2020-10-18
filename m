Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8782291752
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 14:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgJRM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 08:27:45 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33361 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726525AbgJRM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 08:27:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UCMqSC1_1603024061;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCMqSC1_1603024061)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Oct 2020 20:27:42 +0800
Date:   Sun, 18 Oct 2020 20:27:41 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 05/29] virtio-mem: generalize check for added memory
Message-ID: <20201018122741.GB50506@L-31X9LVDL-1304>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201016223811.GJ44269@L-31X9LVDL-1304.local>
 <2E12AC3C-872A-4B30-8FD7-12420FA1D14E@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2E12AC3C-872A-4B30-8FD7-12420FA1D14E@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 09:39:38AM +0200, David Hildenbrand wrote:
>
>> Am 17.10.2020 um 00:38 schrieb Wei Yang <richard.weiyang@linux.alibaba.com>:
>> 
>> ﻿On Fri, Oct 16, 2020 at 12:32:50PM +0200, David Hildenbrand wrote:
>>>>>> Ok, I seems to understand the logic now.
>>>>>> 
>>>>>> But how we prevent ONLINE_PARTIAL memory block get offlined? There are three
>>>>>> calls in virtio_mem_set_fake_offline(), while all of them adjust page's flag.
>>>>>> How they hold reference to struct page?
>>>>> 
>>>>> Sorry, I should have given you the right pointer. (similar to my other
>>>>> reply)
>>>>> 
>>>>> We hold a reference either via
>>>>> 
>>>>> 1. alloc_contig_range()
>>>> 
>>>> I am not familiar with this one, need to spend some time to look into.
>>> 
>>> Each individual page will have a pagecount of 1.
>>> 
>>>> 
>>>>> 2. memmap init code, when not calling generic_online_page().
>>>> 
>>>> I may miss some code here. Before online pages, memmaps are allocated in
>>>> section_activate(). They are supposed to be zero-ed. (I don't get the exact
>>>> code line.) I am not sure when we grab a refcount here.
>>> 
>>> Best to refer to __init_single_page() -> init_page_count().
>>> 
>>> Each page that wasn't onlined via generic_online_page() has a refcount
>>> of 1 and looks like allocated.
>>> 
>> 
>> Thanks, I see the logic.
>> 
>>    online_pages()
>>        move_pfn_range_to_zone()  --- 1)
>>    online_pages_range()      --- 2)
>> 
>> At 1), __init_single_page() would set page count to 1. At 2),
>> generic_online_page() would clear page count, while the call back would not.
>> 
>> Then I am trying to search the place where un-zero page count prevent offline.
>> scan_movable_pages() would fail, since this is a PageOffline() and has 1 page
>> count.
>> 
>> So the GUARD we prevent offline partial-onlined pages is
>> 
>>    (PageOffline && page_count)
>> 
>> And your commit aa218795cb5fd583c94f
>> 
>> mm: Allow to offline unmovable PageOffline() pages via MEM_GOING_OFFLINE
>> 
>> is introduced to handle this case.
>> 
>> That's pretty clear now.
>> 
>
>I‘m happy to see that I am no longer the only person that understands all this magic :)

Thanks for sharing the magic :-)

>
>Thanks for having a look / reviewing!
>
>>> -- 
>>> Thanks,
>>> 
>>> David / dhildenb
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>> 

-- 
Wei Yang
Help you, Help me

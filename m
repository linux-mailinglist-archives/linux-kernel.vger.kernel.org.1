Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC75290268
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 12:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406496AbgJPKCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 06:02:15 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45586 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406489AbgJPKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 06:02:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UCBIqR._1602842531;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCBIqR._1602842531)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 18:02:11 +0800
Date:   Fri, 16 Oct 2020 18:02:11 +0800
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
Message-ID: <20201016100211.GI44269@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-6-david@redhat.com>
 <20201015082808.GE86495@L-31X9LVDL-1304.local>
 <994394f3-c16d-911c-c9fc-d2280f32e7b1@redhat.com>
 <20201016021651.GI86495@L-31X9LVDL-1304.local>
 <5caec772-295c-436a-2b19-ca261ea1ad0c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5caec772-295c-436a-2b19-ca261ea1ad0c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:11:24AM +0200, David Hildenbrand wrote:
>>> That's an interesting corner case. Assume you have a 128MB memory block
>>> but only 64MB are plugged.
>> 
>> Since we just plug a part of memory block, this state is OFFLINE_PARTIAL
>> first. But then we would add these memory and online it. This means the state
>> of this memory block is ONLINE_PARTIAL.
>> 
>> When this state is changed to OFFLINE_PARTIAL again?
>
>Please note that memory onlining is *completely* controllable by user
>space. User space can offline/online memory blocks as it wants. Not
>saying this might actually be the right thing to do - but we cannot
>trust that user space does the right thing.
>
>So at any point in time, you have to assume that
>
>a) added memory might not get onlined
>b) previously onlined memory might get offlined
>c) previously offline memory might get onlined
>
>> 
>>>
>>> As long as we have our online_pages callback in place, we can hinder the
>>> unplugged 64MB from getting exposed to the buddy
>>> (virtio_mem_online_page_cb()). However, once we unloaded the driver,
>> 
>> Yes,
>> 
>> virtio_mem_set_fake_offline() would __SetPageOffline() to those pages.
>> 
>>> this is no longer the case. If someone would online that memory block,
>>> we would expose unplugged memory to the buddy - very bad.
>>>
>> 
>> Per my understanding, at this point of time, the memory block is at online
>> state. Even part of it is set to *fake* offline.
>> 
>> So how could user trigger another online from sysfs interface?
>
>Assume we added a partially plugged memory block, which is now offline.
>Further assume user space did not online the memory block (e.g., no udev
>rules).
>
>User space could happily online the block after unloading the driver.
>Again, we have to assume user space could do crazy things.
>

You are right, online memory is not a forced behavior.

>> 
>>> So we have to remove these partially plugged, offline memory blocks when
>>> losing control over them.
>>>
>>> I tried to document that via:
>>>
>>> "After we unregistered our callbacks, user space can online partially
>>> plugged offline blocks. Make sure to remove them."
>>>
>>>>
>>>> Also, during virtio_mem_remove(), we just handle OFFLINE_PARTIAL memory block.
>>>> How about memory block in other states? It is not necessary to remove
>>>> ONLINE[_PARTIAL] memroy blocks?
>>>
>>> Blocks that are fully plugged (ONLINE or OFFLINE) can get
>>> onlined/offlined without us having to care. Works fine - we only have to
>>> care about partially plugged blocks.
>>>
>>> While we *could* unplug OFFLINE blocks, there is no way we can
>>> deterministically offline+remove ONLINE blocks. So that memory has to
>>> stay, even after we unloaded the driver (similar to the dax/kmem driver).
>> 
>> For OFFLINE memory blocks, would that leave the situation:
>> 
>> Guest doesn't need those pages, while host still maps them?
>
>Yes, but the guest could online the memory and make use of it.
>
>(again, whoever decides to unload the driver better be knowing what he does)
>
>To do it even more cleanly, we would
>
>a) Have to remove completely plugged offline blocks (not done)
>b) Have to remove partially plugged offline blocks (done)
>c) Actually send unplug requests to the hypervisor
>
>Right now, only b) is done, because it might actually cause harm (as
>discussed). However, the problem is, that c) might actually fail.
>
>Long short: we could add a) if it turns out to be a real issue. But
>than, unloading the driver isn't really suggested, the current
>implementation just "keeps it working without crashes" - and I guess
>that's good enough for now.
>
>> 
>>>
>>> ONLINE_PARTIAL is already taken care of: it cannot get offlined anymore,
>>> as we still hold references to these struct pages
>>> (virtio_mem_set_fake_offline()), and as we no longer have the memory
>>> notifier in place, we can no longer agree to offline this memory (when
>>> going_offline).
>>>
>> 
>> Ok, I seems to understand the logic now.
>> 
>> But how we prevent ONLINE_PARTIAL memory block get offlined? There are three
>> calls in virtio_mem_set_fake_offline(), while all of them adjust page's flag.
>> How they hold reference to struct page?
>
>Sorry, I should have given you the right pointer. (similar to my other
>reply)
>
>We hold a reference either via
>
>1. alloc_contig_range()

I am not familiar with this one, need to spend some time to look into.

>2. memmap init code, when not calling generic_online_page().

I may miss some code here. Before online pages, memmaps are allocated in
section_activate(). They are supposed to be zero-ed. (I don't get the exact
code line.) I am not sure when we grab a refcount here.

>
>So these fake-offline pages can never be actually offlined, because we
>no longer have the memory notifier registered to fix that up.
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00BA28FC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393641AbgJPCQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:16:55 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53313 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387691AbgJPCQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:16:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UC93h5h_1602814611;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UC93h5h_1602814611)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 10:16:51 +0800
Date:   Fri, 16 Oct 2020 10:16:51 +0800
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
Message-ID: <20201016021651.GI86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-6-david@redhat.com>
 <20201015082808.GE86495@L-31X9LVDL-1304.local>
 <994394f3-c16d-911c-c9fc-d2280f32e7b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994394f3-c16d-911c-c9fc-d2280f32e7b1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:50:27AM +0200, David Hildenbrand wrote:
[...]
>> 
>>> 		dev_warn(&vdev->dev, "device still has system memory added\n");
>>> 	} else {
>>> 		virtio_mem_delete_resource(vm);
>> 
>> BTW, I got one question during review.
>> 
>> Per my understanding, there are 4 states of a virtio memory block
>> 
>>   * OFFLINE[_PARTIAL]
>>   * ONLINE[_PARTIAL]
>> 
>> While, if my understanding is correct, those two offline states are transient.
>> If the required range is onlined, the state would be change to
>> ONLINE[_PARTIAL] respectively. If it is not, the state is reverted to UNUSED
>> or PLUGGED.
>
>Very right.
>
>> 
>> What I am lost is why you do virtio_mem_mb_remove() on OFFLINE_PARTIAL memory
>> block? Since we wait for the workqueue finish its job.

I have tried to understand the logic, while still have some confusion.

>
>That's an interesting corner case. Assume you have a 128MB memory block
>but only 64MB are plugged.

Since we just plug a part of memory block, this state is OFFLINE_PARTIAL
first. But then we would add these memory and online it. This means the state
of this memory block is ONLINE_PARTIAL.

When this state is changed to OFFLINE_PARTIAL again?

>
>As long as we have our online_pages callback in place, we can hinder the
>unplugged 64MB from getting exposed to the buddy
>(virtio_mem_online_page_cb()). However, once we unloaded the driver,

Yes,

virtio_mem_set_fake_offline() would __SetPageOffline() to those pages.

>this is no longer the case. If someone would online that memory block,
>we would expose unplugged memory to the buddy - very bad.
>

Per my understanding, at this point of time, the memory block is at online
state. Even part of it is set to *fake* offline.

So how could user trigger another online from sysfs interface?

>So we have to remove these partially plugged, offline memory blocks when
>losing control over them.
>
>I tried to document that via:
>
>"After we unregistered our callbacks, user space can online partially
>plugged offline blocks. Make sure to remove them."
>
>> 
>> Also, during virtio_mem_remove(), we just handle OFFLINE_PARTIAL memory block.
>> How about memory block in other states? It is not necessary to remove
>> ONLINE[_PARTIAL] memroy blocks?
>
>Blocks that are fully plugged (ONLINE or OFFLINE) can get
>onlined/offlined without us having to care. Works fine - we only have to
>care about partially plugged blocks.
>
>While we *could* unplug OFFLINE blocks, there is no way we can
>deterministically offline+remove ONLINE blocks. So that memory has to
>stay, even after we unloaded the driver (similar to the dax/kmem driver).

For OFFLINE memory blocks, would that leave the situation:

Guest doesn't need those pages, while host still maps them?

>
>ONLINE_PARTIAL is already taken care of: it cannot get offlined anymore,
>as we still hold references to these struct pages
>(virtio_mem_set_fake_offline()), and as we no longer have the memory
>notifier in place, we can no longer agree to offline this memory (when
>going_offline).
>

Ok, I seems to understand the logic now.

But how we prevent ONLINE_PARTIAL memory block get offlined? There are three
calls in virtio_mem_set_fake_offline(), while all of them adjust page's flag.
How they hold reference to struct page?

>I tried to document that via
>
>"After we unregistered our callbacks, user space can no longer offline
>partially plugged online memory blocks. No need to worry about them."
>
>
>> 
>> Thanks in advance, since I may missed some concepts.
>
>(force) driver unloading is a complicated corner case.
>
>Thanks!
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

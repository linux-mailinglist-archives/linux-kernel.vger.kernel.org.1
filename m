Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D385E291578
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 05:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJRD5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 23:57:31 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38900 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725272AbgJRD5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 23:57:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UCL0Fo4_1602993445;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCL0Fo4_1602993445)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Oct 2020 11:57:26 +0800
Date:   Sun, 18 Oct 2020 11:57:25 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue
 when offlining memory
Message-ID: <20201018035725.GA50506@L-31X9LVDL-1304>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-10-david@redhat.com>
 <20201016040301.GJ86495@L-31X9LVDL-1304.local>
 <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:18:39AM +0200, David Hildenbrand wrote:
>On 16.10.20 06:03, Wei Yang wrote:
>> On Mon, Oct 12, 2020 at 02:53:03PM +0200, David Hildenbrand wrote:
>>> Let's trigger from offlining code when we're not allowed to touch online

Here "touch" means "unplug"? If so, maybe s/touch/unplug/ would be more easy
to understand.

>>> memory.
>> 
>> This describes the change in virtio_mem_memory_notifier_cb()?
>
>Ah, yes, can try to make that clearer.
>
>> 
>>>
>>> Handle the other case (memmap possibly freeing up another memory block)
>>> when actually removing memory. When removing via virtio_mem_remove(),
>>> virtio_mem_retry() is a NOP and safe to use.
>>>
>>> While at it, move retry handling when offlining out of
>>> virtio_mem_notify_offline(), to share it with Device Block Mode (DBM)
>>> soon.
>> 
>> I may not understand the logic fully. Here is my understanding of current
>> logic:
>> 
>> 
>>   virtio_mem_run_wq()
>>       virtio_mem_unplug_request()
>>           virtio_mem_mb_unplug_any_sb_offline()
>> 	      virtio_mem_mb_remove()             --- 1
>> 	  virtio_mem_mb_unplug_any_sb_online()
>> 	      virtio_mem_mb_offline_and_remove() --- 2
>> 

I am trying to get more understanding about the logic of virtio_mem_retry().

Current logic seems clear to me. There are four places to trigger it:

    * notify_offline
    * notify_online
    * timer_expired
    * config_changed

In this patch, we try to optimize the first case, notify_offline.

Now, we would always trigger retry when one of our memory block get offlined.
Per my understanding, this logic is correct while missed one case (or be more
precise, not handle one case timely). The case this patch wants to improve is
virtio_mem_mb_remove(). If my understanding is correct.

   virtio_mem_run_wq()
       virtio_mem_unplug_request()
           virtio_mem_mb_unplug_any_sb_offline()
 	      virtio_mem_mb_remove()             --- 1
           virtio_mem_mb_unplug_any_sb_online()
              virtio_mem_mb_offline_and_remove() --- 2

The above is two functions this patch adjusts. For 2), it will offline the
memory block, thus will trigger virtio_mem_retry() originally. But for 1), the
memory block is already offlined, so virtio_mem_retry() will not be triggered
originally. This is the case we want to improve in this patch. Instead of wait
for timer expire, we trigger retry immediately after unplug/remove an offlined
memory block.

And after this change, this patch still adjust the original
virtio_mem_notify_offline() path to just trigger virtio_mem_retry() when
unplug_online is false. (This means the offline event is notified from user
space instead of from unplug event).

If my above analysis is correct, I got one small suggestion for this patch.
Instead of adjust current notify_offline handling, how about just trigger
retry during virtio_mem_mb_remove()? Since per my understanding, we just want
to do immediate trigger retry when unplug an offlined memory block.

>> This patch tries to trigger the wq at 1 and 2. And these two functions are
>> only valid during this code flow.
>
>Exactly.
>
>> 
>> These two functions actually remove some memory from the system. So I am not
>> sure where extra unplug-able memory comes from. I guess those memory is from
>> memory block device and mem_sectioin, memmap? While those memory is still
>> marked as online, right?
>
>Imagine you end up (only after some repeating plugging and unplugging of
>memory, otherwise it's obviously impossible):
>
>Memory block X: Contains only movable data
>
>Memory block X + 1: Contains memmap of Memory block X:
>
>
>We start to unplug from high, to low.
>
>1. Try to unplug/offline/remove block X + 1: fails, because of the
>   memmap
>2. Try to unplug/offline/remove block X: succeeds.
>3. Not all requested memory got unplugged. Sleep for 30 seconds.
>4. Retry to unplug/offline/remove block X + 1: succeeds
>
>What we do in 2, is that we trigger a retry of ourselves. That means,
>that in 3. we don't actually sleep, but retry immediately.
>
>This has been proven helpful in some of my tests, where you want to
>unplug *a lot* of memory again, not just some parts.
>
>
>Triggering a retry is fairly cheap. Assume you don't actually have to
>perform any more unplugging. The workqueue wakes up, detects that
>nothing is to do, and goes back to sleep.
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

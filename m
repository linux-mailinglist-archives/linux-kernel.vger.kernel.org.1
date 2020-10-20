Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15E8293262
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 02:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgJTAle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 20:41:34 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:20925 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389484AbgJTAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 20:41:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UCax3nK_1603154490;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCax3nK_1603154490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 08:41:31 +0800
Date:   Tue, 20 Oct 2020 08:41:30 +0800
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
Message-ID: <20201020004130.GB61232@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-10-david@redhat.com>
 <20201016040301.GJ86495@L-31X9LVDL-1304.local>
 <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
 <20201018035725.GA50506@L-31X9LVDL-1304>
 <5103e899-0ca2-0804-dee8-772b5737d34d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5103e899-0ca2-0804-dee8-772b5737d34d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:04:40AM +0200, David Hildenbrand wrote:
>On 18.10.20 05:57, Wei Yang wrote:
>> On Fri, Oct 16, 2020 at 11:18:39AM +0200, David Hildenbrand wrote:
>>> On 16.10.20 06:03, Wei Yang wrote:
>>>> On Mon, Oct 12, 2020 at 02:53:03PM +0200, David Hildenbrand wrote:
>>>>> Let's trigger from offlining code when we're not allowed to touch online
>> 
>> Here "touch" means "unplug"? If so, maybe s/touch/unplug/ would be more easy
>> to understand.
>
>Yes, much better.
>
>[...]
>
>> I am trying to get more understanding about the logic of virtio_mem_retry().
>> 
>> Current logic seems clear to me. There are four places to trigger it:
>> 
>>     * notify_offline
>>     * notify_online
>>     * timer_expired
>>     * config_changed
>> 
>> In this patch, we try to optimize the first case, notify_offline.
>
>Yes.
>
>> 
>> Now, we would always trigger retry when one of our memory block get offlined.
>> Per my understanding, this logic is correct while missed one case (or be more
>> precise, not handle one case timely). The case this patch wants to improve is
>> virtio_mem_mb_remove(). If my understanding is correct.
>> 
>
>Yes, that's one part of it. Read below.
>
>>    virtio_mem_run_wq()
>>        virtio_mem_unplug_request()
>>            virtio_mem_mb_unplug_any_sb_offline()
>>  	      virtio_mem_mb_remove()             --- 1
>>            virtio_mem_mb_unplug_any_sb_online()
>>               virtio_mem_mb_offline_and_remove() --- 2
>> 
>> The above is two functions this patch adjusts. For 2), it will offline the
>> memory block, thus will trigger virtio_mem_retry() originally. But for 1), the
>> memory block is already offlined, so virtio_mem_retry() will not be triggered
>> originally. This is the case we want to improve in this patch. Instead of wait
>> for timer expire, we trigger retry immediately after unplug/remove an offlined
>> memory block.
>> 
>> And after this change, this patch still adjust the original
>> virtio_mem_notify_offline() path to just trigger virtio_mem_retry() when
>> unplug_online is false. (This means the offline event is notified from user
>> space instead of from unplug event).
>> 
>> If my above analysis is correct, I got one small suggestion for this patch.
>> Instead of adjust current notify_offline handling, how about just trigger
>> retry during virtio_mem_mb_remove()? Since per my understanding, we just want
>> to do immediate trigger retry when unplug an offlined memory block.
>
>I probably should have added the following to the patch description:
>
>"This is a preparation for Big Block Mode (BBM), whereby we can see some
>temporary offlining of memory blocks without actually making progress"
>
>Imagine you have a Big Block that spans to Linux memory blocks. Assume
>the first Linux memory blocks has no unmovable data on it.
>
>Assume you call offline_and_remove_memory()
>
>1. Try to offline the first block. Works, notifiers triggered.
>virtio_mem_retry().

After this patch, the virtio_mem_retry() is remove here.

>2. Try to offline the second block. Does not work.
>3. Re-online first block.
>4. Exit to main loop, exit workqueue.

Since offline_and_remove_memory() doesn't succeed, virtio_mem_retry() is not
triggered.

>5. Retry immediately (due to virtio_mem_retry()), go to 1.

So we won't have endless loop.

>
>So, you'll keep retrying forever. Found while debugging that exact issue :)
>

If this is the case, my suggestion is to record it in the changelog.
Otherwise, we may lose this corner case which is important to this change.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C3292442
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgJSJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728124AbgJSJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603098295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YN6WDY3oBcjnMWDUE8tH8DebUWuolXBVNxsWQNIqYJs=;
        b=OTlTBB3uRfv+cxIV24dEB112o0VL/t01pjDtYN3Vit50EROl497zt3qLaSnj/AK9zqZ8EK
        pbp/Z0PXG4IWZ7xjPlXTLC33rnE1ylzUll7J5Bzhjn5/9jsWcPJlAFf0LQDyk1TxmqPeK0
        6dCBZinOWFdxSWrh5c5NDiAtHWdtVik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-Yo9k6QCxO1CcpnrFsWtE_A-1; Mon, 19 Oct 2020 05:04:50 -0400
X-MC-Unique: Yo9k6QCxO1CcpnrFsWtE_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72497104D3E3;
        Mon, 19 Oct 2020 09:04:49 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AAA21A4D6;
        Mon, 19 Oct 2020 09:04:42 +0000 (UTC)
Subject: Re: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue
 when offlining memory
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-10-david@redhat.com>
 <20201016040301.GJ86495@L-31X9LVDL-1304.local>
 <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
 <20201018035725.GA50506@L-31X9LVDL-1304>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5103e899-0ca2-0804-dee8-772b5737d34d@redhat.com>
Date:   Mon, 19 Oct 2020 11:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201018035725.GA50506@L-31X9LVDL-1304>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.20 05:57, Wei Yang wrote:
> On Fri, Oct 16, 2020 at 11:18:39AM +0200, David Hildenbrand wrote:
>> On 16.10.20 06:03, Wei Yang wrote:
>>> On Mon, Oct 12, 2020 at 02:53:03PM +0200, David Hildenbrand wrote:
>>>> Let's trigger from offlining code when we're not allowed to touch online
> 
> Here "touch" means "unplug"? If so, maybe s/touch/unplug/ would be more easy
> to understand.

Yes, much better.

[...]

> I am trying to get more understanding about the logic of virtio_mem_retry().
> 
> Current logic seems clear to me. There are four places to trigger it:
> 
>     * notify_offline
>     * notify_online
>     * timer_expired
>     * config_changed
> 
> In this patch, we try to optimize the first case, notify_offline.

Yes.

> 
> Now, we would always trigger retry when one of our memory block get offlined.
> Per my understanding, this logic is correct while missed one case (or be more
> precise, not handle one case timely). The case this patch wants to improve is
> virtio_mem_mb_remove(). If my understanding is correct.
> 

Yes, that's one part of it. Read below.

>    virtio_mem_run_wq()
>        virtio_mem_unplug_request()
>            virtio_mem_mb_unplug_any_sb_offline()
>  	      virtio_mem_mb_remove()             --- 1
>            virtio_mem_mb_unplug_any_sb_online()
>               virtio_mem_mb_offline_and_remove() --- 2
> 
> The above is two functions this patch adjusts. For 2), it will offline the
> memory block, thus will trigger virtio_mem_retry() originally. But for 1), the
> memory block is already offlined, so virtio_mem_retry() will not be triggered
> originally. This is the case we want to improve in this patch. Instead of wait
> for timer expire, we trigger retry immediately after unplug/remove an offlined
> memory block.
> 
> And after this change, this patch still adjust the original
> virtio_mem_notify_offline() path to just trigger virtio_mem_retry() when
> unplug_online is false. (This means the offline event is notified from user
> space instead of from unplug event).
> 
> If my above analysis is correct, I got one small suggestion for this patch.
> Instead of adjust current notify_offline handling, how about just trigger
> retry during virtio_mem_mb_remove()? Since per my understanding, we just want
> to do immediate trigger retry when unplug an offlined memory block.

I probably should have added the following to the patch description:

"This is a preparation for Big Block Mode (BBM), whereby we can see some
temporary offlining of memory blocks without actually making progress"

Imagine you have a Big Block that spans to Linux memory blocks. Assume
the first Linux memory blocks has no unmovable data on it.

Assume you call offline_and_remove_memory()

1. Try to offline the first block. Works, notifiers triggered.
virtio_mem_retry().
2. Try to offline the second block. Does not work.
3. Re-online first block.
4. Exit to main loop, exit workqueue.
5. Retry immediately (due to virtio_mem_retry()), go to 1.

So, you'll keep retrying forever. Found while debugging that exact issue :)


-- 
Thanks,

David / dhildenb


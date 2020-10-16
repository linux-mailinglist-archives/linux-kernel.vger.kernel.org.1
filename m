Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620F92901B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406107AbgJPJSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:18:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394799AbgJPJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602839930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkDAPJVLLNu9aqbT2ZGJGKmJO7QPtcaA3nJyCliA/rs=;
        b=fmT9sYL1QPQlM4RrB7uRQuMMApST3JWpVuYtXHi+E/fEQD/R2KeVAVW239juZF2xf+Uu6w
        HvgRhf6yX5EqwEyXimriXGtqcEgW+y17KAkM5rwV75vDFCFo9dF18iZaGh581WYREfoVQS
        aEcPZyELakWSDZn5n7wGfh7MBn6ExrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-N2dJj4zyMFWma92NUVlemw-1; Fri, 16 Oct 2020 05:18:46 -0400
X-MC-Unique: N2dJj4zyMFWma92NUVlemw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2142284BA66;
        Fri, 16 Oct 2020 09:18:45 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 817366EF70;
        Fri, 16 Oct 2020 09:18:40 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <82afba4e-66e2-ce05-c092-267301b66de9@redhat.com>
Date:   Fri, 16 Oct 2020 11:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016040301.GJ86495@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.20 06:03, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:03PM +0200, David Hildenbrand wrote:
>> Let's trigger from offlining code when we're not allowed to touch online
>> memory.
> 
> This describes the change in virtio_mem_memory_notifier_cb()?

Ah, yes, can try to make that clearer.

> 
>>
>> Handle the other case (memmap possibly freeing up another memory block)
>> when actually removing memory. When removing via virtio_mem_remove(),
>> virtio_mem_retry() is a NOP and safe to use.
>>
>> While at it, move retry handling when offlining out of
>> virtio_mem_notify_offline(), to share it with Device Block Mode (DBM)
>> soon.
> 
> I may not understand the logic fully. Here is my understanding of current
> logic:
> 
> 
>   virtio_mem_run_wq()
>       virtio_mem_unplug_request()
>           virtio_mem_mb_unplug_any_sb_offline()
> 	      virtio_mem_mb_remove()             --- 1
> 	  virtio_mem_mb_unplug_any_sb_online()
> 	      virtio_mem_mb_offline_and_remove() --- 2
> 
> This patch tries to trigger the wq at 1 and 2. And these two functions are
> only valid during this code flow.

Exactly.

> 
> These two functions actually remove some memory from the system. So I am not
> sure where extra unplug-able memory comes from. I guess those memory is from
> memory block device and mem_sectioin, memmap? While those memory is still
> marked as online, right?

Imagine you end up (only after some repeating plugging and unplugging of
memory, otherwise it's obviously impossible):

Memory block X: Contains only movable data

Memory block X + 1: Contains memmap of Memory block X:


We start to unplug from high, to low.

1. Try to unplug/offline/remove block X + 1: fails, because of the
   memmap
2. Try to unplug/offline/remove block X: succeeds.
3. Not all requested memory got unplugged. Sleep for 30 seconds.
4. Retry to unplug/offline/remove block X + 1: succeeds

What we do in 2, is that we trigger a retry of ourselves. That means,
that in 3. we don't actually sleep, but retry immediately.

This has been proven helpful in some of my tests, where you want to
unplug *a lot* of memory again, not just some parts.


Triggering a retry is fairly cheap. Assume you don't actually have to
perform any more unplugging. The workqueue wakes up, detects that
nothing is to do, and goes back to sleep.

-- 
Thanks,

David / dhildenb


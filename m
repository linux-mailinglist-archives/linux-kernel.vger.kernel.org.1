Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31FD2925AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgJSKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726259AbgJSKW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603102977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dClCYoDEHGrmREG2sQsLlOLmsyhbsQZOxw+llhuTikA=;
        b=imB+SIqIHx4E6/BCOR69UjLRnwgwaYHXbvyT6W8gfDGqsRyFR54Hfct310hiDyTfJdYerY
        NguviApclcCEnj3xYsrUmJ4GsgMv17biYHufj8A0Zl+fJVYwyiGrJJA2Q0CM1ifN1E2oJb
        XO4jNVzOkqOmG2Eg++1az8hx9gsSyyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-sPW-dcUcMnKKgPRZkQiKug-1; Mon, 19 Oct 2020 06:22:55 -0400
X-MC-Unique: sPW-dcUcMnKKgPRZkQiKug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63CAB10199A8;
        Mon, 19 Oct 2020 10:22:53 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 336545B4A4;
        Mon, 19 Oct 2020 10:22:45 +0000 (UTC)
Subject: Re: [PATCH v1 21/29] virtio-mem: memory notifier callbacks are
 specific to Sub Block Mode (SBM)
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-22-david@redhat.com>
 <20201019015724.GA54484@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <794b68b2-a3da-5354-4a3b-62f94224c0a6@redhat.com>
Date:   Mon, 19 Oct 2020 12:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019015724.GA54484@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.20 03:57, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:53:15PM +0200, David Hildenbrand wrote:
>> Let's rename accordingly.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/virtio/virtio_mem.c | 29 +++++++++++++++--------------
>> 1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 3a772714fec9..d06c8760b337 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -589,8 +589,8 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
>> 	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
>> }
>>
>> -static int virtio_mem_notify_going_online(struct virtio_mem *vm,
>> -					  unsigned long mb_id)
>> +static int virtio_mem_sbm_notify_going_online(struct virtio_mem *vm,
>> +					      unsigned long mb_id)
> 
> Look into this patch with "virtio-mem: Big Block Mode (BBM) memory hotplug"
> together, I thought the code is a little "complex".
> 
> The final logic of virtio_mem_memory_notifier_cb() looks like this:
> 
>     virtio_mem_memory_notifier_cb()
>         if (vm->in_sbm)
> 	    notify_xxx()
>         if (vm->in_sbm)
> 	    notify_xxx()
> 
> Can we adjust this like
> 
>     virtio_mem_memory_notifier_cb()
> 	notify_xxx()
>             if (vm->in_sbm)
>                 return
> 	notify_xxx()
>             if (vm->in_sbm)
>                 return
> 
> This style looks a little better to me.

Then we lose all the shared code after any of the mode-specific
handling? Like we have in MEM_OFFLINE, MEM_ONLINE, MEM_CANCEL_OFFLINE, ...

Don't think this will improve the situation.

-- 
Thanks,

David / dhildenb


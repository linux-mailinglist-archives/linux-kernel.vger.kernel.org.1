Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCE28EECB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgJOIuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgJOIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602751836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=8g0dEJ4HjLmnMAQQi1r5OiIA7ugQGWhb4UgQjxmr0MY=;
        b=JHjpYuBTAZBVKoSFNkcKgXR1/pSnT8/XQvAjfx4/tfP15f+2dniJxlh1hHdmH8PsgS8+3I
        Sg010DfxS4uQSdv2mtZDniqovswKOupd+5Ctd7VxWXxD0JNoN7ERj3P9w9mYDNDPU7WyOQ
        ciGXGC1r6CChWdfxM8nYfuVLIclFv7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-QmxSiLYUMiaS3T7c_0bKaw-1; Thu, 15 Oct 2020 04:50:34 -0400
X-MC-Unique: QmxSiLYUMiaS3T7c_0bKaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990B0190A3E4;
        Thu, 15 Oct 2020 08:50:32 +0000 (UTC)
Received: from [10.36.114.207] (ovpn-114-207.ams2.redhat.com [10.36.114.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0865A100238E;
        Thu, 15 Oct 2020 08:50:27 +0000 (UTC)
Subject: Re: [PATCH v1 05/29] virtio-mem: generalize check for added memory
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-6-david@redhat.com>
 <20201015082808.GE86495@L-31X9LVDL-1304.local>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <994394f3-c16d-911c-c9fc-d2280f32e7b1@redhat.com>
Date:   Thu, 15 Oct 2020 10:50:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015082808.GE86495@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.20 10:28, Wei Yang wrote:
> On Mon, Oct 12, 2020 at 02:52:59PM +0200, David Hildenbrand wrote:
>> Let's check by traversing busy system RAM resources instead, to avoid
>> relying on memory block states.
>>
>> Don't use walk_system_ram_range(), as that works on pages and we want to
>> use the bare addresses we have easily at hand.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/virtio/virtio_mem.c | 19 +++++++++++++++----
>> 1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index b3eebac7191f..6bbd1cfd10d3 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -1749,6 +1749,20 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
>> 	vm->parent_resource = NULL;
>> }
>>
>> +static int virtio_mem_range_has_system_ram(struct resource *res, void *arg)
>> +{
>> +	return 1;
>> +}
>> +
>> +static bool virtio_mem_has_memory_added(struct virtio_mem *vm)
>> +{
>> +	const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> +
>> +	return walk_iomem_res_desc(IORES_DESC_NONE, flags, vm->addr,
>> +				   vm->addr + vm->region_size, NULL,
>> +				   virtio_mem_range_has_system_ram) == 1;
>> +}
>> +
>> static int virtio_mem_probe(struct virtio_device *vdev)
>> {
>> 	struct virtio_mem *vm;
>> @@ -1870,10 +1884,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
>> 	 * the system. And there is no way to stop the driver/device from going
>> 	 * away. Warn at least.
>> 	 */
>> -	if (vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] ||
>> -	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
>> -	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
>> -	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL]) {
>> +	if (virtio_mem_has_memory_added(vm)) {
> 
> I am not sure this would be more efficient.

In general, no. However, this is a preparation for Big Block Mode, which
won't have memory block states.

(this path only triggers when unloading the driver - which most probably
only ever happens during my testing ... :) and we don't really care
about performance there)

> 
>> 		dev_warn(&vdev->dev, "device still has system memory added\n");
>> 	} else {
>> 		virtio_mem_delete_resource(vm);
> 
> BTW, I got one question during review.
> 
> Per my understanding, there are 4 states of a virtio memory block
> 
>   * OFFLINE[_PARTIAL]
>   * ONLINE[_PARTIAL]
> 
> While, if my understanding is correct, those two offline states are transient.
> If the required range is onlined, the state would be change to
> ONLINE[_PARTIAL] respectively. If it is not, the state is reverted to UNUSED
> or PLUGGED.

Very right.

> 
> What I am lost is why you do virtio_mem_mb_remove() on OFFLINE_PARTIAL memory
> block? Since we wait for the workqueue finish its job.

That's an interesting corner case. Assume you have a 128MB memory block
but only 64MB are plugged.

As long as we have our online_pages callback in place, we can hinder the
unplugged 64MB from getting exposed to the buddy
(virtio_mem_online_page_cb()). However, once we unloaded the driver,
this is no longer the case. If someone would online that memory block,
we would expose unplugged memory to the buddy - very bad.

So we have to remove these partially plugged, offline memory blocks when
losing control over them.

I tried to document that via:

"After we unregistered our callbacks, user space can online partially
plugged offline blocks. Make sure to remove them."

> 
> Also, during virtio_mem_remove(), we just handle OFFLINE_PARTIAL memory block.
> How about memory block in other states? It is not necessary to remove
> ONLINE[_PARTIAL] memroy blocks?

Blocks that are fully plugged (ONLINE or OFFLINE) can get
onlined/offlined without us having to care. Works fine - we only have to
care about partially plugged blocks.

While we *could* unplug OFFLINE blocks, there is no way we can
deterministically offline+remove ONLINE blocks. So that memory has to
stay, even after we unloaded the driver (similar to the dax/kmem driver).

ONLINE_PARTIAL is already taken care of: it cannot get offlined anymore,
as we still hold references to these struct pages
(virtio_mem_set_fake_offline()), and as we no longer have the memory
notifier in place, we can no longer agree to offline this memory (when
going_offline).

I tried to document that via

"After we unregistered our callbacks, user space can no longer offline
partially plugged online memory blocks. No need to worry about them."


> 
> Thanks in advance, since I may missed some concepts.

(force) driver unloading is a complicated corner case.

Thanks!

-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38093024DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbhAYMW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:22:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbhAYMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611576781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtg7PDUV7D5/4c+APnQgvAcp6L1BanPgaK8SorUjGaE=;
        b=chuPADwwIAQMJ9XembHtzL8hsE36iXJXfAryI/9gfRoDTwgrawb0AXGeOqqG06Zt7xp4wG
        rr/18VvdtCnW4ET1Z4D1oiRjKTL5ugAYl5j0jHUSAb6ahANOjkSwstFtcWywW9W6GdffqU
        ieszWWQbP+783HZ9X6jxPk+F9g9GNfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-J0GIFzHXM_Cx0I_wguN0Sg-1; Mon, 25 Jan 2021 07:01:24 -0500
X-MC-Unique: J0GIFzHXM_Cx0I_wguN0Sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFC4B192D786;
        Mon, 25 Jan 2021 12:01:19 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2773910013BD;
        Mon, 25 Jan 2021 12:01:14 +0000 (UTC)
Subject: Re: [PATCH V4 4/4] virtio-mem: check against
 mhp_get_pluggable_range() which memory we can hotplug
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        teawater <teawaterz@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
 <1611543532-18698-5-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a62e9474-ada3-ab80-90a7-14db87c90aa6@redhat.com>
Date:   Mon, 25 Jan 2021 13:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1611543532-18698-5-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.21 03:58, Anshuman Khandual wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Right now, we only check against MAX_PHYSMEM_BITS - but turns out there
> are more restrictions of which memory we can actually hotplug, especially
> om arm64 or s390x once we support them: we might receive something like
> -E2BIG or -ERANGE from add_memory_driver_managed(), stopping device
> operation.
> 
> So, check right when initializing the device which memory we can add,
> warning the user. Try only adding actually pluggable ranges: in the worst
> case, no memory provided by our device is pluggable.
> 
> In the usual case, we expect all device memory to be pluggable, and in
> corner cases only some memory at the end of the device-managed memory
> region to not be pluggable.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: catalin.marinas@arm.com
> Cc: teawater <teawaterz@linux.alibaba.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: hca@linux.ibm.com
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/virtio/virtio_mem.c | 40 +++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 9fc9ec4a25f5..14c17c5c1695 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2222,7 +2222,7 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
>   */
>  static void virtio_mem_refresh_config(struct virtio_mem *vm)
>  {
> -	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
> +	const struct range pluggable_range = mhp_get_pluggable_range(true);
>  	uint64_t new_plugged_size, usable_region_size, end_addr;
>  
>  	/* the plugged_size is just a reflection of what _we_ did previously */
> @@ -2234,15 +2234,25 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
>  	/* calculate the last usable memory block id */
>  	virtio_cread_le(vm->vdev, struct virtio_mem_config,
>  			usable_region_size, &usable_region_size);
> -	end_addr = vm->addr + usable_region_size;
> -	end_addr = min(end_addr, phys_limit);
> +	end_addr = min(vm->addr + usable_region_size - 1,
> +		       pluggable_range.end);
>  
> -	if (vm->in_sbm)
> -		vm->sbm.last_usable_mb_id =
> -					 virtio_mem_phys_to_mb_id(end_addr) - 1;
> -	else
> -		vm->bbm.last_usable_bb_id =
> -				     virtio_mem_phys_to_bb_id(vm, end_addr) - 1;
> +	if (vm->in_sbm) {
> +		vm->sbm.last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr);
> +		if (!IS_ALIGNED(end_addr + 1, memory_block_size_bytes()))
> +			vm->sbm.last_usable_mb_id--;
> +	} else {
> +		vm->bbm.last_usable_bb_id = virtio_mem_phys_to_bb_id(vm,
> +								     end_addr);
> +		if (!IS_ALIGNED(end_addr + 1, vm->bbm.bb_size))
> +			vm->bbm.last_usable_bb_id--;
> +	}
> +	/*
> +	 * If we cannot plug any of our device memory (e.g., nothing in the
> +	 * usable region is addressable), the last usable memory block id will
> +	 * be smaller than the first usable memory block id. We'll stop
> +	 * attempting to add memory with -ENOSPC from our main loop.
> +	 */
>  
>  	/* see if there is a request to change the size */
>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
> @@ -2364,6 +2374,7 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
>  
>  static int virtio_mem_init(struct virtio_mem *vm)
>  {
> +	const struct range pluggable_range = mhp_get_pluggable_range(true);
>  	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;

Sorry, forgot to drop ^ (phys_limit), otherwise ther is a friendly
warning from the compiler. We have to drop that line.



Apart from that, at least on x86-64 it does what it's supposed to do. I
temporarily changed MAX_PHYSMEM_BITS to 35 bits and added a virtio-mem
device that crosses the 32 GiB address limit.


[    0.572084] virtio_mem virtio1: Some device memory is not
addressable/pluggable. This can make some memory unusable.
[    0.573013] virtio_mem virtio1: start address: 0x740000000
[    0.573497] virtio_mem virtio1: region size: 0x500000000


And virtio-mem won't add any memory exceeding that:

(qemu) qom-set vmem0 requested-size 20G
(qemu) info memory-devices
Memory device [virtio-mem]: "vmem0"
[...]
Memory device [virtio-mem]: "vmem1"
  memaddr: 0x740000000
  node: 1
  requested-size: 21474836480
  size: 3221225472
  max-size: 21474836480
  block-size: 2097152
  memdev: /objects/mem1

I adds all memory up to the 32GiB address limit (35 bits) and stops.

LGTM (arm64 to be tested in the future once supported).

-- 
Thanks,

David / dhildenb


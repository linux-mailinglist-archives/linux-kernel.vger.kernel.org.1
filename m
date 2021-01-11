Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8452E2F1B94
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbhAKQyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729070AbhAKQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610383994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGufGJ9Ezi29rGDW7hmHg7R76kh5lHSjpsexDtXG7s8=;
        b=X/Oai3c/+SH2FXnmfoH2LJ6emdZMDkWaLS3mFxKbnvUrVVrJvqypm6n3RO6zahIgkvWR/V
        7besEP0BA5fM3Dm/IFgkJW0ujl4E03mI4Q8YwlxrbdCtGTHbO0jVZfp+CvVZusJAx8SRuF
        A+R7WeCzP8+R/qaGvSx6d8wEVyLgbog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-uasyUNkCODufEqtKq6MVSQ-1; Mon, 11 Jan 2021 11:53:10 -0500
X-MC-Unique: uasyUNkCODufEqtKq6MVSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B98DDAFA83;
        Mon, 11 Jan 2021 16:53:08 +0000 (UTC)
Received: from [10.36.115.103] (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 479C550F1A;
        Mon, 11 Jan 2021 16:53:07 +0000 (UTC)
Subject: Re: [PATCH 3/5] acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when
 supported
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e2bfab61-3f47-e95d-d652-c442ca04b864@redhat.com>
Date:   Mon, 11 Jan 2021 17:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217130758.11565-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.20 14:07, Oscar Salvador wrote:
> Let the caller check whether it can pass MHP_MEMMAP_ON_MEMORY by
> checking mhp_supports_memmap_on_memory().
> MHP_MEMMAP_ON_MEMORY can only be set in case
> ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE is enabled, the architecture supports
> altmap, and the range to be added spans a single memory block.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  drivers/acpi/acpi_memhotplug.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index b02fd51e5589..8cc195c4c861 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -171,6 +171,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  	acpi_handle handle = mem_device->device->handle;
>  	int result, num_enabled = 0;
>  	struct acpi_memory_info *info;
> +	mhp_t mhp_flags = MHP_NONE;
>  	int node;
>  
>  	node = acpi_get_node(handle);
> @@ -194,8 +195,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  		if (node < 0)
>  			node = memory_add_physaddr_to_nid(info->start_addr);
>  
> +		if (mhp_supports_memmap_on_memory(info->length))
> +			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
>  		result = __add_memory(node, info->start_addr, info->length,
> -				      MHP_NONE);
> +				      mhp_flags);
>  
>  		/*
>  		 * If the memory block has been used by the kernel, add_memory()
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


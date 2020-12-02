Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48A22CB913
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbgLBJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:39:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388208AbgLBJi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606901851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCvOXO+6rI+WpobdR0grh6RzWowZrpkVEaa00biUVXU=;
        b=LDZn+puZU3G90veOSSV40V27xbyyX6KGvKfM/yCGGdj7en03I6O4x4ITdqidkNkS6pkWhT
        t9+3K2QAOSiRbC0ULORxYnUBbGKx2PhNoJxwD70mcXasKRXu5ITJyoyjHTxq1iIaEt8SoC
        RcZXF9+iCLBsRPSpikFHWHT3DEv2JZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-aB0pClpFO1KrIdKZsaEGcQ-1; Wed, 02 Dec 2020 04:37:27 -0500
X-MC-Unique: aB0pClpFO1KrIdKZsaEGcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDCE4100A651;
        Wed,  2 Dec 2020 09:37:25 +0000 (UTC)
Received: from [10.36.113.108] (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8662D6085A;
        Wed,  2 Dec 2020 09:37:24 +0000 (UTC)
Subject: Re: [RFC PATCH v3 3/4] mm,memory_hotplug: Enable MHP_MEMMAP_ON_MEMORY
 when supported
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <aebea77d-0f13-3e59-f748-001329c9ed94@redhat.com>
Date:   Wed, 2 Dec 2020 10:37:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201115158.22638-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.20 12:51, Oscar Salvador wrote:
> Let the callers check whether they can use MHP_MEMMAP_ON_MEMORY by
> checking mhp_supports_memmap_on_memory().
> Currently, we only support MHP_MEMMAP_ON_MEMORY in case
> CONFIG_SPARSEMEM_VMEMMAP is enabled, the architecture supports altmap,
> and the range to be added spans a single memory block.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 5 ++++-
>  drivers/acpi/acpi_memhotplug.c                  | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 7efe6ec5d14a..3aba817e729e 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -612,6 +612,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>  {
>  	unsigned long block_sz;
>  	int nid, rc;
> +	mhp_t mhp_flags = MHP_NONE;
>  
>  	if (lmb->flags & DRCONF_MEM_ASSIGNED)
>  		return -EINVAL;
> @@ -629,8 +630,10 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>  	if (nid < 0 || !node_possible(nid))
>  		nid = first_online_node;
>  
> +	if (mhp_supports_memmap_on_memory(block_sz))
> +		mhp_flags |= MHP_MEMMAP_ON_MEMORY;
>  	/* Add the memory */
> -	rc = __add_memory(nid, lmb->base_addr, block_sz, MHP_NONE);
> +	rc = __add_memory(nid, lmb->base_addr, block_sz, mhp_flags);
>  	if (rc) {
>  		invalidate_lmb_associativity_index(lmb);
>  		return rc;
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index b02fd51e5589..1fe645ef0b6c 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -172,6 +172,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  	int result, num_enabled = 0;
>  	struct acpi_memory_info *info;
>  	int node;
> +	mhp_t mhp_flags = MHP_NONE;
>  
>  	node = acpi_get_node(handle);
>  	/*
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

Please split that patch into two parts, one for each subsystem.

-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58CA2CB911
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbgLBJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:38:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387860AbgLBJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606901820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uhVD4aZ4wX+efTPfik+C1mthXMjeir/o96N9/zakbGQ=;
        b=SxcNBwHmlj4Q1/w5KiSgqTDchKAEQvGS/phywg3wnN15C+YVZJg1ksLJ7oSTN1LvgcMEwk
        6jJLxXC2WZARXeQVQcpPOXKvsfNhlGHGjvtROJ4W9EBFgNQFTBBup66BABONDo3wKGraYl
        l0IztsrAgDwAZjcTJSO1b5hJO4suZwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-5cUa9CEfPYarUIOgyylDbw-1; Wed, 02 Dec 2020 04:36:58 -0500
X-MC-Unique: 5cUa9CEfPYarUIOgyylDbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2EE5817B97;
        Wed,  2 Dec 2020 09:36:56 +0000 (UTC)
Received: from [10.36.113.108] (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28E28189A5;
        Wed,  2 Dec 2020 09:36:54 +0000 (UTC)
Subject: Re: [RFC PATCH v3 1/4] mm,memory_hotplug: Add
 mhp_supports_memmap_on_memory
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c5b82d52-f1be-0701-e36b-49aae4bb5cdb@redhat.com>
Date:   Wed, 2 Dec 2020 10:36:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201115158.22638-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.20 12:51, Oscar Salvador wrote:
> mhp_supports_memmap_on_memory is meant to be used by the caller prior
> to hot-adding memory in order to figure out whether it can enable
> MHP_MEMMAP_ON_MEMORY or not.
> 
> Enabling MHP_MEMMAP_ON_MEMORY requires:
> 
>  - memmap_on_memory_enabled is set (by mhp_memmap_on_memory kernel boot option)
>  - CONFIG_SPARSEMEM_VMEMMAP
>  - architecture support for altmap
>  - hot-added range spans a single memory block

Instead of adding these arch callbacks, what about a config option

ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE

that gets selected by the archs with CONFIG_SPARSEMEM_VMEMMAP ?

The mhp_supports_memmap_on_memory() becomes even more trivial.


> 
> Note that mhp_memmap_on_memory kernel boot option will be added in
> a coming patch.

I think it makes sense to

a) separate off the arch changes into separate patches, clarifying why
it can be used. Move this patches to the end of the series.

b) Squashing the remainings into patch #2

> 
> At the moment, only three architectures support passing altmap when
> building the page tables: x86, POWERPC and ARM.
> Define an arch_support_memmap_on_memory function on those architectures
> that returns true, and define a __weak variant of it that will be used
> on the others.

[...]

> +/*
> + * We want memmap (struct page array) to be self contained.
> + * To do so, we will use the beginning of the hot-added range to build
> + * the page tables for the memmap array that describes the entire range.
> + * Only selected architectures support it with SPARSE_VMEMMAP.

You might want to add how the caller can calculate the necessary size
and that that this calculated piece of memory to be added will be
accessed before onlining these pages. This is e.g., relevant if
virtio-mem, the hyper-v balloon, or xen balloon would want to use this
mechanism. Also, it's somewhat incompatible with standby memory where
memory cannot be accessed prior to onlining. So pointing that access out
might be valuable.

> + */
> +#define MHP_MEMMAP_ON_MEMORY   ((__force mhp_t)BIT(1))
> +
>  /*
>   * Extended parameters for memory hotplug:
>   * altmap: alternative allocator for memmap array (optional)
> @@ -129,6 +137,7 @@ extern int try_online_node(int nid);
>  
>  extern int arch_add_memory(int nid, u64 start, u64 size,
>  			   struct mhp_params *params);
> +extern bool arch_support_memmap_on_memory(void);
>  extern u64 max_mem_size;
>  
>  extern int memhp_online_type_from_str(const char *str);
> @@ -361,6 +370,7 @@ extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
>  					  unsigned long pnum);
>  extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
>  		unsigned long nr_pages);
> +extern bool mhp_supports_memmap_on_memory(unsigned long size);
>  extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
>  				      struct mhp_params *params);
>  void arch_remove_linear_mapping(u64 start, u64 size);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a8cef4955907..e3c310225a60 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1011,6 +1011,20 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>  	return device_online(&mem->dev);
>  }
>  
> +bool __weak arch_support_memmap_on_memory(void)
> +{
> +	return false;
> +}
> +
> +bool mhp_supports_memmap_on_memory(unsigned long size)
> +{
> +	if (!arch_support_memmap_on_memory() ||
> +	    !IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) ||
> +	    size > memory_block_size_bytes())
> +		return false;
> +	return true;

You can simplify to

return arch_support_memmap_on_memory() &&
       IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
       size == memory_block_size_bytes();


-- 
Thanks,

David / dhildenb


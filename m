Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802FA2C6420
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgK0Lz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:55:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:38816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgK0Lz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:55:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9ACFABD7;
        Fri, 27 Nov 2020 11:55:25 +0000 (UTC)
Date:   Fri, 27 Nov 2020 12:55:23 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v2 4/4] mm,memory_hotplug: Enable
 MHP_MEMMAP_ON_MEMORY when supported
Message-ID: <20201127115518.GA21935@linux>
References: <20201125112048.8211-1-osalvador@suse.de>
 <20201125112048.8211-5-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125112048.8211-5-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:20:48PM +0100, Oscar Salvador wrote:
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

I fortot the following chunk:

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 7efe6ec5d14a..3aba817e729e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -612,6 +612,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 {
        unsigned long block_sz;
        int nid, rc;
+       mhp_t mhp_flags = MHP_NONE;
 
        if (lmb->flags & DRCONF_MEM_ASSIGNED)
                return -EINVAL;
@@ -629,8 +630,10 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
        if (nid < 0 || !node_possible(nid))
                nid = first_online_node;
 
+       if (mhp_supports_memmap_on_memory(block_sz))
+               mhp_flags |= MHP_MEMMAP_ON_MEMORY;
        /* Add the memory */
-       rc = __add_memory(nid, lmb->base_addr, block_sz, MHP_NONE);
+       rc = __add_memory(nid, lmb->base_addr, block_sz, mhp_flags);
        if (rc) {
                invalidate_lmb_associativity_index(lmb);
                return rc;

I will add it for the next spin once I get more feedback. 

-- 
Oscar Salvador
SUSE L3

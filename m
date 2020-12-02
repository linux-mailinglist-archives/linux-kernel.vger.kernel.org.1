Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F72CB8A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgLBJWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729107AbgLBJWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606900841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQQdBNNqgVntbNPasbENMCveCDK2DYJNqimJozaTDkQ=;
        b=W1jx7M5pFW9zxHs9TTQSEdOPHpgq7w6waR/cYvR7NUdnrGnZzpIqYKTILju2HsCt3P4HKg
        fTgZPOGcAjny1EbCoXGciNRZiEo8tUcN+Ma9pkh762jhrJLnMhpu+QzbqkLsBd5YI2dHZF
        nSW0fHQVePW8mIDuKgxEDZbNFaMJ90Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-J1BxoSlzNnGLzDY8zAafEg-1; Wed, 02 Dec 2020 04:20:39 -0500
X-MC-Unique: J1BxoSlzNnGLzDY8zAafEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79CA858190;
        Wed,  2 Dec 2020 09:20:37 +0000 (UTC)
Received: from [10.36.113.108] (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7476D19C47;
        Wed,  2 Dec 2020 09:20:36 +0000 (UTC)
Subject: Re: [RFC V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-2-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <864c701a-4391-f768-1b95-1992e21835a2@redhat.com>
Date:   Wed, 2 Dec 2020 10:20:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606706992-26656-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.20 04:29, Anshuman Khandual wrote:
> This introduces memhp_range_allowed() which can be called in various memory
> hotplug paths to prevalidate the address range which is being added, with
> the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
> which provides applicable address range depending on whether linear mapping
> is required or not. For ranges that require linear mapping, it calls a new
> arch callback arch_get_mappable_range() which the platform can override. So
> the new callback, in turn provides the platform an opportunity to configure
> acceptable memory hotplug address ranges in case there are constraints.
> 
> This mechanism will help prevent platform specific errors deep down during
> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
> check in __add_pages().
> 


[...]

>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> @@ -317,10 +304,6 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  	if (WARN_ON_ONCE(!params->pgprot.pgprot))
>  		return -EINVAL;
>  
> -	err = check_hotplug_memory_addressable(pfn, nr_pages);
> -	if (err)
> -		return err;
> -

I was wondering if we should add a VM_BUG_ON(!memhp_range_allowed())
here to make it clearer that callers are expected to check that first.
Maybe an other places as well (e.g., arch code where we remove the
original checks)

[...]


>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 16b2fb482da1..26c1825756cc 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -185,6 +185,7 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
>  static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  		int range_id, int nid)
>  {
> +	const bool is_private = pgmap->type == MEMORY_DEVICE_PRIVATE;
>  	struct range *range = &pgmap->ranges[range_id];
>  	struct dev_pagemap *conflict_pgmap;
>  	int error, is_ram;
> @@ -230,6 +231,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	if (error)
>  		goto err_pfn_remap;
>  
> +	if (!memhp_range_allowed(range->start, range_len(range), !is_private))
> +		goto err_pfn_remap;
> +
>  	mem_hotplug_begin();
>  
>  	/*
> @@ -243,7 +247,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	 * the CPU, we do want the linear mapping and thus use
>  	 * arch_add_memory().
>  	 */
> -	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> +	if (is_private) {
>  		error = add_pages(nid, PHYS_PFN(range->start),
>  				PHYS_PFN(range_len(range)), params);
>  	} else {
> 

In general, LGTM.

-- 
Thanks,

David / dhildenb


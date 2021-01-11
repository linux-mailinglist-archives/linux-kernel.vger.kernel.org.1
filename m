Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF52F1B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbhAKQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731149AbhAKQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610384142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+qfhY97NCTMgUChfBrWKmfcQ+DSxbvypcL004zBfdk=;
        b=DyRrBTOC3v3YMR01jXMX6lfcwZ3NY2R1M/U31WIpOZavctDvhhnsSQjJUipiqqfaaRylBM
        kbYObu4+z/2m4Izf6Wcxya+EGm80Zd1YgGlTJc1C+RB3IufMgJb2LQInH6uLl27K4k1AFz
        kSzi8KbsFJzOJjSQUkaUqlS6mRIvXDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-wSNQmkLbMAOfiiQjLDy1ww-1; Mon, 11 Jan 2021 11:55:40 -0500
X-MC-Unique: wSNQmkLbMAOfiiQjLDy1ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742411005E49;
        Mon, 11 Jan 2021 16:55:39 +0000 (UTC)
Received: from [10.36.115.103] (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04E535D9DB;
        Mon, 11 Jan 2021 16:55:37 +0000 (UTC)
Subject: Re: [PATCH 4/5] powerpc/memhotplug: Enable MHP_MEMMAP_ON_MEMORY when
 supported
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-5-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a8fc4fb8-5c88-35a4-4cd7-8cea818acd3a@redhat.com>
Date:   Mon, 11 Jan 2021 17:55:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217130758.11565-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 7efe6ec5d14a..a7f68e282ec1 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -610,6 +610,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
>  
>  static int dlpar_add_lmb(struct drmem_lmb *lmb)
>  {
> +	mhp_t mhp_flags = MHP_NONE;
>  	unsigned long block_sz;
>  	int nid, rc;
>  
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

With 16MB LMBs it's quite wasteful - you won't even have a huge page
fitting the the remaining part.

I do wonder if we want this on powerpc only with a bigger LMB/memory
block size (e.g., 256 MB, which is AFAIK the maximum usually found).

-- 
Thanks,

David / dhildenb


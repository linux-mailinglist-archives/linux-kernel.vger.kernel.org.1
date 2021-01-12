Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8012F2BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbhALJsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388625AbhALJsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610444815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvyJnSq10lv34KzIUsMYXdt+Iwqvb+rfS/2QN/Oiz50=;
        b=Gwcf7vT9zsJD2Q5agrog1msmuVsMGAW/NXj89/JZgAl0b5loUE3eyehVq01Q33X6M1tUtc
        CjnHWhIiLKfFVK3/HaqXAXVnG3+edrX5uxI5MfTGGorTsi6aLQSBk1JWNXzlL57YEAF29A
        BoAqCna9Pg8YAcgny3pbE/ThR5ZtbRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-X3MvMTgaPCm-Vt0DpjGlVA-1; Tue, 12 Jan 2021 04:46:45 -0500
X-MC-Unique: X3MvMTgaPCm-Vt0DpjGlVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C362107ACF7;
        Tue, 12 Jan 2021 09:46:44 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBD8960BE2;
        Tue, 12 Jan 2021 09:46:42 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] mm: Move pfn_to_online_page() out of line
To:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044408207.1482714.1125458890762969867.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a85a1fa0-4ad8-ee63-eab0-de73bc532431@redhat.com>
Date:   Tue, 12 Jan 2021 10:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161044408207.1482714.1125458890762969867.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 10:34, Dan Williams wrote:
> pfn_to_online_page() is already too large to be a macro or an inline
> function. In anticipation of further logic changes / growth, move it out
> of line.
> 
> No functional change, just code movement.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Reported-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/memory_hotplug.h |   17 +----------------
>  mm/memory_hotplug.c            |   16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 15acce5ab106..3d99de0db2dd 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -16,22 +16,7 @@ struct resource;
>  struct vmem_altmap;
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -/*
> - * Return page for the valid pfn only if the page is online. All pfn
> - * walkers which rely on the fully initialized page->flags and others
> - * should use this rather than pfn_valid && pfn_to_page
> - */
> -#define pfn_to_online_page(pfn)					   \
> -({								   \
> -	struct page *___page = NULL;				   \
> -	unsigned long ___pfn = pfn;				   \
> -	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
> -								   \
> -	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> -	    pfn_valid_within(___pfn))				   \
> -		___page = pfn_to_page(___pfn);			   \
> -	___page;						   \
> -})
> +struct page *pfn_to_online_page(unsigned long pfn);
>  
>  /*
>   * Types for free bootmem stored in page->lru.next. These have to be in
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f9d57b9be8c7..55a69d4396e7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -300,6 +300,22 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  	return 0;
>  }
>  
> +/*
> + * Return page for the valid pfn only if the page is online. All pfn
> + * walkers which rely on the fully initialized page->flags and others
> + * should use this rather than pfn_valid && pfn_to_page
> + */
> +struct page *pfn_to_online_page(unsigned long pfn)
> +{
> +	unsigned long nr = pfn_to_section_nr(pfn);
> +
> +	if (nr < NR_MEM_SECTIONS && online_section_nr(nr) &&
> +	    pfn_valid_within(pfn))
> +		return pfn_to_page(pfn);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pfn_to_online_page);
> +
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


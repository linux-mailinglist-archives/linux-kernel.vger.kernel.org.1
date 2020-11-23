Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299512C0CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgKWOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50221 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729652AbgKWOIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606140504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUFzzbljONitOgcLEsp2ObXM969hWXj1Vl6yGCwoRQg=;
        b=TR9LFZA/b1sKHRWBbK+q/6lwf2REia7mug2Tegn4vyWSSpw1K4cGSzJ0vREx/Qa+XvZEBf
        Ku+hLvJawqRUnrnVLMdZ09QOn93yxJ+D3CctE516p+hXVKelmLBHkCm60QBPpS40fAcxav
        ybe2Jk2A7ijE6mnnlYfDxDv1NfMKaKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-VQsyr_QwP4-uPr5e20dvKg-1; Mon, 23 Nov 2020 09:08:19 -0500
X-MC-Unique: VQsyr_QwP4-uPr5e20dvKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6456C1005E48;
        Mon, 23 Nov 2020 14:08:18 +0000 (UTC)
Received: from [10.36.114.57] (ovpn-114-57.ams2.redhat.com [10.36.114.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46E7960864;
        Mon, 23 Nov 2020 14:08:17 +0000 (UTC)
Subject: Re: [PATCH] mm: memory_hotplug: put migration failure information
 under DEBUG_VM
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, mhocko@suse.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9e2b8ee5-62b5-4f38-207e-b68b615e304d@redhat.com>
Date:   Mon, 23 Nov 2020 15:08:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606140196-6053-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.20 15:03, Charan Teja Reddy wrote:
> When the pages are failed to get isolate or migrate, the page owner
> information along with page info is dumped. If there are continuous
> failures in migration(say page is pinned) or isolation, the log buffer
> is simply getting flooded with the page owner information. As most of
> the times page info is sufficient to know the causes for failures of
> migration or isolation, place the page owner information under DEBUG_VM.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  mm/memory_hotplug.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 63b2e46..f48f30d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1326,7 +1326,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  
>  		} else {
>  			pr_warn("failed to isolate pfn %lx\n", pfn);
> -			dump_page(page, "isolation failed");
> +			__dump_page(page, "isolation failed");
> +#if defined(CONFIG_DEBUG_VM)
> +			dump_page_owner(page);
> +#endif
>  		}
>  		put_page(page);
>  	}
> @@ -1357,7 +1360,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  			list_for_each_entry(page, &source, lru) {
>  				pr_warn("migrating pfn %lx failed ret:%d ",
>  				       page_to_pfn(page), ret);
> -				dump_page(page, "migration failure");
> +				__dump_page(page, "migration failure");
> +#if defined(CONFIG_DEBUG_VM)
> +				dump_page_owner(page);
> +#endif
>  			}
>  			putback_movable_pages(&source);
>  		}
> 

It might also make sense to provide an explicit opt-in whether to
pr_warn/dump at all. Most user simply don't care, yet dmesg gets flooded.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


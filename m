Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF292C3B46
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKYInZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgKYInY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606293803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N93NFv+QhCA3XMmTHrAh58uwiNRDLvVPzbJi0yWYW9U=;
        b=gckbb1IfjZMU1L8d45V1soWPXkCrsvw1bMe5r6UM+6muF+cRM1Gv5G0BLGWgxIfynbt86P
        02TRFjt42gyo23fa1fURzSG2wKfg+DVjKtSB1mQj2MB1lB37tcIsTOwnwHj1K1qW2Ls/J4
        fZpYigBG4wzEIODLIov2Z85AIKF1V8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-99JoqyLYNfWIOPZifwxV5A-1; Wed, 25 Nov 2020 03:43:19 -0500
X-MC-Unique: 99JoqyLYNfWIOPZifwxV5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3B57107ACE6;
        Wed, 25 Nov 2020 08:43:17 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B9A519C46;
        Wed, 25 Nov 2020 08:43:16 +0000 (UTC)
Subject: Re: [PATCH 1/2] sparc: Fix handling of page table constructor failure
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     davem@davemloft.net, rppt@kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20201125034655.27687-1-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b761abc9-12de-f003-b8c4-26e7e506700e@redhat.com>
Date:   Wed, 25 Nov 2020 09:43:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125034655.27687-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 04:46, Matthew Wilcox (Oracle) wrote:
> The page has just been allocated, so its refcount is 1.  free_unref_page()
> is for use on pages which have a zero refcount.  Use __free_page()
> like the other implementations of pte_alloc_one().
> 
> Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/sparc/mm/init_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 96edf64d4fb3..182bb7bdaa0a 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2894,7 +2894,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  	if (!page)
>  		return NULL;
>  	if (!pgtable_pte_page_ctor(page)) {
> -		free_unref_page(page);
> +		__free_page(page);
>  		return NULL;
>  	}
>  	return (pte_t *) page_address(page);
> 

I wonder if reusing __pte_alloc_one() - e.g., internally - would be even
cleaner.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


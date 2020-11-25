Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838702C3B47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKYInp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgKYInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606293824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iCA0NoplkuY0wv1lgLVwIs8tVQk43X2rCmw/7XtS8LM=;
        b=MFz+n78RLoxstRPPL+XKFC7qPANtX5Tx91dMeP46sAEJG8xuKaJ6O3PqQf8Lqkk/iw7OTv
        JzcZR/+CiLvq/OGRIZigVwR94Z6Qrw5al71LIlTafgzD8qUKhAA9wfEWDzTHOv2EGAK1d6
        MS3h/iFyHUN52wG09RI2O4Ptz6OVZus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-9f3Pk5vpMMCdH6epfp_sSA-1; Wed, 25 Nov 2020 03:43:41 -0500
X-MC-Unique: 9f3Pk5vpMMCdH6epfp_sSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BBA2180E46E;
        Wed, 25 Nov 2020 08:43:40 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF88060BE5;
        Wed, 25 Nov 2020 08:43:38 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm: Move free_unref_page to mm/internal.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     davem@davemloft.net, rppt@kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20201125034655.27687-1-willy@infradead.org>
 <20201125034655.27687-2-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4e989b22-a144-3778-6d71-f04137a523e4@redhat.com>
Date:   Wed, 25 Nov 2020 09:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125034655.27687-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 04:46, Matthew Wilcox (Oracle) wrote:
> Code outside mm/ should not be calling free_unref_page().  Also
> move free_unref_page_list().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/gfp.h | 2 --
>  mm/internal.h       | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..6e479e9c48ce 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -580,8 +580,6 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
>  
>  extern void __free_pages(struct page *page, unsigned int order);
>  extern void free_pages(unsigned long addr, unsigned int order);
> -extern void free_unref_page(struct page *page);
> -extern void free_unref_page_list(struct list_head *list);
>  
>  struct page_frag_cache;
>  extern void __page_frag_cache_drain(struct page *page, unsigned int count);
> diff --git a/mm/internal.h b/mm/internal.h
> index 75ae680d0a2c..5864815947fe 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -201,6 +201,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
>  extern int user_min_free_kbytes;
>  
> +extern void free_unref_page(struct page *page);
> +extern void free_unref_page_list(struct list_head *list);
> +
>  extern void zone_pcp_update(struct zone *zone);
>  extern void zone_pcp_reset(struct zone *zone);
>  extern void zone_pcp_disable(struct zone *zone);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


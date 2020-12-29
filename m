Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE752E6F48
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgL2JSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:18:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgL2JR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609233392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRqi06XLW/oYwq/HT/wMRGGZLkj3eNNLdOVuy8LBVMM=;
        b=W0v0zSD6uPJmCrNO2MKxOJAurSuVh9xeSvv5gHhvV0VSgjOC61PSkZ8K+Zv69M4/XHWwSU
        oOkp3Zueq6ggS0LPJxU/YDNfETJPjSM0Wfw9SJs1QUC6fn3T8pjhxcbJ70WVLewsc2p46u
        Jc2lIV/0X2FyY7dzQ93Lw0gVsmmlvxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-CvrpukNGPGqFpyGDVU8HrA-1; Tue, 29 Dec 2020 04:16:28 -0500
X-MC-Unique: CvrpukNGPGqFpyGDVU8HrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 323B01005E62;
        Tue, 29 Dec 2020 09:16:27 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5484F1349A;
        Tue, 29 Dec 2020 09:16:26 +0000 (UTC)
Subject: Re: [PATCH] mm/page_reporting: use list_entry_is_head() in
 page_reporting_cycle()
To:     sh <sh_def@163.com>, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201222182735.GA1257912@ubuntu-A520I-AC>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3897f709-3bc8-2204-5e85-09790779e292@redhat.com>
Date:   Tue, 29 Dec 2020 10:16:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201222182735.GA1257912@ubuntu-A520I-AC>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.20 19:27, sh wrote:
> replace '&next->lru != list' with list_entry_is_head().
> No functional change.
> 
> Signed-off-by: sh <sh_def@163.com>
> ---
>  mm/page_reporting.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index cd8e13d41df4..c50d93ffa252 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -211,7 +211,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>  	}
>  
>  	/* Rotate any leftover pages to the head of the freelist */
> -	if (&next->lru != list && !list_is_first(&next->lru, list))
> +	if (!list_entry_is_head(next, list, lru) && !list_is_first(&next->lru, list))
>  		list_rotate_to_front(&next->lru, list);
>  
>  	spin_unlock_irq(&zone->lock);
> 

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


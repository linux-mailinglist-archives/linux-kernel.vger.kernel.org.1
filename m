Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B282CDB37
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgLCQ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgLCQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607012832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKLnCPWi5C0uhOXWYAhcEf6SIUd8pMCmc8cjsrwC2Vw=;
        b=KWMt9Y4zkjqe+04aFI9oUv+AHfUZQimWGAHPkc5+oMYK8soOyzIVTq6yPfIUdej2E7io9i
        qt62NT/yDGtxBP1+znW+xRUa8V7CtdN4rs/4ibm3xZ1i4hH1jFI0jMddQjd47L+/rYN6zf
        x+InUhR1v53JYnaoYG+iryWiE2Ynz/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-cTAmb5S7OcWbeNkMp5F9Fg-1; Thu, 03 Dec 2020 11:27:10 -0500
X-MC-Unique: cTAmb5S7OcWbeNkMp5F9Fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06961425F7;
        Thu,  3 Dec 2020 16:27:09 +0000 (UTC)
Received: from [10.36.113.250] (ovpn-113-250.ams2.redhat.com [10.36.113.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214585D730;
        Thu,  3 Dec 2020 16:27:07 +0000 (UTC)
Subject: Re: [PATCH] mm/page_isolation: do not isolate the max order page
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201202122114.75316-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ddd62925-fff5-4e0b-399a-ca1b70ac202b@redhat.com>
Date:   Thu, 3 Dec 2020 17:27:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202122114.75316-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.20 13:21, Muchun Song wrote:
> The max order page has no buddy page and never merge to other order.
> So isolating and then freeing it is pointless.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index a254e1f370a3..bddf788f45bf 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -88,7 +88,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>  	 */
>  	if (PageBuddy(page)) {
>  		order = buddy_order(page);
> -		if (order >= pageblock_order) {
> +		if (order >= pageblock_order && order < MAX_ORDER - 1) {
>  			pfn = page_to_pfn(page);
>  			buddy_pfn = __find_buddy_pfn(pfn, order);
>  			buddy = page + (buddy_pfn - pfn);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


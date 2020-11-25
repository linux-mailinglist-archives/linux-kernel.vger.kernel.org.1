Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23702C456F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbgKYQjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730247AbgKYQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606322385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ScC2iD5+F6+dcEymW2ZVsRHtouJI90gVvqKnZPqZNY=;
        b=UaFwPiR3ZWkiCktkWjvkqIyH+W7ltc+pdZ+3Iz7rg5giXkD/yYERLNsXJkgR5/QM9lTlRY
        46rnyxhwZjun3WqoymNVA4FhG+afVDsTcEQ4rEEN7ti9WwApFTcfh+RP6W4K2NrZveE8/F
        OqI2E3Mc2+c/J5Jb4oeIhXMwKVuTBCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Gfuy4hdzNBSVKthwn4r-AQ-1; Wed, 25 Nov 2020 11:39:41 -0500
X-MC-Unique: Gfuy4hdzNBSVKthwn4r-AQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA52A911E2;
        Wed, 25 Nov 2020 16:39:39 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408535D71F;
        Wed, 25 Nov 2020 16:39:38 +0000 (UTC)
Subject: Re: [PATCH] mm: cma: improve pr_debug log in cma_release()
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1606318341-29521-1-git-send-email-charante@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9bde4b9a-58e4-b756-af45-1559fc06dcd4@redhat.com>
Date:   Wed, 25 Nov 2020 17:39:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606318341-29521-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 16:32, Charan Teja Reddy wrote:
> It is required to print 'count' of pages, along with the pages, passed
> to cma_release to debug the cases of mismatched count value passed
> between cma_alloc() and cma_release() from a code path.
> 
> As an example, consider the below scenario:
> 1) CMA pool size is 4MB and
> 2) User doing the erroneous step of allocating 2 pages but freeing 1
> page in a loop from this CMA pool.
> The step 2 causes cma_alloc() to return NULL at one point of time
> because of -ENOMEM condition.
> 
> And the current pr_debug logs is not giving the info about these types
> of allocation patterns because of count value not being printed in
> cma_release().
> 
> We are printing the count value in the trace logs, just extend the same
> to pr_debug logs too.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 7f415d7..07c904b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -512,7 +512,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>  	if (!cma || !pages)
>  		return false;
>  
> -	pr_debug("%s(page %p)\n", __func__, (void *)pages);
> +	pr_debug("%s(page %p, count %zu)\n", __func__, (void *)pages, count);
>  
>  	pfn = page_to_pfn(pages);
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


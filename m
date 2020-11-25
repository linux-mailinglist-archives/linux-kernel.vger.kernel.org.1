Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF42C4118
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgKYNYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:24:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbgKYNYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606310676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yfYwxxCydXD+/2AZjU2DkkyQyPi22Qxb5NijBr+uWj0=;
        b=buaKMa9LH2B/JAFH3DvwrODNEmKuzJTAeLfIPNzJxmkZZ7D6wFD4MHAygFrKduTPk20MXR
        OLiNvAgKWudKQ8zM1h1NCPTdRU8pt2UqOeytyePltQCNnoeoO+0iZYRa1bQygMN00In81r
        n+kU2141a5qUN4xBcX2GKhkh4U14Jbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-I-oSW_vvNE2vnVfTOlFbYw-1; Wed, 25 Nov 2020 08:24:33 -0500
X-MC-Unique: I-oSW_vvNE2vnVfTOlFbYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94DC080EDA9;
        Wed, 25 Nov 2020 13:24:31 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 210F15D6AC;
        Wed, 25 Nov 2020 13:24:29 +0000 (UTC)
Subject: Re: [PATCH 1/2] sparc: Fix handling of page table constructor failure
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, davem@davemloft.net, rppt@kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201125034655.27687-1-willy@infradead.org>
 <b761abc9-12de-f003-b8c4-26e7e506700e@redhat.com>
 <20201125121037.GJ4327@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5b574e0d-107a-3ebc-d631-b59e88de7174@redhat.com>
Date:   Wed, 25 Nov 2020 14:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125121037.GJ4327@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.20 13:10, Matthew Wilcox wrote:
> On Wed, Nov 25, 2020 at 09:43:15AM +0100, David Hildenbrand wrote:
>> On 25.11.20 04:46, Matthew Wilcox (Oracle) wrote:
>>> The page has just been allocated, so its refcount is 1.  free_unref_page()
>>> is for use on pages which have a zero refcount.  Use __free_page()
>>> like the other implementations of pte_alloc_one().
>>>
>>> Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>  arch/sparc/mm/init_64.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
>>> index 96edf64d4fb3..182bb7bdaa0a 100644
>>> --- a/arch/sparc/mm/init_64.c
>>> +++ b/arch/sparc/mm/init_64.c
>>> @@ -2894,7 +2894,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>>>  	if (!page)
>>>  		return NULL;
>>>  	if (!pgtable_pte_page_ctor(page)) {
>>> -		free_unref_page(page);
>>> +		__free_page(page);
>>>  		return NULL;
>>>  	}
>>>  	return (pte_t *) page_address(page);
>>>
>>
>> I wonder if reusing __pte_alloc_one() - e.g., internally - would be even
>> cleaner.
> 
> It's really awkward to do because pgtable_t is defined differently.
> The clean thing to do would be:
> 
> --- arch/sparc/include/asm/page_64.h
> -typedef pte_t *pgtable_t;
> +typedef struct page *pgtable_t;
> 
> and then do all the other changes that would require.
> 
> But that feels like a lot more work than appropriate to fix this
> unlikely bug.

Yeah, cleanups would have to come on top of the fix of course. But I can
understand that you have plenty of better things to do :) ... maybe
sparc people want to work on that at one point.

-- 
Thanks,

David / dhildenb


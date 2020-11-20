Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBD2BA627
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgKTJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgKTJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605864540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+Bg7OZiMcMWbLJ0Zu02Ir+OOGBOpz1hEeMPWxEu3Og=;
        b=ZwDOdbXS80TMmjORIN4oeSFManLYfSXPKstP665EG2PsPizG7jlPd6I8lVito8waqa9795
        J/tJpO+w2lHcoUTRwIpCKbuJjpnPE2hL4Imu5zGhr5/lKrFxqkxmmazEPKpmUq72Xu7IJC
        vmx8M4mZ4PdWxjN/hXwD7RMci2OgNjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-qqn5Z1YiOUSELYr-8soHaQ-1; Fri, 20 Nov 2020 04:28:55 -0500
X-MC-Unique: qqn5Z1YiOUSELYr-8soHaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DEDF873163;
        Fri, 20 Nov 2020 09:28:54 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42CF85D9C6;
        Fri, 20 Nov 2020 09:28:53 +0000 (UTC)
Subject: Re: [PATCH] mm,hugetlb: Remove unneded initialization
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201119112141.6452-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <e969f1b4-bc9c-03dc-5e26-8b514ac90edf@redhat.com>
Date:   Fri, 20 Nov 2020 10:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201119112141.6452-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.20 12:21, Oscar Salvador wrote:
> hugetlb_add_hstate initializes nr_huge_pages and free_huge_pages to 0,
> but since hstates[] is a global variable, all its fields are defined to
> 0 already.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   mm/hugetlb.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 37f15c3c24dc..1c69e9044887 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3197,8 +3197,6 @@ void __init hugetlb_add_hstate(unsigned int order)
>   	h = &hstates[hugetlb_max_hstate++];
>   	h->order = order;
>   	h->mask = ~((1ULL << (order + PAGE_SHIFT)) - 1);
> -	h->nr_huge_pages = 0;
> -	h->free_huge_pages = 0;
>   	for (i = 0; i < MAX_NUMNODES; ++i)
>   		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
>   	INIT_LIST_HEAD(&h->hugepage_activelist);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


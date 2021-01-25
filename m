Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789A3302633
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbhAYOSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:18:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729256AbhAYOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611583771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tk4eS0Y2Vo2oPY0Z4JxAQzLc8itlAhOCREG8ddZvOI=;
        b=SPutpDpkrVGS4v14VwG3C2qD8JKbaKn0rO1zKPXv5ZQqhg4fnZsBwlWgge1YbyEJrK1m0h
        8E9reNeW36wOH8G18Q1SfR5nYmaE4ScqzPlAl3bd3447F6n8QZlPHGL92hAGUP+WLy8fnu
        jg+wBU32QNGbu8Iz6McDc8wVDbjhEL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-SQGrC9dfPNiAj-kd1C9gig-1; Mon, 25 Jan 2021 09:09:29 -0500
X-MC-Unique: SQGrC9dfPNiAj-kd1C9gig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03975180A0A5;
        Mon, 25 Jan 2021 14:09:28 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-163.rdu2.redhat.com [10.10.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13F365D731;
        Mon, 25 Jan 2021 14:09:26 +0000 (UTC)
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210125042441.20030-1-longman@redhat.com>
 <20210125043631.GD308988@casper.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1f234e4f-be0d-ecf9-7934-4be3de0d6fe5@redhat.com>
Date:   Mon, 25 Jan 2021 09:09:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210125043631.GD308988@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/21 11:36 PM, Matthew Wilcox wrote:
> On Sun, Jan 24, 2021 at 11:24:41PM -0500, Waiman Long wrote:
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 5c9d564317a5..aa0e0fb04670 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -835,6 +835,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
>>   	XA_STATE(xas, &mapping->i_pages, offset);
>>   	int huge = PageHuge(page);
>>   	int error;
>> +	bool charged = false;
> I don't think we need this extra bool.
>
>> @@ -896,6 +898,8 @@ noinline int __add_to_page_cache_locked(struct page *page,
>>   
>>   	if (xas_error(&xas)) {
>>   		error = xas_error(&xas);
>> +		if (charged)
>> +			mem_cgroup_uncharge(page);
>>   		goto error;
>>   	}
> Better:
>
> -		goto error;
> +		goto uncharge;
> ...
> +uncharge:
> +	if (!huge)
> +		mem_cgroup_uncharge(page);
>   error:
> ...
>
That was my original plan. After finding out there was a potentially 
conflicting patch in linux-next:

commit 7a02fa97b897 ("secretmem: add memcg accounting")

@@ -839,7 +840,7 @@ noinline int __add_to_page_cache_locked(struct page 
*page,
         page->mapping = mapping;
         page->index = offset;

-       if (!huge) {
+       if (!huge && !page_is_secretmem(page)) {
                 error = mem_cgroup_charge(page, current->mm, gfp);
                 if (error)
                         goto error;

Adding a boolean is an easy way out without conflicting it.

Cheers,
Longman


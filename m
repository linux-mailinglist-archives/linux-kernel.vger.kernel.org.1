Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA28F2F7490
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbhAOItR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbhAOItQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610700469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7+3aFpRnpA/Vn6XuyDfHSEJMgBWrcsXLf+cf+V33kME=;
        b=ZRUex7LUyfN6+/GcmBlheTDjrPvXoPhL6duYZDIIvN9o+8LDwxzh2mbfnxeC4PZEbQLjH6
        b8yzi3wfkQwb4vLnibQVyp90eQmerod6AeEmc7R/IjfJ+0vuC914ylfO9yF4ZeCkqUxx0u
        tq+PFouWWWuFm5jJY5hoRwksHVibrfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-o8zcdaJIPFejOLZrNvxqZQ-1; Fri, 15 Jan 2021 03:47:48 -0500
X-MC-Unique: o8zcdaJIPFejOLZrNvxqZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB33D1DDE0;
        Fri, 15 Jan 2021 08:47:46 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC5FD60C6B;
        Fri, 15 Jan 2021 08:47:45 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: avoid unnecessary hugetlb_acct_memory() call
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210114113140.23069-1-linmiaohe@huawei.com>
 <853d6aa4-b84c-7ac2-00d4-402893fcf6b3@redhat.com>
 <b7587d72-fb5b-4e0f-4fa0-d63e035e521c@oracle.com>
 <9841241e-eb8f-9b49-8d2d-d84effda8ba4@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d5ea6179-7e0d-7727-50d2-efa694ba84b3@redhat.com>
Date:   Fri, 15 Jan 2021 09:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <9841241e-eb8f-9b49-8d2d-d84effda8ba4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.21 03:04, Miaohe Lin wrote:
> Hi:
> 
> On 2021/1/15 3:16, Mike Kravetz wrote:
>> On 1/14/21 4:32 AM, David Hildenbrand wrote:
>>> On 14.01.21 12:31, Miaohe Lin wrote:
>>>> When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
>>>> and releasing hugetlb_lock.
>>>
>>> So, what's the deal then? Adding more code?
>>>
>>> If this is a performance improvement, we should spell it out. Otherwise
>>> I don't see a real benefit of this patch.
>>>
>>
>> Thanks for finding/noticing this.
>>
>> As David points out, the commit message should state that this is a
>> performance improvement.  Mention that such a change avoids an unnecessary
>> hugetlb_lock lock/unlock cycle.  You can also mention that this unnecessary
>> lock cycle is happening on 'most' hugetlb munmap operations.
>>
> 
> My bad. I should spell this out explicitly. Many thanks for both of you.

With the "lock cycle is happening on 'most' hugetlb munmap operations"
part added

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb


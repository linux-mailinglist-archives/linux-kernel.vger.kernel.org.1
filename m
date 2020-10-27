Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC89D29BD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811667AbgJ0Qkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1764051AbgJ0Poo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603813483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyLKTZmrav8/jKwoRRJvE881iIOZpv4FNe8qMkz/2ls=;
        b=F3jH9qt/+Xxasq3W7hJ6uxnIp8fIIbCrJ5xvdrzYHGghGqR5Xnw5UeT7hPpc1cL3xvBVN6
        EZUFnF+AmVnH6Z+z4SCQ5Pnhvkjf6OkFIXYNaMxXVtNyWGNKLxTe+hU3OijKC4TanJmmjf
        asNOzD1NcIOTWkr06KV7o5b7EZ//T3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-UhViin-wN-SW6I-5ICq8Wg-1; Tue, 27 Oct 2020 11:44:37 -0400
X-MC-Unique: UhViin-wN-SW6I-5ICq8Wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43BA257206;
        Tue, 27 Oct 2020 15:44:36 +0000 (UTC)
Received: from [10.36.113.185] (ovpn-113-185.ams2.redhat.com [10.36.113.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0BC65D9DD;
        Tue, 27 Oct 2020 15:44:34 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] Allocate memmap from hotadded memory (per device)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
 <3c18e078-25df-3fd4-9988-1b7677d8e05f@redhat.com>
 <20201027154031.GA11489@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <daedbc08-7275-40ad-0d07-007ef89ca25f@redhat.com>
Date:   Tue, 27 Oct 2020 16:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201027154031.GA11489@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.20 16:40, Oscar Salvador wrote:
> On Thu, Oct 22, 2020 at 03:01:44PM +0200, David Hildenbrand wrote:
>>> This does not go without saying that the patchset is not 100% complete.
>>> It is missing:
>>>
>>>   - a way to disable memmap_on_memory (either sysfs or boot_time cmd)
>>>   - atm, arch_add_memory for s390 screams if an altmap is passed.
>>>     I am still thinking of a way to nicely drop handle that.
>>>     Maybe a function in s390 that sets memmap_on_memory false and
>>>     stuff that check in support_memmap_on_memory function.
>>
>> Or simply implement altmap support ... shouldn't be too hard :)
> 
> Yeah, I guess so, but first I would like to have everything else settled.
> So, gentle ping :-)
> 

I'm planning on looking into patch #2/3 later this or next week (this 
week is open source summit / KVM Forum).

One thing to look into right now is how to make this fly this with 
vmemmap optimizations for hugetlb pages.

https://lkml.kernel.org/r/20201026145114.59424-1-songmuchun@bytedance.com

-- 
Thanks,

David / dhildenb


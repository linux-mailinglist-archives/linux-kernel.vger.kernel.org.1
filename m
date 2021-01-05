Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C62EA8AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbhAEK2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:28:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728951AbhAEK2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609842445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnN5IEGJ/23g6PIWT40J6HpSWq+j0GIc1IYqRwgM3sQ=;
        b=LuOQ7TAg15O5qOnteL2ucP72YPJTou6IBOs8Ta7uCirk+nqEL4qlhXgV7oWQaFmKHbKdVE
        nYRbHrO1l1eXS3uUFpAFuu1pK5pmS6b7avQMsS7ct8StLKpmLNCrskBswfP9L/8WM8Kx57
        ev/5DbqXAMa0NbApeOD08ghtqLy2gSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-OgiryqcPOmOX81V2EvMReg-1; Tue, 05 Jan 2021 05:27:24 -0500
X-MC-Unique: OgiryqcPOmOX81V2EvMReg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162F71572B;
        Tue,  5 Jan 2021 10:27:22 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B72D770959;
        Tue,  5 Jan 2021 10:27:11 +0000 (UTC)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Liang Li <liliang324@gmail.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
References: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
 <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com>
 <CA+2MQi_O47B8zOa_TwZqzRsS0LFoPS77+61mUV=yT1U3sa6xQw@mail.gmail.com>
 <eea984f8-dbff-35d3-2c93-db8dc4b700c5@redhat.com>
 <CA+2MQi9Qb5srEcx4qKNVWdphBGP0=HHV_h0hWghDMFKFmCOTMg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <85f16139-b499-dd02-f2bc-c3c42d57ccd8@redhat.com>
Date:   Tue, 5 Jan 2021 11:27:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi9Qb5srEcx4qKNVWdphBGP0=HHV_h0hWghDMFKFmCOTMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 11:22, Liang Li wrote:
>>>> That‘s mostly already existing scheduling logic, no? (How many vms can I put onto a specific machine eventually)
>>>
>>> It depends on how the scheduling component is designed. Yes, you can put
>>> 10 VMs with 4C8G(4CPU, 8G RAM) on a host and 20 VMs with 2C4G on
>>> another one. But if one type of them, e.g. 4C8G are sold out, customers
>>> can't by more 4C8G VM while there are some free 2C4G VMs, the resource
>>> reserved for them can be provided as 4C8G VMs
>>>
>>
>> 1. You can, just the startup time will be a little slower? E.g., grow
>> pre-allocated 4G file to 8G.
>>
>> 2. Or let's be creative: teach QEMU to construct a single
>> RAMBlock/MemoryRegion out of multiple tmpfs files. Works as long as you
>> don't go crazy on different VM sizes / size differences.
>>
>> 3. In your example above, you can dynamically rebalance as VMs are
>> getting sold, to make sure you always have "big ones" lying around you
>> can shrink on demand.
>>
> Yes, we can always come up with some ways to make things work.
> it will make the developer of the upper layer component crazy :)

I'd say that's life in upper layers to optimize special (!) use cases. :)

>>>
>>> You must know there are a lot of functions in the kernel which can
>>> be done in userspace. e.g. Some of the device emulations like APIC,
>>> vhost-net backend which has userspace implementation.   :)
>>> Bad or not depends on the benefits the solution brings.
>>> From the viewpoint of a user space application, the kernel should
>>> provide high performance memory management service. That's why
>>> I think it should be done in the kernel.
>>
>> As I expressed a couple of times already, I don't see why using
>> hugetlbfs and implementing some sort of pre-zeroing there isn't sufficient.
> 
> Did I miss something before? I thought you doubt the need for
> hugetlbfs free page pre zero out. Hugetlbfs is a good choice and is
> sufficient.

I remember even suggesting to focus on hugetlbfs during your KVM talk
when chatting. Maybe I was not clear before.

> 
>> We really don't *want* complicated things deep down in the mm core if
>> there are reasonable alternatives.
>>
> I understand your concern, we should have sufficient reason to add a new
> feature to the kernel. And for this one, it's most value is to make the
> application's life is easier. And implementing it in hugetlbfs can avoid
> adding more complexity to core MM.

Exactly, that's my point. Some people might still disagree with the
hugetlbfs approach, but there it's easier to add tunables without
affecting the overall system.

-- 
Thanks,

David / dhildenb


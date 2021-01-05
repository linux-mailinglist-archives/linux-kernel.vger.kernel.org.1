Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEDC2EA7C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbhAEJlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbhAEJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609839581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9GY3k7qYcAOAzWTuR5xc+9LJ5x2f7CmJLEuHkNfjAg=;
        b=fe+L2nHDYdahbHU2z1b7UfeCzI78ytMDKMDIg6Mwh/dlbeKkrSSLb2cuOZfZTJYKa6748F
        Da+5OX0F4V6cQmPxSIj62yNzPN9QIOruXG83m/aCD/4xSmPN3m+irvuebm1nGGlMR3hMFB
        GsR2EYUvGn6iQWjPl8ng9wir/dCHuf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-J0kE12EeOROLHktCQJ6qww-1; Tue, 05 Jan 2021 04:39:39 -0500
X-MC-Unique: J0kE12EeOROLHktCQJ6qww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0EB0800D62;
        Tue,  5 Jan 2021 09:39:36 +0000 (UTC)
Received: from [10.36.114.117] (ovpn-114-117.ams2.redhat.com [10.36.114.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28F0E60873;
        Tue,  5 Jan 2021 09:39:26 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eea984f8-dbff-35d3-2c93-db8dc4b700c5@redhat.com>
Date:   Tue, 5 Jan 2021 10:39:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi_O47B8zOa_TwZqzRsS0LFoPS77+61mUV=yT1U3sa6xQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 03:14, Liang Li wrote:
>>>>> In our production environment, there are three main applications have such
>>>>> requirement, one is QEMU [creating a VM with SR-IOV passthrough device],
>>>>> anther other two are DPDK related applications, DPDK OVS and SPDK vhost,
>>>>> for best performance, they populate memory when starting up. For SPDK vhost,
>>>>> we make use of the VHOST_USER_GET/SET_INFLIGHT_FD feature for
>>>>> vhost 'live' upgrade, which is done by killing the old process and
>>>>> starting a new
>>>>> one with the new binary. In this case, we want the new process started as quick
>>>>> as possible to shorten the service downtime. We really enable this feature
>>>>> to speed up startup time for them  :)
>>
>> Am I wrong or does using hugeltbfs/tmpfs ... i.e., a file not-deleted between shutting down the old instances and firing up the new instance just solve this issue?
> 
> You are right, it works for the SPDK vhost upgrade case.
> 
>>
>>>>
>>>> Thanks for info on the use case!
>>>>
>>>> All of these use cases either already use, or could use, huge pages
>>>> IMHO. It's not your ordinary proprietary gaming app :) This is where
>>>> pre-zeroing of huge pages could already help.
>>>
>>> You are welcome.  For some historical reason, some of our services are
>>> not using hugetlbfs, that is why I didn't start with hugetlbfs.
>>>
>>>> Just wondering, wouldn't it be possible to use tmpfs/hugetlbfs ...
>>>> creating a file and pre-zeroing it from another process, or am I missing
>>>> something important? At least for QEMU this should work AFAIK, where you
>>>> can just pass the file to be use using memory-backend-file.
>>>>
>>> If using another process to create a file, we can offload the overhead to
>>> another process, and there is no need to pre-zeroing it's content, just
>>> populating the memory is enough.
>>
>> Right, if non-zero memory can be tolerated (e.g., for vms usually has to).
> 
> I mean there is no need to pre-zeroing the file content obviously in user space,
> the kernel will do it when populating the memory.
> 
>>> If we do it that way, then how to determine the size of the file? it depends
>>> on the RAM size of the VM the customer buys.
>>> Maybe we can create a file
>>> large enough in advance and truncate it to the right size just before the
>>> VM is created. Then, how many large files should be created on a host?
>>
>> That‘s mostly already existing scheduling logic, no? (How many vms can I put onto a specific machine eventually)
> 
> It depends on how the scheduling component is designed. Yes, you can put
> 10 VMs with 4C8G(4CPU, 8G RAM) on a host and 20 VMs with 2C4G on
> another one. But if one type of them, e.g. 4C8G are sold out, customers
> can't by more 4C8G VM while there are some free 2C4G VMs, the resource
> reserved for them can be provided as 4C8G VMs
> 

1. You can, just the startup time will be a little slower? E.g., grow
pre-allocated 4G file to 8G.

2. Or let's be creative: teach QEMU to construct a single
RAMBlock/MemoryRegion out of multiple tmpfs files. Works as long as you
don't go crazy on different VM sizes / size differences.

3. In your example above, you can dynamically rebalance as VMs are
getting sold, to make sure you always have "big ones" lying around you
can shrink on demand.

> 
> You must know there are a lot of functions in the kernel which can
> be done in userspace. e.g. Some of the device emulations like APIC,
> vhost-net backend which has userspace implementation.   :)
> Bad or not depends on the benefits the solution brings.
> From the viewpoint of a user space application, the kernel should
> provide high performance memory management service. That's why
> I think it should be done in the kernel.

As I expressed a couple of times already, I don't see why using
hugetlbfs and implementing some sort of pre-zeroing there isn't sufficient.

We really don't *want* complicated things deep down in the mm core if
there are reasonable alternatives.

-- 
Thanks,

David / dhildenb


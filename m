Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0808D303675
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387793AbhAZGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35766 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbhAYNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611581971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUR1kdiVhM2we5zSsKmR+IJNxPESBP8a30L7UKGsPr4=;
        b=MrrO7u3ictXm/bJdSO3FyNdGaa5WGE8qaSGCyhnQnglVkmhy5P7T/v6NNvWbqDqDS58npR
        qqt56R8leDLFWr6r6kQeAnN2z+0+AGniXx0LYSm027XTA/0/cYn3rOa1sKTRYSfJ+SNO/Q
        N3bdwy7xHzQ/R5ZPIOaaNaxY9pZ2GTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-uqtLs3PgNEy80gLVFtO7Sw-1; Mon, 25 Jan 2021 06:23:17 -0500
X-MC-Unique: uqtLs3PgNEy80gLVFtO7Sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 851C41005513;
        Mon, 25 Jan 2021 11:23:15 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2611722C1;
        Mon, 25 Jan 2021 11:23:13 +0000 (UTC)
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
 <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
 <20210125103951.GA27851@linux>
 <a0193441-4c79-b85e-ff38-e7ab3a462beb@redhat.com>
 <20210125111816.GB28363@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f2b82be4-2ff2-65f0-5b44-e6fbb7e610c9@redhat.com>
Date:   Mon, 25 Jan 2021 12:23:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210125111816.GB28363@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.21 12:18, Oscar Salvador wrote:
> On Mon, Jan 25, 2021 at 11:57:20AM +0100, David Hildenbrand wrote:
>> I'm confused.
>>
>> 1. Assume we hotplug memory, online it to ZONE_MOVABLE. The vmemmap gets
>> allocated from altmap space.
> 
> The vmemmap could have never been allocated from altmap in case hpage vmemmap
> feature is enabled.
> 
> Have a look at [1].
> If is_hugetlb_free_vmemmap_enabled(), vmemmap_populate() ends up calling
> vmemmap_populate_basepages().

Oh, it calls "vmemmap_populate_basepages(start, end, node, NULL);"

the "NULL" part is the important bit.

> 
> And since no memory was consumed from altmap, and hence altmap_alloc_block_buf()
> was never called, vmem_altmap->alloc will be 0, and memory_block->nr_vmemmap_pages
> will be 0 as well.
> 
> But on a second though, true is that we will get in trouble if hpage vmemmap
> feature ever gets to work with vmemmap_populate_hugepages.
> I will queue that to look in a new future.

This seriously needs comments and documentation. The problem is where to
document as long as one of both series is not merged yet :)

At least in the cover letter, because this is not obvious how both
things will play along.

Thanks!

-- 
Thanks,

David / dhildenb


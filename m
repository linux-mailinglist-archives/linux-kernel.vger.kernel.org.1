Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F82D2665
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgLHIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727895AbgLHIj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607416711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4QTG3wxzq3Tlyw1pNRU0IwLpg2DNf0xUWadB7K3ewQ=;
        b=ITqmliPKKo2/qS9L32PznCeQ1USds01/pHXjUItcBwg1C0cFx5dYP4M/QD7l84OETGssme
        RrMOxDXZ1mVC4NDXp2d1kkSfq6oIOIFHFzEOR4BsEVvOWIqVgrWz6Js8ua/saijb8jNzdy
        OHmfpK/PZH+gNJlrrZyTjM4ycHmMqLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-4fsNP6laM3GAHxcsziU-bg-1; Tue, 08 Dec 2020 03:38:28 -0500
X-MC-Unique: 4fsNP6laM3GAHxcsziU-bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 004FC879511;
        Tue,  8 Dec 2020 08:38:27 +0000 (UTC)
Received: from [10.36.113.236] (ovpn-113-236.ams2.redhat.com [10.36.113.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACFB85C1A1;
        Tue,  8 Dec 2020 08:38:24 +0000 (UTC)
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
 <20201202203233.GB11274@osiris>
 <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com> <20201203115133.GB9994@osiris>
 <4d6c9ec4-f1be-46b9-5d67-5c53f5afedc5@redhat.com>
 <62c60c9e-20d6-25bd-94d0-78bfed0f2476@arm.com>
 <02dfe6f5-efb6-c04d-c34a-a1e7393625cf@redhat.com>
 <9e80ad53-d203-d7d2-3fc8-92fa860bc869@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ec49e677-7992-40d5-ea5b-709e311d76fe@redhat.com>
Date:   Tue, 8 Dec 2020 09:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <9e80ad53-d203-d7d2-3fc8-92fa860bc869@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Both changes only make sense with an in-tree user. I'm planning on using
>> this functionality in virtio-mem code. I can pickup your patches, drop
>> the superfluous checks, and use it from virtio-mem code. Makese sense
>> (BTW, looks like we'll see aarch64 support for virtio-mem soon)?
> 
> I have not been following virtio-mem closely. But is there something pending
> on arm64 platform which prevents virtio-mem enablement ?

Regarding enablement, I expect things to be working out of the box
mostly. Jonathan is currently doing some testing and wants to send a
simple unlock patch once done. [1]


Now, there are some things to improve in the future. virtio-mem
adds/removes individual Linux memory blocks and logically plugs/unplugs
MAX_ORDER - 1/pageblock_order pages inside Linux memory blocks.

1. memblock

On arm64 and powerpc, we create/delete memblocks when adding/removing
memory, which is suboptimal (and the code is quite fragile as we don't
handle errors ...). Hotplugged memory never has holes, so we can tweak
relevant code to not check via the memblock api.

For example, pfn_valid() only has to check for memblock_is_map_memory()
in case of !early_section() - otherwise it can just fallback to our
generic pfn_valid() function.

2. MAX_ORDER - 1 / pageblock_order

With 64k base pages, virtio-mem can only logically plug/unplug in 512MB
granularity, which is sub-optimal and inflexible. 4/2MB would be much
better - however this would require always using 2MB THP on arm64 (IIRC
via "cont" bits). Luckily, only some distributions use 64k base pages as
default nowadays ... :)

3. Section size

virtio-mem benefits from small section sizes. Currently, we have 1G.
With 4k base pages we could easily reduce it to something what x86 has
(128 MB) - and I remember discussions regarding that already in other
(IIRC NVDIMM / DIMM) context. Again, with 64k base pages we cannot go
below 512 MB right now.

[1] https://lkml.kernel.org/r/20201125145659.00004b3e@Huawei.com

-- 
Thanks,

David / dhildenb


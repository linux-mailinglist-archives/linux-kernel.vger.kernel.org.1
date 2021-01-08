Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8EE2EF4DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbhAHPcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbhAHPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610119839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWxbH/EEwDRQhL/kJPvMQX0Ji74HwvfBlAxAy5TRY6E=;
        b=DnLJVPrcZ7T+2BOybQ13cSNqSYrCeT45OwjT9+68x0pWRqHC/jn2qUo5fmSe1xN0fu1Aey
        /BltyCFlW6mYf1G30hUJgTmMf1tsvDbLNfcu/XBCsHtUomQrCW6mOko2GBg46xhu7Awri8
        UEvURxc0CNC2prXvy41i26yWCLuLQNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-mjoiOGY4PHavf52dOOIAJg-1; Fri, 08 Jan 2021 10:30:35 -0500
X-MC-Unique: mjoiOGY4PHavf52dOOIAJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF3F9809DCE;
        Fri,  8 Jan 2021 15:30:33 +0000 (UTC)
Received: from [10.36.114.168] (ovpn-114-168.ams2.redhat.com [10.36.114.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64A4B12D7E;
        Fri,  8 Jan 2021 15:30:32 +0000 (UTC)
Subject: Re: [PATCH 1/1] arm64: make section size configurable for memory
 hotplug
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1609895500.git.sudaraja@codeaurora.org>
 <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
 <055b0aca-af60-12ad-cd68-e15440ade64b@arm.com>
 <d0e627fd-390f-5915-c218-e2137aef3eb4@redhat.com>
 <3ae8c16d-50c4-c6cc-62b8-922cfc308c95@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7939710a-5d03-de2b-73b2-bca472de431a@redhat.com>
Date:   Fri, 8 Jan 2021 16:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <3ae8c16d-50c4-c6cc-62b8-922cfc308c95@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> To summarize, the section size bits for each base page size config
> should always
> 
> a. Avoid (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS

Pageblocks must also always fall completely into a section.

> 
> b. Provide minimum possible section size for a given base page config to
>    have increased agility during memory hotplug operations and reduced
>    vmemmap wastage for sections with holes.

OTOH, making the section size too small (e.g., 16MB) creates way to many
memory block devices in /sys/devices/system/memory/, and might consume
too many page->flags bits in the !vmemmap case.

For bigger setups, we might, similar to x86-64 (e.g., >= 64 GiB),
determine the memory_block_size_bytes() at runtime (spanning multiple
sections then), once it becomes relevant.

> 
> c. Allow 4K base page configs to have PMD based vmemmap mappings

Agreed.

> 
> Because CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 platform,
> the following would always avoid the condition (a)
> 
> SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
> 
> 			- 22 (11 - 1 + 12) for 4K pages
> 			- 24 (11 - 1 + 14) for 16K pages without THP
> 			- 25 (12 - 1 + 14) for 16K pages with THP
> 			- 26 (11 - 1 + 16) for 64K pages without THP
> 			- 29 (14 - 1 + 16) for 64K pages with THP
> 
> Apart from overriding 4K base page size config to have 27 as section size
> bits, should not all other values be okay here ? But then wondering what
> benefit 128MB (27 bits) section size for 16K config would have ? OR the
> objective here is to match 16K page size config with default x86-64.

We don't want to have sections that are too small. We don't want to have
sections that are too big :)

Not sure if we really want to allow setting e.g., a section size of 4
MB. That's just going to hurt. IMHO, something in the range of 64..256
MB is quite a good choice, where possible.

> 
>>
>> (If we worry about the number of section bits in page->flags, we could
>> glue it to vmemmap support where that does not matter)
> 
> Could you please elaborate ? Could smaller section size bits numbers like
> 22 or 24 create problems in page->flags without changing other parameters
> like NR_CPUS or NODES_SHIFT ? A quick test with 64K base page without THP

Yes, in the !vmemmap case, we have to store the section_nr in there.
IIRC, it's less of an issue with section sizes like 128 MB.

> i.e 26 bits in section size, fails to boot.

26 bits would mean 64 MB, no? Not sure if that's possible even without
THP (MAX_ORDER - 1, pageblock_order ...) on 64k pages. I'd assume 512 MB
is the lowest we can go. I'd assume this would crash :)

> 
> As you have suggested, probably constant defaults (128MB for 4K/16K, 512MB
> for 64K) might be better than depending on the CONFIG_FORCE_MAX_ZONEORDER,
> at least for now.

That's also what I would prefer, keeping it simple.

-- 
Thanks,

David / dhildenb


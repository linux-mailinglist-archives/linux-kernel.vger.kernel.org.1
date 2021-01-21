Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2849F2FEFC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbhAUQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:07:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731795AbhAUQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611245096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJrfazQb48R8qREfS3Tnoev0W+C0yb+jDAvRCgeXo0M=;
        b=TwCgrwx8FzO9JPM8hr0JYQdRgLdOogtRzD8aR81w8Qd6/aaK8SwkULdrnuDzoJoJflNKW2
        Rbxxhuk4Mvf9FU7e5LzgPcmFD51bbqPl0XEAusp2ZlyMG4Sboj7R9ea2a+NhYhaHaKn7UQ
        tXqVGXrPrs+iU2pi87f6TidfmMGZq/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-9PpQOjyVNoS2Od-t-xHorQ-1; Thu, 21 Jan 2021 11:04:51 -0500
X-MC-Unique: 9PpQOjyVNoS2Od-t-xHorQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12B3010054FF;
        Thu, 21 Jan 2021 16:04:49 +0000 (UTC)
Received: from [10.36.115.70] (ovpn-115-70.ams2.redhat.com [10.36.115.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79F2310074E5;
        Thu, 21 Jan 2021 16:04:46 +0000 (UTC)
Subject: Re: [PATCH 1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <cover.1611206601.git.sudaraja@codeaurora.org>
 <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
 <20210121141607.GB7648@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <51c1baf1-9114-4e0e-82f0-c7219e3a0023@redhat.com>
Date:   Thu, 21 Jan 2021 17:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210121141607.GB7648@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.21 15:16, Mike Rapoport wrote:
> On Wed, Jan 20, 2021 at 09:29:13PM -0800, Sudarshan Rajagopalan wrote:
>> memory_block_size_bytes() determines the memory hotplug granularity i.e the
>> amount of memory which can be hot added or hot removed from the kernel. The
>> generic value here being MIN_MEMORY_BLOCK_SIZE (1UL << SECTION_SIZE_BITS)
>> for memory_block_size_bytes() on platforms like arm64 that does not override.
>>
>> Current SECTION_SIZE_BITS is 30 i.e 1GB which is large and a reduction here
>> increases memory hotplug granularity, thus improving its agility. A reduced
>> section size also reduces memory wastage in vmemmmap mapping for sections
>> with large memory holes. So we try to set the least section size as possible.
>>
>> A section size bits selection must follow:
>> (MAX_ORDER - 1 + PAGE_SHIFT) <= SECTION_SIZE_BITS
>>
>> CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 and so just following it
>> would help achieve the smallest section size.
>>
>> SECTION_SIZE_BITS = (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
>>
>> SECTION_SIZE_BITS = 22 (11 - 1 + 12) i.e 4MB   for 4K pages
>> SECTION_SIZE_BITS = 24 (11 - 1 + 14) i.e 16MB  for 16K pages without THP
>> SECTION_SIZE_BITS = 25 (12 - 1 + 14) i.e 32MB  for 16K pages with THP
>> SECTION_SIZE_BITS = 26 (11 - 1 + 16) i.e 64MB  for 64K pages without THP
>> SECTION_SIZE_BITS = 29 (14 - 1 + 16) i.e 512MB for 64K pages with THP
>>
>> But there are other problems in reducing SECTION_SIZE_BIT. Reducing it by too
>> much would over populate /sys/devices/system/memory/ and also consume too many
>> page->flags bits in the !vmemmap case. Also section size needs to be multiple
>> of 128MB to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.
>>
>> Given these constraints, lets just reduce the section size to 128MB for 4K
>> and 16K base page size configs, and to 512MB for 64K base page size config.
>>
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Steven Price <steven.price@arm.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
> 
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> BTW, after reduction of the section size maybe arm64 should consider opting
> out of freeing unused memory map.
> 
> This will make David even more happy as this will allow dropping custom
> pfn_valid() ;-)

Mike knows my wildest dreams ;)

-- 
Thanks,

David / dhildenb


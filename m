Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79BF2FEC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbhAUNzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:55:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729707AbhAUNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611236732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEf/VNdPwyHzK4KCLsMcGYA6UHSFxyACQQAos9koldw=;
        b=iEPurRIZMebBbcotBoCJEmDJLk4qadw6gsBu2fW9dYrpKye9Mdv6Nc+bgqyqrEJMbUPv/u
        eFXrl4rHU47dpfHKksjG6csxl4lmjXgua+2H8Bpzi3WMdNq2064NK4MHwyiai5zwAGu5p0
        QIvzFbWjydwoVXAakFyaAohuCbrokbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-ZvOMgdSdMHCcFKdAIM3I9w-1; Thu, 21 Jan 2021 08:45:30 -0500
X-MC-Unique: ZvOMgdSdMHCcFKdAIM3I9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5319800D55;
        Thu, 21 Jan 2021 13:45:27 +0000 (UTC)
Received: from [10.36.115.70] (ovpn-115-70.ams2.redhat.com [10.36.115.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3C8319CAC;
        Thu, 21 Jan 2021 13:45:24 +0000 (UTC)
Subject: Re: [PATCH 1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <cover.1611206601.git.sudaraja@codeaurora.org>
 <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c4ceb8eb-4bcd-aedb-7b2d-bee338ea9c94@redhat.com>
Date:   Thu, 21 Jan 2021 14:45:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.21 06:29, Sudarshan Rajagopalan wrote:
> memory_block_size_bytes() determines the memory hotplug granularity i.e the
> amount of memory which can be hot added or hot removed from the kernel. The
> generic value here being MIN_MEMORY_BLOCK_SIZE (1UL << SECTION_SIZE_BITS)
> for memory_block_size_bytes() on platforms like arm64 that does not override.
> 
> Current SECTION_SIZE_BITS is 30 i.e 1GB which is large and a reduction here
> increases memory hotplug granularity, thus improving its agility. A reduced
> section size also reduces memory wastage in vmemmmap mapping for sections
> with large memory holes. So we try to set the least section size as possible.
> 
> A section size bits selection must follow:
> (MAX_ORDER - 1 + PAGE_SHIFT) <= SECTION_SIZE_BITS
> 
> CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 and so just following it
> would help achieve the smallest section size.
> 
> SECTION_SIZE_BITS = (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
> 
> SECTION_SIZE_BITS = 22 (11 - 1 + 12) i.e 4MB   for 4K pages
> SECTION_SIZE_BITS = 24 (11 - 1 + 14) i.e 16MB  for 16K pages without THP
> SECTION_SIZE_BITS = 25 (12 - 1 + 14) i.e 32MB  for 16K pages with THP
> SECTION_SIZE_BITS = 26 (11 - 1 + 16) i.e 64MB  for 64K pages without THP
> SECTION_SIZE_BITS = 29 (14 - 1 + 16) i.e 512MB for 64K pages with THP
> 
> But there are other problems in reducing SECTION_SIZE_BIT. Reducing it by too
> much would over populate /sys/devices/system/memory/ and also consume too many
> page->flags bits in the !vmemmap case. Also section size needs to be multiple
> of 128MB to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.
> 
> Given these constraints, lets just reduce the section size to 128MB for 4K
> and 16K base page size configs, and to 512MB for 64K base page size config.
> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/arm64/include/asm/sparsemem.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..eb4a75d720ed 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,26 @@
>  
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> -#define SECTION_SIZE_BITS	30
> -#endif
> +
> +/*
> + * Section size must be at least 512MB for 64K base
> + * page size config. Otherwise it will be less than
> + * (MAX_ORDER - 1) and the build process will fail.
> + */
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define SECTION_SIZE_BITS 29
> +
> +#else
> +
> +/*
> + * Section size must be at least 128MB for 4K base
> + * page size config. Otherwise PMD based huge page
> + * entries could not be created for vmemmap mappings.
> + * 16K follows 4K for simplicity.
> + */
> +#define SECTION_SIZE_BITS 27
> +#endif /* CONFIG_ARM64_64K_PAGES */
> +
> +#endif /* CONFIG_SPARSEMEM*/
>  
>  #endif
> 

I'm happy to see this change.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


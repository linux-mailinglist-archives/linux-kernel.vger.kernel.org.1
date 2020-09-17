Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B584926D2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 06:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIQEhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 00:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbgIQEhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 00:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600317429;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1dPSymURtNP+nZr7zQlcglZS0n6hAk+k5COycAfqws=;
        b=hCXcbk/6KpM/MjWoQYUR+1Ok436cSHMwnqtwUhY8lxcnWgxQ/gPKN61VEs4xWPvTMOYlyS
        PhMuoZPAMsf4rjNWjcg7lnYSaP2l+09dqscnp6Qq/8+2DV8ynVLjyRvpuSTI52f1U/QB6G
        7ol8SWJk1hGY7AFxzw2x1nQTKKvkB/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-4kndPzdUMGiVpHBC11496g-1; Thu, 17 Sep 2020 00:37:04 -0400
X-MC-Unique: 4kndPzdUMGiVpHBC11496g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373B51074641;
        Thu, 17 Sep 2020 04:37:03 +0000 (UTC)
Received: from [10.64.54.113] (vpn2-54-113.bne.redhat.com [10.64.54.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BD5E19D61;
        Thu, 17 Sep 2020 04:37:00 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] arm64/mm: Enable color zero pages
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20200916032523.13011-1-gshan@redhat.com>
 <20200916032523.13011-3-gshan@redhat.com>
 <20200916082819.GB27496@willie-the-truck>
 <77dcab5a-b5f2-a67c-6157-71a5a53db5de@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <40d87436-c283-9beb-e00d-29faf5ed95f7@redhat.com>
Date:   Thu, 17 Sep 2020 14:36:58 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <77dcab5a-b5f2-a67c-6157-71a5a53db5de@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 9/16/20 8:46 PM, Robin Murphy wrote:
> On 2020-09-16 09:28, Will Deacon wrote:
>> On Wed, Sep 16, 2020 at 01:25:23PM +1000, Gavin Shan wrote:
>>> This enables color zero pages by allocating contigous page frames
>>> for it. The number of pages for this is determined by L1 dCache
>>> (or iCache) size, which is probbed from the hardware.
>>>
>>>     * Add cache_total_size() to return L1 dCache (or iCache) size
>>>
>>>     * Implement setup_zero_pages(), which is called after the page
>>>       allocator begins to work, to allocate the contigous pages
>>>       needed by color zero page.
>>>
>>>     * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.
>>>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   arch/arm64/include/asm/cache.h   | 22 ++++++++++++++++++++
>>>   arch/arm64/include/asm/pgtable.h |  9 ++++++--
>>>   arch/arm64/kernel/cacheinfo.c    | 34 +++++++++++++++++++++++++++++++
>>>   arch/arm64/mm/init.c             | 35 ++++++++++++++++++++++++++++++++
>>>   arch/arm64/mm/mmu.c              |  7 -------
>>>   5 files changed, 98 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>>> index a4d1b5f771f6..420e9dde2c51 100644
>>> --- a/arch/arm64/include/asm/cache.h
>>> +++ b/arch/arm64/include/asm/cache.h
>>> @@ -39,6 +39,27 @@
>>>   #define CLIDR_LOC(clidr)    (((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
>>>   #define CLIDR_LOUIS(clidr)    (((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
>>> +#define CSSELR_TND_SHIFT    4
>>> +#define CSSELR_TND_MASK        (UL(1) << CSSELR_TND_SHIFT)
>>> +#define CSSELR_LEVEL_SHIFT    1
>>> +#define CSSELR_LEVEL_MASK    (UL(7) << CSSELR_LEVEL_SHIFT)
>>> +#define CSSELR_IND_SHIFT    0
>>> +#define CSSERL_IND_MASK        (UL(1) << CSSELR_IND_SHIFT)
>>> +
>>> +#define CCSIDR_64_LS_SHIFT    0
>>> +#define CCSIDR_64_LS_MASK    (UL(7) << CCSIDR_64_LS_SHIFT)
>>> +#define CCSIDR_64_ASSOC_SHIFT    3
>>> +#define CCSIDR_64_ASSOC_MASK    (UL(0x1FFFFF) << CCSIDR_64_ASSOC_SHIFT)
>>> +#define CCSIDR_64_SET_SHIFT    32
>>> +#define CCSIDR_64_SET_MASK    (UL(0xFFFFFF) << CCSIDR_64_SET_SHIFT)
>>> +
>>> +#define CCSIDR_32_LS_SHIFT    0
>>> +#define CCSIDR_32_LS_MASK    (UL(7) << CCSIDR_32_LS_SHIFT)
>>> +#define CCSIDR_32_ASSOC_SHIFT    3
>>> +#define CCSIDR_32_ASSOC_MASK    (UL(0x3FF) << CCSIDR_32_ASSOC_SHIFT)
>>> +#define CCSIDR_32_SET_SHIFT    13
>>> +#define CCSIDR_32_SET_MASK    (UL(0x7FFF) << CCSIDR_32_SET_SHIFT)
>>
>> I don't think we should be inferring cache structure from these register
>> values. The Arm ARM helpfully says:
>>
>>    | You cannot make any inference about the actual sizes of caches based
>>    | on these parameters.
>>
>> so we need to take the topology information from elsewhere.
> 
> Yes, these represent parameters for the low-level cache maintenance by set/way instructions, and nothing more. There are definitely cases where they do not reflect the underlying cache structure (commit 793acf870ea3 is an obvious first call).
> 

Thanks for your confirming. Yeah, the system registers aren't
reliable since the cache way/set are hard coded to 1/1. As I
suggested in another thread, ACPI (PPTT) table would be correct
place to get such kind of information.

[...]

Cheers,
Gavin


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F5B2B0A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgKLQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:43:05 -0500
Received: from foss.arm.com ([217.140.110.172]:53962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbgKLQnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:43:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3A7142F;
        Thu, 12 Nov 2020 08:43:04 -0800 (PST)
Received: from [10.37.12.33] (unknown [10.37.12.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5280A3F73C;
        Thu, 12 Nov 2020 08:43:01 -0800 (PST)
Subject: Re: [PATCH v9 30/44] arm64: kasan: Allow enabling in-kernel MTE
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1605046192.git.andreyknvl@google.com>
 <5ce2fc45920e59623a4a9d8d39b6c96792f1e055.1605046192.git.andreyknvl@google.com>
 <20201112094354.GF29613@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6a72b3e3-1b35-5ead-bfff-f4e2f3d5296e@arm.com>
Date:   Thu, 12 Nov 2020 16:46:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112094354.GF29613@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

missed this one.

On 11/12/20 9:43 AM, Catalin Marinas wrote:
> On Tue, Nov 10, 2020 at 11:10:27PM +0100, Andrey Konovalov wrote:
>> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Hardware tag-based KASAN relies on Memory Tagging Extension (MTE)
>> feature and requires it to be enabled. MTE supports
>>
>> This patch adds a new mte_init_tags() helper, that enables MTE in
>> Synchronous mode in EL1 and is intended to be called from KASAN runtime
>> during initialization.
> 
> There's no mte_init_tags() in this function.
> 
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 600b26d65b41..7f477991a6cf 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -129,6 +129,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>  	return ptr;
>>  }
>>  
>> +void mte_enable(void)
>> +{
>> +	/* Enable MTE Sync Mode for EL1. */
>> +	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>> +	isb();
>> +}
> 
> Nitpick: maybe rename this to mte_enable_kernel() since MTE is already
> enabled for user apps.
> 

I will fix this in the next iteration.

-- 
Regards,
Vincenzo

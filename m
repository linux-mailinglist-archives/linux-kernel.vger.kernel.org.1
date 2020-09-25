Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDA6278631
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgIYLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:44:32 -0400
Received: from foss.arm.com ([217.140.110.172]:43112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgIYLoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:44:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9EAB101E;
        Fri, 25 Sep 2020 04:44:31 -0700 (PDT)
Received: from [10.37.12.53] (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93BBE3F70D;
        Fri, 25 Sep 2020 04:44:28 -0700 (PDT)
Subject: Re: [PATCH v3 30/39] arm64: kasan: Enable TBI EL1
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1600987622.git.andreyknvl@google.com>
 <733e94d7368b54473b242bb6a38e421cf459c9ad.1600987622.git.andreyknvl@google.com>
 <20200925113748.GG4846@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <59c25256-374e-9a13-8098-1543b1768248@arm.com>
Date:   Fri, 25 Sep 2020 12:47:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925113748.GG4846@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/20 12:37 PM, Catalin Marinas wrote:
> On Fri, Sep 25, 2020 at 12:50:37AM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 12ba98bc3b3f..dce06e553c7c 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -40,9 +40,13 @@
>>  #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
>>  
>>  #ifdef CONFIG_KASAN_SW_TAGS
>> -#define TCR_KASAN_FLAGS TCR_TBI1
>> +#define TCR_KASAN_SW_FLAGS TCR_TBI1
>>  #else
>> -#define TCR_KASAN_FLAGS 0
>> +#define TCR_KASAN_SW_FLAGS 0
>> +#endif
>> +
>> +#ifdef CONFIG_KASAN_HW_TAGS
>> +#define TCR_KASAN_HW_FLAGS TCR_TBI1
>>  #endif
>>  
>>  /*
>> @@ -454,6 +458,9 @@ SYM_FUNC_START(__cpu_setup)
>>  
>>  	/* set the TCR_EL1 bits */
>>  	orr	mte_tcr, mte_tcr, #SYS_TCR_EL1_TCMA1
>> +#ifdef CONFIG_KASAN_HW_TAGS
>> +	orr	mte_tcr, mte_tcr, #TCR_KASAN_HW_FLAGS
>> +#endif
> 
> I missed this in an earlier patch. Do we need TCMA1 set without
> KASAN_HW? If not, we could add them both to TCR_KASAN_HW_FLAGS.
> 

We don't. I will move the code around in the next version.

-- 
Regards,
Vincenzo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54D5276712
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgIXDY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:24:29 -0400
Received: from foss.arm.com ([217.140.110.172]:32968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgIXDY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:24:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3267A113E;
        Wed, 23 Sep 2020 20:24:25 -0700 (PDT)
Received: from [10.163.75.147] (unknown [10.163.75.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636583F73B;
        Wed, 23 Sep 2020 20:24:22 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V3 1/3] arm64/mm/hotplug: Register boot memory hot remove
 notifier earlier
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.com>,
        catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, will@kernel.org
References: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
 <1600689908-28213-2-git-send-email-anshuman.khandual@arm.com>
 <bde102b0-7054-ae1d-d5d2-6348f4049d13@redhat.com>
Message-ID: <ca813890-7e1d-62fb-d284-ea45609f78ff@arm.com>
Date:   Thu, 24 Sep 2020 08:53:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bde102b0-7054-ae1d-d5d2-6348f4049d13@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/2020 11:34 AM, Gavin Shan wrote:
> Hi Anshuman,
> 
> On 9/21/20 10:05 PM, Anshuman Khandual wrote:
>> This moves memory notifier registration earlier in the boot process from
>> device_initcall() to early_initcall() which will help in guarding against
>> potential early boot memory offline requests. Even though there should not
>> be any actual offlinig requests till memory block devices are initialized
>> with memory_dev_init() but then generic init sequence might just change in
>> future. Hence an early registration for the memory event notifier would be
>> helpful. While here, just skip the registration if CONFIG_MEMORY_HOTREMOVE
>> is not enabled and also call out when memory notifier registration fails.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Steve Capper <steve.capper@arm.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/mm/mmu.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
> 
> With the following nit-picky comments resolved:
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 75df62fea1b6..df3b7415b128 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1499,7 +1499,17 @@ static struct notifier_block prevent_bootmem_remove_nb = {
>>     static int __init prevent_bootmem_remove_init(void)
>>   {
>> -    return register_memory_notifier(&prevent_bootmem_remove_nb);
>> +    int ret = 0;
>> +
>> +    if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
>> +        return ret;
>> +
>> +    ret = register_memory_notifier(&prevent_bootmem_remove_nb);
>> +    if (!ret)
>> +        return ret;
>> +
>> +    pr_err("Notifier registration failed - boot memory can be removed\n");
>> +    return ret;
>>   }
> 
> It might be cleaner if the duplicated return statements can be
> avoided. Besides, it's always nice to print the errno even though

Thought about it, just that the error message was too long.

> zero is always returned from register_memory_notifier(). So I guess
> you probably need something like below:
> 
>         ret = register_memory_notifier(&prevent_bootmem_remove_nb);
>         if (ret)
>             pr_err("%s: Error %d registering notifier\n", __func__, ret)
> 
>         return ret;

Sure, will do.

> 
> 
> register_memory_notifier                   # 0 is returned on !CONFIG_MEMORY_HOTPLUG_SPARSE
>    blocking_notifier_chain_register
>       notifier_chain_register              # 0 is always returned
>      
>> -device_initcall(prevent_bootmem_remove_init);
>> +early_initcall(prevent_bootmem_remove_init);
>>   #endif
>>
> 
> Cheers,
> Gavin
> 
> 

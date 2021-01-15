Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5252F703C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbhAOBwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:52:38 -0500
Received: from foss.arm.com ([217.140.110.172]:58922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbhAOBwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:52:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADFF6D6E;
        Thu, 14 Jan 2021 17:51:51 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9521E3F66E;
        Thu, 14 Jan 2021 17:51:49 -0800 (PST)
Subject: Re: [PATCH V2 07/11] arm64: Add TRBE definitions
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-8-git-send-email-anshuman.khandual@arm.com>
 <d6af6dae-f3ba-cd35-2ffb-cfbc9d222469@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cb73f274-c8d0-a069-e274-f8994f007315@arm.com>
Date:   Fri, 15 Jan 2021 07:22:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d6af6dae-f3ba-cd35-2ffb-cfbc9d222469@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/21 2:51 PM, Suzuki K Poulose wrote:
> On 1/13/21 4:18 AM, Anshuman Khandual wrote:
>> This adds TRBE related registers and corresponding feature macros.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/include/asm/sysreg.h | 49 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 4acff97..d60750e7 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -329,6 +329,55 @@
>>     /*** End of Statistical Profiling Extension ***/
>>   +/*
>> + * TRBE Registers
>> + */
>> +#define SYS_TRBLIMITR_EL1        sys_reg(3, 0, 9, 11, 0)
>> +#define SYS_TRBPTR_EL1            sys_reg(3, 0, 9, 11, 1)
>> +#define SYS_TRBBASER_EL1        sys_reg(3, 0, 9, 11, 2)
>> +#define SYS_TRBSR_EL1            sys_reg(3, 0, 9, 11, 3)
>> +#define SYS_TRBMAR_EL1            sys_reg(3, 0, 9, 11, 4)
>> +#define SYS_TRBTRG_EL1            sys_reg(3, 0, 9, 11, 6)
>> +#define SYS_TRBIDR_EL1            sys_reg(3, 0, 9, 11, 7)
>> +
>> +#define TRBLIMITR_LIMIT_MASK        GENMASK_ULL(51, 0)
>> +#define TRBLIMITR_LIMIT_SHIFT        12
>> +#define TRBLIMITR_NVM            BIT(5)
>> +#define TRBLIMITR_TRIG_MODE_MASK    GENMASK(1, 0)
>> +#define TRBLIMITR_TRIG_MODE_SHIFT    2
> 
> This must be 3.

Changed.

> 
> Rest looks fine to me
> 
> Suzuki

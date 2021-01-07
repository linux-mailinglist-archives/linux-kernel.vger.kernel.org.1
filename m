Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717DB2ED14B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbhAGOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:02:07 -0500
Received: from foss.arm.com ([217.140.110.172]:33244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbhAGOCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:02:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99AED6E;
        Thu,  7 Jan 2021 06:01:21 -0800 (PST)
Received: from [10.57.37.195] (unknown [10.57.37.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99843F70D;
        Thu,  7 Jan 2021 06:01:19 -0800 (PST)
Subject: Re: [PATCH 10/11] coresight: sink: Add TRBE driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
 <1608717823-18387-11-git-send-email-anshuman.khandual@arm.com>
 <92b5ae56-df5d-3772-0206-b50ea4080c4f@arm.com>
 <f5ab26f4-8cf2-b7cf-ad3a-53c98d488407@arm.com>
 <d909717f-c3e2-37cf-63e8-cdf2ac3bf069@arm.com>
 <88a4d889-242a-2951-9c6e-e8712d013f46@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5b6d10a3-d16e-ba2c-ef72-cc00d90e6240@arm.com>
Date:   Thu, 7 Jan 2021 14:01:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <88a4d889-242a-2951-9c6e-e8712d013f46@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 11:50 AM, Anshuman Khandual wrote:
> 
> 
> On 1/5/21 5:07 PM, Suzuki K Poulose wrote:
>> On 1/5/21 9:29 AM, Anshuman Khandual wrote:

...

>>>>> +{
>>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>>> +    unsigned long offset;
>>>>> +
>>>>> +    if (buf->snapshot)
>>>>> +        offset = trbe_snapshot_offset(handle);
>>>>> +    else
>>>>> +        offset = trbe_normal_offset(handle);
>>>>> +    return buf->trbe_base + offset;
>>>>> +}
>>>>> +
>>>>> +static void clear_trbe_state(void)
>>>>
>>>> nit: The name doesn't give much clue about what it is doing, especially, given
>>>> the following "set_trbe_state()" which does completely different from this "clear"
>>>> operation.
>>>
>>> I agree that these names could have been better.
>>>
>>> s/clear_trbe_state/trbe_reset_perf_state  - Clears TRBE from current perf config
>>> s/set_trbe_state/trbe_prepare_perf_state  - Prepares TRBE for the next perf config
>>
>> Please don't tie them to "perf". This is pure hardware configuration, not perf.
> 
> Okay.
> 
>>
>> Also, I wonder if we need a separate "set_trbe_state". Could we not initialize the LIMITR
>> at one go ?
> 
> There are some limitations which could prevent that.
> 
>>
>> i.e, do something like :
>>
>> set_trbe_limit_pointer(limit, mode) ?
>>
>> where it sets all the fields of limit pointer. Also, you may want to document the mode we
>> choose for TRBE. i.e, FILL STOP mode for us to collect the trace.
> 
> Sure, will document the TRBE mode being choosen here.
> 
>>
>>>
>>>
>>>>
>>>> I would rather open code this with a write of 0 to trbsr in the caller.
>>>>
>>>>> +{
>>>>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>>>>> +
>>>>> +    WARN_ON(is_trbe_enabled());
>>>>> +    trbsr &= ~TRBSR_IRQ;
>>>>> +    trbsr &= ~TRBSR_TRG;
>>>>> +    trbsr &= ~TRBSR_WRAP;
>>>>> +    trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
>>>>> +    trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
>>>>> +    trbsr &= ~(TRBSR_FSC_MASK << TRBSR_FSC_SHIFT);
>>>>
>>>> BSC and FSC are the same fields under MSS, with their meanings determined by the EC field.
>>>
>>> Could just drop the FSC part if required.
>>>
>>>>
>>>> Could we simply write 0 to the register ?
>>>
>>> I would really like to avoid that. This function clearly enumerates all
>>> individual bit fields being cleared for resetting as well as preparing
>>> the TRBE for the next perf session. Converting this into a 0 write for
>>> SYS_TRBSR_EL1 sounds excessive and the only thing it would save is the
>>> register read.
>>
>>>
>>>>
>>>>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>>>>> +}
>>>>> +
>>>>> +static void set_trbe_state(void)
>>>>> +{
>>>>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>>>>> +
>>>>> +    trblimitr &= ~TRBLIMITR_NVM;
>>>>> +    trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
>>>>> +    trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
>>>>> +    trblimitr |= (TRBE_FILL_STOP & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT;
>>>>> +    trblimitr |= (TRBE_TRIGGER_IGNORE & TRBLIMITR_TRIG_MODE_MASK) << TRBLIMITR_TRIG_MODE_SHIFT;
>>>>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>>>>
>>>> Do we need to read-copy-update here ? Could we simply write 0 ?
>>>> Same as above comment, could we not simply opencode it at the caller ?
>>>> Clearly the names don't help.
>>>
>>> Will change the names as proposed or something better. But lets leave
>>> these functions as is. Besides TRBE_TRIGGER_IGNORE also has a positive
>>> value (i.e 3), writing all 0s into SYS_TRBLIMITR_EL1 will not be ideal.
>>>
>>
>> The point is, we don't need to preserve the values for LIMITR. Also see my comment
>> above, for folding this to set_trbe_limit_pointer(). In any case, I don't think
>> we should rely on the values of fields we change. So it is safer and cleaner to
>> set set all the bits for LIMITR, including the LIMIT address in one go, without
>> ready-copy-update.
> 
> TRBE needs to be disabled (which is also in the LIMIT register) before we can update
> any other fields in the LIMIT register. So there is already an order dependency here.
> Looking at the function trbe_enable_hw(), it follows something like
> 
> 1. Clear and set the TRBE mode	- followed by an isb()
> 2. Update the TRBE pointers	- followed by an isb()
> 3. Set it rolling		- followed by TSB_CSYNC
> 
> static void trbe_enable_hw(struct trbe_buf *buf)
> {
> 
> 	[Software checks]
>          WARN_ON(buf->trbe_write < buf->trbe_base);
>          WARN_ON(buf->trbe_write >= buf->trbe_limit);
> 
> 	[Disable TRBE in the limit register]
>          set_trbe_disabled();
> 

We need an isb() here.

> 	[Clears TRBE status register]
>          trbe_reset_perf_state();

Please be explicit here. Make the function name reflect the fact that
we are simply clearing the status register and nothing related to perf.

> 
> 	[Configures TRBE mode in the limit register]
>          trbe_prepare_perf_state();

This is unnecessarily introducing a dependency not enforced by the HW.
You could program the LIMIT register with all the setting, mode, limit
and *enable TBRE* once we have programmed base and write pointer at one
shot.

> 
>          isb();

Drop the ISB

> 
> 	[Update all required pointers]
>          set_trbe_base_pointer(buf->trbe_base);
>          set_trbe_limit_pointer(buf->trbe_limit);

As mentioned above, this could be done in set_trbe_enabled()

>          set_trbe_write_pointer(buf->trbe_write);
>          isb();
> 
> 	[Set it rolling]
> 
> 	[Update TRBE status register stop bit]
>          set_trbe_running();

This doesn't have any significance with Hardware. It is a status bit
from the HW, which is writable only for "state" save/restore, when
switching between contexts. Otherwise, this write doesn't do anything.
So, please combine this with the clear_status operation above.


> 
> 	[Update TRBE limit register enable bit]
>          set_trbe_enabled();

Here we could set all the fileds of the LIMIT register, followed by
an isb()

Kind regards
Suzuki

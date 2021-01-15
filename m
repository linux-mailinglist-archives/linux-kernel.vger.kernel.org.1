Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9892E2F7A08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbhAOMoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:44:12 -0500
Received: from foss.arm.com ([217.140.110.172]:39238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732759AbhAOMoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:44:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B9BED1;
        Fri, 15 Jan 2021 04:43:19 -0800 (PST)
Received: from [10.57.56.97] (unknown [10.57.56.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392AA3F70D;
        Fri, 15 Jan 2021 04:43:18 -0800 (PST)
Subject: Re: [PATCH V2 10/11] coresight: sink: Add TRBE driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-11-git-send-email-anshuman.khandual@arm.com>
 <fbcf3c8f-f4c1-bf7f-35ae-e06d3d372cae@arm.com>
 <43bc1738-040c-1e48-b8f1-d337dcfcff2e@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f6262d21-c72e-3b7e-59a1-8f14441d809d@arm.com>
Date:   Fri, 15 Jan 2021 12:43:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <43bc1738-040c-1e48-b8f1-d337dcfcff2e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 5:29 AM, Anshuman Khandual wrote:
> 
> 
> On 1/13/21 8:58 PM, Suzuki K Poulose wrote:
>> Hi Anshuman,
>>
>> The driver looks overall good to me. Please find some minor comments below
>>
>> On 1/13/21 4:18 AM, Anshuman Khandual wrote:
>>> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
>>> accessible via the system registers. The TRBE supports different addressing
>>> modes including CPU virtual address and buffer modes including the circular
>>> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
>>> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
>>> access to the trace buffer could be prohibited by a higher exception level
>>> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
>>> private interrupt (PPI) on address translation errors and when the buffer
>>> is full. Overall implementation here is inspired from the Arm SPE driver.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

...

>>> +
>>> +/*
>>> + * TRBE Buffer Management
>>> + *
>>> + * The TRBE buffer spans from the base pointer till the limit pointer. When enabled,
>>> + * it starts writing trace data from the write pointer onward till the limit pointer.
>>
>>
>>> + * When the write pointer reaches the address just before the limit pointer, it gets
>>> + * wrapped around again to the base pointer. This is called a TRBE wrap event, which
>>> + * generates a maintenance interrupt when operated in WRAP or STOP mode.
>>
>> According to the TRM, it is FILL mode, instead of STOP. So please change the above to:
>>
>> "operated in WRAP or FILL mode".
> 
> Updated.
> 
>>
>>
>>>      The write
>>> + * pointer again starts writing trace data from the base pointer until just before
>>> + * the limit pointer before getting wrapped again with an IRQ and this process just
>>> + * goes on as long as the TRBE is enabled.
>>
>> This could be dropped as it applies to WRAP/CIRCULAR buffer mode, which we don't use.
> 
> Probably this could be changed a bit to match the FILL mode. Because it is essential
> to describe the continuous nature of the buffer operation, even in the FILL mode.
> 
>   * After TRBE
>   * IRQ gets handled and enabled again, write pointer again starts writing trace data
>   * from the base pointer until just before the limit pointer before getting wrapped
>   * again with an IRQ and this process just goes on as long as the TRBE is enabled.
> 

The above doesn't parse well and kind of repeats the operation of TRBE which is
already explained above. How about :

 >>> + * When the write pointer reaches the address just before the limit pointer, it gets
 >>> + * wrapped around again to the base pointer. This is called a TRBE wrap event, which
 >>> + * generates a maintenance interrupt when operated in WRAP or STOP mode.

This driver uses FILL mode, where the TRBE stops the trace collection at wrap event.
The IRQ handler updates the AUX buffer and re-enables the TRBE with updated WRITE and
LIMIT pointers.


>>> +
>>> +static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>>> +                   struct perf_event *event, void **pages,
>>> +                   int nr_pages, bool snapshot)
>>> +{
>>> +    struct trbe_buf *buf;
>>> +    struct page **pglist;
>>> +    int i;
>>> +
>>> +    if ((nr_pages < 2) || (snapshot && (nr_pages & 1)))
>>
>> This restriction on snapshot could be removed now, since we use the
>> full buffer.
> 
> Dropped only the second condition here i.e (snapshot && (nr_pages & 1).
> Just wondering if the aux buffer could work with a single page so that
> the first condition can also be dropped.

I think it is good to keep the restriction of 2 pages, as the WRITE_PTR
and the LIMIT_PTR must be page aligned. With a single page, you can't do
much, with writing into a partially filled buffer. This may be added
as a comment to explain the restriction.

>>> +
>>> +static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle)
>>> +{
>>> +    int ec = get_trbe_ec();
>>> +    int bsc = get_trbe_bsc();
>>> +
>>> +    WARN_ON(is_trbe_running());
>>> +    if (is_trbe_trg() || is_trbe_abort())
>>
>> We seem to be reading the TRBSR every single in these helpers. Could we optimise them
>> by passing the register value in ?
> 
> The same goes for get_trbe_ec() and get_trbe_bsc() as well. Probably all
> TRBSR field probing helpers should be modified to accept a TRBSR register
> value instead.
> 
>>
>> i.e
>>      u64 trbsr = get_trbe_status();
>>
>>      WARN_ON(is_trbe_runnign(trbsr))
>>      if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
>>
>> For is_trbe_wrap() too
> 
> Yes.
> 
>>


>>
>> We should skip the driver init, if the kernel is unmapped at EL0,
>> as the TRBE can't safely write to the kernel virtual addressed
>> buffer when the CPU is running at EL0. This is unlikely, but we
>> should cover that case.
> 
> This should be sufficient or it needs a pr_err() as well ?
> 

Please add a pr_err() message to indicate why this failed. Otherwise
the user could be left with no clue.

Cheers
Suzuki

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEEC2EBD53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbhAFLvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:51:11 -0500
Received: from foss.arm.com ([217.140.110.172]:39898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAFLvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:51:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E99DD6E;
        Wed,  6 Jan 2021 03:50:24 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53F453F70D;
        Wed,  6 Jan 2021 03:50:21 -0800 (PST)
Subject: Re: [PATCH 10/11] coresight: sink: Add TRBE driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <88a4d889-242a-2951-9c6e-e8712d013f46@arm.com>
Date:   Wed, 6 Jan 2021 17:20:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d909717f-c3e2-37cf-63e8-cdf2ac3bf069@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/21 5:07 PM, Suzuki K Poulose wrote:
> On 1/5/21 9:29 AM, Anshuman Khandual wrote:
>>
>>
>> On 1/4/21 9:58 PM, Suzuki K Poulose wrote:
>>>
>>> Hi Anshuman,
>>>
>>> On 12/23/20 10:03 AM, Anshuman Khandual wrote:
>>>> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
>>>> accessible via the system registers. The TRBE supports different addressing
>>>> modes including CPU virtual address and buffer modes including the circular
>>>> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
>>>> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
>>>> access to the trace buffer could be prohibited by a higher exception level
>>>> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
>>>> private interrupt (PPI) on address translation errors and when the buffer
>>>> is full. Overall implementation here is inspired from the Arm SPE driver.
>>>>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>
>>>>
>>>>    Documentation/trace/coresight/coresight-trbe.rst |  39 +
>>>>    arch/arm64/include/asm/sysreg.h                  |   2 +
>>>>    drivers/hwtracing/coresight/Kconfig              |  11 +
>>>>    drivers/hwtracing/coresight/Makefile             |   1 +
>>>>    drivers/hwtracing/coresight/coresight-trbe.c     | 925 +++++++++++++++++++++++
>>>>    drivers/hwtracing/coresight/coresight-trbe.h     | 248 ++++++
>>>>    6 files changed, 1226 insertions(+)
>>>>    create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>>>>    create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>>>>    create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>>>>
> 
>>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>>> index e6962b1..2a9bfb7 100644
>>>> --- a/arch/arm64/include/asm/sysreg.h
>>>> +++ b/arch/arm64/include/asm/sysreg.h
>>>> @@ -97,6 +97,7 @@
>>>>    #define SET_PSTATE_UAO(x)        __emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
>>>>    #define SET_PSTATE_SSBS(x)        __emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
>>>>    #define SET_PSTATE_TCO(x)        __emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
>>>> +#define TSB_CSYNC            __emit_inst(0xd503225f)
>>>>      #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
>>>>        __emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
>>>> @@ -869,6 +870,7 @@
>>>>    #define ID_AA64MMFR2_CNP_SHIFT        0
>>>>      /* id_aa64dfr0 */
>>>> +#define ID_AA64DFR0_TRBE_SHIFT        44
>>>>    #define ID_AA64DFR0_TRACE_FILT_SHIFT    40
>>>>    #define ID_AA64DFR0_DOUBLELOCK_SHIFT    36
>>>>    #define ID_AA64DFR0_PMSVER_SHIFT    32
> 
> 
>>>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>>>> index f20e357..d608165 100644
>>>> --- a/drivers/hwtracing/coresight/Makefile
>>>> +++ b/drivers/hwtracing/coresight/Makefile
>>>> @@ -21,5 +21,6 @@ obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>>>>    obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>>>>    obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>>>>    obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>>> +obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>>>    coresight-cti-y := coresight-cti-core.o    coresight-cti-platform.o \
>>>>               coresight-cti-sysfs.o
>>>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>>>> new file mode 100644
>>>> index 0000000..ba280e6
>>>> --- /dev/null
>>>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> 
>>>> +static void trbe_reset_local(void)
>>>> +{
>>>> +    trbe_disable_and_drain_local();
>>>> +    write_sysreg_s(0, SYS_TRBPTR_EL1);
>>>> +    write_sysreg_s(0, SYS_TRBBASER_EL1);
>>>> +    write_sysreg_s(0, SYS_TRBSR_EL1);
>>>> +    isb();
>>>> +}
>>>> +
>>>> +/*
>>>> + * TRBE Buffer Management
>>>> + *
>>>> + * The TRBE buffer spans from the base pointer till the limit pointer. When enabled,
>>>> + * it starts writing trace data from the write pointer onward till the limit pointer.
>>>> + * When the write pointer reaches the address just before the limit pointer, it gets
>>>> + * wrapped around again to the base pointer. This is called a TRBE wrap event which
>>>> + * is accompanied by an IRQ.
>>>
>>> This is true for one of the modes of operation, the WRAP mode, which could be specified
>>> in the comment. e.g,
>>>
>>> This is called a TRBE wrap event, which generates a maintenance interrupt when operated
>>> in WRAP mode.
>>
>> Sure, will change.
> 
> Sorry, correcting myself:
> 
> s/when operated in WRAP mode/when operated in WRAP or STOP mode/

Sure, will change.

> 
> ...
> 
>>>> +
>>>> +static unsigned long get_trbe_limit(struct perf_output_handle *handle)
>>>
>>> nit: The naming is a bit confusing with get_trbe_limit() and get_trbe_limit_pointer().
>>> One computes the TRBE buffer limit and the other reads the hardware Limit pointer.
>>> It would be good if follow a scheme for the namings.
>>>
>>> e.g, trbe_limit_pointer() , trbe_base_pointer(), trbe_<register>_<name> for anything
>>> that reads the hardware register.
>>
>> The current scheme is in the form get_trbe_XXX() where XXX
>> is a TRBE hardware component e.g.
>>
>> get_trbe_base_pointer()
>> get_trbe_limit_pointer()
>> get_trbe_write_pointer()
>> get_trbe_ec()
>> get_trbe_bsc()
>> get_trbe_address_align()
>> get_trbe_flag_update()
>>
>>>
>>> Or may be rename the get_trbe_limit() to compute_trbe_buffer_limit()
>>
>> This makes it clear, will change.
>>
>>>
>>>> +{
>>>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>>>> +    unsigned long offset;
>>>> +
>>>> +    if (buf->snapshot)
>>>> +        offset = trbe_snapshot_offset(handle);
>>>> +    else
>>>> +        offset = trbe_normal_offset(handle);
>>>> +    return buf->trbe_base + offset;
>>>> +}
>>>> +
>>>> +static void clear_trbe_state(void)
>>>
>>> nit: The name doesn't give much clue about what it is doing, especially, given
>>> the following "set_trbe_state()" which does completely different from this "clear"
>>> operation.
>>
>> I agree that these names could have been better.
>>
>> s/clear_trbe_state/trbe_reset_perf_state  - Clears TRBE from current perf config
>> s/set_trbe_state/trbe_prepare_perf_state  - Prepares TRBE for the next perf config
> 
> Please don't tie them to "perf". This is pure hardware configuration, not perf.

Okay.

> 
> Also, I wonder if we need a separate "set_trbe_state". Could we not initialize the LIMITR
> at one go ?

There are some limitations which could prevent that.

> 
> i.e, do something like :
> 
> set_trbe_limit_pointer(limit, mode) ?
> 
> where it sets all the fields of limit pointer. Also, you may want to document the mode we
> choose for TRBE. i.e, FILL STOP mode for us to collect the trace.

Sure, will document the TRBE mode being choosen here.

> 
>>
>>
>>>
>>> I would rather open code this with a write of 0 to trbsr in the caller.
>>>
>>>> +{
>>>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>>>> +
>>>> +    WARN_ON(is_trbe_enabled());
>>>> +    trbsr &= ~TRBSR_IRQ;
>>>> +    trbsr &= ~TRBSR_TRG;
>>>> +    trbsr &= ~TRBSR_WRAP;
>>>> +    trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
>>>> +    trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
>>>> +    trbsr &= ~(TRBSR_FSC_MASK << TRBSR_FSC_SHIFT);
>>>
>>> BSC and FSC are the same fields under MSS, with their meanings determined by the EC field.
>>
>> Could just drop the FSC part if required.
>>
>>>
>>> Could we simply write 0 to the register ?
>>
>> I would really like to avoid that. This function clearly enumerates all
>> individual bit fields being cleared for resetting as well as preparing
>> the TRBE for the next perf session. Converting this into a 0 write for
>> SYS_TRBSR_EL1 sounds excessive and the only thing it would save is the
>> register read.
> 
>>
>>>
>>>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>>>> +}
>>>> +
>>>> +static void set_trbe_state(void)
>>>> +{
>>>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>>>> +
>>>> +    trblimitr &= ~TRBLIMITR_NVM;
>>>> +    trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
>>>> +    trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
>>>> +    trblimitr |= (TRBE_FILL_STOP & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT;
>>>> +    trblimitr |= (TRBE_TRIGGER_IGNORE & TRBLIMITR_TRIG_MODE_MASK) << TRBLIMITR_TRIG_MODE_SHIFT;
>>>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>>>
>>> Do we need to read-copy-update here ? Could we simply write 0 ?
>>> Same as above comment, could we not simply opencode it at the caller ?
>>> Clearly the names don't help.
>>
>> Will change the names as proposed or something better. But lets leave
>> these functions as is. Besides TRBE_TRIGGER_IGNORE also has a positive
>> value (i.e 3), writing all 0s into SYS_TRBLIMITR_EL1 will not be ideal.
>>
> 
> The point is, we don't need to preserve the values for LIMITR. Also see my comment
> above, for folding this to set_trbe_limit_pointer(). In any case, I don't think
> we should rely on the values of fields we change. So it is safer and cleaner to
> set set all the bits for LIMITR, including the LIMIT address in one go, without
> ready-copy-update.

TRBE needs to be disabled (which is also in the LIMIT register) before we can update
any other fields in the LIMIT register. So there is already an order dependency here.
Looking at the function trbe_enable_hw(), it follows something like

1. Clear and set the TRBE mode	- followed by an isb()
2. Update the TRBE pointers	- followed by an isb()
3. Set it rolling		- followed by TSB_CSYNC

static void trbe_enable_hw(struct trbe_buf *buf)
{

	[Software checks]
        WARN_ON(buf->trbe_write < buf->trbe_base);
        WARN_ON(buf->trbe_write >= buf->trbe_limit);

	[Disable TRBE in the limit register]
        set_trbe_disabled();

	[Clears TRBE status register]
        trbe_reset_perf_state();

	[Configures TRBE mode in the limit register]
        trbe_prepare_perf_state();

        isb();

	[Update all required pointers]
        set_trbe_base_pointer(buf->trbe_base);
        set_trbe_limit_pointer(buf->trbe_limit);
        set_trbe_write_pointer(buf->trbe_write);
        isb();

	[Set it rolling]

	[Update TRBE status register stop bit]
        set_trbe_running();

	[Update TRBE limit register enable bit]
        set_trbe_enabled();
        set_trbe_flush();
}

set_trbe_disabled() should be called before trbe_reset_perf_state() as TRBE
needs to be stopped completely before clearing the TRBE status register.
Hence set_trbe_disabled() cannot be moved inside trbe_prepare_perf_state().

set_trbe_enabled() also cannot be called before configuring the TRBE mode
and updating all other required pointers. So set_trbe_enabled() cannot be
moved inside trbe_prepare_perf_state().

The TRBE limit register needs to be written into in different batches even
though the unchanged fields need not be preserved.

Besides, function names could be changed as follows and document the mode
selection.

s/trbe_reset_perf_state/clr_trbe_status/
s/trbe_prepare_perf_state/set_trbe_mode/

set_trbe_mode() might also take the fill mode and trigger mode as arguments.
Trigger mode needs to be set correctly i.e TRBE_TRIGGER_IGNORE.

> 
> 
>>>
>>>> +}
>>>> +
>>>> +static void trbe_enable_hw(struct trbe_buf *buf)
>>>> +{
>>>> +    WARN_ON(buf->trbe_write < buf->trbe_base);
>>>> +    WARN_ON(buf->trbe_write >= buf->trbe_limit);
>>>> +    set_trbe_disabled();
>>>> +    clear_trbe_state();
>>>> +    set_trbe_state();
>>>> +    isb();
>>>> +    set_trbe_base_pointer(buf->trbe_base);
>>>> +    set_trbe_limit_pointer(buf->trbe_limit);
>>>> +    set_trbe_write_pointer(buf->trbe_write);
>>>
>>> Where do we set the fill mode ?
>>
>> TRBE_FILL_STOP has already been configured in set_trbe_state().
>>
> 
> As mentioned above, this needs to be documented. It is not evident
> for someone who is looking at the code. e.g, I thought the set_trbe_state()
> was simply stopping the TRBE.
> 
> Also, looking at the spec, I find the names of the fill modes confusing.
> The modes are FILL, WRAP and CIRCULAR BUFFER. Stop is just the behavior
> of FILL. So, please do not use STOP for the mode name.
> 
> Also, please rename the mode symbols to :
> 
> TRBE_FILL_MODE_FILL
> TRBE_FILL_MODE_WRAP
> TRBE_FILL_MODE_CIRCULAR_BUFFER
> 
> to align with the spec.

Okay, will change these and possibly the trigger modes as well.

> 
>>>
>>>> +    isb();
>>>> +    set_trbe_running();
>>>> +    set_trbe_enabled();
>>>> +    set_trbe_flush();
>>>> +}
>>>> +
> 
> 
>>>> +
>>>> +static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
>>>> +{
>>>> +    struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
>>>> +
>>>> +    if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
>>>> +        if (!per_cpu(csdev_sink, cpu) && (system_state == SYSTEM_RUNNING)) {
>>>
>>> Why is the system_state check relevant here ?
>>
>> I had a concern regarding whether arm_trbe_probe_coresight_cpu() invocations
>> from arm_trbe_cpu_startup() might race with its invocations during boot from
>> arm_trbe_device_probe(). Checking for runtime system_state would ensure that
>> a complete TRBE probe on a given cpu is called only after the boot is complete.
>> But if the race condition is really never possible, can just drop this check.
> 
> I don't think they should.
> 
> Suzuki
> 

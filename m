Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78C2C38A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 06:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgKYFZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 00:25:44 -0500
Received: from foss.arm.com ([217.140.110.172]:51362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgKYFZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 00:25:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A451D31B;
        Tue, 24 Nov 2020 21:25:41 -0800 (PST)
Received: from [10.163.83.46] (unknown [10.163.83.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 688563F718;
        Tue, 24 Nov 2020 21:25:39 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC 07/11] coresight: sink: Add TRBE driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-8-git-send-email-anshuman.khandual@arm.com>
 <27d318eb-8539-698c-9c33-309dcacecb99@arm.com>
Message-ID: <ba443689-0b44-ef83-934e-41a0a50d99a9@arm.com>
Date:   Wed, 25 Nov 2020 10:55:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27d318eb-8539-698c-9c33-309dcacecb99@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 3:43 PM, Suzuki K Poulose wrote:
> On 11/10/20 12:45 PM, Anshuman Khandual wrote:
>> Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
>> accessible via the system registers. The TRBE supports different addressing
>> modes including CPU virtual address and buffer modes including the circular
>> buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
>> an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
>> access to the trace buffer could be prohibited by a higher exception level
>> (EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
>> private interrupt (PPI) on address translation errors and when the buffer
>> is full. Overall implementation here is inspired from the Arm SPE driver.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   Documentation/trace/coresight/coresight-trbe.rst |  36 ++
>>   arch/arm64/include/asm/sysreg.h                  |   2 +
>>   drivers/hwtracing/coresight/Kconfig              |  11 +
>>   drivers/hwtracing/coresight/Makefile             |   1 +
>>   drivers/hwtracing/coresight/coresight-trbe.c     | 766 +++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-trbe.h     | 525 ++++++++++++++++
>>   6 files changed, 1341 insertions(+)
>>   create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>>   create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>>   create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>>
>> diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Documentation/trace/coresight/coresight-trbe.rst
>> new file mode 100644
>> index 0000000..4320a8b
>> --- /dev/null
>> +++ b/Documentation/trace/coresight/coresight-trbe.rst
>> @@ -0,0 +1,36 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==============================
>> +Trace Buffer Extension (TRBE).
>> +==============================
>> +
>> +    :Author:   Anshuman Khandual <anshuman.khandual@arm.com>
>> +    :Date:     November 2020
>> +
>> +Hardware Description
>> +--------------------
>> +
>> +Trace Buffer Extension (TRBE) is a percpu hardware which captures in system
>> +memory, CPU traces generated from a corresponding percpu tracing unit. This
>> +gets plugged in as a coresight sink device because the corresponding trace
>> +genarators (ETE), are plugged in as source device.
>> +
>> +Sysfs files and directories
>> +---------------------------
>> +
>> +The TRBE devices appear on the existing coresight bus alongside the other
>> +coresight devices::
>> +
>> +    >$ ls /sys/bus/coresight/devices
>> +    trbe0  trbe1  trbe2 trbe3
>> +
>> +The ``trbe<N>`` named TRBEs are associated with a CPU.::
>> +
>> +    >$ ls /sys/bus/coresight/devices/trbe0/
>> +    irq align dbm
>> +
>> +*Key file items are:-*
>> +   * ``irq``: TRBE maintenance interrupt number
>> +   * ``align``: TRBE write pointer alignment
>> +   * ``dbm``: TRBE updates memory with access and dirty flags
>> +
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 14cb156..61136f6 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -97,6 +97,7 @@
>>   #define SET_PSTATE_UAO(x)        __emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
>>   #define SET_PSTATE_SSBS(x)        __emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
>>   #define SET_PSTATE_TCO(x)        __emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
>> +#define TSB_CSYNC            __emit_inst(0xd503225f)
>>     #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
>>       __emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
>> @@ -865,6 +866,7 @@
>>   #define ID_AA64MMFR2_CNP_SHIFT        0
>>     /* id_aa64dfr0 */
>> +#define ID_AA64DFR0_TRBE_SHIFT        44
>>   #define ID_AA64DFR0_TRACE_FILT_SHIFT    40
>>   #define ID_AA64DFR0_DOUBLELOCK_SHIFT    36
>>   #define ID_AA64DFR0_PMSVER_SHIFT    32
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index c119824..0f5e101 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -156,6 +156,17 @@ config CORESIGHT_CTI
>>         To compile this driver as a module, choose M here: the
>>         module will be called coresight-cti.
>>   +config CORESIGHT_TRBE
>> +    bool "Trace Buffer Extension (TRBE) driver"
>> +    depends on ARM64
>> +    help
>> +      This driver provides support for percpu Trace Buffer Extension (TRBE).
>> +      TRBE always needs to be used along with it's corresponding percpu ETE
>> +      component. ETE generates trace data which is then captured with TRBE.
>> +      Unlike traditional sink devices, TRBE is a CPU feature accessible via
>> +      system registers. But it's explicit dependency with trace unit (ETE)
>> +      requires it to be plugged in as a coresight sink device.
>> +
>>   config CORESIGHT_CTI_INTEGRATION_REGS
>>       bool "Access CTI CoreSight Integration Registers"
>>       depends on CORESIGHT_CTI
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index f20e357..d608165 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -21,5 +21,6 @@ obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>>   obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>>   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>> +obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>   coresight-cti-y := coresight-cti-core.o    coresight-cti-platform.o \
>>              coresight-cti-sysfs.o
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> new file mode 100644
>> index 0000000..48a8ec3
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -0,0 +1,766 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * This driver enables Trace Buffer Extension (TRBE) as a per-cpu coresight
>> + * sink device could then pair with an appropriate per-cpu coresight source
>> + * device (ETE) thus generating required trace data. Trace can be enabled
>> + * via the perf framework.
>> + *
>> + * Copyright (C) 2020 ARM Ltd.
>> + *
>> + * Author: Anshuman Khandual <anshuman.khandual@arm.com>
>> + */
>> +#define DRVNAME "arm_trbe"
>> +
>> +#define pr_fmt(fmt) DRVNAME ": " fmt
>> +
>> +#include "coresight-trbe.h"
>> +
>> +#define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
>> +
>> +#define ETE_IGNORE_PACKET 0x70
> 
> Add a comment here, on what this means to the decoder.

Sure, will add.

> 
>> +
>> +static const char trbe_name[] = "trbe";
> 
> Why not
> 
> #define DEVNAME    "trbe"

That can be replaced but we already define DRVNAME which gets used for
naming the TRBE interrupt that shows up in /proc/interrupts. But it is
"arm_trbe" instead. Should /sys/bus/coresight/devices/ list TRBE devices
as "arm_trbeN" ? If so, DRVNAME can be used without any problem. Should
DRVNAME be changed to just "trbe" instead ? But it makes sense to have
the same name for TRBE devices and the interrupt.

> 
> 
>> +
>> +enum trbe_fault_action {
>> +    TRBE_FAULT_ACT_WRAP,
>> +    TRBE_FAULT_ACT_SPURIOUS,
>> +    TRBE_FAULT_ACT_FATAL,
>> +};
>> +
>> +struct trbe_perf {
> 
> Please rename this to trbe_buf. This will be used for sysfs mode as well.

Sure, will do.

> 
>> +    unsigned long trbe_base;
>> +    unsigned long trbe_limit;
>> +    unsigned long trbe_write;
>> +    pid_t pid;
> 
> Why do we need this ? This seems unused and moreover, there cannot
> be multiple tracers into TRBE. So, we don't need to share the sink
> unlike the traditional ones.

Sure, will drop.

> 
>> +    int nr_pages;
>> +    void **pages;
>> +    bool snapshot;
>> +    struct trbe_cpudata *cpudata;
>> +};
>> +
>> +struct trbe_cpudata {
>> +    struct coresight_device    *csdev;
>> +    bool trbe_dbm;
> 
> Why do we need this ?

This is an internal implementation characteristic which should be
presented to the user space via sysfs for better understanding and
probably for debug purpose. The current proposal does not support
the scenario when TRBE DBM is off, which we need to incorporate
later on. Hence lets just leave this as is for now.

> 
>> +    u64 trbe_align;
>> +    int cpu;
>> +    enum cs_mode mode;
>> +    struct trbe_perf *perf;
>> +    struct trbe_drvdata *drvdata;
>> +};
>> +
>> +struct trbe_drvdata {
>> +    struct trbe_cpudata __percpu *cpudata;
>> +    struct perf_output_handle __percpu *handle;
> 
> Shouldn't this be :
> 
>     struct perf_output_handle __percpu **handle ?
> 
> as we get a handle from the etm-perf and is not controlled by
> the TRBE ?

Sure, will change this.

> 
>> +    struct hlist_node hotplug_node;
>> +    int irq;
>> +    cpumask_t supported_cpus;
>> +    enum cpuhp_state trbe_online;
>> +    struct platform_device *pdev;
>> +    struct clk *atclk;
> 
> We don't have any clocks for the TRBE instance. Please remove.

Sure, will drop.

> 
>> +};
>> +
>> +static int trbe_alloc_node(struct perf_event *event)
>> +{
>> +    if (event->cpu == -1)
>> +        return NUMA_NO_NODE;
>> +    return cpu_to_node(event->cpu);
>> +}
>> +
>> +static void trbe_disable_and_drain_local(void)
>> +{
>> +    write_sysreg_s(0, SYS_TRBLIMITR_EL1);
>> +    isb();
>> +    dsb(nsh);
>> +    asm(TSB_CSYNC);
>> +}
>> +
>> +static void trbe_reset_local(void)
>> +{
>> +    trbe_disable_and_drain_local();
>> +    write_sysreg_s(0, SYS_TRBPTR_EL1);
>> +    isb();
>> +
>> +    write_sysreg_s(0, SYS_TRBBASER_EL1);
>> +    isb();
>> +
>> +    write_sysreg_s(0, SYS_TRBSR_EL1);
>> +    isb();
>> +}
>> +
>> +static void trbe_pad_buf(struct perf_output_handle *handle, int len)
>> +{
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +    u64 head = PERF_IDX2OFF(handle->head, perf);
>> +
>> +    memset((void *) perf->trbe_base + head, ETE_IGNORE_PACKET, len);
>> +    if (!perf->snapshot)
>> +        perf_aux_output_skip(handle, len);
>> +}
>> +
>> +static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +    u64 head = PERF_IDX2OFF(handle->head, perf);
>> +    u64 limit = perf->nr_pages * PAGE_SIZE;
>> +
> 
> So we are using half of the buffer for snapshot mode to avoid a case where the
> analyzer is unable to decode the trace in case of an overflow.

Right.

> 
>> +    if (head < limit >> 1)
>> +        limit >>= 1;
> 
> Also this needs to be thought out. We may not need this restriction. The trace decoder
> will be able to walk forward and then find a synchronization packet and then continue
> the tracing from there. So, we could use the entire buffer for TRBE.

Okay. May be we could just go with half the TRBE buffer for now and
later on, use the entire buffer after better understanding on this ?

> 
> 
>> +
>> +    return limit;
>> +}
>> +
>> +static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +    struct trbe_cpudata *cpudata = perf->cpudata;
>> +    const u64 bufsize = perf->nr_pages * PAGE_SIZE;
>> +    u64 limit = bufsize;
>> +    u64 head, tail, wakeup;
>> +
> 
> Commentary please.

Sure, will add some.

> 
>> +    head = PERF_IDX2OFF(handle->head, perf);
>> +    if (!IS_ALIGNED(head, cpudata->trbe_align)) {
>> +        unsigned long delta = roundup(head, cpudata->trbe_align) - head;
>> +
>> +        delta = min(delta, handle->size);
>> +        trbe_pad_buf(handle, delta);
>> +        head = PERF_IDX2OFF(handle->head, perf);
>> +    }
>> +
>> +    if (!handle->size) {
>> +        perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +        return 0;
>> +    }
>> +
>> +    tail = PERF_IDX2OFF(handle->head + handle->size, perf);
>> +    wakeup = PERF_IDX2OFF(handle->wakeup, perf);
>> +
> 
>> +    if (head < tail)
> 
>  comment
> 
>> +        limit = round_down(tail, PAGE_SIZE);
>> +
>> +    if (handle->wakeup < (handle->head + handle->size) && head <= wakeup)
>> +        limit = min(limit, round_up(wakeup, PAGE_SIZE));
> 
> comment. Also do we need an alignement to PAGE_SIZE ?

Limit has to be always PAGE_SIZE aligned because its eventually going
to be the TRBE limit pointer, after getting added into the TRBE base
pointer. Will add some more comment here as well.

> 
>> +
>> +    if (limit > head)
>> +        return limit;
>> +
>> +    trbe_pad_buf(handle, handle->size);
>> +    perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +    return 0;
>> +}
>> +
>> +static unsigned long get_trbe_limit(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +    unsigned long offset;
>> +
>> +    if (perf->snapshot)
>> +        offset = trbe_snapshot_offset(handle);
>> +    else
>> +        offset = trbe_normal_offset(handle);
>> +    return perf->trbe_base + offset;
>> +}
>> +
>> +static void trbe_enable_hw(struct trbe_perf *perf)
>> +{
>> +    WARN_ON(perf->trbe_write < perf->trbe_base);
>> +    WARN_ON(perf->trbe_write >= perf->trbe_limit);
>> +    set_trbe_disabled();
>> +    clr_trbe_irq();
>> +    clr_trbe_wrap();
>> +    clr_trbe_abort();
>> +    clr_trbe_ec();
>> +    clr_trbe_bsc();
>> +    clr_trbe_fsc();
> 
> Please merge all of these field updates to single register update
> unless mandated by the architecture.

Sure, will do.

> 
>> +    set_trbe_virtual_mode();
>> +    set_trbe_fill_mode(TRBE_FILL_STOP);
>> +    set_trbe_trig_mode(TRBE_TRIGGER_IGNORE);
> 
> Same here ^^

Sure, will do.

> 
>> +    isb();
>> +    set_trbe_base_pointer(perf->trbe_base);
>> +    set_trbe_limit_pointer(perf->trbe_limit);
>> +    set_trbe_write_pointer(perf->trbe_write);
>> +    isb();
>> +    dsb(ishst);
>> +    flush_tlb_all();
> 
> Why is this needed ?

Will drop flush_tlb_all().

> 
>> +    set_trbe_running();
>> +    set_trbe_enabled();
>> +    asm(TSB_CSYNC);
>> +}
>> +
>> +static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>> +                   struct perf_event *event, void **pages,
>> +                   int nr_pages, bool snapshot)
>> +{
>> +    struct trbe_perf *perf;
>> +    struct page **pglist;
>> +    int i;
>> +
>> +    if ((nr_pages < 2) || (snapshot && (nr_pages & 1)))
> 
> We may be able to remove the restriction on snapshot mode, see my comment
> above.

Sure, will drop when the entire buffer is used for the snapshot mode.

> 
>> +        return NULL;
>> +
>> +    perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, trbe_alloc_node(event));
>> +    if (IS_ERR(perf))
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
>> +    if (IS_ERR(pglist)) {
>> +        kfree(perf);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +
>> +    for (i = 0; i < nr_pages; i++)
>> +        pglist[i] = virt_to_page(pages[i]);
>> +
>> +    perf->trbe_base = (unsigned long) vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>> +    if (IS_ERR((void *) perf->trbe_base)) {
>> +        kfree(pglist);
>> +        kfree(perf);
>> +        return ERR_PTR(perf->trbe_base);
>> +    }
>> +    perf->trbe_limit = perf->trbe_base + nr_pages * PAGE_SIZE;
>> +    perf->trbe_write = perf->trbe_base;
>> +    perf->pid = task_pid_nr(event->owner);
>> +    perf->snapshot = snapshot;
>> +    perf->nr_pages = nr_pages;
>> +    perf->pages = pages;
>> +    kfree(pglist);
>> +    return perf;
>> +}
>> +
>> +void arm_trbe_free_buffer(void *config)
>> +{
>> +    struct trbe_perf *perf = config;
>> +
>> +    vunmap((void *) perf->trbe_base);
>> +    kfree(perf);
>> +}
>> +
>> +static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>> +                        struct perf_output_handle *handle,
>> +                        void *config)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>> +    struct trbe_perf *perf = config;
>> +    unsigned long size, offset;
>> +
>> +    WARN_ON(perf->cpudata != cpudata);
>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>> +    WARN_ON(cpudata->mode != CS_MODE_PERF);
>> +    WARN_ON(cpudata->drvdata != drvdata);
>> +
>> +    offset = get_trbe_write_pointer() - get_trbe_base_pointer();
>> +    size = offset - PERF_IDX2OFF(handle->head, perf);
>> +    if (perf->snapshot)
>> +        handle->head += size;
>> +    return size;
>> +}
>> +
>> +static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>> +    struct perf_output_handle *handle = data;
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +
>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>> +    WARN_ON(mode != CS_MODE_PERF);
> 
> Why WARN_ON ? Simply return -EINVAL ? Also you need a check to make sure
> the mode is DISABLED (when you get to sysfs mode).
> 
>> +    WARN_ON(cpudata->drvdata != drvdata);
>> +
>> +    *this_cpu_ptr(drvdata->handle) = *handle;
> 
> That is wrong. Storing a local copy of a global perf generic structure
> is calling for trouble, assuming that the global structure doesn't change
> beneath us. Please store handle ptr.

Sure, will change.

> 
>> +    cpudata->perf = perf;
>> +    cpudata->mode = mode;
>> +    perf->cpudata = cpudata;
>> +    perf->trbe_write = perf->trbe_base + PERF_IDX2OFF(handle->head, perf);
>> +    perf->trbe_limit = get_trbe_limit(handle);
>> +    if (perf->trbe_limit == perf->trbe_base) {
>> +        trbe_disable_and_drain_local();
>> +        return 0;
>> +    }
>> +    trbe_enable_hw(perf);
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_disable(struct coresight_device *csdev)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>> +    struct trbe_perf *perf = cpudata->perf;
>> +
>> +    WARN_ON(perf->cpudata != cpudata);
>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>> +    WARN_ON(cpudata->mode != CS_MODE_PERF);
>> +    WARN_ON(cpudata->drvdata != drvdata);
>> +
>> +    trbe_disable_and_drain_local();
>> +    perf->cpudata = NULL;
>> +    cpudata->perf = NULL;
>> +    cpudata->mode = CS_MODE_DISABLED;
>> +    return 0;
>> +}
>> +
>> +static void trbe_handle_fatal(struct perf_output_handle *handle)
>> +{
>> +    perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +    perf_aux_output_end(handle, 0);
>> +    trbe_disable_and_drain_local();
>> +}
>> +
>> +static void trbe_handle_spurious(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +
>> +    perf->trbe_write = perf->trbe_base + PERF_IDX2OFF(handle->head, perf);
>> +    perf->trbe_limit = get_trbe_limit(handle);
>> +    if (perf->trbe_limit == perf->trbe_base) {
>> +        trbe_disable_and_drain_local();
>> +        return;
>> +    }
>> +    trbe_enable_hw(perf);
>> +}
>> +
>> +static void trbe_handle_overflow(struct perf_output_handle *handle)
>> +{
>> +    struct perf_event *event = handle->event;
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +    unsigned long offset, size;
>> +    struct etm_event_data *event_data;
>> +
>> +    offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
>> +    size = offset - PERF_IDX2OFF(handle->head, perf);
>> +    if (perf->snapshot)
>> +        handle->head = offset;
> 
> Is this correct ? Or was this supposed to mean :
>         handle->head += offset;

Hmm, not too sure about this but the SPE driver does the same in
arm_spe_perf_aux_output_end().

> 
> 
>> +    perf_aux_output_end(handle, size);
>> +
>> +    event_data = perf_aux_output_begin(handle, event);
>> +    if (!event_data) {
>> +        event->hw.state |= PERF_HES_STOPPED;
>> +        trbe_disable_and_drain_local();
>> +        return;
>> +    }
>> +    perf->trbe_write = perf->trbe_base;
>> +    perf->trbe_limit = get_trbe_limit(handle);
>> +    if (perf->trbe_limit == perf->trbe_base) {
>> +        trbe_disable_and_drain_local();
>> +        return;
>> +    }
>> +    *this_cpu_ptr(perf->cpudata->drvdata->handle) = *handle;
>> +    trbe_enable_hw(perf);
>> +}
>> +
>> +static bool is_perf_trbe(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_perf *perf = etm_perf_sink_config(handle);
>> +    struct trbe_cpudata *cpudata = perf->cpudata;
>> +    struct trbe_drvdata *drvdata = cpudata->drvdata;
> 
> Can you trust the cpudata ptr here as we are still verifying
> if this was legitimate ?

It verifies the legitimacy of the interrupt as being generated from
an active perf session on the cpu with some simple sanity checks.
But all data structure linkage should be intact. The perf handle
originates from the drvdata percpu structure which should have a
trbe_perf and everything flows from there.

> 
>> +    int cpu = smp_processor_id();
>> +
>> +    WARN_ON(perf->trbe_base != get_trbe_base_pointer());
>> +    WARN_ON(perf->trbe_limit != get_trbe_limit_pointer());
>> +
>> +    if (cpudata->mode != CS_MODE_PERF)
>> +        return false;
>> +
>> +    if (cpudata->cpu != cpu)
>> +        return false;
>> +
>> +    if (!cpumask_test_cpu(cpu, &drvdata->supported_cpus))
>> +        return false;
>> +
>> +    return true;
>> +}
>> +
>> +static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle)
>> +{
>> +    enum trbe_ec ec = get_trbe_ec();
>> +    enum trbe_bsc bsc = get_trbe_bsc();
>> +
>> +    WARN_ON(is_trbe_running());
>> +    asm(TSB_CSYNC);
>> +    dsb(nsh);
>> +    isb();
>> +
>> +    if (is_trbe_trg() || is_trbe_abort())
>> +        return TRBE_FAULT_ACT_FATAL;
>> +
>> +    if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
>> +        return TRBE_FAULT_ACT_FATAL;
>> +
>> +    if (is_trbe_wrap() && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
>> +        if (get_trbe_write_pointer() == get_trbe_base_pointer())
>> +            return TRBE_FAULT_ACT_WRAP;
>> +    }
>> +    return TRBE_FAULT_ACT_SPURIOUS;
>> +}
>> +
>> +static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
>> +{
>> +    struct perf_output_handle *handle = dev;
>> +    enum trbe_fault_action act;
>> +
>> +    WARN_ON(!is_trbe_irq());
>> +    clr_trbe_irq();
>> +
>> +    if (!perf_get_aux(handle))
>> +        return IRQ_NONE;
>> +
>> +    if (!is_perf_trbe(handle))
>> +        return IRQ_NONE;
>> +
>> +    irq_work_run();
>> +
>> +    act = trbe_get_fault_act(handle);
>> +    switch (act) {
>> +    case TRBE_FAULT_ACT_WRAP:
>> +        trbe_handle_overflow(handle);
>> +        break;
>> +    case TRBE_FAULT_ACT_SPURIOUS:
>> +        trbe_handle_spurious(handle);
>> +        break;
>> +    case TRBE_FAULT_ACT_FATAL:
>> +        trbe_handle_fatal(handle);
>> +        break;
>> +    }
>> +    return IRQ_HANDLED;
>> +}
>> +
> 
> 
>> +static void arm_trbe_probe_coresight_cpu(void *info)
>> +{
>> +    struct trbe_cpudata *cpudata = info;
>> +    struct device *dev = &cpudata->drvdata->pdev->dev;
>> +    struct coresight_desc desc = { 0 };
>> +
>> +    if (WARN_ON(!cpudata))
>> +        goto cpu_clear;
>> +
>> +    if (!is_trbe_available()) {
>> +        pr_err("TRBE is not implemented on cpu %d\n", cpudata->cpu);
>> +        goto cpu_clear;
>> +    }
>> +
>> +    if (!is_trbe_programmable()) {
>> +        pr_err("TRBE is owned in higher exception level on cpu %d\n", cpudata->cpu);
>> +        goto cpu_clear;
>> +    }
>> +    desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", trbe_name, smp_processor_id());
>> +    if (IS_ERR(desc.name))
>> +        goto cpu_clear;
>> +
>> +    desc.type = CORESIGHT_DEV_TYPE_SINK;
>> +    desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
> 
> May be should add a new subtype to make this higher priority than the normal ETR.
> Something like :
> 
>     CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM

Sure, will do.

> 
>> +    desc.ops = &arm_trbe_cs_ops;
>> +    desc.pdata = dev_get_platdata(dev);
>> +    desc.groups = arm_trbe_groups;
>> +    desc.dev = dev;
>> +    cpudata->csdev = coresight_register(&desc);
>> +    if (IS_ERR(cpudata->csdev))
>> +        goto cpu_clear;
>> +
>> +    dev_set_drvdata(&cpudata->csdev->dev, cpudata);
>> +    cpudata->trbe_dbm = get_trbe_flag_update();
>> +    cpudata->trbe_align = 1ULL << get_trbe_address_align();
>> +    if (cpudata->trbe_align > SZ_2K) {
>> +        pr_err("Unsupported alignment on cpu %d\n", cpudata->cpu);
>> +        goto cpu_clear;
>> +    }
>> +    return;
>> +cpu_clear:
>> +    cpumask_clear_cpu(cpudata->cpu, &cpudata->drvdata->supported_cpus);
>> +}
>> +
>> +static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
>> +{
>> +    struct trbe_cpudata *cpudata;
>> +    int cpu;
>> +
>> +    drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
>> +    if (IS_ERR(drvdata->cpudata))
>> +        return PTR_ERR(drvdata->cpudata);
>> +
>> +    for_each_cpu(cpu, &drvdata->supported_cpus) {
>> +        cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +        cpudata->cpu = cpu;
>> +        cpudata->drvdata = drvdata;
>> +        smp_call_function_single(cpu, arm_trbe_probe_coresight_cpu, cpudata, 1);
> 
> We could batch it and run it on all CPUs at the same time ? Also it would be better to
> leave the per_cpu area filled by the CPU itself, to avoid racing.

Sure, will re-organize the entire CPU probing/removal and also the CPU
online/offline path. Planning to use smp_call_function_many() instead
for a simultaneous init. 

> 
> 
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void arm_trbe_remove_coresight_cpu(void *info)
>> +{
>> +    struct trbe_drvdata *drvdata = info;
>> +
>> +    disable_percpu_irq(drvdata->irq);
>> +}
>> +
>> +static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
>> +{
>> +    struct trbe_cpudata *cpudata;
>> +    int cpu;
>> +
>> +    for_each_cpu(cpu, &drvdata->supported_cpus) {
>> +        smp_call_function_single(cpu, arm_trbe_remove_coresight_cpu, drvdata, 1);
>> +        cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +        if (cpudata->csdev) {
>> +            coresight_unregister(cpudata->csdev);
>> +            cpudata->drvdata = NULL;
>> +            cpudata->csdev = NULL;
>> +        }
> 
> Please leave this to the CPU to do the part.

Sure, will do.

> 
>> +    }
>> +    free_percpu(drvdata->cpudata);
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
>> +{
>> +    struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
>> +    struct trbe_cpudata *cpudata;
>> +
>> +    if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
>> +        cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +        if (!cpudata->csdev) {
>> +            cpudata->drvdata = drvdata;
>> +            smp_call_function_single(cpu, arm_trbe_probe_coresight_cpu, cpudata, 1);
> 
> Why do we need smp_call here ? We are already on the CPU.

We dont need, will drop.

> 
>> +        }
>> +        trbe_reset_local();
>> +        enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>> +{
>> +    struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
>> +    struct trbe_cpudata *cpudata;
>> +
>> +    if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
>> +        cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +        if (cpudata->csdev) {
>> +            coresight_unregister(cpudata->csdev);
>> +            cpudata->drvdata = NULL;
>> +            cpudata->csdev = NULL;
>> +        }
>> +        disable_percpu_irq(drvdata->irq);
>> +        trbe_reset_local();
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_probe_cpuhp(struct trbe_drvdata *drvdata)
>> +{
>> +    enum cpuhp_state trbe_online;
>> +
>> +    trbe_online = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
>> +                    arm_trbe_cpu_startup, arm_trbe_cpu_teardown);
>> +    if (trbe_online < 0)
>> +        return -EINVAL;
>> +
>> +    if (cpuhp_state_add_instance(trbe_online, &drvdata->hotplug_node))
>> +        return -EINVAL;
>> +
>> +    drvdata->trbe_online = trbe_online;
>> +    return 0;
>> +}
>> +
>> +static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
>> +{
>> +    cpuhp_remove_multi_state(drvdata->trbe_online);
>> +}
>> +
>> +static int arm_trbe_probe_irq(struct platform_device *pdev,
>> +                  struct trbe_drvdata *drvdata)
>> +{
>> +    drvdata->irq = platform_get_irq(pdev, 0);
>> +    if (!drvdata->irq) {
>> +        pr_err("IRQ not found for the platform device\n");
>> +        return -ENXIO;
>> +    }
>> +
>> +    if (!irq_is_percpu(drvdata->irq)) {
>> +        pr_err("IRQ is not a PPI\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
>> +        return -EINVAL;
>> +
>> +    drvdata->handle = alloc_percpu(typeof(*drvdata->handle));
>> +    if (!drvdata->handle)
>> +        return -ENOMEM;
>> +
>> +    if (request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drvdata->handle)) {
>> +        free_percpu(drvdata->handle);
>> +        return -EINVAL;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
>> +{
>> +    free_percpu_irq(drvdata->irq, drvdata->handle);
>> +    free_percpu(drvdata->handle);
>> +}
>> +
>> +static int arm_trbe_device_probe(struct platform_device *pdev)
>> +{
>> +    struct coresight_platform_data *pdata;
>> +    struct trbe_drvdata *drvdata;
>> +    struct device *dev = &pdev->dev;
>> +    int ret;
>> +
>> +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +    if (IS_ERR(drvdata))
>> +        return -ENOMEM;
>> +
>> +    pdata = coresight_get_platform_data(dev);
>> +    if (IS_ERR(pdata)) {
>> +        kfree(drvdata);
>> +        return -ENOMEM;
>> +    }
> 
> 
>> +
>> +    drvdata->atclk = devm_clk_get(dev, "atclk");
>> +    if (!IS_ERR(drvdata->atclk)) {
>> +        ret = clk_prepare_enable(drvdata->atclk);
>> +        if (ret)
>> +            return ret;
>> +    }
> 
> Please drop the clocks, we don't have any

Right, will drop the clock and also the power management support
along with it.

> 
>> +    dev_set_drvdata(dev, drvdata);
>> +    dev->platform_data = pdata;
>> +    drvdata->pdev = pdev;
>> +    ret = arm_trbe_probe_irq(pdev, drvdata);
>> +    if (ret)
>> +        goto irq_failed;
>> +
>> +    ret = arm_trbe_probe_coresight(drvdata);
>> +    if (ret)
>> +        goto probe_failed;
>> +
>> +    ret = arm_trbe_probe_cpuhp(drvdata);
>> +    if (ret)
>> +        goto cpuhp_failed;
>> +
>> +    return 0;
>> +cpuhp_failed:
>> +    arm_trbe_remove_coresight(drvdata);
>> +probe_failed:
>> +    arm_trbe_remove_irq(drvdata);
>> +irq_failed:
>> +    kfree(pdata);
>> +    kfree(drvdata);
>> +    return ret;
>> +}
>> +
>> +static int arm_trbe_device_remove(struct platform_device *pdev)
>> +{
>> +    struct coresight_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> +    struct trbe_drvdata *drvdata = platform_get_drvdata(pdev);
>> +
>> +    arm_trbe_remove_coresight(drvdata);
>> +    arm_trbe_remove_cpuhp(drvdata);
>> +    arm_trbe_remove_irq(drvdata);
>> +    kfree(pdata);
>> +    kfree(drvdata);
>> +    return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int arm_trbe_runtime_suspend(struct device *dev)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +    if (drvdata && !IS_ERR(drvdata->atclk))
>> +        clk_disable_unprepare(drvdata->atclk);
>> +
> 
> Remove. We may need to save/restore the TRBE ptrs, depending on the
> TRBE.

Will drop it for now. Could revisit this later after the base
functionality is up and running.

> 
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_runtime_resume(struct device *dev)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +    if (drvdata && !IS_ERR(drvdata->atclk))
>> +        clk_prepare_enable(drvdata->atclk);
> 
> Remove. See above.
> 
>> +
>> +    return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops arm_trbe_dev_pm_ops = {
>> +    SET_RUNTIME_PM_OPS(arm_trbe_runtime_suspend, arm_trbe_runtime_resume, NULL)
>> +};
>> +
>> +static const struct of_device_id arm_trbe_of_match[] = {
>> +    { .compatible = "arm,arm-trbe",    .data = (void *)1 },
>> +    {},
>> +};
> 
> I think it is better to call this, we have too many acronyms ;-)
> 
>     "arm,trace-buffer-extension"

Sure, will change.

> 
>> +MODULE_DEVICE_TABLE(of, arm_trbe_of_match);
> 
>> +
>> +static const struct platform_device_id arm_trbe_match[] = {
>> +    { "arm,trbe", 0},
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(platform, arm_trbe_match);
> 
> Please remove. The ACPI part can be added when we get to it.

Sure, will drop for now.

> 
>> +
>> +static struct platform_driver arm_trbe_driver = {
>> +    .id_table = arm_trbe_match,
>> +    .driver    = {
>> +        .name = DRVNAME,
>> +        .of_match_table = of_match_ptr(arm_trbe_of_match),
>> +        .pm = &arm_trbe_dev_pm_ops,
>> +        .suppress_bind_attrs = true,
>> +    },
>> +    .probe    = arm_trbe_device_probe,
>> +    .remove    = arm_trbe_device_remove,
>> +};
>> +builtin_platform_driver(arm_trbe_driver)
> 
> Please make this modular.

Will do.

> 
> 
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
>> new file mode 100644
>> index 0000000..82ffbfc
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
>> @@ -0,0 +1,525 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This contains all required hardware related helper functions for
>> + * Trace Buffer Extension (TRBE) driver in the coresight framework.
>> + *
>> + * Copyright (C) 2020 ARM Ltd.
>> + *
>> + * Author: Anshuman Khandual <anshuman.khandual@arm.com>
>> + */
>> +#include <linux/coresight.h>
>> +#include <linux/device.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/smp.h>
>> +
>> +#include "coresight-etm-perf.h"
>> +
>> +static inline bool is_trbe_available(void)
>> +{
>> +    u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>> +    int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_TRBE_SHIFT);
>> +
>> +    return trbe >= 0b0001;
>> +}
>> +
>> +static inline bool is_ete_available(void)
>> +{
>> +    u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>> +    int tracever = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_TRACEVER_SHIFT);
>> +
>> +    return (tracever != 0b0000);
> 
> Why is this needed ?

Sure, will drop.

> 
>> +}
>> +
>> +static inline bool is_trbe_enabled(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    return trblimitr & TRBLIMITR_ENABLE;
>> +}
>> +
>> +enum trbe_ec {
>> +    TRBE_EC_OTHERS        = 0,
>> +    TRBE_EC_STAGE1_ABORT    = 36,
>> +    TRBE_EC_STAGE2_ABORT    = 37,
>> +};
>> +
>> +static const char *const trbe_ec_str[] = {
>> +    [TRBE_EC_OTHERS]    = "Maintenance exception",
>> +    [TRBE_EC_STAGE1_ABORT]    = "Stage-1 exception",
>> +    [TRBE_EC_STAGE2_ABORT]    = "Stage-2 exception",
>> +};
>> +
> 
> Please remove the defintions that are not used by the driver.

Sure, will do.

> 
>> +static inline enum trbe_ec get_trbe_ec(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return (trbsr >> TRBSR_EC_SHIFT) & TRBSR_EC_MASK;
>> +}
>> +
>> +static inline void clr_trbe_ec(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>> +}
>> +
>> +enum trbe_bsc {
>> +    TRBE_BSC_NOT_STOPPED    = 0,
>> +    TRBE_BSC_FILLED        = 1,
>> +    TRBE_BSC_TRIGGERED    = 2,
>> +};
>> +
>> +static const char *const trbe_bsc_str[] = {
>> +    [TRBE_BSC_NOT_STOPPED]    = "TRBE collection not stopped",
>> +    [TRBE_BSC_FILLED]    = "TRBE filled",
>> +    [TRBE_BSC_TRIGGERED]    = "TRBE triggered",
>> +};
>> +
>> +static inline enum trbe_bsc get_trbe_bsc(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return (trbsr >> TRBSR_BSC_SHIFT) & TRBSR_BSC_MASK;
>> +}
>> +
>> +static inline void clr_trbe_bsc(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>> +}
>> +
>> +enum trbe_fsc {
>> +    TRBE_FSC_ASF_LEVEL0    = 0,
>> +    TRBE_FSC_ASF_LEVEL1    = 1,
>> +    TRBE_FSC_ASF_LEVEL2    = 2,
>> +    TRBE_FSC_ASF_LEVEL3    = 3,
>> +    TRBE_FSC_TF_LEVEL0    = 4,
>> +    TRBE_FSC_TF_LEVEL1    = 5,
>> +    TRBE_FSC_TF_LEVEL2    = 6,
>> +    TRBE_FSC_TF_LEVEL3    = 7,
>> +    TRBE_FSC_AFF_LEVEL0    = 8,
>> +    TRBE_FSC_AFF_LEVEL1    = 9,
>> +    TRBE_FSC_AFF_LEVEL2    = 10,
>> +    TRBE_FSC_AFF_LEVEL3    = 11,
>> +    TRBE_FSC_PF_LEVEL0    = 12,
>> +    TRBE_FSC_PF_LEVEL1    = 13,
>> +    TRBE_FSC_PF_LEVEL2    = 14,
>> +    TRBE_FSC_PF_LEVEL3    = 15,
>> +    TRBE_FSC_SEA_WRITE    = 16,
>> +    TRBE_FSC_ASEA_WRITE    = 17,
>> +    TRBE_FSC_SEA_LEVEL0    = 20,
>> +    TRBE_FSC_SEA_LEVEL1    = 21,
>> +    TRBE_FSC_SEA_LEVEL2    = 22,
>> +    TRBE_FSC_SEA_LEVEL3    = 23,
>> +    TRBE_FSC_ALIGN_FAULT    = 33,
>> +    TRBE_FSC_TLB_FAULT    = 48,
>> +    TRBE_FSC_ATOMIC_FAULT    = 49,
>> +};
> 
> Please remove ^^^

Sure, will do.

> 
>> +
>> +static const char *const trbe_fsc_str[] = {
>> +    [TRBE_FSC_ASF_LEVEL0]    = "Address size fault - level 0",
>> +    [TRBE_FSC_ASF_LEVEL1]    = "Address size fault - level 1",
>> +    [TRBE_FSC_ASF_LEVEL2]    = "Address size fault - level 2",
>> +    [TRBE_FSC_ASF_LEVEL3]    = "Address size fault - level 3",
>> +    [TRBE_FSC_TF_LEVEL0]    = "Translation fault - level 0",
>> +    [TRBE_FSC_TF_LEVEL1]    = "Translation fault - level 1",
>> +    [TRBE_FSC_TF_LEVEL2]    = "Translation fault - level 2",
>> +    [TRBE_FSC_TF_LEVEL3]    = "Translation fault - level 3",
>> +    [TRBE_FSC_AFF_LEVEL0]    = "Access flag fault - level 0",
>> +    [TRBE_FSC_AFF_LEVEL1]    = "Access flag fault - level 1",
>> +    [TRBE_FSC_AFF_LEVEL2]    = "Access flag fault - level 2",
>> +    [TRBE_FSC_AFF_LEVEL3]    = "Access flag fault - level 3",
>> +    [TRBE_FSC_PF_LEVEL0]    = "Permission fault - level 0",
>> +    [TRBE_FSC_PF_LEVEL1]    = "Permission fault - level 1",
>> +    [TRBE_FSC_PF_LEVEL2]    = "Permission fault - level 2",
>> +    [TRBE_FSC_PF_LEVEL3]    = "Permission fault - level 3",
>> +    [TRBE_FSC_SEA_WRITE]    = "Synchronous external abort on write",
>> +    [TRBE_FSC_ASEA_WRITE]    = "Asynchronous external abort on write",
>> +    [TRBE_FSC_SEA_LEVEL0]    = "Syncrhonous external abort on table walk - level 0",
>> +    [TRBE_FSC_SEA_LEVEL1]    = "Syncrhonous external abort on table walk - level 1",
>> +    [TRBE_FSC_SEA_LEVEL2]    = "Syncrhonous external abort on table walk - level 2",
>> +    [TRBE_FSC_SEA_LEVEL3]    = "Syncrhonous external abort on table walk - level 3",
>> +    [TRBE_FSC_ALIGN_FAULT]    = "Alignment fault",
>> +    [TRBE_FSC_TLB_FAULT]    = "TLB conflict fault",
>> +    [TRBE_FSC_ATOMIC_FAULT]    = "Atmoc fault",
>> +};
>>
> 
> Please remove ^^^

Sure, will do.

> 
>>
> 
>> +enum trbe_address_mode {
>> +    TRBE_ADDRESS_VIRTUAL,
>> +    TRBE_ADDRESS_PHYSICAL,
>> +};
> 
> #define please.
> 
>> +
>> +static const char *const trbe_address_mode_str[] = {
>> +    [TRBE_ADDRESS_VIRTUAL]    = "Address mode - virtual",
>> +    [TRBE_ADDRESS_PHYSICAL]    = "Address mode - physical",
>> +};
> 
> Do we need this ? We always use virtual.
> 
>> +
>> +static inline bool is_trbe_virtual_mode(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    return !(trblimitr & TRBLIMITR_NVM);
>> +}
>> +
> 
> Remove

Sure, will do.

> 
>> +static inline bool is_trbe_physical_mode(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    return trblimitr & TRBLIMITR_NVM;
>> +}
> 
> Remove

Sure, will do.

> 
>> +
>> +static inline void set_trbe_virtual_mode(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    trblimitr &= ~TRBLIMITR_NVM;
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
>> +
> 
>> +static inline void set_trbe_physical_mode(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    trblimitr |= TRBLIMITR_NVM;
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
> 
> Remove

Sure, will do.

> 
>> +
>> +enum trbe_trig_mode {
>> +    TRBE_TRIGGER_STOP    = 0,
>> +    TRBE_TRIGGER_IRQ    = 1,
>> +    TRBE_TRIGGER_IGNORE    = 3,
>> +};
>> +
>> +static const char *const trbe_trig_mode_str[] = {
>> +    [TRBE_TRIGGER_STOP]    = "Trigger mode - stop",
>> +    [TRBE_TRIGGER_IRQ]    = "Trigger mode - irq",
>> +    [TRBE_TRIGGER_IGNORE]    = "Trigger mode - ignore",
>> +};
>> +
>> +static inline enum trbe_trig_mode get_trbe_trig_mode(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    return (trblimitr >> TRBLIMITR_TRIG_MODE_SHIFT) & TRBLIMITR_TRIG_MODE_MASK;
>> +}
>> +
>> +static inline void set_trbe_trig_mode(enum trbe_trig_mode mode)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
>> +    trblimitr |= ((mode & TRBLIMITR_TRIG_MODE_MASK) << TRBLIMITR_TRIG_MODE_SHIFT);
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
>> +
>> +enum trbe_fill_mode {
>> +    TRBE_FILL_STOP        = 0,
>> +    TRBE_FILL_WRAP        = 1,
>> +    TRBE_FILL_CIRCULAR    = 3,
>> +};
>> +
> 
> Please use #define

These are predefined constrained values which kind of makes them
a set. An enumeration seems to be a better representation.

> 
>> +static const char *const trbe_fill_mode_str[] = {
>> +    [TRBE_FILL_STOP]    = "Buffer mode - stop",
>> +    [TRBE_FILL_WRAP]    = "Buffer mode - wrap",
>> +    [TRBE_FILL_CIRCULAR]    = "Buffer mode - circular",
>> +};
>> +
>> +static inline enum trbe_fill_mode get_trbe_fill_mode(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    return (trblimitr >> TRBLIMITR_FILL_MODE_SHIFT) & TRBLIMITR_FILL_MODE_MASK;
>> +}
>> +
>> +static inline void set_trbe_fill_mode(enum trbe_fill_mode mode)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
>> +    trblimitr |= ((mode & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT);
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
>> +
>> +static inline void set_trbe_disabled(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    trblimitr &= ~TRBLIMITR_ENABLE;
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
>> +
>> +static inline void set_trbe_enabled(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    trblimitr |= TRBLIMITR_ENABLE;
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
>> +
>> +static inline bool get_trbe_flag_update(void)
>> +{
>> +    u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
>> +
>> +    return trbidr & TRBIDR_FLAG;
>> +}
>> +
>> +static inline bool is_trbe_programmable(void)
>> +{
>> +    u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
>> +
>> +    return !(trbidr & TRBIDR_PROG);
>> +}
>> +#
>> +enum trbe_buffer_align {
>> +    TRBE_BUFFER_BYTE,
>> +    TRBE_BUFFER_HALF_WORD,
>> +    TRBE_BUFFER_WORD,
>> +    TRBE_BUFFER_DOUBLE_WORD,
>> +    TRBE_BUFFER_16_BYTES,
>> +    TRBE_BUFFER_32_BYTES,
>> +    TRBE_BUFFER_64_BYTES,
>> +    TRBE_BUFFER_128_BYTES,
>> +    TRBE_BUFFER_256_BYTES,
>> +    TRBE_BUFFER_512_BYTES,
>> +    TRBE_BUFFER_1K_BYTES,
>> +    TRBE_BUFFER_2K_BYTES,
>> +};
>> +
> 
> Remove ^^

Sure, will do.

> 
>> +static const char *const trbe_buffer_align_str[] = {
>> +    [TRBE_BUFFER_BYTE]        = "Byte",
>> +    [TRBE_BUFFER_HALF_WORD]        = "Half word",
>> +    [TRBE_BUFFER_WORD]        = "Word",
>> +    [TRBE_BUFFER_DOUBLE_WORD]    = "Double word",
>> +    [TRBE_BUFFER_16_BYTES]        = "16 bytes",
>> +    [TRBE_BUFFER_32_BYTES]        = "32 bytes",
>> +    [TRBE_BUFFER_64_BYTES]        = "64 bytes",
>> +    [TRBE_BUFFER_128_BYTES]        = "128 bytes",
>> +    [TRBE_BUFFER_256_BYTES]        = "256 bytes",
>> +    [TRBE_BUFFER_512_BYTES]        = "512 bytes",
>> +    [TRBE_BUFFER_1K_BYTES]        = "1K bytes",
>> +    [TRBE_BUFFER_2K_BYTES]        = "2K bytes",
>> +};
> 
> We don't need any of this. We could simply "<<" and get the
> size.

Dropping all these, we will just export the hex value in the sysfs
not a string from here.

> 
> 
>> +
>> +static inline enum trbe_buffer_align get_trbe_address_align(void)
>> +{
>> +    u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
>> +
>> +    return (trbidr >> TRBIDR_ALIGN_SHIFT) & TRBIDR_ALIGN_MASK;
>> +}
>> +
>> +static inline void assert_trbe_address_mode(unsigned long addr)
>> +{
>> +    bool virt_addr = virt_addr_valid(addr) || is_vmalloc_addr((void *)addr);
>> +    bool virt_mode = is_trbe_virtual_mode();
>> +
>> +    WARN_ON(addr && ((virt_addr && !virt_mode) || (!virt_addr && virt_mode)));
>> +}
> 
> I am not sure if this is really helpful. You have to trust the kernel vmalloc().

Okay, dropping both address asserts i.e mode and alignment.

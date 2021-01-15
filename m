Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70E2F7231
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbhAOF3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:29:44 -0500
Received: from foss.arm.com ([217.140.110.172]:60292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbhAOF3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:29:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7210CED1;
        Thu, 14 Jan 2021 21:28:53 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF4113F70D;
        Thu, 14 Jan 2021 21:28:50 -0800 (PST)
Subject: Re: [PATCH V2 10/11] coresight: sink: Add TRBE driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-11-git-send-email-anshuman.khandual@arm.com>
 <fbcf3c8f-f4c1-bf7f-35ae-e06d3d372cae@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <43bc1738-040c-1e48-b8f1-d337dcfcff2e@arm.com>
Date:   Fri, 15 Jan 2021 10:59:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fbcf3c8f-f4c1-bf7f-35ae-e06d3d372cae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/21 8:58 PM, Suzuki K Poulose wrote:
> Hi Anshuman,
> 
> The driver looks overall good to me. Please find some minor comments below
> 
> On 1/13/21 4:18 AM, Anshuman Khandual wrote:
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
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
>> - Dropped irq from coresight sysfs documentation
>> - Renamed get_trbe_limit() as compute_trbe_buffer_limit()
>> - Dropped SYSTEM_RUNNING check for system_state
>> - Dropped .data value from arm_trbe_of_match[]
>> - Dropped [set|get]_trbe_[trig|fill]_mode() helpers
>> - Dropped clearing TRBSR_FSC_MASK from TRBE status register
>> - Added a comment in arm_trbe_update_buffer()
>> - Updated comment for ETE_IGNORE_PACKET
>> - Updated comment for basic TRBE operation
>> - Updated TRBE buffer and trigger mode macros
>> - Restructured trbe_enable_hw()
>> - Updated trbe_snapshot_offset() to use the entire buffer
>> - Changed dsb(ish) as dsb(nsh) during the buffer flush
>> - Renamed set_trbe_flush() as trbe_drain_buffer()
>> - Renamed trbe_disable_and_drain_local() as trbe_drain_and_disable_local()
>> - Reworked sync in trbe_enable_hw(), trbe_update_buffer() and arm_trbe_irq_handler()
>>
>>   Documentation/trace/coresight/coresight-trbe.rst |  39 +
>>   arch/arm64/include/asm/sysreg.h                  |   2 +
>>   drivers/hwtracing/coresight/Kconfig              |  11 +
>>   drivers/hwtracing/coresight/Makefile             |   1 +
>>   drivers/hwtracing/coresight/coresight-trbe.c     | 966 +++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-trbe.h     | 216 +++++
>>   6 files changed, 1235 insertions(+)
>>   create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>>   create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>>   create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>>
>> diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Documentation/trace/coresight/coresight-trbe.rst
>> new file mode 100644
>> index 0000000..1cbb819
>> --- /dev/null
>> +++ b/Documentation/trace/coresight/coresight-trbe.rst
>> @@ -0,0 +1,39 @@
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
>> +The TRBE is not compliant to CoreSight architecture specifications, but is
>> +driven via the CoreSight driver framework to support the ETE (which is
>> +CoreSight compliant) integration.
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
>> +        align dbm
>> +
>> +*Key file items are:-*
>> +   * ``align``: TRBE write pointer alignment
>> +   * ``dbm``: TRBE updates memory with access and dirty flags
>> +
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index d60750e7..d7e65f0 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -97,6 +97,7 @@
>>   #define SET_PSTATE_UAO(x)        __emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
>>   #define SET_PSTATE_SSBS(x)        __emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
>>   #define SET_PSTATE_TCO(x)        __emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
>> +#define TSB_CSYNC            __emit_inst(0xd503225f)
>>     #define set_pstate_pan(x)        asm volatile(SET_PSTATE_PAN(x))
>>   #define set_pstate_uao(x)        asm volatile(SET_PSTATE_UAO(x))
>> @@ -880,6 +881,7 @@
>>   #define ID_AA64MMFR2_CNP_SHIFT        0
>>     /* id_aa64dfr0 */
>> +#define ID_AA64DFR0_TRBE_SHIFT        44
>>   #define ID_AA64DFR0_TRACE_FILT_SHIFT    40
>>   #define ID_AA64DFR0_DOUBLELOCK_SHIFT    36
>>   #define ID_AA64DFR0_PMSVER_SHIFT    32
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index f154ae7..aa657ab 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -164,6 +164,17 @@ config CORESIGHT_CTI
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
>> index 0000000..ddc1d34
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -0,0 +1,966 @@
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
>> +/*
>> + * A padding packet that will help the user space tools
>> + * in skipping relevant sections in the captured trace
>> + * data which could not be decoded. TRBE doesn't support
>> + * formatting the trace data, unlike the legacy CoreSight
>> + * sinks and thus we use ETE trace packets to pad the
>> + * sections of the buffer.
>> + */
>> +#define ETE_IGNORE_PACKET 0x70
>> +
>> +enum trbe_fault_action {
>> +    TRBE_FAULT_ACT_WRAP,
>> +    TRBE_FAULT_ACT_SPURIOUS,
>> +    TRBE_FAULT_ACT_FATAL,
>> +};
>> +
>> +struct trbe_buf {
>> +    unsigned long trbe_base;
>> +    unsigned long trbe_limit;
>> +    unsigned long trbe_write;
>> +    int nr_pages;
>> +    void **pages;
>> +    bool snapshot;
>> +    struct trbe_cpudata *cpudata;
>> +};
>> +
>> +struct trbe_cpudata {
>> +    bool trbe_dbm;
>> +    u64 trbe_align;
>> +    int cpu;
>> +    enum cs_mode mode;
>> +    struct trbe_buf *buf;
>> +    struct trbe_drvdata *drvdata;
>> +};
>> +
>> +struct trbe_drvdata {
>> +    struct trbe_cpudata __percpu *cpudata;
>> +    struct perf_output_handle __percpu **handle;
>> +    struct hlist_node hotplug_node;
>> +    int irq;
>> +    cpumask_t supported_cpus;
>> +    enum cpuhp_state trbe_online;
>> +    struct platform_device *pdev;
>> +};
>> +
>> +static int trbe_alloc_node(struct perf_event *event)
>> +{
>> +    if (event->cpu == -1)
>> +        return NUMA_NO_NODE;
>> +    return cpu_to_node(event->cpu);
>> +}
>> +
>> +static void trbe_drain_buffer(void)
>> +{
>> +    asm(TSB_CSYNC);
>> +    dsb(nsh);
>> +}
>> +
>> +static void trbe_drain_and_disable_local(void)
>> +{
>> +    trbe_drain_buffer();
>> +    write_sysreg_s(0, SYS_TRBLIMITR_EL1);
>> +    isb();
>> +}
>> +
>> +static void trbe_reset_local(void)
>> +{
>> +    trbe_drain_and_disable_local();
>> +    write_sysreg_s(0, SYS_TRBPTR_EL1);
>> +    write_sysreg_s(0, SYS_TRBBASER_EL1);
>> +    write_sysreg_s(0, SYS_TRBSR_EL1);
>> +    isb();
> 
> This is isb() is not necessary.

Dropped.


> 
>> +}
>> +
>> +/*
>> + * TRBE Buffer Management
>> + *
>> + * The TRBE buffer spans from the base pointer till the limit pointer. When enabled,
>> + * it starts writing trace data from the write pointer onward till the limit pointer.
> 
> 
>> + * When the write pointer reaches the address just before the limit pointer, it gets
>> + * wrapped around again to the base pointer. This is called a TRBE wrap event, which
>> + * generates a maintenance interrupt when operated in WRAP or STOP mode.
> 
> According to the TRM, it is FILL mode, instead of STOP. So please change the above to:
> 
> "operated in WRAP or FILL mode".

Updated.

> 
> 
>>     The write
>> + * pointer again starts writing trace data from the base pointer until just before
>> + * the limit pointer before getting wrapped again with an IRQ and this process just
>> + * goes on as long as the TRBE is enabled.
> 
> This could be dropped as it applies to WRAP/CIRCULAR buffer mode, which we don't use.

Probably this could be changed a bit to match the FILL mode. Because it is essential
to describe the continuous nature of the buffer operation, even in the FILL mode.

 * After TRBE
 * IRQ gets handled and enabled again, write pointer again starts writing trace data
 * from the base pointer until just before the limit pointer before getting wrapped
 * again with an IRQ and this process just goes on as long as the TRBE is enabled.

> 
> 
>> + *
>> + *    Wrap around with an IRQ
>> + *    ------ < ------ < ------- < ----- < -----
>> + *    |                    |
>> + *    ------ > ------ > ------- > ----- > -----
>> + *
>> + *    +---------------+-----------------------+
>> + *    |        |            |
>> + *    +---------------+-----------------------+
>> + *    Base Pointer    Write Pointer        Limit Pointer
>> + *
>> + * The base and limit pointers always needs to be PAGE_SIZE aligned. But the write
>> + * pointer can be aligned to the implementation defined TRBE trace buffer alignment
>> + * as captured in trbe_cpudata->trbe_align.
>> + *
>> + *
>> + *        head        tail        wakeup
>> + *    +---------------------------------------+----- ~ ~ ------
>> + *    |$$$$$$$|################|$$$$$$$$$$$$$$|        |
>> + *    +---------------------------------------+----- ~ ~ ------
>> + *    Base Pointer    Write Pointer        Limit Pointer
>> + *
>> + * The perf_output_handle indices (head, tail, wakeup) are monotonically increasing
>> + * values which tracks all the driver writes and user reads from the perf auxiliary
>> + * buffer. Generally [head..tail] is the area where the driver can write into unless
>> + * the wakeup is behind the tail. Enabled TRBE buffer span needs to be adjusted and
>> + * configured depending on the perf_output_handle indices, so that the driver does
>> + * not override into areas in the perf auxiliary buffer which is being or yet to be
>> + * consumed from the user space. The enabled TRBE buffer area is a moving subset of
>> + * the allocated perf auxiliary buffer.
>> + */
>> +static void trbe_pad_buf(struct perf_output_handle *handle, int len)
>> +{
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +    u64 head = PERF_IDX2OFF(handle->head, buf);
>> +
>> +    memset((void *) buf->trbe_base + head, ETE_IGNORE_PACKET, len);
> 
> minor nit: You don't need a space after "(type *)" for casting, here and below at
> some other places.

Fixed.

> 
>> +    if (!buf->snapshot)
>> +        perf_aux_output_skip(handle, len);
>> +}
>> +
>> +static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +
>> +    /*
>> +     * The ETE trace has alignment synchronization packets allowing
>> +     * the decoder to reset in case of an overflow or corruption.
>> +     * So we can use the entire buffer for the snapshot mode.
>> +     */
>> +    return buf->nr_pages * PAGE_SIZE;
>> +}
>> +
>> +/*
>> + * TRBE Limit Calculation
>> + *
>> + * The following markers are used to illustrate various TRBE buffer situations.
>> + *
>> + * $$$$ - Data area, unconsumed captured trace data, not to be overridden
>> + * #### - Free area, enabled, trace will be written
>> + * %%%% - Free area, disabled, trace will not be written
>> + * ==== - Free area, padded with ETE_IGNORE_PACKET, trace will be skipped
>> + */
>> +static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +    struct trbe_cpudata *cpudata = buf->cpudata;
>> +    const u64 bufsize = buf->nr_pages * PAGE_SIZE;
>> +    u64 limit = bufsize;
>> +    u64 head, tail, wakeup;
>> +
>> +    head = PERF_IDX2OFF(handle->head, buf);
>> +
>> +    /*
>> +     *        head
>> +     *    ------->|
>> +     *    |
>> +     *    head    TRBE align    tail
>> +     * +----|-------|---------------|-------+
>> +     * |$$$$|=======|###############|$$$$$$$|
>> +     * +----|-------|---------------|-------+
>> +     * trbe_base                trbe_base + nr_pages
>> +     *
>> +     * Perf aux buffer output head position can be misaligned depending on
>> +     * various factors including user space reads. In case misaligned, head
>> +     * needs to be aligned before TRBE can be configured. Pad the alignment
>> +     * gap with ETE_IGNORE_PACKET bytes that will be ignored by user tools
>> +     * and skip this section thus advancing the head.
>> +     */
>> +    if (!IS_ALIGNED(head, cpudata->trbe_align)) {
>> +        unsigned long delta = roundup(head, cpudata->trbe_align) - head;
>> +
>> +        delta = min(delta, handle->size);
>> +        trbe_pad_buf(handle, delta);
>> +        head = PERF_IDX2OFF(handle->head, buf);
>> +    }
>> +
>> +    /*
>> +     *    head = tail (size = 0)
>> +     * +----|-------------------------------+
>> +     * |$$$$|$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    |
>> +     * +----|-------------------------------+
>> +     * trbe_base                trbe_base + nr_pages
>> +     *
>> +     * Perf aux buffer does not have any space for the driver to write into.
>> +     * Just communicate trace truncation event to the user space by marking
>> +     * it with PERF_AUX_FLAG_TRUNCATED.
>> +     */
>> +    if (!handle->size) {
>> +        perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +        return 0;
>> +    }
>> +
>> +    /* Compute the tail and wakeup indices now that we've aligned head */
>> +    tail = PERF_IDX2OFF(handle->head + handle->size, buf);
>> +    wakeup = PERF_IDX2OFF(handle->wakeup, buf);
>> +
>> +    /*
>> +     * Lets calculate the buffer area which TRBE could write into. There
>> +     * are three possible scenarios here. Limit needs to be aligned with
>> +     * PAGE_SIZE per the TRBE requirement. Always avoid clobbering the
>> +     * unconsumed data.
>> +     *
>> +     * 1) head < tail
>> +     *
>> +     *    head            tail
>> +     * +----|-----------------------|-------+
>> +     * |$$$$|#######################|$$$$$$$|
>> +     * +----|-----------------------|-------+
>> +     * trbe_base            limit    trbe_base + nr_pages
>> +     *
>> +     * TRBE could write into [head..tail] area. Unless the tail is right at
>> +     * the end of the buffer, neither an wrap around nor an IRQ is expected
>> +     * while being enabled.
>> +     *
>> +     * 2) head == tail
>> +     *
>> +     *    head = tail (size > 0)
>> +     * +----|-------------------------------+
>> +     * |%%%%|###############################|
>> +     * +----|-------------------------------+
>> +     * trbe_base                limit = trbe_base + nr_pages
>> +     *
>> +     * TRBE should just write into [head..base + nr_pages] area even though
>> +     * the entire buffer is empty. Reason being, when the trace reaches the
>> +     * end of the buffer, it will just wrap around with an IRQ giving an
>> +     * opportunity to reconfigure the buffer.
>> +     *
>> +     * 3) tail < head
>> +     *
>> +     *    tail            head
>> +     * +----|-----------------------|-------+
>> +     * |%%%%|$$$$$$$$$$$$$$$$$$$$$$$|#######|
>> +     * +----|-----------------------|-------+
>> +     * trbe_base                limit = trbe_base + nr_pages
>> +     *
>> +     * TRBE should just write into [head..base + nr_pages] area even though
>> +     * the [trbe_base..tail] is also empty. Reason being, when the trace
>> +     * reaches the end of the buffer, it will just wrap around with an IRQ
>> +     * giving an opportunity to reconfigure the buffer.
>> +     */
>> +    if (head < tail)
>> +        limit = round_down(tail, PAGE_SIZE);
>> +
>> +    /*
>> +     * Wakeup may be arbitrarily far into the future. If it's not in the
>> +     * current generation, either we'll wrap before hitting it, or it's
>> +     * in the past and has been handled already.
>> +     *
>> +     * If there's a wakeup before we wrap, arrange to be woken up by the
>> +     * page boundary following it. Keep the tail boundary if that's lower.
>> +     *
>> +     *    head        wakeup    tail
>> +     * +----|---------------|-------|-------+
>> +     * |$$$$|###############|%%%%%%%|$$$$$$$|
>> +     * +----|---------------|-------|-------+
>> +     * trbe_base        limit        trbe_base + nr_pages
>> +     */
>> +    if (handle->wakeup < (handle->head + handle->size) && head <= wakeup)
>> +        limit = min(limit, round_up(wakeup, PAGE_SIZE));
>> +
>> +    /*
>> +     * There are two situation when this can happen i.e limit is before
>> +     * the head and hence TRBE cannot be configured.
>> +     *
>> +     * 1) head < tail (aligned down with PAGE_SIZE) and also they are both
>> +     * within the same PAGE size range.
>> +     *
>> +     *            PAGE_SIZE
>> +     *        |----------------------|
>> +     *
>> +     *        limit    head    tail
>> +     * +------------|------|--------|-------+
>> +     * |$$$$$$$$$$$$$$$$$$$|========|$$$$$$$|
>> +     * +------------|------|--------|-------+
>> +     * trbe_base                trbe_base + nr_pages
>> +     *
>> +     * 2) head < wakeup (aligned up with PAGE_SIZE) < tail and also both
>> +     * head and wakeup are within same PAGE size range.
>> +     *
>> +     *        PAGE_SIZE
>> +     *    |----------------------|
>> +     *
>> +     *    limit    head    wakeup  tail
>> +     * +----|------|-------|--------|-------+
>> +     * |$$$$$$$$$$$|=======|========|$$$$$$$|
>> +     * +----|------|-------|--------|-------+
>> +     * trbe_base                trbe_base + nr_pages
>> +     */
>> +    if (limit > head)
>> +        return limit;
>> +
>> +    trbe_pad_buf(handle, handle->size);
>> +    perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +    return 0;
>> +}
>> +
>> +static unsigned long compute_trbe_buffer_limit(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +    unsigned long offset;
>> +
>> +    if (buf->snapshot)
>> +        offset = trbe_snapshot_offset(handle);
>> +    else
>> +        offset = trbe_normal_offset(handle);
>> +    return buf->trbe_base + offset;
>> +}
>> +
>> +static void clr_trbe_status(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    WARN_ON(is_trbe_enabled());
>> +    trbsr &= ~TRBSR_IRQ;
>> +    trbsr &= ~TRBSR_TRG;
>> +    trbsr &= ~TRBSR_WRAP;
>> +    trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
>> +    trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
>> +    trbsr &= ~TRBSR_STOP;
>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>> +}
>> +
>> +static void set_trbe_limit_pointer_enabled(unsigned long addr)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
>> +    WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
>> +
>> +    trblimitr &= ~TRBLIMITR_NVM;
>> +    trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
>> +    trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
>> +    trblimitr &= ~(TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
>> +
>> +    /*
>> +     * Fill trace buffer mode is used here while configuring the
>> +     * TRBE for trace capture. In this particular mode, the trace
>> +     * collection is stopped and a maintenance interrupt is raised
>> +     * when the current write pointer wraps. This pause in trace
>> +     * collection gives the software an opportunity to capture the
>> +     * trace data in the interrupt handler, before reconfiguring
>> +     * the TRBE.
>> +     */
>> +    trblimitr |= (TRBE_FILL_MODE_FILL & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT;
>> +
>> +    /*
>> +     * Trigger mode is not used here while configuring the TRBE for
>> +     * the trace capture. Hence just keep this in the ignore mode.
>> +     */
>> +    trblimitr |= (TRBE_TRIG_MODE_IGNORE & TRBLIMITR_TRIG_MODE_MASK) << TRBLIMITR_TRIG_MODE_SHIFT;
>> +    trblimitr |= (addr & PAGE_MASK);
>> +
>> +    trblimitr |= TRBLIMITR_ENABLE;
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
>> +
>> +static void trbe_enable_hw(struct trbe_buf *buf)
>> +{
>> +    WARN_ON(buf->trbe_write < buf->trbe_base);
>> +    WARN_ON(buf->trbe_write >= buf->trbe_limit);
>> +    set_trbe_disabled();
>> +    isb();
>> +    clr_trbe_status();
>> +    set_trbe_base_pointer(buf->trbe_base);
>> +    set_trbe_write_pointer(buf->trbe_write);
>> +
>> +    /*
>> +     * Synchronize all the register updates
>> +     * till now before enabling the TRBE.
>> +     */
>> +    isb();
>> +    set_trbe_limit_pointer_enabled(buf->trbe_limit);
>> +
>> +    /* Synchronize the TRBE enable event */
>> +    isb();
>> +}
>> +
>> +static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>> +                   struct perf_event *event, void **pages,
>> +                   int nr_pages, bool snapshot)
>> +{
>> +    struct trbe_buf *buf;
>> +    struct page **pglist;
>> +    int i;
>> +
>> +    if ((nr_pages < 2) || (snapshot && (nr_pages & 1)))
> 
> This restriction on snapshot could be removed now, since we use the
> full buffer.

Dropped only the second condition here i.e (snapshot && (nr_pages & 1).
Just wondering if the aux buffer could work with a single page so that
the first condition can also be dropped.

> 
>> +        return NULL;
>> +
>> +    buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
>> +    if (IS_ERR(buf))
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
>> +    if (IS_ERR(pglist)) {
>> +        kfree(buf);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +
>> +    for (i = 0; i < nr_pages; i++)
>> +        pglist[i] = virt_to_page(pages[i]);
>> +
>> +    buf->trbe_base = (unsigned long) vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
>> +    if (IS_ERR((void *) buf->trbe_base)) {
>> +        kfree(pglist);
>> +        kfree(buf);
>> +        return ERR_PTR(buf->trbe_base);
>> +    }
>> +    buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
>> +    buf->trbe_write = buf->trbe_base;
>> +    buf->snapshot = snapshot;
>> +    buf->nr_pages = nr_pages;
>> +    buf->pages = pages;
>> +    kfree(pglist);
>> +    return buf;
>> +}
>> +
>> +void arm_trbe_free_buffer(void *config)
>> +{
>> +    struct trbe_buf *buf = config;
>> +
>> +    vunmap((void *) buf->trbe_base);
>> +    kfree(buf);
>> +}
>> +
>> +static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>> +                        struct perf_output_handle *handle,
>> +                        void *config)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>> +    struct trbe_buf *buf = config;
>> +    unsigned long size, offset;
>> +
>> +    WARN_ON(buf->cpudata != cpudata);
>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>> +    WARN_ON(cpudata->drvdata != drvdata);
>> +    if (cpudata->mode != CS_MODE_PERF)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * perf handle structure needs to be shared with the TRBE IRQ handler for
>> +     * capturing trace data and restarting the handle. There is a probability
>> +     * of an undefined reference based crash when etm event is being stopped
>> +     * while a TRBE IRQ also getting processed. This happens due the release
>> +     * of perf handle via perf_aux_output_end() in etm_event_stop(). Stopping
>> +     * the TRBE here will ensure that no IRQ could be generated when the perf
>> +     * handle gets freed in etm_event_stop().
>> +     */
>> +    trbe_reset_local();
>> +    offset = get_trbe_write_pointer() - get_trbe_base_pointer();
>> +    size = offset - PERF_IDX2OFF(handle->head, buf);
>> +    if (buf->snapshot)
>> +        handle->head += size;
>> +    return size;
>> +}
>> +
>> +static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>> +    struct perf_output_handle *handle = data;
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +
>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>> +    WARN_ON(cpudata->drvdata != drvdata);
>> +    if (mode != CS_MODE_PERF)
>> +        return -EINVAL;
>> +
>> +    *this_cpu_ptr(drvdata->handle) = handle;
>> +    cpudata->buf = buf;
>> +    cpudata->mode = mode;
>> +    buf->cpudata = cpudata;
>> +    buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>> +    buf->trbe_limit = compute_trbe_buffer_limit(handle);
>> +    if (buf->trbe_limit == buf->trbe_base) {
>> +        trbe_drain_and_disable_local();
>> +        return 0;
>> +    }
>> +    trbe_enable_hw(buf);
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_disable(struct coresight_device *csdev)
>> +{
>> +    struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
>> +    struct trbe_buf *buf = cpudata->buf;
>> +
>> +    WARN_ON(buf->cpudata != cpudata);
>> +    WARN_ON(cpudata->cpu != smp_processor_id());
>> +    WARN_ON(cpudata->drvdata != drvdata);
>> +    if (cpudata->mode != CS_MODE_PERF)
>> +        return -EINVAL;
>> +
>> +    trbe_drain_and_disable_local();
>> +    buf->cpudata = NULL;
>> +    cpudata->buf = NULL;
>> +    cpudata->mode = CS_MODE_DISABLED;
>> +    return 0;
>> +}
>> +
>> +static void trbe_handle_fatal(struct perf_output_handle *handle)
>> +{
>> +    perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +    perf_aux_output_end(handle, 0);
>> +    trbe_drain_and_disable_local();
>> +}
>> +
>> +static void trbe_handle_spurious(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +
>> +    buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>> +    buf->trbe_limit = compute_trbe_buffer_limit(handle);
>> +    if (buf->trbe_limit == buf->trbe_base) {
>> +        trbe_drain_and_disable_local();
>> +        return;
>> +    }
>> +    trbe_enable_hw(buf);
>> +}
>> +
>> +static void trbe_handle_overflow(struct perf_output_handle *handle)
>> +{
>> +    struct perf_event *event = handle->event;
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +    unsigned long offset, size;
>> +    struct etm_event_data *event_data;
>> +
>> +    offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
>> +    size = offset - PERF_IDX2OFF(handle->head, buf);
>> +    if (buf->snapshot)
>> +        handle->head = offset;
>> +    perf_aux_output_end(handle, size);
>> +
>> +    event_data = perf_aux_output_begin(handle, event);
>> +    if (!event_data) {
>> +        event->hw.state |= PERF_HES_STOPPED;
>> +        trbe_drain_and_disable_local();
>> +        perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +        return;
>> +    }
>> +    buf->trbe_write = buf->trbe_base;
>> +    buf->trbe_limit = compute_trbe_buffer_limit(handle);
>> +    if (buf->trbe_limit == buf->trbe_base) {
>> +        trbe_drain_and_disable_local();
>> +        return;
>> +    }
>> +    *this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
>> +    trbe_enable_hw(buf);
>> +}
>> +
>> +static bool is_perf_trbe(struct perf_output_handle *handle)
>> +{
>> +    struct trbe_buf *buf = etm_perf_sink_config(handle);
>> +    struct trbe_cpudata *cpudata = buf->cpudata;
>> +    struct trbe_drvdata *drvdata = cpudata->drvdata;
>> +    int cpu = smp_processor_id();
>> +
>> +    WARN_ON(buf->trbe_base != get_trbe_base_pointer());
>> +    WARN_ON(buf->trbe_limit != get_trbe_limit_pointer());
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
>> +    int ec = get_trbe_ec();
>> +    int bsc = get_trbe_bsc();
>> +
>> +    WARN_ON(is_trbe_running());
>> +    if (is_trbe_trg() || is_trbe_abort())
> 
> We seem to be reading the TRBSR every single in these helpers. Could we optimise them
> by passing the register value in ?

The same goes for get_trbe_ec() and get_trbe_bsc() as well. Probably all
TRBSR field probing helpers should be modified to accept a TRBSR register
value instead.

> 
> i.e
>     u64 trbsr = get_trbe_status();
> 
>     WARN_ON(is_trbe_runnign(trbsr))
>     if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
> 
> For is_trbe_wrap() too

Yes.

> 
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
>> +    struct perf_output_handle **handle_ptr = dev;
>> +    struct perf_output_handle *handle = *handle_ptr;
>> +    enum trbe_fault_action act;
>> +
>> +    WARN_ON(!is_trbe_irq());
>> +    clr_trbe_irq();
>> +
>> +    /*
>> +     * Ensure the trace is visible to the CPUs and
>> +     * any external aborts have been resolved.
>> +     */
>> +    trbe_drain_buffer();
>> +    isb();
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
>> +static const struct coresight_ops_sink arm_trbe_sink_ops = {
>> +    .enable        = arm_trbe_enable,
>> +    .disable    = arm_trbe_disable,
>> +    .alloc_buffer    = arm_trbe_alloc_buffer,
>> +    .free_buffer    = arm_trbe_free_buffer,
>> +    .update_buffer    = arm_trbe_update_buffer,
>> +};
>> +
>> +static const struct coresight_ops arm_trbe_cs_ops = {
>> +    .sink_ops    = &arm_trbe_sink_ops,
>> +};
>> +
>> +static ssize_t align_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
>> +
>> +    return sprintf(buf, "%llx\n", cpudata->trbe_align);
>> +}
>> +static DEVICE_ATTR_RO(align);
>> +
>> +static ssize_t dbm_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +    struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
>> +
>> +    return sprintf(buf, "%d\n", cpudata->trbe_dbm);
>> +}
>> +static DEVICE_ATTR_RO(dbm);
>> +
>> +static struct attribute *arm_trbe_attrs[] = {
>> +    &dev_attr_align.attr,
>> +    &dev_attr_dbm.attr,
>> +    NULL,
>> +};
>> +
>> +static const struct attribute_group arm_trbe_group = {
>> +    .attrs = arm_trbe_attrs,
>> +};
>> +
>> +static const struct attribute_group *arm_trbe_groups[] = {
>> +    &arm_trbe_group,
>> +    NULL,
>> +};
>> +
>> +static void arm_trbe_probe_coresight_cpu(void *info)
>> +{
>> +    struct trbe_drvdata *drvdata = info;
>> +    struct coresight_desc desc = { 0 };
>> +    int cpu = smp_processor_id();
>> +    struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +    struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
>> +    struct device *dev;
>> +
>> +    if (WARN_ON(!cpudata))
>> +        goto cpu_clear;
>> +
>> +    if (trbe_csdev)
>> +        return;
>> +
>> +    cpudata->cpu = smp_processor_id();
>> +    cpudata->drvdata = drvdata;
>> +    dev = &cpudata->drvdata->pdev->dev;
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
>> +    desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DRVNAME, smp_processor_id());
>> +    if (IS_ERR(desc.name))
>> +        goto cpu_clear;
>> +
>> +    desc.type = CORESIGHT_DEV_TYPE_SINK;
>> +    desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
>> +    desc.ops = &arm_trbe_cs_ops;
>> +    desc.pdata = dev_get_platdata(dev);
>> +    desc.groups = arm_trbe_groups;
>> +    desc.dev = dev;
>> +    trbe_csdev = coresight_register(&desc);
>> +    if (IS_ERR(trbe_csdev))
>> +        goto cpu_clear;
>> +
>> +    dev_set_drvdata(&trbe_csdev->dev, cpudata);
>> +    cpudata->trbe_dbm = get_trbe_flag_update();
>> +    cpudata->trbe_align = 1ULL << get_trbe_address_align();
>> +    if (cpudata->trbe_align > SZ_2K) {
>> +        pr_err("Unsupported alignment on cpu %d\n", cpudata->cpu);
>> +        goto cpu_clear;
>> +    }
>> +    per_cpu(csdev_sink, cpu) = trbe_csdev;
>> +    trbe_reset_local();
>> +    enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
>> +    return;
>> +cpu_clear:
>> +    cpumask_clear_cpu(cpudata->cpu, &cpudata->drvdata->supported_cpus);
>> +}
>> +
>> +static void arm_trbe_remove_coresight_cpu(void *info)
>> +{
>> +    int cpu = smp_processor_id();
>> +    struct trbe_drvdata *drvdata = info;
>> +    struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
>> +    struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
>> +
>> +    if (trbe_csdev) {
>> +        coresight_unregister(trbe_csdev);
>> +        cpudata->drvdata = NULL;
>> +        per_cpu(csdev_sink, cpu) = NULL;
>> +    }
>> +    disable_percpu_irq(drvdata->irq);
>> +    trbe_reset_local();
>> +}
>> +
>> +static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
>> +{
>> +    drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
>> +    if (IS_ERR(drvdata->cpudata))
>> +        return PTR_ERR(drvdata->cpudata);
>> +
>> +    arm_trbe_probe_coresight_cpu(drvdata);
>> +    smp_call_function_many(&drvdata->supported_cpus, arm_trbe_probe_coresight_cpu, drvdata, 1);
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
>> +{
>> +    arm_trbe_remove_coresight_cpu(drvdata);
>> +    smp_call_function_many(&drvdata->supported_cpus, arm_trbe_remove_coresight_cpu, drvdata, 1);
>> +    free_percpu(drvdata->cpudata);
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
>> +{
>> +    struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
>> +
>> +    if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
>> +        if (!per_cpu(csdev_sink, cpu)) {
>> +            arm_trbe_probe_coresight_cpu(drvdata);
>> +        } else {
>> +            trbe_reset_local();
>> +            enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>> +{
>> +    struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
>> +
>> +    if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
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
>> +
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
>> +static const struct of_device_id arm_trbe_of_match[] = {
>> +    { .compatible = "arm,trace-buffer-extension"},
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(of, arm_trbe_of_match);
>> +
>> +static struct platform_driver arm_trbe_driver = {
>> +    .driver    = {
>> +        .name = DRVNAME,
>> +        .of_match_table = of_match_ptr(arm_trbe_of_match),
>> +        .suppress_bind_attrs = true,
>> +    },
>> +    .probe    = arm_trbe_device_probe,
>> +    .remove    = arm_trbe_device_remove,
>> +};
>> +
>> +static int __init arm_trbe_init(void)
>> +{
>> +    int ret;
>> +
> 
> We should skip the driver init, if the kernel is unmapped at EL0,
> as the TRBE can't safely write to the kernel virtual addressed
> buffer when the CPU is running at EL0. This is unlikely, but we
> should cover that case.

This should be sufficient or it needs a pr_err() as well ?

--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -946,6 +946,9 @@ static int __init arm_trbe_init(void)
 {
        int ret;
 
+       if (arm64_kernel_unmapped_at_el0())
+               return -EOPNOTSUPP;
+
        ret = platform_driver_register(&arm_trbe_driver);
        if (!ret)
                return 0;

> 
> 
>> +    ret = platform_driver_register(&arm_trbe_driver);
>> +    if (!ret)
>> +        return 0;
>> +
>> +    pr_err("Error registering %s platform driver\n", DRVNAME);
>> +    return ret;
>> +}
>> +
>> +static void __exit arm_trbe_exit(void)
>> +{
>> +    platform_driver_unregister(&arm_trbe_driver);
>> +}
>> +module_init(arm_trbe_init);
>> +module_exit(arm_trbe_exit);
>> +
>> +MODULE_AUTHOR("Anshuman Khandual <anshuman.khandual@arm.com>");
>> +MODULE_DESCRIPTION("Arm Trace Buffer Extension (TRBE) driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
>> new file mode 100644
>> index 0000000..d9f5079
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
>> @@ -0,0 +1,216 @@
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
>> +DECLARE_PER_CPU(struct coresight_device *, csdev_sink);
>> +
>> +static inline bool is_trbe_available(void)
>> +{
>> +    u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>> +    int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_TRBE_SHIFT);
> 
> This could be "unsigned int" to make it future proof.

Changed.
	
> 
>> +
>> +    return trbe >= 0b0001;
>> +}
>> +
>> +static inline bool is_trbe_enabled(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    return trblimitr & TRBLIMITR_ENABLE;
>> +}
>> +
>> +#define TRBE_EC_OTHERS        0
>> +#define TRBE_EC_STAGE1_ABORT    36
>> +#define TRBE_EC_STAGE2_ABORT    37
>> +
>> +static inline int get_trbe_ec(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return (trbsr >> TRBSR_EC_SHIFT) & TRBSR_EC_MASK;
>> +}
>> +
>> +#define TRBE_BSC_NOT_STOPPED    0
>> +#define    TRBE_BSC_FILLED        1
>> +#define TRBE_BSC_TRIGGERED    2
>> +
>> +static inline int get_trbe_bsc(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return (trbsr >> TRBSR_BSC_SHIFT) & TRBSR_BSC_MASK;
>> +}
>> +
>> +static inline void clr_trbe_irq(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    trbsr &= ~TRBSR_IRQ;
>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>> +}
>> +
>> +static inline bool is_trbe_irq(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return trbsr & TRBSR_IRQ;
>> +}
>> +
>> +static inline bool is_trbe_trg(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return trbsr & TRBSR_TRG;
>> +}
>> +
>> +static inline bool is_trbe_wrap(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return trbsr & TRBSR_WRAP;
>> +}
>> +
>> +static inline bool is_trbe_abort(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return trbsr & TRBSR_ABORT;
>> +}
>> +
>> +static inline bool is_trbe_running(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    return !(trbsr & TRBSR_STOP);
>> +}
>> +
> 
> 
>> +static inline void set_trbe_running(void)
>> +{
>> +    u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
>> +
>> +    trbsr &= ~TRBSR_STOP;
>> +    write_sysreg_s(trbsr, SYS_TRBSR_EL1);
>> +}
> 
> This could be removed now.

Dropped.

> 
>> +
>> +static inline void set_trbe_virtual_mode(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    trblimitr &= ~TRBLIMITR_NVM;
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
> 
> Same here.

Dropped.

> 
> 
>> +
>> +#define TRBE_TRIG_MODE_STOP        0
>> +#define TRBE_TRIG_MODE_IRQ        1
>> +#define TRBE_TRIG_MODE_IGNORE        3
>> +
>> +#define TRBE_FILL_MODE_FILL        0
>> +#define TRBE_FILL_MODE_WRAP        1
>> +#define TRBE_FILL_MODE_CIRCULAR_BUFFER    3
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
> 
> Same as above.

Dropped.

> 
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
>> +
>> +static inline int get_trbe_address_align(void)
>> +{
>> +    u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
>> +
>> +    return (trbidr >> TRBIDR_ALIGN_SHIFT) & TRBIDR_ALIGN_MASK;
>> +}
>> +
> 
> Similar comment to the TRBSR read on each of these functions. They
> all are only called from a single function. It may make sense to
> read once and pass the value.

Changed is_trbe_programmable(), get_trbe_address_align() and
get_trbe_flag_update() to accept a previously read TRBIDR register.

> 
>> +static inline unsigned long get_trbe_write_pointer(void)
>> +{
>> +    u64 trbptr = read_sysreg_s(SYS_TRBPTR_EL1);
>> +    unsigned long addr = (trbptr >> TRBPTR_PTR_SHIFT) & TRBPTR_PTR_MASK;
>> +
>> +    return addr;
>> +}
>> +
>> +static inline void set_trbe_write_pointer(unsigned long addr)
>> +{
>> +    WARN_ON(is_trbe_enabled());
>> +    addr = (addr >> TRBPTR_PTR_SHIFT) & TRBPTR_PTR_MASK;
>> +    write_sysreg_s(addr, SYS_TRBPTR_EL1);
>> +}
>> +
>> +static inline unsigned long get_trbe_limit_pointer(void)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +    unsigned long limit = (trblimitr >> TRBLIMITR_LIMIT_SHIFT) & TRBLIMITR_LIMIT_MASK;
>> +    unsigned long addr = limit << TRBLIMITR_LIMIT_SHIFT;
>> +
>> +    WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
>> +    return addr;
>> +}
> 
>> +
>> +static inline void set_trbe_limit_pointer(unsigned long addr)
>> +{
>> +    u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
>> +
>> +    WARN_ON(is_trbe_enabled());
>> +    WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
>> +    WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
>> +    trblimitr &= ~(TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
>> +    trblimitr |= (addr & PAGE_MASK);
>> +    write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
>> +}
> 
> Remove the unused function.

Removed.

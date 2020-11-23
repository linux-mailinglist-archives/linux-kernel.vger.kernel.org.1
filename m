Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8292BFEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgKWDwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:52:01 -0500
Received: from foss.arm.com ([217.140.110.172]:54836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgKWDwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:52:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E127E101E;
        Sun, 22 Nov 2020 19:51:59 -0800 (PST)
Received: from [10.163.82.200] (unknown [10.163.82.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9D13F71F;
        Sun, 22 Nov 2020 19:51:57 -0800 (PST)
Subject: Re: [RFC 07/11] coresight: sink: Add TRBE driver
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-8-git-send-email-anshuman.khandual@arm.com>
 <20201114053842.GB28964@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bc4b7219-bee0-ad03-fba4-9f062e0521ca@arm.com>
Date:   Mon, 23 Nov 2020 09:21:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201114053842.GB28964@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/20 11:08 AM, Tingwei Zhang wrote:
> Hi Anshuman,
> 
> On Tue, Nov 10, 2020 at 08:45:05PM +0800, Anshuman Khandual wrote:
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
>>  Documentation/trace/coresight/coresight-trbe.rst |  36 ++
>>  arch/arm64/include/asm/sysreg.h                  |   2 +
>>  drivers/hwtracing/coresight/Kconfig              |  11 +
>>  drivers/hwtracing/coresight/Makefile             |   1 +
>>  drivers/hwtracing/coresight/coresight-trbe.c     | 766 
>> +++++++++++++++++++++++
>>  drivers/hwtracing/coresight/coresight-trbe.h     | 525 ++++++++++++++++
>>  6 files changed, 1341 insertions(+)
>>  create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
>>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
>>  create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h
>>
>> diff --git a/Documentation/trace/coresight/coresight-trbe.rst 
>> b/Documentation/trace/coresight/coresight-trbe.rst
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
>> +    :Author:   Anshuman Khandual <anshuman.khandual@arm.com>
>> +    :Date:     November 2020
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
>> +	>$ ls /sys/bus/coresight/devices
>> +	trbe0  trbe1  trbe2 trbe3
>> +
>> +The ``trbe<N>`` named TRBEs are associated with a CPU.::
>> +
>> +	>$ ls /sys/bus/coresight/devices/trbe0/
>> +	irq align dbm
>> +
>> +*Key file items are:-*
>> +   * ``irq``: TRBE maintenance interrupt number
>> +   * ``align``: TRBE write pointer alignment
>> +   * ``dbm``: TRBE updates memory with access and dirty flags
>> +
>> diff --git a/arch/arm64/include/asm/sysreg.h 
>> b/arch/arm64/include/asm/sysreg.h
>> index 14cb156..61136f6 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -97,6 +97,7 @@
>>  #define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << 
>> PSTATE_Imm_shift))
>>  #define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) 
>> << PSTATE_Imm_shift))
>>  #define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << 
>> PSTATE_Imm_shift))
>> +#define TSB_CSYNC			__emit_inst(0xd503225f)
>>
>>  #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
>>  	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
>> @@ -865,6 +866,7 @@
>>  #define ID_AA64MMFR2_CNP_SHIFT		0
>>
>>  /* id_aa64dfr0 */
>> +#define ID_AA64DFR0_TRBE_SHIFT		44
>>  #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
>>  #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
>>  #define ID_AA64DFR0_PMSVER_SHIFT	32
>> diff --git a/drivers/hwtracing/coresight/Kconfig 
>> b/drivers/hwtracing/coresight/Kconfig
>> index c119824..0f5e101 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -156,6 +156,17 @@ config CORESIGHT_CTI
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called coresight-cti.
>>
>> +config CORESIGHT_TRBE
>> +	bool "Trace Buffer Extension (TRBE) driver"
> 
> Can you consider to support TRBE as loadable module since all coresight
> drivers support loadable module now.

Reworking the TRBE driver and making it a loadable module is part of it.

- Anshuman

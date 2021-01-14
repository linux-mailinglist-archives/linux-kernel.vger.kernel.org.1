Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1332B2F5DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbhANJit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:38:49 -0500
Received: from foss.arm.com ([217.140.110.172]:46576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbhANJiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:38:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB3E1FB;
        Thu, 14 Jan 2021 01:37:19 -0800 (PST)
Received: from [10.0.0.31] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66C6C3F70D;
        Thu, 14 Jan 2021 01:37:16 -0800 (PST)
Subject: Re: [PATCH v2 1/4] kasan, arm64: Add KASAN light mode
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210107172908.42686-1-vincenzo.frascino@arm.com>
 <20210107172908.42686-2-vincenzo.frascino@arm.com>
 <20210113171602.GD27045@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7125af39-2572-1b08-d223-51f4ea6e686b@arm.com>
Date:   Thu, 14 Jan 2021 09:40:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113171602.GD27045@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 5:16 PM, Catalin Marinas wrote:
> On Thu, Jan 07, 2021 at 05:29:05PM +0000, Vincenzo Frascino wrote:
>> Architectures supported by KASAN HW can provide a light mode of
>> execution. On an MTE enabled arm64 hw for example this can be identified
>> with the asynch mode of execution. If an async exception occurs, the
>> arm64 core updates a register which is asynchronously detected the next
>> time in which the kernel is accessed.
> 
> What do you mean by "the kernel is accessed"? Also, there is no
> "exception" as such, only a bit in a register updated asynchronously. So
> the last sentence could be something like:
> 
>   In this mode, if a tag check fault occurs, the TFSR_EL1 register is
>   updated asynchronously. The kernel checks the corresponding bits
>   periodically.
> 
> (or you can be more precise on when the kernel checks for such faults)
>

Yes, I agree, I will change it accordingly. What I wrote has a similar meaning
but your exposition is more clear.

>> KASAN requires a specific mode of execution to make use of this hw feature.
>>
>> Add KASAN HW light execution mode.
> 
> Shall we call it "fast"? ;)
> 
>> --- /dev/null
>> +++ b/include/linux/kasan_def.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_KASAN_DEF_H
>> +#define _LINUX_KASAN_DEF_H
>> +
>> +enum kasan_arg_mode {
>> +	KASAN_ARG_MODE_DEFAULT,
>> +	KASAN_ARG_MODE_OFF,
>> +	KASAN_ARG_MODE_LIGHT,
>> +	KASAN_ARG_MODE_PROD,
>> +	KASAN_ARG_MODE_FULL,
>> +};
>> +
>> +enum kasan_arg_stacktrace {
>> +	KASAN_ARG_STACKTRACE_DEFAULT,
>> +	KASAN_ARG_STACKTRACE_OFF,
>> +	KASAN_ARG_STACKTRACE_ON,
>> +};
>> +
>> +enum kasan_arg_fault {
>> +	KASAN_ARG_FAULT_DEFAULT,
>> +	KASAN_ARG_FAULT_REPORT,
>> +	KASAN_ARG_FAULT_PANIC,
>> +};
>> +
>> +#endif /* _LINUX_KASAN_DEF_H */
> 
> I thought we agreed not to expose the KASAN internal but come up with
> another abstraction. Maybe this was after you posted these patches.
> 

Yes, indeed we agreed and I am going to change it in v3. The agreement
temporally came after I posted v2 hence it is not reflected here.

-- 
Regards,
Vincenzo

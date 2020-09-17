Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2244B26DE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgIQObU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:31:20 -0400
Received: from foss.arm.com ([217.140.110.172]:47612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbgIQOac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:30:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29BCF12FC;
        Thu, 17 Sep 2020 07:22:14 -0700 (PDT)
Received: from [192.168.1.190] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E6F3F718;
        Thu, 17 Sep 2020 07:22:11 -0700 (PDT)
Subject: Re: [PATCH v2 24/37] arm64: mte: Add in-kernel tag fault handler
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
References: <cover.1600204505.git.andreyknvl@google.com>
 <7866d9e6f11f12f1bad42c895bf4947addba71c2.1600204505.git.andreyknvl@google.com>
 <20200917140337.GC10662@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <48ef25ff-0d06-54d9-b467-ff068465e3dc@arm.com>
Date:   Thu, 17 Sep 2020 15:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917140337.GC10662@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 3:03 PM, Catalin Marinas wrote:
> On Tue, Sep 15, 2020 at 11:16:06PM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index a3bd189602df..cdc23662691c 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -294,6 +295,18 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>>  	do_exit(SIGKILL);
>>  }
>>  
>> +static void report_tag_fault(unsigned long addr, unsigned int esr,
>> +			     struct pt_regs *regs)
>> +{
>> +	bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
>> +
>> +	pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
>> +	pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
>> +	pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
>> +			mte_get_ptr_tag(addr),
>> +			mte_get_mem_tag((void *)addr));
>> +}
>> +
>>  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>>  			      struct pt_regs *regs)
>>  {
>> @@ -641,10 +654,31 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>  	return 0;
>>  }
>>  
>> +static void do_tag_recovery(unsigned long addr, unsigned int esr,
>> +			   struct pt_regs *regs)
>> +{
>> +	report_tag_fault(addr, esr, regs);
> 
> I'd only report this once since we expect it to be disabled lazily on
> the other CPUs (i.e. just use a "static bool reported" to keep track).
>

Ok, I will fix it in the next version.

>> +
>> +	/*
>> +	 * Disable Memory Tagging Extension Tag Checking on the local CPU
> 
> Too verbose, just say MTE tag checking, people reading this code should
> have learnt already what MTE stands for ;).
> 

All right, will change it ;)

>> +	 * for the current EL.
>> +	 * It will be done lazily on the other CPUs when they will hit a
>> +	 * tag fault.
>> +	 */
>> +	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_NONE);
>> +	isb();
>> +}
>> +
>> +
>>  static int do_tag_check_fault(unsigned long addr, unsigned int esr,
>>  			      struct pt_regs *regs)
>>  {
>> -	do_bad_area(addr, esr, regs);
>> +	/* The tag check fault (TCF) is per TTBR */
>> +	if (is_ttbr0_addr(addr))
>> +		do_bad_area(addr, esr, regs);
>> +	else
>> +		do_tag_recovery(addr, esr, regs);
> 
> This part looks fine now.
> 

Ok, thanks.

-- 
Regards,
Vincenzo

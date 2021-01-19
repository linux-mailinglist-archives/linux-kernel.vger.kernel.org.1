Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064E22FBE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbhASR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:59:25 -0500
Received: from foss.arm.com ([217.140.110.172]:35076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbhASPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:02:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5911DD6E;
        Tue, 19 Jan 2021 07:01:58 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 409AF3F66E;
        Tue, 19 Jan 2021 07:01:56 -0800 (PST)
Subject: Re: [PATCH v4 3/5] kasan: Add report for async mode
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-4-vincenzo.frascino@arm.com>
 <20210119130440.GC17369@gaia> <813f907f-0de8-6b96-c67a-af9aecf31a70@arm.com>
 <20210119144625.GB2338@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ebcc47e0-5d8c-8642-2e78-09eaad81aa4a@arm.com>
Date:   Tue, 19 Jan 2021 15:05:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119144625.GB2338@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 2:46 PM, Mark Rutland wrote:
> On Tue, Jan 19, 2021 at 02:23:03PM +0000, Vincenzo Frascino wrote:
>> On 1/19/21 1:04 PM, Catalin Marinas wrote:
>>> On Mon, Jan 18, 2021 at 06:30:31PM +0000, Vincenzo Frascino wrote:
> 
>>>> +bool kasan_report_async(unsigned long addr, size_t size,
>>>> +			bool is_write, unsigned long ip);
>>>
>>> We have no address, no size and no is_write information. Do we have a
>>> reason to pass all these arguments here? Not sure what SPARC ADI does
>>> but they may not have all this information either. We can pass ip as the
>>> point where we checked the TFSR reg but that's about it.
>>
>> I kept the interface generic for future development and mainly to start a
>> discussion. I do not have a strong opinion either way. If Andrey agrees as well
>> I am happy to change it to what you are suggesting in v5.
> 
> For now, I think it's preferable that this only has parameters that we
> can actually provide. That way it's clearer what's going on in both
> callers and callees, and we can always rework the prototype later or add
> separate variants of the function that can take additional parameters.
> 
> I don't think we even need to use __kasan_report() -- more on that
> below.
> 
> [...]
> 
>>>> @@ -388,11 +388,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>>>>  	start_report(&flags);
>>>>  
>>>>  	print_error_description(&info);
>>>> -	if (addr_has_metadata(untagged_addr))
>>>> +	if (addr_has_metadata(untagged_addr) && (untagged_addr != 0))
>>>>  		print_tags(get_tag(tagged_addr), info.first_bad_addr);
>>>>  	pr_err("\n");
>>>>  
>>>> -	if (addr_has_metadata(untagged_addr)) {
>>>> +	if (addr_has_metadata(untagged_addr) && (untagged_addr != 0)) {
>>>>  		print_address_description(untagged_addr, get_tag(tagged_addr));
>>>>  		pr_err("\n");
>>>>  		print_memory_metadata(info.first_bad_addr);
>>>> @@ -419,6 +419,18 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +bool kasan_report_async(unsigned long addr, size_t size,
>>>> +			bool is_write, unsigned long ip)
>>>> +{
>>>> +	pr_info("==================================================================\n");
>>>> +	pr_info("KASAN: set in asynchronous mode\n");
>>>> +	pr_info("KASAN: some information might not be accurate\n");
>>>> +	pr_info("KASAN: fault address is ignored\n");
>>>> +	pr_info("KASAN: write/read distinction is ignored\n");
>>>> +
>>>> +	return kasan_report(addr, size, is_write, ip);
>>>
>>> So just call kasan_report (0, 0, 0, ip) here.
> 
> Given there's no information available, I think it's simpler and
> preferable to handle the logging separately, as is done for
> kasan_report_invalid_free(). For example, we could do something roughly
> like:
> 
> void kasan_report_async(void)
> {
> 	unsigned long flags;
> 
> 	start_report(&flags);
> 	pr_err("BUG: KASAN: Tag mismatch detected asynchronously\n");
> 	pr_err("KASAN: no fault information available\n");
> 	dump_stack();
> 	end_report(&flags);
> }
> 
> ... which is easier to consume, since there's no misleading output,
> avoids complicating the synchronous reporting path, and we could
> consider adding information that's only of use for debugging
> asynchronous faults here.
> 
> Since the callside is logged in the backtrace, we don't even need the
> synthetic IP parameter.
> 

Agree, especially because I tend to not like to rely on compiler builtins and
what you proposed solves the problem ;)

I will refactor my code once Andrey had a chance to take a look as well.

> Thanks,
> Mark.
> 

-- 
Regards,
Vincenzo

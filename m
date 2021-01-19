Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DEB2FC44E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhASW7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:59:11 -0500
Received: from foss.arm.com ([217.140.110.172]:33160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404202AbhASOUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:20:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DACDD6E;
        Tue, 19 Jan 2021 06:19:16 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A0743F719;
        Tue, 19 Jan 2021 06:19:13 -0800 (PST)
Subject: Re: [PATCH v4 3/5] kasan: Add report for async mode
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-4-vincenzo.frascino@arm.com>
 <20210119130440.GC17369@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <813f907f-0de8-6b96-c67a-af9aecf31a70@arm.com>
Date:   Tue, 19 Jan 2021 14:23:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119130440.GC17369@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 1:04 PM, Catalin Marinas wrote:
> On Mon, Jan 18, 2021 at 06:30:31PM +0000, Vincenzo Frascino wrote:
>> KASAN provides an asynchronous mode of execution.
>>
>> Add reporting functionality for this mode.
>>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  include/linux/kasan.h |  3 +++
>>  mm/kasan/report.c     | 16 ++++++++++++++--
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index fe1ae73ff8b5..8f43836ccdac 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -336,6 +336,9 @@ static inline void *kasan_reset_tag(const void *addr)
>>  bool kasan_report(unsigned long addr, size_t size,
>>  		bool is_write, unsigned long ip);
>>  
>> +bool kasan_report_async(unsigned long addr, size_t size,
>> +			bool is_write, unsigned long ip);
> 
> We have no address, no size and no is_write information. Do we have a
> reason to pass all these arguments here? Not sure what SPARC ADI does
> but they may not have all this information either. We can pass ip as the
> point where we checked the TFSR reg but that's about it.
>

I kept the interface generic for future development and mainly to start a
discussion. I do not have a strong opinion either way. If Andrey agrees as well
I am happy to change it to what you are suggesting in v5.

>> +
>>  #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>>  
>>  static inline void *kasan_reset_tag(const void *addr)
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index c0fb21797550..946016ead6a9 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -388,11 +388,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>>  	start_report(&flags);
>>  
>>  	print_error_description(&info);
>> -	if (addr_has_metadata(untagged_addr))
>> +	if (addr_has_metadata(untagged_addr) && (untagged_addr != 0))
>>  		print_tags(get_tag(tagged_addr), info.first_bad_addr);
>>  	pr_err("\n");
>>  
>> -	if (addr_has_metadata(untagged_addr)) {
>> +	if (addr_has_metadata(untagged_addr) && (untagged_addr != 0)) {
>>  		print_address_description(untagged_addr, get_tag(tagged_addr));
>>  		pr_err("\n");
>>  		print_memory_metadata(info.first_bad_addr);
>> @@ -419,6 +419,18 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
>>  	return ret;
>>  }
>>  
>> +bool kasan_report_async(unsigned long addr, size_t size,
>> +			bool is_write, unsigned long ip)
>> +{
>> +	pr_info("==================================================================\n");
>> +	pr_info("KASAN: set in asynchronous mode\n");
>> +	pr_info("KASAN: some information might not be accurate\n");
>> +	pr_info("KASAN: fault address is ignored\n");
>> +	pr_info("KASAN: write/read distinction is ignored\n");
>> +
>> +	return kasan_report(addr, size, is_write, ip);
> 
> So just call kasan_report (0, 0, 0, ip) here.
> 

Fine by me.

-- 
Regards,
Vincenzo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94813287B93
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgJHSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:21:36 -0400
Received: from foss.arm.com ([217.140.110.172]:42906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgJHSVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:21:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91CC4D6E;
        Thu,  8 Oct 2020 11:21:35 -0700 (PDT)
Received: from [10.37.12.22] (unknown [10.37.12.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4F63F802;
        Thu,  8 Oct 2020 11:21:31 -0700 (PDT)
Subject: Re: [PATCH v4 29/39] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
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
References: <cover.1601593784.git.andreyknvl@google.com>
 <1f2681fdff1aa1096df949cb8634a9be6bf4acc4.1601593784.git.andreyknvl@google.com>
 <20201002140652.GG7034@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1b2327ee-5f30-e412-7359-32a7a38b4c8d@arm.com>
Date:   Thu, 8 Oct 2020 19:24:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002140652.GG7034@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 10/2/20 3:06 PM, Catalin Marinas wrote:
> On Fri, Oct 02, 2020 at 01:10:30AM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 7c67ac6f08df..d1847f29f59b 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -23,6 +23,8 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/sysreg.h>
>>  
>> +u64 gcr_kernel_excl __ro_after_init;
>> +
>>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>>  {
>>  	pte_t old_pte = READ_ONCE(*ptep);
>> @@ -120,6 +122,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>  	return ptr;
>>  }
>>  
>> +void mte_init_tags(u64 max_tag)
>> +{
>> +	u64 incl = GENMASK(max_tag & MTE_TAG_MAX, 0);
> 
> Nitpick: it's not obvious that MTE_TAG_MAX is a mask, so better write
> this as GENMASK(min(max_tag, MTE_TAG_MAX), 0).
> 

The two things do not seem equivalent because the format of the tags in KASAN is
0xFF and in MTE is 0xF, hence if extract the minimum whatever is the tag passed
by KASAN it will always be MTE_TAG_MAX.

To make it cleaner I propose: GENMASK(FIELD_GET(MTE_TAG_MAX, max_tag), 0);

> Otherwise it looks fine.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

-- 
Regards,
Vincenzo

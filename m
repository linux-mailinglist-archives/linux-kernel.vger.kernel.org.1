Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC52F9D61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbhARK7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:59:34 -0500
Received: from foss.arm.com ([217.140.110.172]:32920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389652AbhARK5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 907681FB;
        Mon, 18 Jan 2021 02:56:53 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF5F33F68F;
        Mon, 18 Jan 2021 02:56:50 -0800 (PST)
Subject: Re: [PATCH v3 4/4] arm64: mte: Optimize mte_assign_mem_tag_range()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210115120043.50023-1-vincenzo.frascino@arm.com>
 <20210115120043.50023-5-vincenzo.frascino@arm.com>
 <20210115154520.GD44111@C02TD0UTHF1T.local>
 <4b1a5cdf-e1bf-3a7e-593f-0089cedbbc03@arm.com>
 <0c1b9a6b-0326-a24f-6418-23a0723adecf@arm.com>
 <20210118104116.GB29688@C02TD0UTHF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ead05a9a-edef-7be9-b173-3a62caf187c3@arm.com>
Date:   Mon, 18 Jan 2021 11:00:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118104116.GB29688@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/21 10:41 AM, Mark Rutland wrote:
> On Sun, Jan 17, 2021 at 12:27:08PM +0000, Vincenzo Frascino wrote:
>> Hi Mark,
>>
>> On 1/16/21 2:22 PM, Vincenzo Frascino wrote:
>>>> Is there any chance that this can be used for the last bytes of the
>>>> virtual address space? This might need to change to `_addr == _end` if
>>>> that is possible, otherwise it'll terminate early in that case.
>>>>
>>> Theoretically it is a possibility. I will change the condition and add a note
>>> for that.
>>>
>>
>> I was thinking to the end of the virtual address space scenario and I forgot
>> that if I use a condition like `_addr == _end` the tagging operation overflows
>> to the first granule of the next allocation. This disrupts tagging accesses for
>> that memory area hence I think that `_addr < _end` is the way to go.
> 
> I think it implies `_addr != _end` is necessary. Otherwise, if `addr` is
> PAGE_SIZE from the end of memory, and `size` is PAGE_SIZE, `_end` will
> be 0, so using `_addr < _end` will mean the loop will terminate after a
> single MTE tag granule rather than the whole page.
> 
> Generally, for some addr/increment/size combination (where all are
> suitably aligned), you need a pattern like:
> 
> | do {
> |       thing(addr);
> |       addr += increment;
> | } while (addr != end);
> 
> ... or:
> 
> | for (addr = start; addr != end; addr += increment) {
> |       thing(addr);
> | }
> 
> ... to correctly handle working at the very end of the VA space.
> 
> We do similar for page tables, e.g. when we use pmd_addr_end().
>

Good point! I agree it wraps around otherwise. I will change it accordingly.

Thanks!

> Thanks,
> Mark.
> 

-- 
Regards,
Vincenzo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FF0300371
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbhAVMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:47:29 -0500
Received: from foss.arm.com ([217.140.110.172]:45938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbhAVMqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:46:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53A9011D4;
        Fri, 22 Jan 2021 04:45:58 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DF533F66E;
        Fri, 22 Jan 2021 04:45:56 -0800 (PST)
Subject: Re: [PATCH 0/1] mm: Optimizing hugepage zeroing in arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        "glider@google.com" <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210121165153.17828-1-prathu.baronia@oneplus.com>
 <20210121174616.GA22740@willie-the-truck>
 <de782758-a7bc-d5a5-832e-c09ce8fe7c00@arm.com> <20210122121334.GC8567@gaia>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d9a5beaa-2927-3c0b-80ed-2735f72db247@arm.com>
Date:   Fri, 22 Jan 2021 12:45:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122121334.GC8567@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-22 12:13, Catalin Marinas wrote:
> On Thu, Jan 21, 2021 at 06:59:37PM +0000, Robin Murphy wrote:
>> On 2021-01-21 17:46, Will Deacon wrote:
>>> On Thu, Jan 21, 2021 at 10:21:50PM +0530, Prathu Baronia wrote:
>>>> This patch removes the unnecessary kmap calls in the hugepage zeroing path and
>>>> improves the timing by 62%.
>>>>
>>>> I had proposed a similar change in Apr-May'20 timeframe in memory.c where I
>>>> proposed to clear out a hugepage by directly calling a memset over the whole
>>>> hugepage but got the opposition that the change was not architecturally neutral.
>>>>
>>>> Upon revisiting this now I see significant improvement by removing around 2k
>>>> barrier calls from the zeroing path. So hereby I propose an arm64 specific
>>>> definition of clear_user_highpage().
>>>
>>> Given that barrier() is purely a thing for the compiler, wouldn't the same
>>> change yield a benefit on any other architecture without HIGHMEM? In which
>>> case, I think this sort of change belongs in the core code if it's actually
>>> worthwhile.
>>
>> I would have thought it's more the constant manipulation of the preempt and
>> pagefault counts, rather than the compiler barriers between them, that has
>> the impact. Either way, if arm64 doesn't need to be atomic WRT preemption
>> when clearing parts of hugepages then I also can't imagine that anyone else
>> (at least for !HIGHMEM) would either.
> 
> I thought the kmap_local stuff was supposed to fix this unnecessary
> preemption disabling on 64-bit architectures:
> 
> https://lwn.net/Articles/836144/
> 
> I guess it's not there yet.

No, it's there alright - when I pulled up the code to double-check my 
memory of this area, I did notice the kerneldoc and start wondering if 
this should simply be using kmap_local_page() for everyone.

Robin.

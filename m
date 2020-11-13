Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930F92B1497
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 04:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKMDQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 22:16:42 -0500
Received: from foss.arm.com ([217.140.110.172]:60274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKMDQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 22:16:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75BF51042;
        Thu, 12 Nov 2020 19:16:41 -0800 (PST)
Received: from [10.163.79.120] (unknown [10.163.79.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0542F3F6CF;
        Thu, 12 Nov 2020 19:16:35 -0800 (PST)
Subject: Re: [PATCH] arm64: mm: account for hotplug memory when randomizing
 the linear region
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        gshan@redhat.com, Robin Murphy <robin.murphy@arm.com>,
        Steven Price <steven.price@arm.com>,
        David Hildenbrand <david@redhat.com>
References: <20201014081857.3288-1-ardb@kernel.org>
 <160503561804.1015659.16599672230432576934.b4-ty@arm.com>
 <a330440d-803b-5aa2-0092-a18317819850@arm.com> <20201112092558.GC29613@gaia>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2f0d9bc5-6288-7388-ff10-97198dabac6f@arm.com>
Date:   Fri, 13 Nov 2020 08:46:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201112092558.GC29613@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/20 2:55 PM, Catalin Marinas wrote:
> Hi Anshuman,
> 
> On Wed, Nov 11, 2020 at 09:18:56AM +0530, Anshuman Khandual wrote:
>> On 11/11/20 12:44 AM, Catalin Marinas wrote:
>>> On Wed, 14 Oct 2020 10:18:57 +0200, Ard Biesheuvel wrote:
>>>> As a hardening measure, we currently randomize the placement of
>>>> physical memory inside the linear region when KASLR is in effect.
>>>> Since the random offset at which to place the available physical
>>>> memory inside the linear region is chosen early at boot, it is
>>>> based on the memblock description of memory, which does not cover
>>>> hotplug memory. The consequence of this is that the randomization
>>>> offset may be chosen such that any hotplugged memory located above
>>>> memblock_end_of_DRAM() that appears later is pushed off the end of
>>>> the linear region, where it cannot be accessed.
>>>>
>>>> [...]
>>>
>>> Applied to arm64 (for-next/mem-hotplug), thanks!
>>>
>>> [1/1] arm64: mm: account for hotplug memory when randomizing the linear region
>>>       https://git.kernel.org/arm64/c/97d6786e0669
>>
>> Got delayed and never made here in time, sorry about that. Nonetheless,
>> I have got something working with respect to the generic mechanism that
>> David Hildenbrand had asked for earlier.
>>
>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> There was a lot of discussion around this patch but I haven't seen any
> new version posted.

Just posted before some time.

https://lore.kernel.org/linux-arm-kernel/1605236574-14636-1-git-send-email-anshuman.khandual@arm.com/

> 
>> I am wondering if we could instead consider merging the above patch with
>> a small change that Ard had pointed out earlier [1], I will send out a
>> revision if required.
> 
> If your patch fixes the randomisation issue that Ard addressed, I'm
> happy to replace that with your patch. But please post a new version and
> get some acks in place from the parties involved in the discussion.

The above patch is not a replacement for Ard's randomization patch here but
rather complements it. Hence both these patches should be considered, which
will make memory hotplug better on the platform.

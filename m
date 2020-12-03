Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB35C2CCAE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgLCANf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:13:35 -0500
Received: from foss.arm.com ([217.140.110.172]:54420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCANf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:13:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39101113E;
        Wed,  2 Dec 2020 16:12:49 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95B713F575;
        Wed,  2 Dec 2020 16:12:45 -0800 (PST)
Subject: Re: [RFC V2 0/3] mm/hotplug: Pre-validate the address range with
 platform
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <20201202203540.GC11274@osiris>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2d2a947f-3c4f-6106-583a-7da4e757a7aa@arm.com>
Date:   Thu, 3 Dec 2020 05:42:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202203540.GC11274@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/20 2:05 AM, Heiko Carstens wrote:
> On Mon, Nov 30, 2020 at 08:59:49AM +0530, Anshuman Khandual wrote:
>> This series adds a mechanism allowing platforms to weigh in and prevalidate
>> incoming address range before proceeding further with the memory hotplug.
>> This helps prevent potential platform errors for the given address range,
>> down the hotplug call chain, which inevitably fails the hotplug itself.
>>
>> This mechanism was suggested by David Hildenbrand during another discussion
>> with respect to a memory hotplug fix on arm64 platform.
>>
>> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
>>
>> This mechanism focuses on the addressibility aspect and not [sub] section
>> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
>> have been left unchanged. Wondering if all these can still be unified in
>> an expanded memhp_range_allowed() check, that can be called from multiple
>> memory hot add and remove paths.
>>
>> This series applies on v5.10-rc6 and has been slightly tested on arm64.
>> But looking for some early feedback here.
>>
>> Changes in RFC V2:
>>
>> Incorporated all review feedbacks from David.
>>
>> - Added additional range check in __segment_load() on s390 which was lost
>> - Changed is_private init in pagemap_range()
>> - Moved the framework into mm/memory_hotplug.c
>> - Made arch_get_addressable_range() a __weak function
>> - Renamed arch_get_addressable_range() as arch_get_mappable_range()
>> - Callback arch_get_mappable_range() only handles range requiring linear mapping
>> - Merged multiple memhp_range_allowed() checks in register_memory_resource()
>> - Replaced WARN() with pr_warn() in memhp_range_allowed()
>> - Replaced error return code ERANGE with E2BIG
>>
>> Changes in RFC V1:
>>
>> https://lore.kernel.org/linux-mm/1606098529-7907-1-git-send-email-anshuman.khandual@arm.com/
>>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
> 
> Btw. please use git send-email's --cc-cover option to make sure that
> all patches of this series will be sent to all listed cc's.
> I really dislike to receive only the cover-letter and maybe on patch
> and then have to figure out where to find the rest.

Okay, will ensure that.

> 
> Thanks :)
> 

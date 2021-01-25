Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20884303512
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbhAZFea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:34:30 -0500
Received: from foss.arm.com ([217.140.110.172]:44824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbhAYKYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:24:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9F01042;
        Mon, 25 Jan 2021 01:51:47 -0800 (PST)
Received: from [10.163.91.197] (unknown [10.163.91.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28E243F66E;
        Mon, 25 Jan 2021 01:51:43 -0800 (PST)
Subject: Re: [PATCH V4 0/4] mm/memory_hotplug: Pre-validate the address range
 with platform
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
 <c60ecbed-9073-83f9-e9e2-1f79a80cfe44@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8260d6fe-7df5-c667-2514-0d94cf87d31c@arm.com>
Date:   Mon, 25 Jan 2021 15:22:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c60ecbed-9073-83f9-e9e2-1f79a80cfe44@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/21 2:55 PM, David Hildenbrand wrote:
> On 25.01.21 03:58, Anshuman Khandual wrote:
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
>> This series applies on v5.11-rc5 and has been tested on arm64. But only
>> build tested on s390.
>>
> 
> Note that this fails to apply right now to both, -next and Linus' tree.
> Do you have a branch with he patches on top I can use for a quick test?
> Thanks
> 

Applied all four patches on v5.11-rc5.

https://gitlab.arm.com/linux-arm/linux-anshuman/-/tree/mm/hotplug_callback/v4/

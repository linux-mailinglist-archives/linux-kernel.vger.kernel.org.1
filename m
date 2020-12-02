Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E02CB533
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgLBGo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:44:58 -0500
Received: from foss.arm.com ([217.140.110.172]:59208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgLBGo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:44:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D93530E;
        Tue,  1 Dec 2020 22:44:12 -0800 (PST)
Received: from [10.163.83.48] (unknown [10.163.83.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E8B3F718;
        Tue,  1 Dec 2020 22:44:07 -0800 (PST)
Subject: Re: [RFC V2 0/3] mm/hotplug: Pre-validate the address range with
 platform
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7ffb5199-1b39-3f35-32cd-b59f71cc00c5@arm.com>
Date:   Wed, 2 Dec 2020 12:14:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/20 8:59 AM, Anshuman Khandual wrote:
> This series adds a mechanism allowing platforms to weigh in and prevalidate
> incoming address range before proceeding further with the memory hotplug.
> This helps prevent potential platform errors for the given address range,
> down the hotplug call chain, which inevitably fails the hotplug itself.
> 
> This mechanism was suggested by David Hildenbrand during another discussion
> with respect to a memory hotplug fix on arm64 platform.
> 
> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> This mechanism focuses on the addressibility aspect and not [sub] section
> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
> have been left unchanged. Wondering if all these can still be unified in
> an expanded memhp_range_allowed() check, that can be called from multiple
> memory hot add and remove paths.
> 
> This series applies on v5.10-rc6 and has been slightly tested on arm64.
> But looking for some early feedback here.
> 
> Changes in RFC V2:
> 
> Incorporated all review feedbacks from David.
> 
> - Added additional range check in __segment_load() on s390 which was lost
> - Changed is_private init in pagemap_range()
> - Moved the framework into mm/memory_hotplug.c
> - Made arch_get_addressable_range() a __weak function
> - Renamed arch_get_addressable_range() as arch_get_mappable_range()
> - Callback arch_get_mappable_range() only handles range requiring linear mapping
> - Merged multiple memhp_range_allowed() checks in register_memory_resource()
> - Replaced WARN() with pr_warn() in memhp_range_allowed()
> - Replaced error return code ERANGE with E2BIG

There is one build failure with MEMORY_HOTPLUG=y and MEMORY_HOTREMOVE=n.
There are warnings on arm64 and s390 platforms when built with W=1 due
to lack of prototypes required with -Wmissing-prototypes. I have fixed
all these problems for the next iteration when there is broad agreement
on the overall approach.

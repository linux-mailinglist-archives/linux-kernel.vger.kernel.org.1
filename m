Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6723304B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 22:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbhAZEqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 23:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbhAYJPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611565989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqYL4d9Wet8su96h3iK+TQ2tTSrGpnqviwW5v3ZJymE=;
        b=NcriAY0exsFdsXKTIBFvs+gnn6tDNw1SBImAT+hkgX3RtfDHkk/zrQiqWnTN23A3o3lFmx
        YZ3yXmQQD663fBf+49TX+3qut+dhbSvePrZisWgUKnna41KWGezF7zZBmpIjNQ81UD6tZ6
        p0ccIQ4N6KEQxCMMTmJPhYGdzEX/K6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-cpZnYtDQPpaJkZZw6Hzrbw-1; Mon, 25 Jan 2021 04:13:05 -0500
X-MC-Unique: cpZnYtDQPpaJkZZw6Hzrbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D8E107ACE3;
        Mon, 25 Jan 2021 09:13:03 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D463470481;
        Mon, 25 Jan 2021 09:13:00 +0000 (UTC)
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
 <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
 <bb5b9c39-d25b-6170-68ea-5b2bf297c1fd@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d527c0b8-415b-2425-9f4a-9edec43d8ae5@redhat.com>
Date:   Mon, 25 Jan 2021 10:13:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <bb5b9c39-d25b-6170-68ea-5b2bf297c1fd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.21 07:22, Anshuman Khandual wrote:
> 
> On 12/22/20 12:42 PM, Anshuman Khandual wrote:
>> pfn_valid() asserts that there is a memblock entry for a given pfn without
>> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
>> that they do not have memblock entries. Hence memblock_is_map_memory() will
>> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
>> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
>> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
>> into the system via memremap_pages() called from a driver, their respective
>> memory sections will not have SECTION_IS_EARLY set.
>>
>> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
>> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
>> for firmware reserved memory regions. memblock_is_map_memory() can just be
>> skipped as its always going to be positive and that will be an optimization
>> for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged
>> normal memory too will not have SECTION_IS_EARLY set for their sections.
>>
>> Skipping memblock_is_map_memory() for all non early memory sections would
>> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
>> performance for normal hotplug memory as well.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Hello David/Mike,
> 
> Given that we would need to rework early sections, memblock semantics via a
> new config i.e EARLY_SECTION_MEMMAP_HOLES and also some possible changes to
> ARCH_KEEP_MEMBLOCK and HAVE_ARCH_PFN_VALID, wondering if these patches here
> which fixes a problem (and improves performance) can be merged first. After
> that, I could start working on the proposed rework. Could you please let me
> know your thoughts on this. Thank you.

As I said, we might have to throw in an pfn_section_valid() check, to
catch not-section-aligned ZONE_DEVICE ranges (I assume this is possible
on arm64 as well, no?).

Apart from that, I'm fine with a simple fix upfront, that can be more
easily backported if needed. (Q: do we? is this stable material?)

-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334CE2E98F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhADPhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:37:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2288 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbhADPhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:37:50 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D8fl03Lbpz67WRx;
        Mon,  4 Jan 2021 23:32:28 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 4 Jan 2021 16:37:09 +0100
Received: from localhost (10.47.65.160) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 4 Jan 2021
 15:37:08 +0000
Date:   Mon, 4 Jan 2021 15:36:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        "David Hildenbrand" <david@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?ISO-8859-1?Q?J?= =?ISO-8859-1?Q?=E9r=F4me?= Glisse 
        <jglisse@redhat.com>, James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>, <will@kernel.org>,
        <ardb@kernel.org>
Subject: Re: [RFC 1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based
 memory
Message-ID: <20210104153633.00003288@Huawei.com>
In-Reply-To: <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
References: <1608621144-4001-1-git-send-email-anshuman.khandual@arm.com>
        <1608621144-4001-2-git-send-email-anshuman.khandual@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.160]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Dec 2020 12:42:23 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> pfn_valid() validates a pfn but basically it checks for a valid struct page
> backing for that pfn. It should always return positive for memory ranges
> backed with struct page mapping. But currently pfn_valid() fails for all
> ZONE_DEVICE based memory types even though they have struct page mapping.
> 
> pfn_valid() asserts that there is a memblock entry for a given pfn without
> MEMBLOCK_NOMAP flag being set. The problem with ZONE_DEVICE based memory is
> that they do not have memblock entries. Hence memblock_is_map_memory() will
> invariably fail via memblock_search() for a ZONE_DEVICE based address. This
> eventually fails pfn_valid() which is wrong. memblock_is_map_memory() needs
> to be skipped for such memory ranges. As ZONE_DEVICE memory gets hotplugged
> into the system via memremap_pages() called from a driver, their respective
> memory sections will not have SECTION_IS_EARLY set.
> 
> Normal hotplug memory will never have MEMBLOCK_NOMAP set in their memblock
> regions. Because the flag MEMBLOCK_NOMAP was specifically designed and set
> for firmware reserved memory regions. memblock_is_map_memory() can just be
> skipped as its always going to be positive and that will be an optimization
> for the normal hotplug memory. Like ZONE_DEVIE based memory, all hotplugged

typo: ZONE_DEVIE

> normal memory too will not have SECTION_IS_EARLY set for their sections.
> 
> Skipping memblock_is_map_memory() for all non early memory sections would
> fix pfn_valid() problem for ZONE_DEVICE based memory and also improve its
> performance for normal hotplug memory as well.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 73b20c84d42d ("arm64: mm: implement pte_devmap support")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/init.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 75addb36354a..ee23bda00c28 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -225,6 +225,18 @@ int pfn_valid(unsigned long pfn)
>  
>  	if (!valid_section(__pfn_to_section(pfn)))
>  		return 0;
> +
> +	/*
> +	 * ZONE_DEVICE memory does not have the memblock entries.
> +	 * memblock_is_map_memory() check for ZONE_DEVICE based
> +	 * addresses will always fail. Even the normal hotplugged
> +	 * memory will never have MEMBLOCK_NOMAP flag set in their
> +	 * memblock entries. Skip memblock search for all non early
> +	 * memory sections covering all of hotplug memory including
> +	 * both normal and ZONE_DEVIE based.

Here as well + the cover letter title.

> +	 */
> +	if (!early_section(__pfn_to_section(pfn)))
> +		return 1;
>  #endif
>  	return memblock_is_map_memory(addr);
>  }


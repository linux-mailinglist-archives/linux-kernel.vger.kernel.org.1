Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A962FEF88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbhAUPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbhAUPwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:52:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A3B822DFA;
        Thu, 21 Jan 2021 15:51:42 +0000 (UTC)
Date:   Thu, 21 Jan 2021 15:51:39 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
Message-ID: <20210121155139.GG21811@gaia>
References: <cover.1611206601.git.sudaraja@codeaurora.org>
 <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:29:13PM -0800, Sudarshan Rajagopalan wrote:
> memory_block_size_bytes() determines the memory hotplug granularity i.e the
> amount of memory which can be hot added or hot removed from the kernel. The
> generic value here being MIN_MEMORY_BLOCK_SIZE (1UL << SECTION_SIZE_BITS)
> for memory_block_size_bytes() on platforms like arm64 that does not override.
> 
> Current SECTION_SIZE_BITS is 30 i.e 1GB which is large and a reduction here
> increases memory hotplug granularity, thus improving its agility. A reduced
> section size also reduces memory wastage in vmemmmap mapping for sections
> with large memory holes. So we try to set the least section size as possible.
> 
> A section size bits selection must follow:
> (MAX_ORDER - 1 + PAGE_SHIFT) <= SECTION_SIZE_BITS
> 
> CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 and so just following it
> would help achieve the smallest section size.
> 
> SECTION_SIZE_BITS = (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
> 
> SECTION_SIZE_BITS = 22 (11 - 1 + 12) i.e 4MB   for 4K pages
> SECTION_SIZE_BITS = 24 (11 - 1 + 14) i.e 16MB  for 16K pages without THP
> SECTION_SIZE_BITS = 25 (12 - 1 + 14) i.e 32MB  for 16K pages with THP
> SECTION_SIZE_BITS = 26 (11 - 1 + 16) i.e 64MB  for 64K pages without THP
> SECTION_SIZE_BITS = 29 (14 - 1 + 16) i.e 512MB for 64K pages with THP
> 
> But there are other problems in reducing SECTION_SIZE_BIT. Reducing it by too
> much would over populate /sys/devices/system/memory/ and also consume too many
> page->flags bits in the !vmemmap case. Also section size needs to be multiple
> of 128MB to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.
> 
> Given these constraints, lets just reduce the section size to 128MB for 4K
> and 16K base page size configs, and to 512MB for 64K base page size config.
> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

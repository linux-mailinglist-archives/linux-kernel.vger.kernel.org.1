Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED642EC13B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAFQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:32:38 -0500
Received: from foss.arm.com ([217.140.110.172]:43816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFQci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:32:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11169D6E;
        Wed,  6 Jan 2021 08:31:52 -0800 (PST)
Received: from [10.37.8.33] (unknown [10.37.8.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2883F719;
        Wed,  6 Jan 2021 08:31:49 -0800 (PST)
Subject: Re: [PATCH 0/4] arm64: ARMv8.5-A: MTE: Add async mode support
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9a78cd4f-838d-0410-62fa-16e4ab921681@arm.com>
Date:   Wed, 6 Jan 2021 16:35:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106115519.32222-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/6/21 11:55 AM, Vincenzo Frascino wrote:
> This patchset implements the asynchronous mode support for ARMv8.5-A
> Memory Tagging Extension (MTE), which is a debugging feature that allows
> to detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.
> 
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> When MTE is enabled and tags are set for ranges of address space of a task,
> the PE will compare the tag related to the physical memory with the tag
> related to the virtual address (tag check operation). Access to the memory
> is granted only if the two tags match. In case of mismatch the PE will raise
> an exception.
> 
> The exception can be handled synchronously or asynchronously. When the
> asynchronous mode is enabled:
>   - Upon fault the PE updates the TFSR_EL1 register.
>   - The kernel detects the change during one of the following:
>     - Context switching
>     - Return to user/EL0
>     - Kernel entry from EL1
>     - Kernel exit to EL1
>   - If the register has been updated by the PE the kernel clears it and
>     reports the error.
> 
> The series contains as well an optimization to mte_assign_mem_tag_range().
> 
> The series is based on linux 5.11-rc2.
> 
> To simplify the testing a tree with the new patches on top has been made
> available at [1].
> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Will is not in arm anymore :( Sorry Will... I will fix this in v2.

> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Evgenii Stepanov <eugenis@google.com>
> Cc: Branislav Rankov <Branislav.Rankov@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Vincenzo Frascino (4):
>   kasan, arm64: Add KASAN light mode
>   arm64: mte: Add asynchronous mode support
>   arm64: mte: Enable async tag check fault
>   arm64: mte: Optimize mte_assign_mem_tag_range()
> 
>  arch/arm64/include/asm/memory.h    |  2 +-
>  arch/arm64/include/asm/mte-kasan.h |  5 ++-
>  arch/arm64/include/asm/mte.h       | 27 +++++++++++-
>  arch/arm64/kernel/entry-common.c   |  6 +++
>  arch/arm64/kernel/mte.c            | 67 ++++++++++++++++++++++++++++--
>  arch/arm64/lib/mte.S               | 15 -------
>  include/linux/kasan.h              |  1 +
>  include/linux/kasan_def.h          | 39 +++++++++++++++++
>  mm/kasan/hw_tags.c                 | 24 ++---------
>  mm/kasan/kasan.h                   |  2 +-
>  10 files changed, 145 insertions(+), 43 deletions(-)
>  create mode 100644 include/linux/kasan_def.h
> 

-- 
Regards,
Vincenzo

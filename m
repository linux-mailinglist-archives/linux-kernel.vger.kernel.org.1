Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0909D2C1266
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbgKWRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732699AbgKWRvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:51:14 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC25C2076E;
        Mon, 23 Nov 2020 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606153874;
        bh=gL0uiEnF5ux/DIVy6Bn9QO6COR6evZ2fenQNwK12ESU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSuPM32rdgh1Eft5jyCUi0yPVLGiv9SiWloey5rvN1O9eDA82uOpvf3C7PvUlOC67
         rLVepbViX/bb58GNXTbean7fkWU7n28Fms/41ypy6NB4gFpd/UPthavrCcZ+bbUVag
         0zsqh89VYuD/hSKd63/fgpumv+bL7LCQuZE0hcLk=
Date:   Mon, 23 Nov 2020 17:51:08 +0000
From:   Will Deacon <will@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Subject: Re: [tlb]  e242a269fa: WARNING:at_mm/mmu_gather.c:#tlb_gather_mmu
Message-ID: <20201123175107.GA11688@willie-the-truck>
References: <20201120143557.6715-6-will@kernel.org>
 <20201122151158.GK2390@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122151158.GK2390@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, this is interesting but my x86-fu is a bit lacking:

On Sun, Nov 22, 2020 at 11:11:58PM +0800, kernel test robot wrote:
> commit: e242a269fa4b7aee0b157ce5b1d7d12179fc3c44 ("[PATCH 5/6] tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()")
> url: https://github.com/0day-ci/linux/commits/Will-Deacon/tlb-Fix-access-and-soft-dirty-bit-management/20201120-223809
> base: https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git for-next/core

[...]

> [   14.182822] WARNING: CPU: 0 PID: 1 at mm/mmu_gather.c:293 tlb_gather_mmu+0x40/0x99

This fires because free_ldt_pgtables() initialises an mmu_gather() with
an end address > TASK_SIZE. In other words, this code:

	unsigned long start = LDT_BASE_ADDR;
	unsigned long end = LDT_END_ADDR;

	if (!boot_cpu_has(X86_FEATURE_PTI))
		return;

	tlb_gather_mmu(&tlb, mm, start, end);

seems to be passing kernel addresses to tlb_gather_mmu(), which will cause
the range adjusment logic in __tlb_adjust_range() to round the base down
to TASK_SIZE afaict. At which point, I suspect the low-level invalidation
routine replaces the enormous range with a fullmm flush (see the check in
flush_tlb_mm_range()).

If that's the case (and I would appreciate some input from somebody who
knows what an LDT is), then I think the right answer is to replace this with
a call to tlb_gather_mmu_fullmm, although I haven't ever anticipated these
things working on kernel addresses and whether that would do the right kind
of invalidation for x86 w/ PTI. A quick read of the code suggests it should
work out...

Will

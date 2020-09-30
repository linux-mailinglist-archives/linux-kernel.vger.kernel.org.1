Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3E27F006
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbgI3ROL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgI3ROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:14:08 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245352076B;
        Wed, 30 Sep 2020 17:14:06 +0000 (UTC)
Date:   Wed, 30 Sep 2020 18:14:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] arm64: mm: Make flush_tlb_fix_spurious_fault() a no-op
Message-ID: <20200930171403.GA29503@gaia>
References: <20200930131859.16989-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930131859.16989-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 02:18:59PM +0100, Will Deacon wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index f07333e86c2f..a696a7921da4 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -218,7 +218,9 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
>  		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
>  	} while (pteval != old_pteval);
>  
> -	flush_tlb_fix_spurious_fault(vma, address);
> +	/* Invalidate a stale read-only entry */
> +	if (dirty)
> +		flush_tlb_page(vma, address);
>  	return 1;

In my proposal I had a pte_accessible(pte) check instead of dirty here
since we may go for an old pte directly to a writable one and a TLBI
wouldn't be needed. Not that it matters from a performance perspective.

Either way,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

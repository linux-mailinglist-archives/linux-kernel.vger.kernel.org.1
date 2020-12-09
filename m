Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB002D491E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbgLISfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733046AbgLISfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:35:54 -0500
Date:   Wed, 9 Dec 2020 18:35:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, Jan Kara <jack@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] arm64: mm: Implement arch_wants_old_faultaround_pte()
Message-ID: <20201209183509.GH13566@gaia>
References: <20201209163950.8494-1-will@kernel.org>
 <20201209163950.8494-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209163950.8494-3-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:39:50PM +0000, Will Deacon wrote:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index da250e4741bd..3424f5881390 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -764,6 +764,18 @@ static inline bool cpu_has_hw_af(void)
>  						ID_AA64MMFR1_HADBS_SHIFT);
>  }
>  
> +static inline bool system_has_hw_af(void)
> +{
> +	u64 mmfr1;
> +
> +	if (!IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
> +		return false;
> +
> +	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> +	return cpuid_feature_extract_unsigned_field(mmfr1,
> +						ID_AA64MMFR1_HADBS_SHIFT);
> +}

Could we not add a new system-wide cpu feature that checks for hardware
AF? This read_sanitised_ftr_reg() does a binary search on each
invocation.

-- 
Catalin

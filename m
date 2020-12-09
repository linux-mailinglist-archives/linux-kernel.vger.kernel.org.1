Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C42D4963
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733106AbgLISrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733254AbgLISr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:47:29 -0500
Date:   Wed, 9 Dec 2020 18:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607539609;
        bh=sUy8zuiil22aMl2/aya4Ll0+5gUQS/Rh6dRvPnqxLcE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ln8pQQFlioSAMr7gY5t45IpDlGO7ZDz1ZNTK+hQZVBzLQx1z8ULe1JbEw+GktEtOg
         eZNky1psifTOoJY0c9pxE6xEIwWX4L9AZS1gjejXskx8JuXVyszVY4QAb/yUZHV+bw
         ikuSNodGLtY81zbVjPHINsdhk2fLyjn4Z7KBKzaQiLpZCNtyTMFTPQRLzXj7Dcp2k/
         VMuV0YJ19VzYurr2a8HFmYkMxblpoQKrDvybJSX0NFouQyexpP1K/RvSsitatmCQIf
         p2fAFzlPdRQ+iT6kXqlqlD6dJ0PwblRO5LjXStqrH/vdtvhQK9OuLE/KUjaPI9QLnT
         joVQLNKb6IXwg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, Jan Kara <jack@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] arm64: mm: Implement arch_wants_old_faultaround_pte()
Message-ID: <20201209184643.GB8778@willie-the-truck>
References: <20201209163950.8494-1-will@kernel.org>
 <20201209163950.8494-3-will@kernel.org>
 <20201209183509.GH13566@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209183509.GH13566@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 06:35:09PM +0000, Catalin Marinas wrote:
> On Wed, Dec 09, 2020 at 04:39:50PM +0000, Will Deacon wrote:
> > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > index da250e4741bd..3424f5881390 100644
> > --- a/arch/arm64/include/asm/cpufeature.h
> > +++ b/arch/arm64/include/asm/cpufeature.h
> > @@ -764,6 +764,18 @@ static inline bool cpu_has_hw_af(void)
> >  						ID_AA64MMFR1_HADBS_SHIFT);
> >  }
> >  
> > +static inline bool system_has_hw_af(void)
> > +{
> > +	u64 mmfr1;
> > +
> > +	if (!IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
> > +		return false;
> > +
> > +	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> > +	return cpuid_feature_extract_unsigned_field(mmfr1,
> > +						ID_AA64MMFR1_HADBS_SHIFT);
> > +}
> 
> Could we not add a new system-wide cpu feature that checks for hardware
> AF? This read_sanitised_ftr_reg() does a binary search on each
> invocation.

I posted a diff [1] which would allow removing the binary search for cases
where we can pass the register coding as a constant (like this), but
honestly, it's not like we have many ID registers so I doubt it really
matters in the grand scheme of things.

That said, I'm spinning a v2 anyway so I can include it for comments
since I haven't posted it as a proper patch before.

Will

[1] https://lore.kernel.org/r/20201202172727.GC29813@willie-the-truck

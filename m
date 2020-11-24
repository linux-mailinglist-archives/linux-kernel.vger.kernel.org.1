Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53272C270C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbgKXNYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:24:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbgKXNYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:24:45 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA7C2083E;
        Tue, 24 Nov 2020 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606224284;
        bh=SH24zETgIC2uK40KbauN9QWLDcUjyzI/5kjjC2KZ+fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iGIa9jIdjELamK289FVflS130IVk3T6wNF0lychyIOHz/la2LUAeR+dXXgw+S/fO/
         BEg6yoQMJSZXvXocSl0q/TtD30ZbGUmAgo+XcTO2xNUPIc0J1NQuIGHhwuVr9xXW2Y
         oaKFyn5dhtjsvcljxyT8+IrK9cSR6e0aJkeTowpY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khYJG-00DFyo-I3; Tue, 24 Nov 2020 13:24:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Nov 2020 13:24:42 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com
Subject: Re: [RFC PATCH 3/6] kvm: arm64: Fix up RELR relocation in hyp
 code/data
In-Reply-To: <20201119162543.78001-4-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
 <20201119162543.78001-4-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e8cf21cc5d246e73154217639adfafe5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, ascull@google.com, ardb@kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-19 16:25, David Brazdil wrote:
> The arm64 kernel also supports packing of relocation data using the 
> RELR
> format. Implement a parser of RELR data and fixup the relocations using
> the same infra as RELA relocs.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/va_layout.c | 41 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
> index b80fab974896..7f45a98eacfd 100644
> --- a/arch/arm64/kvm/va_layout.c
> +++ b/arch/arm64/kvm/va_layout.c
> @@ -145,6 +145,43 @@ static void __fixup_hyp_rela(void)
>  		__fixup_hyp_rel(rel[i].r_offset);
>  }
> 
> +#ifdef CONFIG_RELR
> +static void __fixup_hyp_relr(void)
> +{
> +	u64 *rel, *end;
> +
> +	rel = (u64*)(kimage_vaddr + __load_elf_u64(__relr_offset));
> +	end = rel + (__load_elf_u64(__relr_size) / sizeof(*rel));
> +
> +	while (rel < end) {
> +		unsigned n;
> +		u64 addr = *(rel++);
> +
> +		/* Address must not have the LSB set. */
> +		BUG_ON(addr & BIT(0));
> +
> +		/* Fix up the first address of the chain. */
> +		__fixup_hyp_rel(addr);
> +
> +		/*
> +		 * Loop over bitmaps, i.e. as long as words' LSB is 1.
> +		 * Each bit (ordered from LSB to MSB) represents one word from
> +		 * the last full address (exclusive). If the corresponding bit
> +		 * is 1, there is a relative relocation on that word.
> +		 */

What is the endianness of this bitmap? Is it guaranteed to be in
CPU-endian format?

> +		for (n = 0; rel < end && (*rel & BIT(0)); n++) {
> +			unsigned i;
> +			u64 bitmap = *(rel++);

nit: if you change this u64 for an unsigned long...

> +
> +			for (i = 1; i < 64; ++i) {
> +				if ((bitmap & BIT(i)))
> +					__fixup_hyp_rel(addr + 8 * (63 * n + i));
> +			}

... this can be written as:

         i = 1;
         for_each_set_bit_from(i, &bitmap, 64)
                 __fixup_hyp_rel(addr + 8 * (63 * n + i));

> +		}
> +	}
> +}
> +#endif
> +
>  /*
>   * The kernel relocated pointers to kernel VA. Iterate over 
> relocations in
>   * the hypervisor ELF sections and convert them to hyp VA. This avoids 
> the
> @@ -156,6 +193,10 @@ __init void kvm_fixup_hyp_relocations(void)
>  		return;
> 
>  	__fixup_hyp_rela();
> +
> +#ifdef CONFIG_RELR
> +	__fixup_hyp_relr();
> +#endif
>  }
> 
>  static u32 compute_instruction(int n, u32 rd, u32 rn)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

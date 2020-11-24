Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2312C28F2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgKXOCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbgKXOCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:02:39 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 590D72076E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606226558;
        bh=ueZAeL04uckNDd28QddIVeKofdi8RG1oj0UX85IE2CE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vC8sTOzZZNhg0Eut1OB3+3j1fYyVtJB/BwkJLsmoZE8soWwi8EV/YlziB2z6SQt1r
         GRglbic3RmwEJsk8SNqziyObNRJhQz4wjwM7ap7M1iYtqXH3L+7E8J39UySaZUYoOw
         jDRC9hUL4e+pr0/QoqMVAgvvOSr7q4VutMoHwAxk=
Received: by mail-ot1-f51.google.com with SMTP id n11so19398821ota.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:02:38 -0800 (PST)
X-Gm-Message-State: AOAM532llU/iNZZXOUbNUK6F9VAxykdmbQhV/A752MCanXuMZGXrf+nY
        GeWo7v+zW+x3nIsSSWuGMnWVOviSj3TqEOPaALM=
X-Google-Smtp-Source: ABdhPJyXuqCDGEixCef5QdG9nSVSccAFKPg6VhyzlBBNguekpVHckOJu4TqCBPaYkjdEvbEzzJJkV+TNyWRI0r6VOjQ=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr3359853otk.108.1606226557554;
 Tue, 24 Nov 2020 06:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20201119162543.78001-1-dbrazdil@google.com> <20201119162543.78001-4-dbrazdil@google.com>
In-Reply-To: <20201119162543.78001-4-dbrazdil@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 24 Nov 2020 15:02:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH84+aOa2jGOjQ62x6H_yB=0LtrVpHihtV31v=V5nR2Rg@mail.gmail.com>
Message-ID: <CAMj1kXH84+aOa2jGOjQ62x6H_yB=0LtrVpHihtV31v=V5nR2Rg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] kvm: arm64: Fix up RELR relocation in hyp code/data
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 17:25, David Brazdil <dbrazdil@google.com> wrote:
>
> The arm64 kernel also supports packing of relocation data using the RELR
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
>                 __fixup_hyp_rel(rel[i].r_offset);
>  }
>
> +#ifdef CONFIG_RELR

Please prefer IS_ENABLED() [below] if the code in question can compile
(but perhaps not link) correctly when the symbol is not set.

> +static void __fixup_hyp_relr(void)

__init ?

> +{
> +       u64 *rel, *end;
> +
> +       rel = (u64*)(kimage_vaddr + __load_elf_u64(__relr_offset));
> +       end = rel + (__load_elf_u64(__relr_size) / sizeof(*rel));
> +

The reason for this little dance with the offset and size exists
because the initial relocation routine runs from the ID mapping, but
the relocation fixups are performed via the kernel's VA mapping, as
the ID mapping does not cover the entire image. So simple adrp/add
pairs aren't suitable there.

In this case (as well as in the previous patch, btw), that problem
does not exist, and so I think we should be able to simply define
start and end markers inside the .rela sections, and reference them
here as symbols with external linkage (which ensures that they are
referenced relatively, although you could add in a
__attribute__((visibility("hidden"))) for good measure)



> +       while (rel < end) {
> +               unsigned n;
> +               u64 addr = *(rel++);

Parens are redundant here (and below)

> +
> +               /* Address must not have the LSB set. */
> +               BUG_ON(addr & BIT(0));
> +
> +               /* Fix up the first address of the chain. */
> +               __fixup_hyp_rel(addr);
> +
> +               /*
> +                * Loop over bitmaps, i.e. as long as words' LSB is 1.
> +                * Each bit (ordered from LSB to MSB) represents one word from
> +                * the last full address (exclusive). If the corresponding bit
> +                * is 1, there is a relative relocation on that word.
> +                */
> +               for (n = 0; rel < end && (*rel & BIT(0)); n++) {
> +                       unsigned i;
> +                       u64 bitmap = *(rel++);
> +
> +                       for (i = 1; i < 64; ++i) {
> +                               if ((bitmap & BIT(i)))
> +                                       __fixup_hyp_rel(addr + 8 * (63 * n + i));
> +                       }
> +               }
> +       }
> +}
> +#endif
> +
>  /*
>   * The kernel relocated pointers to kernel VA. Iterate over relocations in
>   * the hypervisor ELF sections and convert them to hyp VA. This avoids the
> @@ -156,6 +193,10 @@ __init void kvm_fixup_hyp_relocations(void)
>                 return;
>
>         __fixup_hyp_rela();
> +
> +#ifdef CONFIG_RELR
> +       __fixup_hyp_relr();
> +#endif
>  }
>
>  static u32 compute_instruction(int n, u32 rd, u32 rn)
> --
> 2.29.2.299.gdc1121823c-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B882D14DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgLGPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgLGPfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:35:54 -0500
X-Gm-Message-State: AOAM533XrIsmn8n5miQ06Q+LNPDvQb6p5cehNplzxGU/wXfli1WgUiWx
        qBQgHNFRBxMwyc4URezRiIHEytp3S7aBeITmRIM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607355313;
        bh=872LZLRA/jW9vxi15anlCqMMjRBZpeIFkNIHv5aF110=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i6Wk5N45uFz63/jC4GgUpMw4tYNUh6lvjcK5Te+jls87zxUiDZufZ/2EoCEC1yj91
         57mHVUVLYJogKSTRW0O689S6iUNI2wCs2zVXqwHf9gS8z6z5ipW4oAVkFkYn6/jtaq
         yL50ciMXnSMcRgKkqrFs2++nLiAZIUkIc0XgvfbqcCBuvuoqrYI4kOJGyWBwtZQls7
         cUKkixOtaGHdd/hMTfkMZlh4H9NsqnIAicKgyGszPtPoVVtiCy64WCTaAtA0pifDCX
         DmBj9HssHlUd5xj/UIrNLSwKlE7S7yVEiHjuZq3+Ey+03zWviNLHsNU1i1Wej0ljaj
         yK8gqO1VVFmyQ==
X-Google-Smtp-Source: ABdhPJyZfk5L3vN1AsUcQQwJK8YbU04Ct2pvcBdenlr7m+8bFpt062nHrbj4YKrBNMRXEeLwx/hEgoFAM9mQ1O1C8HE=
X-Received: by 2002:a9d:4042:: with SMTP id o2mr4287710oti.90.1607355312617;
 Mon, 07 Dec 2020 07:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <X7dB9GCUeHa+Hosn@sol.localdomain> <CAMj1kXECHnV6zfXOjEfsjgNTWRsXj7V_+T-hkgn8v69EEdWvEQ@mail.gmail.com>
 <CAHmME9pzcxQ1aufU7ycTcL+NQYV8P_wMKpetAuSogOw=2N9jRw@mail.gmail.com>
In-Reply-To: <CAHmME9pzcxQ1aufU7ycTcL+NQYV8P_wMKpetAuSogOw=2N9jRw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Dec 2020 16:35:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEXa1Gh-RzRFMe-eyXRT6Qdta+PWifm8AWt7YvM4sS=Zg@mail.gmail.com>
Message-ID: <CAMj1kXEXa1Gh-RzRFMe-eyXRT6Qdta+PWifm8AWt7YvM4sS=Zg@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 15:28, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> On Tue, Dec 1, 2020 at 1:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > is implemented. In most cases, these are special instructions, but in
> > > > > some cases, such as on ARM, we may want to back this using firmware
> > > > > calls, which are considerably more expensive.
>
> This seems fine. But I suppose I'm curious to learn more about what
> you have in mind for ARM. We've been assuming that arch_get_random is
> not horribly expensive. Usually external RNGs that are horribly
> expensive separate hardware take a different route and aren't hooked
> into arch_get_random. When you say "we may want to back this using
> firmware", does that mean it hasn't happened yet, and you're in a
> position to direct the design otherwise? If so, would it be reasonable
> to take a different route with that hardware, and keep arch_get_random
> for when it's actually implemented by the hardware? Or are there
> actually good reasons for keeping it one and the same?
>

Many older generation ARM SoCs have IP blocks that expose an entropy
source of some kind, and map it in the normal world, which is
accessible by the OS directly. These are driven as hwrngs via the
driver stack, which models them as actual devices, with clock and
regulator handling, power management hooks, etc etc.

There are multiple examples where such a SoC is being revved up with
newer cores etc, and now, the IP block is in the secure world, which
means the OS cannot access it directly, and needs to issue an SMC
instruction to perform a firmware call to access it. The secure world
firmware is now entirely in charge of the hardware, and so this SMC
call is really the only thing that goes on in this driver (no clocks,
regulators, etc)

So to prevent fragmentation, as well as make the entropy source
available much earlier in the boot, ARM has issued a firmware spec
that unifies these SMC calls, and defines them as non-blocking, i.e.,
return the requested number of entropy bits, or fail immediately.

Therefore, this should not be super expensive, given that the only
overhead is the CPU cycles spent on calling into the firmware (and a
bit of overhead perhaps from poking some MMIO registers in the IP
block). But it is definitely not suitable for being called hundreds of
times per second, hence this patch. (Note that we are talking about
arch_get_random_seed_long() here, not arch_get_random_long())

> On the other hand, rdrand on intel is getting slower and slower, to
> the point where we've removed it from a few places that used to use
> it. And I don't see anything terribly wrong with removing the extra
> call in this path here. So need be, I'll offer my Reviewed-by. But I
> wanted to get an understanding of the fuller story first.
>

Given that we already have both arch_get_random_seed_long() and
arch_get_random_long(), I think it is reasonable for the former to be
allowed to be slightly more expensive, and we should only invoke it
for the purpose of reseeding a pseudo-RNG. If this occurs on a hot
path, there is something terribly wrong already, so I don't think
RDRAND/RDSEED performance should be a huge concern here.

Note that once this patch lands, we also intend to change the current
way the arm64 RNDR and RNDRRS instructions are mapped to
arch_get_random_seed_long() and arch_get_random_long(). (RNDR returns
64-bit from a DRBG that reseeds an an implementation defined rate, and
RNDRRS does the same but forces a reseed to occur first)

Thanks,
Ard.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3674A2AEFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKKLtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKLs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:48:56 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A73206FB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605095335;
        bh=thpkcneAuU2okRMVMJwAiJlvQnf7AlL9RhNX38F2U3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uLw4MVnmUlmM3N8V1R9mLgezylV6JD2+gzDtqhLW9nijyGcMIhtOWGgrG1u6HqgnF
         nHWeKjYhR+uL4K3hzgsnYmcsNjU91D5tWDIN2EtXm6zwQuHMIyeoinpqe40F4NrU7o
         YJOk9VQ46gTYWzkWFiQPmdpS8Yj7Hw+CvUDhXZuM=
Received: by mail-oi1-f172.google.com with SMTP id d9so1865866oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 03:48:55 -0800 (PST)
X-Gm-Message-State: AOAM531Va9H7nc31okkupvyzceZI5QNXtNX8ywdPkEtdb6PuG2ok4GBX
        Ddddnf4vF9wzDly/f/WvVl2MYk/9euyxACilXDE=
X-Google-Smtp-Source: ABdhPJyXudDvaZhvjMLhyRjTOa0DbFsY5YGNerRtqO0XvUr+gKOz/VD8FaFC8Wi0k+wQ5AF/8H5TfS3BvA11tdACsZY=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr1918562oib.33.1605095334631;
 Wed, 11 Nov 2020 03:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20201105152944.16953-1-ardb@kernel.org> <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <0b0d47d9-76a5-723f-6642-d5ddadce7f94@arm.com> <CAMj1kXHBcb_UxeLs23XZt0VvNM-8JqchutU+qDwdWJm-WQpt5Q@mail.gmail.com>
 <fe355153-a718-4259-9ff3-26170b385353@arm.com>
In-Reply-To: <fe355153-a718-4259-9ff3-26170b385353@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 11 Nov 2020 12:48:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGboqZppYpHOk2B3cvVG12t2aqe5QYU6b6pt6pdm1vM=Q@mail.gmail.com>
Message-ID: <CAMj1kXGboqZppYpHOk2B3cvVG12t2aqe5QYU6b6pt6pdm1vM=Q@mail.gmail.com>
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020 at 11:46, Andr=C3=A9 Przywara <andre.przywara@arm.com> =
wrote:
>
> On 11/11/2020 10:05, Ard Biesheuvel wrote:
>
> Hi,
>
> > On Wed, 11 Nov 2020 at 10:45, Andr=C3=A9 Przywara <andre.przywara@arm.c=
om> wrote:
> >>
> >> On 11/11/2020 08:19, Ard Biesheuvel wrote:
> >>
> >> Hi,
> >>
> >>> (+ Eric)
> >>>
> >>> On Thu, 5 Nov 2020 at 16:29, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>>
> >>>> When reseeding the CRNG periodically, arch_get_random_seed_long() is
> >>>> called to obtain entropy from an architecture specific source if one
> >>>> is implemented. In most cases, these are special instructions, but i=
n
> >>>> some cases, such as on ARM, we may want to back this using firmware
> >>>> calls, which are considerably more expensive.
> >>>>
> >>>> Another call to arch_get_random_seed_long() exists in the CRNG drive=
r,
> >>>> in add_interrupt_randomness(), which collects entropy by capturing
> >>>> inter-interrupt timing and relying on interrupt jitter to provide
> >>>> random bits. This is done by keeping a per-CPU state, and mixing in
> >>>> the IRQ number, the cycle counter and the return address every time =
an
> >>>> interrupt is taken, and mixing this per-CPU state into the entropy p=
ool
> >>>> every 64 invocations, or at least once per second. The entropy that =
is
> >>>> gathered this way is credited as 1 bit of entropy. Every time this
> >>>> happens, arch_get_random_seed_long() is invoked, and the result is
> >>>> mixed in as well, and also credited with 1 bit of entropy.
> >>>>
> >>>> This means that arch_get_random_seed_long() is called at least once
> >>>> per second on every CPU, which seems excessive, and doesn't really
> >>>> scale, especially in a virtualization scenario where CPUs may be
> >>>> oversubscribed: in cases where arch_get_random_seed_long() is backed
> >>>> by an instruction that actually goes back to a shared hardware entro=
py
> >>>> source (such as RNDRRS on ARM), we will end up hitting it hundreds o=
f
> >>>> times per second.
> >>
> >> May I ask why this should be a particular problem? Form what I gathere=
d
> >> on the web, it seems like most h/w RNGs have a capacity of multiple
> >> MBit/s. Wikipedia [1] suggests that the x86 CPU instructions generate =
at
> >> least 20 Mbit/s (worst case: AMD's 2500 cycles @ 800 MHz), and I
> >> measured around 78 Mbit/s with the raw entropy source on my Juno
> >> (possibly even limited by slow MMIO).
> >> So it seems unlikely that a few kbit/s drain the hardware entropy sour=
ce.
> >>
> >> If we consider this interface comparably cheap, should we then not try
> >> to plug the Arm firmware interface into this?
> >>
> >
> > I'm not sure I follow. Are you saying we should not wire up a
> > comparatively expensive firmware interface to
> > arch_get_random_seed_long() because we currently assume it is backed
> > by something cheap?
>
> Yes. I wanted to (ab)use this patch to clarify this. x86 and arm64 use
> CPU instructions (so far), S390 copies from some buffer. PPC uses either
> a CPU instruction or an MMIO access. All of these I would consider
> comparably cheap, especially when compared to a firmware call with
> unknown costs. In fact the current Trusted Firmware implementation[1] is
> not really terse, also the generic SMC dispatcher calls a platform
> defined routine, which could do anything.
> So to also guide the implementation in TF-A, it would be good to
> establish what arch_get_random expects to be. The current
> implementations and the fact that it lives in a header file suggests
> that it's meant as a slim wrapper around something cheap.
>

Reseeding a random number generator is simply not something that you
should need to do hundreds of times per second, regardless of whether
its invocation is from a header file.



> > Because doing so would add significantly to the cost. Also note that a
> > firmware interface would permit other ways of gathering entropy that
> > are not necessarily backed by a dedicated high bandwidth noise source
> > (and we already have examples of this)
>
> Yes, agreed.
> So I have a hwrng driver for the Arm SMCCC TRNG interface ready. I would
> post this, but would like to know if we should drop the proposed
> arch_get_random implementation [2][3] of this interface.
>

No, that would defeat the whole point. There is no reason we should
wait for the entire driver stack to come up just to issue an
architected SMC call. This is basically the reason the spec got issued
in the first place.

> >> I am not against this patch, actually am considering this a nice
> >> cleanup, to separate interrupt generated entropy from other sources.
> >> Especially since we call arch_get_random_seed_long() under a spinlock =
here.
> >> But I am curious about the expectations from arch_get_random in genera=
l.
> >>
> >
> > I think it is reasonable to clean this up a little bit. A random
> > *seed* is not the same thing as a random number, and given that we
> > expose both interfaces, it makes sense to permit the seed variant to
> > be more costly, and only use it as intended (i.e., to seed a random
> > number generator)
>
> That's true, it seems we chickened out on the arm64 implementation
> already, by not using the intended stronger instruction for seed
> (RNDRRS), and not implementing arch_get_random_long() at all.
> But I guess that's another story.
>

Yes it is.

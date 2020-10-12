Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6226728AE42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgJLGfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgJLGfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:35:38 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAD52087D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602484538;
        bh=hXndvJfgUYBEUZBQhxGGgUznUG20iIo9FKCmrLhjA/w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z6YW8pnzmnw6m5TdyFrBXQfdQDkK5Jt9JxkadI2WaXG0PzxUUxisu9MiewKoMVY42
         knuZQJWkbqWIfUW8TQh6Fdq/Ll9yMaHBieGdY9Wm8c5UAr/7TsvZumHYiPln547/+2
         +UniNLM09dVvT05uPJ5rQiGrqo9sNzTffR4LYRM4=
Received: by mail-ot1-f52.google.com with SMTP id s66so14925314otb.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:35:37 -0700 (PDT)
X-Gm-Message-State: AOAM530OqhaHGTgn+pHxQ8jK1cQTtkY/IDn+GmfqDDOu/Z/onP+oTaCN
        sdWLJe55nDEC312wIyO8ehEtHw4znAciih665o8=
X-Google-Smtp-Source: ABdhPJxveMcsyBlHuQEo9l/9LIY2D7vtz1I35u67LuEyuxe27tZ3WC+ulykMl87K8JAU8har6Ht8iCDd4RBqs6IHKU8=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr7928149otr.108.1602484537156;
 Sun, 11 Oct 2020 23:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201006201808.37665-1-andre.przywara@arm.com>
 <20201006201808.37665-3-andre.przywara@arm.com> <65057faa-d06b-6baf-4f12-9587cacbe3a9@arm.com>
 <d5ca622f-5eec-4898-e3b5-af3e26de7cf0@arm.com>
In-Reply-To: <d5ca622f-5eec-4898-e3b5-af3e26de7cf0@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Oct 2020 08:35:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGrHxZprjY9ZJPKMLeFHVhcsQNT2uCcqCv2LJuuQ2fAUg@mail.gmail.com>
Message-ID: <CAMj1kXGrHxZprjY9ZJPKMLeFHVhcsQNT2uCcqCv2LJuuQ2fAUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Add support for SMCCC TRNG firmware interface
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Oct 2020 at 16:44, Andr=C3=A9 Przywara <andre.przywara@arm.com> w=
rote:
>
> On 07/10/2020 15:16, James Morse wrote:
>
> Hi,
>
> > On 06/10/2020 21:18, Andre Przywara wrote:
> >> The ARM architected TRNG firmware interface, described in ARM spec
> >> DEN0098[1], defines an ARM SMCCC based interface to a true random numb=
er
> >> generator, provided by firmware.
> >> This can be discovered via the SMCCC >=3Dv1.1 interface, and provides
> >> up to 192 bits of entropy per call.
> >>
> >> Hook this SMC call into arm64's arch_get_random_*() implementation,
> >> coming to the rescue when the CPU does not implement the ARM v8.5 RNG
> >> system registers.
> >>
> >> For the detection, we piggy back on the PSCI/SMCCC discovery (which gi=
ves
> >> us the conduit to use: hvc or smc), then try to call the
> >> ARM_SMCCC_TRNG_VERSION function, which returns -1 if this interface is
> >> not implemented.
> >
> >>  arch/arm64/include/asm/archrandom.h | 83 +++++++++++++++++++++++++---=
-
> >>  1 file changed, 73 insertions(+), 10 deletions(-)
> >
> >> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/=
asm/archrandom.h
> >> index ffb1a40d5475..b6c291c42a48 100644
> >> --- a/arch/arm64/include/asm/archrandom.h
> >> +++ b/arch/arm64/include/asm/archrandom.h
> >> @@ -7,6 +7,13 @@
> >>  #include <linux/bug.h>
> >>  #include <linux/kernel.h>
> >>  #include <asm/cpufeature.h>
> >> +#include <linux/arm-smccc.h>
> >> +
> >> +static enum smc_trng_status {
> >> +    SMC_TRNG_UNKNOWN,
> >> +    SMC_TRNG_NOT_SUPPORTED,
> >> +    SMC_TRNG_SUPPORTED
> >> +} smc_trng_status =3D SMC_TRNG_UNKNOWN;
> >
> > Doesn't this static variable in a header file mean each file that inclu=
des this has its
> > own copy? Is that intentional?
>
> Right, and it's not intentional. It doesn't really break, but since
> random.h includes archrandom.h, we get an instance everywhere :-(
>
> I wasn't too happy with this detection method to begin with (and also
> not with stuffing everything into a header file), but wanted to
> accommodate the early case, where PSCI hasn't been initialised yet, and
> so we don't know the SMCCC conduit. A static key sounds better, but gets
> a bit hairy with this scenario, I think.
>
> Any ideas here?

I think the early case isn't worth obsessing about. PSCI is
initialized in setup_arch(), which gets called way before
rand_initialize(), which is where this functionality will get used the
first time typically. And kaslr_early_init() is called extremely
early, i.e., straight from head.S, and we should avoid adding any more
code there that sets global state (if kaslr_early_init() exits
successfully, the kernel will be unmapped and remapped again in a
different place, and BSS cleared again etc etc)

> I could copy Ard's solution and introduce random.c, if that makes more
> sense.
>
> Cheers,
> Andre

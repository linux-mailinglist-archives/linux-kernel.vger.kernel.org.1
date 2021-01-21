Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D717D2FF0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbhAUQrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:47:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:54771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732983AbhAUQo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611247386;
        bh=qRZ6iTuOHB3w3EON4V74VVwotW69ctxJnSRL0UlFDqQ=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=dQLvZmpzTaaFcV6PpZT8K2FgRZmnqW5BXSWi1ern5GXYXCmaNstvXsXd6uVjCgE9E
         2UriW910m+agL7XnwgSmHVaIF141WIW9RrElZMi9dnJYOCZj4Y5vFd9G+rpT7OLPNE
         UFRc2XHGNYAKgqPDqeIawKp67oDE3mjfBiCvTJNY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MO9zH-1lMEGB2QSv-00OUMw; Thu, 21
 Jan 2021 17:43:06 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <CAL_JsqJq_wfLrJm8rwspkgz81Be2V9WTudRjMAXSrZD50ewFYA@mail.gmail.com>
Date:   Thu, 21 Jan 2021 17:43:03 +0100
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEDB12D6-2916-4430-A8DC-FBD9352F3730@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
 <CAL_JsqJq_wfLrJm8rwspkgz81Be2V9WTudRjMAXSrZD50ewFYA@mail.gmail.com>
To:     Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:TWpsVTc1UOJ44wP6fgpVADTch53UG4YAuOe8Q2aRaRSHjYYRomm
 hxfG4sTbBlGBSuDuVuXPH2XsMdE4bAiTLYuzl43WnJEdcYsQWQtnib4DbzQXmWNo59YwDLO
 qmd97ij/N9It3+58NkbuGSTHcXECqtJhYyCci+SkDFMavtA57R8063JjyrjuXzZlOM13nsg
 qLlmpwSRFGMFWY+KLvA5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QwGjk+qLBGo=:P2rJkNkg5LS2cKYYibkcae
 5vLjVXtm4NAQzAK2+SQQFpsXjj5ookSgRWygnxkR6WvJvG6WTLYFlx8j5MPSNG9Ayds7gH5Gp
 WHr+e2lBfYuF6hL6AulJEKcVbXQ/T220Gv9nUZ6kwxHXzeK9UfglyJsEmR2LvC2BeRjwp/YU0
 fE35e3wTQWFNP45gOfuGw7Fun6ms5ntPBiVSJ91pM17m2QvUJD5cDXQhVQizm84zraBV9+38v
 f7oAxeZA9xKO6W6Dsk+wE/YbDAU6Hglcosj5wW0L3lTv5bqF29CZg2c5A3Ncs1WbTodU6m0bQ
 ZVg2lH+AWP1kKku43zL91z88ZmNbseBdm3Y5hXOC/fbL+dUf+TgZyaHloT0aF01H7JojdN8Tl
 BhvOE9UyCECySnm3zcvnkX64/Ls0zQ40lXmHuscRZONDu1D/c0rKjq1sSfHOjQWqrIZFkngAq
 LlnxZT/Qg+Uak4jaMtH/jqOQGVf1dhbLRYL6XGxLGnsjCFwtoE26KSvKWrqvVO/1pK5LiUhpU
 AbdYxX21cPOt4y1dIeadxVESk0CulQiquvWcZI6p+0PnjMuPOPENSViXtaFWRZ48u0luXEAWb
 b6Q5YlyaOB7/Bl9PIbIQceEp6MUKR2QdGUSX/aDAVJB8XwzDbzOv7QlIKunAiHEGkZVfLL1kY
 qLHO808ILgmdoZjI0CzZ+i25EwYrfP+kB55ZHNpYSdnmTSNFCpUyeNTTZlcm65xdqTGoB+cLr
 UW75y2nmejjTaM0c7gs2lazm3cNIDvLHZ4vKMStFjjsyp7n36Ye3/UbVfc9e6MVBFrFfNAUTj
 Kesq65QrnqIPlOqBTpD9B4tg2BLz5QUqRgV7PHJI/zHKKPYx2gDZbR2Un8POtlJfc0kislgRm
 fFqGywHNUEBK+KZ1AjcVklsqzre5RBcCBfYVRkvZM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Jan 2021, at 17:40, Rob Herring <robh@kernel.org> wrote:
>=20
> On Thu, Jan 21, 2021 at 6:52 AM Mohamed Mediouni
> <mohamed.mediouni@caramail.com> wrote:
>>=20
>>=20
>>=20
>>> On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
>>>=20
>>> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
>>> <mohamed.mediouni@caramail.com> wrote:
>>>=20
>>>> +#ifdef CONFIG_SMP
>>>> +static void apple_aic_ipi_send_mask(struct irq_data *d,
>>>> +                                   const struct cpumask *mask)
>>>=20
>>> Not sure we care about the #ifdef here, given that arch/arm64 does =
not
>>> allow building a kernel without CONFIG_SMP.
>>>=20
>>>> +       /*
>>>> +     * Ensure that stores to Normal memory are visible to the
>>>> +     * other CPUs before issuing the IPI.
>>>> +     */
>>>> +       wmb();
>>>> +
>>>> +       for_each_cpu (cpu, mask) {
>>>> +               smp_mb__before_atomic();
>>>> +               atomic_or(1u << irqnr, per_cpu_ptr(&aic_ipi_mask, =
cpu));
>>>> +               smp_mb__after_atomic();
>>>> +               lcpu =3D get_cpu();
>>>> +               if (aic.fast_ipi) {
>>>> +                       if ((lcpu >> 2) =3D=3D (cpu >> 2))
>>>> +                               write_sysreg(cpu & 3, =
SR_APPLE_IPI_LOCAL);
>>>> +                       else
>>>> +                               write_sysreg((cpu & 3) | ((cpu >> =
2) << 16),
>>>> +                                            SR_APPLE_IPI_REMOTE);
>>>> +               } else
>>>> +                       writel(lcpu =3D=3D cpu ? REG_IPI_FLAG_SELF =
:
>>>> +                                                  =
(REG_IPI_FLAG_OTHER << cpu),
>>>> +                              aic.base + REG_IPI_SET);
>>>> +               put_cpu();
>>>> +       }
>>>> +
>>>> +       /* Force the above writes to be executed */
>>>> +       if (aic.fast_ipi)
>>>> +               isb();
>>>> +}
>>>=20
>>> Since this just loops over all CPUs, I'd probably just turn it into
>>> an ipi_send_single() callback and have the caller do the
>>> loop for simplicity.
>>>=20
>>> I also have the feeling that splitting one hardware IPI into =
multiple
>>> logical interrupts, which are then all registered by the same irq
>>> handler adds a little more complexity than necessary.
>>>=20
>>> Changing this would of course require modifications to
>>> arch/arm64/kernel/smp.c, which is hardwired to use
>>> CONFIG_GENERIC_IRQ_IPI in smp_cross_call(), and allowing
>>> a different code path there may be worse than emulating an
>>> irqchip.
>>>=20
>>>> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct =
device_node *node,
>>>>      if (WARN(!aic.base, "unable to map aic registers\n"))
>>>>              return -EINVAL;
>>>>=20
>>>> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
>>>=20
>>> Where is this property documented, and what decides which one to =
use?
>> It=E2=80=99s getting documented in the next patch set.
>>=20
>> This property is there to enable support for older iPhone processors
>> later on, some of which do not have fast IPI support.
>>=20
>> On Apple M1, fast-ipi is always on.
>=20
> This should be implied by the compatible string which needs to be more
> specific and include the SoC name.
>=20
> Rob

Then we=E2=80=99ll eventually have two aic compatible strings, aic which =
is compatible
with Apple A7 onwards and aicv2 which is a superset with fast IPI =
(introduced=20
on the Apple A11, 3 years ago, with no further programmer-visible =
changes since=20
then).

Does that look right?

Thank you,=20


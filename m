Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A062FEABB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbhAUMxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:53:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:33185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbhAUMxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611233448;
        bh=wxmgfpmBhrsdPK93rM0xenUVwYAc2Qsuo4Jdk1DH/TU=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=bw1sSKonISN7cfR6Z+TEqNH9nFwgRxacHSMQFZbFAOcPNxSIJ1xIyHsDDfqZ0o5uj
         U4oEcZWMAzkPODGtakLkgiUivhvRBYquNchZ3Q0Y1igFfIHMeTOhbvloJbB0UpJ6JB
         CRIq3HF+QFbA8a0sifNDdxL6wKr+myc4C2ZCN2xY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBDnI-1lAmcI1v5S-00Cm34; Thu, 21
 Jan 2021 13:50:48 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
Date:   Thu, 21 Jan 2021 13:50:47 +0100
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:oZzUZUD1iqzn6wnOqTNUiSAJB4BtZLaIkOKa0UB4zSYBgDFKcm0
 SusL/+ROWQfkMv60Nj8L0mP1V/jJToGuqaD+haRAkfbwRto1UsD60moR7+2L/sjcLGMb7HM
 O0KqAGDg+jhzu0NHalzHPC3lwMPp1kCf7V+dWtQCAAPcHvxo9cZRmyXs22XECgJhTQFFVgP
 v/Jyj+XadF1Lijdq6fjZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zdrNY4ysWEA=:CQ1F9tuXRmDE6hoCLvA/Uy
 SYw+rVAXXqDHCLpl2wQg4tiEv1TKZ1h/E8n/ceX/3wZhwQZVM00t/PsuqYzJ4LbeRWGCNsmG/
 BegIwDeWuQezUZzoWkrk0e5LnnY21f1eZbNHVjjVTq+1SWd5/5gKrinIDFUDq2zNLDRYIor56
 5v11P98lxqbSJBzLH5qeAhlN5jpsqft0+xI29cMQRcjAAydnqB8ZrP0Te0JWr+KGhAp1ZqyaZ
 1D8sxz8Lw1Sc66po7GyLMGS+ddVT41JYOf35hjmVerDhmuMkFKnXh3cStpFNF9hhpAsxMR3bN
 fWXN7VdAsT/4+YVTWStZmKAXq//3FQzp8OW+cf20OMCzduu2hPfQ2ydCBp9A50FXQQQS+QtNt
 aiFj15cgx2qH2mpymiVIyV4n0rCYPrYBi+/J8sYD0cnQnYuhjL4jrobAWZh8CQoAZldxRdPm5
 XwRaQSfwosmg+TIxMwkwk9lJD/U+NmUKqYc99QGvdb3b45krLBpOjGTTsCG3sR79Mtga1Z1XG
 8GT7aJm3G6sNxX301U5xPqfhy+LN8Y8WIOsuRO1Ics3hdGw4OUPSUtx198qG6anrm08r18vRa
 MAetMNhQFdLZ5HZV0a012gBV9w8XnpKbUS0WiJO2JKBYCco1qUR1dQdIQydfRG+SF/LdBNref
 x5iz9IfkLAn/k7PVsAaTo831vTe+cqi2GtLQNcr7acde+RH4BiEKgrEEEkjEIAGwLwTKZAB7x
 UwWLzf5+DKbWnQebdlhk6Nq82m0qhqMrdXGMotG5zVQ+tYf9keLiDDtkSaMGCQNIP1bNUUeb7
 tUXGkjKcIjXOP7nPU+RLr/BrxRgH0vE2YEXbA6ITSb2jhBSD59kWh1rBUnOSuPXqDtRE6IkTL
 qghbXsoO7BpT//wbiwA6PV/ggO1HVOxAGRzRlR5No=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
> <mohamed.mediouni@caramail.com> wrote:
>=20
>> +#ifdef CONFIG_SMP
>> +static void apple_aic_ipi_send_mask(struct irq_data *d,
>> +                                   const struct cpumask *mask)
>=20
> Not sure we care about the #ifdef here, given that arch/arm64 does not
> allow building a kernel without CONFIG_SMP.
>=20
>> +       /*
>> +     * Ensure that stores to Normal memory are visible to the
>> +     * other CPUs before issuing the IPI.
>> +     */
>> +       wmb();
>> +
>> +       for_each_cpu (cpu, mask) {
>> +               smp_mb__before_atomic();
>> +               atomic_or(1u << irqnr, per_cpu_ptr(&aic_ipi_mask, =
cpu));
>> +               smp_mb__after_atomic();
>> +               lcpu =3D get_cpu();
>> +               if (aic.fast_ipi) {
>> +                       if ((lcpu >> 2) =3D=3D (cpu >> 2))
>> +                               write_sysreg(cpu & 3, =
SR_APPLE_IPI_LOCAL);
>> +                       else
>> +                               write_sysreg((cpu & 3) | ((cpu >> 2) =
<< 16),
>> +                                            SR_APPLE_IPI_REMOTE);
>> +               } else
>> +                       writel(lcpu =3D=3D cpu ? REG_IPI_FLAG_SELF :
>> +                                                  =
(REG_IPI_FLAG_OTHER << cpu),
>> +                              aic.base + REG_IPI_SET);
>> +               put_cpu();
>> +       }
>> +
>> +       /* Force the above writes to be executed */
>> +       if (aic.fast_ipi)
>> +               isb();
>> +}
>=20
> Since this just loops over all CPUs, I'd probably just turn it into
> an ipi_send_single() callback and have the caller do the
> loop for simplicity.
>=20
> I also have the feeling that splitting one hardware IPI into multiple
> logical interrupts, which are then all registered by the same irq
> handler adds a little more complexity than necessary.
>=20
> Changing this would of course require modifications to
> arch/arm64/kernel/smp.c, which is hardwired to use
> CONFIG_GENERIC_IRQ_IPI in smp_cross_call(), and allowing
> a different code path there may be worse than emulating an
> irqchip.
>=20
>> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct =
device_node *node,
>>       if (WARN(!aic.base, "unable to map aic registers\n"))
>>               return -EINVAL;
>>=20
>> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
>=20
> Where is this property documented, and what decides which one to use?
It=E2=80=99s getting documented in the next patch set.

This property is there to enable support for older iPhone processors
later on, some of which do not have fast IPI support.

On Apple M1, fast-ipi is always on.

Thank you,
>       Arnd


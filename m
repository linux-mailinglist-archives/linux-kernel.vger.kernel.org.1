Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B842FEE73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbhAUPXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:23:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:36777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731791AbhAUPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611242334;
        bh=3+zbhvgYp/KF6vvuwaiizfonFUtX9PdLLJIrGqCiYHM=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=CZOACZjjo7pDATuoUgSbcUlDmVbxdHonLT5i1pV2Kv5YMpov9oCwZJig2Z8+IYhFa
         79rkFk1p8UFzEPyc0cRm1QGS7HDH64iFA5KagM5fYt/uDgHBT87+evrw/8Qi16X/rD
         RKnFtNVa8t5Qq3R/LQZ0Y8glNNhARTgQRaHwrPrk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzhnH-1lxRTb1yG9-00vdJa; Thu, 21
 Jan 2021 16:18:54 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <CAK8P3a0EhemsG45RQSUQ8ON2REAbJuxcpHhMmWn+-GQCgP2t7w@mail.gmail.com>
Date:   Thu, 21 Jan 2021 16:18:53 +0100
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <34C3EC52-15A0-4DFF-8953-2A12E88ADDD4@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
 <71e94b48857cbdd21c5d6bdadf148621@kernel.org>
 <2861E21B-32B9-479E-A5F6-528D021183E6@caramail.com>
 <7131f110736b8a17c824f39abeeaf711@kernel.org>
 <CAK8P3a0EhemsG45RQSUQ8ON2REAbJuxcpHhMmWn+-GQCgP2t7w@mail.gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:gY/oL3K3E4bklwKx9zttka4uStWhAMBpzWW4GfQuk7T4QhXVHDX
 Yj41Zw2yki+vyXZ2qBKTtwmxjRBjoq/tFy3IqgzMSQObfA1s+udNuAk0M5H1OsOkDuwbXba
 Vc7XexNROLsI5HYUjFT0/sCnY7ClS5H1Nuxe0CJGphknwhNkf7+tnpba71o4j7K8oHYUxOO
 5WAkSem7hc0fwIr2GfDYg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vS6fwU437V0=:mY/XtJZIW+SW5M4NItHUTl
 K4rMXhF7C6524a7yP2ZBSGxnYTO4wDxJMSYaNktj8A5au7qthMh95s7v7y8B5kHDCovCQpzZf
 KR2cM4d2XHezcpEke9wtiPUe4tD2LjF9EJuJu26ZbVGyZrkq0JH5/FgHGj2sF1CZO3QQ6Dqn0
 IJfaSjMNHTSqHKIV3Rj9chur00kdYAoTEhbxAXO13I/kMu0efLtoLKdcJ/Y13fUrNW9HMGfPX
 75BUie58Nbsk2kjcaXMK3bE7OoPukKOq6Jm/OTc8ntMfFdeLJOA9S6QUtQYxn+iLmT1h84s+B
 Dtt0JLedZNTRyJz2EhPauzlW7rtkvuSAyoA8pGwmqq62dTR5/3eSXzpPJXC0EzK3tdp6pd/p/
 ShURd7Vqxo4OJ6qkk1OICegPuTgwG/HsgrD6yV/M/jibA8bbGomf48TF9ckvz7OpOq8Z1cfo1
 mlePcfxR+UWX31v7Nlq8uuyTeNC7tzOEOgx1T5jDrzgyqVpoe/Buw5O6NiiygBlg1mgeeeFIQ
 tXP8Rc3vTLFH4tGgUz1mMNTEqoe4RfD2XPHyjHxEYsCcyeV+DD+sq0ZSJU2T3lcqoGxx3sMNV
 3ajSlM+Xbi+7AkWhjRoeJV4PGzHN1uGhCEtPBd8Ug6NCP3+69jifmQ3VZpCpCo90xhlimT1FM
 29DcJvCT1aeeX/LN7WsA28IbDEASUSt/cMUo8Y0rskV4fgT6bxtw82Mbf5rppUDDc8A2PDFvO
 toZctUiXdumtEEkOFTyzNu1XYG7AphjbBEXyUX0j7aHB/pMzpU4osFAcgPzmB+Bes17b9TwYU
 Lmz9FJdjpcAPzwqnArT6NKKKiyi2Omdz76AE1vJGuKm3ZXKd0CuubnawpIWOP0l9PhPADYJaY
 3KrB3LoMRidoW0y48MLshACMSDB19QHyOt3ZMwevU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Jan 2021, at 16:09, Arnd Bergmann <arnd@kernel.org> wrote:
>=20
> On Thu, Jan 21, 2021 at 3:10 PM Marc Zyngier <maz@kernel.org> wrote:
>> On 2021-01-21 13:34, Mohamed Mediouni wrote:
>>>> On 21 Jan 2021, at 14:22, Marc Zyngier <maz@kernel.org> wrote:
>>> Because UART access adapters for the new M1 Macs aren=E2=80=99t =
plentiful
>>> at all, I actually use this for development, with iPhones which have
>>> much more easy to buy Lightning-to-UART adapters.
>>>=20
>>> (That=E2=80=99s why the old implementation is there too)
>>>=20
>>> Might be worth splitting the new one to a new commit though...
>>=20
>> This series is supposed to cover M1 only, and adding extra support
>> as part of it is only likely to make the code harder to review.
>>=20
>> I'd rather you focus on a single IPI interface (fast or slow,
>> I don't really care). Extra features can come in later.
>=20
> Agreed. The slow interface is probably easier to start with,
> because it avoids hooking into the FIQ, so the FIQ can be
> completely decoupled from AIC and just used for the timer.
>=20
> Maybe there is even a way to use more than one hardware IPI in
> the AIC?
>=20
>       Arnd
Hello,

Decided to only have only the slow interface in the second patch series.

Thank you,=

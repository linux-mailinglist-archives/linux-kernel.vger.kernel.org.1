Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1335C2FF2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbhAUSNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:13:05 -0500
Received: from mout.gmx.net ([212.227.15.19]:44949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389591AbhAUSLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611252540;
        bh=QfhxphCdVKvLvjpXaoa7/kvLOstgKECKtAZEQWM8ywU=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=IY3a82MBVXnR+XuDjaYBKX0Gm2ZtmPej+W4WID0kHUEvp+jUAxPMycqWXV2WCpElP
         QknDY3O/U/+JtQVBBk09hvbMRkuaw+u7VSXR6hYjxSf+xb3gfASz4mkG237ZOQ9MpJ
         uD6yRdWgL+Jhzy9l7WRCtPoBBZwSCzmXMr0A9CVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Yv-1lxvjc2tOt-00wB2z; Thu, 21
 Jan 2021 19:08:59 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
In-Reply-To: <CAL_Jsq+V74tMGJ==OVdsssfqTTa3TrFujfRjj0174uZNonpQSA@mail.gmail.com>
Date:   Thu, 21 Jan 2021 19:08:54 +0100
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <950D140B-491A-40EB-9FDB-D7173B86737B@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com>
 <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com>
 <CAL_JsqJq_wfLrJm8rwspkgz81Be2V9WTudRjMAXSrZD50ewFYA@mail.gmail.com>
 <FEDB12D6-2916-4430-A8DC-FBD9352F3730@caramail.com>
 <CAL_Jsq+V74tMGJ==OVdsssfqTTa3TrFujfRjj0174uZNonpQSA@mail.gmail.com>
To:     Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:5bi+UftWGgKXkK5CIHh5y7Fh4dvoWEqrHS3XkxOUDATNs77NJGF
 4QIhagnStQ1QzuSIgQ7O/WwU4bR+9pnsCmbKNoTv/16ubpo/MMhbUvbGHDgZSxeS5dNg1Es
 5xnaTkcQ+EJUlixHAJ69SX0Wt2GJYNpX1BpXhq0M+uuPmmlV9t62F/A52NQVnMhC5wo/LMw
 w0aBftSJVAf9g+a9zZ1rQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UY3jSNqU8UY=:2uCTpKuUB+Y6//w3U0RofH
 ssB8BOxWDK7PGddfOJGKVe3pk2J3f6OacbSt2dQMeZGv0kDPpnKBgvfFe94ZyNRb1s/xe8Pu3
 OQ2Gc5r8C5XubKGBm7RNOzKDwQasYuhmTjpWXMciImY71M8NrENMtrng+JjV0Pm2epG84xTPh
 raWoT5D6ytpjU11PRvZRdFpjMZQ69bfJ9jD1KbqqhJi/iTKmSZus2oBVnudwzqWbYugAX+0me
 T5yAV535XmKC4euHxyPn126pKVSDnVaxdRsiALsowgeu9RdnyGU3TUMJW6p+iR3FwEcqCATxz
 OEijtOQ1wCwyLRw5+ewoXCGAWZbCK0SC5NvFUTQ0djLYmtdguf12FLml+wMSLwtgwHcs+jkkM
 axqCe2WxelSsVWAw5hmhHjlt4C6JHYIXZh8TwLlupqnxOXMxD7v4d2oQxx6C3QSLRn/uxVtpb
 GSAnzuOrS2nEs3/dxuKV8EvEr4JMvELm6nbPKQqNJF54lvyEdFm4EKSPJFu38PfnBDcGyaC+F
 X29xswgIhIS96mk88Mz0Xy0d3J7eRjTCHwf/AwuachJH5xqr+Le0IPHV1Q0eqyTXyGThu525Z
 I5xml3F0cHAE0wxVPxRZbNTTAsOGTTr1aAAGFqDlP+07W+Y0E1lNfjUFXdalDc0M0D/FbC1OB
 Lyue8dPh7aAoBiI2pDnAOOKAyLefKu/oi1JPMVjfYVZZnyIDwywx8np020luFEQmR6yQq61V0
 EoKKX323gFh8jeZOeO4y9Ep5lmSYHazaMdvbTEHwGEZ7Le60TXYoMxiXUrqD7gVb/qiWpki3y
 QoxWOZ0bRknbPcZJK+2J/LDe9mPDnPPJylleMbAlZGAl8liStbS1nU+FTp8odFzxpgoMHLxyD
 rJzihuFnEhcOVhgRaltfiPTyJzV/BXcTqj7k+Oql8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 21 Jan 2021, at 18:37, Rob Herring <robh@kernel.org> wrote:
>=20
> On Thu, Jan 21, 2021 at 10:43 AM Mohamed Mediouni
> <mohamed.mediouni@caramail.com> wrote:
>>> On 21 Jan 2021, at 17:40, Rob Herring <robh@kernel.org> wrote:
>>> On Thu, Jan 21, 2021 at 6:52 AM Mohamed Mediouni
>>> <mohamed.mediouni@caramail.com> wrote:
>>>>> On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
>>>>> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
>>>>> <mohamed.mediouni@caramail.com> wrote:
>=20
> [...]
>=20
>>>>>> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct =
device_node *node,
>>>>>>     if (WARN(!aic.base, "unable to map aic registers\n"))
>>>>>>             return -EINVAL;
>>>>>>=20
>>>>>> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
>>>>>=20
>>>>> Where is this property documented, and what decides which one to =
use?
>>>> It=E2=80=99s getting documented in the next patch set.
>>>>=20
>>>> This property is there to enable support for older iPhone =
processors
>>>> later on, some of which do not have fast IPI support.
>>>>=20
>>>> On Apple M1, fast-ipi is always on.
>>>=20
>>> This should be implied by the compatible string which needs to be =
more
>>> specific and include the SoC name.
>>>=20
>>> Rob
>>=20
>> Then we=E2=80=99ll eventually have two aic compatible strings, aic =
which is compatible
>> with Apple A7 onwards and aicv2 which is a superset with fast IPI =
(introduced
>> on the Apple A11, 3 years ago, with no further programmer-visible =
changes since
>> then).
>>=20
>> Does that look right?
>=20
> If we did this from the start, it would evolve like this:
>=20
> A7: "AAPL,a7-aic"
> A8: "AAPL,a8-aic", "AAPL,a7-aic"  # Read this as A8 AIC is backwards
> compatible with A7 AIC
> A9: "AAPL,a9-aic", "AAPL,a7-aic"
>=20
> A11: "AAPL,a11-aic", "AAPL,a7-aic"
>=20
> If the A11 version could work on an OS that only supported the
> original model (sounds like this is the case) Or if it's not backwards
> compatible:
>=20

The A11 AIC indeed can be used by older drivers that aren=E2=80=99t =
aware
of the fast IPI path introduced on A11 just fine.

> A11: "AAPL,a11-aic"
>=20
> If the A11 is different and not backwards compatible.
>=20
> Then M1 could be:
>=20
> M1: "AAPL,m1-aic", "AAPL,a11-aic"
>=20
> Or to even support an OS with only v1 support:
>=20
> M1: "AAPL,m1-aic", "AAPL,a11-aic", "AAPL,a7-aic"
>=20
> You don't really need the fallback here because there isn't any
> existing OS support and the baseline is the M1.
>=20
> If you want to have generic fallback compatible strings with versions,
> that's fine too. I'm not really a fan of version numbers that are just
> made up by the binding author though. Most SoC vendors don't have
> rigorous versioning of their IP and those that do seem to have a new
> version on every SoC.
>=20
> The important part is *always* having an SoC specific compatible so
> you can deal with any quirk or feature without having to change the
> DTB. Everyone says blocks are 'the same' until they aren=E2=80=99t.
>=20
Is it fine if such a SoC-specific compatible is present but with having
the driver only know about AAPL,a11-aic for example?
(To just have it when it=E2=80=99d be needed if ever in the future, but =
not uselessly
add entries to the driver that will not be currently used)

On a tangent:

The internal naming scheme used by Apple is off-by-one:

Apple A14 for example is Apple H13P (H-series 13th gen processor, Phone)
Apple M1 is Apple H13G (H-series 13th gen, G series)
(And Apple A12X is Apple H11G for example, with A12 being H11P)

Should we bother with those or use the marketing names? Especially =
because
the beefier SoCs might not be of the H series anyway=E2=80=A6 as the =
internal scheme
reveals that M1 could as well have been an A14X.

And there=E2=80=99s also the other internal naming scheme:
Apple A12 being t8020, Apple A12X being t8027
Apple A14 being t8101
Apple M1 being t8103

T there means the foundry at which the chip was manufactured, in the =
cases above TSMC.

Of course Apple itself uses both=E2=80=A6 with the marketing name being =
nowhere in their device
trees.

Thank you,

> Rob


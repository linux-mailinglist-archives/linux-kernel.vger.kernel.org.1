Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4082FF22C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbhAURkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388371AbhAURil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:38:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 815E122A85
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611250680;
        bh=pbLdfRzzUFQZlOoeKwNwXB2IqIKEyNdxbp1eh/xv3iE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RyMKB/Utnx+Lg7sZaAb8CLhkN5M6ApF2KEy9AzeMpTPwuxceAu7AL2r3n1YOnZZ0e
         CcN3aeggDpbFPd6kYu862YSbaR9599ALHsb62L762E+ct1PlsaphD2fmyIy2kaFe3d
         rrhxb7M9/lgjaOe153at+j6oX+wGFo/1ezxQgJGjeeEvvJkcykfxwHgHBEL+QUCF10
         /G8NDlstIKxx1h4m3R2qwLC5TyJtkiYr8QwLKB+my4FMx5/+/tjo17vGyrCBWC679t
         dqo4CIF+o6D1MrMLMOdcfcWp2X7xKpTzDfK4WodkeY8lqP6V6ZBSFQdqRIYLcdKX3t
         qtM/Uusl2K/cw==
Received: by mail-ed1-f49.google.com with SMTP id g1so3489848edu.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:38:00 -0800 (PST)
X-Gm-Message-State: AOAM532pFzJj162A6d6ic8m2G/frhbUsW1//Q3jEzo8+i0YRSJefKHOf
        rJDiBT1dr4gBasp4JqIk1ZgRNYGmzccivA/THQ==
X-Google-Smtp-Source: ABdhPJyje3REHQ2MnKRkhdF2kmCOTa6gwar6C3EgP19gvRIJDhEgoIQqh+H9zu3GTlogtZLiFvljQmGPtiHV3DxqfHI=
X-Received: by 2002:a05:6402:1b11:: with SMTP id by17mr163527edb.373.1611250678926;
 Thu, 21 Jan 2021 09:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com> <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com> <CAL_JsqJq_wfLrJm8rwspkgz81Be2V9WTudRjMAXSrZD50ewFYA@mail.gmail.com>
 <FEDB12D6-2916-4430-A8DC-FBD9352F3730@caramail.com>
In-Reply-To: <FEDB12D6-2916-4430-A8DC-FBD9352F3730@caramail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jan 2021 11:37:46 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+V74tMGJ==OVdsssfqTTa3TrFujfRjj0174uZNonpQSA@mail.gmail.com>
Message-ID: <CAL_Jsq+V74tMGJ==OVdsssfqTTa3TrFujfRjj0174uZNonpQSA@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] irqchip/apple-aic: add SMP support to the Apple
 AIC driver.
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:43 AM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:
> > On 21 Jan 2021, at 17:40, Rob Herring <robh@kernel.org> wrote:
> > On Thu, Jan 21, 2021 at 6:52 AM Mohamed Mediouni
> > <mohamed.mediouni@caramail.com> wrote:
> >>> On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
> >>> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
> >>> <mohamed.mediouni@caramail.com> wrote:

[...]

> >>>> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct device_=
node *node,
> >>>>      if (WARN(!aic.base, "unable to map aic registers\n"))
> >>>>              return -EINVAL;
> >>>>
> >>>> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
> >>>
> >>> Where is this property documented, and what decides which one to use?
> >> It=E2=80=99s getting documented in the next patch set.
> >>
> >> This property is there to enable support for older iPhone processors
> >> later on, some of which do not have fast IPI support.
> >>
> >> On Apple M1, fast-ipi is always on.
> >
> > This should be implied by the compatible string which needs to be more
> > specific and include the SoC name.
> >
> > Rob
>
> Then we=E2=80=99ll eventually have two aic compatible strings, aic which =
is compatible
> with Apple A7 onwards and aicv2 which is a superset with fast IPI (introd=
uced
> on the Apple A11, 3 years ago, with no further programmer-visible changes=
 since
> then).
>
> Does that look right?

If we did this from the start, it would evolve like this:

A7: "AAPL,a7-aic"
A8: "AAPL,a8-aic", "AAPL,a7-aic"  # Read this as A8 AIC is backwards
compatible with A7 AIC
A9: "AAPL,a9-aic", "AAPL,a7-aic"

A11: "AAPL,a11-aic", "AAPL,a7-aic"

If the A11 version could work on an OS that only supported the
original model (sounds like this is the case) Or if it's not backwards
compatible:

A11: "AAPL,a11-aic"

If the A11 is different and not backwards compatible.

Then M1 could be:

M1: "AAPL,m1-aic", "AAPL,a11-aic"

Or to even support an OS with only v1 support:

M1: "AAPL,m1-aic", "AAPL,a11-aic", "AAPL,a7-aic"

You don't really need the fallback here because there isn't any
existing OS support and the baseline is the M1.

If you want to have generic fallback compatible strings with versions,
that's fine too. I'm not really a fan of version numbers that are just
made up by the binding author though. Most SoC vendors don't have
rigorous versioning of their IP and those that do seem to have a new
version on every SoC.

The important part is *always* having an SoC specific compatible so
you can deal with any quirk or feature without having to change the
DTB. Everyone says blocks are 'the same' until they aren't.

Rob

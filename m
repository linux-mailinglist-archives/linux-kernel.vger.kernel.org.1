Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F63B2FF3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbhAUTJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbhAUTHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:07:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 810E523A63
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 18:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611255467;
        bh=9uEG+UKcIRbXlM2KsrUvRrmi/R25J0TMFGny/+Avp+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ts6wmKw/C6qGIPi/X3U8SOs0bh2imUtKlPGxDMnUOvz5k7lg0wt40Ln1zfxgJ/526
         mDC5KLDwm8bMKgHaqhW0fwwpVc0RcL7mG2LPeJZSJhC3tYWM/PMcZ73Pv8E6/OlvLA
         Cl0JE6JdkvQJ56hyhg4Fas8SR8RzaAvYaHWZzBwxEzySz+wS0HUtHLUVt5/nVgom5z
         QcVSv6esagipoJ/EBEtnjf1VR2fMVF2gmY80DKSj3XTXHT74J5JsdMhrWKcZfTXB17
         RRTOuu7wnfEfIIRfeqespolzX952/PXsIMjJQnKiAKFMeoyxIeqqLeSE+XQTIWVdtE
         x3siMvU70ILeA==
Received: by mail-ej1-f48.google.com with SMTP id w1so4099860ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 10:57:47 -0800 (PST)
X-Gm-Message-State: AOAM532GdSWOzo+2HQ1WKCLd+CWRHLzwheoOFf/HG2hm3jYU2TI8QCBj
        4un9OauP78PUnrrd04nkCfYuZDCLwJcgIA4rRQ==
X-Google-Smtp-Source: ABdhPJx1g/sLGw3hYoIj0dQUVVLDLsVzB3ysfszouwAQSR6cj1IVK4J+z0fKGVOWbO8JsIIpWj0K/HycJypxe0Mhjp4=
X-Received: by 2002:a17:907:d01:: with SMTP id gn1mr561009ejc.130.1611255465946;
 Thu, 21 Jan 2021 10:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-8-mohamed.mediouni@caramail.com> <CAK8P3a1qeVxTxZXpfMe70zpPCSBrTOz23ZTR=PHgw0PP9GUvbw@mail.gmail.com>
 <E77005CF-8B2A-4D17-9330-72ECFD7F3C93@caramail.com> <CAL_JsqJq_wfLrJm8rwspkgz81Be2V9WTudRjMAXSrZD50ewFYA@mail.gmail.com>
 <FEDB12D6-2916-4430-A8DC-FBD9352F3730@caramail.com> <CAL_Jsq+V74tMGJ==OVdsssfqTTa3TrFujfRjj0174uZNonpQSA@mail.gmail.com>
 <950D140B-491A-40EB-9FDB-D7173B86737B@caramail.com>
In-Reply-To: <950D140B-491A-40EB-9FDB-D7173B86737B@caramail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jan 2021 12:57:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK=QMKnhOoxpb+9-wUtMFR=sfqJ7pMc=O6pR4O0hT99WQ@mail.gmail.com>
Message-ID: <CAL_JsqK=QMKnhOoxpb+9-wUtMFR=sfqJ7pMc=O6pR4O0hT99WQ@mail.gmail.com>
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

On Thu, Jan 21, 2021 at 12:09 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:
>
>
>
> > On 21 Jan 2021, at 18:37, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Jan 21, 2021 at 10:43 AM Mohamed Mediouni
> > <mohamed.mediouni@caramail.com> wrote:
> >>> On 21 Jan 2021, at 17:40, Rob Herring <robh@kernel.org> wrote:
> >>> On Thu, Jan 21, 2021 at 6:52 AM Mohamed Mediouni
> >>> <mohamed.mediouni@caramail.com> wrote:
> >>>>> On 21 Jan 2021, at 13:44, Arnd Bergmann <arnd@kernel.org> wrote:
> >>>>> On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
> >>>>> <mohamed.mediouni@caramail.com> wrote:
> >
> > [...]
> >
> >>>>>> @@ -186,8 +325,11 @@ static int __init apple_aic_init(struct devic=
e_node *node,
> >>>>>>     if (WARN(!aic.base, "unable to map aic registers\n"))
> >>>>>>             return -EINVAL;
> >>>>>>
> >>>>>> +       aic.fast_ipi =3D of_property_read_bool(node, "fast-ipi");
> >>>>>
> >>>>> Where is this property documented, and what decides which one to us=
e?
> >>>> It=E2=80=99s getting documented in the next patch set.
> >>>>
> >>>> This property is there to enable support for older iPhone processors
> >>>> later on, some of which do not have fast IPI support.
> >>>>
> >>>> On Apple M1, fast-ipi is always on.
> >>>
> >>> This should be implied by the compatible string which needs to be mor=
e
> >>> specific and include the SoC name.
> >>>
> >>> Rob
> >>
> >> Then we=E2=80=99ll eventually have two aic compatible strings, aic whi=
ch is compatible
> >> with Apple A7 onwards and aicv2 which is a superset with fast IPI (int=
roduced
> >> on the Apple A11, 3 years ago, with no further programmer-visible chan=
ges since
> >> then).
> >>
> >> Does that look right?
> >
> > If we did this from the start, it would evolve like this:
> >
> > A7: "AAPL,a7-aic"
> > A8: "AAPL,a8-aic", "AAPL,a7-aic"  # Read this as A8 AIC is backwards
> > compatible with A7 AIC
> > A9: "AAPL,a9-aic", "AAPL,a7-aic"
> >
> > A11: "AAPL,a11-aic", "AAPL,a7-aic"
> >
> > If the A11 version could work on an OS that only supported the
> > original model (sounds like this is the case) Or if it's not backwards
> > compatible:
> >
>
> The A11 AIC indeed can be used by older drivers that aren=E2=80=99t aware
> of the fast IPI path introduced on A11 just fine.
>
> > A11: "AAPL,a11-aic"
> >
> > If the A11 is different and not backwards compatible.
> >
> > Then M1 could be:
> >
> > M1: "AAPL,m1-aic", "AAPL,a11-aic"
> >
> > Or to even support an OS with only v1 support:
> >
> > M1: "AAPL,m1-aic", "AAPL,a11-aic", "AAPL,a7-aic"
> >
> > You don't really need the fallback here because there isn't any
> > existing OS support and the baseline is the M1.
> >
> > If you want to have generic fallback compatible strings with versions,
> > that's fine too. I'm not really a fan of version numbers that are just
> > made up by the binding author though. Most SoC vendors don't have
> > rigorous versioning of their IP and those that do seem to have a new
> > version on every SoC.
> >
> > The important part is *always* having an SoC specific compatible so
> > you can deal with any quirk or feature without having to change the
> > DTB. Everyone says blocks are 'the same' until they aren=E2=80=99t.
> >
> Is it fine if such a SoC-specific compatible is present but with having
> the driver only know about AAPL,a11-aic for example?
> (To just have it when it=E2=80=99d be needed if ever in the future, but n=
ot uselessly
> add entries to the driver that will not be currently used)

Yes, that's expected. You add the more specific compatible when you
add the feature or quirk work-around.

>
> On a tangent:
>
> The internal naming scheme used by Apple is off-by-one:
>
> Apple A14 for example is Apple H13P (H-series 13th gen processor, Phone)
> Apple M1 is Apple H13G (H-series 13th gen, G series)
> (And Apple A12X is Apple H11G for example, with A12 being H11P)
>
> Should we bother with those or use the marketing names? Especially becaus=
e
> the beefier SoCs might not be of the H series anyway=E2=80=A6 as the inte=
rnal scheme
> reveals that M1 could as well have been an A14X.
>
> And there=E2=80=99s also the other internal naming scheme:
> Apple A12 being t8020, Apple A12X being t8027
> Apple A14 being t8101
> Apple M1 being t8103
>
> T there means the foundry at which the chip was manufactured, in the case=
s above TSMC.
>
> Of course Apple itself uses both=E2=80=A6 with the marketing name being n=
owhere in their device
> trees.

I'd probably lean toward the marketing names, but don't really care as
long as you're consistent both for a given SoC and across generations.

Rob

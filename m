Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7C2C8CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgK3ScZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgK3ScZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:32:25 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B16F2074A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606761104;
        bh=gwsL+0EwlkMhjy0Ll0CqSrl4s0yHH5VqLRU4u4UBbzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pyhKMQne49aewdzx28w9mbVCGogTjmUPe3tODU3l3pJIx/7i8gUnQec1Yh92og8tj
         RfZudpYWC/wLU21SpFCf0UjnfTCSFSbP47EgwZcaQfO+vb+wDyrQLnOfLBye11TgxY
         STvdZ2aEbTRsqzNH4sVUQ2Q/KqcrdfUllIh33QwY=
Received: by mail-oi1-f179.google.com with SMTP id d9so15261402oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:31:44 -0800 (PST)
X-Gm-Message-State: AOAM531fNNnScJplq/+CMs0VTfRcXMMKy448EPCfz+J2MJFFknL+i+Re
        Fz+IGZxoui+pHnYdYL9vdK7YAVlGKs7SXQeq95Y=
X-Google-Smtp-Source: ABdhPJx2PmV4wLNq8NxfSnZDPDD3E4eQh/Sl7HJ2oCEuxm0xuX1VDV7sOhkQscKFDW//1m3kHJpK+F38uKGQvG+Y+9A=
X-Received: by 2002:aca:c657:: with SMTP id w84mr111043oif.47.1606761103398;
 Mon, 30 Nov 2020 10:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org> <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
 <846387e4168f1a22638ad07ae670c531@kernel.org> <e93770e46c73413882584ebc3fe732e3@huawei.com>
In-Reply-To: <e93770e46c73413882584ebc3fe732e3@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Nov 2020 19:31:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
Message-ID: <CAMj1kXGdEbDzFN2cCNpCx_QJk3++v3zrWZ7Yw08Exrzyy_Q97w@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 at 17:22, Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Marc Zyngier [mailto:maz@kernel.org]
> > Sent: 30 November 2020 14:57
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > eric.auger@redhat.com; Linuxarm <linuxarm@huawei.com>
> > Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy sup=
port
> >
> > Hi Shameer,
> >
> > On 2020-11-30 13:55, Shameerali Kolothum Thodi wrote:
> > > Hi Marc,
> > >
> > >> -----Original Message-----
> > >> From: Marc Zyngier [mailto:maz@kernel.org]
> > >> Sent: 30 November 2020 12:28
> > >> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > >> Cc: linux-kernel@vger.kernel.org;
> > >> linux-arm-kernel@lists.infradead.org;
> > >> eric.auger@redhat.com; Linuxarm <linuxarm@huawei.com>
> > >> Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy
> > >> support
> > >>
> > >> Hi Shameer,
> > >>
> > >> On 2020-11-30 10:26, Shameer Kolothum wrote:
> > >> > At present, the support for GICv2 backward compatibility on GICv3/=
v4
> > >> > hardware is determined based on whether DT/ACPI provides a memory
> > >> > mapped phys base address for GIC virtual CPU interface register(GI=
CV).
> > >> > This creates a problem that a Qemu guest boot with default GIC(GIC=
v2)
> > >>
> > >> That'd be true of *any* guest using GICv2, not just when using QEMU =
as
> > >> the VMM, right?
> > >
> > > Yes, I would think so.
> > >
> > >> > hangs when firmware falsely reports this address on systems that d=
on't
> > >> > have support for legacy mode.
> > >>
> > >> And I guess it isn't just the guest that hangs, but the whole system
> > >> can
> > >> go south (it would be totally legitimate for the HW to deliver a
> > >> SError).
> > >
> > > So far I haven=E2=80=99t seen that happening. I was able to kill the =
Guest and
> > > recover.
> > > But the annoying thing is Guest boot hangs at random places without a=
ny
> > > error reported and people end up spending lot of time only to be told
> > > later
> > > that gic-version=3D3 is missing from their scripts.
> >
> > That's pretty lucky. The guest has been reading/writing to random
> > places,
> > and depending on where this maps in the physical space, anything can
> > happen. Out  of (morbid) curiosity, what is at the address pointed to b=
y
> > GICC in MADT?
>
> This is what it reports,
>
> [02Ch 0044   1]                Subtable Type : 0B [Generic Interrupt Cont=
roller]
> [02Dh 0045   1]                       Length : 50
> ...
> [04Ch 0076   8]                 Base Address : 000000009B000000
> [054h 0084   8]     Virtual GIC Base Address : 000000009B020000
> [05Ch 0092   8]  Hypervisor GIC Base Address : 000000009B010000
> [064h 0100   4]        Virtual GIC Interrupt : 00000019
> [068h 0104   8]   Redistributor Base Address : 00000000AE100000
> [070h 0112   8]                    ARM MPIDR : 0000000000080000
> [078h 0120   1]             Efficiency Class : 15
> [079h 0121   3]                     Reserved : 001500
>
> > >
> > >> > As per GICv3/v4 spec, in an implementation that does not support l=
egacy
> > >> > operation, affinity routing and system register access are permane=
ntly
> > >> > enabled. This means that the associated control bits are RAO/WI. H=
ence
> > >> > use the ICC_SRE_EL1.SRE bit to decide whether hardware supports
> > GICv2
> > >> > mode in addition to the above firmware based check.
> > >> >
> > >> > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com>
> > >> > ---
> > >> > On Hisilicon D06, UEFI sets the GIC MADT GICC gicv_base_address bu=
t
> > the
> > >> > GIC implementation on these boards doesn't have the GICv2 legacy
> > >> > support.
> > >> > This results in, Guest boot hang when Qemu uses the default GIC op=
tion.
> > >>
> > >> What a bore. Is this glorious firmware really out in the wild?
> > >
> > > :(. I am afraid it is.
> >
> > Meh. We'll have to paper over it then. How urgent is that?
>
> It is not that urgent urgent but 5.10 support would be nice :)
>
> >
> > [...]
> >
> > >> How about this instead? Completely untested, of course.
> > >
> > > Thanks for that. I just tested and it works.
> >
> > OK. I'll rework it a bit and post it as a complete patch. Is there an
> > erratum number on your side?
>
> Sure. I am not sure on erratum, but will check internally and get back to=
 you
> if there is one.
>

Any clue why production D06 firmware deviates from the D06 port that
exists in Tianocore's edk2-platforms repository? Because that version
does not have this bug, and I wonder why that code was upstreamed at
all if a substantially different version gets shipped with production
hardware.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79E12E25EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 11:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgLXKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 05:22:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgLXKWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 05:22:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2071B22519;
        Thu, 24 Dec 2020 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608805284;
        bh=I33uQjxOKsk96vt/qhhpGWyJa4Vo067StFJz0JDi7cA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nbQ2SLPEgksrmPECD4lKg3ZTu9M86+a1qfch3TzvQ5lxfklQCgLWw7oBJ3qXUXFst
         LlV6/Pg99GD4CLr3eCom4A0UZ35bESy3R9QW7l0z/t2OomcYcK0m144aRCKAWCYt35
         3mWwVch5JY4aOklyWCcA1CxkPsewjnuFU9iD6DEWI9yRkYgoAbd/UiVQF74As4Q5yO
         wLNlr/I7QKsf6cAbNc2zHkzuc7+CqTe2n1g1AqxqMZdoGhCeByX95iTYvawx3S97ij
         CY1BTVzLikJjPkMJa6OkZPTHJ0ofswaNudLrUscDVHt0uZ2K/XkpgyONSQBzZ8+iPs
         ZxwErEXxb9cIg==
Received: by mail-ej1-f46.google.com with SMTP id q22so2816148eja.2;
        Thu, 24 Dec 2020 02:21:24 -0800 (PST)
X-Gm-Message-State: AOAM532PYlXrCN8SqdIEVLYZpe2aSUwucEVGmrXZkSjnd/1QkGgmuF/4
        P93LlUrmp68S/P7NtwX6eiGPlPf9WfRawGEPo84=
X-Google-Smtp-Source: ABdhPJxn/eujA/vCO7qemjJmrEXH60VMF77ZxN5YQE3KmMQ9cj+NF4GsKdSw8dm+kiOuaydEfmlI1DCkymbkLZfT+SY=
X-Received: by 2002:a17:906:8587:: with SMTP id v7mr26874916ejx.381.1608805282619;
 Thu, 24 Dec 2020 02:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-5-jagan@amarulasolutions.com> <20201223115933.GC21091@kozik-lap>
 <CAMty3ZA0zrHS_wVKm8gdqU1q5ONokoT7aG_MBcWtXTJK59Bozg@mail.gmail.com>
 <CAJKOXPfNP+6uv6PXmyTCimRd1hrQUbosnY--55yUQh4G4jfZWw@mail.gmail.com> <CAMty3ZBWteW2OZMNwFT5hSRegy-AARqqkR7SAz53fDoM3j5Ong@mail.gmail.com>
In-Reply-To: <CAMty3ZBWteW2OZMNwFT5hSRegy-AARqqkR7SAz53fDoM3j5Ong@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 24 Dec 2020 11:21:10 +0100
X-Gmail-Original-Message-ID: <CAJKOXPey8+k7_uT4LLTwo8-UY51+TwUgWhtkPDRW3AD-BCi1Bw@mail.gmail.com>
Message-ID: <CAJKOXPey8+k7_uT4LLTwo8-UY51+TwUgWhtkPDRW3AD-BCi1Bw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Dec 2020 at 11:08, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Thu, Dec 24, 2020 at 2:48 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, 23 Dec 2020 at 13:07, Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Wed, Dec 23, 2020 at 5:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > On Wed, Dec 23, 2020 at 04:33:41PM +0530, Jagan Teki wrote:
> > > > > Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> > > > > board.
> > > > >
> > > > > Genaral features:
> > > > > - Ethernet 10/100
> > > > > - Wifi/BT
> > > > > - USB Type A/OTG
> > > > > - Audio Out
> > > > > - CAN
> > > > > - LVDS panel connector
> > > > >
> > > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > > >
> > > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > > >
> > > > > Add support for it.
> > > > >
> > > > > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > > Changes for v3:
> > > > > - don't maintain common nodes and include it, if no feature diff
> > > > > Changes for v2:
> > > > > - enabled fec1 node
> > > > > - updated commit message
> > > > > - dropped engicam from filename since it aligned with imx6 engicam
> > > > >   dts files naming conventions.
> > > > > - add i2c nodes
> > > > > - fixed v1 comments
> > > > >
> > > > >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> > > > >  .../dts/freescale/imx8mm-engicam-ctouch2.dtsi | 82 +++++++++++++++++++
> > > > >  .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
> > > > >  3 files changed, 104 insertions(+)
> > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> > > >
> > > > You split some common part to ctouch2.dtsi so it can be reused in
> > > > multiple places. I saw so far only one usage, where are the others?
> > >
> > > To be clear, ctouch2.dtsi not mean for common it is C.TOUCH2 carrier
> > > board dtsi. The other carrier is C.TOUCH2 10.1" Open Frame(display),
> > > since DSI is not yet mainlined, I didn't add this yet.
> >
> > If I understand correctly: it is a DTSI which is included only by one
> > DTS... and DTS does not have any other nodes. This as well is not the
>
> This is not mandatory as per my understanding, including exiting DTS
> topologies in Mainline.
>
> There are several places where more than one dtsi has been included,
> Simple example of imx8mm tree is

It's not the problem of including more than one DTSI. It's the problem
of creating fake DTS or DTSI files whose purpose is only to include
others. Keep it simple. Don't create unnecessary files. "Entities
should not be multiplied without necessity."

>
> arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts

Which was wrong as well. Don't create unnecessary files.

>
> /dts-v1/;
>
> #include "imx8mm.dtsi"
> #include "imx8mm-beacon-som.dtsi"
> #include "imx8mm-beacon-baseboard.dtsi"
>
> (SoC dtsi, SoM dtsi, Carrier board dtsi)
>
> > design which makes any sense. We do not create empty DTS files which
> > only include one more DTSI. The contents of
> > imx8mm-engicam-ctouch2.dtsi should be directly in
> > imx8mm-icore-mx8mm-ctouch2.dts. That's the same problem as with v1 -
> > you overcomplicate simple stuff. It really looks like you ignored the
> > comments from v1 in multiple places.
>
> As explained above, the design is pretty much the same as the existing SoM's.
>
> imx8mm-engicam-ctouch2.dtsi is not just a dtsi file where nodes are
> enabled. It has nodes enabled for Carrier board, so keeping nodes
> separately will

The files represent real devices or their components. So you have a
SOM - a DTSI file. You have a carrier board - a DTS file. That's
simple design which is mostly followed, unless something over
complicated passes the review.

> 1. More verbose for which IP's are available in the carrier board

No difference when carrier DTSI is the DTS. Exactly the same.

> 2. Easy to extend if someone can create another SoM with a similar Carrier.

Not really, if they include carrier DTSI they need to override a lot.
So usually (including practice - I did it) they *copy* the carrier to
create their own design.

>
> Ie is the whole idea to keep carrier board dtsi and includes them in dts.
>
> As I suggest, if you can look into px30 you can understand more easily.

NAK from my side. I explained my reasoning. You created a fake, empty
DTSI which included only other DTSI. After review, you agreed to fix
it. However you still create a fake DTS which includes only a DTSI.

"Entities should not be multiplied without necessity."

Best regards,
Krzysztof

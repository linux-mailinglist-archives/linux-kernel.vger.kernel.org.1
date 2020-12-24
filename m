Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75E2E259E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 10:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgLXJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 04:19:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgLXJTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 04:19:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A85112225E;
        Thu, 24 Dec 2020 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608801530;
        bh=GrZBQnU+qs+9KKvyhKv76m1eyHbFM5iOSlMTcbWXJOg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kAil0DY9Y5UR2hbGOAzuVrsZ85YxbruYDSjFTS2Q8meg4HytCM+razeOZv6Z/Ps7y
         9Vtlm13EkiAIDWTr6sX8daOG9a6sevttfAt0Gzi9KymKL7NeW5DXHGtFNalInm5iB6
         ONpxaQyu8RcszuRJ7dEuJPOm7roKtHmk+Mj0squPGF5K1b37LbcR8sHZaFadnmNtmk
         N5jd01k73qZfZkaRm45FQjNRht4NqsZv6xeL8DApVrmOpthH5sVyTk5kOnIhIkkoiH
         MkAds58gSi2hlp9CSqYm2VdKFUdMGXOXk0ArVtvqiSRczI7cYlsNO/LQ+XjZrti0tv
         MlhEDRJyNQB3g==
Received: by mail-ej1-f45.google.com with SMTP id g20so2642371ejb.1;
        Thu, 24 Dec 2020 01:18:49 -0800 (PST)
X-Gm-Message-State: AOAM531T5b4LVOCgsVAY2I9RHCyzcj0pyiPFooahYmepe5BpHCqHpoG3
        oVX0FxdUbylQkwEJEXuD4+g0PGgVaoJTls/fDuA=
X-Google-Smtp-Source: ABdhPJwAQg0S1MOOurh2CiV95fqh0bRtne1MLee1I3LcHv9JUaRf2XvE22Hb8eMqRu8k7od2nyrVM5xGqeeG4XPfAhk=
X-Received: by 2002:a17:906:158c:: with SMTP id k12mr9315554ejd.119.1608801528194;
 Thu, 24 Dec 2020 01:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-5-jagan@amarulasolutions.com> <20201223115933.GC21091@kozik-lap>
 <CAMty3ZA0zrHS_wVKm8gdqU1q5ONokoT7aG_MBcWtXTJK59Bozg@mail.gmail.com>
In-Reply-To: <CAMty3ZA0zrHS_wVKm8gdqU1q5ONokoT7aG_MBcWtXTJK59Bozg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 24 Dec 2020 10:18:36 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfNP+6uv6PXmyTCimRd1hrQUbosnY--55yUQh4G4jfZWw@mail.gmail.com>
Message-ID: <CAJKOXPfNP+6uv6PXmyTCimRd1hrQUbosnY--55yUQh4G4jfZWw@mail.gmail.com>
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

On Wed, 23 Dec 2020 at 13:07, Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Wed, Dec 23, 2020 at 5:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Wed, Dec 23, 2020 at 04:33:41PM +0530, Jagan Teki wrote:
> > > Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> > > board.
> > >
> > > Genaral features:
> > > - Ethernet 10/100
> > > - Wifi/BT
> > > - USB Type A/OTG
> > > - Audio Out
> > > - CAN
> > > - LVDS panel connector
> > >
> > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > >
> > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > >
> > > Add support for it.
> > >
> > > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - don't maintain common nodes and include it, if no feature diff
> > > Changes for v2:
> > > - enabled fec1 node
> > > - updated commit message
> > > - dropped engicam from filename since it aligned with imx6 engicam
> > >   dts files naming conventions.
> > > - add i2c nodes
> > > - fixed v1 comments
> > >
> > >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> > >  .../dts/freescale/imx8mm-engicam-ctouch2.dtsi | 82 +++++++++++++++++++
> > >  .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
> > >  3 files changed, 104 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> >
> > You split some common part to ctouch2.dtsi so it can be reused in
> > multiple places. I saw so far only one usage, where are the others?
>
> To be clear, ctouch2.dtsi not mean for common it is C.TOUCH2 carrier
> board dtsi. The other carrier is C.TOUCH2 10.1" Open Frame(display),
> since DSI is not yet mainlined, I didn't add this yet.

If I understand correctly: it is a DTSI which is included only by one
DTS... and DTS does not have any other nodes. This as well is not the
design which makes any sense. We do not create empty DTS files which
only include one more DTSI. The contents of
imx8mm-engicam-ctouch2.dtsi should be directly in
imx8mm-icore-mx8mm-ctouch2.dts. That's the same problem as with v1 -
you overcomplicate simple stuff. It really looks like you ignored the
comments from v1 in multiple places.

The same applies to imx8mm-engicam-edimm2.2.dtsi.

Best regards,
Krzysztof

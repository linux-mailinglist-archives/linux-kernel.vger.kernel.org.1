Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FB2E3504
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 09:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgL1IVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 03:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgL1IVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 03:21:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B2CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 00:21:08 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lt17so13235512ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 00:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEqUsm2Ug03agSnR9VCC2DGwWqGxQTTzvFac2nF2ZaQ=;
        b=LAFOX54FlmvMu9abO6JG9xu7ZOXFYk8MGfcQFnG6LT38pljFcanAz3pYMSFYmMrTur
         bXTY4C3hD69mZvJFTeriarybKN5qd0vBoKKYaZRHd+m7dTlVWLYxuh3+Nm/OxtsSyBi3
         GO2HLzt0pC4SQvszlBjTvdNviYhZuqJFstV9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEqUsm2Ug03agSnR9VCC2DGwWqGxQTTzvFac2nF2ZaQ=;
        b=hcuNdDFeicFdF9xliO0PdRLUTutyh+73yg48BvTOco+Wl1GGDL68BM5KfZpbNE1hwQ
         xBWG7qi/3HO0W7ilRBZPZziextWs+hqeVYlCIVYYISVaXcG2p3EZ0eyvpIVCWeTmEACJ
         E8FEWKHZOX54y0lV+64wXDBjXFP8M6PNGtUdelWt3926n277QTH2dDtqab6BPza1883R
         tkLmXC4IYHYQfhYOr/mSImTHROLioY2Bm/KrLSa9CBY5TIKfU5coRrRe9cYFUHdr8ZDR
         S3HIc7imbVYJbSFsJlA65+tChSo/rc8/ERFR0oJB0PaemqUn02lz3EPprO2O0fUmXXIc
         0M0A==
X-Gm-Message-State: AOAM5305aN+3SjvhYz/9PjJePL0HCrf0TtuYKwvBGhn1ehLYBYzOim0g
        QNaoZaLlL+PblH+TuGOFCk8MHnf2Rrf/OOw3T3rkCQ==
X-Google-Smtp-Source: ABdhPJythkg1EI2s5XzfBo8zJ1GXIzRnE/3Dq2ib1E07cyfneEu4T/68QmpJvbu2PUWw7r9XXxk1HkHs+SPlrG0Gv0c=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr41082373ejc.418.1609143666663;
 Mon, 28 Dec 2020 00:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-5-jagan@amarulasolutions.com> <20201223115933.GC21091@kozik-lap>
 <CAMty3ZA0zrHS_wVKm8gdqU1q5ONokoT7aG_MBcWtXTJK59Bozg@mail.gmail.com>
 <CAJKOXPfNP+6uv6PXmyTCimRd1hrQUbosnY--55yUQh4G4jfZWw@mail.gmail.com>
 <CAMty3ZBWteW2OZMNwFT5hSRegy-AARqqkR7SAz53fDoM3j5Ong@mail.gmail.com> <CAJKOXPey8+k7_uT4LLTwo8-UY51+TwUgWhtkPDRW3AD-BCi1Bw@mail.gmail.com>
In-Reply-To: <CAJKOXPey8+k7_uT4LLTwo8-UY51+TwUgWhtkPDRW3AD-BCi1Bw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 28 Dec 2020 13:50:54 +0530
Message-ID: <CAMty3ZAo+9L4rtkJgBkimJu4SPv=gycVUFaUYtL_RSAhs7yGWw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

On Thu, Dec 24, 2020 at 3:51 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 24 Dec 2020 at 11:08, Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Thu, Dec 24, 2020 at 2:48 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Wed, 23 Dec 2020 at 13:07, Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > On Wed, Dec 23, 2020 at 5:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >
> > > > > On Wed, Dec 23, 2020 at 04:33:41PM +0530, Jagan Teki wrote:
> > > > > > Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> > > > > > board.
> > > > > >
> > > > > > Genaral features:
> > > > > > - Ethernet 10/100
> > > > > > - Wifi/BT
> > > > > > - USB Type A/OTG
> > > > > > - Audio Out
> > > > > > - CAN
> > > > > > - LVDS panel connector
> > > > > >
> > > > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > > > >
> > > > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > > > >
> > > > > > Add support for it.
> > > > > >
> > > > > > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > > Changes for v3:
> > > > > > - don't maintain common nodes and include it, if no feature diff
> > > > > > Changes for v2:
> > > > > > - enabled fec1 node
> > > > > > - updated commit message
> > > > > > - dropped engicam from filename since it aligned with imx6 engicam
> > > > > >   dts files naming conventions.
> > > > > > - add i2c nodes
> > > > > > - fixed v1 comments
> > > > > >
> > > > > >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> > > > > >  .../dts/freescale/imx8mm-engicam-ctouch2.dtsi | 82 +++++++++++++++++++
> > > > > >  .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
> > > > > >  3 files changed, 104 insertions(+)
> > > > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> > > > >
> > > > > You split some common part to ctouch2.dtsi so it can be reused in
> > > > > multiple places. I saw so far only one usage, where are the others?
> > > >
> > > > To be clear, ctouch2.dtsi not mean for common it is C.TOUCH2 carrier
> > > > board dtsi. The other carrier is C.TOUCH2 10.1" Open Frame(display),
> > > > since DSI is not yet mainlined, I didn't add this yet.
> > >
> > > If I understand correctly: it is a DTSI which is included only by one
> > > DTS... and DTS does not have any other nodes. This as well is not the
> >
> > This is not mandatory as per my understanding, including exiting DTS
> > topologies in Mainline.
> >
> > There are several places where more than one dtsi has been included,
> > Simple example of imx8mm tree is
>
> It's not the problem of including more than one DTSI. It's the problem
> of creating fake DTS or DTSI files whose purpose is only to include
> others. Keep it simple. Don't create unnecessary files. "Entities
> should not be multiplied without necessity."
>
> >
> > arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
>
> Which was wrong as well. Don't create unnecessary files.
>
> >
> > /dts-v1/;
> >
> > #include "imx8mm.dtsi"
> > #include "imx8mm-beacon-som.dtsi"
> > #include "imx8mm-beacon-baseboard.dtsi"
> >
> > (SoC dtsi, SoM dtsi, Carrier board dtsi)
> >
> > > design which makes any sense. We do not create empty DTS files which
> > > only include one more DTSI. The contents of
> > > imx8mm-engicam-ctouch2.dtsi should be directly in
> > > imx8mm-icore-mx8mm-ctouch2.dts. That's the same problem as with v1 -
> > > you overcomplicate simple stuff. It really looks like you ignored the
> > > comments from v1 in multiple places.
> >
> > As explained above, the design is pretty much the same as the existing SoM's.
> >
> > imx8mm-engicam-ctouch2.dtsi is not just a dtsi file where nodes are
> > enabled. It has nodes enabled for Carrier board, so keeping nodes
> > separately will
>
> The files represent real devices or their components. So you have a
> SOM - a DTSI file. You have a carrier board - a DTS file. That's
> simple design which is mostly followed, unless something over
> complicated passes the review.
>
> > 1. More verbose for which IP's are available in the carrier board
>
> No difference when carrier DTSI is the DTS. Exactly the same.
>
> > 2. Easy to extend if someone can create another SoM with a similar Carrier.
>
> Not really, if they include carrier DTSI they need to override a lot.
> So usually (including practice - I did it) they *copy* the carrier to
> create their own design.

But what if the new board has slite change to use exiting carrier like
what ctouch2 10" OF. Can we add ctouch2 dtsi as a separate file for
this case?

>
> >
> > Ie is the whole idea to keep carrier board dtsi and includes them in dts.
> >
> > As I suggest, if you can look into px30 you can understand more easily.
>
> NAK from my side. I explained my reasoning. You created a fake, empty
> DTSI which included only other DTSI. After review, you agreed to fix
> it. However you still create a fake DTS which includes only a DTSI.

Not sure. I have updated the series according to comments by dropping
-common.dtsi ie what I was thought of  "empty DTSI inclusion" you have
pointed at previous versions.

Jagan.

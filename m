Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCBB2E25DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 11:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgLXKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 05:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgLXKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 05:08:51 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339CC061794
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 02:08:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ce23so2729700ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUizvoQj8b1rj8eTw88nSgPpWqjjl7qGR7r5xpNtn3k=;
        b=Ir4KT9FufwKLEeD68mTzD0wSzo6rco5sEsovSdtDLTFghK5msBi0TiBxBKnfYoHcjM
         fDtP4rW3KdtNMsam1DejD6vsEv1tXwoJ0VeANDQ+jBSisqGW3f7Lqh3gRRIWRGOkzW6u
         EQRWVxL9IzSmAc79Fan4zZNonXBp2ObK7YT1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUizvoQj8b1rj8eTw88nSgPpWqjjl7qGR7r5xpNtn3k=;
        b=DxIBp8TSZmj1TM/aQMWqG7eSbU9Xt429rrtZwpdIZpjMhfeGdhv2Zb2zAtWI9m1mYK
         X9qIx9WXuEn/Em3RK4Zpe5R+rVuAoVi+be/Gs8fUE14IxowkOwASZfW8rNgMsOacMt6f
         jedAKvvUnPI3NB65fGx6IO1i3r4tfoMovp1VDev6j79XU3Z23EvdbPZl8mMYuJsXID23
         aUnmrqr6kzKNsoARrAzB4ylR+ShrkicTKk+kSuft7dClGaeMYWIqCwgjo7RHD55IsMme
         WD4XVsnlI40Sdr+QHYZbI5idHAlk3wfwdQZdN1uWPbhHn1X7HRF22U4hncS7QH6EHdlR
         b7bA==
X-Gm-Message-State: AOAM532fPy8obTw6BjVOicNpckNTOTYJKa/yHwMsTLuYjKXcS3Dr1XQ/
        jVqmci5M8C9rRAjjDQTDDsxmdI10+qSqyQtz8SgvHg==
X-Google-Smtp-Source: ABdhPJzxoFux0eWRsIJGJjMhK9lodOaJrVTo4LBYmkCrqmsjYET9GZqZZH+jEwe3Xdh+R5d0ESpBY055rHVlYaLuKwQ=
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr28094367ejf.295.1608804489815;
 Thu, 24 Dec 2020 02:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-5-jagan@amarulasolutions.com> <20201223115933.GC21091@kozik-lap>
 <CAMty3ZA0zrHS_wVKm8gdqU1q5ONokoT7aG_MBcWtXTJK59Bozg@mail.gmail.com> <CAJKOXPfNP+6uv6PXmyTCimRd1hrQUbosnY--55yUQh4G4jfZWw@mail.gmail.com>
In-Reply-To: <CAJKOXPfNP+6uv6PXmyTCimRd1hrQUbosnY--55yUQh4G4jfZWw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 24 Dec 2020 15:37:58 +0530
Message-ID: <CAMty3ZBWteW2OZMNwFT5hSRegy-AARqqkR7SAz53fDoM3j5Ong@mail.gmail.com>
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

On Thu, Dec 24, 2020 at 2:48 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 23 Dec 2020 at 13:07, Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Wed, Dec 23, 2020 at 5:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Wed, Dec 23, 2020 at 04:33:41PM +0530, Jagan Teki wrote:
> > > > Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> > > > board.
> > > >
> > > > Genaral features:
> > > > - Ethernet 10/100
> > > > - Wifi/BT
> > > > - USB Type A/OTG
> > > > - Audio Out
> > > > - CAN
> > > > - LVDS panel connector
> > > >
> > > > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> > > >
> > > > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > > > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> > > >
> > > > Add support for it.
> > > >
> > > > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v3:
> > > > - don't maintain common nodes and include it, if no feature diff
> > > > Changes for v2:
> > > > - enabled fec1 node
> > > > - updated commit message
> > > > - dropped engicam from filename since it aligned with imx6 engicam
> > > >   dts files naming conventions.
> > > > - add i2c nodes
> > > > - fixed v1 comments
> > > >
> > > >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> > > >  .../dts/freescale/imx8mm-engicam-ctouch2.dtsi | 82 +++++++++++++++++++
> > > >  .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
> > > >  3 files changed, 104 insertions(+)
> > > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
> > >
> > > You split some common part to ctouch2.dtsi so it can be reused in
> > > multiple places. I saw so far only one usage, where are the others?
> >
> > To be clear, ctouch2.dtsi not mean for common it is C.TOUCH2 carrier
> > board dtsi. The other carrier is C.TOUCH2 10.1" Open Frame(display),
> > since DSI is not yet mainlined, I didn't add this yet.
>
> If I understand correctly: it is a DTSI which is included only by one
> DTS... and DTS does not have any other nodes. This as well is not the

This is not mandatory as per my understanding, including exiting DTS
topologies in Mainline.

There are several places where more than one dtsi has been included,
Simple example of imx8mm tree is

arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts

/dts-v1/;

#include "imx8mm.dtsi"
#include "imx8mm-beacon-som.dtsi"
#include "imx8mm-beacon-baseboard.dtsi"

(SoC dtsi, SoM dtsi, Carrier board dtsi)

> design which makes any sense. We do not create empty DTS files which
> only include one more DTSI. The contents of
> imx8mm-engicam-ctouch2.dtsi should be directly in
> imx8mm-icore-mx8mm-ctouch2.dts. That's the same problem as with v1 -
> you overcomplicate simple stuff. It really looks like you ignored the
> comments from v1 in multiple places.

As explained above, the design is pretty much the same as the existing SoM's.

imx8mm-engicam-ctouch2.dtsi is not just a dtsi file where nodes are
enabled. It has nodes enabled for Carrier board, so keeping nodes
separately will

1. More verbose for which IP's are available in the carrier board
2. Easy to extend if someone can create another SoM with a similar Carrier.

Ie is the whole idea to keep carrier board dtsi and includes them in dts.

As I suggest, if you can look into px30 you can understand more easily.

Jagan.

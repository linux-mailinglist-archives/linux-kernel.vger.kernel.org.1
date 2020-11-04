Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BBF2A6FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgKDVzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:55:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45790 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgKDVzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:55:23 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kaQkK-0004Zn-T8; Wed, 04 Nov 2020 22:55:12 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v4 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
Date:   Wed, 04 Nov 2020 22:55:10 +0100
Message-ID: <3599415.KCJOEREoO8@diego>
In-Reply-To: <CAMty3ZCib5TiQdzU95WS1Xiq1tAQ7FHEQcbf5JhUZYYvofb_MQ@mail.gmail.com>
References: <20200929083217.25406-1-jagan@amarulasolutions.com> <CAMty3ZDHDC5TMF=8HJRmZd7HijOM6RP-k4y9JkdWVQGgPKyGvg@mail.gmail.com> <CAMty3ZCib5TiQdzU95WS1Xiq1tAQ7FHEQcbf5JhUZYYvofb_MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. November 2020, 20:54:40 CET schrieb Jagan Teki:
> On Thu, Oct 22, 2020 at 12:27 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Heiko,
> >
> > On Tue, Sep 29, 2020 at 2:02 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> > >
> > > PX30.Core needs to mount on top of Engicam baseboards for creating
> > > complete platform boards.
> > >
> > > Possible baseboards are,
> > > - EDIMM2.2 Starter Kit
> > > - C.TOUCH 2.0 Carrier Board
> > >
> > > Changes for v4:
> > > - collect Rob A-b
> > > Changes for v3:
> > > - resolved Johan comments about sorting node properties
> > > - add copyright to Amarula Solutions
> > > - update px30 dtsi author
> > > Changes for v2:
> > > - include C.TOUCH 2.0 carrier board
> > > - skip 10" OF LCD as it requires separate dts with panel support.
> > >
> > > Note: These baseboards can be used for i.MX8 SOM's as well. So having
> > > baseboard on respective SoC seems to be easy rather than making it
> > > common across all.
> > >
> > > Any inputs?
> > > Jagan.
> > >
> > > Jagan Teki (6):
> > >   dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
> > >   arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
> > >   arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
> > >   dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
> > >   arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
> > >   arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
> > >
> > > Michael Trimarchi (1):
> > >   arm64: dts: rockchip: Add Engicam PX30.Core SOM
> > >
> > >  .../devicetree/bindings/arm/rockchip.yaml     |  12 +
> > >  arch/arm64/boot/dts/rockchip/Makefile         |   2 +
> > >  .../dts/rockchip/px30-engicam-common.dtsi     |  39 +++
> > >  .../dts/rockchip/px30-engicam-ctouch2.dtsi    |   8 +
> > >  .../dts/rockchip/px30-engicam-edimm2.2.dtsi   |   7 +
> > >  .../dts/rockchip/px30-px30-core-ctouch2.dts   |  22 ++
> > >  .../dts/rockchip/px30-px30-core-edimm2.2.dts  |  21 ++
> > >  .../boot/dts/rockchip/px30-px30-core.dtsi     | 232 ++++++++++++++++++
> > >  8 files changed, 343 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-common.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-ctouch2.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-engicam-edimm2.2.dtsi
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-ctouch2.dts
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core-edimm2.2.dts
> > >  create mode 100644 arch/arm64/boot/dts/rockchip/px30-px30-core.dtsi
> >
> > Any further comments?
> 
> Gentle ping.

on my list to untangle :-)


Heiko




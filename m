Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3502F0D87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbhAKHvV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Jan 2021 02:51:21 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46496 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbhAKHvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:51:21 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyryE-0004Eb-3j; Mon, 11 Jan 2021 08:50:34 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E
Date:   Mon, 11 Jan 2021 08:50:33 +0100
Message-ID: <2633022.BEx9A2HvPv@diego>
In-Reply-To: <CAGb2v67h3v4DdEY68BmHy263=L1tB0DuJnf_exHrLi57SiRjUA@mail.gmail.com>
References: <20210110035846.9155-1-wens@kernel.org> <2241380.NG923GbCHz@diego> <CAGb2v67h3v4DdEY68BmHy263=L1tB0DuJnf_exHrLi57SiRjUA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. Januar 2021, 04:27:47 CET schrieb Chen-Yu Tsai:
> On Mon, Jan 11, 2021 at 4:06 AM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi,
> >
> > Am Sonntag, 10. Januar 2021, 16:37:15 CET schrieb Chen-Yu Tsai:
> > > > > +     vcc_sd: sdmmc-regulator {
> > > > > +             compatible = "regulator-fixed";
> > > > > +             gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> > > > > +             pinctrl-names = "default";
> > > > > +             pinctrl-0 = <&sdmmc0m1_pin>;
> > > >
> > > > > +             regulator-boot-on;
> > > > > +             regulator-name = "vcc_sd";
> > > >
> > > > regulator-name above other regulator properties
> > >
> > > That is actually what I was used to, but some other rockchip dts files
> > > have all the properties sorted alphabetically. So I stuck with what I
> > > saw.
> >
> > I try to keep it alphabetical except for the exceptions :-D .
> >
> > regulator-name is such an exception. Similar to compatibles, the
> > regulator-name is an entry needed to see if you're at the right node,
> > so I really like it being the topmost regulator-foo property - just makes
> > reading easier.
> >
> > (same for the compatible first, then regs, interrupts parts, as well
> > as "status-last")
> >
> > But oftentimes, I just fix the ordering when applying - but seem to have
> > missed this somewhere in those "other Rockchip dts files" ;-) .
> 
> I was slightly confused. I looked again and yes regulator-name is always the
> first regulator related property. What's off is that in some cases min/max
> voltage comes before always-on/boot-on, and in others vice versa.
> 
> For example in the Rock64 and ROC-RK3328-CC device trees, in the fixed
> regulators, always-on/boot-on come before min/max voltage, while in the
> PMIC the other order is used.

That's likely undecidednes on my part ;-)

There could be an argument for a "name, voltages, flags" sorting, but on
the other hand just keeping it alphabetical with the naming on top
creates less special cases.


Heiko



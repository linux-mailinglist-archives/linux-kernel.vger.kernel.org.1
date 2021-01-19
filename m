Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9892FB4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 10:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbhASJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbhASJER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:04:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9743423103;
        Tue, 19 Jan 2021 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611047017;
        bh=agtIFYNs3lDgHvE0kjTIVWnuYq7hAEIToBhzatiNOvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2trKYpn8FrJbfRhuWgpHTOgwZD7qeKPALdYYWDY7ccGcQX18mMa27bjGkw/4imBg
         r6fiEVXDoMm/iRR01ni1QotHdL+IUauEO+4GRFGOMKo/Dc0i51/2JiPank6AZrvCcL
         rna8Dv0CT0hPCa7BBwNSCVL1vieOlZ5/XAQLaKZw1YdeiCdlz30U/+M88ro+eYxCQp
         v8GLRCdDhv5YJRiWStaA6xQgnpTkb8ZryN7ySWmKNzmsWdKc4xNIEGJU0YM6nD+xEL
         TnKkZXCoyNobvzVfL6glLPh4UrLpW4bktNaZyXFQMR5Rv7h/AF5rUWR7amPd97Jhwt
         O6GOgY7eVKolQ==
Date:   Tue, 19 Jan 2021 17:03:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: fsl-ls1012a-rdb: add i2c devices
Message-ID: <20210119090330.GC4356@dragon>
References: <20210115101613.1490837-1-paweldembicki@gmail.com>
 <20210118073609.GQ28365@dragon>
 <CAJN1KkwW174XKn+covSgCHkzUbS40BqAzLBA5QMt4CD2v5CTYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkwW174XKn+covSgCHkzUbS40BqAzLBA5QMt4CD2v5CTYw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:08:11AM +0100, Paweł Dembicki wrote:
> On 18.01.2021 at 08:36 Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Fri, Jan 15, 2021 at 11:16:12AM +0100, Pawel Dembicki wrote:
> > > LS1012A-RDB equipped in some i2c devices:
> > >   - 3x GPIO Expander: PCAL9555A (NXP)
> > >   - Gyro: FXAS21002 (NXP)
> > >   - Accelerometer: FXOS8700 (NXP)
> > >   - Current & Power Monitor: INA220 (TI)
> > >
> > > This patch add listed devices to dts.
> > >
> > > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > > ---
> > >  .../boot/dts/freescale/fsl-ls1012a-rdb.dts    | 45 +++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> > > index d45c17620b98..12117a973eb6 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> > > @@ -7,6 +7,7 @@
> > >   */
> > >  /dts-v1/;
> > >
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > >  #include "fsl-ls1012a.dtsi"
> > >
> > >  / {
> > > @@ -33,6 +34,50 @@ &esdhc1 {
> > >
> > >  &i2c0 {
> > >       status = "okay";
> > > +
> > > +     accelerometer@1e {
> > > +             compatible = "nxp,fxos8700";
> > > +             reg = <0x1e>;
> > > +             interrupt-parent = <&gpio26>;
> > > +             interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> > > +             interrupt-names = "INT1";
> > > +     };
> > > +
> > > +     gyroscope@20 {
> >
> > Please sort these device node in unit-address.
> >
> > Shawn
> >
> 
> Could You give me more details please?  Devices are sorted by
> unit-address ascending.

Oops! I'm sorry.  It must be something went wrong with my eyes.

Shawn

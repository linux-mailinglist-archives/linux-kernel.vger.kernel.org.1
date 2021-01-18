Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F12FACA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394710AbhARV35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388783AbhARKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:10:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018BAC0613CF;
        Mon, 18 Jan 2021 02:08:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d26so15829865wrb.12;
        Mon, 18 Jan 2021 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9HMH7OjX32UDjIZ1ScqtRXZ/AeOtTDrruYTJffZFfw=;
        b=K1H3w+nz0d/y629bM3FnMaV1fCRexj0i7boqbOijslQ42dQLkXkq8z6CoqPcJU7e/C
         +r+wGJ82ZIIY0syMGEmwQ1FsI/tftqtKouXNBCJroHVthSxVMG3036g8c2RBVbSWRnwq
         4hsfGgNTWX2JjUYqQ6G8dXeBHsSK7q44TChJICw+2vFGxHouR9Us4F3EWZaibhZQaK5+
         sIr/2hFClD4pXgzvU2AsvKzuO+3eP0SBeiM70q2OaCPLgjLqiQSwMtsUUecjKdygOk/i
         QCtsBtfEAMtlZVaDtsCquSsBKLQI9jPAdnC9v0WzW6OnSOoovxtyqFAQKQHX/7EH3NwI
         O1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9HMH7OjX32UDjIZ1ScqtRXZ/AeOtTDrruYTJffZFfw=;
        b=nrCML32MR8b8aA2nIA/EYEC1HoUl/pfCdG3TO33UWGFwZG2CD3kucQ1pozUmjl+loK
         KcPwuXbQFnSqR2DfSoffYiZ59YAjv6v7YtZQ9NxUReLBQrMcu6W60Cb3soUWHkLTbZod
         OxhY4+WipWSwjw5GUwwDYQ6foI2/mQQasaBAOE4zSofyxKyYKdVXQMcw4XSTghZhdIfK
         AMPnqbPccpyI23fZGu6JQQ6X0+rFWmFfkP25mb1MMJ8qDEViNDGULGnwL/3t35837FIJ
         T2n85zn5zBsf3GrsCwKlctX+J/EnxmWIy6bP72lfQ+IVQFrszSXIDf3XJ9ccpubMNweQ
         pAIQ==
X-Gm-Message-State: AOAM533wbKQXj29sc8AQuh8FY9E/sFI8wMqVji5roEnizJLcSdM/aCCP
        LjTyhYBdN6XYHjiDisZYNdee9bBkpejL/jYYysk=
X-Google-Smtp-Source: ABdhPJwh60RO3HrJIFlPOjxPRfXbI0TO8SRi6ubiKx+2hcT8pWe4ffxyeV5a0P/vDVP4enx0qgNplTv23OUOm9ZChkA=
X-Received: by 2002:adf:e452:: with SMTP id t18mr24083339wrm.177.1610964502854;
 Mon, 18 Jan 2021 02:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20210115101613.1490837-1-paweldembicki@gmail.com> <20210118073609.GQ28365@dragon>
In-Reply-To: <20210118073609.GQ28365@dragon>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Mon, 18 Jan 2021 11:08:11 +0100
Message-ID: <CAJN1KkwW174XKn+covSgCHkzUbS40BqAzLBA5QMt4CD2v5CTYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: fsl-ls1012a-rdb: add i2c devices
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.2021 at 08:36 Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Jan 15, 2021 at 11:16:12AM +0100, Pawel Dembicki wrote:
> > LS1012A-RDB equipped in some i2c devices:
> >   - 3x GPIO Expander: PCAL9555A (NXP)
> >   - Gyro: FXAS21002 (NXP)
> >   - Accelerometer: FXOS8700 (NXP)
> >   - Current & Power Monitor: INA220 (TI)
> >
> > This patch add listed devices to dts.
> >
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> >  .../boot/dts/freescale/fsl-ls1012a-rdb.dts    | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> > index d45c17620b98..12117a973eb6 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts
> > @@ -7,6 +7,7 @@
> >   */
> >  /dts-v1/;
> >
> > +#include <dt-bindings/interrupt-controller/irq.h>
> >  #include "fsl-ls1012a.dtsi"
> >
> >  / {
> > @@ -33,6 +34,50 @@ &esdhc1 {
> >
> >  &i2c0 {
> >       status = "okay";
> > +
> > +     accelerometer@1e {
> > +             compatible = "nxp,fxos8700";
> > +             reg = <0x1e>;
> > +             interrupt-parent = <&gpio26>;
> > +             interrupts = <13 IRQ_TYPE_EDGE_RISING>;
> > +             interrupt-names = "INT1";
> > +     };
> > +
> > +     gyroscope@20 {
>
> Please sort these device node in unit-address.
>
> Shawn
>

Could You give me more details please?  Devices are sorted by
unit-address ascending.

Pawel

> > +             compatible = "nxp,fxas21002c";
> > +             reg = <0x20>;
> > +     };
> > +
> > +     gpio@24 {
> > +             compatible = "nxp,pcal9555a";
> > +             reg = <0x24>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +     };
> > +
> > +     gpio@25 {
> > +             compatible = "nxp,pcal9555a";
> > +             reg = <0x25>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +     };
> > +
> > +     gpio26: gpio@26 {
> > +             compatible = "nxp,pcal9555a";
> > +             reg = <0x26>;
> > +             interrupt-parent = <&gpio0>;
> > +             interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> > +             interrupt-controller;
> > +             #interrupt-cells = <2>;
> > +             gpio-controller;
> > +             #gpio-cells = <2>;
> > +     };
> > +
> > +     current-sensor@40 {
> > +             compatible = "ti,ina220";
> > +             reg = <0x40>;
> > +             shunt-resistor = <2000>;
> > +     };
> >  };
> >
> >  &qspi {
> > --
> > 2.25.1
> >

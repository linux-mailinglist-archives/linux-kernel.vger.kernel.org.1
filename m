Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9889E283EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgJESre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJESrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:47:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070CEC0613CE;
        Mon,  5 Oct 2020 11:47:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k6so10321971ior.2;
        Mon, 05 Oct 2020 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7YqpccAzej+b2o9pV1jLHqIPTc1Lt2s9q8QE3tuN/+k=;
        b=RxpOVSwA92ftH6anX1m0xntTLg7wgJLJhZKkvwCVzt6FfUfp2p7oR4481IM5i4Gv7h
         QRP5FYAl8B1OX2XfeMSGGco1arDbpAH8LFtSDgFGx9v9IAAZIP/6RlsNX/8h2eWt1u0q
         xEY6uHmB6h6e5qlNjGZqCWkr5qUqedLa6Hbbfx3TbKQVlSClrF2pdSn/jeK+J/hzeVnu
         eJu/4poF9V9UpwPg+vd7ZJhTsr3MCwLl5o2pkJG48blLnvQAe0gPkPZ2sQJn2HoQ4pFt
         4siEh+zrLg+J60wa0dlBXfzTthlLkQkoJyc97WoHKF0TDAlNdil/9789kkQzfyQII5ko
         48nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7YqpccAzej+b2o9pV1jLHqIPTc1Lt2s9q8QE3tuN/+k=;
        b=rOXTRB0VbIX5Y5W+eiItJ+WwkbgLS+ko1aWaNq/AfZgTcoChoUYxewLd7Dbg74wPcI
         wNkpG/GrfQHSxSzEDeMc03Xrlk7iEAVxStEV+RN3dIrZyQ962zhntngq83/BCg43dYmQ
         7cfxwy4GrnOaA7ZJMhKR5ajfkBy3iPIIxZ3ULlL3BWK795H7h4EWTvcLGEF4jBeKcYYi
         5yLIB9Ct723R7GzVUfHKek5l/9J3o3LG8brIYSO2D6r7yLb/qoV+/F964qTwg5wQ3Bv/
         Zctmb4yyq1GjQK1XZef1maxE3xZ12M1CB1pAIzxSrfoEGj7sFCxmGFjOTNZFPSoGZ39D
         CW3w==
X-Gm-Message-State: AOAM533ELbPauaPphq+uTIrI0S/chiF/8qwgSpSYxBmG4uI02Iw5gWWM
        c+EBl1JUU+Ji5ImTXCSo1gHsNQInvxPtwbYSCig=
X-Google-Smtp-Source: ABdhPJzQ1nxounHVLsdGpt/BvM5ERYe1427Wv3ndDU3Z74ZOZ/2XcDkuCjVlvPILBBV0tSx9TsZ3BmsqAi2J2Mmcrh4=
X-Received: by 2002:a05:6638:f8d:: with SMTP id h13mr1269158jal.120.1601923651211;
 Mon, 05 Oct 2020 11:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201003092001.405238-1-peron.clem@gmail.com> <20201005092145.wdu4m4pwxydv76ou@gilmour.lan>
In-Reply-To: <20201005092145.wdu4m4pwxydv76ou@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 5 Oct 2020 20:47:19 +0200
Message-ID: <CAJiuCcfydz4GS3fUTampBLkDC4f6xVWmRpSRJ55TiDStdRCFmA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: add eMMC voltage property
 for Beelink GS1
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,


On Mon, 5 Oct 2020 at 11:21, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Cl=C3=A9ment,
>
> On Sat, Oct 03, 2020 at 11:20:01AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Sunxi MMC driver can't distinguish at runtime what's the I/O voltage
> > for HS200 mode.
>
> Unfortunately, that's not true (or at least, that's not related to your p=
atch).
>
> > Add a property in the device-tree to notify MMC core about this
> > configuration.
> >
> > Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 =
board")
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > index 049c21718846..3f20d2c9bbbb 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > @@ -145,6 +145,7 @@ &mmc2 {
> >       vqmmc-supply =3D <&reg_bldo2>;
> >       non-removable;
> >       cap-mmc-hw-reset;
> > +     mmc-hs200-1_8v;
> >       bus-width =3D <8>;
> >       status =3D "okay";
> >  };
>
> I'm not really sure what you're trying to fix here, but as far as MMC
> goes, eMMC's can support io voltage of 3.3, 1.8 and 1.2V. Modes up until
> HS DDR (50MHz in DDR) will use an IO voltage of 3.3V, higher speed modes
> (HS200 and HS400) supporting 1.8V and 1.2V.

Some users report that the eMMC is not working properly on their
Beelink GS1 boards.

>
> The mmc-hs200-1_8v property states that the MMC controller supports the
> HS200 mode at 1.8V. Now, I can only assume that since BLDO2 is set up at
> 1.8V then otherwise, the MMC core will rightfully decide to use the
> highest supported mode. In this case, since the driver sets it, it would
> be HS-DDR at 3.3V, which won't work with that fixed regulator.
>
> I can only assume that enabling HS200 at 1.8V only fixes the issue you
> have because otherwise it would use HS-DDR at 3.3V, ie not actually
> fixing the issue but sweeping it under the rug.
>
> Trying to add mmc-ddr-1_8v would be a good idea

Thanks for the explanation, this is indeed the correct one.
So It looks like the SDIO controller has an issue on some boards when
using HS-DDR mode.

Is this patch acceptable with the proper commit log?

It looks like the same issue is happening on A64 Pinebook board.

Thanks
Clement


>
> Maxime

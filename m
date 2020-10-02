Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE402816D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbgJBPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387789AbgJBPkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:40:33 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E98C0613D0;
        Fri,  2 Oct 2020 08:40:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id o18so1651658ilg.0;
        Fri, 02 Oct 2020 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z4GmnqL+ap4HdUo7VaM2ph1Dt1KeNprTQUR8alGb9jk=;
        b=BB/LcTMwrAFBbWb648gD3v3aWW2gRywqJIvat2aCTNjboxCO68ejekhJksb9Ky0Yeh
         15PpanlKmNSMMPzGlFJ/tHmcYrQzA2j8vExKu5PGDvXGTXScgd10JRrZ3eUzXPCEA0KG
         Z5bCph4CY7pdBdvrmq51Ylrr9NxPWyQFUCdJIWsZ1GkCO/axjyhGLwI8Tv3+RpkjFedU
         EhydH2hOpjokA4FmECQI1knrxf0YJwsyUdiJnU0mMr7J2Uo6yF7FXb8z86DRmOKZXiCC
         n052v4TbQ5Q/ONurwBT1bTDtxoAYolmvTsWwDo9j9upZVURzR0j/VJ3VO+9K2K9x+e2I
         AY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z4GmnqL+ap4HdUo7VaM2ph1Dt1KeNprTQUR8alGb9jk=;
        b=pWDI1kJ0Ln32Nz6pnlrpiZPHLbHugcZkv/HwwoRM8a/Cqj7GzCKKujt76xshGstY5Y
         cLe5GefwbZFk1Ljdwl7gaAFT8tspeShLkG9kcZu+yR3ZlMq8p7YxTiuxKu/RvazD+fFO
         oFNy4Lfro/HX3YoCU4akcn4QadyYQPkOcaLSC7dsYTpr04dk1KK9XfR1xrk6zmcvwR25
         Gixg8s3MH5pYIy/ZQuKIqiULoGaTsZHJdoe/WtMy1GPcQtfg83hV5LKS8rh17V6CjGtq
         sin+tB2qiGVhSdux60K5THLjPYbdQL6S0GvizcYg3fUGnL4UHAd8P169kQEXrjsYo5/U
         J0Zw==
X-Gm-Message-State: AOAM530/ctv5m0uUPzQDxabCg/3ad8PzReUeWYNQwlTlkPxRBt6OJzhO
        zcCl5jJfTMJTDeuqLOWYHAtu3YDZCG+8/7We5m6jTcJzxjNp3Q==
X-Google-Smtp-Source: ABdhPJx6YOEHpzKpVtj2GKePkM1ooAA22I+RJWeZntl348bFsbQJS4w95GGsHmZATmirwtfXokeaC+znSg9qKl/IZWo=
X-Received: by 2002:a05:6e02:bc9:: with SMTP id c9mr2233146ilu.150.1601653232516;
 Fri, 02 Oct 2020 08:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200928150038.97413-1-peron.clem@gmail.com> <20200930102732.zc3vs4vzm3fyt5dc@gilmour.lan>
In-Reply-To: <20200930102732.zc3vs4vzm3fyt5dc@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 2 Oct 2020 17:40:20 +0200
Message-ID: <CAJiuCccgdG0MNi8-q1HCC=FiUKpNSv_HvdyS0jEzab5+b=Enqg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: h6: add eMMC voltage property for
 Beelink GS1
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

On Wed, 30 Sep 2020 at 12:27, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Mon, Sep 28, 2020 at 05:00:37PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > VQMMC supply is connected to BLDO2 which provides 1.8V.
> >
> > Let's reflect this in the device-tree.
>
> This commit log doesn't really explain what is going on though?
>
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
>
> The Device Tree already expresses that the vqmmc supply is connected to
> BLDO2 which provides 1.8V here (together with the reg_bldo2 node).
>
> >       non-removable;
> >       cap-mmc-hw-reset;
> > +     mmc-hs200-1_8v;
>
> Whereas this indicates that the eMMC supports the HS200 MMC mode at 1.8V

What about a comment like this:

Sunxi mmc driver can't distinguish at runtime what's the I/O voltage
for HS200 mode.
Add a property in the device-tree to notify mmc core about this configurati=
on.


Regards,
Clement

>
> Maxime

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE72C297E10
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764008AbgJXTKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763999AbgJXTKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:10:04 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE80C0613CE;
        Sat, 24 Oct 2020 12:10:04 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b15so5858952iod.13;
        Sat, 24 Oct 2020 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gp1soQJvXzJ2DnY++LW++xO0lp9c0KFybnwo2pz+9iE=;
        b=ibYA/HGfunxV+Sb/rn+/QQm2ivvxxMe5qo0SUw9HKL1pzgLmWRvRMCNiYAR+bkz/lX
         E30+M5tX8ec6F/cKjnchkuHzPON9n9uNhGXoftAT1X0Ciu4MQCpc2truFgaXlEqsjfFS
         w0XorHAHMriu4btQy5Sjw5MUP1GUvWZUe7JZH4kmE/OGuW4eLBeApczGuMMlh+KGqIoC
         tvL4kylDi746fV8pYGZqZki/07+ToSSwR5mudnPbeqsU6KnDPu3Okderi1ZmD8A08fmu
         ZLW65ODUFGD2YLgD57iUQX8IldfLsSWlfFvLd10fOPc6/5cKHw+pdfJQwdnSx8B4nc91
         iBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gp1soQJvXzJ2DnY++LW++xO0lp9c0KFybnwo2pz+9iE=;
        b=t35C4BrOaDBcKY6NwP/SLzihcWIwNPcbPoRs0gjDuf5HhCYuetlUe8ybS9ZbhR60WT
         941roMC88nkzPsvGeT05hQimlIYH1EU3YOBUIDLKcfKqxcKBhQ5LYGlXQK0rKPMucOCm
         yBlQnu5IJ7Ts0ioj5jB4i0QJrstx5Pv+EtZaQ9f0lUzlUS8ZkqGeo9e9KGQwZcg1B7hb
         ptayX6eh7x6j3wJuj0Cstw1EdsTlFkCKeLMrpPwqlwhDVWrQ3RjfDKsY50tUP2qRSZ7+
         WMxolMtdrAt/aDqLQ1i84VDNbW+eYlUucbXd561KVCQjqmWi0emWzLQxvd4DMQaOrKrG
         3qmw==
X-Gm-Message-State: AOAM533LvjUxtn5JGLeZxzXnyYBnBCnB4r2zG6TcH5G6bynKuk+1ovPB
        5YGxt78YJPm+M3jq0k6pbUS1ZGLY4ACUiFvPEslhTKegMWGMeg==
X-Google-Smtp-Source: ABdhPJy2rlMifMu2r/HqnyudFFPGkFdxjfXmRqmOVj7KtCeoHPz9S3WUuMWVzIUcYpxvkiksvO5wbGLcD5YJfRAifDM=
X-Received: by 2002:a6b:7907:: with SMTP id i7mr5671784iop.178.1603566603675;
 Sat, 24 Oct 2020 12:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-2-wens@kernel.org>
 <79894e1266db69e463ee74a52551101298cae03e.camel@aosc.io> <2859076.BEgH6Mo0Pn@jernej-laptop>
 <9D317C52-5F28-41A9-80DA-DBADA142B042@aosc.io>
In-Reply-To: <9D317C52-5F28-41A9-80DA-DBADA142B042@aosc.io>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 24 Oct 2020 21:09:52 +0200
Message-ID: <CAJiuCccANajJbXqJ8mrOzL0jFdsbrrtFbMqfrqPAWEt6pBMNSA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 02/10] ARM: dts: sun6i: a31-hummingbird:
 Enable RGMII RX/TX delay on Ethernet PHY
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Oct 2020 at 20:39, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2020=E5=B9=B410=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=882:30:35, "Jernej =C5=A0krabec" <jernej.skrabec@siol.net> =E5=86=99=E5=88=
=B0:
> >Dne sobota, 24. oktober 2020 ob 19:51:06 CEST je Icenowy Zheng
> >napisal(a):
> >> =E5=9C=A8 2020-10-25=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 00:25 +0800=
=EF=BC=8CChen-Yu Tsai=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> > From: Chen-Yu Tsai <wens@csie.org>
> >> >
> >> > The Ethernet PHY on the A31 Hummingbird has the RX and TX delays
> >> > enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins.
> >> >
> >> > Fix the phy-mode description to correct reflect this so that the
> >> > implementation doesn't reconfigure the delays incorrectly. This
> >> > happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
> >> > rx/tx delay config").
> >>
> >> Personally I think they should revert this commit, and consider other
> >> solution.
> >>
> >> This commit breaks everything.
> >>
> >
> >Previously broken driver allowed inproper DT to work, so you have to
> >fix
> >everything eventually.
>
> There is no "improper DT" if it's already shipped, DT should suffer drive=
r
> change, not changed to match driver.
>
> I think at least Fedora tends to ship a DT with a system image that will
> not get updated when kernel gets updated.

I think we are missing a phy-mode saying use RGMII but don't change
the delay set by the hardware.
Or maybe introduce a phy-mode=3D'rgmii-noid' to explicitly disable the
RX/TD delay using software bits
and use phy-mode=3D'rgmii' to keep the delay set by the hardware.

Clement

>
> >
> >Plus side, there is no need to have hack for Pine64 Plus ethernet
> >anymore.
> >
> >Best regards,
> >Jernej
> >
> >> (Although the patch on individual DT patches are technically correct)
> >>
> >> > Fixes: c220aec2bb79 ("ARM: dts: sun6i: Add Merrii A31 Hummingbird
> >> > support")
> >> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> > ---
> >> >
> >> >  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >> > b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >> > index 049e6ab3cf56..73de34ae37fd 100644
> >> > --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >> > +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> >> > @@ -154,7 +154,7 @@ &gmac {
> >> >
> >> >    pinctrl-names =3D "default";
> >> >    pinctrl-0 =3D <&gmac_rgmii_pins>;
> >> >    phy-handle =3D <&phy1>;
> >> >
> >> > -  phy-mode =3D "rgmii";
> >> > +  phy-mode =3D "rgmii-id";
> >> >
> >> >    status =3D "okay";
> >> >
> >> >  };
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/9D317C52-5F28-41A9-80DA-DBADA142B042%40aosc.io.

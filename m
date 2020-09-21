Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F496273211
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgIUSjP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Sep 2020 14:39:15 -0400
Received: from mailoutvs12.siol.net ([185.57.226.203]:57412 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726456AbgIUSjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:39:15 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 14:39:14 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 3AD4E5274C3;
        Mon, 21 Sep 2020 20:32:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XJOz8y8z8RPg; Mon, 21 Sep 2020 20:32:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id D10215274C4;
        Mon, 21 Sep 2020 20:32:16 +0200 (CEST)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id F3DBC5274C3;
        Mon, 21 Sep 2020 20:32:15 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: Re: [PATCH v4 09/22] arm64: dts: allwinner: h6: Add HDMI audio node
Date:   Mon, 21 Sep 2020 20:37:09 +0200
Message-ID: <59286578.E0qSRroNqr@kista>
In-Reply-To: <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com> <20200921135925.q7mde2cnt5jtzkb5@gilmour.lan> <CAJiuCcfz9A_Vmzq=s3LK2kGB_1tZPkC9Ux+Brdocp9py0fovAg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 21. september 2020 ob 19:23:49 CEST je Clément Péron 
napisal(a):
> Hi Maxime,
> 
> On Mon, 21 Sep 2020 at 15:59, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Mon, Sep 21, 2020 at 12:27:18PM +0200, Clément Péron wrote:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > Add a simple-soundcard to link audio between HDMI and I2S.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
> > >  1 file changed, 33 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/
boot/dts/allwinner/sun50i-h6.dtsi
> > > index 28c77d6872f6..a8853ee7885a 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > > @@ -67,6 +67,25 @@ de: display-engine {
> > >               status = "disabled";
> > >       };
> > >
> > > +     hdmi_sound: hdmi-sound {
> > > +             compatible = "simple-audio-card";
> > > +             simple-audio-card,format = "i2s";
> > > +             simple-audio-card,name = "sun50i-h6-hdmi";
> > > +             simple-audio-card,mclk-fs = <128>;
> > > +             simple-audio-card,frame-inversion;
> > > +             status = "disabled";
> > > +
> > > +             simple-audio-card,codec {
> > > +                     sound-dai = <&hdmi>;
> > > +             };
> > > +
> > > +             simple-audio-card,cpu {
> > > +                     sound-dai = <&i2s1>;
> > > +                     dai-tdm-slot-num = <2>;
> > > +                     dai-tdm-slot-width = <32>;
> >
> > It looks weird to have both some TDM setup here, and yet the format in
> > i2s?
> 
> Yes, I agree I will check if it's really needed.

I think this was explained before. Anyway, this is needed to force width to 
32, no matter actual sample width. That's a requirement of HDMI codec. I 
believe Marcus Cooper have another codec which also needs fixed width.

There is no similar property for I2S, so TDM one is used here.

Best regards,
Jernej

> 
> Clement
> 
> >
> > Maxime
> 



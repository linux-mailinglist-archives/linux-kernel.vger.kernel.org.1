Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F372918A1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgJRRZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgJRRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:25:24 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87FC061755;
        Sun, 18 Oct 2020 10:25:23 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b15so6417151iod.13;
        Sun, 18 Oct 2020 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EF0d0rPxPBP+eQ08m8KipVtvfWo4S1ML+teg9iAvEgM=;
        b=KxNJ94VbFWhQMgJG9lsw14cyd2TbyC3LMiUEL6t5S2ulBXZX1Y0zrZQNi0D8+GzxpU
         GAIXJLQAEHstwd1UXgnK74GEx75Z1kCr0rsVssy8CDouOXLG1sRnG/MFY3jyi+utmUlj
         9nKjzsEW1PB6Y9pkaFXZn6lR+ysPt1cn0PFowfpAZKWaJyGRmmzJuX67qm9iI6VO5QkA
         Br14LBIyj9Zmka7/3GFoWmGLtLyfGlQ7aHRy3Jlc7bRB5WKPoWnSW4egzcQm/ec/UGwe
         P095iapWehaQOF7exvA/ueAf2pcgU9L1TeSMfQPnsOPxcde4pOxcY2aqt24gqGIemMXv
         zjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EF0d0rPxPBP+eQ08m8KipVtvfWo4S1ML+teg9iAvEgM=;
        b=Llum++LmLezI9KGHj9NFsTy47OaFKoVASH5O1D7fNkMxDfbNMhsWLsRtA0FdkkzEHP
         VaTkAE37fJzXD/Hk7kf7avSLfXT2ElS4HqHlxP6z9cgDc2d+OxXDXy1BJ9uBZYTAXB1T
         KhbND4R0kYASFc9rkWLx7FfskNnEL+Z9pIcWlBvleeLtLZUFG3sB1Isxj2Cv2qsRqi9R
         kFWrlfq6ADSWhimkOI3Dv7tC6h61vxQwFv8xO13YUVc+y6ZbvHbl+RPT+p2ZS+uzxTfb
         amnP/ajq3nl7RmS/c3IQlLzUJa3h3NnERgz5Q4vBGxWtsEnv7AxxI/lvRzjEhvPay12r
         buCA==
X-Gm-Message-State: AOAM530TDFtAH0pHGu7nPpRbhLIQWAD9NYkHYqH+LkAu6AkXAw8gHl8K
        DsKkrqz0CoeR/n0oE5FUubQox2EI9XWCjYpNrJo=
X-Google-Smtp-Source: ABdhPJyTT8m3C4AeKq24obqVZhbsLHjyeL/1sJFdbSFOu5S2S1/2OY9bDRPr9FVGZLj6lYSyArc2jnZFmgBKWRAecYk=
X-Received: by 2002:a6b:b208:: with SMTP id b8mr8348127iof.36.1603041922246;
 Sun, 18 Oct 2020 10:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201011212238.174792-1-peron.clem@gmail.com> <20201012112218.juke4ll4dnwrmwzw@gilmour.lan>
In-Reply-To: <20201012112218.juke4ll4dnwrmwzw@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 18 Oct 2020 19:25:10 +0200
Message-ID: <CAJiuCceNOgZVNquFx7Fytxi-e0hvA_==V2Oudq+fYWSRKWD5sA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: allwinner: beelink-gs1: Update LED power node
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

HI Maxime,

On Mon, 12 Oct 2020 at 13:22, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi!
>
> On Sun, Oct 11, 2020 at 11:22:37PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Beelink GS1 LED trigger a warning when running dtbs_check.
> >
> > Update the node with a valid pattern property.
> >
> > Also add the function and the color of the LED and drop the
> > label which is deprecated.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > index 3f7ceeb1a767..a364cb4e5b3f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > @@ -7,6 +7,7 @@
> >  #include "sun50i-h6-cpu-opp.dtsi"
> >
> >  #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/leds/common.h>
> >
> >  / {
> >       model =3D "Beelink GS1";
> > @@ -43,8 +44,9 @@ ext_osc32k: ext_osc32k_clk {
> >       leds {
> >               compatible =3D "gpio-leds";
> >
> > -             power {
> > -                     label =3D "beelink:white:power";
> > +             led-0 {
> > +                     function =3D LED_FUNCTION_POWER;
> > +                     color =3D <LED_COLOR_ID_WHITE>;
> >                       gpios =3D <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 *=
/
> >                       default-state =3D "on";
> >               };
>
> Doesn't that also change the sysfs file that LED is exposed to the usersp=
ace with?

Indeed the previous led sysfs:
/sys/class/leds/beelink:white:power/
is now
/sys/class/leds/white:power/

Do you want me to keep the label property to avoid this sysfs change ?

Regards,
Clement

>
> Maxime

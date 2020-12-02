Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5079C2CC133
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387852AbgLBPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgLBPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:46:44 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FFAC0613CF;
        Wed,  2 Dec 2020 07:46:04 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so4328559ljk.1;
        Wed, 02 Dec 2020 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0qZccW6T6RuJI8Ln1DnE0GJjDxXS9vOlbJ0Zgj3L1EI=;
        b=dv1TDWvtBCJdUGLNTuqA8mM6Y4IBH76JWIqo+SfveVlcDUwS3YRv1weIVpmyuMJLxl
         EF4VHQZZvPhdd/WOWGlLosmo0DMOfOl8skIlVx2Hj5nEPmB/EcxpIhiHf7uX3stMtmhi
         vf2YicWgdNL0VxOcNrhExm6JtIfSnd5V86qEPtxfVRtFQkXWZlbMpg33jSF7TK6WBTTp
         JfAF5/0l5CnaTymeoVhNDD9G5vjDPHulIwPscNfXnQfoj/2YyvWh9q8wFv5mSXCdxgSe
         fGz9k6wT0LvOblF5rGn2z9qU27rmOd3VsCvJ7YLnkCY3M7D36c1f4oOO2Dgr4J5GhldH
         gcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0qZccW6T6RuJI8Ln1DnE0GJjDxXS9vOlbJ0Zgj3L1EI=;
        b=jQDS8YoFh9wZpXup5qTjj50Rjf5ZPK5lb1IvBZIkR9GJEZk1mmJHqPvms1hAGfI0Da
         wIVO6Qd9q0yUqn112X4zCpH+NJHkRmDuW2qTjt062AJ/0YHy3g5vYgdbCbv4BJ/yzkue
         e6LzAlzOO1FunRz3MZcYCJ+xAuVL+7QnK/3Okgmx/8cOg7xw5YOG07OJQFytrUbq7kEy
         xYHk67uXG14bwUqKTXF0yWrJWMls8M+VXt9Vxt7ZglkGKMihEsbGskeVZeUdZa1sLBtP
         nVt1y9wWLmmMdwQePN0RN99FO7qvoeP9DOUtONdwCf5jcp+E6t1eu/6CUQgRUWMIfeBM
         KO7w==
X-Gm-Message-State: AOAM530ReTO/Nx/5PeRP0Wn8twwdzsvubFTjyZ9e0Y03op9AfJZQeRms
        YlkqQB8V4W/K33ZyVIApAcgiXIEYYV5RwKNHJDpecMNQ
X-Google-Smtp-Source: ABdhPJzSiqjwu2NsgZZx/PKcI/qKFtjxlox/dqwxihcJhYlEdF5+SC2i56NuzURCyevi+g5L+GLAhHHvXkaI/YerAzE=
X-Received: by 2002:a2e:b1c9:: with SMTP id e9mr1450197lja.283.1606923962771;
 Wed, 02 Dec 2020 07:46:02 -0800 (PST)
MIME-Version: 1.0
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
 <20201125164207.GD4716@dell> <CADiBU3_bgx-K_zxzKCSL8w=meZu3cA3uWoC-3QVsBAuNJW1uiw@mail.gmail.com>
 <20201202084909.GI4801@dell>
In-Reply-To: <20201202084909.GI4801@dell>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 2 Dec 2020 23:45:50 +0800
Message-ID: <CADiBU3-XYVPjfrVFq_K3GBHviPd-tKuPp6W5EDcUvywsN5ODwA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mfd: rt4831: Adds support for Richtek RT4831 MFD core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B412=E6=9C=882=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 02 Dec 2020, ChiYuan Huang wrote:
>
> > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:42=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > On Mon, 02 Nov 2020, cy_huang wrote:
> > >
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > Adds support Richtek RT4831 MFD core.
> > > > RT4831 includes backlight and DSV part that can provode display pan=
el
> > > > for postive and negative voltage and WLED driving.
> > > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > ---
> > > >  drivers/mfd/Kconfig       |  11 +++++
> > > >  drivers/mfd/Makefile      |   1 +
> > > >  drivers/mfd/rt4831-core.c | 119 ++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  3 files changed, 131 insertions(+)
> > > >  create mode 100644 drivers/mfd/rt4831-core.c
> > > >
> > > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > > index 8b99a13..a22f002 100644
> > > > --- a/drivers/mfd/Kconfig
> > > > +++ b/drivers/mfd/Kconfig
> > > > @@ -1088,6 +1088,17 @@ config MFD_RDC321X
> > > >         southbridge which provides access to GPIOs and Watchdog usi=
ng the
> > > >         southbridge PCI device configuration space.
> > > >
> > > > +config MFD_RT4831
> > > > +     tristate "Richtek RT4831 WLED and DSV IC"
> > >
> > > Please expand on WLED and DSV.
> > >
> > > This is documentation and should leave nothing to the imagination.
> > >
> > Rewrite to "Richtek RT4831 four channel WLED and display bias
> > voltage", is it okay?
>
> I had to look-up WLED, but I guess it's okay.
>
> "Display Bias Voltage"
>
OK, I'll change this line to
"Richtek RT4831 fource channel WLED and Display Bias Voltage"
> > > > +     depends on I2C
> > > > +     select MFD_CORE
> > > > +     select REGMAP_I2C
> > > > +     help
> > > > +       This enables support for the Richtek RT4831.
> > > > +       RT4831 includes WLED driver and DisplayBias voltage(+/-) re=
gulator.
> > > > +       It's common used to provide the display power and to drive =
the
> > > > +       display backlight WLED.
> > >
> > > Please don't line-wrap unnecessarily.
> > >
> > > Please re-work the last sentence, as it doesn't quite make sense.
> > >
> > Rewrite the whole sentence like as below
> > "This enables support for the Richtek RT4831. It includes 4 channel
> > WLED driving and Display Bias voltage output. It's commonly used to
> > provide the LCD power and to drive LCD backlight."
>
> "Display Bias Voltage"
>
> "provide power to the LCD display"
>
Thanks. looks better
> [...]
>
> > > > +static int rt4831_probe(struct i2c_client *client)
> > > > +{
> > > > +     struct gpio_desc *enable;
> > > > +     struct regmap *regmap;
> > > > +     unsigned int val;
> > > > +     int ret;
> > > > +
> > > > +     enable =3D devm_gpiod_get_optional(&client->dev, "enable", GP=
IOD_OUT_HIGH);
> > > > +     if (IS_ERR(enable)) {
> > > > +             dev_err(&client->dev, "Failed to get chip enable gpio=
\n");
> > >
> > > "Failed to get 'enable' GPIO chip"
> > >
> > May I remove "chip" word? It seems redundant.
> > "Failed to get 'enable' GPIO" is better.
> > Because 'enable' is a physical input pin for RT4831.
>
> Sounds good.
>
> [...]
>
> > > > +static int rt4831_remove(struct i2c_client *client)
> > > > +{
> > > > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > > > +
> > > > +     /* Make sure all off before module removal */
> > >
> > > "Disable all <thing your disabling> are disabled before ..."
>
> This should have said:
>
>   "Ensure all <thing your disabling> are disabled before ..."
>
> > May I rewrite it to "Configure WLED driving and DSV output all to be
> > disabled before MFD module removal"?
>
> You don't need to mention MFD or modules here since we know how the
> Device Driver model works and what .remove() does.
>
> What about:
>
>   "Disable WLED and DSV outputs"
Do you mean that only keep this comment line is better? NO more
redundant description like "before ....".
If yes, I'll only leave  the comment like as you said in remove/shutdown op=
s.
> > > > +     return regmap_update_bits(regmap, RT4831_REG_ENABLE, RT4831_R=
ESET_MASK, RT4831_RESET_MASK);
> > > > +}
> > > > +
> > > > +static void rt4831_shutdown(struct i2c_client *client)
> > > > +{
> > > > +     struct regmap *regmap =3D dev_get_regmap(&client->dev, NULL);
> > > > +
> > > > +     /* Make sure all off before machine shutdown */
> > >
> > > As above.
> > >
> > like as above ".... before 'machine shutdown'
>
>   "Disable WLED and DSV outputs"
Same as above.

Thanks for all the suggestion.
If any misunderstanding, please kindly let me know.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

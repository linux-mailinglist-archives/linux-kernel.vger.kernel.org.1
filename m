Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF22E2DD885
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 19:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgLQSju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 13:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQSju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 13:39:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165CC061794;
        Thu, 17 Dec 2020 10:39:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id p22so29640926edu.11;
        Thu, 17 Dec 2020 10:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k/GE2Mymn0MWw4lSzUekG2u984+PB3fp4Emf8ngspDc=;
        b=iRHzqTCLM8uk5SvwHl3R9UrzKEmchQjUBkNk4T2wiWVpOLY/PUsDYx0JhtRbGNchiM
         CbruN/QLF7JnNMoGA8EV2mSEq4rH1b3M36Ji4rALyQlPUbKqK97Til/NVEU1vgliSe9n
         RAKZvE76n3mIY4q5jHtw3DtbXMyKH+WlyldQtOEk+RDasXZDNl+2nxFIL2GqNfRAXc4K
         Pp4mcEyV4k8WdGVZ5CTRWQW7x+SQf91UtxUuJNSwEkLAaoLuHqmrhW+HYK3ryrto946w
         ihOENKhmeQ458J2KGWoz/BEItMOWSjstmtashGpQQPkRc5RzKg/G9LEWgq+Tob7Gyw9A
         DQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k/GE2Mymn0MWw4lSzUekG2u984+PB3fp4Emf8ngspDc=;
        b=haAkudD22cHuW+QoTslXLfJDAk6uD4NvvPKFE8vSK3oBeI+4990jBH5XN0SXEtxruO
         OPMaHX9i2hZupy+Jzo1r7cyVmxIdq+0lvhb51lGyUP2dx4exnViiW5k2DCb/uPRcqTMH
         0lsGopkKcPZWxSLzPgMS+/1negExhPezUB+6h47tqGsOddIGZBQMNL35KTp94U3DdzfQ
         GKtpauVPlVoTPq7FceuAcY1C58qcRnmw8sTZsQK7oAzSIPpC8MfeDga1XS0RN2eVnbQu
         Os0guOVp/r/zY1DWUWDf6uBg5Ok/ePe+3b+AOib3uB+bH6ULx3vAl3SFDO2j66jjAw2Y
         CK2g==
X-Gm-Message-State: AOAM532l1jUWya7XrD8OTZfMDmfNhZYzqtnzERlHhuJXmBXxqU9gvlpo
        ubn01Bh85NZRvWMZM8xFbDJYu/BV0hdv9l0Tizw=
X-Google-Smtp-Source: ABdhPJwd8dEALA2nQF+a81hXjbR/E6op4D/hUq4hHgh/Gy/7UAdk0Vj81j6hmFhlax3l74y9ZSPv3IOr9twA2HOUn+Y=
X-Received: by 2002:aa7:db01:: with SMTP id t1mr691695eds.185.1608230348163;
 Thu, 17 Dec 2020 10:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
 <20201215235639.31516-8-adrien.grassein@gmail.com> <CAMty3ZDgyAx-maPqEOR_cBizQDfRZB0EMGj6iddK1BhGvziFkA@mail.gmail.com>
In-Reply-To: <CAMty3ZDgyAx-maPqEOR_cBizQDfRZB0EMGj6iddK1BhGvziFkA@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 17 Dec 2020 19:38:57 +0100
Message-ID: <CABkfQAHmpuZ8CyuYJijTVOAZ=UgrAepCHZh_j8PJ3y_qwPnQVg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] regulator: pf8x00: fix nxp,phase-shift
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for your review.

Le jeu. 17 d=C3=A9c. 2020 =C3=A0 18:42, Jagan Teki <jagan@amarulasolutions.=
com> a =C3=A9crit :
>
> On Wed, Dec 16, 2020 at 5:27 AM Adrien Grassein
> <adrien.grassein@gmail.com> wrote:
> >
> > Fix the ternary condition which is a bad coding style
> > in the kernel
> >
> > I also remove the defering configuration of the nxp,phase-shift.
> > The configuration is now done at parsing time. It save some memory
> > and it's better for comprehension.
> >
> > I also use the OTP default configuration when the paramater is wrong
> > or not specified.
> > I think that it's better to use the default configuration from the chip
> > than an arbitrary value.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  drivers/regulator/pf8x00-regulator.c | 45 +++++++++++++---------------
> >  1 file changed, 20 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/p=
f8x00-regulator.c
> > index 5ad940b3db0a..b8b3ac393ee8 100644
> > --- a/drivers/regulator/pf8x00-regulator.c
> > +++ b/drivers/regulator/pf8x00-regulator.c
> > @@ -107,7 +107,6 @@ enum pf8x00_ldo_states {
> >
> >  #define PF8X00_SWXILIM_MASK            GENMASK(4, 3)
> >  #define PF8X00_SWXPHASE_MASK           GENMASK(2, 0)
> > -#define PF8X00_SWXPHASE_DEFAULT                0
>
> Keep this as it is and assign it 1 as the below code assigns 1.

I don't understand, PF8X00_SWXPHASE_DEFAULT is not used anymore in the code=
.
Why should I keep it ?
>
> >  #define PF8X00_SWXPHASE_SHIFT          7
> >
> >  enum pf8x00_devid {
> > @@ -121,7 +120,6 @@ enum pf8x00_devid {
> >
> >  struct pf8x00_regulator {
> >         struct regulator_desc desc;
> > -       u8 phase_shift;
> >  };
> >
> >  struct pf8x00_chip {
> > @@ -167,17 +165,13 @@ static const int pf8x00_vsnvs_voltages[] =3D {
> >         0, 1800000, 3000000, 3300000,
> >  };
> >
> > -static struct pf8x00_regulator *desc_to_regulator(const struct regulat=
or_desc *desc)
> > -{
> > -       return container_of(desc, struct pf8x00_regulator, desc);
> > -}
> > -
> >  static int pf8x00_of_parse_cb(struct device_node *np,
> >                               const struct regulator_desc *desc,
> >                               struct regulator_config *config)
> >  {
> > -       struct pf8x00_regulator *data =3D desc_to_regulator(desc);
> >         struct pf8x00_chip *chip =3D config->driver_data;
> > +       unsigned char id =3D desc->id - PF8X00_LDO4;
> > +       unsigned char reg =3D PF8X00_SW_BASE(id) + SW_CONFIG2;
> >         int phase;
> >         int val;
> >         int ret;
> > @@ -185,21 +179,30 @@ static int pf8x00_of_parse_cb(struct device_node =
*np,
> >         ret =3D of_property_read_u32(np, "nxp,phase-shift", &val);
> >         if (ret) {
> >                 dev_dbg(chip->dev,
> > -                       "unspecified phase-shift for BUCK%d, use 0 degr=
ees\n",
> > -                       desc->id - PF8X00_LDO4);
> > -               val =3D PF8X00_SWXPHASE_DEFAULT;
> > +                       "unspecified phase-shift for BUCK%d, using OTP =
configuration\n",
> > +                       id);
> > +               goto end;
> >         }
> >
> > -       phase =3D val / 45;
> > -       if ((phase * 45) !=3D val) {
> > +       if (val < 0 || val > 315 || val % 45 !=3D 0) {
> >                 dev_warn(config->dev,
> > -                        "invalid phase_shift %d for BUCK%d, use 0 degr=
ees\n",
> > -                        (phase * 45), desc->id - PF8X00_LDO4);
> > -               phase =3D PF8X00_SWXPHASE_SHIFT;
> > +                        "invalid phase_shift %d for BUCK%d, using OTP =
configuration\n",
> > +                        val, id);
> > +               goto end;
> >         }
> >
> > -       data->phase_shift =3D (phase >=3D 1) ? phase - 1 : PF8X00_SWXPH=
ASE_SHIFT;
> > +       phase =3D val / 45;
> > +
> > +       if (phase >=3D 1)
> > +               phase -=3D 1;
> > +       else
> > +               phase =3D PF8X00_SWXPHASE_SHIFT;
> > +
> > +       regmap_update_bits(chip->regmap, reg,
> > +                       PF8X00_SWXPHASE_MASK,
> > +                       phase);
>
> Add all these arguments in the same line.
OK.


Thanks again,

Adrien

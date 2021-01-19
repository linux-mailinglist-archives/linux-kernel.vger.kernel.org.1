Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B548C2FB40D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbhASI0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731290AbhASIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:24:54 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672F6C0613CF;
        Tue, 19 Jan 2021 00:24:10 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id n8so12127620ljg.3;
        Tue, 19 Jan 2021 00:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lzQ4WSBpq2hEo6V0PK/bKozargiQZ72MCs5Zs/PuMUA=;
        b=OdNxzGO0wq9dEmorue2gc6pO6u+B5YkF+JpkTRxuOnkIlCd3O5+rWrcB2CgQnY23Da
         3//2g2/2CiWpNCwJb4J22R8K3Ic2QrEXLck96wfi57ZAh9kUSxTyyshzSiH4Gp7rtazs
         BZn09RytTMren18LIcFijQYa0RaqoGdy6U3jGSfolF0Fdqqz65UQ3gzUGHPVXrZtWMwZ
         NyoEzHMHEEu8IEKauF2NgU+Um+F8VXkpyWGiIcRLO0Hlu93VJEVsQ4sXJ0E9KgaC/G92
         lFs1WfWrQFG5bYLo0U66+iaRht+7FR1cc2TV3iyBDp4x2H/KRV+IJyxjFZLCybXEfmtW
         ZVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lzQ4WSBpq2hEo6V0PK/bKozargiQZ72MCs5Zs/PuMUA=;
        b=qgIokDj/reOcsEHo2yjPGI7Tl1jdU85PWUNe+ysGIL3vF+Er0qrOzfE8ibZSj5Ao5R
         H8nkAbk2RTGQe1TcM2cJaPsG9WDiYaM4LWVRqokQyDZhwjS66ep3qIVndYkkJnMnBifs
         LcoU5B/So2eWZ++iYTrgsWEgzMoFnUggFb6iGJObuc98s69W0/EAjSapAeySt9X7FvhA
         75JAVngXN1rJks4T5nadFcPo4WRYlVaNw9sN93Z8Oce1dn2lmMh4UX3vdj/qlAYJkLad
         KoKlD0wklkpxpoF8jK40sb6LCfGr2Y6b7H07bmX3/ahkAFEFm+NtAkbsgtJMx/H/C/EI
         KVew==
X-Gm-Message-State: AOAM532IWhsdwieV29ZXlFOZlzlcAtkP28K2zCQVRMW6SMJl2x+Ab87K
        7x4ISpJbY8kdQmeHn4TGX7p1zFzFPN7aIMyX+do=
X-Google-Smtp-Source: ABdhPJw3SUHClF0Yr/xAP9QfMg0cROH78E5MpdK77ZL6G9aGQ8zQx2aWFdiCVVnBV6y6tt5vnSzns4SbPLZuoZv6wmY=
X-Received: by 2002:a2e:9805:: with SMTP id a5mr1417257ljj.175.1611044648876;
 Tue, 19 Jan 2021 00:24:08 -0800 (PST)
MIME-Version: 1.0
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
 <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net> <CADiBU38g_E+iH4jTwQfPvJh4=WRH4vzQ12oubGg47gj+CpTU0A@mail.gmail.com>
 <1611041874.12761.13.camel@mhfsdcap03>
In-Reply-To: <1611041874.12761.13.camel@mhfsdcap03>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 19 Jan 2021 16:23:56 +0800
Message-ID: <CADiBU39fAa30pK5uNCN=sBVZ2pC-ACFqCoY8vKr3+6e+n828tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb typec: tcpci: mt6360: Add vsafe0v support and
 external vbus supply control
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        matthias.bgg@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=881=
9=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Mon, 2021-01-18 at 16:28 +0800, ChiYuan Huang wrote:
> > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2021=E5=B9=B41=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On 1/15/21 6:13 AM, cy_huang wrote:
> > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > >
> > > > MT6360 not support for TCPC command to control source and sink.
> > >
> > > does not
> > >
> > Ack
> > > > Uses external 5V vbus regulator as the vbus source control.
> > > >
> > > Use
> > >
> > Ack
> > > > Also adds the capability to report vsafe0v.
> > > >
> > > add
> > >
> > Ack
> > > So far this driver works without regulator. Unless I am missing somet=
hing,
> > > this patch makes regulator support mandatory, meaning existing code w=
ill fail.
> > > I am not sure if that is appropriate/acceptable. Can we be sure that =
this will
> > > work for existing users of this driver ?
> > >
> > Yes, I already checked all the src/snk functionality based on  the
> > latest typec code.
> > It'll be common for our TCPC. It didn't support for TCPC command.
> > From the recent patches, actually, I have the local change to test the
> > src capability.
> > But I didn't submit it. It's almost the same to add set_vbus callback.
> > That's why I submit this change after tcpci 'set_vbus callback' is adde=
d.
> >
> > > Thanks,
> > > Guenter
> > >
> > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > ---
> > > >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 29 +++++++++++++++++++++++=
++++++
> > > >  1 file changed, 29 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/ty=
pec/tcpm/tcpci_mt6360.c
> > > > index f1bd9e0..0edf4b6 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/of.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/regmap.h>
> > > > +#include <linux/regulator/consumer.h>
> > > >  #include <linux/usb/tcpm.h>
> > > >
> > > >  #include "tcpci.h"
> > > > @@ -36,6 +37,7 @@ struct mt6360_tcpc_info {
> > > >       struct tcpci_data tdata;
> > > >       struct tcpci *tcpci;
> > > >       struct device *dev;
> > > > +     struct regulator *vbus;
> > > >       int irq;
> > > >  };
> > > >
> > > > @@ -51,6 +53,27 @@ static inline int mt6360_tcpc_write16(struct reg=
map *regmap,
> > > >       return regmap_raw_write(regmap, reg, &val, sizeof(u16));
> > > >  }
> > > >
> > > > +static int mt6360_tcpc_set_vbus(struct tcpci *tcpci, struct tcpci_=
data *data, bool src, bool snk)
> > > > +{
> > > > +     struct mt6360_tcpc_info *mti =3D container_of(data, struct mt=
6360_tcpc_info, tdata);
> > > > +     int ret;
> > > > +
> > > > +     /* To correctly handle the already enabled vbus and disable i=
ts supply first */
> > > > +     if (regulator_is_enabled(mti->vbus)) {
> > > > +             ret =3D regulator_disable(mti->vbus);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > >
> > > Is it really a good idea to disable vbus if it happens to be already =
enabled
> > > and there is (another ?) request to enable it ?
> > >
> > Yes, for  the state change from src_attach_wait to src_attach,
> > It need to meet the requirement that  the vbus is at vsafe0v.
> > So to disable it first is needed.
> > And to prevent other users from enabling/disabling external vbus
> > regulator in any case.
> > I think we may change regulator_get  to 'regulator_get_exclusive'.
> > From the design, 5v regulator only can be controlled via typec framewor=
k.
> > If other user touch it, it'll affect the typec state transition.
> How about to process the case that even switch usb controller to device
> mode, platform also need to keep vbus on? e.g. Iphone Carplay
>
>
It must be processed by USBPD data role swap.

Type C only decide the initial role (SNK: power snk and ufp; SRC:
power src and DFP).
Only USBPD can change the power/data/vconn role individually.

> > > > +
> > > > +     if (src) {
> > > > +             ret =3D regulator_enable(mti->vbus);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data=
 *tdata)
> > > >  {
> > > >       struct regmap *regmap =3D tdata->regmap;
> > > > @@ -138,7 +161,13 @@ static int mt6360_tcpc_probe(struct platform_d=
evice *pdev)
> > > >       if (mti->irq < 0)
> > > >               return mti->irq;
> > > >
> > > > +     mti->vbus =3D devm_regulator_get(&pdev->dev, "vbus");
> > > > +     if (IS_ERR(mti->vbus))
> > > > +             return PTR_ERR(mti->vbus);
> > > > +
> > > >       mti->tdata.init =3D mt6360_tcpc_init;
> > > > +     mti->tdata.set_vbus =3D mt6360_tcpc_set_vbus;
> > > > +     mti->tdata.vbus_vsafe0v =3D 1;
> > > >       mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata);
> > > >       if (IS_ERR(mti->tcpci)) {
> > > >               dev_err(&pdev->dev, "Failed to register tcpci port\n"=
);
> > > >
> > >
>

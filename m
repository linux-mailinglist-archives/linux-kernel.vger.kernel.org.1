Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE792FB3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbhASIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbhASIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:22:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3DDC061574;
        Tue, 19 Jan 2021 00:21:21 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b26so27874063lff.9;
        Tue, 19 Jan 2021 00:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NSnwppJM4RBea6rhgGGM4rDbGdYQwq/CEd9KX8c0D8U=;
        b=KKX43xE7CyF2OAHuoufRljedddmzgKGxjqqoHL0WRNIJh7aY09SxmQA88AnYR2a812
         hLSEHieWkcK1Qnyq4av0mhU1BT8vD0Voa8VgjhuwHdW3XO6OaPJymUgX5TlGksBxlJKH
         RfLZMBS8xRUo8/o4tLPTsIrdRI2qYz2odIaI6VLXwEsFi3N+YcGl1tcJdgXKg6LkFqSZ
         wbnOevLZ/MdE4bLfktG88R1UChwhJCyp+TxWrl/nCTg4rqCwar/PzykpOE8ZvJiaswVp
         1vDe+CDfuDEpfNdr8/u9Dk2Ff5RrCF0MtXcInHEn0yvJla/Mo/ltmKB0y0YcKXvNtywO
         7ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NSnwppJM4RBea6rhgGGM4rDbGdYQwq/CEd9KX8c0D8U=;
        b=eooyZEiT1bFLCnec5C8M3dx9x3taUGC0/ZlJGvQsmjqRYnLMniJeMeRZhT0WYI7SJu
         qyQWbytjYwds5fpmLTdK5zM03USAMID0SxBq3kNphovb9+W4nntoJ11o/mrER8Q+jXQB
         VrYac65LVe0iceAkkbtwD3zpyT80sxD2iyo89nwKNDXyvczZgXFR+s0IqpDUlawqsF0C
         9tn8kpE3g5L6NYfLqrYspgAtadZiirSgqXa0ZsuirDcKCOpMCmHcMdwKVM5lgcPvQeSZ
         CmMYLLlimlzcoOU5WNisCH92KhDvEoOFFbjGuEs/py3vrzo3QFJsgQjQ2ZVp1NRt3C+v
         Pq+g==
X-Gm-Message-State: AOAM530wFE/afdA0jZdUBQN4e2vNuA3YZj3vp6Bw2Asm4KpFOpQz2EU/
        zB/zc2CPxb0ms24jM0bkrFiqMygsqbugYCk1sFEkwmY9sSU=
X-Google-Smtp-Source: ABdhPJy7lFmGjvnX+2QdulCkZeQ6a/G+bDIiQs0QLBdf5QXWUq0IjnzT13t9tJXYesmgQNMi5ZCyMg4N+moiqesZvqc=
X-Received: by 2002:a19:ca5a:: with SMTP id h26mr1393081lfj.612.1611044480139;
 Tue, 19 Jan 2021 00:21:20 -0800 (PST)
MIME-Version: 1.0
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
 <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net> <1611041612.12761.9.camel@mhfsdcap03>
In-Reply-To: <1611041612.12761.9.camel@mhfsdcap03>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 19 Jan 2021 16:21:08 +0800
Message-ID: <CADiBU3-2DL9GOBesE6sZmWv_OeFNP5C5-TfrZ9tVkUXKSiV9wQ@mail.gmail.com>
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
9=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:33=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Sun, 2021-01-17 at 09:43 -0800, Guenter Roeck wrote:
> > On 1/15/21 6:13 AM, cy_huang wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > MT6360 not support for TCPC command to control source and sink.
> >
> > does not
> >
> > > Uses external 5V vbus regulator as the vbus source control.
> > >
> > Use
> >
> > > Also adds the capability to report vsafe0v.
> > >
> > add
> >
> > So far this driver works without regulator. Unless I am missing somethi=
ng,
> > this patch makes regulator support mandatory, meaning existing code wil=
l fail.
> If don't provide vbus-supply in DTS, regulator framework will provide a
> dummy regulator, so the code will not fail.
 In the last reply, I will change from regulator_get to
regulator_get_exclusive, it will return -ENODEV.
The IS_ERR can catch this situation, no dummy regulator will be returned.

And assume no vbus 5v for source & snk attached, It will cause typec
state machine repeated from
drp -> src_attach_wait -> src_attached -> PD_T_PS_SOURCE_on timeout.
It will be stuck in the loop until snk detached.

> > I am not sure if that is appropriate/acceptable. Can we be sure that th=
is will
> > work for existing users of this driver ?
>
> >
> > Thanks,
> > Guenter
> >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 29 +++++++++++++++++++++++++=
++++
> > >  1 file changed, 29 insertions(+)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/type=
c/tcpm/tcpci_mt6360.c
> > > index f1bd9e0..0edf4b6 100644
> > > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/usb/tcpm.h>
> > >
> > >  #include "tcpci.h"
> > > @@ -36,6 +37,7 @@ struct mt6360_tcpc_info {
> > >     struct tcpci_data tdata;
> > >     struct tcpci *tcpci;
> > >     struct device *dev;
> > > +   struct regulator *vbus;
> > >     int irq;
> > >  };
> > >
> > > @@ -51,6 +53,27 @@ static inline int mt6360_tcpc_write16(struct regma=
p *regmap,
> > >     return regmap_raw_write(regmap, reg, &val, sizeof(u16));
> > >  }
> > >
> > > +static int mt6360_tcpc_set_vbus(struct tcpci *tcpci, struct tcpci_da=
ta *data, bool src, bool snk)
> > > +{
> > > +   struct mt6360_tcpc_info *mti =3D container_of(data, struct mt6360=
_tcpc_info, tdata);
> > > +   int ret;
> > > +
> > > +   /* To correctly handle the already enabled vbus and disable its s=
upply first */
> > > +   if (regulator_is_enabled(mti->vbus)) {
> > > +           ret =3D regulator_disable(mti->vbus);
> > > +           if (ret)
> > > +                   return ret;
> > > +   }
> >
> > Is it really a good idea to disable vbus if it happens to be already en=
abled
> > and there is (another ?) request to enable it ?
> >
> > > +
> > > +   if (src) {
> > > +           ret =3D regulator_enable(mti->vbus);
> > > +           if (ret)
> > > +                   return ret;
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *=
tdata)
> > >  {
> > >     struct regmap *regmap =3D tdata->regmap;
> > > @@ -138,7 +161,13 @@ static int mt6360_tcpc_probe(struct platform_dev=
ice *pdev)
> > >     if (mti->irq < 0)
> > >             return mti->irq;
> > >
> > > +   mti->vbus =3D devm_regulator_get(&pdev->dev, "vbus");
> > > +   if (IS_ERR(mti->vbus))
> > > +           return PTR_ERR(mti->vbus);
> > > +
> > >     mti->tdata.init =3D mt6360_tcpc_init;
> > > +   mti->tdata.set_vbus =3D mt6360_tcpc_set_vbus;
> > > +   mti->tdata.vbus_vsafe0v =3D 1;
> > >     mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata);
> > >     if (IS_ERR(mti->tcpci)) {
> > >             dev_err(&pdev->dev, "Failed to register tcpci port\n");
> > >
> >
>

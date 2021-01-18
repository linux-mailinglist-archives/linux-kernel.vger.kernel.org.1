Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9C2F9B47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbhARI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733226AbhARI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:29:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E2EC061573;
        Mon, 18 Jan 2021 00:28:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u25so22842545lfc.2;
        Mon, 18 Jan 2021 00:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KLqGbxNa2Y//bSC/m+YoN3yy9E8IE8S0pxgJYj58niI=;
        b=Tfe7yWK4zDgBHMzIL7TOZmcC9zEBk86gzt6EuxaaK+Ya2f8nnOhvclMuu/30j1XSiL
         odccw1S4tfuCzYqsW9+c8tiQDO/Tl+gKvHR4mAMpnxAlKGSJyc+EdP72IvPJ1bHId9rl
         wzsXvsD5i7PeY0MrYhJQiHBFuRmNhqw34635KhB9eBd2qOZ0QXcrZYzaQBToN4ShM+YS
         qxWWwqOvZADYcDgzw3YOkPUrMyXdG9ozdXmdbK0YQlSDbnLJNWSI5HIfPzDjWd64F8nn
         mf6KsiE2zuhDwMSd/kGAdsklAGp/Vwu8Y5o/ChUSF9A7hx/sTIarKpaE7v5J6UVUCg1X
         MrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KLqGbxNa2Y//bSC/m+YoN3yy9E8IE8S0pxgJYj58niI=;
        b=tzDFbsdk8Fn6hToJ6hI5rGDtXZSlTikuMLx/bGlO/0BgWpUUpSrDyEoUe+N782vs3x
         D+ZGDJs6CWApTPk0HpsBdQeuyF3QhnF+3/Iy1oGZgIu+rS4/CDaJpX5JEeetFnoG9fbf
         twukx9QGH/1rUxEjMPVEajwk3ADlNgTACEM0VuYtnE0DHBvnE26zGh/2NyaaeqVTeNXh
         EymWCgQlKwUcVjHMvB8CSM7fYU+GnW9pkrnounTj+4TD20mZZqoCtPwCQqlYxYOrM820
         Tp+4EiWK5rFF9u2w89oRDoQE64OzTcKz7yngQCZht14TQWhbNJqTTqysMsQhXSEIkgxa
         lquQ==
X-Gm-Message-State: AOAM532BgJTa9sBEo9+AuCQlfLyTS4frwhYxeAtmGdAM/LDyuTNOFGqv
        5tNI3bKvD4KuZu9d7s29FSxFQxk0VM/KG+eJ1MQ=
X-Google-Smtp-Source: ABdhPJzQnwoABZVMam3MBtsrDW5CKBbIRNTR8LDPVSYlnnj70IT1dmoQYSz9szEAPTqj0/sUuSA1tQIbOLR4AZgLZKk=
X-Received: by 2002:a19:991:: with SMTP id 139mr10815362lfj.637.1610958525450;
 Mon, 18 Jan 2021 00:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com> <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net>
In-Reply-To: <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 18 Jan 2021 16:28:34 +0800
Message-ID: <CADiBU38g_E+iH4jTwQfPvJh4=WRH4vzQ12oubGg47gj+CpTU0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb typec: tcpci: mt6360: Add vsafe0v support and
 external vbus supply control
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2021=E5=B9=B41=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=881:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 1/15/21 6:13 AM, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > MT6360 not support for TCPC command to control source and sink.
>
> does not
>
Ack
> > Uses external 5V vbus regulator as the vbus source control.
> >
> Use
>
Ack
> > Also adds the capability to report vsafe0v.
> >
> add
>
Ack
> So far this driver works without regulator. Unless I am missing something=
,
> this patch makes regulator support mandatory, meaning existing code will =
fail.
> I am not sure if that is appropriate/acceptable. Can we be sure that this=
 will
> work for existing users of this driver ?
>
Yes, I already checked all the src/snk functionality based on  the
latest typec code.
It'll be common for our TCPC. It didn't support for TCPC command.
From the recent patches, actually, I have the local change to test the
src capability.
But I didn't submit it. It's almost the same to add set_vbus callback.
That's why I submit this change after tcpci 'set_vbus callback' is added.

> Thanks,
> Guenter
>
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 29 +++++++++++++++++++++++++++=
++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/=
tcpm/tcpci_mt6360.c
> > index f1bd9e0..0edf4b6 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/usb/tcpm.h>
> >
> >  #include "tcpci.h"
> > @@ -36,6 +37,7 @@ struct mt6360_tcpc_info {
> >       struct tcpci_data tdata;
> >       struct tcpci *tcpci;
> >       struct device *dev;
> > +     struct regulator *vbus;
> >       int irq;
> >  };
> >
> > @@ -51,6 +53,27 @@ static inline int mt6360_tcpc_write16(struct regmap =
*regmap,
> >       return regmap_raw_write(regmap, reg, &val, sizeof(u16));
> >  }
> >
> > +static int mt6360_tcpc_set_vbus(struct tcpci *tcpci, struct tcpci_data=
 *data, bool src, bool snk)
> > +{
> > +     struct mt6360_tcpc_info *mti =3D container_of(data, struct mt6360=
_tcpc_info, tdata);
> > +     int ret;
> > +
> > +     /* To correctly handle the already enabled vbus and disable its s=
upply first */
> > +     if (regulator_is_enabled(mti->vbus)) {
> > +             ret =3D regulator_disable(mti->vbus);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Is it really a good idea to disable vbus if it happens to be already enab=
led
> and there is (another ?) request to enable it ?
>
Yes, for  the state change from src_attach_wait to src_attach,
It need to meet the requirement that  the vbus is at vsafe0v.
So to disable it first is needed.
And to prevent other users from enabling/disabling external vbus
regulator in any case.
I think we may change regulator_get  to 'regulator_get_exclusive'.
From the design, 5v regulator only can be controlled via typec framework.
If other user touch it, it'll affect the typec state transition.
> > +
> > +     if (src) {
> > +             ret =3D regulator_enable(mti->vbus);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *td=
ata)
> >  {
> >       struct regmap *regmap =3D tdata->regmap;
> > @@ -138,7 +161,13 @@ static int mt6360_tcpc_probe(struct platform_devic=
e *pdev)
> >       if (mti->irq < 0)
> >               return mti->irq;
> >
> > +     mti->vbus =3D devm_regulator_get(&pdev->dev, "vbus");
> > +     if (IS_ERR(mti->vbus))
> > +             return PTR_ERR(mti->vbus);
> > +
> >       mti->tdata.init =3D mt6360_tcpc_init;
> > +     mti->tdata.set_vbus =3D mt6360_tcpc_set_vbus;
> > +     mti->tdata.vbus_vsafe0v =3D 1;
> >       mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata);
> >       if (IS_ERR(mti->tcpci)) {
> >               dev_err(&pdev->dev, "Failed to register tcpci port\n");
> >
>

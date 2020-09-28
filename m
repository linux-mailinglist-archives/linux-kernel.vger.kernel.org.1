Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905D427AA10
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgI1I5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1I5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:57:36 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1D9C0613CE;
        Mon, 28 Sep 2020 01:57:36 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a16so285686vsp.12;
        Mon, 28 Sep 2020 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ymvnEPp551TwlIsqFX4T8vHwRcqlCYOhPpKWgB7Vosc=;
        b=mIaF7J/A2g3oRrjf/82htfkliPnXMmKpaIQYTJq9dvTjxdWsadMXzN9ImYqJLkajkz
         Jkya5MNLDyCfSMFJ30HVQxO8W9AvS/uFwFpPeEzQBdsXfWHX41k+LDTcW1TcSExvXluL
         JNeg3XX8XHYkpntNYHThxeAYtbaAkDozFW5mUDKLycRQM8wQGa6LryTAC99yaGHEKzbs
         LwHosc8RwtSrIk/oaCAIadtzIoWc1QdY7Ox5sM3woz5oDbSedcd7PVH6q2j9IPCu/0pj
         2J93EkSpTrXinlqe7J8zDBt7PE7nGR6Ra2jRlDXcaQy8dkKS0i0b2eLbQF3hS9H9WOUw
         LBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ymvnEPp551TwlIsqFX4T8vHwRcqlCYOhPpKWgB7Vosc=;
        b=p4Hsk0ECJHyeCXSowVvA5PkmhmuBi7/VexIr2Ch2yLo1utzCBz4S8eRgDtFeduzG4G
         ojE0p/RKblxbyrgmBdWT5WGvYGc/gKw76kgTjQk3uW5xwxnDsxSzaaPlSpWl6PWW9F/p
         6HColarxkEM7gCDfZc2AoKa0AwCtFRyFQuxLCcB/7Qg0GBE4/Co4JN41lBTSyr+QJmkQ
         CG3r7BTLWxmRsij8h0Nh2eZhJJtgbQrbmBTjHj3F6fal4v3RZBHp/Aj0Q6/ZymE2uOgG
         affxogdL80onWGS3Y1ePrB8fb2nmAp9Tttpuux/N5l6iTmFULJawA1HFE7g8bxYjrxKu
         mYpg==
X-Gm-Message-State: AOAM532XkY4hI8SoJ1HQ0wHAUXBQHlNqbX77mBjUwZcRkqU300HJoO8U
        z0zXEBvQ0Bo44aLbTtT45lfwKZEhHakXllEdAes=
X-Google-Smtp-Source: ABdhPJziuemYOoLIjPZGP9SqhTbyrtIgpuNdvMja+DHExszPf9tbmK+qcis+Hxgg2Sg7iJqm2YBaFrK1ODENSM93PTk=
X-Received: by 2002:a67:8b45:: with SMTP id n66mr4878634vsd.45.1601283455301;
 Mon, 28 Sep 2020 01:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200921195555.1050731-1-badhri@google.com> <20200921195555.1050731-5-badhri@google.com>
 <CAKgpwJUqfyZv1+-A4R8R--O-u2R65T+VUxL6PtW4c6kG0FJWfg@mail.gmail.com> <CAPTae5LcTqoc52C01rQjL9NzA5Yh=NH0zvvJNosih8n2kMTn+A@mail.gmail.com>
In-Reply-To: <CAPTae5LcTqoc52C01rQjL9NzA5Yh=NH0zvvJNosih8n2kMTn+A@mail.gmail.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Mon, 28 Sep 2020 16:57:24 +0800
Message-ID: <CAKgpwJXEyeeh9_W-A4JfcRCeV5iXnEeiZBZoDPDT_s23TkLSuw@mail.gmail.com>
Subject: Re: [PATCH v8 05/11] dt-bindings: connector: Add property to set
 initial current cap for FRS
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Badhri Jagan Sridharan <badhri@google.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=88=
24=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:09=E5=86=99=E9=81=93=EF=
=BC=9A
>
> Hi Jun,
>
> Thanks for the feedback !
> The sink PDO from current source reflects the current source's(i.e.
> transmitter of the FRS signal) power requirement during fr swap.
> The current sink (i.e. receiver of the FRS signal) should check if it
> will be able to satisfy the current source's
> requirement during frswap before enabling the frs signal reception.
> The property in this patch refers to maximum current capability
> that the current sink can satisfy.

In this case I agree a new property is required.

Rob mentioned another similar property for typec[1], which is
for typec source(without power delivery) to define its power
capability to present its Rp, so a different usage.

[1]https://lore.kernel.org/linux-arm-kernel/20200902075707.9052-2-amelie.de=
launay@st.com/

> Perhaps, I should name it
> sink-frs-typec-current. Does that make sense to you ?

it looks better, thanks.

Li Jun
>
> Thanks,
> Badhri
>
> On Wed, Sep 23, 2020 at 3:43 AM Jun Li <lijun.kernel@gmail.com> wrote:
> >
> > Badhri Jagan Sridharan <badhri@google.com> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=8822=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:57=E5=86=99=E9=81=
=93=EF=BC=9A
> > >
> > > This change adds frs-typec-current which allows setting the initial c=
urrent
> > > capability of the new source when vSafe5V is applied during PD3.0
> > > sink Fast Role Swap.
> > >
> > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > ---
> > > Changes since v1:
> > > - Changing patch version to v6 to fix version number confusion.
> > >
> > > Changes since v6:
> > > - Removed the redundant usb-connector.txt that I created by mistake.
> > > - Moved to yaml.
> > >
> > > Changes since v7:
> > > - Rebase
> > > ---
> > >  .../devicetree/bindings/connector/usb-connector.yaml   |  8 ++++++++
> > >  include/dt-bindings/usb/pd.h                           | 10 ++++++++=
++
> > >  2 files changed, 18 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/connector/usb-connecto=
r.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > index 9bd52e63c935..1ca8e6a337e5 100644
> > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > @@ -142,6 +142,14 @@ properties:
> > >      required:
> > >        - port@0
> > >
> > > +  frs-typec-current:
> > > +    description: Initial current capability of the new source when v=
Safe5V
> > > +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supp=
ly PDO - Sink"
> > > +      of "USB Power Delivery Specification Revision 3.0, Version 1.2=
" provides the
> > > +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Typ=
e-C Current"
> > > +      provides a detailed description of the field.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> > If it's a part of sink PDO, I think you don't need a new property for t=
his, just
> > define it directly into sink-pdos by adding a new PDO define for PD 3.0=
,
> > something like:
> >
> > sink-pdos =3D <PDO_FIXED_v3(5000, 3000, PDO_FIXED_USB_COMM, FRS_CURRENT=
_1P5A)>;
> >
> > Li Jun
> > > +
> > >  required:
> > >    - compatible
> > >
> > > diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/p=
d.h
> > > index 985f2bbd4d24..db1ad4532197 100644
> > > --- a/include/dt-bindings/usb/pd.h
> > > +++ b/include/dt-bindings/usb/pd.h
> > > @@ -35,6 +35,16 @@
> > >
> > >  #define VSAFE5V 5000 /* mv units */
> > >
> > > +/*
> > > + * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Deliv=
ery Specification Revision 3.0,
> > > + * Version 1.2"
> > > + * Initial current capability of the new source when vSafe5V is appl=
ied.
> > > + */
> > > +#define FRS_NOT_SUPPORTED      0
> > > +#define FRS_DEFAULT_POWER      1
> > > +#define FRS_5V_1P5A            2
> > > +#define FRS_5V_3A              3
> > > +
> > >  #define PDO_BATT_MAX_VOLT_SHIFT        20      /* 50mV units */
> > >  #define PDO_BATT_MIN_VOLT_SHIFT        10      /* 50mV units */
> > >  #define PDO_BATT_MAX_PWR_SHIFT 0       /* 250mW units */
> > > --
> > > 2.28.0.681.g6f77f65b4e-goog
> > >

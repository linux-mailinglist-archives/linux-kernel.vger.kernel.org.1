Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1392E27566C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIWKdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:33:38 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB73C0613CE;
        Wed, 23 Sep 2020 03:33:38 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id d18so6483396uav.4;
        Wed, 23 Sep 2020 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/bBg3FhjP2lS/XUPeXQfiiwRoIzXoU/haAfZ553jXao=;
        b=DZsx62nN9d0HnGxwSaz3Q+J+ewBed0xSr6gDmdhUt8G4dnuvUX1Fe9R4x/yjUxNGQL
         47yPw8Fxn1atB+qP/C2aR+S+sz0b59HeVlXejXZXPqIbqZcHNohSRoIT5ZFTp3KDnb+r
         35JgzHhLIOfhwr9OsVslUtpggxJZ0+lzE5Eo46Njr0L4DDrVjD77dYXypPVz3S6xqcwa
         mQqWmXlhgdlNeMHf1lrMUOwDBoPgNqXfziD1rPxhoyvQca/qe/KYP9+CtzvcS1g9n0Ax
         QS0mnrkgfS+c7Z3KJLqR3yIUAXv+kcFSAbHvyGJ6gGtyQqi1f7dn43vNy8nZZwT35shB
         QomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/bBg3FhjP2lS/XUPeXQfiiwRoIzXoU/haAfZ553jXao=;
        b=edkDGzYWm/GlIcc1pBJpzUqlElwehyapgn72u959awUbaJjEyYrKTHzHgPLSTrKvn3
         EJFg+ztQ6SyGRr6CaUBX0cVhCHR/tXtG+qYrPyqkLaxa6yP5GX/flRyY7lZPlOP1yijf
         0j8axiW5GHYMTyeJW51RwGid5mZ49ya3l5fpcGn2kitF5P9jqBGezk/3BxXBOMH/ODVs
         i9ciKU5RFWV/1gtzcBPNmb4fMcmrl/VbLibvnAtNTV3OdQl9iCKlY9M3Eaj9WU6AuM5z
         /y8Jo7/3zP7xk7LhB4wOHPxkPDQKOG0l5upY6xXJjTkAI2Hb1RET8DqCk4f3W5atmhrf
         ettw==
X-Gm-Message-State: AOAM531rYqEdqshTmMVgPkcJ034ieTYks7NS+CKNjEhusYy/RrQG6muA
        C7sXgiaaJa3iHmk4x6crvQpw9FFDZ5qIs7+L6gU=
X-Google-Smtp-Source: ABdhPJzVji5FHfi5sp07esYPfgiV5ohcWhR4VJ8CJipPI1S1QLhWtPKL65fR4ciPeVtnJUkSScw1TU/Okfb7eapcfpk=
X-Received: by 2002:ab0:6f91:: with SMTP id f17mr5705707uav.129.1600857217627;
 Wed, 23 Sep 2020 03:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200902075707.9052-1-amelie.delaunay@st.com> <20200902075707.9052-2-amelie.delaunay@st.com>
 <CAKgpwJWPWFF_yWC0N_7qPONpWCN8U8tKVJ5Ctr1DGqXd_FyWkA@mail.gmail.com> <31ee8d7c-00b0-0ae1-eea1-e245f215c586@st.com>
In-Reply-To: <31ee8d7c-00b0-0ae1-eea1-e245f215c586@st.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 23 Sep 2020 18:33:26 +0800
Message-ID: <CAKgpwJUikcsbYz6Uy-iQsXgpDpBzJDpxTretYSfubfEJ7X5yWg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/6] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amelie DELAUNAY <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:31=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 9/23/20 11:08 AM, Jun Li wrote:
> > Amelie Delaunay <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=
=882=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:01=E5=86=99=E9=81=93=EF=
=BC=9A
> >>
> >> Power operation mode may depends on hardware design, so, add the optio=
nal
> >> property power-opmode for usb-c connector to select the power operatio=
n
> >> mode capability.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >> ---
> >> Changes in v2:
> >> - Add description for possible operation current values
> >> ---
> >>   .../bindings/connector/usb-connector.yaml     | 20 +++++++++++++++++=
++
> >>   1 file changed, 20 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/connector/usb-connector=
.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> index 9bd52e63c935..2fd85b9a7e1a 100644
> >> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> @@ -88,6 +88,26 @@ properties:
> >>         - device
> >>         - dual
> >>
> >> +  power-opmode:
> >> +    description: Determines the power operation mode that the Type C =
connector
> >> +      will support and will advertise through CC pins.
> >> +      - "default" corresponds to default USB voltage and current defi=
ned by the
> >> +        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 port=
s and
> >> +        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-l=
ane
> >> +        operation respectively.
> >> +      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defin=
ed in USB
> >> +        Type-C Cable and Connector specification, when Power Delivery=
 is not
> >> +        supported.
> >> +      - "usb_power_delivery" when Power Delivery is supported, as def=
ined in
> >> +        USB Power Delivery specification.
> >
> > Why need "usb_power_delivery"? isn't this information can be implied by
> > existing properties like if "source-pdos" is present?
> >
>
> power-opmode is an optional property.
> usb_power_delivery, as 3.0A, 1.5A or default here, only reflect the
> possible power operation mode you can set and that are understood by
> typec class:
> static const char * const typec_pwr_opmodes[] =3D {
>         [TYPEC_PWR_MODE_USB]    =3D "default",
>         [TYPEC_PWR_MODE_1_5A]   =3D "1.5A",
>         [TYPEC_PWR_MODE_3_0A]   =3D "3.0A",
>         [TYPEC_PWR_MODE_PD]     =3D "usb_power_delivery",
> };
>
> But I guess that a Type-C controller with usb power delivery support
> won't use power-opmode property but rather source/sink-pdos.
>
> power-opmode shows what will be advertised through CC pins. I can remove
> usb_power_delivery from the possible values, but what about the user who
> will add power-opmode property to configure his Type-C controller with
> USB power delivery support (sink and/or source by the way) ?

With power delivery support, this information should be abstracted from
source-pdos.

> Should I restrict the use of power-opmode to non-USB power delivery
> Type-C controllers ?

I think Yes. only need it for non-PD(power source/DRP).

Li Jun
> Please advise.
>
> Regards,
> Amelie
>
>
> > Li Jun
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#definitions/string
> >> +    enum:
> >> +      - default
> >> +      - 1.5A
> >> +      - 3.0A
> >> +      - usb_power_delivery
> >> +
> >>     # The following are optional properties for "usb-c-connector" with=
 power
> >>     # delivery support.
> >>     source-pdos:
> >> --
> >> 2.17.1
> >>

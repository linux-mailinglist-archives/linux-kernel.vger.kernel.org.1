Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E35129FAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 02:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgJ3BzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 21:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3BzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 21:55:06 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158C6C0613CF;
        Thu, 29 Oct 2020 18:55:06 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b4so2634335vsd.4;
        Thu, 29 Oct 2020 18:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O2Bfrh7e0SfwIe9SuDWvIR9uYNcLv1ssbiRxQwdN9iY=;
        b=Gc3dAipqASgtOIRGmBamjdZdmFXFKNzCfui1qkk4ipAQzwCWNx85nsFPYD/G+iTl67
         ZRiIqzmIlCmRwCTxaJWss7/xvNNqnAwcUaUY78ApKMH0/zCjpXP3v59ZGkSvbtXAqw1T
         tN1uU+raZBm9jk4OJJgTih0SCDjZG2dPft1DFtPgdQYzeI3rBmk0YbrCadCWMeX4xJy7
         R1/qKDqGy+fCMNmbOBsNd5uN3FCVu/epI/GXhjHzgb7hDdeTJ3nO7dGmyJBpv3mIQLXl
         4tbFCRTXf9lNMapnrJW5EDGxRVhM+fT+6NNgaZJ6bYxmN+ZNdiwp3XGbZbivshcUQg54
         4iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O2Bfrh7e0SfwIe9SuDWvIR9uYNcLv1ssbiRxQwdN9iY=;
        b=Sj28Zd9IBQdlzj19LBYA7DtzpGxSmm7n9vWmGiqp8nEfh0f7LFpfKcyeqIIoI53xKs
         VYvmcqXZl/umL2vja3DWx2hocDYAGE0flVXxtLCUbZSNnBCqjWzHu1GC9uSLQ2elC1mR
         O2LW17qavl4nyesS7Kt+P/nlSGN1go26AjfJ2T5/zkU6Hx7Ov5SrjGgYN4l8MV0r4G9j
         12kKeYjJkzszZwOnNZ/uJt5rj5U3ei1f2wg44/SrqrY2o9sIK/Wh5pJpdpb8/uob7Xjd
         qOPY6eq6GqwK9X1MdYTwmYLojEFnGmf6OSLWh7/mmyn3hil3IOgGpVzWptSC+IBTPTn+
         7U9Q==
X-Gm-Message-State: AOAM5328BenwcxShbJyqcoIWhzYSluj6oLSrX+qvMpRkrn+H6Wowyl9a
        D8bzcFwQiLFCZ2k98Z6qSNxs+ug/2kfe4uLPlnc=
X-Google-Smtp-Source: ABdhPJxsQ56AGU/3+xrQVJ8jrJpxHBC0lKnDYdah7PmyLCy34Sy+c/46LUL7dNf6w9JFX+plUXdhpk2L/oikjHAxHJQ=
X-Received: by 2002:a67:b647:: with SMTP id e7mr6030927vsm.26.1604022905164;
 Thu, 29 Oct 2020 18:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com> <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com>
In-Reply-To: <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Fri, 30 Oct 2020 09:54:54 +0800
Message-ID: <CAKgpwJVGUR9aSfoMkQ=ZXysgqn+H6n0uJbk5W9SeGiB7VXptwQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Rob Herring <robh@kernel.org>,
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

Amelie DELAUNAY <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=883=
0=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=
=BC=9A
>
>
>
> On 10/29/20 4:40 PM, Rob Herring wrote:
> > On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
> >> Power operation mode may depends on hardware design, so, add the optio=
nal
> >> property power-opmode for usb-c connector to select the power operatio=
n
> >> mode capability.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >> ---
> >>   .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++=
++
> >>   1 file changed, 18 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/connector/usb-connector=
.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> index 728f82db073d..200d19c60fd5 100644
> >> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> @@ -93,6 +93,24 @@ properties:
> >>         - device
> >>         - dual
> >>
> >> +  power-opmode:
> >
> > I've acked this version:
> >
> > https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com

That is a different property only for FRS.

> >
>
> frs is used for Fast Role Swap defined in USB PD spec.
> I understand it allows to get the same information but I'm wondering why
> the property name is limited to -frs- in this case. What about a
> non-power delivery USB-C connector ?

It's only for FRS, FRS is in the scope of power delivery.

>
> Moreover, power-opmode property support is already merged in typec class:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/usb/typec/class.c?h=3Dv5.10-rc1&id=3D12f3467b0d28369d3add7a0deb65f=
dac9b503c90
> and stusb160x driver uses it :(
>
> So, do I need to modify stusb160x driver (and bindings) to take into
> account this USB PD specific property?

Only Type-C w/o PD need this "power-opmode" property, so this
property is still required.

Li Jun

>
> Regards,
> Amelie
>
> > Please ack it if you are okay with it.
> >
> > Rob
> >
> >
> >> +    description: Determines the power operation mode that the Type C =
connector
> >> +      will support and will advertise through CC pins when it has no =
power
> >> +      delivery support.
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
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#definitions/string
> >> +    enum:
> >> +      - default
> >> +      - 1.5A
> >> +      - 3.0A
> >> +
> >>     # The following are optional properties for "usb-c-connector" with=
 power
> >>     # delivery support.
> >>     source-pdos:
> >> --
> >> 2.17.1
> >>

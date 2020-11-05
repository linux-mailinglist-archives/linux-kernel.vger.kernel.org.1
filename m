Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838392A82C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgKEPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731268AbgKEPzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:55:32 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09A722242;
        Thu,  5 Nov 2020 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604591730;
        bh=Nn5yZsR5cVNdPLSt6ukSmkFIoHyl1vlOqpN4mmSJvtQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RTPEIBmfewbb9j0xYmB1HkpyH6PrUI2AEgbepb/+ZtWwJvbIx5R/IQaMIQ7MUiQe/
         8/XyD2sgCcWIN9ylAusxJbsGRFQJKmJBGv4RrP8uf/O2/JRQIvAA/DJSmd96kemuOp
         +Ha/C0JLYX19HxzNEW2Ynt9H+n0AttNuf0FeH/n8=
Received: by mail-ot1-f44.google.com with SMTP id 79so1847711otc.7;
        Thu, 05 Nov 2020 07:55:30 -0800 (PST)
X-Gm-Message-State: AOAM532SAMY8PhSqpNHmHYhh0O4+JV0nj/ecjQLBKGgbeCecC369p8dO
        fCg3wqr/VXm42Ea8BNzHEvpAbr7uD42QCOdovw==
X-Google-Smtp-Source: ABdhPJzFE9EXbkrCyHs8MI0I/5ukc4rsI6+2K2P6Vfp+sYo4ignpEJ+h06rHKi84VQz22pcJpGyw8es9BrIeRKrOcBE=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr1984194oti.107.1604591729675;
 Thu, 05 Nov 2020 07:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com> <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com> <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
 <ebccf61a-c88f-c7f4-9f06-01d2bd1f43de@st.com> <20201104210803.GA4115079@bogus>
 <2da804ff-3b3c-0ea9-14d5-a163b28ccc33@st.com> <CAKgpwJU_yTTYabeMYFBqNs_6=N7gaTAc1v-+fU-dshFUrL1qVA@mail.gmail.com>
In-Reply-To: <CAKgpwJU_yTTYabeMYFBqNs_6=N7gaTAc1v-+fU-dshFUrL1qVA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Nov 2020 09:55:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUVRRD=j6FTFUgUuhfLkGe5WRex+gj7N6wvu-DbwL+bA@mail.gmail.com>
Message-ID: <CAL_JsqJUVRRD=j6FTFUgUuhfLkGe5WRex+gj7N6wvu-DbwL+bA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 6:24 AM Jun Li <lijun.kernel@gmail.com> wrote:
>
> Amelie DELAUNAY <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=
=885=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:36=E5=86=99=E9=81=93=EF=
=BC=9A
> >
> > On 11/4/20 10:08 PM, Rob Herring wrote:
> > > On Fri, Oct 30, 2020 at 04:27:14PM +0100, Amelie DELAUNAY wrote:
> > >>
> > >>
> > >> On 10/30/20 3:29 PM, Rob Herring wrote:
> > >>> On Thu, Oct 29, 2020 at 11:49 AM Amelie DELAUNAY <amelie.delaunay@s=
t.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 10/29/20 4:40 PM, Rob Herring wrote:
> > >>>>> On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
> > >>>>>> Power operation mode may depends on hardware design, so, add the=
 optional
> > >>>>>> property power-opmode for usb-c connector to select the power op=
eration
> > >>>>>> mode capability.
> > >>>>>>
> > >>>>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > >>>>>> ---
> > >>>>>>     .../bindings/connector/usb-connector.yaml      | 18 ++++++++=
++++++++++
> > >>>>>>     1 file changed, 18 insertions(+)
> > >>>>>>
> > >>>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-con=
nector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yam=
l
> > >>>>>> index 728f82db073d..200d19c60fd5 100644
> > >>>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.=
yaml
> > >>>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.=
yaml
> > >>>>>> @@ -93,6 +93,24 @@ properties:
> > >>>>>>           - device
> > >>>>>>           - dual
> > >>>>>>
> > >>>>>> +  power-opmode:
> > >>>>>
> > >>>>> I've acked this version:
> > >>>>>
> > >>>>> https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.c=
om
> > >>>>>
> > >>>>
> > >>>> frs is used for Fast Role Swap defined in USB PD spec.
> > >>>> I understand it allows to get the same information but I'm wonderi=
ng why
> > >>>> the property name is limited to -frs- in this case. What about a
> > >>>> non-power delivery USB-C connector ?
> > >>>
> > >>> I've got no idea. The folks that know USB-C and PD details need to =
get
> > >>> together and work all this out. To me, it looks like the same thing=
...
> > >>>
> > >>
> > >> It looks but...
> > >>
> > >> The purpose of power-opmode property is to configure the USB-C contr=
ollers,
> > >> especially the non-PD USB-C controllers to determine the power opera=
tion
> > >> mode that the Type C connector will support and will advertise throu=
gh CC
> > >> pins when it has no power delivery support, whatever the power role:=
 Sink,
> > >> Source or Dual
> > >> The management of the property is the same that data-role and power-=
role
> > >> properties, and done by USB Type-C Connector Class.
> > >>
> > >> new-source-frs-typec-current specifies initial current capability of=
 the new
> > >> source when vSafe5V is applied during PD3.0 Fast Role Swap. So here,=
 this
> > >> property is not applied at usb-c controller configuration level, but=
 during
> > >> PD Fast Role Swap, so when the Sink become the Source.
> > >> Moreover, the related driver code says FRS can only be supported by =
DRP
> > >> ports. So new-source-frs-typec-current property, in addition to bein=
g
> > >> specific to PD, is also dedicated to DRP usb-c controller.
> > >> The property is managed by Type-C Port Controller Manager for PD.
> > >
> > > But it's the same set of possible values, right? So we can align the
> > > values at least.
> > >
> >
> > USB Power Delivery FRS values are defined in
> > include/dt-bindings/usb/pd.h
>
> I think this can be changed if both can be aligned.
>
> >to fit with drivers/usb/typec/tcpm/tcpm.c
> > frs_typec_current enum.
> >
> > USB-C power operation mode values are defined in
> > include/linux/usb/typec.h with typec_pwr_opmode enum and matching with
> > string values of typec_pwr_opmodes tab.
> >
> > USB PD requires USB-C.
> > USB-C doesn't requires USB PD.
> >
> > drivers/usb/typec/tcpm/tcpm.c already used typec_pwr_opmode values.
> >
> > USB PD specification Table 6-14 Fixed Supply PDO says:
> > Fast Role Swap required USB Type-C Current (see also [USB Type-C 2.0]):
> > Value | Description
> >   00b  | Fast Swap not supported (default)
> >   01b  | Default USB Power
> >   10b  | 1.5A @ 5V
> >   11b  | 3.0A @ 5V
>
> This is the value in PDO of sink, the FRS property value(or after transla=
ted)
> actually is used to compare with above value.
>
> So I think both properties can share the same "value", maybe string
> like below
>
>   10 static const char * const typec_pwr_opmodes[] =3D {
>   11         [TYPEC_PWR_MODE_USB]    =3D "default",
>   12         [TYPEC_PWR_MODE_1_5A]   =3D "1.5A",
>   13         [TYPEC_PWR_MODE_3_0A]   =3D "3.0A",
>
> >
> > Note the *see also USB Type-C 2.0*.
> >
> > USB Type-C specification 4.6.2.1 USB Type-C Current says:
> > The USB Type-C connector uses CC pins for configuration including an
> > ability for a Source to advertise to its port partner (Sink) the amount
> > of current it shall supply:
> > =E2=80=A2 Default is the as-configured for high-power operation current=
 value as
> > defined by the USB Specification (500 mA for USB 2.0 ports; 900 mA or
> > 1,500 mA for USB 3.2 ports in single-lane or dual-lane operation,
> > respectively)
> > =E2=80=A2 1.5 A
> > =E2=80=A2 3.0 A
> >
> > > Can we align the names in some way? power-opmode and frs-source-opmod=
e
> > > or ??
>
> how about typec-power-opmode and frs-new-source-opmode

Sure.

>
> > >
> >
> > I let USB PD specialists answer.
> >
> > *frs* property fits with USB PD specification, so with USB PD protocol.
> > *power-opmode fits with USB Type-C specification, so with USB-C hardwar=
e
> > support.
> >
> > > Are these 2 properties mutually exclusive?
>
> I think yes.

This should work to express that:

allOf:
  - not:
      required:
        - typec-power-opmode
        - frs-new-source-opmode

Rob

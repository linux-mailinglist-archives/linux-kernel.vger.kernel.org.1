Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132842A7E80
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgKEMYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKEMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:24:07 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8EC0613CF;
        Thu,  5 Nov 2020 04:24:07 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id l22so648907vsa.4;
        Thu, 05 Nov 2020 04:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kL2m+ZFgq1/K+CQrrDxi61N8IEUFK1H2EexBFfPVxDg=;
        b=Ygz0p7/1IFsL6fMq4vGN0ed+2c39VHo8k8ld81EIwj/BVvsosT+em3sXxoP9ZlmKPs
         oPYvKNB1RFt5nvFV2G1USKal7xWAt3G2Qc3H8KIP6IlSCsz1ozp2jwOuFjJGxYv5bRgV
         ULHs3CHnSVk7FXyjP0bnsm8mrVH19eoX4YGbYnRTp70hL1X7sIGzsi+74HsmdwK0a2En
         HMNWnEN8EzxNtQPCYAJn2rqB2qiXTMltpDOeQoM5NymQhG06QKzMMBziHR1YlyTa+kKW
         cRpwcWzTR3H/P/EBNtKFPSLt2zV0uuUo9hsW8agIOvsFsTbBviXTS8jPt6HeW0cVpuMA
         bPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kL2m+ZFgq1/K+CQrrDxi61N8IEUFK1H2EexBFfPVxDg=;
        b=Cj0IkL/gWOYSiQyVWptQCaA29VNp7rLd+9yCQtFmXRiFoVcUjk2rn3S9pEXzWutVUz
         lcw0pAsheyPrxoLjuStMuxMvkeoY20Zv/uPI9ZrJKPFARwnsn9W4tKXAuTcblXhpCMrl
         zMK4clfyhWwaUGAnxu50MLkVdj209OpxW7H/BvBj3yKmeMp4PlVC5U5xnwbHJIml4xRe
         oRDYCJTnZnbWF4Phte/U4BY0OaIILmvjT+HqHDmz0Rd9xirW+jijICCWRzmTpIOUFdxN
         HmI9krU0Mzm6ym08CkC90LJdU1wbIVXCtrS1uoEOoSSa4FWzQblnDOUR8EpcpldcxUON
         kLvQ==
X-Gm-Message-State: AOAM530zA+991ejRPRHuOBjuvN4vTD+6TqRLzXO83AixcSJsIxY4C8r/
        8AOKiR0MA2rWiIot9gAKq1zmUDqf+rZXXVx6JBU=
X-Google-Smtp-Source: ABdhPJwrw+XyaIXuE6kgWuVslPDF/evht/Qk0FVkDZi9BYHfsLnPP4rZ+nmFWRlo79G76RQdvVb6D0/EONFB1ohCn84=
X-Received: by 2002:a05:6102:a1a:: with SMTP id t26mr814216vsa.37.1604579046470;
 Thu, 05 Nov 2020 04:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com> <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com> <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
 <ebccf61a-c88f-c7f4-9f06-01d2bd1f43de@st.com> <20201104210803.GA4115079@bogus>
 <2da804ff-3b3c-0ea9-14d5-a163b28ccc33@st.com>
In-Reply-To: <2da804ff-3b3c-0ea9-14d5-a163b28ccc33@st.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Thu, 5 Nov 2020 20:23:55 +0800
Message-ID: <CAKgpwJU_yTTYabeMYFBqNs_6=N7gaTAc1v-+fU-dshFUrL1qVA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Rob Herring <robh@kernel.org>,
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

Amelie DELAUNAY <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=885=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:36=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On 11/4/20 10:08 PM, Rob Herring wrote:
> > On Fri, Oct 30, 2020 at 04:27:14PM +0100, Amelie DELAUNAY wrote:
> >>
> >>
> >> On 10/30/20 3:29 PM, Rob Herring wrote:
> >>> On Thu, Oct 29, 2020 at 11:49 AM Amelie DELAUNAY <amelie.delaunay@st.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/29/20 4:40 PM, Rob Herring wrote:
> >>>>> On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
> >>>>>> Power operation mode may depends on hardware design, so, add the o=
ptional
> >>>>>> property power-opmode for usb-c connector to select the power oper=
ation
> >>>>>> mode capability.
> >>>>>>
> >>>>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >>>>>> ---
> >>>>>>     .../bindings/connector/usb-connector.yaml      | 18 ++++++++++=
++++++++
> >>>>>>     1 file changed, 18 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-conne=
ctor.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >>>>>> index 728f82db073d..200d19c60fd5 100644
> >>>>>> --- a/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml
> >>>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml
> >>>>>> @@ -93,6 +93,24 @@ properties:
> >>>>>>           - device
> >>>>>>           - dual
> >>>>>>
> >>>>>> +  power-opmode:
> >>>>>
> >>>>> I've acked this version:
> >>>>>
> >>>>> https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com
> >>>>>
> >>>>
> >>>> frs is used for Fast Role Swap defined in USB PD spec.
> >>>> I understand it allows to get the same information but I'm wondering=
 why
> >>>> the property name is limited to -frs- in this case. What about a
> >>>> non-power delivery USB-C connector ?
> >>>
> >>> I've got no idea. The folks that know USB-C and PD details need to ge=
t
> >>> together and work all this out. To me, it looks like the same thing..=
.
> >>>
> >>
> >> It looks but...
> >>
> >> The purpose of power-opmode property is to configure the USB-C control=
lers,
> >> especially the non-PD USB-C controllers to determine the power operati=
on
> >> mode that the Type C connector will support and will advertise through=
 CC
> >> pins when it has no power delivery support, whatever the power role: S=
ink,
> >> Source or Dual
> >> The management of the property is the same that data-role and power-ro=
le
> >> properties, and done by USB Type-C Connector Class.
> >>
> >> new-source-frs-typec-current specifies initial current capability of t=
he new
> >> source when vSafe5V is applied during PD3.0 Fast Role Swap. So here, t=
his
> >> property is not applied at usb-c controller configuration level, but d=
uring
> >> PD Fast Role Swap, so when the Sink become the Source.
> >> Moreover, the related driver code says FRS can only be supported by DR=
P
> >> ports. So new-source-frs-typec-current property, in addition to being
> >> specific to PD, is also dedicated to DRP usb-c controller.
> >> The property is managed by Type-C Port Controller Manager for PD.
> >
> > But it's the same set of possible values, right? So we can align the
> > values at least.
> >
>
> USB Power Delivery FRS values are defined in
> include/dt-bindings/usb/pd.h

I think this can be changed if both can be aligned.

>to fit with drivers/usb/typec/tcpm/tcpm.c
> frs_typec_current enum.
>
> USB-C power operation mode values are defined in
> include/linux/usb/typec.h with typec_pwr_opmode enum and matching with
> string values of typec_pwr_opmodes tab.
>
> USB PD requires USB-C.
> USB-C doesn't requires USB PD.
>
> drivers/usb/typec/tcpm/tcpm.c already used typec_pwr_opmode values.
>
> USB PD specification Table 6-14 Fixed Supply PDO says:
> Fast Role Swap required USB Type-C Current (see also [USB Type-C 2.0]):
> Value | Description
>   00b  | Fast Swap not supported (default)
>   01b  | Default USB Power
>   10b  | 1.5A @ 5V
>   11b  | 3.0A @ 5V

This is the value in PDO of sink, the FRS property value(or after translate=
d)
actually is used to compare with above value.

So I think both properties can share the same "value", maybe string
like below

  10 static const char * const typec_pwr_opmodes[] =3D {
  11         [TYPEC_PWR_MODE_USB]    =3D "default",
  12         [TYPEC_PWR_MODE_1_5A]   =3D "1.5A",
  13         [TYPEC_PWR_MODE_3_0A]   =3D "3.0A",

>
> Note the *see also USB Type-C 2.0*.
>
> USB Type-C specification 4.6.2.1 USB Type-C Current says:
> The USB Type-C connector uses CC pins for configuration including an
> ability for a Source to advertise to its port partner (Sink) the amount
> of current it shall supply:
> =E2=80=A2 Default is the as-configured for high-power operation current v=
alue as
> defined by the USB Specification (500 mA for USB 2.0 ports; 900 mA or
> 1,500 mA for USB 3.2 ports in single-lane or dual-lane operation,
> respectively)
> =E2=80=A2 1.5 A
> =E2=80=A2 3.0 A
>
> > Can we align the names in some way? power-opmode and frs-source-opmode
> > or ??

how about typec-power-opmode and frs-new-source-opmode

> >
>
> I let USB PD specialists answer.
>
> *frs* property fits with USB PD specification, so with USB PD protocol.
> *power-opmode fits with USB Type-C specification, so with USB-C hardware
> support.
>
> > Are these 2 properties mutually exclusive?

I think yes.

thanks
Li Jun
>> If so, that should be
> > captured.
>
> FRS is specific to products with Power Delivery Support.
>
> power-opmode is dedicated to products with USB-C connector support.
>
> Regards,
> Amelie

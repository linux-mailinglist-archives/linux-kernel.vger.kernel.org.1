Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1772A8D5E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKFDLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:11:05 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78193C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 19:11:05 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id 52so1189672uaj.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 19:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UG3DAlH9b9Or2QNwH1ghe+WKv0N6NvDdVmlq47TlkRU=;
        b=bOII9tou5D9cYfGL+0ova6j8npZ0Bp7kHX3GTNHiNihnzfgTiiJQ9x+GzhAlFuXYS9
         3yRmfDdmWUq7sZlrNIW7uGAZmU2mu0hE7XxLirbUti0eaYM7VSooxI1TEs/FBpkPoGDw
         x2aHiW3b9UPwXKELcJ906unUzNGUngCCknlG/lrr8tOK8Xc2ec+N+GuGb3o3PUIesGqw
         9Mo/r+eLp0NNKdxE3X8orbhqOKBfzzGQP9wHMMSl4ksVygkDaYdJCfH7EwVniz+hQcLD
         evJ2JhbPHktOhGF8T+F4hROTh0Qq9lT+GJVwq4s/QEOeI+WroPdrxh8rbf+HX4EnntS4
         B7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UG3DAlH9b9Or2QNwH1ghe+WKv0N6NvDdVmlq47TlkRU=;
        b=lRxd9FMHt42c/Vb3CWysyB/r2ti+JP+fwh/YZ49Vh7ywcJF+WGJ0JBeD7tdzHtOfnU
         wzaEs/2MBkszafQpPqeyb4P6k+GpPx1tKGOgjH268xfm94GwiZmkAvcPrHRq0NETLR7u
         pKiPnGhaNuWfLahY6aul6WwdZ/aqp0btLdi/MzG5iIrXXTDKM8pzKcv4jsmRcH96OFF7
         CJzro9dzzl7PgaYPo4usUSE2tNtPohmmUbxApnhkazDQgMmXTM0/P9gp39gmxhsnYtMg
         ed32PTWzrOk/38oQRH9al8hDz5GJ8S1JC2MYteUxC9immP2+DVcg4OEThhnIrr+6thQs
         xQYg==
X-Gm-Message-State: AOAM530syozEyWS1Ab+jipnRAaV9nDT0XzLxliSt4wln9/aCp/SDfr6M
        DaySVso8tUw+XHU/PxZ3HGkM8Rj1jGPesWbW9aSGKg==
X-Google-Smtp-Source: ABdhPJzstqO6KWunaZQtlcX7azqKa/IMOm+fpiTNoBQ1xJN75OQpFGRApY+XjVotH/xO4pWK6BRfvovl74LUlbDaGDA=
X-Received: by 2002:ab0:5b55:: with SMTP id v21mr3403151uae.65.1604632264237;
 Thu, 05 Nov 2020 19:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com> <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com> <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
 <ebccf61a-c88f-c7f4-9f06-01d2bd1f43de@st.com> <20201104210803.GA4115079@bogus>
 <2da804ff-3b3c-0ea9-14d5-a163b28ccc33@st.com> <CAKgpwJU_yTTYabeMYFBqNs_6=N7gaTAc1v-+fU-dshFUrL1qVA@mail.gmail.com>
 <CAL_JsqJUVRRD=j6FTFUgUuhfLkGe5WRex+gj7N6wvu-DbwL+bA@mail.gmail.com>
In-Reply-To: <CAL_JsqJUVRRD=j6FTFUgUuhfLkGe5WRex+gj7N6wvu-DbwL+bA@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 5 Nov 2020 19:10:27 -0800
Message-ID: <CAPTae5JtpRS11FxsYE4wLFoM=fng__v8wEWMtyCJqiqrgS5SmA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Rob Herring <robh@kernel.org>
Cc:     Jun Li <lijun.kernel@gmail.com>,
        Amelie DELAUNAY <amelie.delaunay@st.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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

Hi Rob and Amelie,

With regards to discussions in this thread,
For https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com,
I can send in a patch to update the new-source-frs-typec-current property.
Amelie, If you are already planning to send that I am fine with that as wel=
l.
Let me know !

To summarize the changes for new-source-frs-typec-current would be,
1. Rename to frs-new-source-opmode
2. Use string values instead of u32 similar to typec-power-opmode.
Are these correct ?

Thanks,
Badhri

On Thu, Nov 5, 2020 at 7:55 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 5, 2020 at 6:24 AM Jun Li <lijun.kernel@gmail.com> wrote:
> >
> > Amelie DELAUNAY <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=
=885=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:36=E5=86=99=E9=81=93=EF=
=BC=9A
> > >
> > > On 11/4/20 10:08 PM, Rob Herring wrote:
> > > > On Fri, Oct 30, 2020 at 04:27:14PM +0100, Amelie DELAUNAY wrote:
> > > >>
> > > >>
> > > >> On 10/30/20 3:29 PM, Rob Herring wrote:
> > > >>> On Thu, Oct 29, 2020 at 11:49 AM Amelie DELAUNAY <amelie.delaunay=
@st.com> wrote:
> > > >>>>
> > > >>>>
> > > >>>>
> > > >>>> On 10/29/20 4:40 PM, Rob Herring wrote:
> > > >>>>> On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote=
:
> > > >>>>>> Power operation mode may depends on hardware design, so, add t=
he optional
> > > >>>>>> property power-opmode for usb-c connector to select the power =
operation
> > > >>>>>> mode capability.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > > >>>>>> ---
> > > >>>>>>     .../bindings/connector/usb-connector.yaml      | 18 ++++++=
++++++++++++
> > > >>>>>>     1 file changed, 18 insertions(+)
> > > >>>>>>
> > > >>>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-c=
onnector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.y=
aml
> > > >>>>>> index 728f82db073d..200d19c60fd5 100644
> > > >>>>>> --- a/Documentation/devicetree/bindings/connector/usb-connecto=
r.yaml
> > > >>>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connecto=
r.yaml
> > > >>>>>> @@ -93,6 +93,24 @@ properties:
> > > >>>>>>           - device
> > > >>>>>>           - dual
> > > >>>>>>
> > > >>>>>> +  power-opmode:
> > > >>>>>
> > > >>>>> I've acked this version:
> > > >>>>>
> > > >>>>> https://lore.kernel.org/r/20201020093627.256885-2-badhri@google=
.com
> > > >>>>>
> > > >>>>
> > > >>>> frs is used for Fast Role Swap defined in USB PD spec.
> > > >>>> I understand it allows to get the same information but I'm wonde=
ring why
> > > >>>> the property name is limited to -frs- in this case. What about a
> > > >>>> non-power delivery USB-C connector ?
> > > >>>
> > > >>> I've got no idea. The folks that know USB-C and PD details need t=
o get
> > > >>> together and work all this out. To me, it looks like the same thi=
ng...
> > > >>>
> > > >>
> > > >> It looks but...
> > > >>
> > > >> The purpose of power-opmode property is to configure the USB-C con=
trollers,
> > > >> especially the non-PD USB-C controllers to determine the power ope=
ration
> > > >> mode that the Type C connector will support and will advertise thr=
ough CC
> > > >> pins when it has no power delivery support, whatever the power rol=
e: Sink,
> > > >> Source or Dual
> > > >> The management of the property is the same that data-role and powe=
r-role
> > > >> properties, and done by USB Type-C Connector Class.
> > > >>
> > > >> new-source-frs-typec-current specifies initial current capability =
of the new
> > > >> source when vSafe5V is applied during PD3.0 Fast Role Swap. So her=
e, this
> > > >> property is not applied at usb-c controller configuration level, b=
ut during
> > > >> PD Fast Role Swap, so when the Sink become the Source.
> > > >> Moreover, the related driver code says FRS can only be supported b=
y DRP
> > > >> ports. So new-source-frs-typec-current property, in addition to be=
ing
> > > >> specific to PD, is also dedicated to DRP usb-c controller.
> > > >> The property is managed by Type-C Port Controller Manager for PD.
> > > >
> > > > But it's the same set of possible values, right? So we can align th=
e
> > > > values at least.
> > > >
> > >
> > > USB Power Delivery FRS values are defined in
> > > include/dt-bindings/usb/pd.h
> >
> > I think this can be changed if both can be aligned.
> >
> > >to fit with drivers/usb/typec/tcpm/tcpm.c
> > > frs_typec_current enum.
> > >
> > > USB-C power operation mode values are defined in
> > > include/linux/usb/typec.h with typec_pwr_opmode enum and matching wit=
h
> > > string values of typec_pwr_opmodes tab.
> > >
> > > USB PD requires USB-C.
> > > USB-C doesn't requires USB PD.
> > >
> > > drivers/usb/typec/tcpm/tcpm.c already used typec_pwr_opmode values.
> > >
> > > USB PD specification Table 6-14 Fixed Supply PDO says:
> > > Fast Role Swap required USB Type-C Current (see also [USB Type-C 2.0]=
):
> > > Value | Description
> > >   00b  | Fast Swap not supported (default)
> > >   01b  | Default USB Power
> > >   10b  | 1.5A @ 5V
> > >   11b  | 3.0A @ 5V
> >
> > This is the value in PDO of sink, the FRS property value(or after trans=
lated)
> > actually is used to compare with above value.
> >
> > So I think both properties can share the same "value", maybe string
> > like below
> >
> >   10 static const char * const typec_pwr_opmodes[] =3D {
> >   11         [TYPEC_PWR_MODE_USB]    =3D "default",
> >   12         [TYPEC_PWR_MODE_1_5A]   =3D "1.5A",
> >   13         [TYPEC_PWR_MODE_3_0A]   =3D "3.0A",
> >
> > >
> > > Note the *see also USB Type-C 2.0*.
> > >
> > > USB Type-C specification 4.6.2.1 USB Type-C Current says:
> > > The USB Type-C connector uses CC pins for configuration including an
> > > ability for a Source to advertise to its port partner (Sink) the amou=
nt
> > > of current it shall supply:
> > > =E2=80=A2 Default is the as-configured for high-power operation curre=
nt value as
> > > defined by the USB Specification (500 mA for USB 2.0 ports; 900 mA or
> > > 1,500 mA for USB 3.2 ports in single-lane or dual-lane operation,
> > > respectively)
> > > =E2=80=A2 1.5 A
> > > =E2=80=A2 3.0 A
> > >
> > > > Can we align the names in some way? power-opmode and frs-source-opm=
ode
> > > > or ??
> >
> > how about typec-power-opmode and frs-new-source-opmode
>
> Sure.
>
> >
> > > >
> > >
> > > I let USB PD specialists answer.
> > >
> > > *frs* property fits with USB PD specification, so with USB PD protoco=
l.
> > > *power-opmode fits with USB Type-C specification, so with USB-C hardw=
are
> > > support.
> > >
> > > > Are these 2 properties mutually exclusive?
> >
> > I think yes.
>
> This should work to express that:
>
> allOf:
>   - not:
>       required:
>         - typec-power-opmode
>         - frs-new-source-opmode
>
> Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7096B2A07EB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJ3Ocg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3Ocg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:32:36 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACE820637;
        Fri, 30 Oct 2020 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604068355;
        bh=H73aTFe9brejPhv93HXkvU3N5qlIm5iZsJBrgXyq5lE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lN74zVv+y0LBSHf4rqFdraGgS8IsYFsifgokwyPkvmhZM55UCiMlrIHfZCg1QVVgU
         o9cBQDDIypBFmI+kl3cU8EVY1agALeA8QRQln0r1KkgLuzHVsIyXbLhhl0zaPte5L3
         xp79GoUiFbPxrvKlG0Qw73+iTpB9MyUMSFvjLnCw=
Received: by mail-ot1-f44.google.com with SMTP id m22so5721796ots.4;
        Fri, 30 Oct 2020 07:32:35 -0700 (PDT)
X-Gm-Message-State: AOAM532+AooKztQEgVi3e6L5o9Hxz8J87AWONyyFMDbMqyt8XAJsIdGa
        24psNRFQ0Nny5Rc/s0mKzVb89byBC02pYDvrDg==
X-Google-Smtp-Source: ABdhPJw0/hZSGq4gZvXd4rAw3DV98IaGIIMxB5UmNkdeNZ6nvaElNZ6SNe1QYlhyoHVF6qp+lB3fHjsIxLDfBIhsRlU=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr1974117otk.192.1604068354225;
 Fri, 30 Oct 2020 07:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com> <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com> <CAKgpwJVGUR9aSfoMkQ=ZXysgqn+H6n0uJbk5W9SeGiB7VXptwQ@mail.gmail.com>
In-Reply-To: <CAKgpwJVGUR9aSfoMkQ=ZXysgqn+H6n0uJbk5W9SeGiB7VXptwQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Oct 2020 09:32:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLbuNTnonH2SqcmF5YF_EB4gTQdS6L3yFKF9pJmaypdKg@mail.gmail.com>
Message-ID: <CAL_JsqLbuNTnonH2SqcmF5YF_EB4gTQdS6L3yFKF9pJmaypdKg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     Amelie DELAUNAY <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
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

On Thu, Oct 29, 2020 at 8:55 PM Jun Li <lijun.kernel@gmail.com> wrote:
>
> Amelie DELAUNAY <amelie.delaunay@st.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> >
> >
> > On 10/29/20 4:40 PM, Rob Herring wrote:
> > > On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
> > >> Power operation mode may depends on hardware design, so, add the opt=
ional
> > >> property power-opmode for usb-c connector to select the power operat=
ion
> > >> mode capability.
> > >>
> > >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > >> ---
> > >>   .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++=
++++
> > >>   1 file changed, 18 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/connector/usb-connect=
or.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > >> index 728f82db073d..200d19c60fd5 100644
> > >> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > >> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > >> @@ -93,6 +93,24 @@ properties:
> > >>         - device
> > >>         - dual
> > >>
> > >> +  power-opmode:
> > >
> > > I've acked this version:
> > >
> > > https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com
>
> That is a different property only for FRS.
>
> > >
> >
> > frs is used for Fast Role Swap defined in USB PD spec.
> > I understand it allows to get the same information but I'm wondering wh=
y
> > the property name is limited to -frs- in this case. What about a
> > non-power delivery USB-C connector ?
>
> It's only for FRS, FRS is in the scope of power delivery.
>
> >
> > Moreover, power-opmode property support is already merged in typec clas=
s:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/usb/typec/class.c?h=3Dv5.10-rc1&id=3D12f3467b0d28369d3add7a0deb6=
5fdac9b503c90
> > and stusb160x driver uses it :(
> >
> > So, do I need to modify stusb160x driver (and bindings) to take into
> > account this USB PD specific property?
>
> Only Type-C w/o PD need this "power-opmode" property, so this
> property is still required.

Yet we have the same set of values. So there's something common...

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E448293863
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403823AbgJTJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403799AbgJTJn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:43:58 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CDC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:43:58 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id i62so345432vkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjdyFK6+77JSWhbhdO2ZuxNLLPayu81xI0vhP8ntxQg=;
        b=La4o7i2OJsXMD4q5xRA5hBGQ5Qm6dQDBPA6bArJvJ43aVe8GWjIxy8b7M1LH8agwSG
         kljQUdppVQQXxJBGFVQEfCX0oVR6VA2JLx0HGKeQNmgNYUfBysfQbrIN97E89/8LXYgY
         XqEuBEJxClQrOnk7OaiwLtikTTRgUkeO1xPCUwtrv2iEew5a8CV39kopu6qQ6QoWKbch
         +dAhoYoSWkeZHcMufzoBgR5DKBz6/HsobzkejfOs8ktw6pvybqwR9fH/Non/Ho92Rq89
         KnDXdq62t4AgQM9L7+8dau1A4RGG5V1RU8sCF/XrKXvrN5aSIe7AT2sO5T4nTKyE5FiT
         d6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjdyFK6+77JSWhbhdO2ZuxNLLPayu81xI0vhP8ntxQg=;
        b=A3EQBSAYmj5MN4WBhUsyV/oe/K3yd7HBN8HkkCsdOaWUXPIDmsiTrVtEknBYYUoYXy
         g8um2/jwawQ/KKo6QMxt3NJDmokDh3d4UXdNwDkb9hUS7Ze/5wqoZOcYGKWy3jKSsri/
         1VToVKLOBcacwiqfmByfGVIR7VwWazjTLUjVrC9yB/wTMeThg4YsfMBnSYhZfsGtQ03D
         2uJghpk6WtuRrd7YWYY/NrYC8T9gvBFFF2ISEgdjusyqx6sv3QfZJrhlxBx0SObAjRtq
         ixjQGw6lCLuPSgDAP98FQ7FbM5/Pxh5H+ohvwz9fFJsxAYQ7Iv3gxf++TfmIFzT1EK1p
         mWiw==
X-Gm-Message-State: AOAM5310+o2oYn2JVYyoLmypv61MeX8TeuWSkad7eo0+8YJBhdoLHHkm
        0G94X05tvKucDwhCwotOGg/V8BjiWiFr+TpsR91osA==
X-Google-Smtp-Source: ABdhPJzkuNHgpTCH+/hhwKeV4xliCj2/L+Rcgp4UrCsWbP2a8i4WMUdSDm0bzpFM+VfJlMqNfnN2DaanwcokO38O5x0=
X-Received: by 2002:a1f:38cb:: with SMTP id f194mr837808vka.22.1603187036941;
 Tue, 20 Oct 2020 02:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com> <20200929024004.244992-6-badhri@google.com>
 <20201006182940.GA2574941@bogus> <CAPTae5L6UFGNJ0pxxfFAS3=KDNDVU-WDW-OHk6prLStbe+EaOQ@mail.gmail.com>
 <CAL_JsqKxW9BeFQGsLqa-ZRurR8gDDrTSaDYs=mj7TYtF9ZDiYQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKxW9BeFQGsLqa-ZRurR8gDDrTSaDYs=mj7TYtF9ZDiYQ@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 20 Oct 2020 02:43:20 -0700
Message-ID: <CAPTae5LiTmgH+Nn7L3y47oy-QkZBSusq3aqwGvt=dYy7_dbQhw@mail.gmail.com>
Subject: Re: [PATCH v9 05/15] dt-bindings: connector: Add property to set
 initial current cap for FRS
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 7:16 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 7, 2020 at 8:07 PM Badhri Jagan Sridharan <badhri@google.com> wrote:
> >
> > On Tue, Oct 6, 2020 at 11:29 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 07:39:54PM -0700, Badhri Jagan Sridharan wrote:
> > > > This change adds frs-typec-current which allows setting the initial current
> > > > capability of the new source when vSafe5V is applied during PD3.0
> > > > sink Fast Role Swap.
> > >
> > > Shouldn't you Cc the person you copied this from?
> > Not sure whether I get this comment. The patch wasn't copied. Maybe you were
> > expecting me to CC amelie.delaunay@st.com ? if so, just now CC'ed.
> >
> > >
> > >
> > > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > > ---
> > > > Changes since v1:
> > > > - Changing patch version to v6 to fix version number confusion.
> > > >
> > > > Changes since v6:
> > > > - Removed the redundant usb-connector.txt that I created by mistake.
> > > > - Moved to yaml.
> > > >
> > > > Changes since v7:
> > > > - Rebase
> > > >
> > > > Changes since v8:
> > > > - Redefine new-source-frs-typec-current as string enums to address
> > > >   Rob Herring's comment.
> > > > ---
> > > >  .../bindings/connector/usb-connector.yaml     | 26 +++++++++++++++++++
> > > >  include/dt-bindings/usb/pd.h                  | 10 +++++++
> > > >  2 files changed, 36 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > index 9bd52e63c935..0b8cd08a8678 100644
> > > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > @@ -142,6 +142,32 @@ properties:
> > > >      required:
> > > >        - port@0
> > > >
> > > > +  new-source-frs-typec-current:
> > > > +    description: Initial current capability of the new source when vSafe5V
> > > > +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
> > > > +      of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
> > > > +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
> > > > +      provides a detailed description of the field. The sink PDO from current source
> > > > +      reflects the current source's(i.e. transmitter of the FRS signal) power
> > > > +      requirement during fr swap. The current sink (i.e. receiver of the FRS signal),
> > > > +      a.k.a new source, should check if it will be able to satisfy the current source's,
> > > > +      new sink's, requirement during frswap before enabling the frs signal reception.
> > > > +      This property refers to maximum current capability that the current sink can
> > > > +      satisfy. During FRS, VBUS voltage is at 5V, as the partners are in implicit
> > > > +      contract, hence, the power level is only a function of the current capability.
> > > > +      "not-supported" implies sink to source fast role swap not supported.
> > > > +      "default" refers to default USB power level as described by
> > > > +      "Table 6-14 Fixed Supply PDO - Sink".
> > > > +      "1.5A" refers to 1.5A@5V.
> > > > +      "3.0A" refers to 3.0A@5V.
> > >
> > >
> > > > +
> > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > +    enum:
> > > > +      - not-supported
> > > > +      - default
> > > > +      - 1.5A
> > > > +      - 3.0A
> > >
> > > What happens if the property is not present?
> >
> > The behavior would be the same as "not-supported".
>
> Then you don't need 'not-supported'.
>
> >
> > >
> > > I'm not crazy about mixing strings and what could be a number.
> >
> > v8 version[1] of the patch was using uint32. I moved to using strings
> > as you were asking to unify with the approach in [2]. Since [3] was using
> > string enums, I moved to that. I don't have a strong preference here, so
> > I can move back to using u32 if you feel so.
>
> Since the u32 values are based on the USB spec, I think I prefer that.
> Should be easier to deal with in the driver than doing strcmp's.
Done. Sent out as v11 of the patch.

Thanks,
Badhri

>
> Rob

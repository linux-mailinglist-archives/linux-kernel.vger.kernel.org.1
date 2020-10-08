Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE483286C53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 03:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgJHBHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 21:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgJHBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 21:07:36 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA7C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 18:07:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s15so2200632vsm.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 18:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcjrPBqEOw4bZNkJr5mtnvKCnpXPa719CXuFi0/dSbw=;
        b=X9+1gB4sf2oEkvm6r11MSkiG3Vfdqew3uHoECXF0M4T5jmSXn4Zg92EN+z10WSBM5G
         vRZ9Srx9LfXCZtMs7VIL4ixLoBaMKrSZhTGjesxkrcA6HlR141jQ/sDiHsEVwrGi9eiH
         TGN0RkrA9PzeGodv9O4yts3/6B324XU6uHTB7/9Aybi4nn6f4CpuOmj4CbFDrpiVHyoE
         kwCAH2xz9+CdYZSTzm4TCgh1PPv5dQk21nOOXGs6+9spLM+C5FLu8joTtu7vfE5KLn35
         IVkeTn2gdD2EVK6m51KzPfVjDmlYdKPEzYJb/R8np4BRQawbJhscihoCkdfa9lC7LrU+
         +PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcjrPBqEOw4bZNkJr5mtnvKCnpXPa719CXuFi0/dSbw=;
        b=Wl2DOoPIjRC8jLlG0HfOTUmeUnHHOzrQ39aGP7kR+DbdUWvd+EcsWIqgX6TKRT7nNk
         NKx4SsdEDRmPGlaVO0fDkkDAMaCNyyTZbKCBGQ5K+jVIE6OPEcTgsgfK6pg05r+0YBJ/
         0X1xHkN9N44KaRngYJIK8vzIoi6/rocLTfA7BL3+tksMQtqLHAZShpfhjZhydSctRVtO
         BbdpVDI2tFXZp43RscihHbVo4NUCaTyD4rxhbrPiG7hc2zQdaW+DSHLkQhU6y3FEPLH/
         2+/KJNiG6pQu+ezx5r3i0r4Fne+kzxmshodKDsrjnI5E2/cri9ZAI7d3YgH2KiCt7D24
         KC7w==
X-Gm-Message-State: AOAM531u0CxrEZSZFRnWZ6O62N4RP5QcQWROraoXf40RkttwRnAZH1uB
        zbcm80cbJuuR+EkP8ZPSEx0H+NSWKOg6xN0GvbXDWtbA3HiBCw==
X-Google-Smtp-Source: ABdhPJwV6R8bITrE+2J2VWs6IAAqcQo4nj0Qa+3Mjo3n1bp+ptKf/KUAbYc09VokExpVDm5cqZ3f1WFkg6oEy/rOVtg=
X-Received: by 2002:a67:f50a:: with SMTP id u10mr3587205vsn.43.1602119254754;
 Wed, 07 Oct 2020 18:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com> <20200929024004.244992-6-badhri@google.com>
 <20201006182940.GA2574941@bogus>
In-Reply-To: <20201006182940.GA2574941@bogus>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 7 Oct 2020 18:06:58 -0700
Message-ID: <CAPTae5L6UFGNJ0pxxfFAS3=KDNDVU-WDW-OHk6prLStbe+EaOQ@mail.gmail.com>
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

On Tue, Oct 6, 2020 at 11:29 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Sep 28, 2020 at 07:39:54PM -0700, Badhri Jagan Sridharan wrote:
> > This change adds frs-typec-current which allows setting the initial current
> > capability of the new source when vSafe5V is applied during PD3.0
> > sink Fast Role Swap.
>
> Shouldn't you Cc the person you copied this from?
Not sure whether I get this comment. The patch wasn't copied. Maybe you were
expecting me to CC amelie.delaunay@st.com ? if so, just now CC'ed.

>
>
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > Changes since v1:
> > - Changing patch version to v6 to fix version number confusion.
> >
> > Changes since v6:
> > - Removed the redundant usb-connector.txt that I created by mistake.
> > - Moved to yaml.
> >
> > Changes since v7:
> > - Rebase
> >
> > Changes since v8:
> > - Redefine new-source-frs-typec-current as string enums to address
> >   Rob Herring's comment.
> > ---
> >  .../bindings/connector/usb-connector.yaml     | 26 +++++++++++++++++++
> >  include/dt-bindings/usb/pd.h                  | 10 +++++++
> >  2 files changed, 36 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > index 9bd52e63c935..0b8cd08a8678 100644
> > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > @@ -142,6 +142,32 @@ properties:
> >      required:
> >        - port@0
> >
> > +  new-source-frs-typec-current:
> > +    description: Initial current capability of the new source when vSafe5V
> > +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
> > +      of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
> > +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
> > +      provides a detailed description of the field. The sink PDO from current source
> > +      reflects the current source's(i.e. transmitter of the FRS signal) power
> > +      requirement during fr swap. The current sink (i.e. receiver of the FRS signal),
> > +      a.k.a new source, should check if it will be able to satisfy the current source's,
> > +      new sink's, requirement during frswap before enabling the frs signal reception.
> > +      This property refers to maximum current capability that the current sink can
> > +      satisfy. During FRS, VBUS voltage is at 5V, as the partners are in implicit
> > +      contract, hence, the power level is only a function of the current capability.
> > +      "not-supported" implies sink to source fast role swap not supported.
> > +      "default" refers to default USB power level as described by
> > +      "Table 6-14 Fixed Supply PDO - Sink".
> > +      "1.5A" refers to 1.5A@5V.
> > +      "3.0A" refers to 3.0A@5V.
>
>
> > +
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum:
> > +      - not-supported
> > +      - default
> > +      - 1.5A
> > +      - 3.0A
>
> What happens if the property is not present?

The behavior would be the same as "not-supported".

>
> I'm not crazy about mixing strings and what could be a number.

v8 version[1] of the patch was using uint32. I moved to using strings
as you were asking to unify with the approach in [2]. Since [3] was using
string enums, I moved to that. I don't have a strong preference here, so
I can move back to using u32 if you feel so.

[1] https://lore.kernel.org/linux-usb/20200921195555.1050731-5-badhri@google.com/
[2] https://lore.kernel.org/linux-usb/CAPTae5+Pe1m=TUhmPJY91eJbP+B6UroqBo3u7m0AC8YS1WPu9g@mail.gmail.com/
[3] https://lore.kernel.org/linux-arm-kernel/20200902075707.9052-2-amelie.delaunay@st.com/

>
> > +
> >  required:
> >    - compatible
> >
> > diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> > index 985f2bbd4d24..db1ad4532197 100644
> > --- a/include/dt-bindings/usb/pd.h
> > +++ b/include/dt-bindings/usb/pd.h
> > @@ -35,6 +35,16 @@
> >
> >  #define VSAFE5V 5000 /* mv units */
> >
> > +/*
> > + * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
> > + * Version 1.2"
> > + * Initial current capability of the new source when vSafe5V is applied.
> > + */
> > +#define FRS_NOT_SUPPORTED    0
> > +#define FRS_DEFAULT_POWER    1
> > +#define FRS_5V_1P5A          2
> > +#define FRS_5V_3A            3
>
> Why are these in a DT header, but not used by the binding? Though
This is a mistake on my part. v8 of the patch which had
new-source-frs-typec-current
defined as uint32 were making use of these constants. Now that
new-source-frs-typec-current
is a string, these constants dont have any more significance in the binding.
Will remove in the next version of the patch.

> perhaps they should be. Are these numbers from the spec or made up?
Yes they are from the spec and are from "Table 6-14 Fixed Supply PDO - Sink"
of "USB Power Delivery Specification Revision 3.0, Version 1.2". Not made up.

>
> > +
> >  #define PDO_BATT_MAX_VOLT_SHIFT      20      /* 50mV units */
> >  #define PDO_BATT_MIN_VOLT_SHIFT      10      /* 50mV units */
> >  #define PDO_BATT_MAX_PWR_SHIFT       0       /* 250mW units */
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >

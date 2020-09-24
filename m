Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80A276E41
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIXKJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgIXKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:09:49 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9003FC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:09:49 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id w25so1758509vsk.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kn2+qFRHRQOFTB6gfC/64B7vTCRTjfTNnHcSfiSmojw=;
        b=VYMiEvadE+WuOWqt/EcqxrrkP8QD00ZygSDrvjt8aoyL8sIU14aJa05m1iQk5pz9Iu
         O8Uh26VAivvoQQqERo8dTYKRAMe1oE9ANoleiHjeO/6lI9plFqHWisfmKJ2pfVTJJvUm
         Sxr9Sy2h8nHmMXDPxOqiB5s03zHnvUo0DUU+DliKpbTSbkcfIsNFoUyxBrVNpXGNZ1VE
         4d86O5wmvGzZWf7ruyX1pCA2FA7mtxp46VXPMS00t5OB5nQc75OgfnIj36idQ8J5TejF
         5MPNR1U3AUr+I++LcNQ1jBS0M+l/xRYg9vac3IMvtUNPMu1+NxnEpToZr6/TPdReMmkS
         4lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kn2+qFRHRQOFTB6gfC/64B7vTCRTjfTNnHcSfiSmojw=;
        b=MrUczAK3sSu5vgtzkHSaOtHuzggmDfZGUKX8/YF0ZroBqTdiZ8eUX9xBCKw/cZOmPy
         6OJXFwMDh3ewJATQQedbON2Anla2HAW0cTwhizaAC/avGLv+y3ghoCv4ZpaOrc/iCpPf
         1M2/OhQoz6PeLyMwuzkF4hQDbZoOAv+9vQAyMnoQJrUEhbLSksysDMdSMpBEwopA2Ylq
         P5uYEgKqb9pj0CxjPEerai9bLhzl9+Y2OiNmjmxbWRoUHqaKN9/k70gImrGjlKO+G/6d
         Bi9w5n51BornCF+mdiJHE/hb90VhtsAouKYHIgjVgx8S6AgZOn6lC9BSG76LANyKQRQe
         BckA==
X-Gm-Message-State: AOAM532EL69XeZDuvyuGJWPBLVRbPiI1lV3XMLZhjVdvclQasJ0Pztk5
        ryOAot0UOomLUeIeNUC2+NKX9Q6xKIc18HKon3iFhg==
X-Google-Smtp-Source: ABdhPJySvYeu90LKO46pZkw8wIQQ250ltBHpKKI1sljR9Dq4TQ44KVfWZV5qMGz+JOJRF1qnnK/GgYtvbzAbI4fPQ8E=
X-Received: by 2002:a67:e3d4:: with SMTP id k20mr2925429vsm.60.1600942188382;
 Thu, 24 Sep 2020 03:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200921195555.1050731-1-badhri@google.com> <20200921195555.1050731-5-badhri@google.com>
 <CAKgpwJUqfyZv1+-A4R8R--O-u2R65T+VUxL6PtW4c6kG0FJWfg@mail.gmail.com>
In-Reply-To: <CAKgpwJUqfyZv1+-A4R8R--O-u2R65T+VUxL6PtW4c6kG0FJWfg@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 24 Sep 2020 03:09:12 -0700
Message-ID: <CAPTae5LcTqoc52C01rQjL9NzA5Yh=NH0zvvJNosih8n2kMTn+A@mail.gmail.com>
Subject: Re: [PATCH v8 05/11] dt-bindings: connector: Add property to set
 initial current cap for FRS
To:     Jun Li <lijun.kernel@gmail.com>
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

Hi Jun,

Thanks for the feedback !
The sink PDO from current source reflects the current source's(i.e.
transmitter of the FRS signal) power requirement during fr swap.
The current sink (i.e. receiver of the FRS signal) should check if it
will be able to satisfy the current source's
requirement during frswap before enabling the frs signal reception.
The property in this patch refers to maximum current capability
that the current sink can satisfy. Perhaps, I should name it
sink-frs-typec-current. Does that make sense to you ?

Thanks,
Badhri

On Wed, Sep 23, 2020 at 3:43 AM Jun Li <lijun.kernel@gmail.com> wrote:
>
> Badhri Jagan Sridharan <badhri@google.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=
=8822=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:57=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > This change adds frs-typec-current which allows setting the initial cur=
rent
> > capability of the new source when vSafe5V is applied during PD3.0
> > sink Fast Role Swap.
> >
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
> > ---
> >  .../devicetree/bindings/connector/usb-connector.yaml   |  8 ++++++++
> >  include/dt-bindings/usb/pd.h                           | 10 ++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.=
yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > index 9bd52e63c935..1ca8e6a337e5 100644
> > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > @@ -142,6 +142,14 @@ properties:
> >      required:
> >        - port@0
> >
> > +  frs-typec-current:
> > +    description: Initial current capability of the new source when vSa=
fe5V
> > +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply=
 PDO - Sink"
> > +      of "USB Power Delivery Specification Revision 3.0, Version 1.2" =
provides the
> > +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-=
C Current"
> > +      provides a detailed description of the field.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> If it's a part of sink PDO, I think you don't need a new property for thi=
s, just
> define it directly into sink-pdos by adding a new PDO define for PD 3.0,
> something like:
>
> sink-pdos =3D <PDO_FIXED_v3(5000, 3000, PDO_FIXED_USB_COMM, FRS_CURRENT_1=
P5A)>;
>
> Li Jun
> > +
> >  required:
> >    - compatible
> >
> > diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.=
h
> > index 985f2bbd4d24..db1ad4532197 100644
> > --- a/include/dt-bindings/usb/pd.h
> > +++ b/include/dt-bindings/usb/pd.h
> > @@ -35,6 +35,16 @@
> >
> >  #define VSAFE5V 5000 /* mv units */
> >
> > +/*
> > + * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Deliver=
y Specification Revision 3.0,
> > + * Version 1.2"
> > + * Initial current capability of the new source when vSafe5V is applie=
d.
> > + */
> > +#define FRS_NOT_SUPPORTED      0
> > +#define FRS_DEFAULT_POWER      1
> > +#define FRS_5V_1P5A            2
> > +#define FRS_5V_3A              3
> > +
> >  #define PDO_BATT_MAX_VOLT_SHIFT        20      /* 50mV units */
> >  #define PDO_BATT_MIN_VOLT_SHIFT        10      /* 50mV units */
> >  #define PDO_BATT_MAX_PWR_SHIFT 0       /* 250mW units */
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >

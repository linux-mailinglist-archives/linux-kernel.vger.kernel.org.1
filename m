Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B044E275691
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIWKn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:43:25 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F5C0613CE;
        Wed, 23 Sep 2020 03:43:25 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id w25so2792743vsk.9;
        Wed, 23 Sep 2020 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gEMIbVXla8ei6LvM6PCuNE9og9ukk6dC+Bnjd4IkIyY=;
        b=vGunRZh6u7CNnttPXSH/AboifZCgmN2QnPWtVk8JCX7cNpRbav50woJ5L+97gI6Q4B
         BiAUgwTq+TBYRm7y8gsr8TVGbAUlk2Pt6KSOOYZIyyEXlJ4R1JU2JDaLUYPGwSwsAF/B
         JU0iiIVB6lAQ3FEgH17QiQAhqZi2dHMF4jA4st/b/yDAUcPLlvSG2f/atnO2l0p3flms
         QUbKz763u+OC9nnridN9YsCj7mXPP51EQ7U7fBxXcBYywIQ7OvT/Mu+t16SdhH4ZBpiq
         GRnViPRho2jSOB2h9UL28kzZsJM5A7cwXtS3bUzym5k7zwNDGdkL66pTuEcwa/CFDsg0
         eHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gEMIbVXla8ei6LvM6PCuNE9og9ukk6dC+Bnjd4IkIyY=;
        b=YEkM5/heiF0Xuz2+ImB81hhobm7EC2sejxghIlAiu2BoESMkYCK8aBf51t3jYpfATb
         /RQ3yzzwvVA11dhBEi33dnhc6CbrmrNq3JdjlBhivVrzim1QgFJk5p8pPYZ7dMC9HrWT
         QoGRJw4ody8KmGhPpXFEuc3M9WWuGs7Lac2bkWoroKIE/L6e9rkQB+TeJbtGlivA2O5h
         vH26VdXuW3UKiHptEK73PCDrBU2iJI8awxDFSEtJ4PSIyDLjTBPGd9Vo6DWnn/jB4pv3
         PVRNB8xGtasCe5sEpZ3uR3IbO/+W0CAfHb1bdbc3c3m2GzAMCDEp8UhonagwLVEx/J2q
         bCnQ==
X-Gm-Message-State: AOAM531MhIFrx57lFT6lhoGpSoTzkE1jf/8qZNnBl0cWGvvMtGGXv+7s
        mkQuLJgJAkfrX6ejRth87czZWa/OMA+0lonZdjt12qRg2rE=
X-Google-Smtp-Source: ABdhPJzAkp8jdmqE/qYITYxa7oMpfKc2cFMT24MTk3/33cHIoYMS+6W7in9LvX6twRStWw4I0kK7ucdfUNxH5bjiYjE=
X-Received: by 2002:a67:8b45:: with SMTP id n66mr6360345vsd.45.1600857804831;
 Wed, 23 Sep 2020 03:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921195555.1050731-1-badhri@google.com> <20200921195555.1050731-5-badhri@google.com>
In-Reply-To: <20200921195555.1050731-5-badhri@google.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 23 Sep 2020 18:43:13 +0800
Message-ID: <CAKgpwJUqfyZv1+-A4R8R--O-u2R65T+VUxL6PtW4c6kG0FJWfg@mail.gmail.com>
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
22=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:57=E5=86=99=E9=81=93=EF=
=BC=9A
>
> This change adds frs-typec-current which allows setting the initial curre=
nt
> capability of the new source when vSafe5V is applied during PD3.0
> sink Fast Role Swap.
>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Changing patch version to v6 to fix version number confusion.
>
> Changes since v6:
> - Removed the redundant usb-connector.txt that I created by mistake.
> - Moved to yaml.
>
> Changes since v7:
> - Rebase
> ---
>  .../devicetree/bindings/connector/usb-connector.yaml   |  8 ++++++++
>  include/dt-bindings/usb/pd.h                           | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 9bd52e63c935..1ca8e6a337e5 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -142,6 +142,14 @@ properties:
>      required:
>        - port@0
>
> +  frs-typec-current:
> +    description: Initial current capability of the new source when vSafe=
5V
> +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply P=
DO - Sink"
> +      of "USB Power Delivery Specification Revision 3.0, Version 1.2" pr=
ovides the
> +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C =
Current"
> +      provides a detailed description of the field.
> +    $ref: /schemas/types.yaml#/definitions/uint32

If it's a part of sink PDO, I think you don't need a new property for this,=
 just
define it directly into sink-pdos by adding a new PDO define for PD 3.0,
something like:

sink-pdos =3D <PDO_FIXED_v3(5000, 3000, PDO_FIXED_USB_COMM, FRS_CURRENT_1P5=
A)>;

Li Jun
> +
>  required:
>    - compatible
>
> diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
> index 985f2bbd4d24..db1ad4532197 100644
> --- a/include/dt-bindings/usb/pd.h
> +++ b/include/dt-bindings/usb/pd.h
> @@ -35,6 +35,16 @@
>
>  #define VSAFE5V 5000 /* mv units */
>
> +/*
> + * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery =
Specification Revision 3.0,
> + * Version 1.2"
> + * Initial current capability of the new source when vSafe5V is applied.
> + */
> +#define FRS_NOT_SUPPORTED      0
> +#define FRS_DEFAULT_POWER      1
> +#define FRS_5V_1P5A            2
> +#define FRS_5V_3A              3
> +
>  #define PDO_BATT_MAX_VOLT_SHIFT        20      /* 50mV units */
>  #define PDO_BATT_MIN_VOLT_SHIFT        10      /* 50mV units */
>  #define PDO_BATT_MAX_PWR_SHIFT 0       /* 250mW units */
> --
> 2.28.0.681.g6f77f65b4e-goog
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A3228A845
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbgJKQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbgJKQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 12:38:55 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193EC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 09:38:54 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id x20so11479564ybs.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRGrsGIuHpsCfKgbLO01uLpvEDCDM1u1XXLG6rg/fA8=;
        b=bvlPXmeK/qf8n8NEPngF8fpdHhCzPCvjqrlMsg772k6imUu/MMbe0009IL5+tmsd1n
         7pu4L+iVuHDZCz384frL6dbV0MitX9tBNKWHKQy29EcqDzwkX+wqqLkVwiIdd2wJmqcy
         PzYWlv7nm+b9X3AMfgq7nNxFjnmY80RkJkNRCZsUJ8VzLh6tgDoeL0zrqERXtH8sIwSr
         l2ajuwgw11uCmUzKqH0T2/dgSOIRuZ5qf7Fbk6ybUFmNu1iW0NLm9b2UVLSRyttB1x3B
         Y7vN2ibL8LeYP0s5veOpfUpjtZuYw5iimvHv6EXkXI5FrBKTnaOgIcP1l/hcsn3nLkJI
         7N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRGrsGIuHpsCfKgbLO01uLpvEDCDM1u1XXLG6rg/fA8=;
        b=lRlbH+unuVLmMw06z98HrKoUYkuqG8RXiCaluqcmkv6Lygj3kQIMeywUtguoyWjtyF
         ViSiUNn5coCJy2Xi676Xq7cG9VjvAfKMjX7WRKxcyE1ps+x02Zx+et+lIWrF3Y1OK76n
         HqK1Jq/ExQRg7KXKivj8FB0w/gXN0sUHExuYGrIfgpfeYC4lxiZQAAFnkG3jTsHgrF3V
         OYDMqD0/9ZWXdEIt8meOF0tFlmNw3Umh8O9CzCH2+6IP3c52uqr9XKLDnIInDpTRHl+y
         Mo08dKG5UsN9iChZpydLzet3Q4WRjYe+sjQ9OkHegyWjfk2tr/8CWtEl41gv1YnuytVf
         Tl/Q==
X-Gm-Message-State: AOAM531WGDcLwnwuwfdm9QcZx+wyjICfHdXijzId/vQMIQVdToKnQwAV
        lYy3PVyCnNhxv47lqnemQxFrZRgf8tX+vbEOYYlCUg==
X-Google-Smtp-Source: ABdhPJyHAeOQgz49/VL6jtU+i54f8NdtusYvL5ifZQPa6cUV0Dn0B0bM0z0uoe62jZChFcS3kGipw61Kf+ExvkpIoCs=
X-Received: by 2002:a25:6585:: with SMTP id z127mr139784ybb.33.1602434332955;
 Sun, 11 Oct 2020 09:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201009132732.v6.1.Ic98067cd92a0b7fed9cd3dfb7b4e736e76551cda@changeid>
 <20201009132732.v6.2.I8d7530d8372e4ef298ddaaaad612a2cdd24ed93e@changeid> <8cfa923c-cc7a-6dd3-9541-8a18b98091b7@collabora.com>
In-Reply-To: <8cfa923c-cc7a-6dd3-9541-8a18b98091b7@collabora.com>
From:   Duncan Laurie <dlaurie@google.com>
Date:   Sun, 11 Oct 2020 09:38:36 -0700
Message-ID: <CADv6+04sHeL9BVSqWVtFeUfuPxBGK+H-jq2+gA0YgpwpbBtYjg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        devicetree@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Peers <epeers@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 4:59 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Bhanu,
>
> Thank you for your patch.
>
> On 9/10/20 23:01, Bhanu Prakash Maiya wrote:
> > Add DT compatible string in
> > Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> >
>
> The problem with this patchset continues being the same. You are using the trick
> of using a DT compatible string to instantiate an ACPI-only driver. You should
> have an ACPI ID for that device or use a DMI table to match the device and
> instantiate it (see for example the platform/chrome/cros_ec_lpc.c).
>

It isn't really meant to be an ACPI only driver, it just happens
to be an x86 system that uses the UART interface first.  We use
this PRP0001 instantiation method with a lot of different drivers
like MIPI cameras, fingerprint sensors, the cr50 TPM driver, etc.

That said it is true that the rest of the cros_ec drivers use
distinct ACPI IDs.  Bhanu I allocated GOOG0019 for the cros_ec
UART interface so you can switch to using that instead.
You'll need to update the coreboot interface as well and might
want to keep both devices in firmware to ease the transition.

-duncan

>
> > Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >
> > Changes in v6:
> > - No change
> >
> > Changes in v5:
> > - No change
> >
> > Changes in v4:
> > - Changes in commit message.
> >
> > Changes in v3:
> > - Rebased changes on google,cros-ec.yaml
> >
> > Changes in v2:
> > - No change
> >
> >  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > index 6a7279a85ec1c..552d1c9bf3de4 100644
> > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > @@ -10,11 +10,12 @@ maintainers:
> >    - Benson Leung <bleung@chromium.org>
> >    - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >    - Guenter Roeck <groeck@chromium.org>
> > +  - Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> >
> >  description:
> >    Google's ChromeOS EC is a microcontroller which talks to the AP and
> >    implements various functions such as keyboard and battery charging.
> > -  The EC can be connected through various interfaces (I2C, SPI, and others)
> > +  The EC can be connected through various interfaces (I2C, SPI, UART and others)
> >    and the compatible string specifies which interface is being used.
> >
> >  properties:
> > @@ -29,6 +30,9 @@ properties:
> >        - description:
> >            For implementations of the EC is connected through RPMSG.
> >          const: google,cros-ec-rpmsg
> > +      - description:
> > +          For implementations of the EC is connected through UART.
> > +        const: google,cros-ec-uart
> >
> >    google,cros-ec-spi-pre-delay:
> >      description:
> >

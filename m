Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5122D8257
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407030AbgLKWt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394011AbgLKWtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:49:19 -0500
X-Gm-Message-State: AOAM5313Hs3LDR3j5REIZ+4NC3zAsehRiuOC+DdrzIFEyNrZCwNm4uoP
        5tngIEUWy52Jt9j6UGbGB5cLqsey+TH8qfUwqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726919;
        bh=9kZNymVdIQdokRAKswxv73AN4tdhSwyYcUymBCQ55Ic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfxGOydcbMt0JjYq6ERbodgzYugBbj5r6D8hPDOOyYvDnnQPOGwQXYqduJbwHc1Rt
         8Eh4MdG8RgJwHYa1stna5N/rHLQE+bN32BJK6ic1Pu86SB9Jkz/K7qSz8kht1pLKMc
         r2bm6vIJyIDi6IspadzII6gUbYNrpQKyVoHmdpcmcZtYJVbp6oSTWXDPA3gsE+wXbg
         wLIXS5s9VJ3OltUs04v6uzu9XjbwNlR4umrcJMhSI3PI1On/t1o66Yypqx11KYwYQT
         2JPV1Z/4bATMscD9WUVU95VkXJzEjhlPe07PuEvh9J1WHCL+T68QSjQMcf11oDa8sT
         sNyaC7aTJAMmA==
X-Google-Smtp-Source: ABdhPJwK8ZorGU0TFVJZH5c/4e3AauDieEoMVL2guTtxGD4PK2qnMlMawIC4UeCIoBz67Lan/AhY/UipOcj6bzR90cw=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr12958728ejz.341.1607726917615;
 Fri, 11 Dec 2020 14:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20201211060429.20027-1-a-govindraju@ti.com> <062c861a-b35e-06cd-2bda-a2d3f5034290@ti.com>
In-Reply-To: <062c861a-b35e-06cd-2bda-a2d3f5034290@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 11 Dec 2020 16:48:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoq20v7wj0x9Nzp2dFeeEunEmschF+VTXMtPdLwg1izA@mail.gmail.com>
Message-ID: <CAL_JsqJoq20v7wj0x9Nzp2dFeeEunEmschF+VTXMtPdLwg1izA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: usb: Add new compatible string for AM64 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 6:04 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Hi,
> On 11/12/20 11:34 am, Aswath Govindraju wrote:
> > Add compatible string in j721e-usb binding file as the same USB subsystem
> > is present in AM64.
> >
> > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > ---
> >
> > Changes since v3:
> > - used enum instead of anyOf.
> >
> > Changes since v2:
> > - added changes done over the versions.
> >
> > Changes since v1:
> > - replaced the '\t' at the beginning of the lines with spaces as it was
> >   causing the dt_binding_check to fail.
> >
> >  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > index 388245b91a55..1a5c7bbb40d1 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> > @@ -11,8 +11,9 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - const: ti,j721e-usb
> > +    enum:
> > +      - ti,j721e-usb
> > +      - ti,am64-usb
> >
>
> I am trying to use the compatible strings in the following manner
>
> ```
> compatible = "ti,am64-usb", "ti,j721e-usb";
>
> ```
> If I use above patch I am getting an error while doing a dtbs check.
>
> ```
> /home/gsaswath/src/ti-linux-kernel/arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml:
> cdns-usb@f900000: compatible: Additional items are not allowed
> ('ti,j721e-usb' was unexpected)
>         From schema:
> /home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
> /home/gsaswath/src/ti-linux-kernel/arch/arm64/boot/dts/ti/k3-am642-evm.dt.yaml:
> cdns-usb@f900000: compatible: ['ti,am64-usb', 'ti,j721e-usb'] is too long
>         From schema:
> /home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>
> ```
>
>
> I have looked around for examples but I am unable to find a similar
> case. I tried using anyOf in the following manner

You didn't look hard enough. There are lots.

> ```
> compatible:
>      anyOf:
>         - const: ti,am64-usb
>         - const: ti,j721e-usb

This is really no different than a single 'enum' with the 2 values.
'anyOf' means one or more in the list are true, but more than 1 is
impossible here.

If you have different possible lengths of values, then you need
'oneOf' for each case and then 'items' when you have a value with
multiple entries:

oneOf:
  - const: ti,j721e-usb
  - items:
      - const: ti,am64-usb
      - const: ti,j721e-usb

> ```
>
> But I am getting an error
>
> ```
> /home/gsaswath/src/ti-linux-kernel/Documentation/devicetree/bindings/usb/ti,j721e-usb.example.dt.yaml:
> cdns_usb@4104000: compatible: 'anyOf' conditional failed, one must be fixed:
>         Additional items are not allowed ('ti,j721e-usb' was unexpected)
>         ['ti,am64-usb', 'ti,j721e-usb'] is too long
>         'ti,j721e-usb' was expected
> ```
>
> Doesn't anyof mean that the compatible strings can be used in any
> combination ??
>
> Thanks,
> Aswath
>
> >    reg:
> >      description: module registers
> >
>

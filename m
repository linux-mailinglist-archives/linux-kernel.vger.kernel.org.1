Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350C830066C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbhAVPBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:01:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbhAVOwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:52:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EDE7239EE;
        Fri, 22 Jan 2021 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611327110;
        bh=UVENJ8SwAaMEVSup4KUp9M6Y7Hntoo9gwFOVgUT8oGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FXrG7NjANZ8HxnMna/ny1zUy2Mogyuxbnz68QCBd7kO7NiPV4/2q6lG4MmLu17UyP
         N470/R1kO9y720A/M8CIWiEtI6/ZYhgDSciZzrb/sxt8dG4gZ/W9qpM4iOIbneZ4Q2
         mkfLYceaRA9yzfbWJilCgSxiElOahehcDT5Ec+CvZO6OZLF+v3F+q49Noajl0xHaVF
         83N6BsYCD5zW59qlJS1XwAW+DxYT77YXEgLtvruEKU5u97ZJMjZcgRlR3GCfMCM77z
         4yXf/4IzZEteQTB3dZSVqDOYUWnU6NLDkGiv7e1OMBmLMkt1Qri8c5pZgwwntxuGz6
         LwYyRaAXt/BLA==
Received: by mail-ej1-f49.google.com with SMTP id rv9so8000151ejb.13;
        Fri, 22 Jan 2021 06:51:50 -0800 (PST)
X-Gm-Message-State: AOAM532IivjpDsZ7ZWYnug0xQJfLv/5FZ1tUGH7CDjXcTPTc4KBRLSNM
        VOrYewvW4pgc98IUc3j+qOwtQDn5BfjvegQFLw==
X-Google-Smtp-Source: ABdhPJwFUeGwf7xQOBtjPmx0ccgY3V7Y6xkhTkG4GkyffTDYwU7UDugMKHbPhpv6LP4LwMNjyZNgYQiLoTUE2SV2tmw=
X-Received: by 2002:a17:906:958f:: with SMTP id r15mr3085496ejx.360.1611327109003;
 Fri, 22 Jan 2021 06:51:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
 <78e54d594b9e31d603d913048a7bc89d3a089608.1610645385.git.mchehab+huawei@kernel.org>
 <20210115014731.GA4077569@robh.at.kernel.org> <20210119112653.46f26ce3@coco.lan>
In-Reply-To: <20210119112653.46f26ce3@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Jan 2021 08:51:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKyMy010vOjSdbDPXs13ygvfHpK5pb_1TN0pLM9pwL97w@mail.gmail.com>
Message-ID: <CAL_JsqKyMy010vOjSdbDPXs13ygvfHpK5pb_1TN0pLM9pwL97w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] phy: phy-hi3670-usb3: move driver from staging
 into phy
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yu Chen <chenyu56@huawei.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 4:26 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Thu, 14 Jan 2021 19:47:31 -0600
> Rob Herring <robh@kernel.org> escreveu:
>
> > On Thu, Jan 14, 2021 at 06:35:44PM +0100, Mauro Carvalho Chehab wrote:
> > > The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> > > for mainstream. Mode it from staging into the main driver's
> > > phy/ directory.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
> > >  MAINTAINERS                                   |   9 +-
> > >  drivers/phy/hisilicon/Kconfig                 |  10 +
> > >  drivers/phy/hisilicon/Makefile                |   1 +
> > >  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 668 ++++++++++++++++++
> > >  drivers/staging/hikey9xx/Kconfig              |  11 -
> > >  drivers/staging/hikey9xx/Makefile             |   2 -
> > >  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 668 ------------------
> > >  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --
> > >  9 files changed, 759 insertions(+), 754 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > >  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
> > >  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
> > >  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > > new file mode 100644
> > > index 000000000000..125a5d6546ae
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.yaml
> > > @@ -0,0 +1,72 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/hisilicon,hi3670-usb3.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Hisilicon Kirin970 USB PHY
> > > +
> > > +maintainers:
> > > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >
> > Blank line.
>
> Ok.
>
> >
> > > +description: |+
> > > +  Bindings for USB3 PHY on HiSilicon Kirin 970.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: hisilicon,hi3670-usb-phy
> > > +
> > > +  "#phy-cells":
> > > +    const: 0
> > > +
> > > +  hisilicon,pericrg-syscon:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > +    description: phandle of syscon used to control iso refclk.
> > > +
> > > +  hisilicon,pctrl-syscon:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > +    description: phandle of syscon used to control usb tcxo.
> > > +
> > > +  hisilicon,sctrl-syscon:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > +    description: phandle of syscon used to control phy deep sleep.
> > > +
> > > +  hisilicon,eye-diagram-param:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Eye diagram for phy.
> > > +
> > > +  hisilicon,tx-vboost-lvl:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: TX level vboost for phy.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - hisilicon,pericrg-syscon
> > > +  - hisilicon,pctrl-syscon
> > > +  - hisilicon,sctrl-syscon
> > > +  - hisilicon,eye-diagram-param
> > > +  - hisilicon,tx-vboost-lvl
> > > +  - "#phy-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    bus {
> > > +      #address-cells = <2>;
> > > +      #size-cells = <2>;
> > > +
> > > +      usb3_otg_bc: usb3_otg_bc@ff200000 {
> > > +        compatible = "syscon", "simple-mfd";
> > > +        reg = <0x0 0xff200000 0x0 0x1000>;
> > > +
> > > +        usb_phy {
> >
> > Is there a contiguous register region for this sub-block? If so, add
> > 'reg' even though Linux doesn't need it currently.
>
> No. The driver uses 4 syscon regions in order to access the needed
> registers:

I meant just for the parent device node. I assume these are the 'main'
registers? If not, then maybe it should be a child of one of the other
syscons.

'reg' would just be for documentation ATM. However, if the subblock
was reused on another chip, but at a different offset then reg would
become useful. You could handle that with a fixed offset when 'reg' is
missing, but adding it later would be too late.

Rob

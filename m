Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90F8287CA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgJHTrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgJHTrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:47:23 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6841E22200;
        Thu,  8 Oct 2020 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602186442;
        bh=SogUjMB0CBlzI2GJG+eOsj9We4ZGEMenuo5pC/MW5eQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSfKtOkAypzDoteeVFxZt86mzhGnusdufe5AeGmfvWZbYg/ZTKlCqNUkNaE4eIQJ6
         svxa2XxdTtuoAYygm/TAu6gPgxjlMbQ0sFLodUAsU/uxuvMtIEygFvaGQ3vj95e6Y3
         fvYXRR9Tn+8OASb9L0Mz7A8fS1SBp6yvo0aB5ujA=
Received: by mail-oi1-f177.google.com with SMTP id z26so7548988oih.12;
        Thu, 08 Oct 2020 12:47:22 -0700 (PDT)
X-Gm-Message-State: AOAM530XNtyE3ooxdDMYnn+sNizrv0qadU616ijoUjy+u0MTpRNuk718
        Z7ANpjb+OBjKKVwdFtT1W9wY9XyA2Fm1od2BAg==
X-Google-Smtp-Source: ABdhPJz2oNaku/oyyTmq42V8qnOXwViBgeYQXBKIrGbtQCDZkxU2VZpGkDVbUpGPZwahfqM+0DKZamEWEptncS+yMbQ=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr275043oia.147.1602186441518;
 Thu, 08 Oct 2020 12:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200921092951.945382-1-enric.balletbo@collabora.com>
 <20201007151159.GA221754@bogus> <CAFqH_531fkh_gZbOMuzhsRj-72NeWsPyxWoFQh9bAF3CZwTfNw@mail.gmail.com>
In-Reply-To: <CAFqH_531fkh_gZbOMuzhsRj-72NeWsPyxWoFQh9bAF3CZwTfNw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Oct 2020 14:47:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL7ej3o_qzb7r+Nmdp=YkuYciqRYYcFo4Z21OGOvkn-3A@mail.gmail.com>
Message-ID: <CAL_JsqL7ej3o_qzb7r+Nmdp=YkuYciqRYYcFo4Z21OGOvkn-3A@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Caesar Wang <wxt@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 3:57 PM Enric Balletbo Serra <eballetbo@gmail.com> w=
rote:
>
> Hi Rob,
>
> Missatge de Rob Herring <robh@kernel.org> del dia dc., 7 d=E2=80=99oct. 2=
020 a
> les 17:12:
> >
> > On Mon, Sep 21, 2020 at 11:29:51AM +0200, Enric Balletbo i Serra wrote:
> > > Convert the soc/rockchip/power_domain.txt binding document to json-sc=
hema
> > > and move to the power bindings directory.
> > >
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > >
> > > Changes in v3:
> > > - Fixed tab errors found by bot
> > >
> > > Changes in v2:
> > > - Fixed a warning that says that 'syscon' should not be used alone.
> > > - Use patternProperties to define a new level for power-domains.
> > > - Add const values for power-domain-cells, address-cells, etc.
> > >
> > >  .../power/rockchip,power-controller.yaml      | 207 ++++++++++++++++=
++
> > >  .../bindings/soc/rockchip/power_domain.txt    | 136 ------------
> > >  2 files changed, 207 insertions(+), 136 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/power/rockchip,=
power-controller.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/po=
wer_domain.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/rockchip,power-c=
ontroller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-con=
troller.yaml
> > > new file mode 100644
> > > index 000000000000..b23ea37e2a08
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/rockchip,power-controll=
er.yaml
> > > @@ -0,0 +1,207 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/rockchip,power-controller.y=
aml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rockchip Power Domains
> > > +
> > > +maintainers:
> > > +  - Caesar Wang <wxt@rock-chips.com>
> > > +  - Heiko Stuebner <heiko@sntech.de>
> > > +
> > > +description: |
> > > +  Rockchip processors include support for multiple power domains whi=
ch can be
> > > +  powered up/down by software based on different application scenes =
to save power.
> > > +
> > > +  Power domains contained within power-controller node are generic p=
ower domain
> > > +  providers documented in Documentation/devicetree/bindings/power/po=
wer-domain.yaml.
> > > +
> > > +  IP cores belonging to a power domain should contain a 'power-domai=
ns'
> > > +  property that is a phandle for the power domain node representing =
the domain.
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    const: power-controller
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - rockchip,px30-power-controller
> > > +      - rockchip,rk3036-power-controller
> > > +      - rockchip,rk3066-power-controller
> > > +      - rockchip,rk3128-power-controller
> > > +      - rockchip,rk3188-power-controller
> > > +      - rockchip,rk3228-power-controller
> > > +      - rockchip,rk3288-power-controller
> > > +      - rockchip,rk3328-power-controller
> > > +      - rockchip,rk3366-power-controller
> > > +      - rockchip,rk3368-power-controller
> > > +      - rockchip,rk3399-power-controller
> > > +
> > > +  '#power-domain-cells':
> > > +    const: 1
> > > +
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +patternProperties:
> > > +  "^power-domain@[0-9]+$":
> >
> > unit-addresses are hex.
> >
> > > +    type: object
> > > +    description: |
> > > +      Represents the power domains within the power controller node =
as documented
> > > +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> > > +
> > > +    properties:
> > > +
> > > +      '#power-domain-cells':
> > > +        description:
> > > +            Must be 0 for nodes representing a single PM domain and =
1 for nodes
> > > +            providing multiple PM domains.
> > > +
> > > +      '#address-cells':
> > > +        const: 1
> > > +
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +      reg:
> > > +        description: |
> > > +          Power domain index. Valid values are defined in:
> > > +          "include/dt-bindings/power/px30-power.h" - for PX30 type p=
ower domain.
> > > +          "include/dt-bindings/power/rk3036-power.h" - for RK3036 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3066-power.h" - for RK3066 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3128-power.h" - for RK3128 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3188-power.h" - for RK3188 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3228-power.h" - for RK3228 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3288-power.h" - for RK3288 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3328-power.h" - for RK3328 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3366-power.h" - for RK3366 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3368-power.h" - for RK3368 ty=
pe power domain.
> > > +          "include/dt-bindings/power/rk3399-power.h" - for RK3399 ty=
pe power domain.
> > > +        maxItems: 1
> >
> > Range of values?
> >
> > > +
> > > +      clocks:
> > > +        description: |
> > > +          A number of phandles to clocks that need to be enabled whi=
le power domain
> > > +          switches state.
> >
> > Can you at least put a range of how many clocks?
> >
> > > +
> > > +      pm_qos:
> > > +        description: |
> > > +          A number of phandles to qos blocks which need to be saved =
and restored
> > > +          while power domain switches state.
> >
> > And here.
> >
> > > +
> > > +    required:
> > > +      - reg
> >
> >        additionalProperties: false
> >
> > Which in turn means the nested power domains will throw an error, so yo=
u
> > can do:
> >
> >        patternProperties:
> >          "^power-domain@[0-9a-f]+$":
> >            $ref: '#/patternProperties/^power-domain@[0-9a-f]+$'
> >
>
> When I tried this I got the following error:
>
> rockchip,power-controller.yaml:
> patternProperties:^power-domain@[0-9a-f]+$:patternProperties:^power-domai=
n@[0-9a-f]+$:$ref:
> '#/patternProperties/^power-domain@[0-9a-f]+$' is not a
> 'uri-reference'
>
> Not sure if is my environment or I am still doing something silly, can
> you confirm that this works for you? It doesn't seem to be any binding
> doing this actually.

I think the regex would have to be escaped to be a valid URI:

$ref: '%23/patternProperties/%5Epower-domain@%5B0-9a-f%5D+%24'

That's not the most readable nor am I sure it would get translated
back to the right path, so it's probably going to be best to just
define the child nodes even if duplicated.

Rob

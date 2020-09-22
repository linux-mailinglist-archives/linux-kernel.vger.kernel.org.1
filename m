Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0DE274C29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIVWgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVWgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:36:32 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426AF20715;
        Tue, 22 Sep 2020 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600814192;
        bh=42JEbkwJ0QcZASq1Xu6y67Bf8D/3KmeHjzJ9YCx8dHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G985UI6DInk3QstKOjZeMHQVb2yBKJKcr6wo7bgw8wgSz4csAVdeiEuGxORsC3F23
         q4qGJSGjNjjnFmVVei6AUkvzfizaJgozFleRVSrIihdOax5W8Xy2AK63PMc9rMW4Yf
         QowxKuDNnZJxXEIrPiSYDGQsyoGCKkAl1tZzvttY=
Received: by mail-oi1-f172.google.com with SMTP id x14so22830497oic.9;
        Tue, 22 Sep 2020 15:36:32 -0700 (PDT)
X-Gm-Message-State: AOAM531W6xYiGcPzQUEpWukcOVhbbg/UGYGcBXblMgDBlIJcAWOKSzI9
        0IFVpw72IZGzto8Hjr8MMUyYkNZrUYRS/O4ugQ==
X-Google-Smtp-Source: ABdhPJzZN0UgDaU6VdXUbXGFsCMsyMLMdcBZ6UFDqWV5LRcZ8PQQtjB9wUHpc6lYoWnyT/qiwTJuMWEE8IMBZfMrad8=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr4015483oii.106.1600814191611;
 Tue, 22 Sep 2020 15:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-2-enric.balletbo@collabora.com> <20200911230255.GA2972120@bogus>
 <7a1c89b6-f483-5d57-f154-b80b72964077@gmail.com>
In-Reply-To: <7a1c89b6-f483-5d57-f154-b80b72964077@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 16:36:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCOXKCTbjw=8MMhnq0YdhrOb7tY6QpT7d3XTAgUrbg=w@mail.gmail.com>
Message-ID: <CAL_JsqLCOXKCTbjw=8MMhnq0YdhrOb7tY6QpT7d3XTAgUrbg=w@mail.gmail.com>
Subject: Re: [PATCH 01/12] dt-bindings: power: Add bindings for the Mediatek
 SCPSYS power domains controller
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 2:59 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 12/09/2020 01:02, Rob Herring wrote:
> > On Thu, Sep 10, 2020 at 07:28:15PM +0200, Enric Balletbo i Serra wrote:
> >> The System Control Processor System (SCPSYS) has several power management
> >> related tasks in the system. Add the bindings to define the power
> >> domains for the SCPSYS power controller.
> >>
> >> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
> >> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >> Dear Rob,
> >>
> >> I am awasre that this binding is not ready, but I prefered to send because I'm
> >> kind of blocked. Compiling this binding triggers the following error:
> >>
> >>      mediatek,power-controller.example.dt.yaml: syscon@10006000: mfg_async@7:
> >>      '#address-cells', '#size-cells', 'mfg_2d@8'
> >>      do not match any of the regexes: 'pinctrl-[0-9]+'
> >>
> >> This happens when a definition of a power-domain (parent) contains
> >> another power-domain (child), like the example. I am not sure how to
> >> specify this in the yaml and deal with this, so any clue is welcome.
> >
> > You just have to keep nesting schemas all the way down. Define a
> > grandchild node under the child node and then all of its properties.
> >
> >>
> >> Thanks,
> >>    Enric
> >>
> >>   .../power/mediatek,power-controller.yaml      | 171 ++++++++++++++++++
> >>   1 file changed, 171 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> >> new file mode 100644
> >> index 000000000000..8be9244ad160
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> >> @@ -0,0 +1,171 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Mediatek Power Domains Controller
> >> +
> >> +maintainers:
> >> +  - Weiyi Lu <weiyi.lu@mediatek.com>
> >> +  - Matthias Brugger <mbrugger@suse.com>
> >> +
> >> +description: |
> >> +  Mediatek processors include support for multiple power domains which can be
> >> +  powered up/down by software based on different application scenes to save power.
> >> +
> >> +  IP cores belonging to a power domain should contain a 'power-domains'
> >> +  property that is a phandle for SCPSYS node representing the domain.
> >> +
> >> +properties:
> >> +  $nodename:
> >> +    pattern: "^syscon@[0-9a-f]+$"
> >> +
> >> +  compatible:
> >> +    items:
> >> +      - enum:
> >> +        - mediatek,mt8173-power-controller
> >> +      - const: syscon
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +patternProperties:
> >> +  "^.*@[0-9]$":
> >
> > Node names should be generic:
> >
> > power-domain@
> >
>
> Enric correct me if I'm wrong, if we want to see the power domains in debugfs,
> they are listed by their name. If all are called power-domain then the listing
> is pretty much useless.

Sorry, but not a binding problem.

Maybe if debugfs shows what devices are contained within a power
domain then it doesn't matter so much.

> >> +    type: object
> >> +    description: |
> >> +      Represents the power domains within the power controller node as documented
> >> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
> >> +
> >> +    properties:
> >> +      reg:
> >> +        description: |
> >> +          Power domain index. Valid values are defined in:
> >> +              "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
> >> +        maxItems: 1
> >> +
> >> +      '#power-domain-cells':
> >> +        description:
> >> +          Documented by the generic PM Domain bindings in
> >> +          Documentation/devicetree/bindings/power/power-domain.yaml.
> >
> > No need to redefine a common property. This should define valid values
> > for it.
> >
> >> +
> >> +      clocks:
> >> +        description: |
> >> +          A number of phandles to clocks that need to be enabled during domain
> >> +          power-up sequencing.
> >
> > No need to redefine 'clocks'. You need to define how many, what each one
> > is, and the order.
> >
>
> Do you mean we have to define each clock for each power domain of each SoC?

Yes.

Rob

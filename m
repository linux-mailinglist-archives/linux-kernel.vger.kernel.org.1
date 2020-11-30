Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6D2C8EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgK3UTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgK3UTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:19:10 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8A62073C;
        Mon, 30 Nov 2020 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606767509;
        bh=OYAwhBu5ywGPe4jP/b3ZBFwibZjhake7u5Wr/qL2fIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O9uFaNr4To7vJTf75zjkEL7XgHxwVqQRCftbAfCkIVP+QNsx891Ugysnp+257Te0m
         nuWpIHXPOO+K8kpEjh+4gT7tLzzjH9KZy8jgcODRTGPrjEiXjmx/n4gloJK2+bJRzV
         j7HKJb/r9PmQA8ABEBNPeeTJEchyhpX680ay9BTA=
Received: by mail-ej1-f51.google.com with SMTP id a16so24364852ejj.5;
        Mon, 30 Nov 2020 12:18:28 -0800 (PST)
X-Gm-Message-State: AOAM5321f+/9QskaQinM3LICyWQJK/E/UY5w6lhMHqCmevfnbCcwufQm
        j+8bnV1HaUEDkopKWfANxjsZV5k9xVU9F6ypiw==
X-Google-Smtp-Source: ABdhPJy2nXxet6XRLfUULbJdYRO0enUaj+Ze/fUrnLEhVqiYAL20KfJSmMjjwubTbni2mL1Ow39Nn3DY7hHQGlUA2Io=
X-Received: by 2002:a17:906:6713:: with SMTP id a19mr23950068ejp.468.1606767507250;
 Mon, 30 Nov 2020 12:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20201101093150.8071-1-paul@crapouillou.net> <20201101093150.8071-3-paul@crapouillou.net>
 <20201101122900.GB1269759@ravnborg.org> <9CZ5JQ.CWYPSJ8EDOW4@crapouillou.net>
 <CAL_JsqLSGMFibm8tVKqNe1SFBzXTU2=M2jZmpfrHeGUqS3foRg@mail.gmail.com> <1XJMKQ.YER47WG3D7R41@crapouillou.net>
In-Reply-To: <1XJMKQ.YER47WG3D7R41@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Nov 2020 13:18:15 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJDQMzHjtYa6ZCOxXW_U5nWrS+DhBj-w2myn-SkGB+KCA@mail.gmail.com>
Message-ID: <CAL_JsqJDQMzHjtYa6ZCOxXW_U5nWrS+DhBj-w2myn-SkGB+KCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: Add ABT Y030XX067A panel bindings
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:39 PM Paul Cercueil <paul@crapouillou.net> wrote=
:
>
> Hi Rob,
>
> Le lun. 30 nov. 2020 =C3=A0 7:32, Rob Herring <robh+dt@kernel.org> a =C3=
=A9crit
> :
> > On Mon, Nov 2, 2020 at 3:19 AM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>
> >>
> >>
> >>  Le dim. 1 nov. 2020 =C3=A0 13:29, Sam Ravnborg <sam@ravnborg.org> a
> >> =C3=A9crit :
> >>  > On Sun, Nov 01, 2020 at 09:31:48AM +0000, Paul Cercueil wrote:
> >>  >>  The Asia Better Technology (ABT) Y030XX067A panel is a 3.0"
> >> 320x480
> >>  >>  24-bit IPS LCD panel. Its particularity is that it has
> >> non-square
> >>  >> pixels
> >>  >>  (as it is 4:3 for a resolution of 320x480), and that it
> >> requires odd
> >>  >>  lines to be sent as RGB and even lines to be sent as GRB on its
> >>  >> 8-bit
> >>  >>  bus.
> >>  >>
> >>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  >>  ---
> >>  >>   .../display/panel/abt,y030xx067a.yaml         | 54
> >>  >> +++++++++++++++++++
> >>  >>   1 file changed, 54 insertions(+)
> >>  >>   create mode 100644
> >>  >>
> >> Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >>  >>
> >>  >>  diff --git
> >>  >>
> >> a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >>  >>
> >> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >>  >>  new file mode 100644
> >>  >>  index 000000000000..6407e8bf45fa
> >>  >>  --- /dev/null
> >>  >>  +++
> >>  >>
> >> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >>  >>  @@ -0,0 +1,54 @@
> >>  >>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>  >>  +%YAML 1.2
> >>  >>  +---
> >>  >>  +$id:
> >>  >> http://devicetree.org/schemas/display/panel/abt,y030xx067a.yaml#
> >>  >>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>  >>  +
> >>  >>  +title: Asia Better Technology 3.0" (320x480 pixels) 24-bit IPS
> >> LCD
> >>  >> panel
> >>  >>  +
> >>  >>  +description: |
> >>  >>  +  The panel must obey the rules for a SPI slave device as
> >>  >> specified in
> >>  >>  +  spi/spi-controller.yaml
> >>  >>  +
> >>  >>  +maintainers:
> >>  >>  +  - Paul Cercueil <paul@crapouillou.net>
> >>  >>  +
> >>  >>  +allOf:
> >>  >>  +  - $ref: panel-common.yaml#
> >>  >>  +
> >>  >>  +properties:
> >>  >>  +  compatible:
> >>  >>  +    const: abt,y030xx067a
> >>  >>  +
> >>  >>  +  backlight: true
> >>  >>  +  port: true
> >>  >>  +  power-supply: true
> >>  >>  +  reg: true
> >>  >>  +  reset-gpios: true
> >>  >
> >>  > The binding is missing:
> >>  > required:
> >>  >   - compatible
> >>  >   - reg
> >>  >   - power-supply
> >>  >   - reset-gpios
> >>  >   - ...
> >>  >
> >>  > additionalProperties: false
> >>  >
> >>  > So r-b only with these added.
> >>
> >>  Stupid mistake, sorry about that.
> >>
> >>  I'll V2.
> >
> > I don't have any V2 in my inbox, but looks like it is in linux-next
> > now:
>
> Yes, Sam told me on IRC I could fix it while applying and avoid the V2.
>
> > /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/=
display/panel/abt,y030xx067a.example.dt.yaml:
> > panel@0: 'spi-max-frequency' does not match any of the regexes:
> > 'pinctrl-[0-9]+'
> >  From schema:
> > /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/=
display/panel/abt,y030xx067a.yaml
>
> "make dt_binding_check
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/display/panel/abt,y03=
0xx067a.yaml"
> doesn't complain here :(

Even if you do 'touch
Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml'
or do a clean build?

I can't think of any kernel or dt-schema changes which would explain
the difference. This is purely related to 'additionalProperties:
false'.

Rob

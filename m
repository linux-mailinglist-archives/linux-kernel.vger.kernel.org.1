Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76272C86D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgK3Odc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgK3Odb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:33:31 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7276320709;
        Mon, 30 Nov 2020 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606746770;
        bh=SuE4P++qmGoLIF8j33uj/kt53nUU2XUBIpidjDdUDcQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XAxwCCneycEo0STLrtMaQhdKZ0vIy3KX2+qKn8bxFx6V2pJKlDfCwdebLr9GFYJyL
         16lHebPujB7w6CV7vLOdcAwlEwmV3Ey2hf6UPW2xxW2DgOhsFtgMgpm43mDRnQaJt8
         mMzqeX9x7yi9OmkfOAPTltp96mvfQNpFA7OdHBYc=
Received: by mail-ed1-f51.google.com with SMTP id d18so16372194edt.7;
        Mon, 30 Nov 2020 06:32:50 -0800 (PST)
X-Gm-Message-State: AOAM530iVvwA0MFastt48Ias9c6F4ON4ZdYrS90tZ8G4ic2Hwk0M+IMH
        SMzYK5gZQQavkQS3WkEyMWdeVcNWQH9Ke3eDsw==
X-Google-Smtp-Source: ABdhPJyTqjub2riyWhCOMyYIHeNVbIUSCia+ywmWQkoDk3lUZp34191pq9pG8Twi1LTvGpKxnvfe+omAGM3pVlOvnig=
X-Received: by 2002:a50:c091:: with SMTP id k17mr1349767edf.137.1606746768862;
 Mon, 30 Nov 2020 06:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20201101093150.8071-1-paul@crapouillou.net> <20201101093150.8071-3-paul@crapouillou.net>
 <20201101122900.GB1269759@ravnborg.org> <9CZ5JQ.CWYPSJ8EDOW4@crapouillou.net>
In-Reply-To: <9CZ5JQ.CWYPSJ8EDOW4@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Nov 2020 07:32:37 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLSGMFibm8tVKqNe1SFBzXTU2=M2jZmpfrHeGUqS3foRg@mail.gmail.com>
Message-ID: <CAL_JsqLSGMFibm8tVKqNe1SFBzXTU2=M2jZmpfrHeGUqS3foRg@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: display: Add ABT Y030XX067A panel bindings
To:     Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Christophe Branchereau <cbranchereau@gmail.com>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 3:19 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le dim. 1 nov. 2020 =C3=A0 13:29, Sam Ravnborg <sam@ravnborg.org> a =C3=
=A9crit :
> > On Sun, Nov 01, 2020 at 09:31:48AM +0000, Paul Cercueil wrote:
> >>  The Asia Better Technology (ABT) Y030XX067A panel is a 3.0" 320x480
> >>  24-bit IPS LCD panel. Its particularity is that it has non-square
> >> pixels
> >>  (as it is 4:3 for a resolution of 320x480), and that it requires odd
> >>  lines to be sent as RGB and even lines to be sent as GRB on its
> >> 8-bit
> >>  bus.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>   .../display/panel/abt,y030xx067a.yaml         | 54
> >> +++++++++++++++++++
> >>   1 file changed, 54 insertions(+)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >>
> >>  diff --git
> >> a/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >>  new file mode 100644
> >>  index 000000000000..6407e8bf45fa
> >>  --- /dev/null
> >>  +++
> >> b/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
> >>  @@ -0,0 +1,54 @@
> >>  +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>  +%YAML 1.2
> >>  +---
> >>  +$id:
> >> http://devicetree.org/schemas/display/panel/abt,y030xx067a.yaml#
> >>  +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>  +
> >>  +title: Asia Better Technology 3.0" (320x480 pixels) 24-bit IPS LCD
> >> panel
> >>  +
> >>  +description: |
> >>  +  The panel must obey the rules for a SPI slave device as
> >> specified in
> >>  +  spi/spi-controller.yaml
> >>  +
> >>  +maintainers:
> >>  +  - Paul Cercueil <paul@crapouillou.net>
> >>  +
> >>  +allOf:
> >>  +  - $ref: panel-common.yaml#
> >>  +
> >>  +properties:
> >>  +  compatible:
> >>  +    const: abt,y030xx067a
> >>  +
> >>  +  backlight: true
> >>  +  port: true
> >>  +  power-supply: true
> >>  +  reg: true
> >>  +  reset-gpios: true
> >
> > The binding is missing:
> > required:
> >   - compatible
> >   - reg
> >   - power-supply
> >   - reset-gpios
> >   - ...
> >
> > additionalProperties: false
> >
> > So r-b only with these added.
>
> Stupid mistake, sorry about that.
>
> I'll V2.

I don't have any V2 in my inbox, but looks like it is in linux-next now:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/disp=
lay/panel/abt,y030xx067a.example.dt.yaml:
panel@0: 'spi-max-frequency' does not match any of the regexes:
'pinctrl-[0-9]+'
 From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree=
/bindings/display/panel/abt,y030xx067a.yaml

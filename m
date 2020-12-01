Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C866A2CA9D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392175AbgLARht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391945AbgLARht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:37:49 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F10C21D42
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606844227;
        bh=KNAM6f9lqa9mSdVyTIG/dKQEu1sW8SSDpknGMUKbCiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q7gvXsO8ykqAn2xVepDAm7HMlbTj1GN5iniIENiosDRNoP34C9CXV2n19OssOrOSf
         zrHyfvybHLN4CfnLGsVrl2JcsaJ+CdjwlOBwLTkB41lyPHgC9pllif5zp7zhSV4eOu
         N50+hBxxWoZ6tlmxD6bJrD1Hh6WkQ4KIF5fOnMpg=
Received: by mail-ej1-f54.google.com with SMTP id x16so5814239ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:37:07 -0800 (PST)
X-Gm-Message-State: AOAM5321luAWYhACxtM2aY33PdtL1di+ynP5N5Kv1QJbN17KDBGGZlZo
        RqfO2RBV4ANoebQk+iu6hAmZbiBIwJs7ZPahPQ==
X-Google-Smtp-Source: ABdhPJxR2ypWVHPbsoaZHQu3SRgRb3mnZE4SCBgSJTl1wFd4t4AYEIvkGKfVCSCuJyrRSxZoQsFWoEqw9dgY/cytRY4=
X-Received: by 2002:a17:906:c20f:: with SMTP id d15mr4059120ejz.341.1606844225944;
 Tue, 01 Dec 2020 09:37:05 -0800 (PST)
MIME-Version: 1.0
References: <1606746513-30909-1-git-send-email-kevin3.tang@gmail.com>
 <1606746513-30909-2-git-send-email-kevin3.tang@gmail.com> <CAL_Jsq+fC1TzygUopiwVtwBN8JtwmnGy=VMTEvkudSQUdXiMqg@mail.gmail.com>
 <CAFPSGXZLXh__GuXT2NPqF0jpO2DnMAhz+NtE721EZfMCSKLBjQ@mail.gmail.com>
In-Reply-To: <CAFPSGXZLXh__GuXT2NPqF0jpO2DnMAhz+NtE721EZfMCSKLBjQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 1 Dec 2020 10:36:54 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJQE0-ScESutDd950GEac+w0KhzGcLv+_jb1xuVs6DQXw@mail.gmail.com>
Message-ID: <CAL_JsqJQE0-ScESutDd950GEac+w0KhzGcLv+_jb1xuVs6DQXw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 12:36 AM Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> Hi Rob
>
> Rob Herring <robh+dt@kernel.org> =E4=BA=8E2020=E5=B9=B412=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=884:29=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Nov 30, 2020 at 7:28 AM Kevin Tang <kevin3.tang@gmail.com> wrot=
e:
> > >
> > > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > Once again, DT patches must Cc the DT list if you want them reviewed.
> Ok, i will add DT list to my Cc list.
> >
> > >
> > > The Unisoc DRM master device is a virtual device needed to list all
> > > DPU devices or other display interface nodes that comprise the
> > > graphics subsystem
> > >
> > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > > ---
> > >  .../display/sprd/sprd,display-subsystem.yaml       | 39 ++++++++++++=
++++++++++
> > >  1 file changed, 39 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/sprd/sp=
rd,display-subsystem.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,disp=
lay-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,di=
splay-subsystem.yaml
> > > new file mode 100644
> > > index 0000000..9487a39
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-sub=
system.yaml
> > > @@ -0,0 +1,39 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/sprd/sprd,display-subsyst=
em.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Unisoc DRM master device
> > > +
> > > +maintainers:
> > > +  - Kevin Tang <kevin.tang@unisoc.com>
> > > +
> > > +description: |
> > > +  The Unisoc DRM master device is a virtual device needed to list al=
l
> > > +  DPU devices or other display interface nodes that comprise the
> > > +  graphics subsystem.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sprd,display-subsystem
> >
> > As I said before, we try to avoid these virtual nodes. Make the DRM
> > driver bind to the DPU node.
> >
> > The case where this might be needed is if you have h/w that's a
> > mixture of shared and discrete blocks. I don't see anything here
> > matching that.
>
> This is how I understand this sentence: "h/w that's a mixture of shared a=
nd discrete blocks"
> We have multiple display controllers and corresponding physical interface=
s, typical dual-screen display scenario
> E.g:
> 1. dpu0 and dpu1 both binding to DSI for dual mipi-dsi display;
> 2. dpu0 binding to DSI for primary display, and dpu1 binding to DP for ex=
ternal display;
>
> It looks like this:
> dpu0------>MIPI-DSI------>DPHY/CPHY Combo------>Panel0
>                         ^
>     ----------------|
>     |
> dpu1------>DisplayPort------>PHY------>Panel1
>
> For DTS like this:
> display-subsystem {
> compatible =3D "sprd,display-subsystem";
> ports =3D <&dpu0_out>, <&dpu1_out>;
> };

Yeah, this would be one such case. Just make this scenario clear in
commit message.

Rob

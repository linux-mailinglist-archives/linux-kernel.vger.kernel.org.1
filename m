Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E422E27BD37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgI2Gff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgI2Gfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:35:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314D6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:35:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y17so4151644lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+v6NFNkpNv4QFfcDFX8DIUEdE4c/tx9CiOwb1iqWN8s=;
        b=LArxUVHh0fN7BaYMIeqQtxL60B6Hn0pyGZk6bPFsEdPyEpKQ2GzoOoyN+ZpvUQw5Ud
         iYroF9Zwhnhx4rkRfL2VenuryVNspDptQCDUOf+9+DnY/0UNxKKUI5KYxt3L9bEmyHND
         CkRbdjRIJyVaDc1gi606MC4Y+Yx80g+RdZ9rJalrNCVu8/GP515IeIqJaBTtGhA1R7O5
         XFZvq5ZlPR4pgWwPaaAvokpuKoiOOMNRtE+W7TQ1UoCjILJeNvuI/35e+VB6/tSZSdAo
         yJhFLn1/6K+/JrBBM1qWUfxrL7ttTqBNNp08uRDH6Bkllitx+NjcaspMg65YSWPJvPna
         G4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+v6NFNkpNv4QFfcDFX8DIUEdE4c/tx9CiOwb1iqWN8s=;
        b=UuSyseiCRXmhZOdnEmS7Oc9tUHRb6LcIOecfIApwRxowbtDAu71k+Od4t7hRNUkwgB
         bueyvMxYl5gXgwJyWmiOERuJ3c2MokltDj1QsKHcxEzE6WDIiKxczN9EqObpzw0/w8UE
         ypYL14XUZa4flAiDUFV1/1OlV0zkIdZY7IObiXrmCs6CnALMY5QXv0Weob5wzvYJQGu/
         6SeSZT1BYD/3V1YJg0S8/Tr05p9T29zrjijxG6BzFGh2PSatDzlifx9QCZlOfWOVHZj4
         ZKf/NghIAjAPexyYzbXWFiXqvQXImwoxS4VDd3E6QOMBssPNAuUt2c2pfDz19Oqm2ap6
         Ck2Q==
X-Gm-Message-State: AOAM531q7EgsjrCeeXlNvqLakQTNMxrAWrSnZOkwCwQAdSOuZ0S6lCSK
        58dmUO/fcx5beKOTMkFlVOBOwBHFo9Ev9Bi/iEw=
X-Google-Smtp-Source: ABdhPJwDZX67W2Jnc3QulXwMmecGTBztlpEn8xr1t/O2/Kg32kOG8ZxZPTjRCZ6EjqWRMWP9MM8oHYjJPSSXTIJ0dCI=
X-Received: by 2002:a19:992:: with SMTP id 140mr594077lfj.273.1601361332605;
 Mon, 28 Sep 2020 23:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
 <1601274460-7866-2-git-send-email-kevin3.tang@gmail.com> <20200928081726.hkh3rzbfr6m7jszt@gilmour.lan>
 <CAL_JsqLUT9gBiVgSdcHM86vNLR_1MxEZ+x9MDBaFGdv2j9EtvA@mail.gmail.com>
In-Reply-To: <CAL_JsqLUT9gBiVgSdcHM86vNLR_1MxEZ+x9MDBaFGdv2j9EtvA@mail.gmail.com>
From:   Kevin Tang <kevin3.tang@gmail.com>
Date:   Tue, 29 Sep 2020 14:35:21 +0800
Message-ID: <CAFPSGXYbdeZuVKQWnU6kiPzn3zgm224O2uDkr-uuLBUUjufGsA@mail.gmail.com>
Subject: Re: [PATCH RFC v7 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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

Hi Rob,
Component framework include master and component, here is master subnode.
It seems that everyone else does it, why not me?

Your comments on v6:
"We generally try to avoid this virtual node as it doesn't represent
any h/w. Can't you bind the driver to the DPU directly?"

I'm sorry, maybe is my careless, I still don't understand why and how to do=
 it

Rob Herring <robh+dt@kernel.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=8829=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:28=E5=86=99=E9=81=93=EF=BC=9A

>
> On Mon, Sep 28, 2020 at 3:17 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi!
> >
> > On Mon, Sep 28, 2020 at 02:27:35PM +0800, Kevin Tang wrote:
> > > From: Kevin Tang <kevin.tang@unisoc.com>
> > >
> > > The Unisoc DRM master device is a virtual device needed to list all
> > > DPU devices or other display interface nodes that comprise the
> > > graphics subsystem
> > >
> > > RFC v7:
> > >   - Fix DTC unit name warnings
> > >   - Fix the problem of maintainers
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
> > > +
> > > +  ports:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description:
> > > +      Should contain a list of phandles pointing to display interfac=
e port
> > > +      of DPU devices.
> >
> > Generally speaking, driver-specific properties should be prefixed by th=
e
> > vendor name to avoid any conflict with generic properties (like the
> > OF-Graph ports subnode in this case)
>
> We try to avoid this virtual node altogether which I commented about
> on v6 which was ignored.
>
> Rob

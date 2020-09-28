Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5112327B1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgI1Q2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgI1Q2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:28:42 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765CC2184D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601310521;
        bh=Eo8YEjouCJzF1yYSbOTSLRi6+NRp9wrcB5MtIkA8TCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AZ+elSJNS7jNx/5uNGRT4xca53om5Iz5t8ceN1+UDaeEUAm4QfDKNhZ51HYVQP7Tg
         duTODn7ql0pu+rSaIDfQbNE5uwyTEi088CU/pYJZr8/IhYzJvQBL/0bjkHQ7DXtTCZ
         brvEBHgLw9nKzZsnyKaJiyuTuYJinZhd3qfKGfY4=
Received: by mail-oi1-f171.google.com with SMTP id c13so1964902oiy.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:28:41 -0700 (PDT)
X-Gm-Message-State: AOAM531Cw4jCzh/kVhHBswWf9s8uqSr5Fca1rDerQA+gAcbmF7f0MIR2
        s+t5jzFF9IKHUCK90CPETO21ZG6sxt2p0sVMOg==
X-Google-Smtp-Source: ABdhPJxa2uMVpJWBoZg+SM+FBl4RJ9Um0uaAT5ECCXoQfXhOVrkAi/EDHDmDLmJOKu0hkbNfgXZBlR2mU8AeruFF828=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr1401247oii.106.1601310520677;
 Mon, 28 Sep 2020 09:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
 <1601274460-7866-2-git-send-email-kevin3.tang@gmail.com> <20200928081726.hkh3rzbfr6m7jszt@gilmour.lan>
In-Reply-To: <20200928081726.hkh3rzbfr6m7jszt@gilmour.lan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 28 Sep 2020 11:28:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUT9gBiVgSdcHM86vNLR_1MxEZ+x9MDBaFGdv2j9EtvA@mail.gmail.com>
Message-ID: <CAL_JsqLUT9gBiVgSdcHM86vNLR_1MxEZ+x9MDBaFGdv2j9EtvA@mail.gmail.com>
Subject: Re: [PATCH RFC v7 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Maxime Ripard <maxime@cerno.tech>,
        Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 3:17 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi!
>
> On Mon, Sep 28, 2020 at 02:27:35PM +0800, Kevin Tang wrote:
> > From: Kevin Tang <kevin.tang@unisoc.com>
> >
> > The Unisoc DRM master device is a virtual device needed to list all
> > DPU devices or other display interface nodes that comprise the
> > graphics subsystem
> >
> > RFC v7:
> >   - Fix DTC unit name warnings
> >   - Fix the problem of maintainers
> >
> > Cc: Orson Zhai <orsonzhai@gmail.com>
> > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > ---
> >  .../display/sprd/sprd,display-subsystem.yaml       | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
> > new file mode 100644
> > index 0000000..9487a39
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/sprd/sprd,display-subsystem.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc DRM master device
> > +
> > +maintainers:
> > +  - Kevin Tang <kevin.tang@unisoc.com>
> > +
> > +description: |
> > +  The Unisoc DRM master device is a virtual device needed to list all
> > +  DPU devices or other display interface nodes that comprise the
> > +  graphics subsystem.
> > +
> > +properties:
> > +  compatible:
> > +    const: sprd,display-subsystem
> > +
> > +  ports:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      Should contain a list of phandles pointing to display interface port
> > +      of DPU devices.
>
> Generally speaking, driver-specific properties should be prefixed by the
> vendor name to avoid any conflict with generic properties (like the
> OF-Graph ports subnode in this case)

We try to avoid this virtual node altogether which I commented about
on v6 which was ignored.

Rob

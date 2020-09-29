Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1B27BE57
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgI2Hru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI2Hrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 03:47:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79625C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:47:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so3740451wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gTw8+Yfq2M+lgL6uz8tiJpeY2ZADAkzaEJEhPKyRCFI=;
        b=IkT8QLC85j8yoqCUXeesrjQjdwYyMXKI+9pHr+gD194jy/JPlP7IULJjQBms6RfAcn
         ngOpiL8YKxttlae/eW+ZSYsuN6fw22wjzPlxYz4CDVZQDW6jOe/fUpkTpZ06RqkrezNR
         tZkf3oRsdTOWnYGJBVtyhGGF97Yrg4fEfY5ZIcZb811ljQIAJX1+o0YjTeWIaW1PBXE+
         VLRgbDqUx1NexRNOfcMr8YML02icMyBzioqMZjt4FsQUuZccI2vjISzfstZ8Ll3CZL0X
         uw2lFh1dlc98GFEzdezIO+4ogmKGDBjmkzMVNoNFeVIQxDwrMa1bVwb3S3R4Q7QIhlWk
         BKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gTw8+Yfq2M+lgL6uz8tiJpeY2ZADAkzaEJEhPKyRCFI=;
        b=KXlJqeZx8y2kb/prHAtl7tWmeYF9rihUNllVseSnSkTXnBt8a+R7g4KSMoAyT9gNYO
         ga66OJFAVOEDtQ+bUfvNvo9pN2/XdO/j2bU+8dwXZiI55mPR5x55EPNCNyv5sMV9F3gC
         AkWK8JmBTUk/ASX9KFregRJhGuFIOrPDVBjzcqu6tczJJ3Q2tN6ObZaOIF6j9MCpTwhv
         6IlECIsi6qm28hpNl7eu8KtqHHAWlkLRHk51Rm5Ma3Mg+FQ0DRq9ywtvYFDjA4rjFbKt
         F7B3axz2UY2VogJd++FMCyXwRuJra++5Qez1ahg/Al1/fRoJIFO0wo3xs5wLaItg8Hbq
         3jgQ==
X-Gm-Message-State: AOAM533LYjylMdcpmNKo4QUJTsYCVbOwtNPsZNiZ6jHH8Lsi+rkwwGMO
        rCWfEtdbyh3sjHKmRWJDqbbN9g+klxJy8GzWsgRVo+ksgHFdyg==
X-Google-Smtp-Source: ABdhPJwgE/V6GpmwpxCPRvRtwn4tPlyvUYF/SJiKYjaeXSNi83XanhC/KGLo6HVBvseR3RSGee42R6EPnZDFrupv9vs=
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr2888405wmh.166.1601365668191;
 Tue, 29 Sep 2020 00:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <1601274460-7866-1-git-send-email-kevin3.tang@gmail.com>
 <1601274460-7866-2-git-send-email-kevin3.tang@gmail.com> <20200928081726.hkh3rzbfr6m7jszt@gilmour.lan>
 <CAL_JsqLUT9gBiVgSdcHM86vNLR_1MxEZ+x9MDBaFGdv2j9EtvA@mail.gmail.com> <CAFPSGXYbdeZuVKQWnU6kiPzn3zgm224O2uDkr-uuLBUUjufGsA@mail.gmail.com>
In-Reply-To: <CAFPSGXYbdeZuVKQWnU6kiPzn3zgm224O2uDkr-uuLBUUjufGsA@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 29 Sep 2020 15:47:12 +0800
Message-ID: <CAAfSe-uncUhsN_MFWe2KiaWjBwmdyrXOSp32O3sTvbgwTJ+VRQ@mail.gmail.com>
Subject: Re: [PATCH RFC v7 1/6] dt-bindings: display: add Unisoc's drm master bindings
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 at 14:35, Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> Hi Rob,
> Component framework include master and component, here is master subnode.
> It seems that everyone else does it, why not me?
>
> Your comments on v6:
> "We generally try to avoid this virtual node as it doesn't represent
> any h/w. Can't you bind the driver to the DPU directly?"
>
> I'm sorry, maybe is my careless, I still don't understand why and how to =
do it

Devicetree is used to describe hardware rather than virtual things
like "sprd,display-subsystem" which is not a real device.
That's what I understand for Rob's comments here.

Chunyan

>
> Rob Herring <robh+dt@kernel.org> =E4=BA=8E2020=E5=B9=B49=E6=9C=8829=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:28=E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > On Mon, Sep 28, 2020 at 3:17 AM Maxime Ripard <maxime@cerno.tech> wrote=
:
> > >
> > > Hi!
> > >
> > > On Mon, Sep 28, 2020 at 02:27:35PM +0800, Kevin Tang wrote:
> > > > From: Kevin Tang <kevin.tang@unisoc.com>
> > > >
> > > > The Unisoc DRM master device is a virtual device needed to list all
> > > > DPU devices or other display interface nodes that comprise the
> > > > graphics subsystem
> > > >
> > > > RFC v7:
> > > >   - Fix DTC unit name warnings
> > > >   - Fix the problem of maintainers
> > > >
> > > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > > Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> > > > Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> > > > ---
> > > >  .../display/sprd/sprd,display-subsystem.yaml       | 39 ++++++++++=
++++++++++++
> > > >  1 file changed, 39 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/sprd/=
sprd,display-subsystem.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,di=
splay-subsystem.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,=
display-subsystem.yaml
> > > > new file mode 100644
> > > > index 0000000..9487a39
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/display/sprd/sprd,display-s=
ubsystem.yaml
> > > > @@ -0,0 +1,39 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/display/sprd/sprd,display-subsy=
stem.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Unisoc DRM master device
> > > > +
> > > > +maintainers:
> > > > +  - Kevin Tang <kevin.tang@unisoc.com>
> > > > +
> > > > +description: |
> > > > +  The Unisoc DRM master device is a virtual device needed to list =
all
> > > > +  DPU devices or other display interface nodes that comprise the
> > > > +  graphics subsystem.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: sprd,display-subsystem
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    description:
> > > > +      Should contain a list of phandles pointing to display interf=
ace port
> > > > +      of DPU devices.
> > >
> > > Generally speaking, driver-specific properties should be prefixed by =
the
> > > vendor name to avoid any conflict with generic properties (like the
> > > OF-Graph ports subnode in this case)
> >
> > We try to avoid this virtual node altogether which I commented about
> > on v6 which was ignored.
> >
> > Rob

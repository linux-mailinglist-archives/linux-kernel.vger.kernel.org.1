Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3922F443A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbhAMGAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMGAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:00:19 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C110C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:59:38 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id 73so338576uac.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uflk09hDM8jdt4VETF4zx5oJUWKH+szab3bAtMaySZM=;
        b=V3XzRVPHSN8FFVcOv8s7cpuEkmtlGkiiHwAJaarEz7yvvOdfJhsgwyKvQTQNg2o7ZL
         V/GK4fj9ALPENfCozfr27V58sVnrLv/ZmwzCHf2X68mFcnMuUdhY46ER2c0BLdYLtUly
         AqfsKcS4XhbLMY3ZWLO+Vk8IPH2OooUGZr9lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uflk09hDM8jdt4VETF4zx5oJUWKH+szab3bAtMaySZM=;
        b=l8EK5nXxM7naToTcyrrUU9Tl9reYYpslYop3oAUP/ld7EWRt9jL91gcjuyuNGkRQkJ
         ElEZQdynvBXiS5pzvEzi0Ydo99iSmxZge1DTerZTNDt+3rfe8eH+hFsiE0T3qawk5lzU
         idlYAY0PcldKKdJRhe2/P/uTrAacCGXS3gu5Ct2nBxCimCSwxevg+VGrW1yS5ov0CRTU
         dtQv3bmlVqU+iHOoHAz+vOef3nv81bvgKiijlboqPFXPhg1XadajjzB46KK7q2W42ID1
         wC49FTwH1/i9WJNLtKUc58zEE3Aar6Z4b+f9Jnxij53ol1XrzvIHPZE58Dd9hmlQBjif
         7BEw==
X-Gm-Message-State: AOAM532rMPtcoXLfKhIEQh2OKpAEZxVI26VbiyQqTUht3p2jq3no4ZTu
        j3q0e8N+7deZnhFPd3mgtc+kSZRpG40Iozp6x8Pfzg==
X-Google-Smtp-Source: ABdhPJxUOJXjPKGrSYhZlqGURvTegd9S+519z9w10z9Cg+aIQfHXMgodScbQmK240/7XPSZwmWdqBfZO5TB6vzygsss=
X-Received: by 2002:ab0:74d2:: with SMTP id f18mr516697uaq.48.1610517577824;
 Tue, 12 Jan 2021 21:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20210108011011.4061575-1-drinkcat@chromium.org>
 <20210108091005.v9.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid> <20210112150726.GA330364@robh.at.kernel.org>
In-Reply-To: <20210112150726.GA330364@robh.at.kernel.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 13 Jan 2021 13:59:26 +0800
Message-ID: <CANMq1KAY+KgXGNaVttESfW+1m3Daec6B-GqHgRW0gdFmOGf=qA@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Fei Shao <fshao@chromium.org>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:07 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 08, 2021 at 09:10:08AM +0800, Nicolas Boichat wrote:
> > Define a compatible string for the Mali Bifrost GPU found in
> > Mediatek's MT8183 SoCs.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> > ---
> >
> > (no changes since v6)
> >
> > Changes in v6:
> >  - Rebased, actually tested with recent mesa driver.
> >  - No change
> >
> > Changes in v5:
> >  - Rename "2d" power domain to "core2"
> >
> > Changes in v4:
> >  - Add power-domain-names description
> >    (kept Alyssa's reviewed-by as the change is minor)
> >
> > Changes in v3:
> >  - No change
> >
> >  .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > index 184492162e7e..71b613ee5bd7 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > @@ -17,6 +17,7 @@ properties:
> >      items:
> >        - enum:
> >            - amlogic,meson-g12a-mali
> > +          - mediatek,mt8183-mali
> >            - realtek,rtd1619-mali
> >            - rockchip,px30-mali
> >        - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> > @@ -87,6 +88,30 @@ allOf:
> >      then:
> >        required:
> >          - resets
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: mediatek,mt8183-mali
> > +    then:
> > +      properties:
> > +        sram-supply: true
>
> This has to be defined at the top-level or there will be an error when
> it is present (due to additionalProperties).
>
> In this if/then you can do:
>
> else:
>   sram-supply: false
>
> to disallow it if not 'mediatek,mt8183-mali'

I see. Thanks Rob, will send a v10.



>
> > +        power-domains:
> > +          description:
> > +            List of phandle and PM domain specifier as documented in
> > +            Documentation/devicetree/bindings/power/power_domain.txt
> > +          minItems: 3
> > +          maxItems: 3
> > +        power-domain-names:
> > +          items:
> > +            - const: core0
> > +            - const: core1
> > +            - const: core2
> > +
> > +      required:
> > +        - sram-supply
> > +        - power-domains
> > +        - power-domains-names
> >
> >  examples:
> >    - |
> > --
> > 2.29.2.729.g45daf8777d-goog
> >

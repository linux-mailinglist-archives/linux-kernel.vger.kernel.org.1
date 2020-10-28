Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77D529D93E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbgJ1WuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbgJ1Wsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:48:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BAAC0613CF;
        Wed, 28 Oct 2020 15:48:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q199so543524qke.10;
        Wed, 28 Oct 2020 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSBDVbjHhG9zeA/DTxswLuBUaX5GcRcOqrQA1xpDRcw=;
        b=h+5kSOxB4GU1lVQmKzLTMGS3FgSifN/Mfq/0gj+H7igLwNR2BWGbiOu6RuWpSpISiF
         wNS7JvCbzMi/MNMyND3Vkxv70NZ5+Q/+niWJ336qL6gskOKDde7y4plolWM68vlIQEJV
         NaQFkVgokW7Zmkz06EqnKwFGWBxo5286pYvcXV8dJfFWlGUP8O9ve+3Gq/T5UiyawvJy
         9I62Pfmsi6d4QVEMOhwtoC0vcAfLa9BohovkPY0FsvOI4gxe75tPG1rjqL1c+VhqdFyG
         UIcIz/48UkcifbD2ePb2dOcDxzWQaw44JU3KYDaGX2prOubHEKBQU5n5RB+WHuaAVVUE
         5Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSBDVbjHhG9zeA/DTxswLuBUaX5GcRcOqrQA1xpDRcw=;
        b=qiPid9wMMHxqxvoM8etBsP/GPBa4h8np49Ko+risLDpGhXmZwPVT0/4085X2x4KMBw
         N2l7KfB1SjR73P4zbkKO4bZcMNuSOUh8uXibWTZH1ppsyLefuGrh2hOYk8U90fm9cwk4
         reCWHAZAynsKx1gjQuteIz6zBWG+OtBFMzs443YQAfH/jT2o1ktJ6vvJchsrONz58FgW
         00PftIMeXy/jT5kdiebnmKUaLgmQrXIiR1s8ae9TVJ77funzkC9d4ex1u10tbndQ1rlF
         e96MeiNrPMYawzJetIdZZ0Y0To7MvLRmi7kG/W2TLXrUcHpG5Sb8JbCzH4vQkiWALX8L
         1Frw==
X-Gm-Message-State: AOAM531BctU1TaMiSe8aBGu4EqHk+SBCf6VUupRnztOcEmgDIRR5prEw
        dnhRgieNz1DhQuBvBg0YhV/6VxD3grJz75ugZQ0YpgipZrE=
X-Google-Smtp-Source: ABdhPJzO2p30F4Yjj/o8ZcbkZ7ROKT5TBXHUaz1VkKheGp0FBnljBOOn55tfm5sGYlheoJilNa86PQue9aYJYtAfjGo=
X-Received: by 2002:a05:620a:657:: with SMTP id a23mr5712705qka.121.1603862425444;
 Tue, 27 Oct 2020 22:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com> <20201027110840.GA23076@kozik-lap>
In-Reply-To: <20201027110840.GA23076@kozik-lap>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 28 Oct 2020 13:20:14 +0800
Message-ID: <CAA+D8AOvhYDK=NHxQGxb-GLPaRsPn0uZsBZqswxACfMz+eQQHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc for
 aud2htx module
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 7:09 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 06:40:54PM +0800, Shengjiu Wang wrote:
> > AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> > IP module found on i.MX8MP.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../bindings/sound/fsl,aud2htx.yaml           | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> > new file mode 100644
> > index 000000000000..18548d0889a8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,aud2htx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP Audio Subsystem to HDMI RTX Subsystem Controller
> > +
> > +maintainers:
> > +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^aud2htx@.*"
>
> aud2htx is not a generic class of a device so it should not be enforced.
>
> > +
> > +  compatible:
> > +    const: fsl,imx8mp-aud2htx
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Peripheral clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +
> > +  dmas:
> > +    items:
> > +      - description: DMA controller phandle and request line for TX
> > +
> > +  dma-names:
> > +    items:
> > +      - const: tx
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - dmas
> > +  - dma-names
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/imx8mp-clock.h>
> > +
> > +    aud2htx: aud2htx@30cb0000 {
> > +             compatible = "fsl,imx8mp-aud2htx";
>
> Wrong indentation. Most of examples are indented with 4 spaces.
>
ok, I will update it.

best regards
wang shengjiu

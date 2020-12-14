Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947172D9AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438166AbgLNPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgLNPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:14:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F249C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:14:13 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 190so3821827wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XFFq37eCn9McjSMbAdEWRX+rN8Hu5pbl3VvCnEtPlqw=;
        b=JOoX3QsHa+m84XGE+3wMKtfSJbdikbTI963rGgGR7IJgHl29QrbhK89m2LdPTY5/YH
         5VEsLAjrGiQWPr5JB1qbvYf05AozzX4dvgh/oeJhT5j6V9TfBJXRF0raoXlA8jBQD5+f
         xGBh5ZumNldFNWxTjauMVsenCqfdhsnQ2fMONlFISb3DhTnM9kDt1XuN9MkaStoLPlQf
         iTYPpdPctLeajlp0Z8SEMfoBoWhLWk8CWCvLc5v3f0dn6DkVPnCY3IRdnO+eJFVXYaFF
         9UpzLBh2ESpNPNasNU2+ML9AFkgPOvPuk5NJm0Wyx1hMKozu2VWkINSWlcMMxNFtvxuF
         v9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XFFq37eCn9McjSMbAdEWRX+rN8Hu5pbl3VvCnEtPlqw=;
        b=qJivN7fa+xYSRkKzxUHvtD4lrx70ZvQY/WZDTKBtuoCMLD+9S3HO4b8La69SSOZq7v
         CQwxtV2S11fMPLvnbshkwA2P1a2HHJK2j4ipzcmWvnlLezevZeYfPkMhc6Bje8TyvKV5
         ntfm1ymKzsNeek+B4h5w9opI0LJn+g2dakXp8GadEGgbWw/xI8kRJDU6p9duu8rOVX/P
         bye/F3hgIyOd3/clW4St1LKB3yhkbeG0rdKE4nLbJCF/Cblabxg3VnGDgRD1bTwzXo8w
         NQ9vVGRWN6tEfcNEWfRzXCgMb917ffVkDEiF/53IJCWlZC4tNBz1EWwglEaFtaKisGYG
         wr7Q==
X-Gm-Message-State: AOAM532DsmENXzmj0ICjvUzXhoEE7cZ4ICwMbuT65wRsCQH1qR1/7XLt
        R+NIqDxpc6G+CArvAW0kAN6Ldg==
X-Google-Smtp-Source: ABdhPJxgXYy630nRoHObtDB87X9DSIY8FH/7CuN7WM8pmFduvAx4KayG+AbHlc9oykC6MguozsCDIg==
X-Received: by 2002:a1c:5605:: with SMTP id k5mr28364108wmb.99.1607958851903;
        Mon, 14 Dec 2020 07:14:11 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j7sm31017532wmb.40.2020.12.14.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 07:14:10 -0800 (PST)
Date:   Mon, 14 Dec 2020 15:14:09 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20201214151409.qdqh2i5hr4g3eboe@holly.lan>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
 <1607704424-16223-2-git-send-email-u0084500@gmail.com>
 <20201214095916.4g47zlueng4wa3hv@holly.lan>
 <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU38wZ+yrfjbggJyY7BHc5-tdV-KWVgWBmZn-q3EY99=PPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:40:55PM +0800, ChiYuan Huang wrote:
> Hi,
> 
> Daniel Thompson <daniel.thompson@linaro.org> 於 2020年12月14日 週一 下午5:59寫道：
> >
> > Hi CY
> >
> > On Sat, Dec 12, 2020 at 12:33:43AM +0800, cy_huang wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Adds DT binding document for Richtek RT4831 backlight.
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >
> > This patch got keyword filtered and brought to my attention
> > but the rest of the series did not.
> >
> > If it was a backlight patch series you need to send it To: the
> > all the backlight maintainers.
> >
> Yes, I'm waiting for mfd reviewing.
> Due to mfd patch, I need to add backlight dt-binding patch prior to
> backlight source code.
> Or autobuild robot will said mfd dt-binding build fail from Rob.
> That's why I send the backlight dt-binding prior to the source code.
> 
> I still have backlight/regulator source code patch after mfd reviewing.
> Do you want me to send all the patches without waiting for mfd reviewing?

To some extent it's up to you.

I think I would have shared all the pieces at once (although not it Lee,
as mfd maintainer, had suggested otherwise).


Daniel.


> >
> > Daniel.
> >
> >
> > > ---
> > > since v3
> > > - Move inlcude/dt-bindings/leds/rt4831-backlight.h from v3 mfd binding patch to here.
> > > - Add dual license tag in header and backlight binding document.
> > > - Left backlight dt-binding example only.
> > > ---
> > >  .../leds/backlight/richtek,rt4831-backlight.yaml   | 76 ++++++++++++++++++++++
> > >  include/dt-bindings/leds/rt4831-backlight.h        | 23 +++++++
> > >  2 files changed, 99 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> > >  create mode 100644 include/dt-bindings/leds/rt4831-backlight.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> > > new file mode 100644
> > > index 00000000..f24c8d1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> > > @@ -0,0 +1,76 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/backlight/richtek,rt4831-backlight.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Richtek RT4831 Backlight
> > > +
> > > +maintainers:
> > > +  - ChiYuan Huang <cy_huang@richtek.com>
> > > +
> > > +description: |
> > > +  RT4831 is a mutifunctional device that can provide power to the LCD display
> > > +  and LCD backlight.
> > > +
> > > +  For the LCD backlight, it can provide four channel WLED driving capability.
> > > +  Each channel driving current is up to 30mA
> > > +
> > > +  Datasheet is available at
> > > +  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: richtek,rt4831-backlight
> > > +
> > > +  default-brightness:
> > > +    description: |
> > > +      The default brightness that applied to the system on start-up.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 2048
> > > +
> > > +  max-brightness:
> > > +    description: |
> > > +      The max brightness for the H/W limit
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 2048
> > > +
> > > +  richtek,pwm-enable:
> > > +    description: |
> > > +      Specify the backlight dimming following by PWM duty or by SW control.
> > > +    type: boolean
> > > +
> > > +  richtek,bled-ovp-sel:
> > > +    description: |
> > > +      Backlight OVP level selection, currently support 17V/21V/25V/29V.
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    default: 1
> > > +    minimum: 0
> > > +    maximum: 3
> > > +
> > > +  richtek,channel-use:
> > > +    description: |
> > > +      Backlight LED channel to be used.
> > > +      BIT 0/1/2/3 is used to indicate led channel 1/2/3/4 enable or disable.
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    minimum: 1
> > > +    maximum: 15
> > > +
> > > +required:
> > > +  - compatible
> > > +  - richtek,channel-use
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/leds/rt4831-backlight.h>
> > > +    backlight {
> > > +      compatible = "richtek,rt4831-backlight";
> > > +      default-brightness = <1024>;
> > > +      max-brightness = <2048>;
> > > +      richtek,bled-ovp-sel = /bits/ 8 <RT4831_BLOVPLVL_21V>;
> > > +      richtek,channel-use = /bits/ 8 <RT4831_BLED_ALLCHEN>;
> > > +    };
> > > diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bindings/leds/rt4831-backlight.h
> > > new file mode 100644
> > > index 00000000..125c635
> > > --- /dev/null
> > > +++ b/include/dt-bindings/leds/rt4831-backlight.h
> > > @@ -0,0 +1,23 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > > +/*
> > > + * This header provides constants for rt4831 backlight bindings.
> > > + *
> > > + * Copyright (C) 2020, Richtek Technology Corp.
> > > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_RT4831_BACKLIGHT_H
> > > +#define _DT_BINDINGS_RT4831_BACKLIGHT_H
> > > +
> > > +#define RT4831_BLOVPLVL_17V  0
> > > +#define RT4831_BLOVPLVL_21V  1
> > > +#define RT4831_BLOVPLVL_25V  2
> > > +#define RT4831_BLOVPLVL_29V  3
> > > +
> > > +#define RT4831_BLED_CH1EN    (1 << 0)
> > > +#define RT4831_BLED_CH2EN    (1 << 1)
> > > +#define RT4831_BLED_CH3EN    (1 << 2)
> > > +#define RT4831_BLED_CH4EN    (1 << 3)
> > > +#define RT4831_BLED_ALLCHEN  ((1 << 4) - 1)
> > > +
> > > +#endif /* _DT_BINDINGS_RT4831_BACKLIGHT_H */
> > > --
> > > 2.7.4
> > >

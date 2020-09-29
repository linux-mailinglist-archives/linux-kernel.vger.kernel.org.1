Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4D27DB75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgI2WJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgI2WJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:09:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB73C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:09:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t7so3521228pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8fC27h9ZgDNL2axWTEutG+gx93n8Yc9ucaXhlyytfCs=;
        b=EfZtR0Qr0tu9rn4I7XKHQgJEVbI8JywQ+y/MRkyNqRlmhY+TDgTFzOnLz7tL959Q22
         2yetaoLrkqAmf9znNgBrl5+TeS37a6kDUc1TyYpq5CP39U+2kou5CYExO20RxnTh+8tl
         FXtPJiPiZWnBNWz7ycVAWQFpUmD5H68oPQY88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fC27h9ZgDNL2axWTEutG+gx93n8Yc9ucaXhlyytfCs=;
        b=UnmtfyYeaJDVH6/VuacQ3BkAaydcm7VMRg2NYpUGLeTJYN9/GZVit0gSC3l6oTmxVk
         SETJWFHFsdJTirwGfJ+nqGhjCPOBYfwJmNO4uNOUdBRoePSVQGKVGjJvOXRZwPr2j1wU
         MuLDDTqJiDj39J0H436JvLyrPFvqS32XmLpD0SUd5UX6gr3INvYxAgEO94JD4LTGDc+u
         A7Kze1rOilWSQ14TREuB0nwZRE7BAlIBBFd9A9NBp8VVP3tBV/caU+m6+x2e/HNyd3EL
         3hcs9Ld5OQZlS0RdEhecER3xt4g1MCLetOWxjbETDoLZ1ZRVF/V09ORkKzsaidozP4cz
         uMUw==
X-Gm-Message-State: AOAM530Ihs28uWTEE5NdBI129x2yahR+6ApD7MCPxzQcqFYvq76KUtSi
        eFXVQYaYlEpgZzUaDZTws7e0Tg==
X-Google-Smtp-Source: ABdhPJxTYRtJRMu/SXLDA4x5xCJTpWeBSfOlq+vQ95AwOTdOXivReBz7xAPyU89owMQ29ex5vahf7Q==
X-Received: by 2002:a17:90a:fa8b:: with SMTP id cu11mr5623209pjb.10.1601417354186;
        Tue, 29 Sep 2020 15:09:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id h11sm5930115pgi.10.2020.09.29.15.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 15:09:13 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:09:12 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add binding for discrete
 onboard USB hubs
Message-ID: <20200929220912.GF1621304@google.com>
References: <20200928101326.v4.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200929201701.GA1080459@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200929201701.GA1080459@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Sep 29, 2020 at 03:17:01PM -0500, Rob Herring wrote:
> On Mon, Sep 28, 2020 at 10:13:54AM -0700, Matthias Kaehlcke wrote:
> > Discrete onboard USB hubs (an example for such a hub is the Realtek
> > RTS5411) need to be powered and may require initialization of other
> > resources (like GPIOs or clocks) to work properly. This adds a device
> > tree binding for these hubs.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > (no changes since v3)
> > 
> > Changes in v3:
> > - updated commit message
> > - removed recursive reference to $self
> > - adjusted 'compatible' definition to support multiple entries
> > - changed USB controller phandle to be a node
> > 
> > Changes in v2:
> > - removed 'wakeup-source' and 'power-off-in-suspend' properties
> > - consistently use spaces for indentation in example
> > 
> >  .../bindings/usb/onboard_usb_hub.yaml         | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > new file mode 100644
> > index 000000000000..c9783da3e75c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/onboard_usb_hub.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binding for onboard USB hubs
> > +
> > +maintainers:
> > +  - Matthias Kaehlcke <mka@chromium.org>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +        - realtek,rts5411
> > +      - const: onboard-usb-hub
> > +
> > +  vdd-supply:
> > +    description:
> > +      phandle to the regulator that provides power to the hub.
> > +
> > +required:
> > +  - compatible
> > +  - vdd-supply
> > +
> > +examples:
> > +  - |
> > +    usb_hub: usb-hub {
> > +        compatible = "realtek,rts5411", "onboard-usb-hub";
> > +        vdd-supply = <&pp3300_hub>;
> > +    };
> 
> As I said in prior version, this separate node and 'hub' phandle is not 
> going to work. You are doing this because you want a platform driver for 
> "realtek,rts5411". That may be convenient for Linux, but doesn't reflect 
> the h/w.

I agree that the hardware representation isn't totally straightforward, however
the description isn't limited to Linux:

- there is a single IC (like the Realtek RTS5411)
- the IC may require several resources to be initialized in a certain way
  - this may require executing hardware specific code by some driver, which
    isn't a USB device driver
- the IC can 'contain' multiple USB hub devices, which can be connected to
  separate USB busses
- the IC doesn't have a control bus, which somewhat resembles the
  'simple-audio-amplifier' driver, which also registers a platform device
  to initialize its resources

- to provide the functionality of powering down the hub conditionally during
  system suspend the driver (whether it's a platform driver or something else)
  needs know which USB (hub) devices correspond to it. This is a real world
  problem, on hardware that might see wide distribution.

There were several attempts to solve this problem in the past, but none of them
was accepted. So far Alan Stern seems to think the driver (not necessarily the
binding as is) is a suitable solution, Greg KH also spent time reviewing it,
without raising conceptual concerns. So it seems we have solution that would
be generally landable from the USB side.

I understand that your goal is to keep the device tree sane, which I'm sure
can be challenging. If you really can't be convinced that the binding might
be acceptable in its current or similiar form then please offer guidance
on possible alternatives which allow to achieve the same functionality.

Thanks

Matthias

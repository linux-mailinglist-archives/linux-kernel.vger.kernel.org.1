Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADBF300437
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbhAVNaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbhAVN3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:29:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F87C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:29:04 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i63so4312323wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owT9ZDTqHXNrbWE+7r0Lrony8G5r+UvHg072nHQs1m8=;
        b=IV9BDspRaepjk9Ex4ccn5wbH1nNpKqXl4rEfsScHxjVPiyJWPnD24oli1MhIZhGOOt
         5OyUyknNAjoE5rPNRt5izFGIdVJCgMqZc3OLBOU6aYT8kKpDFhXbjm2Emct+sNXK+pgT
         wQzpu03L1JLg49FhsdPSUzmkKTAGwjwmB6orEAtgPrjHOtj2j72bePNePfTiPGWuddWz
         sm7lUJYcXiJV5jGKTlz4sFagmBUMxLCyMDik4MHM/lSIMNELIRwj9/kEhrnxYV5sG2OR
         tbq8jumBegYoqpHH34TJ4D0ZgF4joIUPySflSw0vAIsJT6zV3GYbuVlqkznllIuJQNie
         YHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owT9ZDTqHXNrbWE+7r0Lrony8G5r+UvHg072nHQs1m8=;
        b=QuyuDSGVB7jaLBhy5jW2rNm2nXulF4nc7515333GGvzgOr3XpI7RuXMM94YIDA6JWo
         4tQbzGQxW7VExqxkHlG5jpp4wm/Fa23qFkn12esEUZQFYs5nyYR/6BswIfbGNBTWOgow
         a08MDBslspIlLpe17GwYVhoyygqn3OARJ196obb4CyLj6eVYCwvaOCBd/8t1xaidg4oy
         jtTbDlzNwpRArDcvzI+Fz7b4ZcSU80ZJV2v1TmmHldGUsHi/p9TeAsV71VRA7L5QsVWS
         VDZWhSff1u8v8aQoPbXS2YSSos9477NT0irRpD0Fim0Y1Jh4IINd1yrLCmrV6hqJtEvU
         NrHQ==
X-Gm-Message-State: AOAM532NlgDxWGe2dLvzQQj0oufbNILSXMW16TSP+SShflwnBTN5cu0X
        kQCGjnypm8KuN58fzy7yC+MiJy5XSlqkNuDK/9wlgQ==
X-Google-Smtp-Source: ABdhPJz2p5y4L7mSAemntP7ClkJC7I4pddYEtJGeJK0fpUzZ1TeA0drUIpISuCVyOD0oSQ65imTpSrX5n2anLJKUSCw=
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr3858329wmg.183.1611322143536;
 Fri, 22 Jan 2021 05:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20210111142309.193441-1-maxime@cerno.tech> <20210111142309.193441-14-maxime@cerno.tech>
In-Reply-To: <20210111142309.193441-14-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 22 Jan 2021 13:28:48 +0000
Message-ID: <CAPY8ntA1iAj39hzfDLg18bT5ZLA6h738suDubw5hnh=9yhMQsA@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] dt-binding: display: bcm2711-hdmi: Add CEC and
 hotplug interrupts
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime

On Mon, 11 Jan 2021 at 14:23, Maxime Ripard <maxime@cerno.tech> wrote:
>
> The CEC and hotplug interrupts were missing when that binding was
> introduced, let's add them in now that we've figured out how it works.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Looks reasonable to me, but I'm not a DT bindings expert

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  .../bindings/display/brcm,bcm2711-hdmi.yaml   | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> index 7ce06f9f9f8e..6e8ac910bdd8 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> @@ -53,6 +53,24 @@ properties:
>        - const: audio
>        - const: cec
>
> +  interrupts:
> +    items:
> +      - description: CEC TX interrupt
> +      - description: CEC RX interrupt
> +      - description: CEC stuck at low interrupt
> +      - description: Wake-up interrupt
> +      - description: Hotplug connected interrupt
> +      - description: Hotplug removed interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: cec-tx
> +      - const: cec-rx
> +      - const: cec-low
> +      - const: wakeup
> +      - const: hpd-connected
> +      - const: hpd-removed
> +
>    ddc:
>      allOf:
>        - $ref: /schemas/types.yaml#/definitions/phandle
> @@ -90,7 +108,7 @@ required:
>    - resets
>    - ddc
>
> -additionalProperties: false
> +unevaluatedProperties: false
>
>  examples:
>    - |
> --
> 2.29.2
>

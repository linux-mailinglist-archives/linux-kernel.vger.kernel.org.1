Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734C82DE1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 12:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgLRLVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 06:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgLRLVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 06:21:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C69C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 03:21:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a6so1977567wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 03:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9VPuMSJSoUHqzMeVGbAE30IrKxI8APrsEWW8ZWta/c=;
        b=Jwh2WpiuqTtq8IfgRyqIkz6FNAHeEn05Ct65f/ZAFEXaiuq2+Zdo8nJKvU8sQ+RFgy
         eWyRZ/dANLyHxjixnapLeiLAXU1HtgK956k8JebGtyN2i4I3itFeBe3BFCp2M8plyLve
         3zku/R4re76JwoUX/OAUO6lrK4kaetW9UQlvSTLigUNfS7KuaJ5RCJZQzpeOo8SBYHPl
         YPfw2rlG6BnY530aQwyzK9S67fh6nG1+VdTFldGxQsN62Nik22sSQA/I4lKRjZJwuIFx
         02g/bIgrVjWKqOZjFhy6aS4iUviUj+1gh5v3E1Z0kXbFfrMeC6bG6yHan6MlY8vRAqUc
         GTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9VPuMSJSoUHqzMeVGbAE30IrKxI8APrsEWW8ZWta/c=;
        b=g1ggNWTuYoE4ZkCM9qmlEv1oZMFO9+Mmil2q59hMrxGRxcTy1D1JLfRSDjtED6YrGT
         xD91q0UnGhpkGj6Xgd5ENb4wect4RTCUtbj1pH39pKypSjkTI9q98e+SykufadlTeWlO
         jGSykh+DgskkcbOQ3TKD/lqFXvObkaqX5ZLFQOmbNuxhmCFawj8M7DqC6pcjRv1HEImz
         K4M54rsSNM4KUrhMMcDrqWDCDTP/ItgOW9xh9wQPqxyZIi3bR9mC4npFmc8VMUpf5/r+
         YntLpJX2RSkz+jCUlhum6INUmYTfSMBqQVeiMhTeeLIDIEIV6iZOwBguJWRLZi/5Ktla
         VFhQ==
X-Gm-Message-State: AOAM530L3hFfUAGwr95V76bJoq9AtIVaJwGQ96ycyJCmrY5w9ZFrZFuy
        WMOW3hrJ0ESKfidDbSW/A+DGJueuWFW4xJgIEbHaiA==
X-Google-Smtp-Source: ABdhPJyWiVYnVdrf2lovSlQt3Ng19j8UcjWhnRFH32AdooP4ukqD0DcGQGxUswg/ja6zIoPYyJVqTr0YkWIUx1S9T+s=
X-Received: by 2002:a1c:27c3:: with SMTP id n186mr3780670wmn.96.1608290462078;
 Fri, 18 Dec 2020 03:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20201210134648.272857-1-maxime@cerno.tech> <20201210134648.272857-3-maxime@cerno.tech>
In-Reply-To: <20201210134648.272857-3-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Dec 2020 11:20:45 +0000
Message-ID: <CAPY8ntCuVWkZ6twBRPqDX_Vj5bP39pxLuHaEZ-FPveVt7VH=Yg@mail.gmail.com>
Subject: Re: [PATCH 02/15] drm/vc4: hdmi: Move hdmi reset to bind
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jason Cooper <jason@lakedaemon.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <popcornmix@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime & Dom

On Thu, 10 Dec 2020 at 13:46, Maxime Ripard <maxime@cerno.tech> wrote:
>
> From: Dom Cobley <popcornmix@gmail.com>
>
> The hdmi reset got moved to a later point in the commit 9045e91a476b
> ("drm/vc4: hdmi: Add reset callback").
>
> However, the reset now occurs after vc4_hdmi_cec_init and so tramples
> the setup of registers like HDMI_CEC_CNTRL_1
>
> This only affects pi0-3 as on pi4 the cec registers are in a separate
> block

It does mean that this reset only happens once on bind rather than on
every pre_crtc_configure, but as this really is the big reset the
entire block I don't see it needing to be triggered on every
configure.

> Fixes: 9045e91a476b ("drm/vc4: hdmi: Add reset callback")
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 8006bddc8fbb..3df1747dd917 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -773,9 +773,6 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder,
>                 return;
>         }
>
> -       if (vc4_hdmi->variant->reset)
> -               vc4_hdmi->variant->reset(vc4_hdmi);
> -
>         if (vc4_hdmi->variant->phy_init)
>                 vc4_hdmi->variant->phy_init(vc4_hdmi, vc4_conn_state);
>
> @@ -1865,6 +1862,9 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         vc4_hdmi->disable_wifi_frequencies =
>                 of_property_read_bool(dev->of_node, "wifi-2.4ghz-coexistence");
>
> +       if (vc4_hdmi->variant->reset)
> +               vc4_hdmi->variant->reset(vc4_hdmi);
> +
>         pm_runtime_enable(dev);
>
>         drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> --
> 2.28.0
>

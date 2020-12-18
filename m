Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7475A2DE410
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgLRObI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgLRObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:31:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CCC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:30:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e25so2793346wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSf/A3KMFP7l6dKoCFldn4orJN3Li1SRGvRFJDZdZBk=;
        b=FAxD2Y0NbqFM3ObrBbKO1uzFTAkuZkfq4nO0/y02pStuULzcEQVJ++qE6xjAOWSiMJ
         Z+zJK/11O7gH7sBtClCoRC44Lu5RNjqID1MNzTa4s/odoqiMyCdQE7nRSDhOIstJf1nv
         GoaY7I4IJDvHuiglAV1NWAN18RRDFPmabOcytUignipoOKlOQkMbQ+WDk0oqEuda5C8P
         eqDwlymwP/5kXCAkXMbeuU6nLmgGm8gdBKksDocR0F6Her14FIhXm+vqz+vCxEWde6iH
         Ui7oJC4E7fWuKt027IzbeCK6dw/U1rS3uFhcgxG/51fn3oVXly8LPUrMCwOpXTcbwavv
         jreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSf/A3KMFP7l6dKoCFldn4orJN3Li1SRGvRFJDZdZBk=;
        b=iN1K/wAuId5Wrouy40+0sHqy/66bCmU0pEY6aoHsJhKSaxxPanb0icWLbbUTQyLFuT
         bwCbHTARjHV11Q/ufeIrpuRMLn9YB+javNOHCNlsdTcVgReXpX0t5i7yGXnxgjnNuBNA
         936QRfGb59CLOJb6vPtt89AyUWYvQthm4XxQ7h4gg+ZZ5bSeRklsOTbF7V6X2rKizqGg
         yForbXoJAkRBt5rI8OVGLwhWp3JSjhvIcpnhfclUlQ/OucPmvSwFuwy+mM4v6pITj2XU
         PaFFoOu223Ffg7BFHe24v8tbF5XdQXFoznOppQT8nw6h0gUD1bbEeR76MqLFy5uhFOrz
         tFFw==
X-Gm-Message-State: AOAM532M/4u1tzz4BSIbG1UYO+RbGcwEwiP6EXsy8UkpaCVzmlOmyduD
        Qzjae7Ebq+AjmLggZe1Jq3D0qN8MsiUWdmiWKUaSKg==
X-Google-Smtp-Source: ABdhPJwZPxE2hgQD4zqrk0QkQvmTF5EOdTM22UN833i/JzSn6RMW16hnmxGVt7Jtvfucob2k4gTUusWtU/lA6XrmCQw=
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr4329681wme.183.1608301826242;
 Fri, 18 Dec 2020 06:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20201210134648.272857-1-maxime@cerno.tech> <20201210134648.272857-12-maxime@cerno.tech>
In-Reply-To: <20201210134648.272857-12-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Dec 2020 14:30:09 +0000
Message-ID: <CAPY8ntDRkw0FaAojjoPZykrDWN4zboGnDSCefoegAkCZ4PrMXw@mail.gmail.com>
Subject: Re: [PATCH 11/15] drm/vc4: hdmi: Remove cec_available flag
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

Hi Dom & Maxime

On Thu, 10 Dec 2020 at 13:47, Maxime Ripard <maxime@cerno.tech> wrote:
>
> From: Dom Cobley <popcornmix@gmail.com>
>
> Now that our HDMI controller supports CEC for the BCM2711, let's remove
> that flag.
>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ----
>  drivers/gpu/drm/vc4/vc4_hdmi.h | 3 ---
>  2 files changed, 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index d208b7d1d937..327638d93032 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1658,9 +1658,6 @@ static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
>         u32 value;
>         int ret;
>
> -       if (!vc4_hdmi->variant->cec_available)
> -               return 0;
> -
>         vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
>                                                   vc4_hdmi, "vc4",
>                                                   CEC_CAP_DEFAULTS |
> @@ -2074,7 +2071,6 @@ static const struct vc4_hdmi_variant bcm2835_variant = {
>         .debugfs_name           = "hdmi_regs",
>         .card_name              = "vc4-hdmi",
>         .max_pixel_clock        = 162000000,
> -       .cec_available          = true,
>         .registers              = vc4_hdmi_fields,
>         .num_registers          = ARRAY_SIZE(vc4_hdmi_fields),
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index 27352827f70c..c93ada62f429 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -42,9 +42,6 @@ struct vc4_hdmi_variant {
>         /* Filename to expose the registers in debugfs */
>         const char *debugfs_name;
>
> -       /* Set to true when the CEC support is available */
> -       bool cec_available;
> -
>         /* Maximum pixel clock supported by the controller (in Hz) */
>         unsigned long long max_pixel_clock;
>
> --
> 2.28.0
>

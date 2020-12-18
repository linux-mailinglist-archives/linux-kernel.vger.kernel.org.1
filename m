Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893822DE3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgLROWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgLROWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:22:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A3C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:21:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a6so2502895wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yg/DSJRdrLy0HhUNnHE4yMYxJ8sJyjH42WoCIL2vO8M=;
        b=avagjLPPM/4TenYe+5NFwMYfDv5mkadG3/FGaqQJLbxamQObpsp1s2ti8eQdTXtaon
         heMFa1Ff+s1WmQ5BcoX6PZE51lm02DR21bsPKye3xLeNIpzlKnjBTOsTlOX1gQGLyb3W
         jIosaRHbAPDeU7U6WTAJ/yewyQo84s5nju4Jc5A8OK+PsfIfgcE60gmTN9Q2kDYxR92d
         uLTno9x8L4yrdnyVTAZ9RD7dpCqW/8Gpam/AhLRr3e1hVqNm/6Zn7TJMigJnLdUJeBJ0
         goVEXQyOJ3gnNQTFRAoYuaIdcsEMbvjvhcnJC+6HST790kZh+omIAfT9GDznlD7avlSd
         HBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yg/DSJRdrLy0HhUNnHE4yMYxJ8sJyjH42WoCIL2vO8M=;
        b=J3TGWJ0+wD4shP19b9sdnsVcvOSoyJK7rlhxjEAcnTLgcn4u4xr3O1noUxcwozEMLS
         4lJ9CmPcNOxcyRM9z4YDd3XIt38zMu1yoF5Fb/wNv3M9AN193Z8k7tRIh6dU9dJep5X/
         rp4P/upJ9v6LcTZA6L9dBGoqSEn7KdhmFhez2/XFBhDW0Z9SOYNUSfpe1rjD1p/18IGF
         EJCmQdp8sdY/5dO7caidZ4JqQCBvS//b/fwJs2S7FSFYyIkHgELU8MeSJ20E6X+tWGfa
         5zlsNo4bFFFN1dAauSdYgx6EkidlYyhC8MB4q+Liji9I2rriru5p08snieHFfEV/EJBK
         TYdw==
X-Gm-Message-State: AOAM532PFLAmUT3z8KTK80kGIQ39auViLsD6z/FQ2AtPWk/3vTwvugNO
        +/FO8aLhqXlrarGCQl/aHKjfMqAmCyWDykFP9I7ZDQ==
X-Google-Smtp-Source: ABdhPJyt9fDcXOzHI8EKkCqBDVJFYeA5WQWNbsZGass3dzm1SJFYCDEWIUPq84vwnQjLtV5mIEeDN0G9jubDadFmIHE=
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr4418480wmc.158.1608301296016;
 Fri, 18 Dec 2020 06:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20201210134648.272857-1-maxime@cerno.tech> <20201210134648.272857-6-maxime@cerno.tech>
In-Reply-To: <20201210134648.272857-6-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Dec 2020 14:21:18 +0000
Message-ID: <CAPY8ntDXJWR-vssSLsRbh7RTd-40SQApOxWGwt2LkeoyxCdYMw@mail.gmail.com>
Subject: Re: [PATCH 05/15] drm/vc4: hdmi: Restore cec physical address on reconnect
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

Hi  Maxime & Dom

On Thu, 10 Dec 2020 at 13:47, Maxime Ripard <maxime@cerno.tech> wrote:
>
> From: Dom Cobley <popcornmix@gmail.com>
>
> Currently we call cec_phys_addr_invalidate on a hotplug deassert.
> That may be due to a TV power cycling, or an AVR being switched
> on (and switching edid).
>
> This makes CEC unusable since our controller wouldn't have a physical
> address anymore.
>
> Set it back up again on the hotplug assert.
>
> Fixes: 15b4511a4af6 ("drm/vc4: add HDMI CEC support")
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 28b78ea885ea..eff3bac562c6 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -136,20 +136,29 @@ static enum drm_connector_status
>  vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
>  {
>         struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
> +       bool connected = false;
>
>         if (vc4_hdmi->hpd_gpio) {
>                 if (gpio_get_value_cansleep(vc4_hdmi->hpd_gpio) ^
>                     vc4_hdmi->hpd_active_low)
> -                       return connector_status_connected;
> -               cec_phys_addr_invalidate(vc4_hdmi->cec_adap);
> -               return connector_status_disconnected;
> -       }
> -
> -       if (drm_probe_ddc(vc4_hdmi->ddc))
> -               return connector_status_connected;
> -
> +                       connected = true;
> +       } else if (drm_probe_ddc(vc4_hdmi->ddc))
> +               connected = true;
>         if (HDMI_READ(HDMI_HOTPLUG) & VC4_HDMI_HOTPLUG_CONNECTED)

This needs to become an "else if(...".
It used to be that all the other paths would return, so were mutually
exclusive to this. Now they set a thing and keep going we need to
avoid reading the register should there be a HPD gpio or the ddc probe
succeeds.
Memory says that otherwise Pi3 always reports connected.

I fixed this in a downstream patch already -
https://github.com/raspberrypi/linux/commit/d345caec1e9b2317b9cd7eb5b92ae453a0d3e98c

Otherwise fine.

  Dave

> +               connected = true;
> +       if (connected) {
> +               if (connector->status != connector_status_connected) {
> +                       struct edid *edid = drm_get_edid(connector, vc4_hdmi->ddc);
> +
> +                       if (edid) {
> +                               cec_s_phys_addr_from_edid(vc4_hdmi->cec_adap, edid);
> +                               vc4_hdmi->encoder.hdmi_monitor = drm_detect_hdmi_monitor(edid);
> +                               drm_connector_update_edid_property(connector, edid);
> +                               kfree(edid);
> +                       }
> +               }
>                 return connector_status_connected;
> +       }
>         cec_phys_addr_invalidate(vc4_hdmi->cec_adap);
>         return connector_status_disconnected;
>  }
> --
> 2.28.0
>

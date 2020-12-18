Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5922DE40E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgLROaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgLROaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:30:13 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6675C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:29:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q75so2789467wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 06:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQcnaVeKn76lYRwiXKR4yvTyQ/9Lgo43QJdLzaw88No=;
        b=dPH2ZMGlXf7qxs4VLNk1sqQ6DOFTn3EJphiLC07Hd/sKNpQ9O+b48p1oN5bMMLsNcw
         hUCxxdBSaWxlRLCiL9I/Tfv7Ip15ldWsKrB+y0tzx17DQZbd5X0qybJL4dS6oezkjXuL
         1YSWS2M66tLqmHYc3wFa0FqObn3OYwwVpqrlVgWf01NBCJq8VBu1OVSdI4xzZvIqedxg
         0eUb8r35JQVUXYis0AZPc+9VNUaDtE9dWc6DIn2A/6aZsBXFJBtRfvgj9tL/HyxINwoa
         hYGargZwS5AyYExBC9Pyy1MRNHD2HRaJI2tnVrHRDiAkjnG+32WYgMNbODrH25LBY6hy
         w3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQcnaVeKn76lYRwiXKR4yvTyQ/9Lgo43QJdLzaw88No=;
        b=DEl2svOJE7J/MijSxHxWSCXhsnfdCaCD1JSwQx9MgD1ZtrKGDGGiRbvSl86kqyk/2Y
         C1Zdx6LUwVFLOTVk6aSHntLhJCqNvR6L2lGEAdFl1tNy5pS51pPHFcSgIrrRDKjKIFp7
         KVyDptM11Rwf/8JJL95Jb6s57ecw6F2XjI244GbfpGF2983JBPgCciyyXJ21kKjF9Q0j
         OuY7/t+9JFJ6TbB341m81WSsfW79XnTPchlSgqJA/HGk9LtgZxhMsqetoOfPOUmtsSwL
         16v6ZADYuCPgoWNiRbYrh82Dj0GJaa2V6Sw2a9zvUz94WdvG2ZYmDZrDfaZisqYWZv9y
         z0oA==
X-Gm-Message-State: AOAM532SgTSiopYwF32mYzeErh89iW/1Lfp5yqMyAGiSRE5zLMM25+Cu
        LST+ykcT6JpMKmzygg+/sX2444Rb5qwyFoNzplOPhA==
X-Google-Smtp-Source: ABdhPJx1zfDnyXEmVWiw9EZm8yj56h7EPNv2EiQk8r5FgzIdRnBEqEC4Oc6xyUqbtGIHIlNzOeHBGh+HWy5KnmgE0kE=
X-Received: by 2002:a1c:bc88:: with SMTP id m130mr4645539wmf.82.1608301771650;
 Fri, 18 Dec 2020 06:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20201210134648.272857-1-maxime@cerno.tech> <20201210134648.272857-13-maxime@cerno.tech>
In-Reply-To: <20201210134648.272857-13-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 18 Dec 2020 14:29:14 +0000
Message-ID: <CAPY8ntCkFU47CJmDf_E1RVgprscq=BYj4o2=8ReTOfe8hd0d0Q@mail.gmail.com>
Subject: Re: [PATCH 12/15] drm/vc4: hdmi: Don't register the CEC adapter if
 there's no interrupts
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
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 at 13:47, Maxime Ripard <maxime@cerno.tech> wrote:
>
> We introduced the BCM2711 support to the vc4 HDMI controller with 5.10,
> but this was lacking any of the interrupts of the CEC controller so we
> have to deal with the backward compatibility.
>
> Do so by simply ignoring the CEC setup if the DT doesn't have the
> interrupts property.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 327638d93032..69217c68d3a4 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1655,9 +1655,15 @@ static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
>  {
>         struct cec_connector_info conn_info;
>         struct platform_device *pdev = vc4_hdmi->pdev;
> +       struct device *dev = &pdev->dev;
>         u32 value;
>         int ret;
>
> +       if (!of_find_property(dev->of_node, "interrupts", NULL)) {
> +               dev_warn(dev, "'interrupts' DT property is missing, no CEC\n");
> +               return 0;
> +       }
> +
>         vc4_hdmi->cec_adap = cec_allocate_adapter(&vc4_hdmi_cec_adap_ops,
>                                                   vc4_hdmi, "vc4",
>                                                   CEC_CAP_DEFAULTS |
> --
> 2.28.0
>

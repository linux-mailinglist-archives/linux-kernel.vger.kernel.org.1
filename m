Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6654C2DABF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgLOLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgLOLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:24:19 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C620C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:23:39 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a12so19458152wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfMSQatGMWNZ2UIzROdV1pX/rfI9pwbGhSWYVlJrJZE=;
        b=eXE+Lb4dOZbQV4Mve43qbM4rizFy7cQaqgbo9Sd7txHpXvnvKlsSwuS31p4dUt3g8l
         TY3A5NbK0k+xkwNjyzP36ek+RmXOTppJsTgpEBkdidDJ4Y/gC6k8qL5F3T5ck+3kti35
         tGgnqHmmOMCTtdJV8eSX4EwlxPBd9yK7CNhn+abP3TuwP0EhoRP3IKB7Vt/Hbof/elpP
         WiF+a0xQrLncak0A9c5ijvEEeeNYVGUsT9Sa7lrLjSrfaI/adqRARKGxBLa5YZqG7l+M
         X5fp0UKriviDiWVmxgGunA/ylIAXMF59Ahka6iyGuuRHzednnNENC+Eb5oHwKMQIXFgF
         /zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfMSQatGMWNZ2UIzROdV1pX/rfI9pwbGhSWYVlJrJZE=;
        b=WfLkSX1t3Nca5ikyG4nA3RAGdmn2lXo6O63CLZ9KUY8ZgKI0V4+MMNUy89K77YSMRY
         Erbaj+OFTDh+D/NBbk5/8u+wynd0TgK9YqvzpImIjbpdN/NOJMY5oAVL/hVLwSkrkfzw
         cVGd6iQINtCRrSrmjq01fKiSTtOdWU/fIXROWENZPtGPG/yKYOODbe78yk8XC+NHb2it
         MUuvkrNzcIOG8Ppid5srJyEPiOalIKwfV5oxiaW3/A5y8g1LW0XH80LXLy5x68c4OIEN
         ujAqYH0CildRO9BYEVjQ1mmqCIVaG6Vta+bg1KXFyeUScZzpwaoZbKHAy51678G4ktpz
         r86w==
X-Gm-Message-State: AOAM532dzub2wE64m1m5F16QZXwaqqWiVlWnGBk0zxtjy1PVTsTDCEys
        tJp1ElO60hpHsFkZqviRj/aL5BIvjxOfoPeHL7fO9A==
X-Google-Smtp-Source: ABdhPJx+sM7fMbriohJGobmth2ydPm3qvpHoTFwjRws9SUq0A20IN0zEsSlLodomgkvY6en9cyG7kd2SKzCFtcfG9e8=
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr11821446wrq.47.1608031418169;
 Tue, 15 Dec 2020 03:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20201210134648.272857-1-maxime@cerno.tech> <20201210134648.272857-4-maxime@cerno.tech>
In-Reply-To: <20201210134648.272857-4-maxime@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 15 Dec 2020 11:23:22 +0000
Message-ID: <CAPY8ntAijv1qdOz8qWkofXSpCa85cEOPSiuUacLrM2xOSkjWYw@mail.gmail.com>
Subject: Re: [PATCH 03/15] drm/vc4: hdmi: Fix register offset with longer CEC messages
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

On Thu, 10 Dec 2020 at 13:46, Maxime Ripard <maxime@cerno.tech> wrote:
>
> From: Dom Cobley <popcornmix@gmail.com>
>
> The code prior to 311e305fdb4e ("drm/vc4: hdmi: Implement a register
> layout abstraction") was relying on the fact that the register offset
> was incremented by 4 for each readl call. That worked since the register
> width is 4 bytes.
>
> However, since that commit the HDMI_READ macro is now taking an enum,
> and the offset doesn't increment by 4 but 1 now. Divide the index by 4
> to fix this.
>
> Fixes: 311e305fdb4e ("drm/vc4: hdmi: Implement a register layout abstraction")
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 3df1747dd917..28b78ea885ea 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1434,13 +1434,20 @@ static irqreturn_t vc4_cec_irq_handler_thread(int irq, void *priv)
>
>  static void vc4_cec_read_msg(struct vc4_hdmi *vc4_hdmi, u32 cntrl1)
>  {
> +       struct drm_device *dev = vc4_hdmi->connector.dev;
>         struct cec_msg *msg = &vc4_hdmi->cec_rx_msg;
>         unsigned int i;
>
>         msg->len = 1 + ((cntrl1 & VC4_HDMI_CEC_REC_WRD_CNT_MASK) >>
>                                         VC4_HDMI_CEC_REC_WRD_CNT_SHIFT);
> +
> +       if (msg->len > 16) {
> +               drm_err(dev, "Attempting to read too much data (%d)\n", msg->len);
> +               return;
> +       }
> +
>         for (i = 0; i < msg->len; i += 4) {
> -               u32 val = HDMI_READ(HDMI_CEC_RX_DATA_1 + i);
> +               u32 val = HDMI_READ(HDMI_CEC_RX_DATA_1 + (i >> 2));
>
>                 msg->msg[i] = val & 0xff;
>                 msg->msg[i + 1] = (val >> 8) & 0xff;
> @@ -1533,11 +1540,17 @@ static int vc4_hdmi_cec_adap_transmit(struct cec_adapter *adap, u8 attempts,
>                                       u32 signal_free_time, struct cec_msg *msg)
>  {
>         struct vc4_hdmi *vc4_hdmi = cec_get_drvdata(adap);
> +       struct drm_device *dev = vc4_hdmi->connector.dev;
>         u32 val;
>         unsigned int i;
>
> +       if (msg->len > 16) {
> +               drm_err(dev, "Attempting to transmit too much data (%d)\n", msg->len);
> +               return -ENOMEM;
> +       }
> +
>         for (i = 0; i < msg->len; i += 4)
> -               HDMI_WRITE(HDMI_CEC_TX_DATA_1 + i,
> +               HDMI_WRITE(HDMI_CEC_TX_DATA_1 + (i >> 2),
>                            (msg->msg[i]) |
>                            (msg->msg[i + 1] << 8) |
>                            (msg->msg[i + 2] << 16) |
> --
> 2.28.0
>

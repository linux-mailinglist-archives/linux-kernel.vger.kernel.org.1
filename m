Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFFA275196
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgIWGef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIWGed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:34:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E64C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 23:34:32 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lo4so26134407ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 23:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJXfV81t/sXYl4JgftuDRtEbB8599Smh1I+VQSzWSeE=;
        b=Qt4u0jAOa3Xtg8NwEC6733GHoTotQMbK+cv3/dl/9k9bmkFORy7UNm2RRRuEt3fUDp
         mpEQo7f9MlB3ipYPGQCtiEFuRB5Z100GHmmKLQxZH5b78903jGBatxea2H81tGXJ/2JQ
         lsag7Ig3ErS1ZZMLOiM0dVIERN6W+X3mn3tvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJXfV81t/sXYl4JgftuDRtEbB8599Smh1I+VQSzWSeE=;
        b=oAr+Pt/xWb6iWS4mMZSKIp1MaVhyuT6pvzN+9P8O0tbxfc4d4ZcggHMewwfdf7T1s0
         b9cQ/6ED7oz4Vr3VtHPqlak2LhqntPtEuIIdbwU0l4u2EfoDPl5KH5Im/1p7pNxGx9MW
         VPIjkD2Zg5+Xjf4Q6bqv+IiH5PpdcIJLbNzwMFYR5M9XSPbpS0tTWloWcZQT7RnsakEJ
         er1DEy9dDpl9O985O4hBGwfidywYlStPS/8vaAKzy01V64N6+aGhGfrEZ47ZAVqQJXdY
         l33KBGoeirVvyu8IQc/PnQ5rmyxVQUvvCGOttG6lOoN2fbH9GdTovRJ0cTDSKGJxQpgh
         v5Jw==
X-Gm-Message-State: AOAM531poTsl+8lpLu4GLuYzjOfqn0VJ5uCus9djWSApbUSdZh6XNpZ1
        EokzoeNQ5cNwqW+yO0Wmipqtx2iv1WNeU6U0zEa7FA==
X-Google-Smtp-Source: ABdhPJxVp0i9LV/h1/bBJ7dAOqBc+Foo/bYGPSvrZYzkvDkdDb8Y/5tW5bGvpIFjzyKvdVgsVvpISbgglQCSu2pQ6Yg=
X-Received: by 2002:a17:906:4c81:: with SMTP id q1mr8550168eju.72.1600842871347;
 Tue, 22 Sep 2020 23:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200904021029.365700-1-allen.chen@ite.com.tw>
In-Reply-To: <20200904021029.365700-1-allen.chen@ite.com.tw>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Wed, 23 Sep 2020 14:33:55 +0800
Message-ID: <CANdKZ0erkp_S-K_QpH-9dvEDR9THypLxTT3s+0aZQUaNDoZM-w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: add it6505 driver
To:     allen <allen.chen@ite.com.tw>
Cc:     Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Yilun Lin <yllin@google.com>,
        kernel test robot <lkp@intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 10:17 AM allen <allen.chen@ite.com.tw> wrote:
>
> This adds support for the iTE IT6505.
> This device can convert DPI signal to DP output.
>
> From: Allen Chen <allen.chen@ite.com.tw>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Signed-off-by: Yilun Lin <yllin@google.com>
> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig      |    7 +
>  drivers/gpu/drm/bridge/Makefile     |    1 +
>  drivers/gpu/drm/bridge/ite-it6505.c | 3338 +++++++++++++++++++++++++++
>  3 files changed, 3346 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 3e11af4e9f63e..f21dce3fabeb9 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -61,6 +61,13 @@ config DRM_LONTIUM_LT9611
>           HDMI signals
>           Please say Y if you have such hardware.
>
> +config DRM_ITE_IT6505
> +       tristate "ITE IT6505 DisplayPort bridge"
> +       depends on OF
> +       select DRM_KMS_HELPER
> +       help
> +         ITE IT6505 DisplayPort bridge chip driver.
> +
>  config DRM_LVDS_CODEC
>         tristate "Transparent LVDS encoders and decoders support"
>         depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index c589a6a7cbe1d..8a118fd901ad7 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>  obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
>  obj-$(CONFIG_DRM_DISPLAY_CONNECTOR) += display-connector.o
>  obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
> +obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
>  obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
>  obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> new file mode 100644
> index 0000000000000..0ed19673431ee
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> ...
> +
> +static void __maybe_unused it6505_delayed_audio(struct work_struct *work)
> +{
> +       struct it6505 *it6505 = container_of(work, struct it6505,
> +                                            delayed_audio.work);
> +
> +       DRM_DEV_DEBUG_DRIVER(&it6505->client->dev, "start");
> +
> +       if (!it6505->powered)
> +               return;
> +
> +       if (!it6505->enable_drv_hold)
> +               it6505_enable_audio(it6505);
> +}
> +
> +static int __maybe_unused it6505_audio_setup_hw_params(struct it6505 *it6505,
> +                                       struct hdmi_codec_params *params)
> +{
> +       struct device *dev = &it6505->client->dev;
> +       int i = 0;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "%s %d Hz, %d bit, %d channels\n", __func__,
> +                            params->sample_rate, params->sample_width,
> +                            params->cea.channels);
> +
> +       if (!it6505->bridge.encoder)
> +               return -ENODEV;
> +
> +       if (params->cea.channels <= 1 || params->cea.channels > 8) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "channel number: %d not support",
> +                                    it6505->audio.channel_count);
> +               return -EINVAL;
> +       }
> +
> +       it6505->audio.channel_count = params->cea.channels;
> +
> +       while (i < ARRAY_SIZE(audio_sample_rate_map) &&
> +              params->sample_rate !=
> +                      audio_sample_rate_map[i].sample_rate_value) {
> +               i++;
> +       }
> +       if (i == ARRAY_SIZE(audio_sample_rate_map)) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "sample rate: %d Hz not support",
> +                                    params->sample_rate);
> +               return -EINVAL;
> +       }
> +       it6505->audio.sample_rate = audio_sample_rate_map[i].rate;
> +
> +       switch (params->sample_width) {
> +       case 16:
> +               it6505->audio.word_length = WORD_LENGTH_16BIT;
> +               break;
> +       case 18:
> +               it6505->audio.word_length = WORD_LENGTH_18BIT;
> +               break;
> +       case 20:
> +               it6505->audio.word_length = WORD_LENGTH_20BIT;
> +               break;
> +       case 24:
> +       case 32:
> +               it6505->audio.word_length = WORD_LENGTH_24BIT;
> +               break;
> +       default:
> +               DRM_DEV_DEBUG_DRIVER(dev, "wordlength: %d bit not support",
> +                                    params->sample_width);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static void __maybe_unused it6505_audio_shutdown(struct device *dev, void *data)
> +{
> +       struct it6505 *it6505 = dev_get_drvdata(dev);
> +
> +       if (it6505->powered)
> +               it6505_disable_audio(it6505);
> +}
> +
> +static int __maybe_unused it6505_audio_hook_plugged_cb(struct device *dev,
> +                                                      void *data,
> +                                                      hdmi_codec_plugged_cb fn,
> +                                                      struct device *codec_dev)
> +{
> +       struct it6505 *it6505 = data;
> +
> +       it6505->plugged_cb = fn;
> +       it6505->codec_dev = codec_dev;
> +       it6505_plugged_status_to_codec(it6505);
> +
> +       return 0;
> +}

These four functions about audio seem to be unused. Move them (and
other audio related changes) into another patch.

> +
> ...
> 2.25.1
>

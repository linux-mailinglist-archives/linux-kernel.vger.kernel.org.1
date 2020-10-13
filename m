Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B8D28D374
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgJMSJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgJMSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:09:52 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F9DC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:09:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p16so1166348ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TE2fl/qyE0ZlA7fIvI5O4hrdLbHdTXQxQKy8JK0q3BA=;
        b=ubAscvvyW2B6KLNtkBbazSIC4pm8TD4sdIhBQKaONsIrvYUNTpwqjGh/HXGxu6zGk0
         QMxkSXVje4iKactBly7HjjNN/Y85LHLDjqSzy5vu8PqdsRIS4VQ0vo4ISr/RZyXRO1SW
         5vNVVqzKHMzQBznwTOESTZiKZFfNp/W7Kpqypn7NRp7LLhLUumuvVEJfoj3CV50qYONP
         NEqjQtrHmuYbf+0KS6HlLncpkER5ADcJzKYGbVoaUi7D6+GcFEYVTgYCWVxtyi1dhqEK
         ctbwf++/BSJI/rgrNp/BxtVtgFW2A3Cy7KCixpdFox8y8aWKlwMY43ktplNzprK5rueD
         6jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TE2fl/qyE0ZlA7fIvI5O4hrdLbHdTXQxQKy8JK0q3BA=;
        b=HJZTbX0vo8ROEc3XYVUmQPF17RHRNX7o0l9VoqJF86me0BoVQWstY9DfwyPNAC1Pmo
         3SDvIGUmuvRR4+KVVjYgC8czik5yCGwFa2KRju60NiS8KQtIxdw3zzmXbBxT0mjeJSIT
         k/yl30VSm3nO3mFejE/leJCcqoMKaf0n4yBVlVec7p8CEoJgcsVla5aQAIbRrJEZ+I0/
         MPzjkrKvmfv/LblWCZaoVVKb9CPK6I/M97zFThF0rS7afnc+0trkFI+43qrLUoRjt9j3
         2g6/UWndF80+cK7B9ExEN9wpIJZ+RWSz9eAIQEnlbE8+Hosp988aErqb1nyFg0poW3FM
         2w7Q==
X-Gm-Message-State: AOAM532HsRjpC7EZMmy3h0enH2UCr/2Ek/cX9Kk6aVIWq/yHbX/lm7qu
        S/YoSInhuByxaSVkCEO0d1RmjsCMshUQow4RKuEP703X6rpPNg==
X-Google-Smtp-Source: ABdhPJwY3+uca79dB+DpzD2BqWxy386/q68+0Wx8eiiTzy3ZbGd3JtUUxsWGLmmvtTcD5QGvD2EdLVGpuAGKbrC8vgk=
X-Received: by 2002:a92:7914:: with SMTP id u20mr966643ilc.203.1602612590574;
 Tue, 13 Oct 2020 11:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201013172832.4055545-1-fparent@baylibre.com> <20201013172832.4055545-2-fparent@baylibre.com>
In-Reply-To: <20201013172832.4055545-2-fparent@baylibre.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Tue, 13 Oct 2020 20:09:39 +0200
Message-ID: <CAOwMV_wo0SeXRbX-8+ipTr3zcYNPZ4fNF7-Xf8hX0RYP_EAOsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mediatek: mtk_hdmi: add MT8167 support for HDMI
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        p.zabel@pengutronix.de, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 7:28 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add support for HDMI on MT8167. HDMI on MT8167 is similar to
> MT8173/MT2701 execpt for the two registers: SYS_CFG1C and SYS_CFG20
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c      | 7 +++++++
>  drivers/gpu/drm/mediatek/mtk_hdmi_regs.h | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index c70f195c21be..7762be5cb446 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1835,9 +1835,16 @@ static struct mtk_hdmi_data mt8173_hdmi_driver_data = {
>         .sys_cfg20 = HDMI_SYS_CFG20,
>  };
>
> +static struct mtk_hdmi_conf mt8167_hdmi_driver_data = {

Sent the wrong patch. Sending v2 soon.

> +       .sys_cfg1c = MT8167_HDMI_SYS_CFG1C,
> +       .sys_cfg20 = MT8167_HDMI_SYS_CFG20,
> +};
> +
>  static const struct of_device_id mtk_drm_hdmi_of_ids[] = {
>         { .compatible = "mediatek,mt8173-hdmi",
>           .data = &mt8173_hdmi_driver_data },
> +       { .compatible = "mediatek,mt8167-hdmi",
> +         .data = &mt8167_hdmi_driver_data },
>         {}
>  };
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> index 2050ba45b23a..a0f9c367d7aa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs.h
> @@ -195,6 +195,7 @@
>  #define GEN_RGB                                (0 << 7)
>
>  #define HDMI_SYS_CFG1C         0x000
> +#define MT8167_HDMI_SYS_CFG1C  0x800
>  #define HDMI_ON                                BIT(0)
>  #define HDMI_RST                       BIT(1)
>  #define ANLG_ON                                BIT(2)
> @@ -211,6 +212,7 @@
>  #define HTPLG_PIN_SEL_OFF              BIT(30)
>  #define AES_EFUSE_ENABLE               BIT(31)
>  #define HDMI_SYS_CFG20         0x004
> +#define MT8167_HDMI_SYS_CFG20  0x804
>  #define DEEP_COLOR_MODE_MASK           (3 << 1)
>  #define COLOR_8BIT_MODE                        (0 << 1)
>  #define COLOR_10BIT_MODE               (1 << 1)
> --
> 2.28.0
>

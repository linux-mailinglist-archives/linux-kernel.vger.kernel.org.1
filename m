Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C02699E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgINXoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgINXoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:44:16 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5654321741
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600127055;
        bh=+OhI6QNHCUTezEy3dC8zYNoj1C1U2IUoG/B2Kdfhl0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tldsgMhMqLV/lzvk9W8V5/yK35Olz+LfV3L7KOMtcrLzTTSw9fIEELANJodDHRdQD
         B2T06DyfTxiJHGrZBjdCQxk84dzjB+FaMfaCJZXZ86nBGTk2e53cS8NF4dcy4+EixH
         rkXN5fe+bf0vsl7ZMkLPt9XaQOHrlWvtn5Lg5UjE=
Received: by mail-ej1-f43.google.com with SMTP id j11so2448065ejk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:44:15 -0700 (PDT)
X-Gm-Message-State: AOAM530fltDM4saGtPeBRip9PJaih86Yo4/ZLnnanEnSIJH2476c3e85
        apJaEj735j8lybvlfOaLEBpaRRZiFkdQW99wSQ==
X-Google-Smtp-Source: ABdhPJyYu9jlk9XD95lFQa7HI5Qb4vp8g0UXjCYsPMegPd9apv/vOGC9kUF8wL49jyw/7LJM+MYuJZzZHH36b+Lyj/4=
X-Received: by 2002:a17:906:8690:: with SMTP id g16mr16850817ejx.187.1600127053936;
 Mon, 14 Sep 2020 16:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200911112151.3220469-1-yukuai3@huawei.com>
In-Reply-To: <20200911112151.3220469-1-yukuai3@huawei.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 15 Sep 2020 07:44:03 +0800
X-Gmail-Original-Message-ID: <CAAOTY__jzUgrz9UuRFn104ePfMY5sR4vLuRRFNWVO=1naZUntw@mail.gmail.com>
Message-ID: <CAAOTY__jzUgrz9UuRFn104ePfMY5sR4vLuRRFNWVO=1naZUntw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: add missing put_device() call in mtk_hdmi_dt_parse_pdata()
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        jie.qiu@mediatek.com, junzhi.zhao@mediatek.com,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yu Kuai:

Yu Kuai <yukuai3@huawei.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8811=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> if of_find_device_by_node() succeed, mtk_drm_kms_init() doesn't have
> a corresponding put_device(). Thus add jump target to fix the exception
> handling for this function implementation.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index f2e9b429960b..a97725680d4e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1507,25 +1507,30 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdm=
i *hdmi,
>                 dev_err(dev,
>                         "Failed to get system configuration registers: %d=
\n",
>                         ret);
> -               return ret;
> +               goto put_device;
>         }
>         hdmi->sys_regmap =3D regmap;
>
>         mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         hdmi->regs =3D devm_ioremap_resource(dev, mem);
> -       if (IS_ERR(hdmi->regs))
> -               return PTR_ERR(hdmi->regs);
> +       if (IS_ERR(hdmi->regs)) {
> +               ret =3D PTR_ERR(hdmi->regs);
> +               goto put_device;
> +       }
>
>         remote =3D of_graph_get_remote_node(np, 1, 0);
> -       if (!remote)
> -               return -EINVAL;
> +       if (!remote) {
> +               ret =3D -EINVAL;
> +               goto put_device;
> +       }
>
>         if (!of_device_is_compatible(remote, "hdmi-connector")) {
>                 hdmi->next_bridge =3D of_drm_find_bridge(remote);
>                 if (!hdmi->next_bridge) {
>                         dev_err(dev, "Waiting for external bridge\n");
>                         of_node_put(remote);
> -                       return -EPROBE_DEFER;
> +                       ret =3D -EPROBE_DEFER;
> +                       goto put_device;
>                 }
>         }
>
> @@ -1534,7 +1539,8 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi =
*hdmi,
>                 dev_err(dev, "Failed to find ddc-i2c-bus node in %pOF\n",
>                         remote);
>                 of_node_put(remote);
> -               return -EINVAL;
> +               ret =3D -EINVAL;
> +               goto put_device;
>         }
>         of_node_put(remote);
>
> @@ -1542,10 +1548,14 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdm=
i *hdmi,
>         of_node_put(i2c_np);
>         if (!hdmi->ddc_adpt) {
>                 dev_err(dev, "Failed to get ddc i2c adapter by node\n");
> -               return -EINVAL;
> +               ret =3D -EINVAL;
> +               goto put_device;
>         }
>
>         return 0;
> +put_device:
> +       put_device(hdmi->cec_dev);
> +       return ret;
>  }
>
>  /*
> --
> 2.25.4
>

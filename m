Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0A52DAE22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgLONj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbgLONir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:38:47 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A26DC06138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:38:07 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id q10so10951275vsr.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 05:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FgvEA6LpRqaZRiWRCs1HzkpZ2wxH4J/Kj/S8yl9EX8=;
        b=aMDDKyWXNebTeXg5FMLCK9txB+AXo41QnAw7eILkX0NTeyAdt7jEx4r62/kGLfIHLY
         NTdTfInWItH7WmdFOmFWrs0hZxC8xA4+JavAwYl1jp8pksKKMo4VeyPHa4XewnixNL71
         5zM6Wgsl4rhnbDaXq2EpMe4o9FfwGh7clMUv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FgvEA6LpRqaZRiWRCs1HzkpZ2wxH4J/Kj/S8yl9EX8=;
        b=V/4PaRL180pRZtPPRwS+Z4wwJJ5BblC/kLX60N8bKa7xtou+ZmnkwWVCpjO1jDtRpy
         cfwy6A9TzU7+mUoNY+KWi3WVLR+SRyD3G6eo1VGYoVsNSw2OWZFXQzLV4Rm/OhjPwPbk
         YfbqYGTz1p/pX0aObyZN+/L6bJEaRM0hhIwwQxJM4B8PMdeIaDV3TyyP+v7UkxsGuelm
         Jly0UPW0UdobJc+xvZCTL3k1QybPXg+EMwx1A4QGali5qNvNES6LjSPoPqeOEve0vdAn
         MJwpRgehbhPiHGbSbKnGXcYalY1YeTjGtsbpqfd2fVqJqP8wkMomv6FogPfB6QS5irnr
         4n9A==
X-Gm-Message-State: AOAM530gARKR8+FXIpddmMwI1hK8bwRnzPyMeq5FjF3SZoutcQPfXKDp
        8Xx2MVPbss81S15YL5Iga2ihJVHvlJievrQQUdgPUw==
X-Google-Smtp-Source: ABdhPJw2pSaiM6ovuzcTeKxy3DP6Ku+SVy15pyfTwAwM3z1ikPI1R8D7O7JPHcMCx/NBwXhCbuTiLeGCivpmnPRuZRE=
X-Received: by 2002:a67:5c03:: with SMTP id q3mr26997421vsb.47.1608039486303;
 Tue, 15 Dec 2020 05:38:06 -0800 (PST)
MIME-Version: 1.0
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com> <1607746317-4696-8-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1607746317-4696-8-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 15 Dec 2020 21:37:55 +0800
Message-ID: <CANMq1KCbmW4kbY5rbuogr9JJD5c5=-qatFs-EaWbuAxSzWmnLQ@mail.gmail.com>
Subject: Re: [PATCH v2, 07/17] drm/mediatek: add disp config and mm 26mhz
 clock into mutex device
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 12:12 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> there are 2 more clock need enable for display.
> parser these clock when mutex device probe,
> enable and disable when mutex on/off
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 49 ++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 60788c1..de618a1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -118,7 +118,7 @@ struct mtk_ddp_data {
>
>  struct mtk_ddp {
>         struct device                   *dev;
> -       struct clk                      *clk;
> +       struct clk                      *clk[3];
>         void __iomem                    *regs;
>         struct mtk_disp_mutex           mutex[10];
>         const struct mtk_ddp_data       *data;
> @@ -257,14 +257,39 @@ int mtk_disp_mutex_prepare(struct mtk_disp_mutex *mutex)
>  {
>         struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
>                                            mutex[mutex->id]);
> -       return clk_prepare_enable(ddp->clk);
> +       int ret;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(ddp->clk); i++) {
> +               if (IS_ERR(ddp->clk[i]))
> +                       continue;
> +               ret = clk_prepare_enable(ddp->clk[i]);
> +               if (ret) {
> +                       pr_err("failed to enable clock, err %d. i:%d\n",
> +                               ret, i);
> +                       goto err;
> +               }
> +       }
> +
> +       return 0;
> +
> +err:
> +       while (--i >= 0)
> +               clk_disable_unprepare(ddp->clk[i]);
> +       return ret;
>  }
>
>  void mtk_disp_mutex_unprepare(struct mtk_disp_mutex *mutex)
>  {
>         struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
>                                            mutex[mutex->id]);
> -       clk_disable_unprepare(ddp->clk);
> +       int i;
> +
> +        for (i = 0; i < ARRAY_SIZE(ddp->clk); i++) {
> +               if (IS_ERR(ddp->clk[i]))
> +                       continue;
> +               clk_disable_unprepare(ddp->clk[i]);
> +       }
>  }
>
>  void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
> @@ -415,11 +440,19 @@ static int mtk_ddp_probe(struct platform_device *pdev)
>         ddp->data = of_device_get_match_data(dev);
>
>         if (!ddp->data->no_clk) {
> -               ddp->clk = devm_clk_get(dev, NULL);
> -               if (IS_ERR(ddp->clk)) {
> -                       if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
> -                               dev_err(dev, "Failed to get clock\n");
> -                       return PTR_ERR(ddp->clk);
> +               int ret;
> +
> +               for (i = 0; i < ARRAY_SIZE(ddp->clk); i++) {
> +                       ddp->clk[i] = of_clk_get(dev->of_node, i);
> +
> +                       if (IS_ERR(ddp->clk[i])) {
> +                               ret = PTR_ERR(ddp->clk[i]);
> +                               if (ret != EPROBE_DEFER)
> +                                       dev_err(dev, "Failed to get clock %d\n",
> +                                               ret);
> +
> +                               return ret;
> +                       }

Use of_clk_bulk_get_all instead?

ddp->num_clks = of_clk_bulk_get_all(dev->of_node, &ddp->clks);
...

Then the calls above can be clk_bulk_enable/clk_bulk_disable using
num_clks and clks.


>                 }
>         }
>
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

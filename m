Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34B2F1DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbhAKSMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390231AbhAKSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:12:12 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0300C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:11:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id 6so968030ejz.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZheorGSTfgd88VVFRSNsRcjuZSZpq1vykcWg/KvDChs=;
        b=gs12mhRbkRDLQX/6SckZEyeDpBAdQGlKd4nf/EyWDLEj07/LTf4rYxSUIAPjPFM+PY
         tC9J3o7p5a4hFG5SPMQ/aBZVGX2bnJ1IBXAWbEFrDOuuYtr7RTgRSbu8M+0CJqzJ7Itn
         DbnSM1kONKRe+ynT8uTAKESH8tYuaQHn4Y/x6Lk4Pr/wBxxd1y+nnP80GDqQGOg7kwMi
         WPfuKnQ5RuVQ2nqflScTu8mWUqjSloWUhP+RhXQiZG9e0Xav40Q32v0EfscPAMnUhoIT
         64YxKGAkWkI7gHnpn4uoBJaSV9D/ZQKQH54fa8lb11gbGqHA18ZOvuA2b7Rz+lRaFtdl
         8yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZheorGSTfgd88VVFRSNsRcjuZSZpq1vykcWg/KvDChs=;
        b=rlY9dFE+ORT+PH/yfafp/nqjatl29NyeqNMQnRA60s9/lEpsCbX1UfcSGNBtBH2RES
         98Zz68/6h2+2avWERS7iYrLIfy/IMcMgEtEdheq4SFK+hjHM3Z/ZrmdllpCSCnxhuw8i
         KFYoXFU2oQhWluu9mfqb9iKVXqisRjsTcVayPTHNqjdMr3OAU8Dj+m1hEdS72Kp6qPFC
         AJjDIFavwAx+A3RfLplmPZAwdnl4mtQD3Czo+MPEgWmezVS2HM2N6uCm3ErZgeDB0HdF
         3Jno7jQTSZTQE8Qq35dPVI6viJhR2htIv6s6gEUinVvrZcEFm/WttSA43zHAuGR4mY/m
         f5ow==
X-Gm-Message-State: AOAM5306QMV04rD84ZV3BoLNK7wF5FfDN8HesV0Jc6nHVrt9Ac2xT7HP
        H1xKmwZDVqyOE/IZOdshwP69romED7Ni5tDxi85YeQ==
X-Google-Smtp-Source: ABdhPJzxgFsUtoVLIF49QjS3VoJV2KHCOv1fviyrbLtL5fuWpUiZwQi1Wh1a6uPJ25egRkVpTjsjP0y69emZDFIBZm0=
X-Received: by 2002:a17:906:e84:: with SMTP id p4mr490149ejf.141.1610388690333;
 Mon, 11 Jan 2021 10:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20210111145445.28854-1-ribalda@chromium.org> <20210111145445.28854-7-ribalda@chromium.org>
In-Reply-To: <20210111145445.28854-7-ribalda@chromium.org>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 11 Jan 2021 15:11:18 -0300
Message-ID: <CAAEAJfB5RD8y6fMsqSZp7Xw5656Qyt3pj9G64gsA9xwSePEd9g@mail.gmail.com>
Subject: Re: [PATCH 6/9] media: sum4i-csi: Do not zero reserved fields
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thanks a lot for doing this media-wide cleanup.

Aside from a silly typo here in the commit title, s/sum4i-csi/sun4i-csi,
all the patches seem fine.

Thanks,
Ezequiel

On Mon, 11 Jan 2021 at 11:56, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Core code already clears reserved fields of struct
> v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
> v4l2_plane_pix_format reserved fields").
>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c
> index 1a2f65d83a6c..4785faddf630 100644
> --- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c
> +++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c
> @@ -113,8 +113,6 @@ static void _sun4i_csi_try_fmt(struct sun4i_csi *csi,
>         pix->num_planes = _fmt->num_planes;
>         pix->pixelformat = _fmt->fourcc;
>
> -       memset(pix->reserved, 0, sizeof(pix->reserved));
> -
>         /* Align the width and height on the subsampling */
>         width = ALIGN(pix->width, _fmt->hsub);
>         height = ALIGN(pix->height, _fmt->vsub);
> @@ -131,8 +129,6 @@ static void _sun4i_csi_try_fmt(struct sun4i_csi *csi,
>                 bpl = pix->width / hsub * _fmt->bpp[i] / 8;
>                 pix->plane_fmt[i].bytesperline = bpl;
>                 pix->plane_fmt[i].sizeimage = bpl * pix->height / vsub;
> -               memset(pix->plane_fmt[i].reserved, 0,
> -                      sizeof(pix->plane_fmt[i].reserved));
>         }
>  }
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>

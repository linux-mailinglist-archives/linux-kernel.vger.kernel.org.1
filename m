Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E98F2F11F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbhAKL4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbhAKL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:56:45 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB818C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:56:04 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id q5so18030742ilc.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uA3TKz8uECHG3k4yaFsUscxG5WEGEfU+DDgmBoAkS/o=;
        b=cIvAbCgayxCKoOYNityjL7wT9stWwPvV5eiCz7X38vD43GczvDqDpmuctteU9QyQ+e
         Km9UDE+qcaQ+wrWWNECGFkMSGJXhz5AW0uKH50716CeXLrfWfAe0i4OFHhFv79uQxpSy
         gnOsEH9u8HNzIAWUO1mhanlP45jDlmTwtKBbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uA3TKz8uECHG3k4yaFsUscxG5WEGEfU+DDgmBoAkS/o=;
        b=cIJasr2Nm0a5JrXWULyX8A1FsnUPWXg0MR/Pb6c5zeT7uALDGnTQBxhoHu/g4W2V6O
         9VNSTamIjlP108Hfzfrsc5fnCOoDv2ZXtqN+3ACGi27/tMBYVeFCXpfN6Ehf1Til4qxi
         2B/F+M2i197OuG24sS9ue+JbD/t65VbUhL1JpAd6aZ504kno3WnASlJwEHYBbqN7ZS1h
         JYoGbQsjFFA+G8x1Nf++B0f3gBGpDx3bf1KQnXih/mg050ClmGNefzmiiKXsPcBSSmSg
         rWouxkjWoj5VA/DNsvCjB5/26TZF13kPuZMjGCjm0IMi5bILMkiNAVQ8XPCs0tKX4jTH
         TSxw==
X-Gm-Message-State: AOAM530JfKYKIIhs4qHpj8i39XKWsIvmVgs8gS8jCPPSizZ0pAm3DW4E
        MCtitAGXawT38bUUhHvtRKvoluHyl5EM6g==
X-Google-Smtp-Source: ABdhPJwK/DmSe3X7odTISfhg7HH0/L5LEtNtlfVmnRHbOFWmzATu3FL+sgBQyMG92vC1o/wU3F9h9w==
X-Received: by 2002:a92:4906:: with SMTP id w6mr15014286ila.234.1610366164109;
        Mon, 11 Jan 2021 03:56:04 -0800 (PST)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id z4sm10404277ioj.55.2021.01.11.03.56.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:56:03 -0800 (PST)
Received: by mail-io1-f43.google.com with SMTP id q1so3078606ion.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:56:03 -0800 (PST)
X-Received: by 2002:a02:c042:: with SMTP id u2mr13813149jam.32.1610366162852;
 Mon, 11 Jan 2021 03:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20210111113529.45488-1-ribalda@chromium.org> <ef218bf2bd948961079237686b58a00ca1b125bf.camel@collabora.com>
In-Reply-To: <ef218bf2bd948961079237686b58a00ca1b125bf.camel@collabora.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 11 Jan 2021 12:55:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCsX3k7xeC7Sr2T2SxHqspay+i054rAuv-NYCQpFRNuGeg@mail.gmail.com>
Message-ID: <CANiDSCsX3k7xeC7Sr2T2SxHqspay+i054rAuv-NYCQpFRNuGeg@mail.gmail.com>
Subject: Re: [PATCH] hantro: Format IOCTLs compliance fixes
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-rockchip@lists.infradead.org, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel

On Mon, Jan 11, 2021 at 12:48 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Hi Ricardo,
>
> On Mon, 2021-01-11 at 12:35 +0100, Ricardo Ribalda wrote:
> > Clear the reserved fields.
> >
> > Fixes:
> >   fail: v4l2-test-formats.cpp(482): pix_mp.plane_fmt[0].reserved not zeroed
> > test VIDIOC_TRY_FMT: FAIL
> >   fail: v4l2-test-formats.cpp(482): pix_mp.plane_fmt[0].reserved not zeroed
> > test VIDIOC_S_FMT: FAIL
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/staging/media/hantro/hantro_v4l2.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
> > index b668a82d40ad..9b384fbffc93 100644
> > --- a/drivers/staging/media/hantro/hantro_v4l2.c
> > +++ b/drivers/staging/media/hantro/hantro_v4l2.c
> > @@ -239,6 +239,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
> >         const struct hantro_fmt *fmt, *vpu_fmt;
> >         bool capture = V4L2_TYPE_IS_CAPTURE(type);
> >         bool coded;
> > +       int i;
> >
> >         coded = capture == ctx->is_encoder;
> >
> > @@ -293,6 +294,10 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
> >                         pix_mp->width * pix_mp->height * fmt->max_depth;
> >         }
> >
> > +       for (i = 0; i < pix_mp->num_planes; i++)
> > +               memset(pix_mp->plane_fmt[i].reserved, 0,
> > +                      sizeof(pix_mp->plane_fmt[i].reserved));
> > +
>
> This looks like something that should be handled at the core,
> probably in drivers/media/v4l2-core/v4l2-ioctl.c::v4l_try_fmt().

The core does clear the reserved field from v4l2_pix_format_mplane,
but not the reserved field for every plane. I can try to add it to the
core as well. At least these drivers have code duplication:

git grep reserved | grep memset | grep plane_fmt
drivers/media/pci/intel/ipu3/ipu3-cio2.c:
memset(mpix->plane_fmt[0].reserved, 0,
drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c:
memset(pix_mp->plane_fmt[i].reserved, 0,
drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c:
memset(&(pix_fmt_mp->plane_fmt[i].reserved[0]), 0x0,
drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:
memset(&(pix_fmt_mp->plane_fmt[i].reserved[0]), 0x0,
drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c:
memset(&(pix->plane_fmt[i].reserved[0]), 0x0,
drivers/media/platform/rcar_fdp1.c:
memset(pix->plane_fmt[i].reserved, 0,
drivers/media/platform/rcar_fdp1.c:
memset(pix->plane_fmt[2].reserved, 0,
drivers/media/platform/rcar_jpu.c:
memset(pix->plane_fmt[0].reserved, 0,
drivers/media/platform/rcar_jpu.c:
memset(pix->plane_fmt[i].reserved, 0,
drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c:
memset(pix->plane_fmt[i].reserved, 0,
drivers/media/platform/ti-vpe/vpe.c:
memset(plane_fmt->reserved, 0, sizeof(plane_fmt->reserved));
drivers/media/test-drivers/vicodec/vicodec-core.c:
memset(pix_mp->plane_fmt[0].reserved, 0,
drivers/staging/media/hantro/hantro_v4l2.c:
memset(pix_mp->plane_fmt[i].reserved, 0,
drivers/staging/media/ipu3/ipu3-v4l2.c: memset(pixm->plane_fmt[0].reserved, 0,

>
> Thanks,
> Ezequiel
>


-- 
Ricardo Ribalda

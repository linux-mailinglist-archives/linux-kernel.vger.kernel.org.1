Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540FA293517
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404438AbgJTGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404421AbgJTGla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:41:30 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD8C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:41:30 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id w25so192457oos.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5LGZ4Z5//+lRNXTDf6tlbBsdMMt7/nvH3Q3EoFvv7s=;
        b=Seh8wX3yNDbz2GaumO8yPfsIcVs44ueyV8duc/RD0O/2j5QVWjxuAfj7ov8QrLl/1t
         2Ifriom0ENn+iNMhZNB38+XJdOd0Lla1+8RFcFXYGYJPlJJCLLJU0QjBQXyS1HYKM7Bf
         L7/yRX2oScLVkIun/Ob1qL4X33j2g8VWH/kRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5LGZ4Z5//+lRNXTDf6tlbBsdMMt7/nvH3Q3EoFvv7s=;
        b=JLljKF8ZBzNd/OQPr0mrA99qD7oI/bj6MyXFUcErcl0Ro1B87F2Kor2P8rSl/lwWXE
         7z6uBUxgNpzwKaqHqUDUrycawvnMQIRmlBvOJEI7vK9+OwliGHWk+eQL+fs0iML/RB4c
         d+cr+ACnjUF6E5K39AR/EYss8iEPLPHzIfQrQI182NMr2dVThGAk40X/nkOEOFOmkWZK
         KfXL5ad3+TOJvkCH1uDRAIuROUsEOIoJusctvmw2BOWPvtTFbocy0MC35UBJtqbSsLOB
         HiVV6xhBBMk71c6ksoHsFUVyTWuf8ldwrXtxqvlDKqbaNtiaaWo3Ac4t9JMLrsv8O5fY
         CfIg==
X-Gm-Message-State: AOAM533RsccU7BABUhHUqHDycfPJpMYPsQbwLN0Nr1sNuIyPiB2DoJzQ
        +YyDVedB96ewX8GI73F3B30rERPjImEvwQ==
X-Google-Smtp-Source: ABdhPJyhsN5uaMKvlXQl5Y5oQReHnCySzG4ZVTobVuwwGV6Ep5uJo6bmBKs5B8dvR8IKWK+MJalxOA==
X-Received: by 2002:a4a:95cb:: with SMTP id p11mr758950ooi.89.1603176089538;
        Mon, 19 Oct 2020 23:41:29 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id d64sm289431oia.11.2020.10.19.23.41.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 23:41:28 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q136so1060766oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:41:28 -0700 (PDT)
X-Received: by 2002:a05:6808:8c:: with SMTP id s12mr808474oic.55.1603176087864;
 Mon, 19 Oct 2020 23:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201009084533.2405320-1-acourbot@chromium.org> <CAMfZQbw4wFzcocXXGavYdt+o8ydUoW4rSw4QnnrbZgwWUnp7Nw@mail.gmail.com>
In-Reply-To: <CAMfZQbw4wFzcocXXGavYdt+o8ydUoW4rSw4QnnrbZgwWUnp7Nw@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 20 Oct 2020 15:41:16 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV=hyZ=yOv++ivd2peGyRntGB4iwgDNwF4RGORFYXRNWQ@mail.gmail.com>
Message-ID: <CAPBb6MV=hyZ=yOv++ivd2peGyRntGB4iwgDNwF4RGORFYXRNWQ@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: return parsed crop information from stream
To:     Fritz Koenig <frkoenig@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 7:19 AM Fritz Koenig <frkoenig@chromium.org> wrote:
>
> It looks like only h.264 streams are populating the event.input_crop
> struct when receiving the HFI_INDEX_EXTRADATA_INPUT_CROP message in
> event_seq_changed().  vp8/vp9 streams end up with the struct filled
> with 0.

Indeed. :( I guess we can fallback to the previous behavior of using
the coded resolution as visible rect when the reported visible rect's
area is 0. That will preserve the previous behavior until the firmware
starts reporting this information for all encoded streams.

>
> On Fri, Oct 9, 2020 at 1:45 AM Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > Per the stateful codec specification, VIDIOC_G_SELECTION with a target
> > of V4L2_SEL_TGT_COMPOSE is supposed to return the crop area of capture
> > buffers containing the decoded frame. Until now the driver did not get
> > that information from the firmware and just returned the dimensions of
> > CAPTURE buffers.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  drivers/media/platform/qcom/venus/core.h |  1 +
> >  drivers/media/platform/qcom/venus/vdec.c | 21 ++++++++++++++++-----
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> > index 7b79a33dc9d6..3bc129a4f817 100644
> > --- a/drivers/media/platform/qcom/venus/core.h
> > +++ b/drivers/media/platform/qcom/venus/core.h
> > @@ -361,6 +361,7 @@ struct venus_inst {
> >         unsigned int streamon_cap, streamon_out;
> >         u32 width;
> >         u32 height;
> > +       struct v4l2_rect crop;
> >         u32 out_width;
> >         u32 out_height;
> >         u32 colorspace;
> > diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> > index ea13170a6a2c..ee74346f0cae 100644
> > --- a/drivers/media/platform/qcom/venus/vdec.c
> > +++ b/drivers/media/platform/qcom/venus/vdec.c
> > @@ -325,6 +325,10 @@ static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
> >
> >         inst->width = format.fmt.pix_mp.width;
> >         inst->height = format.fmt.pix_mp.height;
> > +       inst->crop.top = 0;
> > +       inst->crop.left = 0;
> > +       inst->crop.width = inst->width;
> > +       inst->crop.height = inst->height;
> >
> >         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> >                 inst->fmt_out = fmt;
> > @@ -343,6 +347,9 @@ vdec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
> >             s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
> >                 return -EINVAL;
> >
> > +       s->r.top = 0;
> > +       s->r.left = 0;
> > +
> >         switch (s->target) {
> >         case V4L2_SEL_TGT_CROP_BOUNDS:
> >         case V4L2_SEL_TGT_CROP_DEFAULT:
> > @@ -363,16 +370,12 @@ vdec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
> >         case V4L2_SEL_TGT_COMPOSE:
> >                 if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
> >                         return -EINVAL;
> > -               s->r.width = inst->out_width;
> > -               s->r.height = inst->out_height;
> > +               s->r = inst->crop;
> >                 break;
> >         default:
> >                 return -EINVAL;
> >         }
> >
> > -       s->r.top = 0;
> > -       s->r.left = 0;
> > -
> >         return 0;
> >  }
> >
> > @@ -1309,6 +1312,10 @@ static void vdec_event_change(struct venus_inst *inst,
> >
> >         inst->width = format.fmt.pix_mp.width;
> >         inst->height = format.fmt.pix_mp.height;
> > +       inst->crop.left = ev_data->input_crop.left;
> > +       inst->crop.top = ev_data->input_crop.top;
> > +       inst->crop.width = ev_data->input_crop.width;
> > +       inst->crop.height = ev_data->input_crop.height;
> >
> >         inst->out_width = ev_data->width;
> >         inst->out_height = ev_data->height;
> > @@ -1412,6 +1419,10 @@ static void vdec_inst_init(struct venus_inst *inst)
> >         inst->fmt_cap = &vdec_formats[0];
> >         inst->width = frame_width_min(inst);
> >         inst->height = ALIGN(frame_height_min(inst), 32);
> > +       inst->crop.left = 0;
> > +       inst->crop.top = 0;
> > +       inst->crop.width = inst->width;
> > +       inst->crop.height = inst->height;
> >         inst->out_width = frame_width_min(inst);
> >         inst->out_height = frame_height_min(inst);
> >         inst->fps = 30;
> > --
> > 2.28.0.1011.ga647a8990f-goog
> >

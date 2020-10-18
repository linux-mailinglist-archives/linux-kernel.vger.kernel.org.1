Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66CF292073
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 00:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgJRWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 18:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729389AbgJRWTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 18:19:45 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFBC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 15:19:44 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 33so8253940edq.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNlNSWtGKHz22BkJOTQfDL7XA8BtaJWUZUUPXDCETnw=;
        b=JRtiX+f5Af6nqke8AiQdsPQwxw9FOoxZSc4NgHM9vLVt9hKkwbuYGxBK7A9LxcZIEh
         UX6CcbLvYNAwOAbLAIAmux7gbPYhh7FCRu+dTUUMGQurunzaNov2S0aAe3Kct8j44cIw
         8SOYbD/bx6iPRs+nQ2DhktxKWx2AUe5OaBLhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNlNSWtGKHz22BkJOTQfDL7XA8BtaJWUZUUPXDCETnw=;
        b=R+aVLhRcNA+RHX4UgrOxhTOhGZKHoFaik3Bwh77hVhpCtvwK3BqM1yJKGHaya6ANjg
         nfIioj5ijVvMH3uWQh7VHX6vJECCYviOZdxIxWEgvpIX1juZVROqa30f3EVkoi5SED5y
         /0wJogNRtlFSSsg5aWbPkwpjXnCrD9oRvFv7pIHYB7veEJPpjm3xJEvNwv0QZaOF6BhN
         kyUWjFC4rp8vUKNIt+r310lqbcnQ1sZhchRTGkNuhfnKcazNjfkQsdgapvwxJE4bP87A
         /d6/LjHJJ81INZJ5r2CZiD/zCR9oEvPxxoZIgeoMGqI3o/2QN2om3NOqetVsoDIaFmzN
         x2tQ==
X-Gm-Message-State: AOAM532Uo/d9h5U7Ejf1LwrYQ+KN4EmzsqZ7VE/6qr5rr/oXabXeT8We
        zIyAG5vSbFJyEC+cG2L22iV7ka6BJw11ig==
X-Google-Smtp-Source: ABdhPJwr57aQld8NbQ6fwjPIrCLPz+opOWXmdjYTxDREH4d7Cv67LWGjSS7LqoC5sxru1RNXk8UIjw==
X-Received: by 2002:aa7:cad6:: with SMTP id l22mr15231133edt.229.1603059582047;
        Sun, 18 Oct 2020 15:19:42 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id j26sm5663232ejk.93.2020.10.18.15.19.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 15:19:41 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id b127so10841439wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 15:19:41 -0700 (PDT)
X-Received: by 2002:a1c:2586:: with SMTP id l128mr4802138wml.49.1603059580798;
 Sun, 18 Oct 2020 15:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201009084533.2405320-1-acourbot@chromium.org>
In-Reply-To: <20201009084533.2405320-1-acourbot@chromium.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sun, 18 Oct 2020 15:19:28 -0700
X-Gmail-Original-Message-ID: <CAMfZQbw4wFzcocXXGavYdt+o8ydUoW4rSw4QnnrbZgwWUnp7Nw@mail.gmail.com>
Message-ID: <CAMfZQbw4wFzcocXXGavYdt+o8ydUoW4rSw4QnnrbZgwWUnp7Nw@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: return parsed crop information from stream
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like only h.264 streams are populating the event.input_crop
struct when receiving the HFI_INDEX_EXTRADATA_INPUT_CROP message in
event_seq_changed().  vp8/vp9 streams end up with the struct filled
with 0.

On Fri, Oct 9, 2020 at 1:45 AM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> Per the stateful codec specification, VIDIOC_G_SELECTION with a target
> of V4L2_SEL_TGT_COMPOSE is supposed to return the crop area of capture
> buffers containing the decoded frame. Until now the driver did not get
> that information from the firmware and just returned the dimensions of
> CAPTURE buffers.
>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/core.h |  1 +
>  drivers/media/platform/qcom/venus/vdec.c | 21 ++++++++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 7b79a33dc9d6..3bc129a4f817 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -361,6 +361,7 @@ struct venus_inst {
>         unsigned int streamon_cap, streamon_out;
>         u32 width;
>         u32 height;
> +       struct v4l2_rect crop;
>         u32 out_width;
>         u32 out_height;
>         u32 colorspace;
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index ea13170a6a2c..ee74346f0cae 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -325,6 +325,10 @@ static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>
>         inst->width = format.fmt.pix_mp.width;
>         inst->height = format.fmt.pix_mp.height;
> +       inst->crop.top = 0;
> +       inst->crop.left = 0;
> +       inst->crop.width = inst->width;
> +       inst->crop.height = inst->height;
>
>         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>                 inst->fmt_out = fmt;
> @@ -343,6 +347,9 @@ vdec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
>             s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>                 return -EINVAL;
>
> +       s->r.top = 0;
> +       s->r.left = 0;
> +
>         switch (s->target) {
>         case V4L2_SEL_TGT_CROP_BOUNDS:
>         case V4L2_SEL_TGT_CROP_DEFAULT:
> @@ -363,16 +370,12 @@ vdec_g_selection(struct file *file, void *fh, struct v4l2_selection *s)
>         case V4L2_SEL_TGT_COMPOSE:
>                 if (s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>                         return -EINVAL;
> -               s->r.width = inst->out_width;
> -               s->r.height = inst->out_height;
> +               s->r = inst->crop;
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
> -       s->r.top = 0;
> -       s->r.left = 0;
> -
>         return 0;
>  }
>
> @@ -1309,6 +1312,10 @@ static void vdec_event_change(struct venus_inst *inst,
>
>         inst->width = format.fmt.pix_mp.width;
>         inst->height = format.fmt.pix_mp.height;
> +       inst->crop.left = ev_data->input_crop.left;
> +       inst->crop.top = ev_data->input_crop.top;
> +       inst->crop.width = ev_data->input_crop.width;
> +       inst->crop.height = ev_data->input_crop.height;
>
>         inst->out_width = ev_data->width;
>         inst->out_height = ev_data->height;
> @@ -1412,6 +1419,10 @@ static void vdec_inst_init(struct venus_inst *inst)
>         inst->fmt_cap = &vdec_formats[0];
>         inst->width = frame_width_min(inst);
>         inst->height = ALIGN(frame_height_min(inst), 32);
> +       inst->crop.left = 0;
> +       inst->crop.top = 0;
> +       inst->crop.width = inst->width;
> +       inst->crop.height = inst->height;
>         inst->out_width = frame_width_min(inst);
>         inst->out_height = frame_height_min(inst);
>         inst->fps = 30;
> --
> 2.28.0.1011.ga647a8990f-goog
>

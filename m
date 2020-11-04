Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86402A6CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgKDSaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKDSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:30:21 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE6DC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:30:19 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id j24so31098373ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObXZvuqDTjW88+sZhWTYfkzHwkNpd/2w4NBTS9tL7ew=;
        b=Bf6YApk3rqg8dXlrfYBYH9ATnDAf0xBN3HUgnv7zNBKLh4n02Gy3392KT8gOSfX+K3
         8uGh7ZRh+Fa5i47uM1MbVKUIFhv+AS5lQllZ2XFtTQPi6cjflYzlvTZYAoSC0HLo671h
         XT/flnYZvPQi5Lth97PnRneljo7oax9nuQKDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObXZvuqDTjW88+sZhWTYfkzHwkNpd/2w4NBTS9tL7ew=;
        b=g/pJDSJUUM5o+g7pZPhXl0oguwMV22RLB1ig6yjZ6nolJMMtSHLVfj1hC/a6sIlEu1
         u6J4+n99oqj/m2OgWZAfsM9teZJ6K674eppN98rKealI4tYVMdvyB0eQiLLE3kCHpRGC
         C/gNw/+Ti5DWSO2i/uQYg+RZqs8GVX5zFvjOpW3QE9WgHUO3lYofGJ++qJWvgNqncjT6
         koEbN3EWbWlNxcVPwJ9fUOkdzN/BsKFF0mI1VV170LFTVuasX5MZEHdQ3kFrrcHvzaRM
         S6gdKyGbI95FgwbizV9uOZQXywp4whK5cRFa8wq3vnXHP5KpWxEzm8GTRmw9oEhPfPy4
         BmiA==
X-Gm-Message-State: AOAM530o1xkoStIgROrKhOPGOVzYpgSG+FwaydkJS2PXRq0Yj9B14n+t
        nDrgnJqRUjPt00yqG5fyGVx91Lf4c3O65Q==
X-Google-Smtp-Source: ABdhPJzT5jvhx2BBc0asjVMjEutI3pRhDwbRMX/LzwuSASx22wdRXI2Cozde7evdtq/lDKVJwoZTFA==
X-Received: by 2002:a17:906:1955:: with SMTP id b21mr27239498eje.42.1604514617641;
        Wed, 04 Nov 2020 10:30:17 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id y15sm1459255eds.56.2020.11.04.10.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:30:16 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id n15so23187295wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:30:16 -0800 (PST)
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr33486907wrn.262.1604514615979;
 Wed, 04 Nov 2020 10:30:15 -0800 (PST)
MIME-Version: 1.0
References: <1604422184-2019-1-git-send-email-dikshita@codeaurora.org>
In-Reply-To: <1604422184-2019-1-git-send-email-dikshita@codeaurora.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Wed, 4 Nov 2020 10:30:03 -0800
X-Gmail-Original-Message-ID: <CAMfZQbzQ0Ao1AOm75vg=ByyvY05Ovach49tP71dRHaYhL3ZU9g@mail.gmail.com>
Message-ID: <CAMfZQbzQ0Ao1AOm75vg=ByyvY05Ovach49tP71dRHaYhL3ZU9g@mail.gmail.com>
Subject: Re: [PATCH] venus: venc: fix handlig of S_SELECTION and G_SELECTION
To:     Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     linux-media@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 8:50 AM Dikshita Agarwal <dikshita@codeaurora.org> wrote:
>
> - return correct width and height for G_SELECTION
> - update capture port wxh with rectangle wxh.
> - add support for HFI_PROPERTY_PARAM_UNCOMPRESSED_PLANE_ACTUAL_INFO
>   to set stride info and chroma offset to FW.
>
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c    | 18 +++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h    |  2 ++
>  drivers/media/platform/qcom/venus/hfi_cmds.c   | 12 +++++++++
>  drivers/media/platform/qcom/venus/hfi_helper.h |  4 +--
>  drivers/media/platform/qcom/venus/venc.c       | 36 ++++++++++++++++++--------
>  5 files changed, 59 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 2b6925b..6545cfb 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1621,3 +1621,21 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
>         return -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_get_out_fmts);
> +
> +int venus_helper_set_stride(struct venus_inst *inst,
> +                           unsigned int width, unsigned int height)
> +{
> +       const u32 ptype = HFI_PROPERTY_PARAM_UNCOMPRESSED_PLANE_ACTUAL_INFO;
> +
> +       struct hfi_uncompressed_plane_actual_info plane_actual_info;
> +
> +       plane_actual_info.buffer_type = HFI_BUFFER_INPUT;
> +       plane_actual_info.num_planes = 2;
> +       plane_actual_info.plane_format[0].actual_stride = width;
> +       plane_actual_info.plane_format[0].actual_plane_buffer_height = height;
> +       plane_actual_info.plane_format[1].actual_stride = width;
> +       plane_actual_info.plane_format[1].actual_plane_buffer_height = height / 2;
> +
> +       return hfi_session_set_property(inst, ptype, &plane_actual_info);
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_set_plane_actual_info);

I think this should be EXPORT_SYMBOL_GPL(venus_helper_set_stride);

> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index a4a0562..f36c9f71 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -63,4 +63,6 @@ void venus_helper_get_ts_metadata(struct venus_inst *inst, u64 timestamp_us,
>                                   struct vb2_v4l2_buffer *vbuf);
>  int venus_helper_get_profile_level(struct venus_inst *inst, u32 *profile, u32 *level);
>  int venus_helper_set_profile_level(struct venus_inst *inst, u32 profile, u32 level);
> +int venus_helper_set_stride(struct venus_inst *inst, unsigned int aligned_width,
> +                           unsigned int aligned_height);
>  #endif
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 7022368..4f75658 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -1205,6 +1205,18 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
>                 pkt->shdr.hdr.size += sizeof(u32) + sizeof(*cu);
>                 break;
>         }
> +       case HFI_PROPERTY_PARAM_UNCOMPRESSED_PLANE_ACTUAL_INFO: {
> +               struct hfi_uncompressed_plane_actual_info *in = pdata;
> +               struct hfi_uncompressed_plane_actual_info *info = prop_data;
> +
> +               info->buffer_type = in->buffer_type;
> +               info->num_planes = in->num_planes;
> +               info->plane_format[0] = in->plane_format[0];
> +               if (in->num_planes > 1)
> +                       info->plane_format[1] = in->plane_format[1];
> +               pkt->shdr.hdr.size += sizeof(u32) + sizeof(*info);
> +               break;
> +       }
>         case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
>         case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER:
>         case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE:
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 60ee247..5938a96 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -908,13 +908,13 @@ struct hfi_uncompressed_plane_actual {
>  struct hfi_uncompressed_plane_actual_info {
>         u32 buffer_type;
>         u32 num_planes;
> -       struct hfi_uncompressed_plane_actual plane_format[1];
> +       struct hfi_uncompressed_plane_actual plane_format[2];
>  };
>
>  struct hfi_uncompressed_plane_actual_constraints_info {
>         u32 buffer_type;
>         u32 num_planes;
> -       struct hfi_uncompressed_plane_constraints plane_format[1];
> +       struct hfi_uncompressed_plane_constraints plane_format[2];
>  };
>
>  struct hfi_codec_supported {
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 4ecf78e..99bfabf 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -190,8 +190,10 @@ static int venc_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdesc *f)
>         pixmp->height = clamp(pixmp->height, frame_height_min(inst),
>                               frame_height_max(inst));
>
> -       if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> +       if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> +               pixmp->width = ALIGN(pixmp->width, 128);
>                 pixmp->height = ALIGN(pixmp->height, 32);
> +       }
>
>         pixmp->width = ALIGN(pixmp->width, 2);
>         pixmp->height = ALIGN(pixmp->height, 2);
> @@ -335,13 +337,13 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
>         switch (s->target) {
>         case V4L2_SEL_TGT_CROP_DEFAULT:
>         case V4L2_SEL_TGT_CROP_BOUNDS:
> -               s->r.width = inst->width;
> -               s->r.height = inst->height;
> -               break;
> -       case V4L2_SEL_TGT_CROP:
>                 s->r.width = inst->out_width;
>                 s->r.height = inst->out_height;
>                 break;
> +       case V4L2_SEL_TGT_CROP:
> +               s->r.width = inst->width;
> +               s->r.height = inst->height;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -360,12 +362,19 @@ static int venc_g_fmt(struct file *file, void *fh, struct v4l2_format *f)
>         if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>                 return -EINVAL;
>
> +       if (s->r.width > inst->out_width ||
> +           s->r.height > inst->out_height)
> +               return -EINVAL;
> +
> +       s->r.width = ALIGN(s->r.width, 2);
> +       s->r.height = ALIGN(s->r.height, 2);
> +
>         switch (s->target) {
>         case V4L2_SEL_TGT_CROP:
> -               if (s->r.width != inst->out_width ||
> -                   s->r.height != inst->out_height ||
> -                   s->r.top != 0 || s->r.left != 0)
> -                       return -EINVAL;
> +               s->r.top = 0;
> +               s->r.left = 0;
> +               inst->width = s->r.width;
> +               inst->height = s->r.height;
>                 break;
>         default:
>                 return -EINVAL;
> @@ -728,6 +737,11 @@ static int venc_init_session(struct venus_inst *inst)
>         if (ret)
>                 return ret;
>
> +       ret = venus_helper_set_stride(inst, inst->out_width,
> +                                     inst->out_height);
> +       if (ret)
> +               goto deinit;
> +
>         ret = venus_helper_set_input_resolution(inst, inst->width,
>                                                 inst->height);
>         if (ret)
> @@ -816,8 +830,8 @@ static int venc_queue_setup(struct vb2_queue *q,
>                 inst->num_input_bufs = *num_buffers;
>
>                 sizes[0] = venus_helper_get_framesz(inst->fmt_out->pixfmt,
> -                                                   inst->width,
> -                                                   inst->height);
> +                                                   inst->out_width,
> +                                                   inst->out_height);
>                 inst->input_buf_size = sizes[0];
>                 break;
>         case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
> --
> 1.9.1
>

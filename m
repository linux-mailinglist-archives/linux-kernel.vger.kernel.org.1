Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14820293744
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392186AbgJTI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392179AbgJTI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:57:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7049AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:57:41 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 32so1098526otm.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uT0NXS//qb947TsojT9yUxidX+OMPncJLo1H0INLQEM=;
        b=msWlPbdDZxBNc5Qy14JyQkFhY4XUh6YKd8wwOYJnYzqM31bknOgjJsUbNU6mAWxqaf
         vhnn3M/aVFdvVe9tQ3Re9ykUg7U4/o6acqsj5lzpFlaPJfthQd1AVIwWtmSK+lV6oFoj
         dZ/+4WjPM1HVIZfM1/A/pt6HSCxSYNW8SpCdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uT0NXS//qb947TsojT9yUxidX+OMPncJLo1H0INLQEM=;
        b=rYAnp+Iih2DVCI0zkr5EXOS3OMyWpocTRyIgKiI7Tr1Qc8pHL0ZysIw+JG5SozewF4
         d1L2CdbpO78Q/l9dsmzNurg491BDciPJgwYPFS15S8WpRwvDkB6//y94ox9N2UEkj/35
         cET/TCPUrWdRJ5aYUkNbybObq6b/MZgoR58v8wM0XLHgy3eP46GPJQrkjRFngIXJM90m
         9M2habeRn0VxF+VeQmMuaZ0x0D/I+04iKMZ4G67a90F5ovSQgyDHX8tWaLletMrT0xF4
         pUMuRkXulbTYsir1moPEps78QWOscOMLRB2BY1+8TNUHK7ajP0AgHXW7fYuVRQh9nO1I
         hLvw==
X-Gm-Message-State: AOAM532XoRbEgzjj5q1omh1mch9Fyj3ckjq8es3vHUc4FVDpp3lasMVq
        sqhKZo9fytzgkVR6vqc4AJJE6Oqx/6ILxA==
X-Google-Smtp-Source: ABdhPJzcIZMNOJQph1cbLXu0dCtLjSK8Oq3a6r0sIQoDrq39bPJFBaU5O/A3VYmSw3s4yN3moM6Dbw==
X-Received: by 2002:a9d:f03:: with SMTP id 3mr988566ott.21.1603184260298;
        Tue, 20 Oct 2020 01:57:40 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id e76sm376634oib.16.2020.10.20.01.57.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 01:57:39 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id f10so1085351otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:57:39 -0700 (PDT)
X-Received: by 2002:a9d:7313:: with SMTP id e19mr961207otk.97.1603184258633;
 Tue, 20 Oct 2020 01:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <1603117737-16965-1-git-send-email-dikshita@codeaurora.org>
In-Reply-To: <1603117737-16965-1-git-send-email-dikshita@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 20 Oct 2020 17:57:26 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVPmW7MVveAKYzBXm=g=Ou4xviv5DjqMG+n0ax4OR7O0A@mail.gmail.com>
Message-ID: <CAPBb6MVPmW7MVveAKYzBXm=g=Ou4xviv5DjqMG+n0ax4OR7O0A@mail.gmail.com>
Subject: Re: [PATCH] venus: venc: add handling for VIDIOC_ENCODER_CMD
To:     Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

On Mon, Oct 19, 2020 at 11:29 PM Dikshita Agarwal
<dikshita@codeaurora.org> wrote:
>
> Add handling for below commands in encoder:
> 1. V4L2_ENC_CMD_STOP
> 2. V4L2_ENC_CMD_START

I suspect this can be implemented more easily (and more safely) using
the m2m encoder helpers introduced recently. Please see this commit
for details:

https://github.com/torvalds/linux/commit/2b48e113866a6735de3a99531183afb6217c2a60

By making use of this you can probably get rid of venus_enc_state
entirely. Also this generic implementation should take care of corner
cases that this patch does not address (like streaming off while a
drain is in progress).

>
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.h |  9 +++++
>  drivers/media/platform/qcom/venus/venc.c | 64 +++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index e30eeaf..5c46936 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -276,6 +276,14 @@ enum venus_dec_state {
>         VENUS_DEC_STATE_DRC             = 7,
>  };
>
> +enum venus_enc_state {
> +       VENUS_ENC_STATE_DEINIT          = 0,
> +       VENUS_ENC_STATE_INIT            = 1,
> +       VENUS_ENC_STATE_ENCODING        = 2,
> +       VENUS_ENC_STATE_STOPPED         = 3,
> +       VENUS_ENC_STATE_DRAIN           = 4,
> +};
> +
>  struct venus_ts_metadata {
>         bool used;
>         u64 ts_ns;
> @@ -367,6 +375,7 @@ struct venus_inst {
>         u8 quantization;
>         u8 xfer_func;
>         enum venus_dec_state codec_state;
> +       enum venus_enc_state enc_state;
>         wait_queue_head_t reconf_wait;
>         unsigned int subscriptions;
>         int buf_count;
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index f7fb6e3..c6143b0 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -498,6 +498,46 @@ static int venc_enum_frameintervals(struct file *file, void *fh,
>         return 0;
>  }
>
> +static int
> +venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
> +{
> +       struct venus_inst *inst = to_inst(file);
> +       struct hfi_frame_data fdata = {0};
> +       int ret = 0;
> +
> +       ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&inst->lock);
> +
> +       if (cmd->cmd == V4L2_ENC_CMD_STOP &&
> +           inst->enc_state == VENUS_ENC_STATE_ENCODING) {
> +               /*
> +                * Implement V4L2_ENC_CMD_STOP by enqueue an empty buffer on
> +                * encoder input to signal EOS.
> +                */
> +               if (!(inst->streamon_out && inst->streamon_cap))
> +                       goto unlock;
> +
> +               fdata.buffer_type = HFI_BUFFER_INPUT;
> +               fdata.flags |= HFI_BUFFERFLAG_EOS;
> +               fdata.device_addr = 0xdeadb000;
> +
> +               ret = hfi_session_process_buf(inst, &fdata);
> +
> +               inst->enc_state = VENUS_ENC_STATE_DRAIN;
> +       } else if (cmd->cmd == V4L2_ENC_CMD_START &&
> +               inst->enc_state == VENUS_ENC_STATE_STOPPED) {
> +               vb2_clear_last_buffer_dequeued(&inst->fh.m2m_ctx->cap_q_ctx.q);
> +               inst->enc_state = VENUS_ENC_STATE_ENCODING;
> +       }
> +
> +unlock:
> +       mutex_unlock(&inst->lock);
> +       return ret;
> +}
> +
>  static const struct v4l2_ioctl_ops venc_ioctl_ops = {
>         .vidioc_querycap = venc_querycap,
>         .vidioc_enum_fmt_vid_cap = venc_enum_fmt,
> @@ -525,6 +565,7 @@ static int venc_enum_frameintervals(struct file *file, void *fh,
>         .vidioc_enum_frameintervals = venc_enum_frameintervals,
>         .vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
>         .vidioc_unsubscribe_event = v4l2_event_unsubscribe,
> +       .vidioc_encoder_cmd = venc_encoder_cmd,
>  };
>
>  static int venc_set_properties(struct venus_inst *inst)
> @@ -884,6 +925,8 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
>         if (ret)
>                 goto deinit_sess;
>
> +       inst->enc_state = VENUS_ENC_STATE_ENCODING;
> +
>         mutex_unlock(&inst->lock);
>
>         return 0;
> @@ -903,8 +946,19 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
>  static void venc_vb2_buf_queue(struct vb2_buffer *vb)
>  {
>         struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
>
>         mutex_lock(&inst->lock);
> +
> +       if (inst->enc_state == VENUS_ENC_STATE_STOPPED) {
> +               vbuf->sequence = inst->sequence_cap++;
> +               vbuf->field = V4L2_FIELD_NONE;
> +               vb2_set_plane_payload(vb, 0, 0);
> +               v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> +               mutex_unlock(&inst->lock);
> +               return;
> +       }
> +
>         venus_helper_vb2_buf_queue(vb);
>         mutex_unlock(&inst->lock);
>  }
> @@ -943,6 +997,11 @@ static void venc_buf_done(struct venus_inst *inst, unsigned int buf_type,
>                 vb->planes[0].data_offset = data_offset;
>                 vb->timestamp = timestamp_us * NSEC_PER_USEC;
>                 vbuf->sequence = inst->sequence_cap++;
> +
> +               if ((vbuf->flags & V4L2_BUF_FLAG_LAST) &&
> +                   inst->enc_state == VENUS_ENC_STATE_DRAIN) {
> +                       inst->enc_state = VENUS_ENC_STATE_STOPPED;
> +               }
>         } else {
>                 vbuf->sequence = inst->sequence_out++;
>         }
> @@ -1041,6 +1100,9 @@ static int venc_open(struct file *file)
>         inst->clk_data.core_id = VIDC_CORE_ID_DEFAULT;
>         inst->core_acquired = false;
>
> +       if (inst->enc_state == VENUS_ENC_STATE_DEINIT)
> +               inst->enc_state = VENUS_ENC_STATE_INIT;
> +
>         venus_helper_init_instance(inst);
>
>         ret = pm_runtime_get_sync(core->dev_enc);
> @@ -1105,7 +1167,7 @@ static int venc_close(struct file *file)
>         mutex_destroy(&inst->lock);
>         v4l2_fh_del(&inst->fh);
>         v4l2_fh_exit(&inst->fh);
> -
> +       inst->enc_state = VENUS_ENC_STATE_DEINIT;
>         pm_runtime_put_sync(inst->core->dev_enc);
>
>         kfree(inst);
> --
> 1.9.1
>

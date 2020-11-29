Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5C2C7836
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgK2GKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgK2GKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:10:18 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C1C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:09:38 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id d18so10658665edt.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fu+OLgh33kd4c7uWtP+T5ynLNcOve17zeiTVDhx2z0E=;
        b=Qh2PVWDDKHbM51luphJ8s7JPsgXiObRyw72WqBT9N9N9or5ya0Z6xdKAxIwuNUEGY/
         nRDDC6DFhZvs5Tr3NxBaaAGWcbCV5CdvNRXmECCTBQFvGE0vsJCZrXTSkJPVV3YOCFzE
         Lmp+hcqE7JreKxxzd4FjCfh4cR29RXg3n1f/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fu+OLgh33kd4c7uWtP+T5ynLNcOve17zeiTVDhx2z0E=;
        b=jRq7JNa4Qb+s4/aqBA02nxoIjXk9Lxe6S6QaTg2/toV/kC43M7hIMNd38jnPuW2uV/
         AoLCAfwHnvG4ojCzi2jevIrhykm+0JpTw/FB+4MnMpCtJ/qewTusT7IguXo6d3G/FIRh
         dpwszDV5TLaLHP23J8QYera1wDxbB68fKnCxmYiw5GRDEl3l9oluwQPaMJafDR+4PsFe
         QSmG2uDDlchpZJUvq//mFqu+Fc10MB9Xqo2Jnp98yyg2TCi6jusLStbTw9jpxEA4G7G3
         cW/qx8iLN7iDAXd/ayWPU9mGucDIyraSxrXDSQ1mbOmiU+2nDvRKUzDiBFaceWs1nXvC
         b30Q==
X-Gm-Message-State: AOAM530otbSlb4aGRV53Tfoh7RfVMKV/vQ/e9CGYZGzsgaQicV/2fuM0
        sCBG52utXwZMAuJCET6+SowVa8MVUkFxJw==
X-Google-Smtp-Source: ABdhPJxbh5mSMRLH5PWssjUkpOlDEUzyDJn5kArlsghJ3Lt4IejnXXC9G+Ch7O9r+Y0QuFXNQ7BOzA==
X-Received: by 2002:a50:e18c:: with SMTP id k12mr15574568edl.58.1606630176959;
        Sat, 28 Nov 2020 22:09:36 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id 65sm7485020edj.83.2020.11.28.22.09.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 22:09:36 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id x22so11808233wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:09:36 -0800 (PST)
X-Received: by 2002:a1c:8155:: with SMTP id c82mr10594340wmd.49.1606630175847;
 Sat, 28 Nov 2020 22:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org> <20201111143755.24541-9-stanimir.varbanov@linaro.org>
In-Reply-To: <20201111143755.24541-9-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sat, 28 Nov 2020 22:09:23 -0800
X-Gmail-Original-Message-ID: <CAMfZQbyvWYAUF=+mR_E-X_P8TtiJnC2P-=vR-9mxVTn_hJmp7Q@mail.gmail.com>
Message-ID: <CAMfZQbyvWYAUF=+mR_E-X_P8TtiJnC2P-=vR-9mxVTn_hJmp7Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] venus: helpers: Delete unused stop streaming helper
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 6:38 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> After re-design of encoder driver this helper is not needed
> anymore.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 43 ---------------------
>  drivers/media/platform/qcom/venus/helpers.h |  1 -
>  2 files changed, 44 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 490c026b58a3..51c80417f361 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1406,49 +1406,6 @@ void venus_helper_buffers_done(struct venus_inst *inst, unsigned int type,
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_buffers_done);
>
> -void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
> -{
> -       struct venus_inst *inst = vb2_get_drv_priv(q);
> -       struct venus_core *core = inst->core;
> -       int ret;
> -
> -       mutex_lock(&inst->lock);
> -
> -       if (inst->streamon_out & inst->streamon_cap) {
> -               ret = hfi_session_stop(inst);
> -               ret |= hfi_session_unload_res(inst);
> -               ret |= venus_helper_unregister_bufs(inst);
> -               ret |= venus_helper_intbufs_free(inst);
> -               ret |= hfi_session_deinit(inst);
> -
> -               if (inst->session_error || core->sys_error)
> -                       ret = -EIO;
> -
> -               if (ret)
> -                       hfi_session_abort(inst);
> -
> -               venus_helper_free_dpb_bufs(inst);
> -
> -               venus_pm_load_scale(inst);
> -               INIT_LIST_HEAD(&inst->registeredbufs);
> -       }
> -
> -       venus_helper_buffers_done(inst, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> -                                 VB2_BUF_STATE_ERROR);
> -       venus_helper_buffers_done(inst, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> -                                 VB2_BUF_STATE_ERROR);
> -
> -       if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> -               inst->streamon_out = 0;
> -       else
> -               inst->streamon_cap = 0;
> -
> -       venus_pm_release_core(inst);
> -
> -       mutex_unlock(&inst->lock);
> -}
> -EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
> -
>  int venus_helper_process_initial_cap_bufs(struct venus_inst *inst)
>  {
>         struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index 231af29667e7..3eae2acbcc8e 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -20,7 +20,6 @@ int venus_helper_vb2_buf_init(struct vb2_buffer *vb);
>  int venus_helper_vb2_buf_prepare(struct vb2_buffer *vb);
>  void venus_helper_vb2_buf_queue(struct vb2_buffer *vb);
>  void venus_helper_process_buf(struct vb2_buffer *vb);
> -void venus_helper_vb2_stop_streaming(struct vb2_queue *q);
>  int venus_helper_vb2_start_streaming(struct venus_inst *inst);
>  void venus_helper_m2m_device_run(void *priv);
>  void venus_helper_m2m_job_abort(void *priv);
> --
> 2.17.1
>

Reviewed-by: Fritz Koenig <frkoenig@chromium.org>

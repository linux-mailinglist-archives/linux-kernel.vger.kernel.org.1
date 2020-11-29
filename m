Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3542C7824
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgK2GEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgK2GEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:04:14 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8330C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:03:33 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so10636681edv.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQ9GbhiuAOXfXy14OxRHpp5YCBQqf+t+cOFg3gNWF/Q=;
        b=ccN+q0jqNw3ubVJHKg8PRJD2j3vLir1lTOj7ni1yN0uFwFEjLQWhaZJPi3DkBqmSEq
         k+LbIw8NUfGyDWNPCHEIz7v1nI5nd0xeiQ0J+xLlLEHybxBURMObPnBtxqfi+xqa2TCl
         90ThtLBykbpNmgc1CqUeB8FVkiwdkrLYzLEmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQ9GbhiuAOXfXy14OxRHpp5YCBQqf+t+cOFg3gNWF/Q=;
        b=bq6kXGmKG+ewqQJXtD14NMUotUS+8fwcPrepurqnt4GgChW8nsXJPg+dR9+t834Hzw
         MrO6/5zl1jqpcTggefsEJv+j/n4PBU1q7/ee0utTYUBE5iEfLlL4niTv44O9EUurvz26
         34kd1udCQSO2fqhOHRLePI5i32Dej9H+TXkPVvvfgtL/7cSOcron0pgpQVSxtgv/eUr0
         RQXHWa1YgnnC4264DJHLkLvGS5y02QPSaHRn2dw2ezC7pgKeK2d5oDNwxEJo5MgyDj5o
         Y1HedG731AP0ezo7g0DTpHWZ3stC18oCCJ6QBjSIY/ctCsSn8yLvgRKz7u44IY5IaHg5
         Jqpw==
X-Gm-Message-State: AOAM532yUPBqvCOa4LndYJ3FiQUyIyBzL/5stJ5vKMhoQMSUWynMWdK7
        hXrItb29DECQEFuMPMTof110dcrrzvFFvg==
X-Google-Smtp-Source: ABdhPJyCZR/eBY6hgwqLokQLO8sxczAxJfMLBuXg0VU7KkhZMvr4AUNpFM0HHZaDcVRRwEQfrQW9yQ==
X-Received: by 2002:a50:da84:: with SMTP id q4mr15445154edj.377.1606629812409;
        Sat, 28 Nov 2020 22:03:32 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id r7sm2320494eda.23.2020.11.28.22.03.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 22:03:31 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id l1so10591283wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:03:31 -0800 (PST)
X-Received: by 2002:adf:e9cb:: with SMTP id l11mr20463647wrn.320.1606629811269;
 Sat, 28 Nov 2020 22:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org> <20201111143755.24541-3-stanimir.varbanov@linaro.org>
In-Reply-To: <20201111143755.24541-3-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sat, 28 Nov 2020 22:03:18 -0800
X-Gmail-Original-Message-ID: <CAMfZQbyqLNrY_to-cJP1tLWk-6n4L57kQUcg-+x4rOhE4UP1Ng@mail.gmail.com>
Message-ID: <CAMfZQbyqLNrY_to-cJP1tLWk-6n4L57kQUcg-+x4rOhE4UP1Ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] venus: helpers: Add a new helper for buffer processing
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
> The new helper will be used from encoder and decoder drivers
> to enqueue buffers for processing by firmware.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 20 ++++++++++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  1 +
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index efa2781d6f55..688e3e3e8362 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -1369,6 +1369,26 @@ void venus_helper_vb2_buf_queue(struct vb2_buffer *vb)
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_vb2_buf_queue);
>
> +void venus_helper_process_buf(struct vb2_buffer *vb)
> +{
> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +       struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
> +       int ret;
> +
> +       cache_payload(inst, vb);
> +
> +       if (vb2_start_streaming_called(vb->vb2_queue)) {
> +               ret = is_buf_refed(inst, vbuf);
> +               if (ret)
> +                       return;
> +
> +               ret = session_process_buf(inst, vbuf);
> +               if (ret)
> +                       return_buf_error(inst, vbuf);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(venus_helper_process_buf);
> +
>  void venus_helper_buffers_done(struct venus_inst *inst, unsigned int type,
>                                enum vb2_buffer_state state)
>  {
> diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
> index f36c9f717798..231af29667e7 100644
> --- a/drivers/media/platform/qcom/venus/helpers.h
> +++ b/drivers/media/platform/qcom/venus/helpers.h
> @@ -19,6 +19,7 @@ void venus_helper_buffers_done(struct venus_inst *inst, unsigned int type,
>  int venus_helper_vb2_buf_init(struct vb2_buffer *vb);
>  int venus_helper_vb2_buf_prepare(struct vb2_buffer *vb);
>  void venus_helper_vb2_buf_queue(struct vb2_buffer *vb);
> +void venus_helper_process_buf(struct vb2_buffer *vb);
>  void venus_helper_vb2_stop_streaming(struct vb2_queue *q);
>  int venus_helper_vb2_start_streaming(struct venus_inst *inst);
>  void venus_helper_m2m_device_run(void *priv);
> --
> 2.17.1
>

Reviewed-by: Fritz Koenig <frkoenig@chromium.org>

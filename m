Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6DE2CBA83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgLBKZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgLBKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:25:35 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744F5C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 02:24:49 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so2882141ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqgZBuyriKFHscfCKzWnYdcmG7dmWWESxzGWiLiHppY=;
        b=JVWBNXyC0QeCaKMX16uuRxGVMsXFILjSBYoCPCJ+kahnp3X5gzwhziPhpWn478WqNh
         YLgQGNkk2MfSolO4QwgTJn0INTag0vsigSNSVSB8IZIexg+BK4u2O+DOuFNsJLOFHfeU
         SSP+/BWtvPejS8RG5ZORi83TUT9GtRs0SzIS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqgZBuyriKFHscfCKzWnYdcmG7dmWWESxzGWiLiHppY=;
        b=R/aWaMjERALDtH231ATggItmaPcDWz+ZXqx0mYbhxaFWnPJOA18UgUVlLID+Updeyg
         J6EcrCXZvhPsIAxN/DwJjXLL0GI9NmaoRQjFM3OvEi1kf1rU/HyVId2A7KXoC9iLevP4
         UxC8qEpbzNwBakPeLYWRh3Y3BGIGgB7Y7IDWNMaUMmv5obhnyS/Tk6F1ji0B+LewMXiP
         KrkGvjXXScJOCOLbvWeV2WqSmmwUcUVBVC+aUSCLIh/u5Qq4BpwMfMnRmBJQeffdF+xs
         uDlUyilKPJgARe0BP7o/rIqDRV5HxrE9/QLJZ3udSIm9VB340Nn3J6+tgb+/YZtGgp9I
         rmBw==
X-Gm-Message-State: AOAM530kvkSOkLwMvlio9Pd2+KAQ6zcCMBkOn2Lj/xAjjGWqS33ST7Df
        T2RShxCQhOzxjyVA2YeZIWXKMe3nMNt1hJgT
X-Google-Smtp-Source: ABdhPJyphF0T+fjcSx/Js5sZryT96FMR/GKtwMWiK96ofEcItA+7Ul74+SqzFYjfGgcMdBwQhLkTWw==
X-Received: by 2002:a2e:964b:: with SMTP id z11mr880136ljh.236.1606904687449;
        Wed, 02 Dec 2020 02:24:47 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w11sm339815lfl.33.2020.12.02.02.24.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 02:24:47 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id d8so3730942lfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:24:46 -0800 (PST)
X-Received: by 2002:ac2:5e8d:: with SMTP id b13mr905826lfq.246.1606904686164;
 Wed, 02 Dec 2020 02:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20201202053424.3286774-1-acourbot@chromium.org>
In-Reply-To: <20201202053424.3286774-1-acourbot@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 2 Dec 2020 19:24:33 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXt4uL+VgxQs6ynf5LKae657QXmrjw6XYnL0vg_zuuDsw@mail.gmail.com>
Message-ID: <CAPBb6MXt4uL+VgxQs6ynf5LKae657QXmrjw6XYnL0vg_zuuDsw@mail.gmail.com>
Subject: Re: [PATCH] media: venus: preserve DRC state across seeks
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 2:34 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> DRC events can happen virtually at anytime, including when we are
> starting a seek. Should this happen, we must make sure to return to the
> DRC state, otherwise the firmware will expect buffers of the new
> resolution whereas userspace will still work with the old one.
>
> Returning to the DRC state upon resume for seeking makes sure that the
> client will get the DRC event and will reallocate the buffers to fit the
> firmware's expectations.

Oops, please ignore as this seems to depend on another patch... I will
repost once I can figure out the correct dependency chain, unless
Stanimir can find a better way to handle DRC during seek and flush.

>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 8488411204c3..e3d0df7fd765 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -972,7 +972,10 @@ static int vdec_start_output(struct venus_inst *inst)
>
>         if (inst->codec_state == VENUS_DEC_STATE_SEEK) {
>                 ret = venus_helper_process_initial_out_bufs(inst);
> -               inst->codec_state = VENUS_DEC_STATE_DECODING;
> +               if (inst->next_buf_last)
> +                       inst->codec_state = VENUS_DEC_STATE_DRC;
> +               else
> +                       inst->codec_state = VENUS_DEC_STATE_DECODING;
>                 goto done;
>         }
>
> @@ -1077,8 +1080,10 @@ static int vdec_stop_capture(struct venus_inst *inst)
>                 ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
>                 fallthrough;
>         case VENUS_DEC_STATE_DRAIN:
> -               vdec_cancel_dst_buffers(inst);
>                 inst->codec_state = VENUS_DEC_STATE_STOPPED;
> +               fallthrough;
> +       case VENUS_DEC_STATE_SEEK:
> +               vdec_cancel_dst_buffers(inst);
>                 break;
>         case VENUS_DEC_STATE_DRC:
>                 WARN_ON(1);
> @@ -1102,6 +1107,7 @@ static int vdec_stop_output(struct venus_inst *inst)
>         case VENUS_DEC_STATE_DECODING:
>         case VENUS_DEC_STATE_DRAIN:
>         case VENUS_DEC_STATE_STOPPED:
> +       case VENUS_DEC_STATE_DRC:
>                 ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
>                 inst->codec_state = VENUS_DEC_STATE_SEEK;
>                 break;
> @@ -1371,6 +1377,7 @@ static void vdec_event_change(struct venus_inst *inst,
>                         dev_dbg(dev, VDBGH "flush output error %d\n", ret);
>         }
>
> +       inst->next_buf_last = true;
>         inst->reconfig = true;
>         v4l2_event_queue_fh(&inst->fh, &ev);
>         wake_up(&inst->reconf_wait);
> --
> 2.29.2.454.gaff20da3a2-goog
>

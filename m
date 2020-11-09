Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FA72AC3DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgKIScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgKIScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:32:09 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13364C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:32:09 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id 7so13736410ejm.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IleGIJZzQ/fVs3LTovTtPZbHIKvQDjde3rU/8zBLt+Y=;
        b=EtajP82pPEWPNnuIMtZD9zDC0LVEjGeiy8Apk4BGecDfoXybbYQ/aAIolsdroW2DaU
         eOB6zzKtGOvK6uDn/Mdm6f07Nqwz9BCc4pXgFcAn65dqhIX2G4nWPVpCpmHCEuHXvw5/
         ion83q0HLIhTu0slRxGmhsZW+3QAWvKDoobJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IleGIJZzQ/fVs3LTovTtPZbHIKvQDjde3rU/8zBLt+Y=;
        b=PBPm8eyqmDDtvjUROhy88KM4Etgs8H3kRN+JlPQs0uL2yWTe/RkEL5pj27eO/k3U0b
         pRJTLpsFHcGjr4I+vOZWp5Di1u08dAcf6FRX8Xd/Xz6qaSmUsY0dBcrrAnAR45nIvMIX
         B73FPJbWRB2kxQ4kNyFRCWW7krw7R8UxyLnO0WB/57f5Wcc6iCaIsv75D/0C8pkonmJ6
         xnRE23KhvbALJztJQo0csBfisoI32dTe3FmgdGBI+e6AXwsDLIKWASWW5XZGrUOtYd9v
         YRKXdKi6uM0tVyvBcDFCsSAtQfZPQjDI+ORS+O79wntGJqFmLcdtf2DV30iCbACbqeS3
         6xow==
X-Gm-Message-State: AOAM531djLaKqwx5/dbaGuISUkKMP7ZGvJKriqWPjDlEBJYp47ztT0md
        ntEQQNorcXA4x4FRzlTf0CNDXzYLFfNZEg==
X-Google-Smtp-Source: ABdhPJzCpPGshHapPrGvgerLFm3A+cDIfMvkc5JwSqS0Ztx5IikeL7WXSZzPnGc0zj8HGhesrIQ+7w==
X-Received: by 2002:a17:906:944f:: with SMTP id z15mr17125038ejx.111.1604946727326;
        Mon, 09 Nov 2020 10:32:07 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id p1sm6565757edx.4.2020.11.09.10.32.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 10:32:06 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id s13so404289wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:32:06 -0800 (PST)
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr488018wmb.39.1604946725873;
 Mon, 09 Nov 2020 10:32:05 -0800 (PST)
MIME-Version: 1.0
References: <1604312674-1621-1-git-send-email-mansur@codeaurora.org>
In-Reply-To: <1604312674-1621-1-git-send-email-mansur@codeaurora.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Mon, 9 Nov 2020 10:31:53 -0800
X-Gmail-Original-Message-ID: <CAMfZQbywEfmKHabwpC=6AuBXjiGpswE=+S4qKRRHArhOLGg7dQ@mail.gmail.com>
Message-ID: <CAMfZQbywEfmKHabwpC=6AuBXjiGpswE=+S4qKRRHArhOLGg7dQ@mail.gmail.com>
Subject: Re: [PATCH] venus: fix calculating mbps in calculate_inst_freq()
To:     Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     linux-media@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 2:25 AM Mansur Alisha Shaik
<mansur@codeaurora.org> wrote:
>
> Currently in calculate_inst_freq() video driver is calculating
> macro blocks per frame in steam of macro blocks per second(mpbs).
> Which results frequency is always setting to lower frequency (150MB)
> as per frequency table for sc7180. Hence the playback is not smooth.
>
> Corrected this by correcting the mbps calculation.
>
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 57877ea..001513f 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -928,7 +928,7 @@ static unsigned long calculate_inst_freq(struct venus_inst *inst,
>         u32 fps = (u32)inst->fps;
>         u32 mbs_per_sec;
>
> -       mbs_per_sec = load_per_instance(inst) / fps;
> +       mbs_per_sec = load_per_instance(inst);
>
>         vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
>         /* 21 / 20 is overhead factor */
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>

Reviewed-by: Fritz Koenig <frkoenig@chromium.org>

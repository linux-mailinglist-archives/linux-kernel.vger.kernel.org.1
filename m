Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C192C782D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgK2GG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgK2GGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:06:55 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D7AC0617A7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:06:15 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o9so14365222ejg.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QH5AaLENJtnaVb0zakGwFRAJxR6ENRJ5wor2gNEi1WA=;
        b=XKnws3F/UYEV/6oLcu06/qaNXPqpi3KxhfKrP2qHWK8lJM35tOc6PztIQER6fPbes9
         RZVP4fmqf325TW4rO56DMa0tT8YOxmoCzwJlZ4BhlmXc4Le4raCWWXCMw/FuvhSrS+Wi
         /DaH8iD9CDFhWi+dIEljgHBpJK9EWtAmy6Ark=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QH5AaLENJtnaVb0zakGwFRAJxR6ENRJ5wor2gNEi1WA=;
        b=Z7hCW3U1WL0Q2eWorBKOcxxZWsp8Z7LJeZV1Yt5CvcCSXuledHP1Om6hL/1gjnBWo0
         7M3YPM71t5knSLHUYz3UixCDF/G+q9dqLhXXc6SiuAnByV5iWOf+Q/aEGKxtBKvuX6Af
         wCYUVldSkbI2jX+T99BdyTbGIWAB3VzUOdENjFyskqBONV2GgSPjdeD7A7L/WMTnwAz0
         07Ed7BiaSKsPqQ9sjJx/iJ+c0eIy7mv7mhZGV1RS/+hxQg/MLmAO1NTcEzIwqPT3qG3S
         kSkvmFofarFphAoV9ixhc3ZEAveRLK8ni4xz6f0mbTE25izmxEFYYwUlhZuseTWZGORs
         wPqQ==
X-Gm-Message-State: AOAM530HzwqbwyaIf4l4/0rx5O5RQq5Kz71jtX+f3YAcg/nRoxAQCkAh
        MGAGV3AdDJQFVD5P1EzVw3HFLYQIwq3kBA==
X-Google-Smtp-Source: ABdhPJxXAxsAw2NyaYUGPyLQe5R3wM6w7TiiYzhRsZa+lAseAk9fYQtK3Ij7/YS1z6TGXAkndYyptw==
X-Received: by 2002:a17:906:7087:: with SMTP id b7mr14713387ejk.70.1606629973658;
        Sat, 28 Nov 2020 22:06:13 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id i13sm6893441ejv.84.2020.11.28.22.06.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 22:06:12 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id t4so10578304wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:06:12 -0800 (PST)
X-Received: by 2002:a5d:4388:: with SMTP id i8mr21310112wrq.262.1606629972421;
 Sat, 28 Nov 2020 22:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org> <20201111143755.24541-4-stanimir.varbanov@linaro.org>
In-Reply-To: <20201111143755.24541-4-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sat, 28 Nov 2020 22:05:59 -0800
X-Gmail-Original-Message-ID: <CAMfZQbxwcnk7Nx8MfDfCThDzpWX2zoXOCdLk_mNcht7T4ZVROw@mail.gmail.com>
Message-ID: <CAMfZQbxwcnk7Nx8MfDfCThDzpWX2zoXOCdLk_mNcht7T4ZVROw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] venus: hfi_cmds: Allow null buffer address on
 encoder input
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
> Allow null buffer address for encoder input buffers. This will
> be used to send null input buffers to signal end-of-stream.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 4f7565834469..2affaa2ed70f 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -278,7 +278,7 @@ int pkt_session_etb_encoder(
>                 struct hfi_session_empty_buffer_uncompressed_plane0_pkt *pkt,
>                 void *cookie, struct hfi_frame_data *in_frame)
>  {
> -       if (!cookie || !in_frame->device_addr)
> +       if (!cookie)
>                 return -EINVAL;
>
>         pkt->shdr.hdr.size = sizeof(*pkt);
> --
> 2.17.1
>
Reviewed-by: Fritz Koenig <frkoenig@chromium.org>

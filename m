Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD32EFA5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbhAHVY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhAHVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:24:26 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995DAC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:23:46 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id w3so11013139otp.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aCoAbGKkVysmTlB8nOnLajkPksJNfkFdrsTwnEpGsSI=;
        b=dw8z5uqcP4yfpvEpx9m+W8twaWwhF8X4C4YEoWC+okMrrLSN5v6vdoivlehcwM4w3K
         byA8Y+RzIDsNBmPVhbzKcg3unN/BdvyFfaZCPHVqLD29UWDIjHhjGAjdBe4pdEjOwP18
         4JWdj9ObeNJjTa0/ZtxRXkP7Gx/DgCKBLOda9cDDT2bT1w0yzEuLc54Gq/tMZd4WNxcQ
         sQhnrTmTxgwy+GOTfJkw05hxw7UyvNlshkNR2ZyDdtLIsthz5Man2QrnUowaGSz6tUiU
         lYZbe+E9Thy3pjpjm06DqesLhYnHy5+btBCFzsDf1573SMgRpU9dTN+7zlCb+0IUcAaJ
         /Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aCoAbGKkVysmTlB8nOnLajkPksJNfkFdrsTwnEpGsSI=;
        b=t8P1KA21paHcjPcjwQlta8Hd6am96vr/CKk7cNifNfTpNcGfgQ0aVe8fS4i3AP7Gs/
         b+9lK05VZQkWqbBzfK9NUzBDBvmuISxnJRnAxQ8N5qmM/jjKrx0aV3GB09yF7sXINUOY
         +tMH9bNB3wXFA8twsz9alNKlILvxfru1hmbMlIi1veUMsOTRuiefubNxYHFmjWQzBOg0
         ty2bkiY3PQqj0dn9JZNzkikYK61eK+R78vXpgHHR5RRY3uGL5UoNdtXfbaiS5mweOpX4
         Y/BhogsUVoddd7iY2CF62/ur19MHVCgN0YjffKmiJIta/nWSVdhXQS8TTbNz3OSXvGju
         nxdw==
X-Gm-Message-State: AOAM5325zSomI7yTxFuDwPEGmVYse9avL4FMf6CPEp1hdhIiDv3Q0P65
        yIsJVmy3zSBlqwV3uPjxWWsuvilkRgrB+dFPP7dWYHtW
X-Google-Smtp-Source: ABdhPJyKMBdC32hANO1XiAZxwbrpCwG6gelTpkW9IiHXMRtS3Ms+jMC1qMYHR7T93LBlrMvaDocCheQB64ssDHUsBCY=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr3902194oti.23.1610141024619;
 Fri, 08 Jan 2021 13:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-37-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:23:33 -0500
Message-ID: <CADnq5_PDo2XRMkrhwz52+01r3StpuP7TJHUE=W-8E__kuMtd3A@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amd/display/dc/dce/dce_i2c_hw: Make functions
 called by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Lewis Huang <Lewis.Huang@amd.com>, Leo Li <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:438:35: warnin=
g: no previous prototype for =E2=80=98dce_i2c_hw_engine_wait_on_operation_r=
esult=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:505:6: warning=
: no previous prototype for =E2=80=98dce_i2c_hw_engine_submit_payload=E2=80=
=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lewis Huang <Lewis.Huang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gp=
u/drm/amd/display/dc/dce/dce_i2c_hw.c
> index 7fbd92fbc63a9..a524f471e0d75 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> @@ -435,7 +435,7 @@ struct dce_i2c_hw *acquire_i2c_hw_engine(
>         return dce_i2c_hw;
>  }
>
> -enum i2c_channel_operation_result dce_i2c_hw_engine_wait_on_operation_re=
sult(
> +static enum i2c_channel_operation_result dce_i2c_hw_engine_wait_on_opera=
tion_result(
>         struct dce_i2c_hw *dce_i2c_hw,
>         uint32_t timeout,
>         enum i2c_channel_operation_result expected_result)
> @@ -502,7 +502,7 @@ static uint32_t get_transaction_timeout_hw(
>         return period_timeout * num_of_clock_stretches;
>  }
>
> -bool dce_i2c_hw_engine_submit_payload(
> +static bool dce_i2c_hw_engine_submit_payload(
>         struct dce_i2c_hw *dce_i2c_hw,
>         struct i2c_payload *payload,
>         bool middle_of_transaction,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

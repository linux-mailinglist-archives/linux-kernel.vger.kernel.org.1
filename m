Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172B02C7831
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgK2GIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgK2GIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:08:51 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221C5C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:08:05 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id y4so10666657edy.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBuF+7TgU/ZfyiFolzpZTN7G+5moGv16x7YISSbf2WI=;
        b=Sa+KUL04mbhl4rwgaA9YJuTDBxqbdL5uxIXeUp631xJLXww0w3G6Rq5FN9HD8PINF9
         SQpzslfjFUGE0+7KJQXqHgtqUBKzgX4z5PpC/VTQ7o5v9VmVbkB44fNLPxAI7CaF9OQ3
         +CZ+/oqvsXC0JWkiDue713l8H7KiAZ3CRHJn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBuF+7TgU/ZfyiFolzpZTN7G+5moGv16x7YISSbf2WI=;
        b=AACy9MMPHz3KXk/wdYs4f3DjAAoPQWvIGIksoB0ozg3qA6a037UdxwYFcIBVSdb42+
         dJui4EjZlWk9euGLMDh1niPupE1YaUSmnYg7fEaLJelNsEU1udrCqBLC5bka8ox+pJ3u
         B98YRV5JiEuM+2y3N1XMtKyDTfBWCT4Z+yBUTxwx0b7Hp34XPSXr3oRt5daTiFo6cDcq
         j/miVBAcOtcjqN5vbGA5Tk5CEJZCxoYVc9OoMHQVXixIE9VFpb1ttiwDWrCy1w0fywND
         QsO5yUIkZn13Sar4on5dSbWlBlN0z+MHZQgITQpl8rlOJZuW/XOfA/C/Ueq7g54+YDl7
         j2Yg==
X-Gm-Message-State: AOAM532bUPzJJ0nGz4rmteZGVuuHjI7rlakVOgYg5bgA17ZSU32L0X3W
        J2YyYmji+OoBJ97aEj68i/MxPkYaTKd+lw==
X-Google-Smtp-Source: ABdhPJzPVIUGJEmeZR9JE80pFbEPGvdSMKMrffh0epPJApUT/EMsZ6XWjVui/Gqw/+BGGcQ0snmJFA==
X-Received: by 2002:a50:ff0c:: with SMTP id a12mr15838954edu.79.1606630083722;
        Sat, 28 Nov 2020 22:08:03 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id g15sm6788777edj.49.2020.11.28.22.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 22:08:03 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id h21so14702945wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 22:08:02 -0800 (PST)
X-Received: by 2002:a1c:9e53:: with SMTP id h80mr7849050wme.50.1606630082300;
 Sat, 28 Nov 2020 22:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20201111143755.24541-1-stanimir.varbanov@linaro.org> <20201111143755.24541-5-stanimir.varbanov@linaro.org>
In-Reply-To: <20201111143755.24541-5-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Sat, 28 Nov 2020 22:07:49 -0800
X-Gmail-Original-Message-ID: <CAMfZQbwMwPkQzakC+6aLqCnoHnjEL7ZhSn_WngcycAF0=6MFxg@mail.gmail.com>
Message-ID: <CAMfZQbwMwPkQzakC+6aLqCnoHnjEL7ZhSn_WngcycAF0=6MFxg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] venus: helpers: Calculate properly compressed
 buffer size
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
> For resolutions below 720p the size of the compressed buffer must
> be bigger. Correct this by checking the resolution when calculating
> buffer size and multiply by four.

I'm confused because the commit message doesn't appear to line up with
the code.  It says multiply by four here, but the code has by eight.

>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 688e3e3e8362..490c026b58a3 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -986,6 +986,8 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
>
>         if (compressed) {
>                 sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
> +               if (width < 1280 || height < 720)
> +                       sz *= 8;
>                 return ALIGN(sz, SZ_4K);
>         }
>
> --
> 2.17.1
>

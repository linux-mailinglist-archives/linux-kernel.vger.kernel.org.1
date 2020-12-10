Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7042D694A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393904AbgLJVBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 16:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgLJVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:01:05 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703AEC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:00:25 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id p187so7103400iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26Vm4s06JnMVOl9zkroZalqQJYVX3pZvEC5YiT4DGro=;
        b=bePoVgoZkT130rTZGLCOVgoYm8XZaqW8Woj+N4R6vowh7e/+3K7mvFceJ7tUDc23I3
         79awfxjusxoStgE5o129NbFBY8mcaIqCfapdan1OnCr+DJ0vhkZraIb68YUkrDAGD9hv
         9rgShmTq9kQb7z6ds9lLLt88SYadgYWjKrr8ZfgAIJIBfaRwSJ1ZzZdQEakgUQR1+Cm4
         JRDf8p8e1joY1358W7XspiYV5GATWZScWxgDyGz4FpBovsSDZqTnJnGIitu+gb8pDbwH
         VMZ2dh00eXlf0+/7Bz1nt4/Fhxa/jt6pEGNXo1TRWWxUNoArgXMZ0J68Jgw3vF4GroRs
         tw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26Vm4s06JnMVOl9zkroZalqQJYVX3pZvEC5YiT4DGro=;
        b=Ch9Wopf5QpnMl+MFTarmIwQfsDVoQ/RPUkYq9xyGa7+zyE1rjQNN7sB6zGh9Vq3QTU
         K8VM1QvMuJrZqYu2Xz4zoNw5VjYACP3P4ssrGpLP3H6JF13/bHNeidFQQkv0+UNvLrvu
         9zVaC03Y0e797nAZSRggJ0ASgqmFmUvEBumnQgimauEwAk+Da9S8l+sMVPX8P+jQ4CLS
         TYWPtoxV9ozt379OTfT92ou7WtCCrtXNGRrKXjqkNJQb6LTbEHB3nIS/vPdOyBQrCq9I
         zUGFMtl9U0KRVIHZDmiQy5MT77pvmmfkAh+toxp9FSNG5tZFGMbrtGh78cTSADTDK1mw
         Y9mw==
X-Gm-Message-State: AOAM5309gm6r16OL2G/ka+T4dtGAEl0ICHumdHvcaemN+284ujYeCqc9
        cloaXiWCl50s0Qp4QjmYgChlZ41otLlE9PsjtFlcog==
X-Google-Smtp-Source: ABdhPJxVTTC6jf6Rca6pGj/4VGpBcmnmfKJQSRWgYGp5zzAjBBSxgIgZtYJdOgIiHV6IOPYUdwwP97+bX6EwXIfd6J4=
X-Received: by 2002:a05:6638:ecd:: with SMTP id q13mr9100887jas.62.1607634024741;
 Thu, 10 Dec 2020 13:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20201123104616.1412688-1-robert.foss@linaro.org>
In-Reply-To: <20201123104616.1412688-1-robert.foss@linaro.org>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 10 Dec 2020 13:00:13 -0800
Message-ID: <CAMn1gO6AQvyJO0s2k1POAVn4JxuOKLoKpj_UvvW3TnLTtv6_bw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: lt9611: Fix handling of 4k panels
To:     Robert Foss <robert.foss@linaro.org>
Cc:     a.hajda@samsung.com, Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alistair Delva <adelva@google.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Confirmed that this fixes display output for me on a 4K monitor.

On Mon, Nov 23, 2020 at 2:46 AM Robert Foss <robert.foss@linaro.org> wrote:
>
> 4k requires two dsi pipes, so don't report MODE_OK when only a
> single pipe is configured. But rather report MODE_PANEL to
> signal that requirements of the panel are not being met.
>
> Reported-by: Peter Collingbourne <pcc@google.com>
> Suggested-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Tested-by: John Stultz <john.stultz@linaro.org>

Tested-by: Peter Collingbourne <pcc@google.com>

> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index d734d9402c35..e8eb8deb444b 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -867,8 +867,14 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
>                                                      const struct drm_display_mode *mode)
>  {
>         struct lt9611_mode *lt9611_mode = lt9611_find_mode(mode);
> +       struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
>
> -       return lt9611_mode ? MODE_OK : MODE_BAD;
> +       if (!lt9611_mode)
> +               return MODE_BAD;
> +       else if (lt9611_mode->intfs > 1 && !lt9611->dsi1)
> +               return MODE_PANEL;
> +       else
> +               return MODE_OK;
>  }
>
>  static void lt9611_bridge_pre_enable(struct drm_bridge *bridge)
> --
> 2.27.0
>

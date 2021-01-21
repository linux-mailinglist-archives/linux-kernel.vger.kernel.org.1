Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865702FE6C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 10:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbhAUJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 04:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbhAUJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 04:51:39 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25116C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:50:59 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so1204713pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 01:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbxFki6tRqBX44IegEJe/BsZNExFbfRgQ7K/DMqXpe8=;
        b=A1AJnTLR1KCTSKBNCZ3JyEbtViSOVuzkHWv6idUgfWTfqy+UYL3/XgVlhkw3gUTrZL
         3GY386GwUpruFJZD6FaCnygmfq2zZQCl3n7h6l+0WpFIpGT0u3MeCiWcj6fxItmgMgML
         /Yjc9zlGywzrlno0Tfs9FkGe6jyAWlB9hIVpj9OmgoWYfW1A71uMrMAr06MYroD271li
         UZ+1bdV1CQ1uMWEKBhF08lHe+LsML/w3wThdojfW76E2uR2WdWav/6V6XEVBFhh9NJ39
         Ls949nwzS6aD+uhFedHdK6LQe16aYjDCCRKp3R5aksY58DnTNVTMfH5f0UGi7PLRuvsu
         BVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbxFki6tRqBX44IegEJe/BsZNExFbfRgQ7K/DMqXpe8=;
        b=DMfN/7sza6hJi7A2riZOn9K+uPeLa1mD/CMePEUy++fkJxktWW65oLIz1A13qEs7rz
         tvd1WB2pD9TtpT8juOsaMUkuyJSaSzqnxJw5F/LgEZlAZrO6R6V94y403a5PvshsLJHP
         TZlUV06k76wB62Ew9161J/ZDBBb5EZ7SOHyFfPUaIigjvfpOfdymQ5WJIHQZWFbOXmMN
         tQBjtRbb3MBVHfPZl4u26vuy2oC7IEuBUXKI//Gm4IJx+Q6lkd3stb/keTh2yMHumxqE
         Yb48/wyx40tqpYbOOk6icJfp55ilWsjZDpHQfKoKvkSCBx0Kg0YxZ1wdA/mgsjMAtMKG
         xZbw==
X-Gm-Message-State: AOAM531DOgJuG8UoxZ5EaW8SEw7LZVSx8Vq0pVAmf21XsjAQNExTiFs9
        N4NoppOs/oI9INChAFf8pnlQgjles4F9Azwk4NK4dA==
X-Google-Smtp-Source: ABdhPJy4QmxdDGGbdf9i+h1GcKiwufxe5Plh47FVzcuGSR7wU0aFKJI9QhaFtI+6AWpwyCxBgfhH/vaW0W5o0h154jo=
X-Received: by 2002:aa7:8edd:0:b029:1b7:9f41:c4d8 with SMTP id
 b29-20020aa78edd0000b02901b79f41c4d8mr13464399pfr.39.1611222658609; Thu, 21
 Jan 2021 01:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20201217140933.1133969-1-robert.foss@linaro.org>
In-Reply-To: <20201217140933.1133969-1-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 21 Jan 2021 10:50:47 +0100
Message-ID: <CAG3jFyuzjbPsMBOOgc2DBBT92H7FPBNdJLKWHF8+7K10LujMbw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: lt9611: Fix handling of 4k panels
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>, a.hajda@samsung.com,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peter Collingbourne <pcc@google.com>, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

+Sam Ravnborg

I think this patch is ready to get pulled into the drm-misc tree.

On Thu, 17 Dec 2020 at 15:09, Robert Foss <robert.foss@linaro.org> wrote:
>
> 4k requires two dsi pipes, so don't report MODE_OK when only a
> single pipe is configured. But rather report MODE_PANEL to
> signal that requirements of the panel are not being met.
>
> Reported-by: Peter Collingbourne <pcc@google.com>
> Suggested-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Tested-by: John Stultz <john.stultz@linaro.org>
> Tested-by: Anibal Limon <anibal.limon@linaro.org>
> Acked-By: Vinod Koul <vkoul@kernel.org>
> Tested-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

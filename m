Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99222FD4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391258AbhATQF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391070AbhATQEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:04:14 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7310C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:03:33 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id o11so23850412ote.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJCBiwBO/xEgO9jr3aVUv1rBDTi8ytSoHuAN7ss9+FQ=;
        b=SaNPNcS6Z2xbfYNvLJu3j5/JXjEfVIiaD4P4PHnskHPlvUSY3LWnLXUVn3VF1lKqN5
         G/G8yyGUi02V6B9yUNwvIXxbxLSqAD7RAM34brWGTXH/z+dw244szhVmhINlaIqRw9U+
         z6npoCi0zz7cTE+fNxUJSK1uClMI4ipS1yPIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJCBiwBO/xEgO9jr3aVUv1rBDTi8ytSoHuAN7ss9+FQ=;
        b=pffkc3ZQV93DtoxarDoAfVU93rdDQroA1NoRVqEyyrHBKvdLc/1JoZGGCNTZSV799J
         cQYToIXaxC004EAURJ6Lus+yX2jw8te03bkIB1B9LYiWYNCLgl46wx1o4Z6I5lpvhL/q
         VwnRe1zooV6fF/p9bqzMZOdWjgYBN5lcO8Xd8u7gAAbXpVECE+vuk2NGrATONlTboprU
         WMBCGYh7Smi0PhYe9NKnNSVYIuSyb/6IQ6LMVWUxoUeV9dzai3xTkGWswU2Yd+eiCGKm
         zXHiBnLXQAlMckxWHcC8rE8j4CsD7ALUmiK7EznyS/us2DTH3osEI5Sg3XFjJEPEFwqf
         B5gA==
X-Gm-Message-State: AOAM530z4BnAbWC26av/IAck7i/ZTgbwOEVIHQvive53cvWw6wZYm7e5
        Zau4WFgRlbMl4XrXYMZ5vnBkO5wgBqxZLkrx+D5JTg==
X-Google-Smtp-Source: ABdhPJyWdj1BXwHHDK/NwUPAiGcQF/1RUz7Tu4QQIHGq8FtBjL5jH4ywkwS00QWZajtNaqewC5R8crwbLX0gY5WWKhI=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr7575766otb.281.1611158613038;
 Wed, 20 Jan 2021 08:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20210120123535.40226-1-paul@crapouillou.net> <20210120123535.40226-2-paul@crapouillou.net>
In-Reply-To: <20210120123535.40226-2-paul@crapouillou.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 20 Jan 2021 17:03:22 +0100
Message-ID: <CAKMK7uGGDe8bZpeTnyCkF7g_2gC1nixOzWe4FWYXPRWi-q5y7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm: bridge/panel: Cleanup connector on bridge detach
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        od@zcrc.me, dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 1:35 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> If we don't call drm_connector_cleanup() manually in
> panel_bridge_detach(), the connector will be cleaned up with the other
> DRM objects in the call to drm_mode_config_cleanup(). However, since our
> drm_connector is devm-allocated, by the time drm_mode_config_cleanup()
> will be called, our connector will be long gone. Therefore, the
> connector must be cleaned up when the bridge is detached to avoid
> use-after-free conditions.

For -fixes this sounds ok, but for -next I think switching to drmm_
would be much better.
-Daniel

> v2: Cleanup connector only if it was created
>
> Fixes: 13dfc0540a57 ("drm/bridge: Refactor out the panel wrapper from the lvds-encoder bridge.")
> Cc: <stable@vger.kernel.org> # 4.12+
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/panel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 0ddc37551194..df86b0ee0549 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -87,6 +87,12 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>
>  static void panel_bridge_detach(struct drm_bridge *bridge)
>  {
> +       struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +       struct drm_connector *connector = &panel_bridge->connector;
> +
> +       /* Cleanup the connector if we know it was initialized */
> +       if (!!panel_bridge->connector.dev)
> +               drm_connector_cleanup(connector);
>  }
>
>  static void panel_bridge_pre_enable(struct drm_bridge *bridge)
> --
> 2.29.2
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

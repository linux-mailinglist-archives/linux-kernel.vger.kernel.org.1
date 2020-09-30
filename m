Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926C827E6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgI3Kb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3Kb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:31:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:31:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c2so1300743otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/cFVU0k3Lc4dRZ8DHvHDPTwflgSIBkQD3tkvH9ZVpI=;
        b=c/mTOTqmh8Rks2UaquMUtKbjXrSqZcnUdklwdLCrN0JbNt/l0lJUbf5u4oKg0Pf7nK
         CCEd4cSvZ2Tt9V7vnwnCHTRfq2VjSZo57zKBV5UIWl7KyD9/n01QbspGF7kp+zAwg8xC
         XeLx29noJtYHxxQYZhwb8z5ZvloC0v+6E+pDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/cFVU0k3Lc4dRZ8DHvHDPTwflgSIBkQD3tkvH9ZVpI=;
        b=n7MQkT6XDWmS6F8TwiB7UvRf2VCkb70FX73ppuKETuGxzP7MNWFNmkorQlZH6y0wUQ
         GR6z/lHAzxx2HHmd4nQA5Z0Ijm30tL78KYhuPCV5H8vhLHZY31rOGCmM4pU7l+6TMRu5
         lOT1/HSENcN5ERyUE8+0kn/KAwKVmPTFLFzMNdr18V0HJcbN/DXfz57IgTyX6TYpj3ff
         8zRbujyqLIxtLoY73VHZap5Vi4ubilvRm6N/cMWrIwS0cP45jecKuLHC4nqyUjN45lFE
         FMZWCUhvHRzC+BUImbeq79lVABvwqDILTyVY1EaFajY7KupChZSeq4z07MLI7/l5bGcv
         E3Hw==
X-Gm-Message-State: AOAM532Il1TCEpOMeUA1xuigp7wFJazXyRyjFvW5RJoPj5bwlVf/wDUr
        sq1miMSj5NI4QzjIugKGGTrB01HOD5gTAky+FMulPQ==
X-Google-Smtp-Source: ABdhPJwLn+FNDqwfuSKkVOFjxo1S15hkPQEufBsajDpjhfn6f/gVEE3CILSzi+lMBrLaU8K33zQMNTfFSgXwQOnrx/E=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr1175790otf.281.1601461885462;
 Wed, 30 Sep 2020 03:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200924083156eucas1p14406128445a655393013effe719f2228@eucas1p1.samsung.com>
 <20200924083145.23312-1-m.szyprowski@samsung.com> <1f62b659-4534-c4de-28c1-07043b6468a7@samsung.com>
In-Reply-To: <1f62b659-4534-c4de-28c1-07043b6468a7@samsung.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 30 Sep 2020 12:31:14 +0200
Message-ID: <CAKMK7uENE3LroHkiYOX08M1g-dj4gb2JW_DJaDPW12gOPPaz6w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: tc358764: restore connector support
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:13 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> W dniu 24.09.2020 o 10:31, Marek Szyprowski pisze:
> > This patch restores DRM connector registration in the TC358764 bridge
> > driver and restores usage of the old drm_panel_* API, thus allows dynamic
> > panel registration. This fixes panel operation on Exynos5250-based
> > Arndale board.
> >
> > This is equivalent to the revert of the following commits:
> > 1644127f83bc "drm/bridge: tc358764: add drm_panel_bridge support"
> > 385ca38da29c "drm/bridge: tc358764: drop drm_connector_(un)register"
> > and removal of the calls to drm_panel_attach()/drm_panel_detach(), which
> > were no-ops and has been removed in meanwhile.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>
> Regards
> Andrzej
> > ---
> > As I've reported and Andrzej Hajda pointed, the reverted patches break
> > operation of the panel on the Arndale board. Noone suggested how to fix
> > the regression, I've decided to send a revert until a new solution is
> > found.
> >
> > The issues with tc358764 might be automatically resolved once the Exynos
> > DSI itself is converted to DRM bridge:
> > https://patchwork.kernel.org/cover/11770683/
> > but that approach has also its own issues so far.

I'm ok with the revert to fix the regression, but I'd kinda like to
see a bit more than "maybe we fix this in the future". Otherwise this
nice idea of having a common drm_bridge abstraction is just leading
towards a complete disaster where every combination of bridge/driver
works slightly differently. And we're half-way there in that mess
already I think.

Cheers, Daniel

> >
> > Best regards,
> > Marek Szyprowski
> > ---
> >   drivers/gpu/drm/bridge/tc358764.c | 107 +++++++++++++++++++++++++-----
> >   1 file changed, 92 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
> > index d89394bc5aa4..c1e35bdf9232 100644
> > --- a/drivers/gpu/drm/bridge/tc358764.c
> > +++ b/drivers/gpu/drm/bridge/tc358764.c
> > @@ -153,9 +153,10 @@ static const char * const tc358764_supplies[] = {
> >   struct tc358764 {
> >       struct device *dev;
> >       struct drm_bridge bridge;
> > +     struct drm_connector connector;
> >       struct regulator_bulk_data supplies[ARRAY_SIZE(tc358764_supplies)];
> >       struct gpio_desc *gpio_reset;
> > -     struct drm_bridge *panel_bridge;
> > +     struct drm_panel *panel;
> >       int error;
> >   };
> >
> > @@ -209,6 +210,12 @@ static inline struct tc358764 *bridge_to_tc358764(struct drm_bridge *bridge)
> >       return container_of(bridge, struct tc358764, bridge);
> >   }
> >
> > +static inline
> > +struct tc358764 *connector_to_tc358764(struct drm_connector *connector)
> > +{
> > +     return container_of(connector, struct tc358764, connector);
> > +}
> > +
> >   static int tc358764_init(struct tc358764 *ctx)
> >   {
> >       u32 v = 0;
> > @@ -271,11 +278,43 @@ static void tc358764_reset(struct tc358764 *ctx)
> >       usleep_range(1000, 2000);
> >   }
> >
> > +static int tc358764_get_modes(struct drm_connector *connector)
> > +{
> > +     struct tc358764 *ctx = connector_to_tc358764(connector);
> > +
> > +     return drm_panel_get_modes(ctx->panel, connector);
> > +}
> > +
> > +static const
> > +struct drm_connector_helper_funcs tc358764_connector_helper_funcs = {
> > +     .get_modes = tc358764_get_modes,
> > +};
> > +
> > +static const struct drm_connector_funcs tc358764_connector_funcs = {
> > +     .fill_modes = drm_helper_probe_single_connector_modes,
> > +     .destroy = drm_connector_cleanup,
> > +     .reset = drm_atomic_helper_connector_reset,
> > +     .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > +     .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > +};
> > +
> > +static void tc358764_disable(struct drm_bridge *bridge)
> > +{
> > +     struct tc358764 *ctx = bridge_to_tc358764(bridge);
> > +     int ret = drm_panel_disable(bridge_to_tc358764(bridge)->panel);
> > +
> > +     if (ret < 0)
> > +             dev_err(ctx->dev, "error disabling panel (%d)\n", ret);
> > +}
> > +
> >   static void tc358764_post_disable(struct drm_bridge *bridge)
> >   {
> >       struct tc358764 *ctx = bridge_to_tc358764(bridge);
> >       int ret;
> >
> > +     ret = drm_panel_unprepare(ctx->panel);
> > +     if (ret < 0)
> > +             dev_err(ctx->dev, "error unpreparing panel (%d)\n", ret);
> >       tc358764_reset(ctx);
> >       usleep_range(10000, 15000);
> >       ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> > @@ -296,28 +335,71 @@ static void tc358764_pre_enable(struct drm_bridge *bridge)
> >       ret = tc358764_init(ctx);
> >       if (ret < 0)
> >               dev_err(ctx->dev, "error initializing bridge (%d)\n", ret);
> > +     ret = drm_panel_prepare(ctx->panel);
> > +     if (ret < 0)
> > +             dev_err(ctx->dev, "error preparing panel (%d)\n", ret);
> > +}
> > +
> > +static void tc358764_enable(struct drm_bridge *bridge)
> > +{
> > +     struct tc358764 *ctx = bridge_to_tc358764(bridge);
> > +     int ret = drm_panel_enable(ctx->panel);
> > +
> > +     if (ret < 0)
> > +             dev_err(ctx->dev, "error enabling panel (%d)\n", ret);
> >   }
> >
> >   static int tc358764_attach(struct drm_bridge *bridge,
> >                          enum drm_bridge_attach_flags flags)
> > +{
> > +     struct tc358764 *ctx = bridge_to_tc358764(bridge);
> > +     struct drm_device *drm = bridge->dev;
> > +     int ret;
> > +
> > +     if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> > +             DRM_ERROR("Fix bridge driver to make connector optional!");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ctx->connector.polled = DRM_CONNECTOR_POLL_HPD;
> > +     ret = drm_connector_init(drm, &ctx->connector,
> > +                              &tc358764_connector_funcs,
> > +                              DRM_MODE_CONNECTOR_LVDS);
> > +     if (ret) {
> > +             DRM_ERROR("Failed to initialize connector\n");
> > +             return ret;
> > +     }
> > +
> > +     drm_connector_helper_add(&ctx->connector,
> > +                              &tc358764_connector_helper_funcs);
> > +     drm_connector_attach_encoder(&ctx->connector, bridge->encoder);
> > +     ctx->connector.funcs->reset(&ctx->connector);
> > +     drm_connector_register(&ctx->connector);
> > +
> > +     return 0;
> > +}
> > +
> > +static void tc358764_detach(struct drm_bridge *bridge)
> >   {
> >       struct tc358764 *ctx = bridge_to_tc358764(bridge);
> >
> > -     return drm_bridge_attach(bridge->encoder, ctx->panel_bridge,
> > -                              bridge, flags);
> > +     drm_connector_unregister(&ctx->connector);
> > +     ctx->panel = NULL;
> > +     drm_connector_put(&ctx->connector);
> >   }
> >
> >   static const struct drm_bridge_funcs tc358764_bridge_funcs = {
> > +     .disable = tc358764_disable,
> >       .post_disable = tc358764_post_disable,
> > +     .enable = tc358764_enable,
> >       .pre_enable = tc358764_pre_enable,
> >       .attach = tc358764_attach,
> > +     .detach = tc358764_detach,
> >   };
> >
> >   static int tc358764_parse_dt(struct tc358764 *ctx)
> >   {
> > -     struct drm_bridge *panel_bridge;
> >       struct device *dev = ctx->dev;
> > -     struct drm_panel *panel;
> >       int ret;
> >
> >       ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > @@ -326,16 +408,12 @@ static int tc358764_parse_dt(struct tc358764 *ctx)
> >               return PTR_ERR(ctx->gpio_reset);
> >       }
> >
> > -     ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
> > -     if (ret)
> > -             return ret;
> > -
> > -     panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> > -     if (IS_ERR(panel_bridge))
> > -             return PTR_ERR(panel_bridge);
> > +     ret = drm_of_find_panel_or_bridge(ctx->dev->of_node, 1, 0, &ctx->panel,
> > +                                       NULL);
> > +     if (ret && ret != -EPROBE_DEFER)
> > +             dev_err(dev, "cannot find panel (%d)\n", ret);
> >
> > -     ctx->panel_bridge = panel_bridge;
> > -     return 0;
> > +     return ret;
> >   }
> >
> >   static int tc358764_configure_regulators(struct tc358764 *ctx)
> > @@ -381,7 +459,6 @@ static int tc358764_probe(struct mipi_dsi_device *dsi)
> >               return ret;
> >
> >       ctx->bridge.funcs = &tc358764_bridge_funcs;
> > -     ctx->bridge.type = DRM_MODE_CONNECTOR_LVDS;
> >       ctx->bridge.of_node = dev->of_node;
> >
> >       drm_bridge_add(&ctx->bridge);
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

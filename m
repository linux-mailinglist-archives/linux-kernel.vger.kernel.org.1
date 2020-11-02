Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEF2A2F47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgKBQGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgKBQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:06:29 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:06:29 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id k125so3049967vka.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EAJxrbNKb2UnVB4OFa3XW/KW/bAnXVvDS85XdhAgXY=;
        b=kvaF0DVjznsslmC6N78FPbYUkt271nHsx8pzI2dwafQr+aWMtlTUXTa6XQF/UnTG7O
         v2m7iuSP5kYhINST9+HMHrHY96GvLZUaG+a7P/lEltBAhK4Cq1hSAal2iHde/HLUEona
         2yTUb6XZgmuzBIIq+4WmnRD4XDGPCre7UdoCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EAJxrbNKb2UnVB4OFa3XW/KW/bAnXVvDS85XdhAgXY=;
        b=WxPOgrqf1XJGQEq2cDnrnlIAk4rvd08tyMQOkP5aEvfZbKLic6644IRI+H5rzRCIDw
         Ec2ANMf7z0goAeLGxaBK6zpy+VANH7ATo+88Md//RRvIoSFVwiE3xImpSjN8naseZbWl
         PpeS0h4OwHMCzP/Nvt8YAm0qMmbBHNa6zQGrVVfufjAY3WUar0JPdm+X0myod6P4y4ae
         PxU+Fqd2x2giYvWEFZ3A0IW3hHvRo+/kZAPNJ0hHpTCyFIC3klcsKrnM6CXfN1WmiKG2
         aQu6j67YohKwaTdQ6565tUpVjhWEsnOBRcpjAzGrgDOqd6+xl1hybUSPmrrieGKCx/dp
         ZM5w==
X-Gm-Message-State: AOAM5307hW2RY8DQKmu77DPe/tw8N2T2aYhMfLqU8KW06EvfLc8npG8l
        lVOJWdC60+wOjWUZZ0ICHm0xBh4Vd0CGlw==
X-Google-Smtp-Source: ABdhPJyoJJuZ8vME2ujPi0kKc3fiNp7rOy1ic/uIBGdfGS0S1buprNqxDSZWrMpe5BgZrtPNDnydPw==
X-Received: by 2002:a1f:cd07:: with SMTP id d7mr13989939vkg.10.1604333188134;
        Mon, 02 Nov 2020 08:06:28 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id u7sm1539696vsj.1.2020.11.02.08.06.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:06:27 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id y78so7741530vsy.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:06:27 -0800 (PST)
X-Received: by 2002:a05:6102:309a:: with SMTP id l26mr2329294vsb.4.1604333186845;
 Mon, 02 Nov 2020 08:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201030011738.2028313-4-swboyd@chromium.org>
 <20201101192027.GA7612@pendragon.ideasonboard.com>
In-Reply-To: <20201101192027.GA7612@pendragon.ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Nov 2020 08:06:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VKTS7G9a3x8iHg=eWRFtrcwKBdwbdtynmHhV4KPCnDKQ@mail.gmail.com>
Message-ID: <CAD=FV=VKTS7G9a3x8iHg=eWRFtrcwKBdwbdtynmHhV4KPCnDKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 1, 2020 at 11:21 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Stephen,
>
> Thank you for the patch.
>
> On Thu, Oct 29, 2020 at 06:17:37PM -0700, Stephen Boyd wrote:
> > Use the DDC connection to read the EDID from the eDP panel instead of
> > relying on the panel to tell us the modes.
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index c77f46a21aae..f86934fd6cc8 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -119,6 +119,7 @@
> >   * @debugfs:      Used for managing our debugfs.
> >   * @host_node:    Remote DSI node.
> >   * @dsi:          Our MIPI DSI source.
> > + * @edid:         Detected EDID of eDP panel.
> >   * @refclk:       Our reference clock.
> >   * @panel:        Our panel.
> >   * @enable_gpio:  The GPIO we toggle to enable the bridge.
> > @@ -144,6 +145,7 @@ struct ti_sn_bridge {
> >       struct drm_bridge               bridge;
> >       struct drm_connector            connector;
> >       struct dentry                   *debugfs;
> > +     struct edid                     *edid;
> >       struct device_node              *host_node;
> >       struct mipi_dsi_device          *dsi;
> >       struct clk                      *refclk;
> > @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
> >  static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
> >  {
> >       struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
> > +     struct edid *edid = pdata->edid;
> > +     int num, ret;
> > +
> > +     if (!edid) {
> > +             pm_runtime_get_sync(pdata->dev);
> > +             edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
> > +             pm_runtime_put(pdata->dev);
> > +     }
>
> Do we need to cache the EDID ? It seems like something that should be
> done by the DRM core (well, caching modes in that case), not by
> individual bridge drivers.

I can take the blame for the fact that it does caching, since I
requested it in early reviews.  In general boot speed is pretty
important to me and each read of the EDID take 20 ms.  There are
definitely several calls to get the EDID during a normal bootup.
Stephen did a little more digging into exactly what was causing all
these calls and can chime in, but in general until we can eliminate
the extra calls it seems like it'd be nice to keep the caching?  This
bridge chip is intended for use for eDP for internal panels, so there
should be no downside to caching.  If we can later optimize the DRM
core, we can fix this and a pre-existing driver that does the same
type of caching (analogix-anx6345.c) at the same time?

-Doug

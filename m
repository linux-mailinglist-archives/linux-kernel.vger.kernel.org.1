Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA32B01B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgKLJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgKLJHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:07:45 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78DC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:07:43 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 7so6649127ejm.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9u5Hd/k602S0Bq8sFpKbzZCXBppMuyyaNJFma4F5QE=;
        b=ATw238UzY8CkoOP/BcuZxyhhEruWXvBv8RLXARErrKNDzHlh6KQFXQC0ncFMsuC6ua
         gpjKPJRjXUvAgADluKLG9wSZ7LJQtQ0xNMbWxfh4kTqfFGhBr0FhHCvt+Obu9WvUEmMm
         K6tfy6kj79u1gZU1cSoMNa9kf8Ph4Ev1Vv0sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9u5Hd/k602S0Bq8sFpKbzZCXBppMuyyaNJFma4F5QE=;
        b=RZvb1Gf1lb3H1BDm9UXTNXGezlUuaFtC/OLLn9lR0gl79LmPb6vzvY6HjrJ8PXuYzg
         xORd+jsJ8PIv2vG17bRpB04zk5M10v/6zDZqXCtbwHi/aSwT8b0UaqnID0PzYaA7LOXy
         tr8loPXwdUQfWDkHBrvlEqlf5hQwb27iqeEzTAWK0eGybDht/U1qrUaQbr0CresX/VNS
         rPJ+qqRdGgcB8PW14CoPSOE6NfK0MB+J07IvXGFC40tDrBZt39QqmLQ08faU+E78gWXm
         IdqBUoDnqBc1LZYAQGGQA/WCEbOiNUxtXe4PLDyUZrgJ4BaLqUnFCIZw1Vriqzp8fkLn
         0gqA==
X-Gm-Message-State: AOAM530C3SFkm5g8auqcQhIlggR3kUckCGu9EQ62HFl8lN9uii9X7ak2
        WeKEiTk62slP9xM9MyBnQGj2b8zA1cm2glESu0ecvQ==
X-Google-Smtp-Source: ABdhPJzxNklwusGJ+2JRv2DnbMZ3qgM8ZPseYvtZ8KlaKgS9SKNyVEE5WuuRwiVGYGYezRJmS7hx/ngCbMSs39+qLJI=
X-Received: by 2002:a17:906:1e04:: with SMTP id g4mr28399323ejj.72.1605172061677;
 Thu, 12 Nov 2020 01:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20201112064051.3716968-1-pihsun@chromium.org> <20201112085920.GB1367855@google.com>
In-Reply-To: <20201112085920.GB1367855@google.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Thu, 12 Nov 2020 17:07:05 +0800
Message-ID: <CANdKZ0cGXkcVfevpT4y_za5vu_y0s-NdCvhw1AVibK-q_W8yBw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Add anx7625 port switching.
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Please see inline reply as below.

On Thu, Nov 12, 2020 at 4:59 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Pi-Hsun,
>
> I haven't gone through the code, but did have a high-level comment
> (kindly see inline)
>
> On Thu, Nov 12, 2020 at 02:40:40PM +0800, Pi-Hsun Shih wrote:
> > When output 2 lanes DP data, anx7625 can output to either TX1/RX1 or
> > TX2/RX2. In typical usage, these two TX/RX pairs corresponds to two
> > orientations of typec.
> >
> > On some board one anx7625 is used as DPI to DP converter for two typec
> > ports. In this case, the TX1/RX1 and TX2/RX2 are connected to two usb
> > muxes, which mux the DP data with the rest of the USB3 data, and
> > connects to the two typec ports.
> >
> > This patch adds option for anx7625 to acts as a usb typec switch and
> > switch output lanes based on the typec orientation, or acts as two usb
> > typec mux and switch output lanes depending on whether the two ports
> > currently has DP enabled.
> >
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> >
> > ====================================================================
> >
> > This is an attempt to use typec framework with how we're using anx7625
> > on Chrome OS asurada board.
> >
> > An example of the dts for the two ports case can be found at
> > https://crrev.com/c/2507199/6
>
> Do you plan on submitting DT schemas & bindings documentation for the switch(es)
> that are intended to be used?

Yes I plan to submit corresponding DT schemas & bindings documentation
changes if this change looks good.

>
> I would strongly recommend that for usb-c-connector since AFAIK they don't exist, and
> I don't believe there is explicit support for them in the Type C connector class framework
> (even .
>
> IMO this would be needed to ensure an implementation here doesn't break
> in the event of modifications to the connector class framework (or Type
> C port drivers like cros-ec-typec) in the future. I think some patches
> were floated for this for orientation switch [1] so those might provide
> some hints about how to proceed.
>
> I've CC-ed Heikki (Type C maintainer) in case he has additional comments regarding this.
>
> >
> > Sending this as a RFC patch since I'm not sure about the best approach
> > here. Should the logic of switching output lanes depends on ports be
> > coupled inside anx7625 driver, or in another driver, or is there
> > any existing way to accomplish this?
>
> Might be good to add [RFC] as a tag instead of [PATCH] in case this
> iteration is chiefly to solicit comments.

Ah I did have [RFC] tag in some local .patch files before. I guess I
somehow forgot it in later `git format-patch` runs...
I'll add the tag in the next version, thanks for the comments.

>
> Best regards,
>
> -Prashant
>
> [1]:
> https://lore.kernel.org/linux-usb/1604403610-16577-1-git-send-email-jun.li@nxp.com/
> >

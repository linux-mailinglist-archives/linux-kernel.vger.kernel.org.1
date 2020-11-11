Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444A62AEAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKKIAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKIAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:00:09 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E56C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:00:05 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id s35so275616pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 00:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d02g+zhQMhpaDvTn0zDbRhRDWrRC5B6qJJz7rxHmhvk=;
        b=l5NnLaP9K1JapsaAQXaB8IUPWmIzvVVjxOPXTnY4LAqfJpynKxsQ6wRuVs4BGucwEm
         aJ/ngYVDWQAtA8Rq2D/hfXXkXPJZ+uo1BctGZDFkjngmYPuMN6XIO80nHLEJ0fdzI0t+
         W1XOaDqKDIU9ubq52Ej0H6b96FVSgLmVTPEfEbOu9fCBcTq4+AfG2/WC+vzLq5b+G6Oa
         HgngwLyIdV0hoh+lq32G0nGS9sohC4aZCzV1oSrdT/gC0oNsyZIQ7JLCqzWI3WfVln0I
         5Ru+8iA12FIn8Q+AkEOsNACkUKEEl67indYrhif1z4ZlrHNitQLSGo4mlqXqZ+pAPW1F
         pnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d02g+zhQMhpaDvTn0zDbRhRDWrRC5B6qJJz7rxHmhvk=;
        b=KLyV8ll3yVpPe8P06GA3GzU5MMHrOAWAAhapxWT9VjItqQtE6X13eLoTv1pXaCd/vQ
         S17uuyO3Kz3dufcHqo3R3Y0LUaT8HpO3CC3SgTZZ/4JavZUzWeryn1ogx7iCXENzOf+V
         92sIP3lkbGBaFw2FV0A3kQtQ7012kqd1E+zJ/BwKqUanC69e0bPaTb2GhEMcULUQbWv+
         yzJT5EmoXG5rmD55c/59wV0GT/u4+pT6yxW+D1wNyJqgVl05L2h3BWQYhKuPVauhfHU4
         QBBNc57nQgoNvz68MxBqH/7kwXAe4968xORH20SVD7mL7SShkEnXr5bX716mTBBTt5rZ
         K7pA==
X-Gm-Message-State: AOAM532E2t752rk3NY4e69RDfaIT9ynow/0tTmIMsNVBdbYuvbguI3Av
        u1aP22bHrXw12XN7dxge1wZbhfk/e4YF+6jRcb4=
X-Google-Smtp-Source: ABdhPJwaR2ZBgrMvFOCxPmERr/GODcyDwdLR8u4nldVHHcxLvDF36BYKAQef57Eysm+cYSwP4/y/Y/h+8VIhT0McGss=
X-Received: by 2002:a17:902:d3ca:b029:d7:e0f9:b9c with SMTP id
 w10-20020a170902d3cab02900d7e0f90b9cmr11696040plb.2.1605081605125; Wed, 11
 Nov 2020 00:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20201031081747.372599-1-net147@gmail.com> <20201108095322.GA1129714@ravnborg.org>
 <20201108095724.GW1551@shell.armlinux.org.uk> <20201108104742.GA1161483@ravnborg.org>
In-Reply-To: <20201108104742.GA1161483@ravnborg.org>
From:   Jonathan Liu <net147@gmail.com>
Date:   Wed, 11 Nov 2020 18:59:49 +1100
Message-ID: <CANwerB0NGbtGna2c4+XNeGPUvNL1vfpAeiNTQEyEo-u+wM+Piw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Avoid resetting force in the detect function
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Fabio Estevam <fabio.estevam@freescale.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sun, 8 Nov 2020 at 21:47, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Russell,
>
> On Sun, Nov 08, 2020 at 09:57:25AM +0000, Russell King - ARM Linux admin wrote:
> > On Sun, Nov 08, 2020 at 10:53:22AM +0100, Sam Ravnborg wrote:
> > > Russell,
> > >
> > > On Sat, Oct 31, 2020 at 07:17:47PM +1100, Jonathan Liu wrote:
> > > > It has been observed that resetting force in the detect function can
> > > > result in the PHY being powered down in response to hot-plug detect
> > > > being asserted, even when the HDMI connector is forced on.
> > > >
> > > > Enabling debug messages and adding a call to dump_stack() in
> > > > dw_hdmi_phy_power_off() shows the following in dmesg:
> > > > [  160.637413] dwhdmi-rockchip ff940000.hdmi: EVENT=plugin
> > > > [  160.637433] dwhdmi-rockchip ff940000.hdmi: PHY powered down in 0 iterations
> > > >
> > > > Call trace:
> > > > dw_hdmi_phy_power_off
> > > > dw_hdmi_phy_disable
> > > > dw_hdmi_update_power
> > > > dw_hdmi_detect
> > > > dw_hdmi_connector_detect
> > > > drm_helper_probe_detect_ctx
> > > > drm_helper_hpd_irq_event
> > > > dw_hdmi_irq
> > > > irq_thread_fn
> > > > irq_thread
> > > > kthread
> > > > ret_from_fork
> > > >
> > > > Fixes: 381f05a7a842 ("drm: bridge/dw_hdmi: add connector mode forcing")
> > > > Signed-off-by: Jonathan Liu <net147@gmail.com>
> > >
> > > you are the original author of this code - any comments on this patch?
> >
> > No further comments beyond what has already been discussed, and the
> > long and short of it is it's been so long that I don't remember why
> > that code was there. Given that, I'm not even in a position to ack
> > the change. Sorry.
> Thanks for the quick reply.
>
> Given that this fixes a problem for Jonathan I will apply this to -fixes
> if there is no other feedback the next couple of days.
> If it introduces regression we can take it from there.
>
> Jonathan - please ping me if I forget.
>
>         Sam

Ping.

Regards,
Jonathan

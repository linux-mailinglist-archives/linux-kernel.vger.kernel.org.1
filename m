Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8F2A362D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgKBV4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKBV4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:56:31 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A0C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 13:56:31 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3EDBF583;
        Mon,  2 Nov 2020 22:56:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1604354187;
        bh=89P0rtmbvGghV/QE8F8hRIZpDj6Er59rua00pGU1HKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfJzoGe7SDaqyeXt7EcNjKen2Xu/hoZRTpKea4JxoyJrLVwuvdFpgnnN1zD8nq7Vw
         WEjhR1WD42k79W/o9mmE8pQeKbcdQKlsBtlRa6npDcXSHEh2YaJeL7DOg3iiKdwxvq
         x76hSFJgfXbusuqBu3xDU00Qak9bBBGXXcoI5U6Q=
Date:   Mon, 2 Nov 2020 23:55:39 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v2 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
Message-ID: <20201102215539.GF3971@pendragon.ideasonboard.com>
References: <20201030011738.2028313-1-swboyd@chromium.org>
 <20201030011738.2028313-4-swboyd@chromium.org>
 <20201101192027.GA7612@pendragon.ideasonboard.com>
 <CAD=FV=VKTS7G9a3x8iHg=eWRFtrcwKBdwbdtynmHhV4KPCnDKQ@mail.gmail.com>
 <160433869233.884498.1989382962614280308@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <160433869233.884498.1989382962614280308@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Nov 02, 2020 at 09:38:12AM -0800, Stephen Boyd wrote:
> Quoting Doug Anderson (2020-11-02 08:06:14)
> > On Sun, Nov 1, 2020 at 11:21 AM Laurent Pinchart wrote:
> > > On Thu, Oct 29, 2020 at 06:17:37PM -0700, Stephen Boyd wrote:
> > > > @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *connector)
> > > >  static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
> > > >  {
> > > >       struct ti_sn_bridge *pdata = connector_to_ti_sn_bridge(connector);
> > > > +     struct edid *edid = pdata->edid;
> > > > +     int num, ret;
> > > > +
> > > > +     if (!edid) {
> > > > +             pm_runtime_get_sync(pdata->dev);
> > > > +             edid = pdata->edid = drm_get_edid(connector, &pdata->aux.ddc);
> > > > +             pm_runtime_put(pdata->dev);
> > > > +     }
> > >
> > > Do we need to cache the EDID ? It seems like something that should be
> > > done by the DRM core (well, caching modes in that case), not by
> > > individual bridge drivers.
> > 
> > I can take the blame for the fact that it does caching, since I
> > requested it in early reviews.  In general boot speed is pretty
> > important to me and each read of the EDID take 20 ms.  There are
> > definitely several calls to get the EDID during a normal bootup.
> > Stephen did a little more digging into exactly what was causing all
> > these calls and can chime in, 
> 
> In ChromeOS we get modes a couple times and then whenever we connect or
> disconnect a DP cable for external display we also get modes. It seems
> that we also run modetest at boot but I'm not sure why we do that. I
> think it is to gather diagnostic data for all the EDIDs on the device at
> boot so we know what all is connected.
> 
> > but in general until we can eliminate
> > the extra calls it seems like it'd be nice to keep the caching?  This
> > bridge chip is intended for use for eDP for internal panels, so there
> > should be no downside to caching.  If we can later optimize the DRM
> > core, we can fix this and a pre-existing driver that does the same
> > type of caching (analogix-anx6345.c) at the same time?
> 
> I'd like to add the caching somewhere in the core (maybe the bridge
> connector code?) but I don't know what the logic should be. Is it eDP
> and if not hpd notify then cache all the time and if it is eDP and hpd
> notify then cache once hpd notify says detected and drop cache when no
> longer detected?
> 
> 	if (eDP) {
> 		if (!hpd)
> 			cache();
> 		else if (hpd_detected()) {
> 			cache();
> 		else if (!hpd_detected()) {
> 			drop_cache();
> 		}
> 	}
> 
> I thought that EDID could change and HPD can be pulsed to notify that it
> should be read again.

I think we should expose a flag tells the panel is fixed instead of
making it a special case of eDP, as other panel types could benefit from
the same mechanism. Otherwise, yes, I think it's really about caching
the EDID the first time we read it, and then reusing it. The question is
who should convert EDID to modes. At the moment bridge drivers do so,
and we're migrating to drm_bridge_connector for most cases. That would
be a candidate location to cache EDID. The DRM core would be another
one, but in that case we may need to also cache the modes.

-- 
Regards,

Laurent Pinchart

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319812A31BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgKBRiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgKBRiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:38:16 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD494C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:38:14 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id x13so11712039pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=8TTac8powIKxnrBZ37Qjfao9bhPKPpAxX0Xh5E4KL5E=;
        b=jK3ykP36tExYCAPVVAm2YTynBYGQPqQPtkKu+VT/+wxZypJUrIf06+iHJXRt7rvc7f
         eZvXoF2Gy3WcpC9qxFhN8Rqk1L8vuWPTngdn0V2yrmvRnruxfJ6A7F0M3TxZ+h1KHdvo
         tLkwUBvMmGO7zlP0m8dd8dceaXDiHrbBxsy/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=8TTac8powIKxnrBZ37Qjfao9bhPKPpAxX0Xh5E4KL5E=;
        b=aqFgz3FpyJdFlWMtVMPMocDCMrJPsTqDrGLY26Nw7YXKcNPUUEeUcON3nHBE/Pljxc
         enEQxYJoIW52DRSjctwJWUMSlvNGMr7e90xlB2lKTVfIhuHVmBDD0l947PyLfqxta31I
         GxAwJG9RH67JZRTuoy6AKpK7gxk5ixSTm5t7xy3H2/VmOL9m2JMYQtY4klvkX0WwLT5U
         +BO+aPKqp/kpT/FU3Otkxe3nz6scN0gRQQjkSpGAeYA6FzGxvUuSrOsemYbqHSUKs/tQ
         LJ3SduPDh8VHIlhF+3kGkN5vRSpSiRW3UYHwDMm3MMlTutiFKzAoHbAro/P8ZsElcven
         Zawg==
X-Gm-Message-State: AOAM531qiyL9X1AAZ1oQs8oPKQm1fXFBel4a+qrzwyo0OINLWnp9ANnH
        4spDdHz27nUWKGEGQxx2c6ICY0J5sS0RZQ==
X-Google-Smtp-Source: ABdhPJzv8jGtg/TxPSmziKdWoyu4EAbnBFaw7EnnZAW2MW+yGDBYCGFXtHl/8GkSlcNeKcwHVG9BUg==
X-Received: by 2002:a17:90a:ec13:: with SMTP id l19mr19246817pjy.51.1604338694299;
        Mon, 02 Nov 2020 09:38:14 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i25sm710301pfo.167.2020.11.02.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:38:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VKTS7G9a3x8iHg=eWRFtrcwKBdwbdtynmHhV4KPCnDKQ@mail.gmail.com>
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201030011738.2028313-4-swboyd@chromium.org> <20201101192027.GA7612@pendragon.ideasonboard.com> <CAD=FV=VKTS7G9a3x8iHg=eWRFtrcwKBdwbdtynmHhV4KPCnDKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>
To:     Doug Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Mon, 02 Nov 2020 09:38:12 -0800
Message-ID: <160433869233.884498.1989382962614280308@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-11-02 08:06:14)
> On Sun, Nov 1, 2020 at 11:21 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Thu, Oct 29, 2020 at 06:17:37PM -0700, Stephen Boyd wrote:
> > > @@ -265,6 +267,23 @@ connector_to_ti_sn_bridge(struct drm_connector *=
connector)
> > >  static int ti_sn_bridge_connector_get_modes(struct drm_connector *co=
nnector)
> > >  {
> > >       struct ti_sn_bridge *pdata =3D connector_to_ti_sn_bridge(connec=
tor);
> > > +     struct edid *edid =3D pdata->edid;
> > > +     int num, ret;
> > > +
> > > +     if (!edid) {
> > > +             pm_runtime_get_sync(pdata->dev);
> > > +             edid =3D pdata->edid =3D drm_get_edid(connector, &pdata=
->aux.ddc);
> > > +             pm_runtime_put(pdata->dev);
> > > +     }
> >
> > Do we need to cache the EDID ? It seems like something that should be
> > done by the DRM core (well, caching modes in that case), not by
> > individual bridge drivers.
>=20
> I can take the blame for the fact that it does caching, since I
> requested it in early reviews.  In general boot speed is pretty
> important to me and each read of the EDID take 20 ms.  There are
> definitely several calls to get the EDID during a normal bootup.
> Stephen did a little more digging into exactly what was causing all
> these calls and can chime in,=20

In ChromeOS we get modes a couple times and then whenever we connect or
disconnect a DP cable for external display we also get modes. It seems
that we also run modetest at boot but I'm not sure why we do that. I
think it is to gather diagnostic data for all the EDIDs on the device at
boot so we know what all is connected.

> but in general until we can eliminate
> the extra calls it seems like it'd be nice to keep the caching?  This
> bridge chip is intended for use for eDP for internal panels, so there
> should be no downside to caching.  If we can later optimize the DRM
> core, we can fix this and a pre-existing driver that does the same
> type of caching (analogix-anx6345.c) at the same time?

I'd like to add the caching somewhere in the core (maybe the bridge
connector code?) but I don't know what the logic should be. Is it eDP
and if not hpd notify then cache all the time and if it is eDP and hpd
notify then cache once hpd notify says detected and drop cache when no
longer detected?

	if (eDP) {
		if (!hpd)
			cache();
		else if (hpd_detected()) {
			cache();
		else if (!hpd_detected()) {
			drop_cache();
		}
	}

I thought that EDID could change and HPD can be pulsed to notify that it
should be read again.

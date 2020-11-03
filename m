Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B086C2A3840
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgKCBP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCBP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:15:27 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ADDC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 17:15:27 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id o3so12330700pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=PqAbEpNaqalCL4gjVLHLOZmt8aSF7C4UgItgtzwaFzw=;
        b=Co/H6SGZJetUfpLSN6UcHn8yI/ZbXVM4biUCT5+bBZHl4+NBtkDegXvPd4KMNIRHRb
         UdL80W61Raf1tTMAfbBN/lrGNTNHZHHjIamdINXcd0oHCPJkL7DPv0+fs4uwhWiLDrUM
         OrF3n4VztpswIGau9qDdHF3pzNmcsgzPKU/bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=PqAbEpNaqalCL4gjVLHLOZmt8aSF7C4UgItgtzwaFzw=;
        b=An6aJ0Dgtu7aU/ZkHJZdUVuPS9RzHAopydp0k9lu4/PtCO24jQAI+eEKdFMApaD9vt
         gk4RTZ4/MXSfQZ0KyLISSNImfXrbFfLtsQZYC2hfKBqVxOMx/pa3n6gu3D+WxeDY2bkS
         CBpBoJgtPEH0R3IUB+LuD7oC/A3eM+D6aMAWOszJrIJKpveUFSkkQQv3Amw/AXSJDXkx
         10sHOCb+TLHU5o5OnSxGJm3bVXos5BqkWrz6RJr0R/yTVlkhgMmur2Zy3sKvWJ94JOQS
         ex6eTokX+dcE9MrW35budtMHlE8cGVeMWlOZA3EvWpTFjgKYhBK0eAx3wlEhrDDBvnrf
         ozxw==
X-Gm-Message-State: AOAM533a1Yq7zbMTa3h1OW51Sq5OvbR9znTXNCMBXsNuOC+Sbwxs1Kqx
        ZcMq2JuKh4ZZMJO/XezMtPHxrA==
X-Google-Smtp-Source: ABdhPJxyyHyCsFAt6uHd9IBB9Q7GU9/Cm2oktg1f3L5A2dQ2xhhfNg0ly2klkUgQPL5yKl3c5iQhAA==
X-Received: by 2002:a62:2a94:0:b029:155:3225:6fd0 with SMTP id q142-20020a622a940000b029015532256fd0mr24297587pfq.64.1604366127124;
        Mon, 02 Nov 2020 17:15:27 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z12sm747236pfg.123.2020.11.02.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 17:15:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201101173741.GA1293305@ravnborg.org>
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201101173741.GA1293305@ravnborg.org>
Subject: Re: [PATCH v2 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Date:   Mon, 02 Nov 2020 17:15:24 -0800
Message-ID: <160436612483.884498.883110130131457033@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Ravnborg (2020-11-01 09:37:41)
> Hi Stephen.
>=20
> On Thu, Oct 29, 2020 at 06:17:34PM -0700, Stephen Boyd wrote:
> > This patch series cleans up the DDC code a little bit so that
> > it is more efficient time wise and supports grabbing the EDID
> > of the eDP panel over the aux channel. I timed this on a board
> > I have on my desk and it takes about 20ms to grab the EDID out
> > of the panel and make sure it is valid.
> >=20
> > The first two patches seem less controversial so I stuck them at
> > the beginning. The third patch does the EDID reading and caches
> > it so we don't have to keep grabbing it over and over again. And
> > finally the last patch updates the reply field so that short
> > reads and nacks over the channel are reflected properly instead of
> > treating them as some sort of error that can't be discerned.
> >=20
> > Stephen Boyd (4):
> >   drm/bridge: ti-sn65dsi86: Combine register accesses in
> >     ti_sn_aux_transfer()
> >   drm/bridge: ti-sn65dsi86: Make polling a busy loop
> >   drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
> >   drm/bridge: ti-sn65dsi86: Update reply on aux failures
>=20
> Series looks good. You can add my a-b on the full series.
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
> I can apply after Douglas have had a look at the patches he did not r-b
> yet.
>=20
> Any chance we can convince you to prepare this bridge driver for use in
> a chained bridge setup where the connector is created by the display
> driver and uses drm_bridge_funcs?
>=20
> First step wuld be to introduce the use of a panel_bridge.
> Then add get_edid to drm_bridge_funcs and maybe more helpers.
>=20
> Then natural final step would be to move connector creation to the
> display driver - see how other uses drm_bridge_connector_init() to do so
> - it is relatively simple.
>=20
> Should be doable - and reach out if you need some help.
>=20

I started to look at this and got stuck at ti_sn_bridge_get_bpp(). Where
can I get the details of the bpc for the downstream bridge or panel? Is
there some function that can tell this bridge what the bpc is for the
attached connector? I see that td_mode_valid() in
drivers/gpu/drm/bridge/tc358775.c stores away the bpc from the incoming
drm_display_info pointer but I'm not sure that is correct because can't
that be called for various and not necessarily the one we're using?

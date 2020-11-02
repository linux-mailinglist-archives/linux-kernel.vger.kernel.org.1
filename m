Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B42A30FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKBRJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgKBRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:09:24 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C8C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:09:24 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b12so7138824plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=VqiKVe2OHLmU5JAf22RJzOSV9uu3Tp5oES/Ka+XZU48=;
        b=E+GXv1xhCIFEzwW4SU0iieWzqTiYdPYfZF6FA2tz6ySZFh1DEj0TtTVOvRllE4Y+Zg
         3FIeqIKXsy3OCMw12k0bjJZ79kpcoZnH5cFiu0RdpC7ciFct3ko4skYK+BTqTLmaqoUp
         jYNEdNCK5gPrswQ77HOQQVSQR0xPt/gAyFjTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=VqiKVe2OHLmU5JAf22RJzOSV9uu3Tp5oES/Ka+XZU48=;
        b=e+L8EweYQ7KfHrFOYziP/lnbRHVik1bpEomre9exi1FKLIfNPh+It/JPxhczx93P9A
         xpjYBqrrr+olK/10ROsQ7+TnbrFMuuAShZMsDEzyZxWyCfZSSEmQj9qhrYieoc3eABWI
         RuJ9Z747+wnVoIgN7jASbvI+ERWp9ECnnaHr5d+d6TT0bFrwtCFKRmg34UOX3/IbPzGC
         SNOVCXaBIvyO7+BbDYRNKieaB2oKnzedJ3y4dpeUBQ1kPdYubIRV1GEktXJC6BEOwH8f
         /RqJaEXL97AP990AVPrrNCpo8zj3II+fevbddtZ9czijamrgI/nLkHEZwreFDARZtnMQ
         E1fQ==
X-Gm-Message-State: AOAM532NB2rcJVx2L1JmLoMn4nHxRrWvNJfeDhYZ9o3j6hWCObkW/b0P
        TKgirRrsDF1gg24OtwIokiEmWg==
X-Google-Smtp-Source: ABdhPJw8zB5/xSM90Q8TpAiNu3BRaZP596eYjK1Ir/3iDyBzYNs4HvGpVlbgKbb6uPSonDX/JXU8Fw==
X-Received: by 2002:a17:902:ba96:b029:d5:f36b:44af with SMTP id k22-20020a170902ba96b02900d5f36b44afmr20995122pls.51.1604336963252;
        Mon, 02 Nov 2020 09:09:23 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id i11sm7619662pfd.211.2020.11.02.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:09:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=V3kktCrwvMBeOy1dnQGYuV-ZUGX81+upRZacfzxjceFg@mail.gmail.com>
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201101173741.GA1293305@ravnborg.org> <CAD=FV=V3kktCrwvMBeOy1dnQGYuV-ZUGX81+upRZacfzxjceFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Mon, 02 Nov 2020 09:09:21 -0800
Message-ID: <160433696138.884498.1206890596724384092@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-11-02 08:37:21)
> Hi,
>=20
> On Sun, Nov 1, 2020 at 9:37 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Stephen.
> >
> > On Thu, Oct 29, 2020 at 06:17:34PM -0700, Stephen Boyd wrote:
> > > This patch series cleans up the DDC code a little bit so that
> > > it is more efficient time wise and supports grabbing the EDID
> > > of the eDP panel over the aux channel. I timed this on a board
> > > I have on my desk and it takes about 20ms to grab the EDID out
> > > of the panel and make sure it is valid.
> > >
> > > The first two patches seem less controversial so I stuck them at
> > > the beginning. The third patch does the EDID reading and caches
> > > it so we don't have to keep grabbing it over and over again. And
> > > finally the last patch updates the reply field so that short
> > > reads and nacks over the channel are reflected properly instead of
> > > treating them as some sort of error that can't be discerned.
> > >
> > > Stephen Boyd (4):
> > >   drm/bridge: ti-sn65dsi86: Combine register accesses in
> > >     ti_sn_aux_transfer()
> > >   drm/bridge: ti-sn65dsi86: Make polling a busy loop
> > >   drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
> > >   drm/bridge: ti-sn65dsi86: Update reply on aux failures
> >
> > Series looks good. You can add my a-b on the full series.
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > I can apply after Douglas have had a look at the patches he did not r-b
> > yet.
>=20
> They look fine to me now assuming that Stepehn has tested patch #1
> enough that we're confident that the slight change in ordering isn't
> going to mess anything up.

I did test it but the test isn't thorough enough to cover the timeout
case. I'll resend with v1 of this patch and pick up acks and include
Sam on To line.

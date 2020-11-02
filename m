Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043212A2FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgKBQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgKBQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:37:35 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700B8C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:37:35 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id t8so4980616vsr.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovcjCIOpEfV1hqgQxS2QKiT2OQ1ZSCW/4Q1xN3dJVgs=;
        b=UzxkgOqrCuwNQptJpjds/vbFdVftn+vsaKBt+OKdu5fA0iysZmmnM3ZO1zgHfFfPJf
         T+q0GQO9iZp3k+UyuSTmlGNIBqYZnQrVMxWpoz1b34lqx+TbsG/RE5GhpsGUDDnDyMtd
         oj0l/C9Bcly2821At1syMoRBFjBiS4kXUtPMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovcjCIOpEfV1hqgQxS2QKiT2OQ1ZSCW/4Q1xN3dJVgs=;
        b=p7iSITks5iS1VByX7qn688oHbU7Q+C+Gv6wbmvHgRMKbkmLLcE6ruGEyW48szam00O
         Dtr5dfPyT9dZ2wD1xjo8C6qI8k2mIiBRBo8ROtiTaKO7j6BeHjGbhLWAlgS+XX5xM2sW
         y1/33R6NtX4cLxa1+Y3j4qT0ninOGbUzClX6LoH7RXyQsPzbReMbLTE+/6awswRyJcd5
         3va09lLDMg5bR23ZyLrBQRyHVfUA78tdcfyTrMhSBgkHU5SjdFavNmc/16EdwYwdf+xE
         g9XN4vVK48mG53mH9GmSHmHknJrfo79hVc/gmyHZBIufS/wDW+e49/s2A1L8PZlJf0ZN
         MFhQ==
X-Gm-Message-State: AOAM530b7ImKF45SUsz80YZHFzOPoKPcbbraFqEhor6CN2dU+qN53UW4
        iUEMHBk5jsiA4DUW11rq8+biywq7n5GQlQ==
X-Google-Smtp-Source: ABdhPJyY7qcA9F8dFPUvTxPY60LFLtMkI+Ct9dZdulhV6SN2gRd+qeJ/aByNA+7U6kuNPQSQbVZrLQ==
X-Received: by 2002:a67:df97:: with SMTP id x23mr14052180vsk.13.1604335054476;
        Mon, 02 Nov 2020 08:37:34 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id b62sm2122162vsb.7.2020.11.02.08.37.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:37:33 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id d125so3066590vkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:37:32 -0800 (PST)
X-Received: by 2002:ac5:c885:: with SMTP id n5mr13399838vkl.21.1604335052255;
 Mon, 02 Nov 2020 08:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201101173741.GA1293305@ravnborg.org>
In-Reply-To: <20201101173741.GA1293305@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Nov 2020 08:37:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V3kktCrwvMBeOy1dnQGYuV-ZUGX81+upRZacfzxjceFg@mail.gmail.com>
Message-ID: <CAD=FV=V3kktCrwvMBeOy1dnQGYuV-ZUGX81+upRZacfzxjceFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Nov 1, 2020 at 9:37 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Stephen.
>
> On Thu, Oct 29, 2020 at 06:17:34PM -0700, Stephen Boyd wrote:
> > This patch series cleans up the DDC code a little bit so that
> > it is more efficient time wise and supports grabbing the EDID
> > of the eDP panel over the aux channel. I timed this on a board
> > I have on my desk and it takes about 20ms to grab the EDID out
> > of the panel and make sure it is valid.
> >
> > The first two patches seem less controversial so I stuck them at
> > the beginning. The third patch does the EDID reading and caches
> > it so we don't have to keep grabbing it over and over again. And
> > finally the last patch updates the reply field so that short
> > reads and nacks over the channel are reflected properly instead of
> > treating them as some sort of error that can't be discerned.
> >
> > Stephen Boyd (4):
> >   drm/bridge: ti-sn65dsi86: Combine register accesses in
> >     ti_sn_aux_transfer()
> >   drm/bridge: ti-sn65dsi86: Make polling a busy loop
> >   drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
> >   drm/bridge: ti-sn65dsi86: Update reply on aux failures
>
> Series looks good. You can add my a-b on the full series.
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> I can apply after Douglas have had a look at the patches he did not r-b
> yet.

They look fine to me now assuming that Stepehn has tested patch #1
enough that we're confident that the slight change in ordering isn't
going to mess anything up.  Laurent also had comments about caching
the EDID on patch #3.  If he feels strongly about getting rid of that,
it'll need another spin and we'll just have to suck up the small boot
time penalty until we can find a solution in the core.


> Any chance we can convince you to prepare this bridge driver for use in
> a chained bridge setup where the connector is created by the display
> driver and uses drm_bridge_funcs?
>
> First step wuld be to introduce the use of a panel_bridge.
> Then add get_edid to drm_bridge_funcs and maybe more helpers.
>
> Then natural final step would be to move connector creation to the
> display driver - see how other uses drm_bridge_connector_init() to do so
> - it is relatively simple.
>
> Should be doable - and reach out if you need some help.

At some point I think Vinod tried to prepare a patch for this and I
tried it, but it didn't just work.  I spent an hour or so poking at it
and I couldn't quite figure out why and I couldn't find enough other
examples to compare against to see what was wrong...  That was a few
months ago, though.  Maybe things are in a better shape now?

-Doug

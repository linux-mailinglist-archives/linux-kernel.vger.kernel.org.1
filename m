Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A22A3CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgKCGLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:11:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgKCGLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:11:21 -0500
Received: from localhost (unknown [122.179.37.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07AFF22277;
        Tue,  3 Nov 2020 06:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604383880;
        bh=23DogF8cxNuHcdZPQ5HVx3IcI+ys/4JhUq4kkNZX/js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLXMYcoHk5jc5ulnuVbydiNUa9ym5FjoC4EufLQc59nmscXYde/WxczCKMjm14LoE
         U5RkcSAbE1C1Tg/1c3ZogjOS4A5wTgfNkPC8u8i+wey/llOfwZMoZxFNebaX19xFQa
         3bh+2GP3a6HeNvheTdab9Zbg0QqRzM7fgQdso0EM=
Date:   Tue, 3 Nov 2020 11:41:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
Message-ID: <20201103061116.GD2621@vkoul-mobl>
References: <20201030011738.2028313-1-swboyd@chromium.org>
 <20201101173741.GA1293305@ravnborg.org>
 <CAD=FV=V3kktCrwvMBeOy1dnQGYuV-ZUGX81+upRZacfzxjceFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V3kktCrwvMBeOy1dnQGYuV-ZUGX81+upRZacfzxjceFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Doug for adding me

On 02-11-20, 08:37, Doug Anderson wrote:
> > On Thu, Oct 29, 2020 at 06:17:34PM -0700, Stephen Boyd wrote:

> > Any chance we can convince you to prepare this bridge driver for use in
> > a chained bridge setup where the connector is created by the display
> > driver and uses drm_bridge_funcs?
> >
> > First step wuld be to introduce the use of a panel_bridge.
> > Then add get_edid to drm_bridge_funcs and maybe more helpers.
> >
> > Then natural final step would be to move connector creation to the
> > display driver - see how other uses drm_bridge_connector_init() to do so
> > - it is relatively simple.
> >
> > Should be doable - and reach out if you need some help.

Yes it is and doable and you find this at [1], would need a rebase
though.

> At some point I think Vinod tried to prepare a patch for this and I
> tried it, but it didn't just work.  I spent an hour or so poking at it
> and I couldn't quite figure out why and I couldn't find enough other
> examples to compare against to see what was wrong...  That was a few
> months ago, though.  Maybe things are in a better shape now?

It worked fine for me on Rb3 and db410c where we had HDMI connector. I
don't have a panel device to test and Bjorn tried to help out with a bit
of testing. This didn't work on the laptop, that is why I haven't posted
it yet.

This has conversion of msm driver and bridge drivers lt9611, adv7511 and
ti-sn65dsi86.

[1]: https://git.linaro.org/people/vinod.koul/kernel.git/log/?h=wip/msm_bridges_no_conn

Thanks
-- 
~Vinod

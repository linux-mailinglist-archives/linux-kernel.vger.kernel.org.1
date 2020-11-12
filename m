Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB72B01C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgKLJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKLJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:10:02 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACADBC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:10:01 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i13so3636120pgm.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k4jNN4/h3s3NV1F+0Q0WzcgOTkCPpVphwH4WUMWMcI8=;
        b=Uxfg/gsxqnYTbyI4zPBy3DPpJCBbX5CGLrrfi0KExaYAzoThCHOXOQ1hSI5ZnPSrcG
         RJR3eefL0HKhCqAy/F05y5EGaSVgtQ6y0uXVxdInxuOtfEn8chJarRQdl5pZ2mShd+04
         K7nhMZzkl5H0kRqWrFwe6zbKKxRPTMY5qVttw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k4jNN4/h3s3NV1F+0Q0WzcgOTkCPpVphwH4WUMWMcI8=;
        b=kwPyXljoLL3aZddZ4Jk7/LkdHkFx/6GN3a2+6xiqDOjs4wdylNAedF2EKde2l3LRM5
         riXkdDXovh7mPyC4qkvvztfYYd2M1xgjZJjT24tUMB5TEi2AxvzAPFZC2IuRl6fdHynN
         6p14hi62p+LI1ESUH2XAu3mIe6ujUsrtwoR20FJd6iyxgzA1Fbp3t/eOxq+Xel3EgoCr
         QwT5IJbkESi670E4suvcoBr8w+NKJP9yV0+Zd4SaDXMtR0s1/5pVtZ/fh3AhFy/WVsVW
         UC24sZGbS3g7C4UbMTDAv9TlbDfU5EIIVoO5fMynHt5aOyQqV7XoHrmVVeBaffTYgzwL
         9Ruw==
X-Gm-Message-State: AOAM531d6y+BsvdAcHPEXh/xvucIsrmWGjqbgU/QxJgEkI9SkbUPSQG9
        YLr/uuc0DPD6ChjU69ZQC7CHxw==
X-Google-Smtp-Source: ABdhPJywHYqw1gmRPzduqhVbO8h5JLcgcIW+D9FrFiL5xpMLx94ZxY7IQYZKNYP9xrsabRAKTh4tpg==
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr8609605pjj.206.1605172201298;
        Thu, 12 Nov 2020 01:10:01 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e10sm5427187pfh.38.2020.11.12.01.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:10:00 -0800 (PST)
Date:   Thu, 12 Nov 2020 01:09:59 -0800
From:   Prashant Malani <pmalani@chromium.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
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
Subject: Re: [PATCH] drm/bridge: anx7625: Add anx7625 port switching.
Message-ID: <20201112090959.GC1367855@google.com>
References: <20201112064051.3716968-1-pihsun@chromium.org>
 <20201112085920.GB1367855@google.com>
 <CANdKZ0cGXkcVfevpT4y_za5vu_y0s-NdCvhw1AVibK-q_W8yBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANdKZ0cGXkcVfevpT4y_za5vu_y0s-NdCvhw1AVibK-q_W8yBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Nov 12, 2020 at 05:07:05PM +0800, Pi-Hsun Shih wrote:
> Hi Prashant,
> 
> Please see inline reply as below.
> 
> On Thu, Nov 12, 2020 at 4:59 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Pi-Hsun,
> >
> > I haven't gone through the code, but did have a high-level comment
> > (kindly see inline)
> >
> > On Thu, Nov 12, 2020 at 02:40:40PM +0800, Pi-Hsun Shih wrote:
> > > When output 2 lanes DP data, anx7625 can output to either TX1/RX1 or
> > > TX2/RX2. In typical usage, these two TX/RX pairs corresponds to two
> > > orientations of typec.
> > >
> > > On some board one anx7625 is used as DPI to DP converter for two typec
> > > ports. In this case, the TX1/RX1 and TX2/RX2 are connected to two usb
> > > muxes, which mux the DP data with the rest of the USB3 data, and
> > > connects to the two typec ports.
> > >
> > > This patch adds option for anx7625 to acts as a usb typec switch and
> > > switch output lanes based on the typec orientation, or acts as two usb
> > > typec mux and switch output lanes depending on whether the two ports
> > > currently has DP enabled.
> > >
> > > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > >
> > > ====================================================================
> > >
> > > This is an attempt to use typec framework with how we're using anx7625
> > > on Chrome OS asurada board.
> > >
> > > An example of the dts for the two ports case can be found at
> > > https://crrev.com/c/2507199/6
> >
> > Do you plan on submitting DT schemas & bindings documentation for the switch(es)
> > that are intended to be used?
> 
> Yes I plan to submit corresponding DT schemas & bindings documentation
> changes if this change looks good.
> 

That's great. Thanks for confirming :)


BR,

-Prashant

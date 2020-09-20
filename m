Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AD82712E2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 10:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgITIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgITIZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 04:25:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDAC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 01:25:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a2so9557474otr.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/a7naUyGGQKH1PXxQJcaI7djTJ1eGMxz16YFC+CoiHA=;
        b=MwFaajB4ddZEfoS7GDUcwZ09kFwbv/ZPTx4QWEGF92caNb0CPyyc8mE2LnbmeydYRg
         SiXt2yT2P3jWmptEP4rwZTk1fwEjtS/pTYL6Q8V40Y01tXllkHP+t+b6Hsvhroi/DjiG
         kxCI09qbc0xIpWl8xxp8GDUaqMoxh3MOpOINY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/a7naUyGGQKH1PXxQJcaI7djTJ1eGMxz16YFC+CoiHA=;
        b=RsKSNeRcFROCbOHpnikMPAl8nYQzs/+9JkflBAPvrJZBBqNkL52Z+Vq7gSZAmPJwB3
         yRxwrtsfxZvAkumAeytN7MjtHFn5m/LZo62+LSaVDoq6BvP5cQnm7E7yOlIk7OryAmHU
         7FuCzl/kvR8n988IIJeKtvWCvsgeQAa5AwsTgL+BNdlyrlwqgAhGiy9wqacrGIWpi9aC
         TOtP8J8qAZhWUoIJKSQAf/drj7fWoEqFmkOwvkxr5sVz7pot1yqp+7OV6TT2hv01qRRC
         IQajyT/s8iGfMbKzfUKzlx8zX4OiPMB6DE+FbRjnxs3p+S6497/mpgBjKZmztSqoMmbs
         gG/g==
X-Gm-Message-State: AOAM530j56ARPZ7gRx/3PYOkdr7i79xx3hS/xK9H4Rx+rnggkJT3bDr4
        unvcn9NxdmsNkUvH2VVywBPDQW60RVaSTK3y/QxwlQ==
X-Google-Smtp-Source: ABdhPJwvCe+IENwJ8m6nRbrwsW1P4512f+jSE1TU352LgCSSh9cgMw9oHKltWRqeohi5j6nyA0l0FsdeQtUcKr0FdFA=
X-Received: by 2002:a9d:4b99:: with SMTP id k25mr29624761otf.281.1600590306336;
 Sun, 20 Sep 2020 01:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200909190213.156302-1-alex.dewar90@gmail.com>
 <c14d055d-1f6e-8c46-3a6e-7794ec69e6fe@baylibre.com> <89c599d2-6766-df68-5359-7672679b3d89@gmail.com>
In-Reply-To: <89c599d2-6766-df68-5359-7672679b3d89@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 20 Sep 2020 10:24:55 +0200
Message-ID: <CAKMK7uEwQhdqmU4+Ri+M9JtYqMmetmK8p9uFrhx1Lp16g=1edA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: Use kmemdup cf. kmalloc+memcpy
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Philippe Cornu <philippe.cornu@st.com>,
        =?UTF-8?Q?Yannick_Fertr=C3=A9?= <yannick.fertre@st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 9:31 PM Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> On 2020-09-11 13:57, Neil Armstrong wrote:
> > On 09/09/2020 21:02, Alex Dewar wrote:
> >> kmemdup can be used instead of kmalloc+memcpy. Replace an occurrence of
> >> this pattern.
> Friendly ping?
> >>
> >> Issue identified with Coccinelle.
> >>
> >> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> >> ---
> >>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 4 +---
> >>   1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >> index 52f5c5a2ed64..7e9a62ad56e8 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >> @@ -1049,12 +1049,10 @@ static void debugfs_create_files(void *data)
> >>      };
> >>      int i;
> >>
> >> -    dsi->debugfs_vpg = kmalloc(sizeof(debugfs), GFP_KERNEL);
> >> +    dsi->debugfs_vpg = kmemdup(debugfs, sizeof(debugfs), GFP_KERNEL);
> >>      if (!dsi->debugfs_vpg)
> >>              return;
> >>
> >> -    memcpy(dsi->debugfs_vpg, debugfs, sizeof(debugfs));
> >> -
> >>      for (i = 0; i < ARRAY_SIZE(debugfs); i++)
> >>              debugfs_create_file(dsi->debugfs_vpg[i].name, 0644,
> >>                                  dsi->debugfs, &dsi->debugfs_vpg[i],
> >>
> > Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Neil has commit rights, so I was assuming he'd push this to drm-misc-next.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

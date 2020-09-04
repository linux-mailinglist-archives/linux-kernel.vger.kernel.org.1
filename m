Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3210325E08B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIDRII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 13:08:08 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:60510 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgIDRIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:08:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 40D12FB04;
        Fri,  4 Sep 2020 19:08:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jLj9SpQdZr4N; Fri,  4 Sep 2020 19:08:02 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1891C45B81; Fri,  4 Sep 2020 19:08:02 +0200 (CEST)
Date:   Fri, 4 Sep 2020 19:08:02 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     "Robert Chiras (OSS)" <robert.chiras@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 0/5] Add new features to nwl-dsi driver
Message-ID: <20200904170802.GD755526@bogon.m.sigxcpu.org>
References: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1598613212-1113-1-git-send-email-robert.chiras@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Fri, Aug 28, 2020 at 02:13:27PM +0300, Robert Chiras (OSS) wrote:
> From: Robert Chiras <robert.chiras@nxp.com>
> 
> This patch-set adds the new following features to the nwl-dsi bridge driver:
> 
> 1. Control Video PLL from nwl-dsi driver
> 
> Add support for the Video PLL into the nwl-dsi driver, in order
> to better control it's rate, depending on the requested video mode.
> Controlling the Video PLL from nwl-dsi is usefull, since it both drives the DC
> pixel-clock and DPHY phy_ref clock.
> On i.MX8MQ, the DC can be either DCSS or LCDIF.
> 
> 2. Add new property to nwl-dsi: clock-drop-level
> 
> This new property is usefull in order to use DSI panels with the nwl-dsi
> driver which require a higher overhead to the pixel-clock.
> For example, the Raydium RM67191 DSI Panel works with 132M pixel-clock,
> but it needs an overhead in order to work properly. So, the actual pixel-clock
> fed into the DSI DPI interface needs to be lower than the one used ad DSI output.
> This new property addresses this matter.
> 
> 3. Add support to handle both inputs for nwl-dsi: DCSS and LCDIF

Thanks. I've tested the drop-clock-level part with mxsfb on a Librem 5
devkit and it removes the slight flickering we've seen before (and which
could be worked around by reducing the input pixel clock so 1 and 3 are

Tested-by: Guido Günther <agx@sigxcpu.org>

I've have added some comments to the individual patches and try to get
around to check out the DCSS part too.
Cheers,
 -- Guido

> 
> Laurentiu Palcu (1):
>   drm/bridge: nwl-dsi: add support for DCSS
> 
> Robert Chiras (4):
>   drm/bridge: nwl-dsi: Add support for video_pll
>   dt-bindings: display/bridge: nwl-dsi: Document video_pll clock
>   drm/bridge: nwl-dsi: Add support for clock-drop-level
>   dt-bindings: display/bridge: nwl-dsi: Document fsl,clock-drop-level
>     property
> 
>  .../bindings/display/bridge/nwl-dsi.yaml           |   7 +
>  drivers/gpu/drm/bridge/nwl-dsi.c                   | 338 ++++++++++++++++++++-
>  2 files changed, 336 insertions(+), 9 deletions(-)
> 
> -- 
> 2.7.4
> 

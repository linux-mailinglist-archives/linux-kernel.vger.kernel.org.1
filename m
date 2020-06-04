Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298E21EDE9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgFDHin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 03:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgFDHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:38:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BEEC05BD1E;
        Thu,  4 Jun 2020 00:38:42 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B661A29B;
        Thu,  4 Jun 2020 09:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591256317;
        bh=Ia+q/Q+BfL6tHkvCBFgK10jhset8KFeCNrnvPfoBk6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIWTnYeZ0/5gCWJqKEDGMMICDb2Q5FP8/+6+lMgm1XppsiWoorRuIQ36s2kiIpWid
         1UOECcAivjKfGd3yuvYTH3SPR05Vy1k5CuMW3xHQIJxheqaPcTbpSgDblqDEKXHjcQ
         cGV+uESgypZ58Vn7x77BJYNoHFFSCbr3860AfxBM=
Date:   Thu, 4 Jun 2020 10:38:20 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/bridge: Introduce LT9611 DSI to HDMI bridge
Message-ID: <20200604073820.GB5828@pendragon.ideasonboard.com>
References: <20200513100533.42996-1-vkoul@kernel.org>
 <20200513100533.42996-4-vkoul@kernel.org>
 <20200528015205.GE4670@pendragon.ideasonboard.com>
 <20200604072548.GE3521@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200604072548.GE3521@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Thu, Jun 04, 2020 at 12:55:48PM +0530, Vinod Koul wrote:
> On 28-05-20, 04:52, Laurent Pinchart wrote:
> 
> > > +static int lt9611_bridge_attach(struct drm_bridge *bridge,
> > > +				enum drm_bridge_attach_flags flags)
> > > +{
> > > +	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
> > > +	int ret;
> > > +
> > > +	dev_dbg(lt9611->dev, "bridge attach\n");
> > 
> > 
> > Connector creation in bridge drivers is deprecated. Please at least add
> 
> Okay what is the right way for connector creation? I can add support for
> that.

Historically bridge drivers have created connectors. With support for
bridge chaining, this approach was considered not to scale. For
instance, I have a board where the SoC has an internal LVDS encoder, and
the board itself has an LVDS-to-DPI decoder followed by a DPI-to-HDMI
encoder. All three components are supported by bridge drivers, and only
the last one should create a connector. Furthermore, different
operations of the connector may be implemented by different bridges, for
instance with one bridge connected to the DDC lines to read EDID, and
another bridge connected to the HPD line to detect hotplug.

To support these systems, we have deprecated connector creation in
bridges, in favour of implementing new bridge callback functions for
connector-related operations (see .get_modes(), .get_edid() and
.detect() in struct drm_bridge_funcs). With this new model, each bridge
implements the operations it supports, and the display controller driver
binds the bridges together to create a connector that delegates the
connector operations to the appropriate bridge. A helper function,
drm_bridge_connector_init(), can be used to automate that.

To transition to this model, we require all new bridge to at least
optionally support disabling connector creation (as requested by the
DRM_BRIDGE_ATTACH_NO_CONNECTOR), and implement the drm_bridge_funcs
functions related to connector operations. Existing bridges are also
converted to the new model. Once all bridges used by a display
controller support the new model, the display controller is then
converted to use DRM_BRIDGE_ATTACH_NO_CONNECTOR and
drm_bridge_connector_init() (or implement the latter manually if the
helper doesn't support all the display controller's needs). Once all
display controllers using a bridge have been converted to the new model,
support for creating a connector (the !DRM_BRIDGE_ATTACH_NO_CONNECTOR
case) is removed from the bridge driver. Finally, once everybody will
use the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, we will simply drop it.

> > support for the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, to make connector
> > creation optional. Ideally the !DRM_BRIDGE_ATTACH_NO_CONNECTOR case
> 
> will add that
> 
> > should not be implemented at all. This will require the display
> > controller driver to use DRM_BRIDGE_ATTACH_NO_CONNECTOR. Which display
> > controller(s) do you use this driver with ?
> 
> I am using with msm display driver, this was tested on dragon-board
> db845c board.

-- 
Regards,

Laurent Pinchart

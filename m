Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25522BCDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 06:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgGXEWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 00:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGXEWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 00:22:33 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B84F206F0;
        Fri, 24 Jul 2020 04:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595564553;
        bh=cubPT/pAlpqAYcMftnQz56cp+y/ntu/XUxPaomDOqk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0zOH4bAEfXjxYhLHkQ+UHZkxcK8wKB3MsQoIsJ/zEd/jZtZjPs9y/XcQ0Z6IO0r4n
         /9j4b+OuqJ21maZc1uDZdrc2Hgmqvr9TjCbBi+rDVvDAqPkwvDB8pAIE+2BQoGIQkI
         IVn9vjcLIegNTsfNHH4pd+aVzU41tvPE65FefKAw=
Date:   Fri, 24 Jul 2020 09:52:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>, linux-imx@nxp.com
Subject: Re: [PATCH] drm/bridge/adv7511: set the bridge type properly
Message-ID: <20200724042228.GE12965@vkoul-mobl>
References: <20200720124228.12552-1-laurentiu.palcu@oss.nxp.com>
 <20200722121554.GD5833@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722121554.GD5833@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 15:15, Laurent Pinchart wrote:
> Hi Laurentiu,
> 
> Thank you for the patch.
> 
> On Mon, Jul 20, 2020 at 03:42:27PM +0300, Laurentiu Palcu wrote:
> > From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > 
> > After the drm_bridge_connector_init() helper function has been added, the ADV
> > driver has been changed accordingly. However, the 'type' field of the bridge
> > structure was left unset, which makes the helper function always return -EINVAL.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks Laurent for pointing me to this.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

I have tested this on DragonBoard 410c:

Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1A2C0FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbgKWQGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731034AbgKWQGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:06:01 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4626E2076E;
        Mon, 23 Nov 2020 16:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606147561;
        bh=fuNWfiq7aFD4wGCPPdNDS0No0kLxYokW2jUq0M9gTi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sA2HD2eAJJf77bJSFimYuJ5Pi0oozwXD2kHYwoGg3RFWhAWTe6TAKnTYCDplePgc1
         XnhrsDSYAH9xgan2FFkw9rhUJOqky+sl2gKvORyeBmTyue3E1exI9whRXhYOKvAuQ/
         rL6UwZl5mJA53M1DC/NQtOg7ustCJuXy2RRkAIUA=
Date:   Mon, 23 Nov 2020 21:35:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Alistair Delva <adelva@google.com>,
        Anibal Limon <anibal.limon@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v1] drm/bridge: lt9611: Fix handling of 4k panels
Message-ID: <20201123160552.GD8403@vkoul-mobl>
References: <20201123104616.1412688-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123104616.1412688-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-11-20, 11:46, Robert Foss wrote:
> 4k requires two dsi pipes, so don't report MODE_OK when only a
> single pipe is configured. But rather report MODE_PANEL to
> signal that requirements of the panel are not being met.

Acked-By: Vinod Koul <vkoul@kernel.org>

> Reported-by: Peter Collingbourne <pcc@google.com>
> Suggested-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Tested-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index d734d9402c35..e8eb8deb444b 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -867,8 +867,14 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
>  						     const struct drm_display_mode *mode)
>  {
>  	struct lt9611_mode *lt9611_mode = lt9611_find_mode(mode);
> +	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
>  
> -	return lt9611_mode ? MODE_OK : MODE_BAD;
> +	if (!lt9611_mode)
> +		return MODE_BAD;
> +	else if (lt9611_mode->intfs > 1 && !lt9611->dsi1)
> +		return MODE_PANEL;
> +	else
> +		return MODE_OK;
>  }
>  
>  static void lt9611_bridge_pre_enable(struct drm_bridge *bridge)
> -- 
> 2.27.0

-- 
~Vinod

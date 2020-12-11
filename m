Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB92D6C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394310AbgLKA0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbgLKA0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:26:09 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3696EC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:25:29 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y24so6736316otk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nuQJ0wHKc4Xsa6OBJpnfoeLl9XbZSnvK52TPE16gHMU=;
        b=hJNzQiNA1fnW7DmxuvY+4J7zo3a/f2+YdaXw/Jzv0+WHBQPTB8fPEcYl/SzKsUVFHO
         NooC9/wHd9xjn03TPm+Zuq/RMfT18MUqS56wTEmz8czUCtBTeSvxMu7dZKn05B3GnSzC
         FwY8sy9jBJy6H8f17XNUHfPHZi5efyN9i5sYhU1SCuepPnh5Xj579O1gGFytp8OYeKFn
         VrbVghUqptC5snob5+7Klb5+DHK42mQLpLnF1OsgWfVL9K0rgLauLG/PITx+XHbvHRxh
         sa3u8yj9m/VHcp/2WGMei3VJbJq32pyWYQfceitcf4CzHwpgyvN25TCy+Jedo3lyilGh
         KXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuQJ0wHKc4Xsa6OBJpnfoeLl9XbZSnvK52TPE16gHMU=;
        b=NA+hjWBQJWHoG6kXx4dsMREqbkWcnyzKq3WK4Tgnik7HzbTSmZD+A5S83XLZDCn3k0
         eyKfng6R/RNxL8PANUDTapY2i46gdWnD5RUZGsk0291cKrBnUnZkbWVtLBaKKjIUEJ5C
         B0I2gdb/Rmh+uPmCQbPB23qnXDfkRrifO2cUa+UhT5duhsD4VHwQReboFuYHdHSHaGMw
         QCP6dTkM84iSk14ege/r7eQfd79QvEHYB54OqIAheH5nbRbD2kXrCOkA+z6AnTToDV+x
         FIKS6XK6CYIN+25EkQ2i9US+Y2QjR50YuwApJnzWxRY1KIiWzMWDFjUcaTA7Svi+pJIW
         MYCA==
X-Gm-Message-State: AOAM531SKyRuOeR7ekNQg0sFMQMj1qizPzWhn/6baS7h/FBhZR5aQi/i
        Z2v3wa/G2dct1hv1lULt7BO45Q==
X-Google-Smtp-Source: ABdhPJwFAdTm0nWnNH04pOL3J6N+OUvCSzQq44RMZ3gLumTaldRKQ56B3UebIZlupj+Na0zQXBRwog==
X-Received: by 2002:a9d:1d64:: with SMTP id m91mr7780740otm.290.1607646328495;
        Thu, 10 Dec 2020 16:25:28 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o21sm1473252otj.1.2020.12.10.16.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 16:25:27 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:25:25 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Alistair Delva <adelva@google.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>
Subject: Re: [PATCH v1] drm/bridge: lt9611: Fix handling of 4k panels
Message-ID: <X9K8daO5DrKC+Ama@builder.lan>
References: <20201123104616.1412688-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123104616.1412688-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Nov 04:46 CST 2020, Robert Foss wrote:

> 4k requires two dsi pipes, so don't report MODE_OK when only a
> single pipe is configured. But rather report MODE_PANEL to
> signal that requirements of the panel are not being met.
> 
> Reported-by: Peter Collingbourne <pcc@google.com>
> Suggested-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Tested-by: John Stultz <john.stultz@linaro.org>

This looks very similar to what I had in the early revisions of the
driver.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
> 

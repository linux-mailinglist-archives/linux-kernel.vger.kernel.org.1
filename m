Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92C283755
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgJEOH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgJEOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:07:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6807C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:07:25 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y15so8952600wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZldILGuVy9unlOOxU0H1hIH1gJzlU8+mS56ImbM+ZQ8=;
        b=CJGccaFA76/tlfY2+H8drZvwvp7lpfcLqG9vrSqs0SWJ/O/oNPHEFK6IA305zHWR/n
         S9JBCFSoBbOQQ4tlidWqvqsJxhWniQwa5tEA/4gN8U6iGoqiDfwpB2vdOIHOETyqqEKK
         Nu3iSAlkMt1N86xOeLibgRMgeklh/kZiYX4iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ZldILGuVy9unlOOxU0H1hIH1gJzlU8+mS56ImbM+ZQ8=;
        b=sxXgKHryH/cFwstTXriiIwC+wtizyffog5GDDJQk2Nb1fs0Wxg1ph+seikNPE08y6+
         2+CgpbG+UA4PJPM352+xDhOj1D83W/8ftV3ql2JecrP2WsKtvSNGUnt+VX/358WOm3bd
         bFJZbl01yA8c0J+/dfNsl9a9JzmiXFtihl983AwmkEeBd+T3p8SOkbEddXKcW73/RqHo
         lTIVV0kPimZkGv09ILgNZG5GldNDa3KkL8/jZxP7SvCrOnZaOhK96DdbwlUeZ3AdvFsj
         A8oYqwftGr2VF+6ILq4aQea4Vl0GNKiHRTXjweGtIHfZ3ZZX+VIjWPIjO40bIJ9vs9IL
         O28g==
X-Gm-Message-State: AOAM530DfoJuBrSZ7OiMCmUakV7C4puvvK4IsEmBl8QG6Sh1m9BQ78oQ
        PQJ1E7yaw0ciLHDIh5Vseug41g==
X-Google-Smtp-Source: ABdhPJyxdZ2mcLmnrUnQgng992VSWkng0jYBV8uCV805lCE/hWFcvl7aOou5BxcHapS8phDJHWQk8g==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr17861625wmb.135.1601906844392;
        Mon, 05 Oct 2020 07:07:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f14sm81907wrt.53.2020.10.05.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:07:23 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:07:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Constify dw_hdmi_i2s_ops
Message-ID: <20201005140721.GU438822@phenom.ffwll.local>
Mail-Followup-To: Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>
References: <20201004200653.14702-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004200653.14702-1-rikard.falkeborn@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 10:06:53PM +0200, Rikard Falkeborn wrote:
> The only usage of dw_hdmi_i2s_ops is to assign its address to the ops
> field in the hdmi_codec_pdata struct, which is a const pointer. Make it
> const to allow the compiler to put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Queued up in drm-misc-next for 5.11, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index 9fef6413741d..feb04f127b55 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -170,7 +170,7 @@ static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
>  	return dw_hdmi_set_plugged_cb(hdmi, fn, codec_dev);
>  }
>  
> -static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
> +static const struct hdmi_codec_ops dw_hdmi_i2s_ops = {
>  	.hw_params	= dw_hdmi_i2s_hw_params,
>  	.audio_startup  = dw_hdmi_i2s_audio_startup,
>  	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
> -- 
> 2.28.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

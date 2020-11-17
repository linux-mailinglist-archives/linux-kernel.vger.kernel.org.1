Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5A2B6BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgKQR3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgKQR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:29:29 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13050C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:29:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so24032168wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FROWGsH7Dx97guc9ujjqMeX/SzGuLi2yD3mmQjMN8Gw=;
        b=lWa4MH/4y1JT4uoM08zKk7JftI+U9CDGGyz8OX0rRi7T9zDzoCGKTrzRaczE+OYdQa
         xKZdr7i8MeRzbLh11SQGZW9DhRFzHG5NVFURHUeXdHU0hOAwyNLKfMCYjVguTYCzFlAQ
         aqYwXcl8u/X+GL+3j2W6ylnIHZEjk5+dstyRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=FROWGsH7Dx97guc9ujjqMeX/SzGuLi2yD3mmQjMN8Gw=;
        b=prHg5lKyTYcgk7INc6IVqKGNvl2kRqikkvG5dKa5S9UoXqlpbk84DhDPWIiVu2CYVP
         yqFVphO6Kv4LKD4WOBzcIeWw0q+RmTUMBi/EZ+6+y7kqwAUvGYA+21nmNoaJ06VKBkV4
         lbDwK0KfF9DZa0WGErk8Kdxk2144MbneFXFfqgff0nZOM90NfTv8XxAoIvnvjoWWaL4j
         BtzFADt/ovbZz/RxjwqXmWPg/bEOCv2XS8D/55KqhsCMDxnpBHNmeU8jdbxWNvHO3tVc
         RC+oGafarqbHm+wkUcRYG3GVPCXGWTCNEVV0iMK6GywX/6Vg9YkD2RANtX5D9Wyes/12
         sQdg==
X-Gm-Message-State: AOAM532p6Rcs+bAtV7gbqcLrY7nywce6SYNEdPuATPIu4YVIpjIQyE1C
        IikIzW9zRs1MZeHCsXCrHY7av/WVWYyccQ==
X-Google-Smtp-Source: ABdhPJx+BnHbl/cFR2hypORia53biB2S0AX0CRMhWkYyVQSS1zuJpDkCMnVSXjw1JIT88MC4cefjtg==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr567492wrv.299.1605634167815;
        Tue, 17 Nov 2020 09:29:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u23sm4816488wmc.32.2020.11.17.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:29:26 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:29:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 03/42] drm/drm_dp_mst_topology: Remove set but never used
 variable 'len'
Message-ID: <20201117172925.GN401619@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116174112.1833368-4-lee.jones@linaro.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:40:33PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c: In function ‘drm_dp_send_query_stream_enc_status’:
>  drivers/gpu/drm/drm_dp_mst_topology.c:3263:6: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Going to apply this, but I noticed that the return value of the
build_query_stream_enc_status() is pointless. Can you pls follow up with
an additional patch to change that to void?

Thanks, Daniel

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index e875425336406..0401b2f475002 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3260,7 +3260,7 @@ int drm_dp_send_query_stream_enc_status(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	u8 nonce[7];
> -	int len, ret;
> +	int ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>  	if (!txmsg)
> @@ -3281,7 +3281,7 @@ int drm_dp_send_query_stream_enc_status(struct drm_dp_mst_topology_mgr *mgr,
>  	 */
>  	txmsg->dst = mgr->mst_primary;
>  
> -	len = build_query_stream_enc_status(txmsg, port->vcpi.vcpi, nonce);
> +	build_query_stream_enc_status(txmsg, port->vcpi.vcpi, nonce);
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

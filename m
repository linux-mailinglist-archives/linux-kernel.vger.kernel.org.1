Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981DE2B6EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgKQTkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgKQTkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:40:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:40:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 1so2910672wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FHkNUdrffEEewUqKRC5MHcmvzKN343SbiYWMLq5hSig=;
        b=Y8xRFV1uXbhUD/hNWnOZWHHvJxo2AOqJa9wV9al4z4mwA5aKWhD7ICIZCL6HKE+NYB
         DEaSlhXR89JiPboWtnAOmsSDbEjXlP3cR9qF6WfYLHu08xvKeeUDOCMFvhlZDWqUL8VZ
         8uQWLxQI4mffDvRkb2gb4vCipF63m3ayPXMXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=FHkNUdrffEEewUqKRC5MHcmvzKN343SbiYWMLq5hSig=;
        b=P7OOPaEunOmS3AvAYF5VvYKqEqMhNCtDgRqTl/pxNUrT6TNknaSpbZXjUrTGGwPcmF
         1GectJtlo3hvw5Qki6D9Ddcuv72AKGLx1RgaEsLULDGCgrVkh30kr7Gqv7z8dZh5qXvJ
         IliOIlkCfOnM6uFAP6B45b+E+LJ5SDKo0uo9v7V6SwtQIZeHFZvCBalVYuCF+bBSb+vE
         9inyJy0KUTrVNOYzPk8yfRjGGeNCP9aywRDwNGe0q9ZdHbq1IkYw36XawgWiWQyC4JMT
         cIT1xFd9rRIj4WYCgMACHPqo8sbmWm3KGsugmAxe3L3ym1a/YfEjQIkJLBZBSqsBRhNU
         cNOQ==
X-Gm-Message-State: AOAM530WdjlQ49qMHxSQoLCrnIKoyT+CJo6UsUgxtROH9mfZq/gZFeH2
        XF2CT0/fCT9LIM9AUGFpN5a3tw==
X-Google-Smtp-Source: ABdhPJz9AJRrUB8LSQple4httgcCRK/0wqg7MvcLR0c4AXS2Zx0msIgNNlqu4m1/MW9PZsPuViapkQ==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr729506wma.86.1605642009912;
        Tue, 17 Nov 2020 11:40:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a144sm5493322wmd.47.2020.11.17.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:40:08 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:40:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 38/42] drm/vc4/vc4_hdmi: Remove set but unused variable
 'ret'
Message-ID: <20201117194006.GU401619@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-39-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116174112.1833368-39-lee.jones@linaro.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:41:08PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/vc4/vc4_hdmi.c: In function ‘vc4_hdmi_set_audio_infoframe’:
>  drivers/gpu/drm/vc4/vc4_hdmi.c:334:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Hm this is another where I think the right thing to do is switch the
return value from int to void. All users are maintained in drm except
sound/soc, so probably good enough as a single patch. If you feel like,
otherwise I can type it up too.

Anyway applied this one here.
-Daniel

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 95779d50cca0b..b80eb9d3d9d5a 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -331,9 +331,8 @@ static void vc4_hdmi_set_audio_infoframe(struct drm_encoder *encoder)
>  {
>  	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
>  	union hdmi_infoframe frame;
> -	int ret;
>  
> -	ret = hdmi_audio_infoframe_init(&frame.audio);
> +	hdmi_audio_infoframe_init(&frame.audio);
>  
>  	frame.audio.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
>  	frame.audio.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

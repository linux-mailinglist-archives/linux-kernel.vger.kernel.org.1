Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600452F32D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbhALOVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbhALOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:21:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124DC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:20:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r4so2263806wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lRZ3d22RXi2ViyjCaIZIVlAwq5J2EBopCK/yoHar0tk=;
        b=Tnor6WweTI6EMJ3JkUSAheTZoPtMvnhHIrNwk2GPdLYm+l8vUhui0OTuLf3VW2t7Zp
         LmrhMjocBU+y7mPLZkHzqBtelT3BCd/Js5+749EuC9BVTQcRZF3m0dMQyyg4QMYbGqze
         Wp+YMC/JMjblo0QMU4DCnvhZ+mVZmdkN7PQog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lRZ3d22RXi2ViyjCaIZIVlAwq5J2EBopCK/yoHar0tk=;
        b=FOv8VfEJDcybLoCAH3ypa769CxwveHYESs/srj8vwJAcmn0m/XhKYRzIFJP8u4DHBw
         jDWPCX+QkXm+EbYA6Agez4EelrWf6rd5NxN17LRrtxq9PYxyy+M704zqq8ijWufwt5Dn
         I5Q0wEatP38/Dfl46gjAIPJbzkZAM0qdzboKXMWf7PPHSxLPe5GCKyqs56TKkCs1kq/3
         kdMgQ7m+39kwUJAYEvquyjtVqnnRaYkOqGzJpFrDNPNCIVaJpVMXG57OdMnRaaGW4mJX
         34sg5laD20453ieLAG7Ipp9l2Nk27iJHsM4BFUlU6AXiBUvSrrHhnU3F6VY8XZF7lcy2
         QC/A==
X-Gm-Message-State: AOAM530bbhYGF1axLW+17rwkLPKd0GzqVmDGD1Ej4EzmckIUVN5Oct2l
        14+EvY0CmEkTYiQvlNKMNE6CQ9MIQMJdyivy
X-Google-Smtp-Source: ABdhPJy83/7uShpCX8AKV6iHS42oLbgL1kEyg4Xhn+9gXQjSyaPhkB95sv3erSdwA2vZlZOynSSvUQ==
X-Received: by 2002:a1c:a501:: with SMTP id o1mr3840543wme.44.1610461239793;
        Tue, 12 Jan 2021 06:20:39 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a17sm5486318wrs.20.2021.01.12.06.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:20:38 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:20:36 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Improve the output_poll_changed  description
Message-ID: <X/2wNLjupzAS7O5c@phenom.ffwll.local>
Mail-Followup-To: "ZhiJie.Zhang" <zhangzhijie@loongson.cn>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210112104644.341345-1-zhangzhijie@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112104644.341345-1-zhangzhijie@loongson.cn>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 06:46:44PM +0800, ZhiJie.Zhang wrote:
> From: zhangzhijie <zhangzhijie@loongson.cn>
> 
> codeview the implementation of few Drivers.

I'm not really understanding what you're trying to say here.

> this callback was used by drm_kms_helper_hotplug_event()
> 
> Signed-off-by: zhangzhijie <zhangzhijie@loongson.cn>
> ---
>  include/drm/drm_mode_config.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index ab424ddd7665..e01c4d0f07d1 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -104,7 +104,7 @@ struct drm_mode_config_funcs {
>  	 * changes.
>  	 *
>  	 * Drivers implementing fbdev emulation with the helpers can call
> -	 * drm_fb_helper_hotplug_changed from this hook to inform the fbdev
> +	 * drm_kms_helper_hotplug_event() from this hook to inform the fbdev
>  	 * helper of output changes.

I think since we touch this, maybe better to revamp it complete. The best
way to handle all this is by registering a struct drm_client, since that
provides the &drm_client_funcs.hotplug callback. Also for fbdev support
drivers shouldn't even use that, but instead use the
drm_fbdev_generic_setup() function, which takes care of everything.

I think we can also remove the FIXME below, since with the drm_client
infrastructure and the generic fbdev emulation we've resolved this all
very neatly now.

Can you please respin with my suggestions taking into account somehow?

Thanks, Daniel

>  	 *
>  	 * FIXME:
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

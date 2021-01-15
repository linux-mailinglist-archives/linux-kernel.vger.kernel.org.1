Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B702F7DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbhAOOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbhAOOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:06:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4CBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:06:02 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m4so9382614wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPMlJO4UTyJchtTDyOaRwmLeb/v0M+Q+kKVn0zhDYy4=;
        b=b7dTXqm7YcuokeqHifpnNRd94kbQAZo0jyg/IaPVC9bajGq92qNPy2m4f0Pf33hq8j
         AaAIRG+QTlBjNb1CiA2RW02MzhEvKXtN6hreJ3gx0yW/otTXkHXNwhrX+9jQfOGwyr/z
         nP1z9em+MC7fDaYEafcK3aEljTVRj1JWu4dfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=UPMlJO4UTyJchtTDyOaRwmLeb/v0M+Q+kKVn0zhDYy4=;
        b=tmkaUCJyDAnt5FQrLKjzmk9XT7TSfLO26C4QQ8p1HpN/fJxvAXCm6myZvXQV+7EQ7B
         kAsdz6e0C6kZLTvWCG8Gl73QjglKm/cNkjfT1lOsT9XLomxiK5X5kIRoRldsZBeckDpB
         we4KRUsJ8HEuB2kVfs5NiwuXBtWf4AFzj86Lf0Dq7PpLOq1YcFS0jvzmiA13Ef8wR4FP
         DjdTYKVMhKHV0tDXNawFGjz4YfXkuLBIbnNzXjTypYEU6AqsaZQtJNDi2Z9oibWFysAX
         MkGd1MdQ8nRJ77dJoymXc64gJjrESTU87Vjbda5xKXzQdJXo0MdhX2BIpQnna2NFD1r3
         2l5A==
X-Gm-Message-State: AOAM5317RSSQpUe9g8eFx819SekcVfc14GiBurNTJ52Qn/VUW/6XY618
        UlhXvSi7XQk22RnpprrSm1yR9w==
X-Google-Smtp-Source: ABdhPJxW1WgQpSNdRjSyFIn+j2kGkas48b58kNNX4M1ZvcdRga9YAe1posPH9U9hdlysMaufwXPBMQ==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr13647251wrm.1.1610719561768;
        Fri, 15 Jan 2021 06:06:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b13sm14234499wrt.31.2021.01.15.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 06:06:01 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:05:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Improve the output_poll_changed description
Message-ID: <YAGhRz0ac6GDBFDI@phenom.ffwll.local>
Mail-Followup-To: "ZhiJie.Zhang" <zhangzhijie@loongson.cn>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210115033328.1799514-1-zhangzhijie@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115033328.1799514-1-zhangzhijie@loongson.cn>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:33:28AM +0800, ZhiJie.Zhang wrote:
> From: zhangzhijie <zhangzhijie@loongson.cn>
> 
> this callback was used by drm_kms_helper_hotplug_event()
> 
> V2: (Thanks for Daniel's suggestions)
> - remove the FIXME below.since with the drm_client
> - infrastructure and the generic fbdev emulation we've
> - resolved this all very neatly now.
> 
> Signed-off-by: zhangzhijie <zhangzhijie@loongson.cn>
> Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>
> ---
>  include/drm/drm_mode_config.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index ab424ddd7665..50541980f7f2 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -104,13 +104,8 @@ struct drm_mode_config_funcs {
>  	 * changes.
>  	 *
>  	 * Drivers implementing fbdev emulation with the helpers can call
> -	 * drm_fb_helper_hotplug_changed from this hook to inform the fbdev
> +	 * drm_kms_helper_hotplug_event() from this hook to inform the fbdev

Hm I looked at this again, and this change is actually wrong. Both
functions exists, but calling drm_kms_helper_hotplug_event() from this hook
would result in an endless loop until we crash somewhere.

>  	 * helper of output changes.

Ah I meant not just removing this, but explaining what to do now instead.
Suggestion:

	 * This hook is deprecated, drivers should instead use
	 * drm_fbdev_generic_setup() which takes care of any necessary
	 * hotplug event forwarding already without further involvement by
	 * the driver.

Can you pls respin, with the function change dropped and the fixme
replaced with the above?

Thanks, Daniel


> -	 *
> -	 * FIXME:
> -	 *
> -	 * Except that there's no vtable for device-level helper callbacks
> -	 * there's no reason this is a core function.
>  	 */
>  	void (*output_poll_changed)(struct drm_device *dev);
>  
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

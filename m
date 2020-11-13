Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784D2B25D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKMUuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMUuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:50:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC8FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:50:03 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r17so11601519wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eOXlZj0XPFWz7dlYa6NqKCzhJqTiZPBQkJ27S51Z/uw=;
        b=lQXAKOz+VF1cNFLuf+oV/VqV7EySOBNChHjZD8juvCYoc+YJU+joPVRZEjC1j1jKph
         pgxq+cfxmcr+te3hKWQm6LbDC5iqTyGMX/WldcyDMkh5yr2Ih1qyqDi5HkXv+fn5uUci
         TxOcKlvgL5iDdjE8oZ2JRtkkdy2BMxoU3/H60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=eOXlZj0XPFWz7dlYa6NqKCzhJqTiZPBQkJ27S51Z/uw=;
        b=dTs0oY9KIsn+SiUBiG9hsMqyNtDD/D7Eu5S2MBmBk/1RcPH5s/zfRvQlckElzY3466
         mfuHpQpa+MsJVUDopuAfO8J2w1HrDmaPK9mnkZZib9UxazjPWE6lhLRPgxvbNtabGSFh
         Y1i6GGj+QwqUIAavjzS483mSGoHr8WnCmOZTeCON9PmWdkcqYlfhAFLtfHxfOGICIUiT
         5lZVI0uzdzZszPVPjWIgvSwH//c91WvLKX5h2ABifRXZnWMHfgBEhYdDoAr/G5anMYNA
         XWriJGTxuGXO+zGiekoFWwRNUF3gvtGA23k5Eib8wXvWfhkHDJL2tr2t8QuvvRHmJyT9
         o9rg==
X-Gm-Message-State: AOAM53353H096Ct2EZTjK5LJHoUbKex0lm3kf5UNES0lSLgbj159eJq3
        tELfGFVJs+r6IwEMFb115i5W2Q==
X-Google-Smtp-Source: ABdhPJzkFfexeDsoa+Wk0hm/w8ujcFMdDiRRJOkwPpoJBqXarBaFF2qtiom4zSV7Fshbzm+lULW3Tw==
X-Received: by 2002:adf:a40c:: with SMTP id d12mr5851835wra.154.1605300602644;
        Fri, 13 Nov 2020 12:50:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c2sm11589328wmf.47.2020.11.13.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:50:01 -0800 (PST)
Date:   Fri, 13 Nov 2020 21:49:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Lee Jones <lee.jones@linaro.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc'
 to avoid 'not used' warning
Message-ID: <20201113204959.GW401619@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Lee Jones <lee.jones@linaro.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-3-lee.jones@linaro.org>
 <20201112202516.GA3340631@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201112202516.GA3340631@ravnborg.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:25:16PM +0100, Sam Ravnborg wrote:
> Hi Lee,
> 
> On Thu, Nov 12, 2020 at 07:00:11PM +0000, Lee Jones wrote:
> > The precedent has already been set by other macros in the same file.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable ‘crtc’ set but not used [-Wunused-but-set-variable]
> >  55 | struct drm_crtc *crtc;
> >  | ^~~~
> > 
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Rob Clark <robdclark@gmail.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Also applied to drm-misc-next.
> This was the last patch from this batch I will process.
> The others are left for the maintainers to pick up.

btw for patches that maintainers don't pick up, the usual process is that
we give them 2 weeks, then just mass apply. Now you're producing a lot of
patches, too much for me to keep track, so please just ping me with a
resend for those that expired and I'll go through and pick them all up.

Cheers, Daniel

> 
> 	Sam
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

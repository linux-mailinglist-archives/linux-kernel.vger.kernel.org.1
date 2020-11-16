Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A722B4D17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgKPRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731287AbgKPRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:33:43 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:33:43 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so19648793wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QQ0Y0HjWuKkF/yI1XhFJjLETVzYo8oJjFXZUGQZAiWk=;
        b=BV/xWrUd/fIFABPjkFm2ZT6D5AYrHNqpqMcuOwAaHo4h/21ltS0feo5aMprbhoAn3H
         LLf92/Sv4s5MbbeAOOoMGpsT0gdOmZ/Yz4siVcbyT/bxmytb0IkHFBtEoXdbHVEBJsGB
         xT0gB8m+0Rm2QIdd2Fowc9T6xLVFCMVyPxtogxhCpSZCA5cwnApeSPJf1Rcl7k1QIHgj
         fUUA+tq0THkHI9YX5RTXoABdRJTOffUOlf1ay3MBeX03m8hWvs/MnSPKzph7u/EroDCp
         JljYfvVppcxQPIW32qy5G1PwFpiNEfbt/z1BjJ+xRxou0r5VfC35bRcSSdFBPSrwsuwl
         1pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QQ0Y0HjWuKkF/yI1XhFJjLETVzYo8oJjFXZUGQZAiWk=;
        b=rHqQiABAgBSZD3SMNrIUdShOklnl5rcoS/nwesHmRHsdXLavjIfK6gSQGm2I0Z0lpl
         dbq+v7TqsxhABPekEQtnGP693aPqEziYVHzR92uPKvlIhGtqA0ksos8vhMzwF6IsHYVj
         IHo0ZojH6AT3LSNDAUqtEVUbeGQXKNY3E7q98od7NbdIVf2MpjyJJ4qygnZtbWvCanr2
         9Bq8sDxR6mEEGlzDM0lNvqzIyCRE5WDIr8NAZ8QVBgld6hdw2HIUCFx7b90gy1FkVI8h
         wOTb0lCcZZCEKOZBz//p35TY1UK3m7MfKPLwNXYvGHcUFw/rBqGF7F7Af2CzEjUwxjWI
         SGeg==
X-Gm-Message-State: AOAM530nN91vO/T7lC9oYSqDgjdXPWwFOQ9X+HY7O+elIlXgcaCpTWAe
        nY9SbOBX2dY9p1gqznzyc/1Fyg==
X-Google-Smtp-Source: ABdhPJyDe42mcoiLj3IUWc1BkQI6esqikQ5pfG4c1j5rokQQAfmHxfIwCFaouQMwqTq0KbGhQ20Rbg==
X-Received: by 2002:adf:f181:: with SMTP id h1mr20116998wro.267.1605548022184;
        Mon, 16 Nov 2020 09:33:42 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p12sm23389482wrw.28.2020.11.16.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:33:41 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:33:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc'
 to avoid 'not used' warning
Message-ID: <20201116173339.GQ3718728@dell>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-3-lee.jones@linaro.org>
 <20201112202516.GA3340631@ravnborg.org>
 <20201113204959.GW401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113204959.GW401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020, Daniel Vetter wrote:

> On Thu, Nov 12, 2020 at 09:25:16PM +0100, Sam Ravnborg wrote:
> > Hi Lee,
> > 
> > On Thu, Nov 12, 2020 at 07:00:11PM +0000, Lee Jones wrote:
> > > The precedent has already been set by other macros in the same file.
> > > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable ‘crtc’ set but not used [-Wunused-but-set-variable]
> > >  55 | struct drm_crtc *crtc;
> > >  | ^~~~
> > > 
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Rob Clark <robdclark@gmail.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Also applied to drm-misc-next.
> > This was the last patch from this batch I will process.
> > The others are left for the maintainers to pick up.
> 
> btw for patches that maintainers don't pick up, the usual process is that
> we give them 2 weeks, then just mass apply. Now you're producing a lot of
> patches, too much for me to keep track, so please just ping me with a
> resend for those that expired and I'll go through and pick them all up.

Okay, I have split the remaining patches into 2 new sets.

One for Radeon, the other for everything else.

Hopefully that makes things easier/more obvious.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

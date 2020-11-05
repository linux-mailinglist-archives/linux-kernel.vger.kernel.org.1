Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3854C2A7AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKEJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:42:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:42:18 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so900084wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=wpa/gH6WKVvOZOF65OKK1Df7hL/w51tUR5ocafirz/U=;
        b=gGpve2b5nT5gDe0F41+nOJ8S0JtPp+K/fkbykHKZpJakWRrlBTuW9/X4OP3lckOq4S
         wFC6L2TgfvMVBEyrEUg0CaryizLLCP6ZWidtrdKSBVVAH8mjIY62v2CsJQrEZDf7Ly6U
         pP0JtMJnmCpKC98YGUdp8xOqeDtcn7vXs6s8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=wpa/gH6WKVvOZOF65OKK1Df7hL/w51tUR5ocafirz/U=;
        b=WDWTV/sbXiss8Kzo6shVxOJAfSw8wT76Et1iuPe1lvJ5hRT5BGZYWi+VKsQS0A5Ak8
         46K/tgdUx3oGMS+DYgKdXacKwTmuWWEQ8r3PjMyHfz4GjKkwCRpPF3vdaCJ+O0g5qG2U
         3uhhfGPK8JYQgGdWCEpXKu8R6JPPggnKkmuHGUQF3v14Alt49wJvhQucrJUPkqQuIIr7
         rBA9HPfM28EOgZVyC3nfj2lGqXCl4TDNMhxHmuwBkuRisuFEr3zlWRU5IYF6y9vnhjxg
         Vdl8KTA4Z9j6OHEjoN1Dv7CCS+kvv+FW2cFAZ8Occ06zX8BT85ctE7gUD4O/4JSZAOuG
         z8/g==
X-Gm-Message-State: AOAM532vwDs7NwIyipsvx5nQ6xN3GsNtV4i4Rim5RN55bDgz5E2ovdUJ
        vXgoxVa5OgfnFwuE1e8DEHE4Lg==
X-Google-Smtp-Source: ABdhPJzLdA/5MB4X8lL2FOSUeAQLRPyPZzE5Hwhd3ddv0IHLtJIf4ldo5XuVgoPqCzuJ52+HNerkLg==
X-Received: by 2002:a1c:2d8f:: with SMTP id t137mr1729198wmt.26.1604569337681;
        Thu, 05 Nov 2020 01:42:17 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w11sm1875170wmg.36.2020.11.05.01.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 01:42:16 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:42:15 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vgm: replace idr_init() by idr_init_base()
Message-ID: <20201105094215.GT401619@phenom.ffwll.local>
Mail-Followup-To: Deepak R Varma <mh12gx2825@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20201104112338.GA29271@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104112338.GA29271@localhost>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:53:38PM +0530, Deepak R Varma wrote:
> idr_init() uses base 0 which is an invalid identifier. The new function
> idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> all lookups that otherwise starts from 0 since 0 is always unused.
> 
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Tiny typo in the commit message summary: s/vgm/vgem/

Also can you pls resbumit this with intel-gfx mailing list on cc (like for
i915)? There's a CI bot there which runs a few vgem tests, would be good
to confirm nothing has been broken.

Otherwise lgtm.

Thanks, Daniel

> ---
>  drivers/gpu/drm/vgem/vgem_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
> index 17f32f550dd9..2902dc6e64fa 100644
> --- a/drivers/gpu/drm/vgem/vgem_fence.c
> +++ b/drivers/gpu/drm/vgem/vgem_fence.c
> @@ -233,7 +233,7 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
>  int vgem_fence_open(struct vgem_file *vfile)
>  {
>  	mutex_init(&vfile->fence_mutex);
> -	idr_init(&vfile->fence_idr);
> +	idr_init_base(&vfile->fence_idr, 1);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

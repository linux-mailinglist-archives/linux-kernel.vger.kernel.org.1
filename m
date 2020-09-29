Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6127C2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgI2KxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2KxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:53:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:53:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so4862169wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/8RcwvNRZX4QrC1qgXuNqwd8pHZ5jEfkIMP8FcXGzs=;
        b=jsz6B1+YEp5B8KlbE/d0+3hD+n5mvwweCSSsHXznFq2L+MbyNhnwBbEVTadiV9A8e8
         Hj/4Q37N4gMr3WISbfGAUlxUR7jJYV5BX7k2uQWCUyOolHRZurqdtTKtWu98cbslD4kd
         j3VLPxLK5+IeiS53iuP6Pb2M5x1wuj8Ww0P4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=m/8RcwvNRZX4QrC1qgXuNqwd8pHZ5jEfkIMP8FcXGzs=;
        b=alW7h7AZTcI85OqV2z7vuztxd2rfZWKHgdnQIDLUU7h6dLu3SPvf6zZZx/woDlSGHp
         ZYmRiXBC5CEoRRM4DcA4Gzgkd5e0WiHuCWxbDIpY20b7CqCIdoUpvseLQY9jXjDcOITy
         u6Q+EIu3nCCQnGWWj7z0TgkFAj5XwzpDEaG7l4r4ot6dJd2lOFVo0b2XUFxqru4tiXS6
         4zvzv+JNBVhGluk95PS7KocHS0dmaXlKFaFSjidNnuU2GAsJKSHhe4uRZZzsPEmS2vvV
         eZeKZutexzXbbwcR/AzrpKm3eHKGm+G9Jx7Saz6x0HuM7EfjzajnfnrC6t30HYdsTcRx
         C7RQ==
X-Gm-Message-State: AOAM532iZ4qCTu3UkUGtfsPTfFHb5xLj/yN7nCvjQ0pzTxcJZdO5bdyd
        eeJsO32dhc/r74lNu8CKrc/S6Q==
X-Google-Smtp-Source: ABdhPJzmw2CD/MpLrTQRlDKQtbpWYZdfZO7lS5wPv+xREi43g7gWZnZuZtDrMycOZuDAjAbXvAqStA==
X-Received: by 2002:a5d:6552:: with SMTP id z18mr3513370wrv.32.1601376783538;
        Tue, 29 Sep 2020 03:53:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l5sm5116546wmf.10.2020.09.29.03.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 03:53:02 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:53:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drm/qxl: use qxl pin function
Message-ID: <20200929105300.GM438822@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200929095115.24430-1-kraxel@redhat.com>
 <20200929095115.24430-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929095115.24430-5-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:51:15AM +0200, Gerd Hoffmann wrote:
> Otherwise ttm throws a WARN because we try to pin without a reservation.
> 
> Fixes: 9d36d4320462 ("drm/qxl: switch over to the new pin interface")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
> index d3635e3e3267..eb45267d51db 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -145,7 +145,7 @@ int qxl_bo_create(struct qxl_device *qdev,
>  		return r;
>  	}
>  	if (pinned)
> -		ttm_bo_pin(&bo->tbo);
> +		qxl_bo_pin(bo);

I think this is now after ttm_bo_init, and at that point the object is
visible to lru users and everything. So I do think you need to grab locks
here instead of just incrementing the pin count alone.

It's also I think a bit racy, since ttm_bo_init drops the lock, so someone
might have snuck in and evicted the object already.

I think what you need is to call ttm_bo_init_reserved, then ttm_bo_pin,
then ttm_bo_unreserve, all explicitly.
-Daniel

>  	*bo_ptr = bo;
>  	return 0;
>  }
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

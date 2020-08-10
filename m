Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31F8240678
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHJNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgHJNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:12:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EACC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:12:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so8120930wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGTAL/+sIj6emRK3fqEhesmWaas0p8AJ5UO8Qp8MS1M=;
        b=kiybH+qBWuADveErVU6XG2NhmnEtx+jjpz4e5l4kPqdP+eOVGDVXTTuj7GzN8/usfb
         aqSyH2C6eba/f1bIp2y4Qwz89xvumnwQDUFTZn+O1+dhurhVQUQrPcper+mKqlPWKIJS
         /pjIiSSf4Jsk1WTPpS5yRa5EkgDThqB3kPG0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=iGTAL/+sIj6emRK3fqEhesmWaas0p8AJ5UO8Qp8MS1M=;
        b=EOiIFpYbhZAtyJbIWhTUdCwb9aud2umGQAoyz+mUA/QdUk/XBHVRfKL82XJP+C2k0c
         OtcOjoJFcFHFbjlwnAKpKlacM8njnu96md0zlymgbL/i3OG2O7BsuUibBeG88aLtpoYB
         u1cijqy5BisaSpqVeFjfIMUJyvV6VOYjx0r6oTmKvfzM7P5oWrGMrKf6hCvh7NxgmYpp
         ffAwi7ep2EysFcSuMtitpKAQuOC+eTFDKGhlEu569Zu5ailHQUjDJhO/VRlD9isl+vFu
         m5qPb2qvehdb3rtRy2kxNyFdmPr/LkXG+9BOfysyOrffocMiiU13JrQ9hW2FNWQvuo3y
         644Q==
X-Gm-Message-State: AOAM533yl960ifrDydjGeqdnaRzDrK7RAUg9hmzPYQQN6UhOECZIJUqn
        4WEBN1yXbBcqRFMab0p+DtW9EUhPQbE=
X-Google-Smtp-Source: ABdhPJzE2hOnuO6FJZJTN+hB/BfbT0RyysxtWTsn0jH+nB8VUjAb31vcXQl1nU79oHgj8G6691FpWQ==
X-Received: by 2002:a5d:5383:: with SMTP id d3mr1457089wrv.42.1597065150007;
        Mon, 10 Aug 2020 06:12:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t13sm20523157wru.65.2020.08.10.06.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 06:12:29 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:12:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vgem: add missing platform_device_unregister() in
 vgem_init()
Message-ID: <20200810131227.GU2352366@phenom.ffwll.local>
Mail-Followup-To: Qinglang Miao <miaoqinglang@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200810125942.186637-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810125942.186637-1-miaoqinglang@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 08:59:42PM +0800, Qinglang Miao wrote:
> When vgem_init() get into out_put, the unregister call of
> vgem_device->platform is missing. So add it before return.
> 
> Fixes: 363de9e7d4f6 "drm/vgem: Use drmm_add_final_kfree"
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Uh right I still have my series stuck which would have fixed this properly
... Thanks for your fix, both applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/vgem/vgem_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
> index a775feda1..313339bbf 100644
> --- a/drivers/gpu/drm/vgem/vgem_drv.c
> +++ b/drivers/gpu/drm/vgem/vgem_drv.c
> @@ -471,8 +471,8 @@ static int __init vgem_init(void)
>  
>  out_put:
>  	drm_dev_put(&vgem_device->drm);
> +	platform_device_unregister(vgem_device->platform);
>  	return ret;
> -
>  out_unregister:
>  	platform_device_unregister(vgem_device->platform);
>  out_free:
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

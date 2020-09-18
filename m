Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F9B26FCCD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIRMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:45:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84605C061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:45:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so5514379wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=mkjGA7pXWKUs0Nfv07SZZRXfgMyaUHALkc311WYJd5c=;
        b=IjP59USZ4bt/dNbg6oSq65GvWXtsZNBOpmHcvEGwUUe7X+YQ8CuVdvzCJGUW31mYN+
         kutEcRAjJR4RcIEaSUCQ+2SZ1Rv35nHNuqPRysdFMn9OVDXJ9a8uh6YI7JPIBIExQFFw
         1nb0o6gG1SpBjtUqoSxsN0I9Nz6cEgQsIpwa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=mkjGA7pXWKUs0Nfv07SZZRXfgMyaUHALkc311WYJd5c=;
        b=QLzH3ca/fbPqYbpm2k08gkK+ztxhjjI9B459DL5f8GyZLnugYzqICc0vVAVD1lI4lA
         FI/9qrg5faoGlQ09Qbv1bWGkxxj/NZU8ro+DZgRt+xbf43ZnfYsNQmTROwe55YXhbWTc
         0ajm6y/CVJslJJ5dD3g8c5c7fJl365krngbs8jxgexwi27hEsGi6SCRVfBX1oefroR59
         9N+onH6vgsNabjCq6odddREIA8m8Vd2HziY0w4+71zwUFLGXiAv/tvUoaOccv3LYcjrL
         EBH2FRE0I8rUUEscELT9SvHXnG5diW4e+ZuJXDFJU+XoGP1NH01/TzUix3eWUVVUK2k0
         6sfw==
X-Gm-Message-State: AOAM532ACwwkCAWOw9eoGyJL4edGmIeAnEchvkq7LTIgWqJeAyoni8Ij
        Ut/fWGecUYJToQZ/5J8qha87Sg==
X-Google-Smtp-Source: ABdhPJyDK0gDuuHiczv9k6y+Mdkm1lj9HIgPKWCvChWYK5+PoIgy7TapyPO7BGOVyhxEfKVMzA4lGQ==
X-Received: by 2002:adf:81a3:: with SMTP id 32mr37517353wra.368.1600433138210;
        Fri, 18 Sep 2020 05:45:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e18sm4912651wrx.50.2020.09.18.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:45:37 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:45:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, ndesaulniers@google.com,
        gustavoars@kernel.org, jirislaby@kernel.org,
        george.kennedy@oracle.com, natechancellor@gmail.com,
        peda@axentia.se, krzysztof.h1@wp.pl, akpm@linux-foundation.org,
        adaplas@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fbcon: Remove the superfluous break
Message-ID: <20200918124535.GB438822@phenom.ffwll.local>
Mail-Followup-To: Jing Xiangfeng <jingxiangfeng@huawei.com>,
        b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        ndesaulniers@google.com, gustavoars@kernel.org,
        jirislaby@kernel.org, george.kennedy@oracle.com,
        natechancellor@gmail.com, peda@axentia.se, krzysztof.h1@wp.pl,
        akpm@linux-foundation.org, adaplas@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200918010521.69950-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918010521.69950-1-jingxiangfeng@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 09:05:21AM +0800, Jing Xiangfeng wrote:
> Remove the superfluous break, as there is a 'return' before it.
> 
> Fixes: bad07ff74c32 ("fbcon: smart blitter usage for scrolling")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/video/fbdev/core/fbcon.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 0b49b0f44edf..623359aadd1e 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  				    vc->vc_video_erase_char,
>  				    vc->vc_size_row * count);
>  			return true;
> -			break;
>  
>  		case SCROLL_WRAP_MOVE:
>  			if (b - t - count > 3 * vc->vc_rows >> 2) {
> @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>  				    vc->vc_video_erase_char,
>  				    vc->vc_size_row * count);
>  			return true;
> -			break;
>  
>  		case SCROLL_WRAP_MOVE:
>  			if (b - t - count > 3 * vc->vc_rows >> 2) {
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

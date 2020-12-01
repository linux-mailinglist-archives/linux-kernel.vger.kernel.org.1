Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FB42CABA9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgLATU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLATU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:20:59 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF1BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:20:17 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id o9so1717906pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UNtFxOQ4O2xPBFWrY/r+XwQcNVVjoO3zZJHkFA0yk+E=;
        b=KIVEomxVAADgG+V3vucWYExkCHk7pkgg652UAixA4Q3FRU8XTmPH3XX5dK5BCzfR2l
         ebbvWYq4vvxBYFyUa0fMS+4zN0kjEtBEzbG/0IDsu1WJoN1ayoSPcLvveTmvwZLOEZWA
         1931MXK+C3YJMyK9b2KJHge4rVxoa2aMsfe9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UNtFxOQ4O2xPBFWrY/r+XwQcNVVjoO3zZJHkFA0yk+E=;
        b=DV99vFxbPc5wGqWHdd5gqb+XvFzLgBRv0QgXGDN+dj8OUm6OCHwFTbfznbnOcCbFiw
         mKxqsh8gkH31sk50kZ3ZWoOOH0Q8+vJh51WINUH+xVlAQAjPpYCjV/dquT3Sd0SX0aAX
         ZoV6IK5pxJAivOCxvwhTD2ik43Df8X3c9bkEwb54cOalB4eqt150o3plPUkXtYZZvPkz
         wp1AsF+Am/+t8V+U39vGrr706gx0EMxIRfLsd6rFnsx8Xj5JyD4WsxVpkINNJQ3gpEBh
         +kHDLgYIM2slkQ8fX+yB1FRvGQ6+H/kZRaSjluPA4tPRYwn9re8xqiZig/cG6m+2t3Lk
         5s/w==
X-Gm-Message-State: AOAM533Zq94ZJ0XVUAmwI+B3EfromGygVm29RoZstWY9JltIwRRbhdfa
        MxmSmJRoN5AMZrbFi07Pq4Cf2w==
X-Google-Smtp-Source: ABdhPJxzRPXUo3h35t+Wv6xoj7vNs214gALSlt5JxU9Scdc9UW3uX5K0pMMc0ffAavMIlm60tp8uGQ==
X-Received: by 2002:a05:6a00:882:b029:19c:5287:4a1e with SMTP id q2-20020a056a000882b029019c52874a1emr2345984pfj.44.1606850417451;
        Tue, 01 Dec 2020 11:20:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s21sm344612pgk.52.2020.12.01.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:20:16 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:20:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] pstore/blk: remove __unregister_pstore_blk
Message-ID: <202012011119.A3816E1B0@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:42PM +0200, Christoph Hellwig wrote:
> Fold __unregister_pstore_blk into its only caller, and merge the
> two identical calls to __unregister_pstore_device that exist in the
> caller now.

Meh, I'm not a fan of this. I like it in a separate function. Pushing it
into the _exit() routine feels weird to me.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/pstore/blk.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index 7f8368e94b3604..3a2214ecf942ae 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -388,19 +388,6 @@ static int __register_pstore_blk(void)
>  	return ret;
>  }
>  
> -static void __unregister_pstore_blk(unsigned int major)
> -{
> -	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
> -	void *holder = blkdev;
> -
> -	lockdep_assert_held(&pstore_blk_lock);
> -	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
> -		__unregister_pstore_device(&dev);
> -		psblk_put_bdev(psblk_bdev, holder);
> -		psblk_bdev = NULL;
> -	}
> -}
> -
>  /* get information of pstore/blk */
>  int pstore_blk_get_config(struct pstore_blk_config *info)
>  {
> @@ -430,16 +417,14 @@ late_initcall(pstore_blk_init);
>  
>  static void __exit pstore_blk_exit(void)
>  {
> +	struct pstore_device_info dev = { };
> +
>  	mutex_lock(&pstore_blk_lock);
> +	if (pstore_zone_info)
> +		dev.read = pstore_zone_info->read;
> +	__unregister_pstore_device(&dev);
>  	if (psblk_bdev)
> -		__unregister_pstore_blk(MAJOR(psblk_bdev->bd_dev));
> -	else {
> -		struct pstore_device_info dev = { };
> -
> -		if (pstore_zone_info)
> -			dev.read = pstore_zone_info->read;
> -		__unregister_pstore_device(&dev);
> -	}
> +		psblk_put_bdev(psblk_bdev, blkdev);
>  	mutex_unlock(&pstore_blk_lock);
>  }
>  module_exit(pstore_blk_exit);
> -- 
> 2.28.0
> 

-- 
Kees Cook

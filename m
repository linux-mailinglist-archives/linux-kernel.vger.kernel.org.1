Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46362CC5CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbgLBSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387760AbgLBSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:47:17 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9CAC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:46:37 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 1so2267679qka.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2LD/HTrkqGSyXQ6XIikf4GS8sO+kccPG3e6WKHlaxvI=;
        b=YdK0yG/7KWAhu5MJYtLYFFzUTig0WLcAz/L/v3HiT6GdNgS7Zo1ZE6tGrpyvVTFM/a
         v/xLRbafxg78pYimAtvlik1NkbMTQZXkQOnwvEf+1uw88LMj9sLd7TY/5C102e1mJ6+v
         1KsUjFp77PkpgVwry7Dn+3Lc2nMP+ngci3FAxT990QT34ud7YbD+9QMWd/2XgIxXKwNr
         tScRaCnXWrm+0XOwWbAv2h4mgbSSTPhwAPjNX/XzTAud/qUds0nfbjiRleaN4NtRS/q4
         VM3Hxq75LA7ZYcwo1LPBu8XOjI5joizrrf7Mdtpm/cjGizMZ99A1SJveRRUE1DY1p3tk
         9QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2LD/HTrkqGSyXQ6XIikf4GS8sO+kccPG3e6WKHlaxvI=;
        b=mG1Ljuv8181UK143A+juRLgnvi+TAhRpVUsioqOZ1DtRR3La6gkIyDwnnRoDX0Z/r0
         C79BRAHnzkSB3DnPqeoBM0IDR/q+1tnY5w0nF7Y2NgF9WOHqEeW0D0nwC6MLYAzR2Jh6
         GJXyO7lT7T7nXclTlaD/gwmvl8jVX/YpTs6UTaPczpmbAnV8bS9B5saqHLhdb2gPA7vv
         ApLQ5AmswgKNYKwzFwaRNCi9WbUj/6Wp8ztVmTewJ/g5fzzHg0FkJS37MVQvfOPEhKSz
         JgkOq06WREejicOLSnW/qECRq85zO3pPJy7AOBUvlyIMxnc/Hpzl/BrkeRzuwxc7bEzN
         aWKw==
X-Gm-Message-State: AOAM531OEyA4sQ/Z56xW8FcbwsWWfev35HDrHMvUdBQr5rd4xWficMTT
        hftPgGZjKV6/ivFlbYgsaoH5O0fDIjPRRQ==
X-Google-Smtp-Source: ABdhPJy0BvzHIlBbwDIJIZRO6aQEJDF+OElc+jFluQLE9lKbJkRGifEHkrR1MacSgmXrz1BTGk7ueQ==
X-Received: by 2002:a37:4816:: with SMTP id v22mr4048810qka.42.1606934797003;
        Wed, 02 Dec 2020 10:46:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8dbd])
        by smtp.gmail.com with ESMTPSA id d9sm2461576qtr.68.2020.12.02.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:46:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Dec 2020 13:46:08 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kernfs: remove mutex in kernfs_dop_revalidate
Message-ID: <X8fg8CVS8RVQ8GCO@mtj.duckdns.org>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
 <20201202145837.48040-3-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145837.48040-3-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 02, 2020 at 10:58:37PM +0800, Fox Chen wrote:
> There is a big mutex in kernfs_dop_revalidate which slows down the
> concurrent performance of kernfs.
> 
> Since kernfs_dop_revalidate only does some checks, the lock is
> largely unnecessary. Also, according to kernel filesystem locking
> document:
> https://www.kernel.org/doc/html/latest/filesystems/locking.html
> locking is not in the protocal for d_revalidate operation.

That's just describing the rules seen from vfs side. It doesn't say anything
about locking rules internal to each file system implementation.

> This patch remove this mutex from
> kernfs_dop_revalidate, so kernfs_dop_revalidate
> can run concurrently.
> 
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  fs/kernfs/dir.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 9aec80b9d7c6..c2267c93f546 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -26,7 +26,6 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
>  
>  static bool kernfs_active(struct kernfs_node *kn)
>  {
> -	lockdep_assert_held(&kernfs_mutex);
>  	return atomic_read(&kn->active) >= 0;
>  }
>  
> @@ -557,10 +556,9 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>  
>  	/* Always perform fresh lookup for negatives */
>  	if (d_really_is_negative(dentry))
> -		goto out_bad_unlocked;
> +		goto out_bad;
>  
>  	kn = kernfs_dentry_node(dentry);
> -	mutex_lock(&kernfs_mutex);
>  
>  	/* The kernfs node has been deactivated */
>  	if (!kernfs_active(kn))
> @@ -579,11 +577,8 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>  	    kernfs_info(dentry->d_sb)->ns != kn->ns)
>  		goto out_bad;
>  
> -	mutex_unlock(&kernfs_mutex);
>  	return 1;
>  out_bad:
> -	mutex_unlock(&kernfs_mutex);
> -out_bad_unlocked:
>  	return 0;
>  }

I don't see how this can be safe. Nothing even protects the dentry from
turning negative in the middle and it may end up trying to deref NULL. I'm
sure we can make this not need kernfs_mutex but that'd have to be a lot more
careful.

Thanks.

-- 
tejun

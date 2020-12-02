Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8CB2CC509
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgLBS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgLBS1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:27:10 -0500
Date:   Wed, 2 Dec 2020 19:27:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606933589;
        bh=33LDAly2Dj/xO+/mODEE4euBaaporynFszCc7VfbE8Q=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzGmMFjEHM0Ih+UGrq/zGCXeSnuptqugEKn6M3dBKrgb+2hqgCW+MyncKFHTVRLQK
         e0SuGSk6k8BWYkNsbOhpWuTuqPIY4GZv7FzP2fumwVVhmQGaEogXxi1s3X3qtTAnvU
         V1jr59szae3uVRwkjWUYhp6bHpxCWu/I5tBXxfaY=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kernfs: remove mutex in kernfs_dop_revalidate
Message-ID: <X8fcmiEgJUeW6jqR@kroah.com>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
 <20201202145837.48040-3-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145837.48040-3-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:58:37PM +0800, Fox Chen wrote:
> There is a big mutex in kernfs_dop_revalidate which slows down the
> concurrent performance of kernfs.
> 
> Since kernfs_dop_revalidate only does some checks, the lock is
> largely unnecessary. Also, according to kernel filesystem locking
> document:
> https://www.kernel.org/doc/html/latest/filesystems/locking.html
> locking is not in the protocal for d_revalidate operation.
> 
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
>  
> @@ -650,6 +645,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  	kn->mode = mode;
>  	kn->flags = flags;
>  
> +	rwlock_init(&kn->iattr_rwlock);

Ah, now you initialize this, it should go into patch 1, right? :)

greg k-h

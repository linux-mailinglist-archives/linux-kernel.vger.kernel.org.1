Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67292CC505
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgLBS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgLBS0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:26:41 -0500
Date:   Wed, 2 Dec 2020 19:27:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606933560;
        bh=Up+i7gLdiXGbpr5ExEIjvv9QzzFhP7bpGM7vkWGDj34=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMZ0G0SUFYpA57WFtjq1UgDR6hCMz98s8ZivOXQUOhIJ6q28YXy6V5DjzMV7iUaZr
         DMSG/1BJTCGxJl6PLaZiyBFHr3tA2CqiHVmL1kiweR4KeXuUl5eiV/O+67kZXPAKFE
         FmuvcgwsyU5HLFPcohu5125D2ydZCnh2zUExEfFc=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kernfs: replace the mutex in kernfs_iop_permission
 with a rwlock
Message-ID: <X8fcfSxLhfqj35eR@kroah.com>
References: <20201202145837.48040-1-foxhlchen@gmail.com>
 <20201202145837.48040-2-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202145837.48040-2-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:58:36PM +0800, Fox Chen wrote:
> A big global mutex in kernfs_iop_permission will significanly drag
> system performance when processes concurrently open files
> on kernfs in Big machines(with >= 16 cpu cores).
> 
> This patch replace the big mutex with a rwlock specifically for
> protecting kernfs_node->iattribute. So that kernfs_iop_permission
> can perform concurrently.
> 
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  fs/kernfs/inode.c      | 16 ++++++++--------
>  include/linux/kernfs.h |  1 +
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index fc2469a20fed..c8c2ea669e6d 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -106,9 +106,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
>  {
>  	int ret;
>  
> -	mutex_lock(&kernfs_mutex);
> +	write_lock(&kn->iattr_rwlock);
>  	ret = __kernfs_setattr(kn, iattr);
> -	mutex_unlock(&kernfs_mutex);
> +	write_unlock(&kn->iattr_rwlock);
>  	return ret;
>  }
>  
> @@ -121,7 +121,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
>  	if (!kn)
>  		return -EINVAL;
>  
> -	mutex_lock(&kernfs_mutex);
> +	write_lock(&kn->iattr_rwlock);
>  	error = setattr_prepare(dentry, iattr);
>  	if (error)
>  		goto out;
> @@ -134,7 +134,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
>  	setattr_copy(inode, iattr);
>  
>  out:
> -	mutex_unlock(&kernfs_mutex);
> +	write_unlock(&kn->iattr_rwlock);
>  	return error;
>  }
>  
> @@ -189,9 +189,9 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
>  	struct inode *inode = d_inode(path->dentry);
>  	struct kernfs_node *kn = inode->i_private;
>  
> -	mutex_lock(&kernfs_mutex);
> +	read_lock(&kn->iattr_rwlock);
>  	kernfs_refresh_inode(kn, inode);
> -	mutex_unlock(&kernfs_mutex);
> +	read_unlock(&kn->iattr_rwlock);
>  
>  	generic_fillattr(inode, stat);
>  	return 0;
> @@ -281,9 +281,9 @@ int kernfs_iop_permission(struct inode *inode, int mask)
>  
>  	kn = inode->i_private;
>  
> -	mutex_lock(&kernfs_mutex);
> +	read_lock(&kn->iattr_rwlock);
>  	kernfs_refresh_inode(kn, inode);
> -	mutex_unlock(&kernfs_mutex);
> +	read_unlock(&kn->iattr_rwlock);
>  
>  	return generic_permission(inode, mask);
>  }
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 89f6a4214a70..545cdb39b34b 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -156,6 +156,7 @@ struct kernfs_node {
>  	unsigned short		flags;
>  	umode_t			mode;
>  	struct kernfs_iattrs	*iattr;
> +	rwlock_t		iattr_rwlock;
>  };

Don't you have to call rwlock_init() somewhere in order to properly
initialize the lock?  Did you try running this under lockdep to ensure
that there are no issues?

thanks,

greg k-h

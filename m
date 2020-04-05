Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED9B19ECAB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgDEQkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 12:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgDEQkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 12:40:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD33420675;
        Sun,  5 Apr 2020 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586104809;
        bh=tRkkXO+PEc/JrqWheuKG1whPIrxpx6mFXjlo4ozKhNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnfgp1DKwXMsHdHtFBSb419gEpYl3xaXybe04XzGLilluGFkO/IyJSj4Fo7+WxIcD
         fWJgt3dMpy84fwtijWeRReDHRsQ+oKGboxD6fpuFaUg6pzM1HS8gLRa+KmsggIUsuD
         6CiqndUfJHhHDUROUe8aX0q6ZoGnsnqrHh51aTRk=
Date:   Sun, 5 Apr 2020 18:40:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangfeionline@gmail.com
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] driver core: Fix possible use after free on name
Message-ID: <20200405164006.GA1582475@kroah.com>
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 09:05:49AM -0700, zhangfeionline@gmail.com wrote:
> From: PengfeiZhang <zhangfeionline@gmail.com>
> 
> __class_create() copies the pointer to the name passed as an
> argument only to be used later. But there's a chance the caller
> could immediately free the passed string(e.g., local variable).
> This could trigger a use after free when we use class name(e.g.,
> dev_uevent_name()called by device_destroy(),class_create_release()).
> 
> To be on the safe side: duplicate the string with kstrdup_const()
> so that if an unaware user passes an address to a stack-allocated
> buffer, we won't get the arbitrary name and crash.

Where are you seeing this happen?  

> 
> Signed-off-by: PengfeiZhang <zhangfeionline@gmail.com>
> ---
>  drivers/base/class.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index bcd410e..770b3b3 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -206,6 +206,7 @@ void class_unregister(struct class *cls)
>  static void class_create_release(struct class *cls)
>  {
>  	pr_debug("%s called for %s\n", __func__, cls->name);
> +	kfree_const(cls->name);
>  	kfree(cls);
>  }
>  
> @@ -227,7 +228,10 @@ struct class *__class_create(struct module *owner, const char *name,
>  			     struct lock_class_key *key)
>  {
>  	struct class *cls;
> -	int retval;
> +	int retval = -EINVAL;
> +
> +	if (!name)
> +		goto done;

This is a new change, who calls this function with name not being set?


>  
>  	cls = kzalloc(sizeof(*cls), GFP_KERNEL);
>  	if (!cls) {
> @@ -235,18 +239,27 @@ struct class *__class_create(struct module *owner, const char *name,
>  		goto error;
>  	}
>  
> +	name = kstrdup_const(name, GFP_KERNEL);
> +	if (!name) {
> +		retval = -ENOMEM;
> +		goto error;
> +	}

and overwriting the pointer like that is bad-form, try doing something
else here instead.

> +
>  	cls->name = name;
>  	cls->owner = owner;
>  	cls->class_release = class_create_release;
>  
>  	retval = __class_register(cls, key);
>  	if (retval)
> -		goto error;
> +		goto error_class_register;
>  
>  	return cls;
>  
> +error_class_register:
> +	kfree(cls->name);

kfree_const()?

thanks,

greg k-h

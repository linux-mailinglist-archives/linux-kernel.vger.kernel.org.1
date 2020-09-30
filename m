Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7C427E804
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgI3L5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3L5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:57:38 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C962075F;
        Wed, 30 Sep 2020 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467057;
        bh=jTIPj0hDxe4dQiOvFbebYyAKYwFyXODykvNjRZ/EYfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPm4lfm7efSRjxS7P4PqAemAG+Hd5iwQzN+jXJ26OpB0Z5nygh3nJ6/3VN4KSJ0mM
         T7nBJNyJqEI+lWY/v1AhBku2qi3F8Yple32MpMTW/nq5pRlMqLmQasFq/rQ5OayNHS
         uK0jvxXt2iEMqm8at1LTWqTbB0c85UddUoxYLBSk=
Date:   Wed, 30 Sep 2020 13:57:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 1/8] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
Message-ID: <20200930115740.GA1611809@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
 <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees, and Rafael, I don't know if you saw this proposal from Joe for
sysfs files, questions below:

On Wed, Sep 16, 2020 at 01:40:38PM -0700, Joe Perches wrote:
> Output defects can exist in sysfs content using sprintf and snprintf.
> 
> sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> used for outputting sysfs content and it's possible to overrun the
> PAGE_SIZE buffer length.
> 
> Add a generic sysfs_emit function that knows that the size of the
> temporary buffer and ensures that no overrun is done.
> 
> Add a generic sysfs_emit_at function that can be used in multiple
> call situations that also ensures that no overrun is done.
> 
> Validate the output buffer argument to be page aligned.
> Validate the offset len argument to be within the PAGE_SIZE buf.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  Documentation/filesystems/sysfs.rst |  8 ++---
>  fs/sysfs/file.c                     | 55 +++++++++++++++++++++++++++++
>  include/linux/sysfs.h               | 15 ++++++++
>  3 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
> index 5a3209a4cebf..004d490179f3 100644
> --- a/Documentation/filesystems/sysfs.rst
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -241,12 +241,10 @@ Other notes:
>    is 4096.
>  
>  - show() methods should return the number of bytes printed into the
> -  buffer. This is the return value of scnprintf().
> +  buffer.
>  
> -- show() must not use snprintf() when formatting the value to be
> -  returned to user space. If you can guarantee that an overflow
> -  will never happen you can use sprintf() otherwise you must use
> -  scnprintf().
> +- show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> +  the value to be returned to user space.
>  
>  - store() should return the number of bytes used from the buffer. If the
>    entire buffer has been used, just return the count argument.
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index eb6897ab78e7..96d0da65e088 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/seq_file.h>
> +#include <linux/mm.h>
>  
>  #include "sysfs.h"
>  
> @@ -707,3 +708,57 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sysfs_change_owner);
> +
> +/**
> + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> + *	@buf:	start of PAGE_SIZE buffer.
> + *	@fmt:	format
> + *	@...:	optional arguments to @format
> + *
> + *
> + * Returns number of characters written to @buf.
> + */
> +int sysfs_emit(char *buf, const char *fmt, ...)
> +{
> +	va_list args;
> +	int len;
> +
> +	if (WARN(!buf || offset_in_page(buf),
> +		 "invalid sysfs_emit: buf:%p\n", buf))
> +		return 0;
> +
> +	va_start(args, fmt);
> +	len = vscnprintf(buf, PAGE_SIZE, fmt, args);
> +	va_end(args);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(sysfs_emit);
> +
> +/**
> + *	sysfs_emit_at - scnprintf equivalent, aware of PAGE_SIZE buffer.
> + *	@buf:	start of PAGE_SIZE buffer.
> + *	@at:	offset in @buf to start write in bytes
> + *		@at must be >= 0 && < PAGE_SIZE
> + *	@fmt:	format
> + *	@...:	optional arguments to @fmt
> + *
> + *
> + * Returns number of characters written starting at &@buf[@at].
> + */
> +int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
> +{
> +	va_list args;
> +	int len;
> +
> +	if (WARN(!buf || offset_in_page(buf) || at < 0 || at >= PAGE_SIZE,
> +		 "invalid sysfs_emit_at: buf:%p at:%d\n", buf, at))
> +		return 0;
> +
> +	va_start(args, fmt);
> +	len = vscnprintf(buf + at, PAGE_SIZE - at, fmt, args);
> +	va_end(args);
> +
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(sysfs_emit_at);

These feel sane, but I'm loath to have a ton of churn for no good
reason.

If we make all sysfs show/store functions use these calls instead of
sprintf(), it "feels" like that might address the objections that people
have had in the past where they are nervous about "bare" sprintf()
calls, right?

It also might make things easier to audit where we can see much easier
where sysfs files are doing "foolish" things by calling sysfs_emit_at()
a bunch of times they shouldn't be, and maybe automate the documentation
of sysfs files in a better way.

So I guess I'm asking for another developer to at least agree that this
feels like the right way forward here.  I don't want to start down this
path, only to roll them all back as it feels like pointless churn.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430D51AC6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394550AbgDPOn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 10:43:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730302AbgDPOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587048229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MWF7qeFYGcwjfe4u/XIKlxtmBa+zuBoTmVw0MA2bPLk=;
        b=Kj33VeBHwI8PgzJfC4J+BOyht29ICVvsdy/GgOtSkS6uB+ACWBSIB3GpP4kXF7uVc0sljv
        eMK9JROD7C0+ZVdZFgXimAAKwDdEWjzpo2xYcNjxkvA9QrZR8zRtaAB6eIUVuGRE+Nprxn
        O8MQCfNS+y8F2DC7378ONAzmBSmTYWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-wJELbwD0OO2EOCILcZJ6Yg-1; Thu, 16 Apr 2020 10:43:45 -0400
X-MC-Unique: wJELbwD0OO2EOCILcZJ6Yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD988017FD;
        Thu, 16 Apr 2020 14:43:44 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-198.ams2.redhat.com [10.36.113.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A07A95D9E2;
        Thu, 16 Apr 2020 14:43:42 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH] vfs: add faccessat2 syscall
References: <20200416143532.11743-1-mszeredi@redhat.com>
Date:   Thu, 16 Apr 2020 16:43:40 +0200
In-Reply-To: <20200416143532.11743-1-mszeredi@redhat.com> (Miklos Szeredi's
        message of "Thu, 16 Apr 2020 16:35:32 +0200")
Message-ID: <87a73bcwyr.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Miklos Szeredi:

> POSIX defines faccessat() as having a fourth "flags" argument, while the
> linux syscall doesn't have it.  Glibc tries to emulate AT_EACCESS and
> AT_SYMLINK_NOFOLLOW, but AT_EACCESS emulation is broken.
>
> Add a new faccessat(2) syscall with the added flags argument and implement
> both flags.
>
> The value of AT_EACCESS is defined in glibc headers to be the same as
> AT_REMOVEDIR.  Use this value for the kernel interface as well, together
> with the explanatory comment.

Thanks a lot for this!

> +long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
> +{
> +	const struct cred *old_cred = NULL;
> +	struct path path;
> +	struct inode *inode;
> +	int res;
> +	unsigned int lookup_flags = LOOKUP_FOLLOW;
> +
> +	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
> +		return -EINVAL;
> +
> +	if (flags & ~(AT_EACCESS | AT_SYMLINK_NOFOLLOW))
> +		return -EINVAL;

Should this accept AT_EMPTY_PATH as well?

(I can't comment on the rest of the logic of the patch.)

> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index ca88b7bce553..2f86b2ad6d7e 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -84,10 +84,20 @@
>  #define DN_ATTRIB	0x00000020	/* File changed attibutes */
>  #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
>  
> +/*
> + * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
> + * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
> + * unlinkat.  The two functions do completely different things and therefore,
> + * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
> + * faccessat would be undefined behavior and thus treating it equivalent to
> + * AT_EACCESS is valid undefined behavior.
> + */
>  #define AT_FDCWD		-100    /* Special value used to indicate
>                                             openat should use the current
>                                             working directory. */
>  #define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
> +#define AT_EACCESS		0x200	/* Test access permitted for
> +                                           effective IDs, not real IDs.  */
>  #define AT_REMOVEDIR		0x200   /* Remove directory instead of
>                                             unlinking file.  */
>  #define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */

I can confirm that this is what glibc does, ofr better or worse.

Thanks,
Florian


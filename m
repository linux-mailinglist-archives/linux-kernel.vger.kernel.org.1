Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0566323B8EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgHDKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 06:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHDKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:41:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E702C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 03:41:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c2so23616136edx.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJDGqnBNBibFjObEixMOV83HWOZyXU89o9TO01hMyLI=;
        b=RsP0Dez4CRPGgZm75GnJjeLxJeymavBEExZwCbGNsxvzH9OVH+kmlD7Ldhp3eNAs7I
         8vyA8lcp9xzI4MBspyZMRog4UFEg00GloukWpE58T2vOYxFEpgJtiSOUn73KEJmnc2Uh
         EdkcgdhRO4zxRCvdu7IVVBcqAfMPVu35vt85I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HJDGqnBNBibFjObEixMOV83HWOZyXU89o9TO01hMyLI=;
        b=SH5XO42tb7WrLAqjfU8aZsXZo+TZmzlRxmVp5UA1kr/8XLTSQH1J75W2FYSxUqPy7G
         tLP/QwA8tj1OSMZYhDIJGFBLUJdSUmK7JwfDjZP9kLqFfmHlzNwx800WD7TYpR4Mlp5j
         hGem8ju8MF46+URTLW+lwzi7sL3FNp3XQRFYnvPAM13wNOnra1svocB48T1Zi6i1gHmq
         fddoDH46QM2uPuduuJYkeJQ7DFZobOuxy8A4qWi3RSHS/UVYXMFxOwUctuzgYwq+w2FN
         QaEW23dXx2g2NqOiShbKM117IwFVMgD6IwV6rRaSogBgWgf0jbcmcgbVK9rYLBPNFVj5
         hNIA==
X-Gm-Message-State: AOAM533X3VqZVM45TCI0OgVPOWOhvduE6Q2JKU8YyPDnF7hapOr/IN4z
        EEyaNkEBEZyFZGxmOICO85ZIbg==
X-Google-Smtp-Source: ABdhPJwyySilMxuE+LAsWOY2Y0iK4ietlusLfHz1j0+yzFekAp6FeWunyjURnbnr9K5sXQ47ys4WCQ==
X-Received: by 2002:a05:6402:b1b:: with SMTP id bm27mr14223356edb.140.1596537671215;
        Tue, 04 Aug 2020 03:41:11 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (94-21-100-63.pool.digikabel.hu. [94.21.100.63])
        by smtp.gmail.com with ESMTPSA id c18sm18357270eja.13.2020.08.04.03.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 03:41:10 -0700 (PDT)
Date:   Tue, 4 Aug 2020 12:41:08 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] fsinfo: Add a uniquifier ID to struct mount [ver
 #21]
Message-ID: <20200804104108.GC32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159646183662.1784947.5709738540440380373.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:37:16PM +0100, David Howells wrote:
> Add a uniquifier ID to struct mount that is effectively unique over the
> kernel lifetime to deal around mnt_id values being reused.  This can then
> be exported through fsinfo() to allow detection of replacement mounts that
> happen to end up with the same mount ID.
> 
> The normal mount handle is still used for referring to a particular mount.
> 
> The mount notification is then changed to convey these unique mount IDs
> rather than the mount handle.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/mount.h        |    3 +++
>  fs/mount_notify.c |    4 ++--
>  fs/namespace.c    |    3 +++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 85456a5f5a3a..1037781be055 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -79,6 +79,9 @@ struct mount {
>  	int mnt_expiry_mark;		/* true if marked for expiry */
>  	struct hlist_head mnt_pins;
>  	struct hlist_head mnt_stuck_children;
> +#ifdef CONFIG_FSINFO
> +	u64	mnt_unique_id;		/* ID unique over lifetime of kernel */
> +#endif

Not sure if it's worth making conditional.

>  #ifdef CONFIG_MOUNT_NOTIFICATIONS
>  	struct watch_list *mnt_watchers; /* Watches on dentries within this mount */
>  #endif
> diff --git a/fs/mount_notify.c b/fs/mount_notify.c
> index 44f570e4cebe..d8ba66ed5f77 100644
> --- a/fs/mount_notify.c
> +++ b/fs/mount_notify.c
> @@ -90,7 +90,7 @@ void notify_mount(struct mount *trigger,
>  	n.watch.type	= WATCH_TYPE_MOUNT_NOTIFY;
>  	n.watch.subtype	= subtype;
>  	n.watch.info	= info_flags | watch_sizeof(n);
> -	n.triggered_on	= trigger->mnt_id;
> +	n.triggered_on	= trigger->mnt_unique_id;
>  
>  	switch (subtype) {
>  	case NOTIFY_MOUNT_EXPIRY:
> @@ -102,7 +102,7 @@ void notify_mount(struct mount *trigger,
>  	case NOTIFY_MOUNT_UNMOUNT:
>  	case NOTIFY_MOUNT_MOVE_FROM:
>  	case NOTIFY_MOUNT_MOVE_TO:
> -		n.auxiliary_mount	= aux->mnt_id;
> +		n.auxiliary_mount = aux->mnt_unique_id;

Hmm, so we now have two ID's:

 - one can be used to look up the mount
 - one is guaranteed to be unique

With this change the mount cannot be looked up with FSINFO_FLAGS_QUERY_MOUNT,
right?

Should we be merging the two ID's into a single one which has both properties?

>  		break;
>  
>  	default:
> diff --git a/fs/namespace.c b/fs/namespace.c
> index b2b9920ffd3c..1db8a64cd76f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -115,6 +115,9 @@ static int mnt_alloc_id(struct mount *mnt)
>  	if (res < 0)
>  		return res;
>  	mnt->mnt_id = res;
> +#ifdef CONFIG_FSINFO
> +	mnt->mnt_unique_id = atomic64_inc_return(&vfs_unique_counter);
> +#endif
>  	return 0;
>  }
>  
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E544300CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbhAVSjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbhAVScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:32:25 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A753C061794
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:31:44 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id o5so1623926oop.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ab9R3Beg3K2SiC0qANgEYUJGr8eAMXRzKvwtlr3avY=;
        b=nasFTn+Wbf6+mLFLGP8W5Ujy6BYP5L2cegwclttCFnekEXAOkDDrvQu9YItuVGUqYZ
         KHew29S8kFItmdEKeX795fWRGhMVHexN8B+hmtTwKNd1mopSb58bSd3I9ZqxjBoNXSm/
         xYfxCLQpYYbd6kAnIKn9JBg4Pa3xpH/h5cjEW25nlNW62cfvCFaxWtz2X7fUkiKVL30c
         3aj3OmGZk1i/CBH0WT4fQlOsj13gCXgLRNy3s8yrXgm5XwcXd0PPn7ji/TlF8hfVpCYB
         k4bSiEC6DoNK0a0PtWTOCv5AgjGzFRHvM2E17zUau5K2Wem2O1Dw7Et+vzouOWJesWvT
         /OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ab9R3Beg3K2SiC0qANgEYUJGr8eAMXRzKvwtlr3avY=;
        b=haDedcqvafMV7d6gt/WRts+HtglqQE4iEGMHWAMfwtnCOvY5G+OAZ8ewMBAClZ5j7t
         WnAcLpXljEFO/6p+7Z9lhm1W7XRSZJmoaCCIDUBN54jottewP3lYKMNAXvvpyETlJxJ8
         /1CZQxNij13pRLf/GR/xD7G051pqmsc0MMeO1IvN0gDxNtmp78wdjZdwI/IKB6pdSV1b
         OWnvbCKc6fCVnK2yIk6uNdZ5hRXyh51lyUhWc6n89tiyGoKlobr9UrSp44XRuW8nQiqF
         cvf6ZvXsEbSU9nUThAoWuZvRJ5gzNr9v+10r9ReFkzFaWIzVgQMDmAaEd9wdiqssRm5M
         AvFQ==
X-Gm-Message-State: AOAM5323/HXSosy+kCVcJFfUKD6aURFUGZASly3Kr+mSpdWsMNSO2286
        xHAIKJiuCwTjnGrPM6sascK/ug==
X-Google-Smtp-Source: ABdhPJz0jtCdpEjEMrPjsrQ4MNKqxVFzLEirJ6qP9Bb8ZCzO4bpHVBR4tHp1tIKbz9Klj8hQkCd1XA==
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr4749495oof.61.1611340303740;
        Fri, 22 Jan 2021 10:31:43 -0800 (PST)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id x9sm1825985ota.23.2021.01.22.10.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:31:43 -0800 (PST)
Date:   Fri, 22 Jan 2021 12:31:41 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on
 security.capability
Message-ID: <20210122183141.GB81247@sequoia>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
 <20210119162204.2081137-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119162204.2081137-2-mszeredi@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-19 17:22:03, Miklos Szeredi wrote:
> Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> vfs_setxattr()") the translation of nscap->rootid did not take stacked
> filesystems (overlayfs and ecryptfs) into account.
> 
> That patch fixed the overlay case, but made the ecryptfs case worse.

Thanks for sending a fix!

I know that you don't have an eCryptfs setup to test with but I'm at a
loss about how to test this from the userns/fscaps side of things. Do
you have a sequence of unshare/setcap/getcap commands that I can run on
a file inside of an eCryptfs mount to verify that the bug exists after
7c03e2cda4a5 and then again to verify that this patch fixes the bug?

Tyler

> 
> Restore old the behavior for ecryptfs that existed before the overlayfs
> fix.  This does not fix ecryptfs's handling of complex user namespace
> setups, but it does make sure existing setups don't regress.
> 
> Reported-by: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Fixes: 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into vfs_setxattr()")
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/ecryptfs/inode.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e23752d9a79f..58d0f7187997 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1016,15 +1016,19 @@ ecryptfs_setxattr(struct dentry *dentry, struct inode *inode,
>  {
>  	int rc;
>  	struct dentry *lower_dentry;
> +	struct inode *lower_inode;
>  
>  	lower_dentry = ecryptfs_dentry_to_lower(dentry);
> -	if (!(d_inode(lower_dentry)->i_opflags & IOP_XATTR)) {
> +	lower_inode = d_inode(lower_dentry);
> +	if (!(lower_inode->i_opflags & IOP_XATTR)) {
>  		rc = -EOPNOTSUPP;
>  		goto out;
>  	}
> -	rc = vfs_setxattr(lower_dentry, name, value, size, flags);
> +	inode_lock(lower_inode);
> +	rc = __vfs_setxattr_locked(lower_dentry, name, value, size, flags, NULL);
> +	inode_unlock(lower_inode);
>  	if (!rc && inode)
> -		fsstack_copy_attr_all(inode, d_inode(lower_dentry));
> +		fsstack_copy_attr_all(inode, lower_inode);
>  out:
>  	return rc;
>  }
> -- 
> 2.26.2
> 

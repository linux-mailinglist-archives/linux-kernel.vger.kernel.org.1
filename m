Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20C62D1636
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgLGQej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbgLGQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9GFPfP4QUc9Eox0SoIdqm6RVWFYT3GmDgPPKwCvoZY=;
        b=BtehgoyXnmOIRhbF3FzG92Up0VW4JGlEbEwItKs+U+2tIVJOY91xQ643IPaG7pv/O2btre
        u8bwVYt1lXO9DQEpGKzZqNV/JK7PvJYyJ42r1Upk3IiXFQ/ugC49DdPsS45uaScODIw5hc
        Ae3KdLkQQtgJGNMv8X4OQnQKcHYoqQ0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-TNbhqQTZPyCIICgLdWFFOg-1; Mon, 07 Dec 2020 11:33:07 -0500
X-MC-Unique: TNbhqQTZPyCIICgLdWFFOg-1
Received: by mail-ed1-f71.google.com with SMTP id a9so5357340edy.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9GFPfP4QUc9Eox0SoIdqm6RVWFYT3GmDgPPKwCvoZY=;
        b=Pn/94xFMBfetMke7dLULE53Gl7LzojwSZbEkdhPwN0nUUPXspfXp9rIhkjUcNzOJd7
         Y/wda/ODoxJAg9gM+eQpEpWjOAnJB+4Fth0rEL2xwb8BUl64zTSX/I3l6adI9Ub9wi2v
         yP+ZzuWqs/ynDkF5uMAeSGgjXgWyZi88yHL84+8rwIDof4UGllE/zjm+LFYC1OzCsKtR
         G+6kJrYoYL9GEAlz6QJ+FV4iIwCFhC/ZwOmERc+rXzF7vCrrCeAxunvd6m4VXT4/F8de
         wBioDmrWIvMjrDNU7UdxJImiwUTm7px7v3Fp56vy6HcABx1X/Fnzx4ndRBoNGs4MUb72
         2m0w==
X-Gm-Message-State: AOAM532uEnCITxhVLvysFUhZASW0CYash5jRId7Wvd8R1gfwaFHG/WQa
        KqmCsg4X4d7hNFF/E1aJQgmOivknXjBhCFRTxxVWXHBS56N3pHTPveBP5nacya24aP36fDdP2hu
        vy+wHFET7h5vahqcT6aGyD8vL
X-Received: by 2002:a50:b243:: with SMTP id o61mr21246724edd.57.1607358785660;
        Mon, 07 Dec 2020 08:33:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdoaGF6V93HN0G1oEmt6WxNgh14Oc+j5HptlRhKBAGk7XVmmffsr/juqgIckKEWhSdANFcew==
X-Received: by 2002:a50:b243:: with SMTP id o61mr21246662edd.57.1607358785086;
        Mon, 07 Dec 2020 08:33:05 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:03 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 04/10] ovl: make ioctl() safe
Date:   Mon,  7 Dec 2020 17:32:49 +0100
Message-Id: <20201207163255.564116-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ovl_ioctl_set_flags() does a capability check using flags, but then the
real ioctl double-fetches flags and uses potentially different value.

The "Check the capability before cred override" comment misleading: user
can skip this check by presenting benign flags first and then overwriting
them to non-benign flags.

Just remove the cred override for now, hoping this doesn't cause a
regression.

The proper solution is to create a new setxflags i_op (patches are in the
works).

Xfstests don't show a regression.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 75 ++-------------------------------------------
 1 file changed, 3 insertions(+), 72 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..3cd1590f2030 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -541,46 +541,26 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	long ret;
 
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = security_file_ioctl(real.file, cmd, arg);
 	if (!ret)
 		ret = vfs_ioctl(real.file, cmd, arg);
-	revert_creds(old_cred);
 
 	fdput(real);
 
 	return ret;
 }
 
-static unsigned int ovl_iflags_to_fsflags(unsigned int iflags)
-{
-	unsigned int flags = 0;
-
-	if (iflags & S_SYNC)
-		flags |= FS_SYNC_FL;
-	if (iflags & S_APPEND)
-		flags |= FS_APPEND_FL;
-	if (iflags & S_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (iflags & S_NOATIME)
-		flags |= FS_NOATIME_FL;
-
-	return flags;
-}
-
 static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
-				unsigned long arg, unsigned int flags)
+				unsigned long arg)
 {
 	long ret;
 	struct inode *inode = file_inode(file);
-	unsigned int oldflags;
 
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
@@ -591,12 +571,6 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 	inode_lock(inode);
 
-	/* Check the capability before cred override */
-	oldflags = ovl_iflags_to_fsflags(READ_ONCE(inode->i_flags));
-	ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (ret)
-		goto unlock;
-
 	ret = ovl_maybe_copy_up(file_dentry(file), O_WRONLY);
 	if (ret)
 		goto unlock;
@@ -613,46 +587,6 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 
 }
 
-static long ovl_ioctl_set_fsflags(struct file *file, unsigned int cmd,
-				  unsigned long arg)
-{
-	unsigned int flags;
-
-	if (get_user(flags, (int __user *) arg))
-		return -EFAULT;
-
-	return ovl_ioctl_set_flags(file, cmd, arg, flags);
-}
-
-static unsigned int ovl_fsxflags_to_fsflags(unsigned int xflags)
-{
-	unsigned int flags = 0;
-
-	if (xflags & FS_XFLAG_SYNC)
-		flags |= FS_SYNC_FL;
-	if (xflags & FS_XFLAG_APPEND)
-		flags |= FS_APPEND_FL;
-	if (xflags & FS_XFLAG_IMMUTABLE)
-		flags |= FS_IMMUTABLE_FL;
-	if (xflags & FS_XFLAG_NOATIME)
-		flags |= FS_NOATIME_FL;
-
-	return flags;
-}
-
-static long ovl_ioctl_set_fsxflags(struct file *file, unsigned int cmd,
-				   unsigned long arg)
-{
-	struct fsxattr fa;
-
-	memset(&fa, 0, sizeof(fa));
-	if (copy_from_user(&fa, (void __user *) arg, sizeof(fa)))
-		return -EFAULT;
-
-	return ovl_ioctl_set_flags(file, cmd, arg,
-				   ovl_fsxflags_to_fsflags(fa.fsx_xflags));
-}
-
 long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret;
@@ -663,12 +597,9 @@ long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ret = ovl_real_ioctl(file, cmd, arg);
 		break;
 
-	case FS_IOC_SETFLAGS:
-		ret = ovl_ioctl_set_fsflags(file, cmd, arg);
-		break;
-
 	case FS_IOC_FSSETXATTR:
-		ret = ovl_ioctl_set_fsxflags(file, cmd, arg);
+	case FS_IOC_SETFLAGS:
+		ret = ovl_ioctl_set_flags(file, cmd, arg);
 		break;
 
 	default:
-- 
2.26.2


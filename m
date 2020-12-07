Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9A2D1655
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgLGQfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:35:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727754AbgLGQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607358791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=slnEJYBwmhqKOQO5uk6sWnTW5gdRX2VMxeSBeR8XW8Q=;
        b=A8aux/tMi/UcrLstNz5wCEjHGNGnUT/jQj8IMN6vXKIeTDimn8c8ukXoDTs3hGAMVEqLra
        kgGGFnKy/u3e/qjwLRHBOEybm37rOFijQ5/7l2IxvQEtybabOx3K2eORPTkjh9ujMgOvyg
        QxjSNw/dyTt1yMGF+v6ViiVg6zwEQ1M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-q6pjIAgCOs-a2g3kQvCVqQ-1; Mon, 07 Dec 2020 11:33:07 -0500
X-MC-Unique: q6pjIAgCOs-a2g3kQvCVqQ-1
Received: by mail-ej1-f71.google.com with SMTP id g18so4035700eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slnEJYBwmhqKOQO5uk6sWnTW5gdRX2VMxeSBeR8XW8Q=;
        b=PET4qKsGo7ReB7fj17BLKjQb+euAdFLyrov4eKP+FXgXGj5JRdRd5DaRPLM/X9SLcu
         /xe9/gL/HUV4KiHwdepPSX9Sza4S+A4Rn4/zrL6TsAB5RlXnlaw4zohFRLjEGKdI+y8X
         JwdAqUxXFFVN6t8LlW9WzS7ZjJ1hN5oQED2r68kmWgedvkPuPYjjzM3eCMcCxsqcP042
         4da8vGZyKkg+WWOCtpwS2wzOaW2KWAP98xm4sSoFtlWZb9bk2YYbTy5XfeWRh1cKhxrE
         e0ppHtmG3srEfRMNUHPF2UV8Obx74TgXCveENE4Ux62UU4uSIU2HzpVhLsHxOIMWUJE5
         vlUA==
X-Gm-Message-State: AOAM533pfD4lRmC+agqtbUr3eq/g4yj3QuqWfcmdPI7EV6rvMzWex8vp
        n3AQOoIyslyrZ/1tGjGqa67APJ4JdvbjRzT2uZ1tkWWCwyvZl42GwtO53eTimqpiHZsAQRxIZmR
        c9nwMB+3UYaVgahjk8rR2GLF7
X-Received: by 2002:a05:6402:1b1e:: with SMTP id by30mr19432222edb.75.1607358786632;
        Mon, 07 Dec 2020 08:33:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx0eatSbnQFhmj8ZAY47IpBzt1G1gtOIufiyiAi4IqzHOg0Ye7dB87LiC49RkGGzdIWq8D8A==
X-Received: by 2002:a05:6402:1b1e:: with SMTP id by30mr19432206edb.75.1607358786499;
        Mon, 07 Dec 2020 08:33:06 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id op5sm12801964ejb.43.2020.12.07.08.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:33:06 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/10] ovl: simplify file splice
Date:   Mon,  7 Dec 2020 17:32:50 +0100
Message-Id: <20201207163255.564116-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207163255.564116-1-mszeredi@redhat.com>
References: <20201207163255.564116-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_file_splice_read() and iter_file_splice_write() will call back into
f_op->iter_read() and f_op->iter_write() respectively.  These already do
the real file lookup and cred override.  So the code in ovl_splice_read()
and ovl_splice_write() is redundant.

In addition the ovl_file_accessed() call in ovl_splice_write() is
incorrect, though probably harmless.

Fix by calling generic_file_splice_read() and iter_file_splice_write()
directly.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/file.c | 46 ++-------------------------------------------
 1 file changed, 2 insertions(+), 44 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 3cd1590f2030..dc767034d37b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -397,48 +397,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
-			 struct pipe_inode_info *pipe, size_t len,
-			 unsigned int flags)
-{
-	ssize_t ret;
-	struct fd real;
-	const struct cred *old_cred;
-
-	ret = ovl_real_fdget(in, &real);
-	if (ret)
-		return ret;
-
-	old_cred = ovl_override_creds(file_inode(in)->i_sb);
-	ret = generic_file_splice_read(real.file, ppos, pipe, len, flags);
-	revert_creds(old_cred);
-
-	ovl_file_accessed(in);
-	fdput(real);
-	return ret;
-}
-
-static ssize_t
-ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
-			  loff_t *ppos, size_t len, unsigned int flags)
-{
-	struct fd real;
-	const struct cred *old_cred;
-	ssize_t ret;
-
-	ret = ovl_real_fdget(out, &real);
-	if (ret)
-		return ret;
-
-	old_cred = ovl_override_creds(file_inode(out)->i_sb);
-	ret = iter_file_splice_write(pipe, real.file, ppos, len, flags);
-	revert_creds(old_cred);
-
-	ovl_file_accessed(out);
-	fdput(real);
-	return ret;
-}
-
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct fd real;
@@ -732,8 +690,8 @@ const struct file_operations ovl_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= ovl_compat_ioctl,
 #endif
-	.splice_read    = ovl_splice_read,
-	.splice_write   = ovl_splice_write,
+	.splice_read    = generic_file_splice_read,
+	.splice_write   = iter_file_splice_write,
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
-- 
2.26.2


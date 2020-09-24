Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084732771F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgIXNNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgIXNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:13:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6B7C0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v12so3550517wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdyGUVuKv4uLTP1IH/WHroPyoizsYQ5O3xwWtSel+KA=;
        b=aKDNhQ9xaE7F0uUzW0kf0/mOfK+rPpwk1pTpxTAV+GegmPnu6q9Sp/YzeyQ9/JqSkW
         qxG/SjGu/Q1DYNKG96m6maPT41AKHfM0OV+VSrQwU1RLax+WIEUcHti50uK38USvhHOM
         PTI5qSc479kGMTxO98fo9wmzsSq02dH7ythqEBhAl0i9RjBPMDLorlKbFRZ5r7yedky0
         cJCXVSiD75rndCAuuYnDOBO9WY6oWIzDGBBcnLCXR5OND/3OmZkelzRlOqXaJHeG59A9
         i6OYktIcGLrZshWEsQkLuW/QBhJ6SllxuoIlbBA+oLM0rQ9qklTLCT1brH3Y5Pu6Fgi+
         3zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdyGUVuKv4uLTP1IH/WHroPyoizsYQ5O3xwWtSel+KA=;
        b=kZi2m9vfiNSyjCYjL1r3/562GFqqrU6u8RWdI2irFAZIstkazK8hWrrDvdqK0kKfUY
         6OD1ZZheS84N/kL5dNNvu3Jk/n5vyVt7qR2m7U2LRXB5rLnUehM1kJP6BlRe6sPhi3wo
         ZlLEz+BrQ2Y/JqJdALzcIzLveS0HheVtIt5oAZCQZZTVqVi4zm35SMNhPS6Ly2Ob1iWi
         eJq9i/3nIjVJVxyOotvu9wpPeKqPYLV/LMP0JzpBk6p8k5CGklI9P+BmB5wpl4G1HN3/
         37yXfgM/CPmIAzz2yPhyTGwpU1Ao6bee9i0Jm0maYpfyjDX0Ya45pBZVQaMoGhoZT35H
         Qo3Q==
X-Gm-Message-State: AOAM5302EEmkoVobmw5YiHZz4MNoZ+Irwt8RWyod2uwQpE5+KpTZ5R+9
        g6UwrmFENfigDSHbJdti0//g5A==
X-Google-Smtp-Source: ABdhPJyxhZcl5xyjMu94IAzrj7E5CrK+jN97dKuaDSE5wtPHiMTH4wRVOq+ZSf1afDxWj/RtxHzsKg==
X-Received: by 2002:a1c:2e4b:: with SMTP id u72mr4758638wmu.69.1600953204589;
        Thu, 24 Sep 2020 06:13:24 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id k22sm3805044wrd.29.2020.09.24.06.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:13:24 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V9 2/4] fuse: Trace daemon creds
Date:   Thu, 24 Sep 2020 14:13:16 +0100
Message-Id: <20200924131318.2654747-3-balsini@android.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200924131318.2654747-1-balsini@android.com>
References: <20200924131318.2654747-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reference to the FUSE daemon credentials, so that they can be used to
temporarily raise the user credentials when accessing lower file system
files in passthrough.

When using FUSE passthrough, read/write operations are directly forwarded
to the lower file system file, but there is no guarantee that the process
that is triggering the request has the right permissions to access the
lower file system.
By default, in the non-passthrough use case, it is the daemon that handles
the read/write operations, that can be performed to the lower file system
with the daemon privileges.
When passthrough is active, instead, the read/write operation is directly
applied to the lower file system, so to keep the same behavior as before,
the calling process temporarily receives the same credentials as the
daemon, that should be removed as soon as the operation completes.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/fuse_i.h | 3 +++
 fs/fuse/inode.c  | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6c5166447905..67bf5919f8d6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -524,6 +524,9 @@ struct fuse_conn {
 	/** The group id for this mount */
 	kgid_t group_id;
 
+	/** Creds of process which created this mount point */
+	const struct cred *creator_cred;
+
 	/** The pid namespace for this mount */
 	struct pid_namespace *pid_ns;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index eb223130a917..d22407bfa959 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -654,6 +654,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 			fiq->ops->release(fiq);
 		put_pid_ns(fc->pid_ns);
 		put_user_ns(fc->user_ns);
+		if (fc->creator_cred)
+			put_cred(fc->creator_cred);
 		fc->release(fc);
 	}
 }
@@ -1203,6 +1205,12 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->allow_other = ctx->allow_other;
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;
+	fc->creator_cred = prepare_creds();
+	if (!fc->creator_cred) {
+		err = -ENOMEM;
+		goto err_dev_free;
+	}
+
 	fc->max_read = max_t(unsigned, 4096, ctx->max_read);
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
-- 
2.28.0.681.g6f77f65b4e-goog


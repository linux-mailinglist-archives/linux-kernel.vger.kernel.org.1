Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8E3302721
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbhAYPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbhAYPnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:43:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A427CC061A2E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so4649922wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwpIKZJEqgcyH9jTEkHY/oqU7zr1rLx1xK5r1q299wU=;
        b=M5mY7gcIWm30rHRLFfpJ6dVKIbqVpY567QMlr+38KgnT63CeaQnTw5jMWuzyX5Ue78
         FXAAWtbuJX7k3a0w1/3gqITeZIjPn1WBnFrAhx3NF3sFhgiPs/rsah2Smt4Ux8jAMiMr
         OWJWrXDyfFjJOk+iCDJviGaBVc6zTTyQDdhTX5AYdNw9+j/AsKMiBXVUSuyHzt1k+PSe
         4F66kv3CX8hEme1SqkXYXX2Oym13u8YKvbfDI9df8QdPYwxowcZG6VNKFhhdZniKNvRI
         xOM84w8hekDeXCS+otrcssbVpw8d3eH1Os42KAYdwVIYybE/T30cJKino7oY2KNHJg4h
         RBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwpIKZJEqgcyH9jTEkHY/oqU7zr1rLx1xK5r1q299wU=;
        b=d1xtAN3L6wYBLkOWiNOQWn0IfVwehXydQEqUaVA/jjVIasoM50NZfzWcey9UmrJeEk
         /ck2qkxnDeWiTsgMndZUvwnkUHyWq2m19qM5ovQmf4JubzxpA4Yrp9qpTNnInhvHdzmb
         aRcXg74R7acXJlJb5OmZ/wErN8mgRq0sm/sY750dl0MMc4Sl4E6k2YYIOtyg/UkviARD
         n2N8IU2iYjEDz4Gulur6RimIxXGpxoXMVD6HWYuEshKsNFtdI2U9v1nzRU0TvMb4hpHT
         j+iyHEil5hDMXDZDxFEYFQh2La5S+nmVBwTiy/r4MOa3h2LSrKFaO+5f4eIjM4+I7eJ9
         IeQw==
X-Gm-Message-State: AOAM531XOB7k6IrT9PWEUzmONhxGyhuU3TiaENqHLY50cj/gIVZcE5Qx
        PMRsvDrG/ab/SSRiiTD4+ibOfw==
X-Google-Smtp-Source: ABdhPJx3VC0jelypwqOAnjslGn7yu3b7OKbCzFWEs1qu6YAjEOp2s1YkzSYOzf11YVv3sUG7XqmzYg==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr638086wml.115.1611588669362;
        Mon, 25 Jan 2021 07:31:09 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:4cd4:5994:40fe:253d])
        by smtp.gmail.com with ESMTPSA id o14sm22611965wri.48.2021.01.25.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:31:08 -0800 (PST)
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
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for fuse device
Date:   Mon, 25 Jan 2021 15:30:51 +0000
Message-Id: <20210125153057.3623715-3-balsini@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210125153057.3623715-1-balsini@android.com>
References: <20210125153057.3623715-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a 64-bit kernel build the FUSE device cannot handle ioctl requests
coming from 32-bit user space.
This is due to the ioctl command translation that generates different
command identifiers that thus cannot be used for direct comparisons
without proper manipulation.

Explicitly extract type and number from the ioctl command to enable
32-bit user space compatibility on 64-bit kernel builds.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/dev.c             | 29 ++++++++++++++++++-----------
 include/uapi/linux/fuse.h |  3 ++-
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 588f8d1240aa..ff9f3b83f879 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2233,37 +2233,44 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
-	int err = -ENOTTY;
+	int res;
+	int oldfd;
+	struct fuse_dev *fud = NULL;
 
-	if (cmd == FUSE_DEV_IOC_CLONE) {
-		int oldfd;
+	if (_IOC_TYPE(cmd) != FUSE_DEV_IOC_MAGIC)
+		return -EINVAL;
 
-		err = -EFAULT;
-		if (!get_user(oldfd, (__u32 __user *) arg)) {
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(FUSE_DEV_IOC_CLONE):
+		res = -EFAULT;
+		if (!get_user(oldfd, (__u32 __user *)arg)) {
 			struct file *old = fget(oldfd);
 
-			err = -EINVAL;
+			res = -EINVAL;
 			if (old) {
-				struct fuse_dev *fud = NULL;
-
 				/*
 				 * Check against file->f_op because CUSE
 				 * uses the same ioctl handler.
 				 */
 				if (old->f_op == file->f_op &&
-				    old->f_cred->user_ns == file->f_cred->user_ns)
+				    old->f_cred->user_ns ==
+					    file->f_cred->user_ns)
 					fud = fuse_get_dev(old);
 
 				if (fud) {
 					mutex_lock(&fuse_mutex);
-					err = fuse_device_clone(fud->fc, file);
+					res = fuse_device_clone(fud->fc, file);
 					mutex_unlock(&fuse_mutex);
 				}
 				fput(old);
 			}
 		}
+		break;
+	default:
+		res = -ENOTTY;
+		break;
 	}
-	return err;
+	return res;
 }
 
 const struct file_operations fuse_dev_operations = {
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 98ca64d1beb6..54442612c48b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -903,7 +903,8 @@ struct fuse_notify_retrieve_in {
 };
 
 /* Device ioctls: */
-#define FUSE_DEV_IOC_CLONE	_IOR(229, 0, uint32_t)
+#define FUSE_DEV_IOC_MAGIC		229
+#define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.30.0.280.ga3ce27912f-goog


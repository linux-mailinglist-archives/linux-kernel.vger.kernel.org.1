Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDB26DFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgIQPbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:31:14 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgIQPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:30:10 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MUGuZ-1jrobq3GTr-00REDu; Thu, 17 Sep 2020 17:28:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-media@vger.kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/8] media: v4l2: prepare compat-ioctl rework
Date:   Thu, 17 Sep 2020 17:28:16 +0200
Message-Id: <20200917152823.1241599-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200917152823.1241599-1-arnd@arndb.de>
References: <20200917152823.1241599-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jLtivs9oR8yT4Amv6wUYDZEGU94xByx2XLV3rL1lfaEk9Rp9+Y+
 WK3WkMVSuoxZ4WqzGptxXOYUsHq/yU0Ir+Eb+eb5Irthl2pfOAJ1BsroP4TxgXQ1zDE38dN
 m5MPdrfXJa5WltPdIWNLsYFjoVdA0lZE5lJ2jOTEPKz23UeauqCc9m4s5zJ0pBcOY7Cj1yL
 +sHUaUJkEhAXioDNGQfaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iw35kdxrs2c=:iAsUgkzFrSD/PzOctyTQCM
 AIUqxKNsN438rKEqhGTq3qTZsSlnaWFkn/Z7PU4Mr5BJrYKLvGtqI7BBVNoWanADZZx5YlsfO
 gzlLrA1ZOu9pavuOtFr1Gyl8Vb16sFfdy/uD3VcQi8l7cjGVhNO+vp1wh8C2QaYgmtHr47Ffw
 5ry2DF1yyn3IazHDtSLAacfVV8K5VqBe1xU7GFtByIQwtelvTffJBghQK/LfGjQyIbghlmv9h
 O5IYm3Xmln3eS2vG0BAS+QHovkiZFepPjTWSkrxQECx2WUWLrzuJjqe5W4tXjrUmSL7eXjHDV
 FxJQ4g0GrkYCGYzMp9wn0VFQ7CZ2iPAGwFE03fRu7ZZB6mRlpo/YqWkzgyrzgOMMX2SW3gUTp
 7a6+0K/aU1S3tbkbbfcnBI3pJdzjzZY393AGIFY+weTuh4xvI7TDL5jbdSa1OR++FFed8zhTx
 PIeAyGOgmAqWLdV7kb3koDCWMCRnBq2Ot+TkbGFyOLDxwUwOm9BpTU5TDsTTgnSbshP/UMHhn
 a41PeNR/IPUjIUbORnKIDEMpqOVmLBg27QgT25rlAZXONMsfluJlS/P2MaXcgiOlwl3FFS18g
 W2cvRFS/niXBD5Xn/D+pd92JyxtpLpDNXoaNwaV4sL5dZE8pr7rpbe3XgQpfYzREwFKVZEW8y
 UyPhNM5xhqBelX3J6UxaCopxR2xnz658L+AhmC3DZreAwthiZFOILLwTmwCWYZmrP8/w7TKxd
 eddK7v8waponllibERqjXrfgNPtKaVN+6YMycFQh6y4lqJ9lKz/Ml9hobyl5EQEuBYnburydY
 nhDQmN2wnArwyb7oCiKVcr2JuhWl9VmbGy0ksFCgYgAVfanpm3aXRfZbx7IGZz4KTcozy2J
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v4l2-compat-ioctl32() currently takes an extra round trip through user
space pointers when converting the data structure formats. In particular,
this involves using the compat_alloc_user_space() and copy_in_user()
helpers that often lead to worse compat handlers compared to using
in_compat_syscall() checks when copying the data.

The native implementation already gained a simpler method to deal with
the conversion for the time32 conversion.  Hook into the same places to
provide a location for reading and writing user space data from inside
of the generic video_usercopy() helper.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 53 ++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          | 97 ++++++++++++-------
 include/media/v4l2-ioctl.h                    | 11 +++
 3 files changed, 125 insertions(+), 36 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index 593bcf6c3735..8f2cb03be48b 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -1420,6 +1420,59 @@ static int put_v4l2_edid32(struct v4l2_edid __user *p64,
 #define VIDIOC_G_OUTPUT32	_IOR ('V', 46, s32)
 #define VIDIOC_S_OUTPUT32	_IOWR('V', 47, s32)
 
+unsigned int v4l2_compat_translate_cmd(unsigned int cmd)
+{
+	switch (cmd) {
+	}
+	return cmd;
+}
+
+int v4l2_compat_get_user(void __user *arg, void *parg, unsigned int cmd)
+{
+	switch (cmd) {
+	}
+	return 0;
+}
+
+int v4l2_compat_put_user(void __user *arg, void *parg, unsigned int cmd)
+{
+	switch (cmd) {
+	}
+	return 0;
+}
+
+int v4l2_compat_get_array_args(struct file *file, void *mbuf,
+			       void __user *user_ptr, size_t array_size,
+			       unsigned int cmd, void *arg)
+{
+	int err = 0;
+
+	switch (cmd) {
+	default:
+		if (copy_from_user(mbuf, user_ptr, array_size))
+			err = -EFAULT;
+		break;
+	}
+
+	return err;
+}
+
+int v4l2_compat_put_array_args(struct file *file, void __user *user_ptr,
+			       void *mbuf, size_t array_size,
+			       unsigned int cmd, void *arg)
+{
+	int err = 0;
+
+	switch (cmd) {
+	default:
+		if (copy_to_user(user_ptr, mbuf, array_size))
+			err = -EFAULT;
+		break;
+	}
+
+	return err;
+}
+
 /**
  * alloc_userspace() - Allocates a 64-bits userspace pointer compatible
  *	for calling the native 64-bits version of an ioctl.
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index a556880f225a..4e79cdac9a5f 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -8,6 +8,7 @@
  *              Mauro Carvalho Chehab <mchehab@kernel.org> (version 2)
  */
 
+#include <linux/compat.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -3103,11 +3104,14 @@ static unsigned int video_translate_cmd(unsigned int cmd)
 		return VIDIOC_PREPARE_BUF;
 #endif
 	}
+	if (in_compat_syscall())
+		return v4l2_compat_translate_cmd(cmd);
 
 	return cmd;
 }
 
-static int video_get_user(void __user *arg, void *parg, unsigned int cmd,
+static int video_get_user(void __user *arg, void *parg,
+			  unsigned int real_cmd, unsigned int cmd,
 			  bool *always_copy)
 {
 	unsigned int n = _IOC_SIZE(cmd);
@@ -3118,6 +3122,34 @@ static int video_get_user(void __user *arg, void *parg, unsigned int cmd,
 		return 0;
 	}
 
+	if (cmd == real_cmd) {
+		/*
+		 * In some cases, only a few fields are used as input,
+		 * i.e. when the app sets "index" and then the driver
+		 * fills in the rest of the structure for the thing
+		 * with that index.  We only need to copy up the first
+		 * non-input field.
+		 */
+		if (v4l2_is_known_ioctl(cmd)) {
+			u32 flags = v4l2_ioctls[_IOC_NR(cmd)].flags;
+
+			if (flags & INFO_FL_CLEAR_MASK)
+				n = (flags & INFO_FL_CLEAR_MASK) >> 16;
+			*always_copy = flags & INFO_FL_ALWAYS_COPY;
+		}
+
+		if (copy_from_user(parg, (void __user *)arg, n))
+			return -EFAULT;
+
+		/* zero out anything we don't copy from userspace */
+		if (n < _IOC_SIZE(cmd))
+			memset((u8 *)parg + n, 0, _IOC_SIZE(cmd) - n);
+		return 0;
+	}
+
+	if (in_compat_syscall())
+		return v4l2_compat_get_user(arg, parg, cmd);
+
 	switch (cmd) {
 #ifdef CONFIG_COMPAT_32BIT_TIME
 	case VIDIOC_QUERYBUF_TIME32:
@@ -3152,39 +3184,26 @@ static int video_get_user(void __user *arg, void *parg, unsigned int cmd,
 		break;
 	}
 #endif
-	default:
-		/*
-		 * In some cases, only a few fields are used as input,
-		 * i.e. when the app sets "index" and then the driver
-		 * fills in the rest of the structure for the thing
-		 * with that index.  We only need to copy up the first
-		 * non-input field.
-		 */
-		if (v4l2_is_known_ioctl(cmd)) {
-			u32 flags = v4l2_ioctls[_IOC_NR(cmd)].flags;
-
-			if (flags & INFO_FL_CLEAR_MASK)
-				n = (flags & INFO_FL_CLEAR_MASK) >> 16;
-			*always_copy = flags & INFO_FL_ALWAYS_COPY;
-		}
-
-		if (copy_from_user(parg, (void __user *)arg, n))
-			return -EFAULT;
-
-		/* zero out anything we don't copy from userspace */
-		if (n < _IOC_SIZE(cmd))
-			memset((u8 *)parg + n, 0, _IOC_SIZE(cmd) - n);
-		break;
 	}
-
 	return 0;
 }
 
-static int video_put_user(void __user *arg, void *parg, unsigned int cmd)
+static int video_put_user(void __user *arg, void *parg,
+			  unsigned int real_cmd, unsigned int cmd)
 {
 	if (!(_IOC_DIR(cmd) & _IOC_READ))
 		return 0;
 
+	if (cmd == real_cmd) {
+		/*  Copy results into user buffer  */
+		if (copy_to_user(arg, parg, _IOC_SIZE(cmd)))
+			return -EFAULT;
+		return 0;
+	}
+
+	if (in_compat_syscall())
+		return v4l2_compat_put_user(arg, parg, cmd);
+
 	switch (cmd) {
 #ifdef CONFIG_COMPAT_32BIT_TIME
 	case VIDIOC_DQEVENT_TIME32: {
@@ -3231,11 +3250,6 @@ static int video_put_user(void __user *arg, void *parg, unsigned int cmd)
 		break;
 	}
 #endif
-	default:
-		/*  Copy results into user buffer  */
-		if (copy_to_user(arg, parg, _IOC_SIZE(cmd)))
-			return -EFAULT;
-		break;
 	}
 
 	return 0;
@@ -3269,8 +3283,8 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
 			parg = mbuf;
 		}
 
-		err = video_get_user((void __user *)arg, parg, orig_cmd,
-				     &always_copy);
+		err = video_get_user((void __user *)arg, parg, cmd,
+				     orig_cmd, &always_copy);
 		if (err)
 			goto out;
 	}
@@ -3292,7 +3306,14 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
 		if (NULL == mbuf)
 			goto out_array_args;
 		err = -EFAULT;
-		if (copy_from_user(mbuf, user_ptr, array_size))
+		if (in_compat_syscall())
+			err = v4l2_compat_get_array_args(file, mbuf, user_ptr,
+							 array_size, orig_cmd,
+							 parg);
+		else
+			err = copy_from_user(mbuf, user_ptr, array_size) ?
+								-EFAULT : 0;
+		if (err)
 			goto out_array_args;
 		*kernel_ptr = mbuf;
 	}
@@ -3313,7 +3334,11 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
 
 	if (has_array_args) {
 		*kernel_ptr = (void __force *)user_ptr;
-		if (copy_to_user(user_ptr, mbuf, array_size))
+		if (in_compat_syscall())
+			err = v4l2_compat_put_array_args(file, user_ptr, mbuf,
+							 array_size, orig_cmd,
+							 parg);
+		else if (copy_to_user(user_ptr, mbuf, array_size))
 			err = -EFAULT;
 		goto out_array_args;
 	}
@@ -3325,7 +3350,7 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
 		goto out;
 
 out_array_args:
-	if (video_put_user((void __user *)arg, parg, orig_cmd))
+	if (video_put_user((void __user *)arg, parg, cmd, orig_cmd))
 		err = -EFAULT;
 out:
 	kvfree(mbuf);
diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
index 86878fba332b..0db79f36c496 100644
--- a/include/media/v4l2-ioctl.h
+++ b/include/media/v4l2-ioctl.h
@@ -686,6 +686,17 @@ long int v4l2_compat_ioctl32(struct file *file, unsigned int cmd,
 			     unsigned long arg);
 #endif
 
+unsigned int v4l2_compat_translate_cmd(unsigned int cmd);
+int v4l2_compat_get_user(void __user *arg, void *parg, unsigned int cmd);
+int v4l2_compat_put_user(void __user *arg, void *parg, unsigned int cmd);
+int v4l2_compat_get_array_args(struct file *file, void *mbuf,
+			       void __user *user_ptr, size_t array_size,
+			       unsigned int cmd, void *arg);
+int v4l2_compat_put_array_args(struct file *file, void __user *user_ptr,
+			       void *mbuf, size_t array_size,
+			       unsigned int cmd, void *arg);
+
+
 /**
  * typedef v4l2_kioctl - Typedef used to pass an ioctl handler.
  *
-- 
2.27.0


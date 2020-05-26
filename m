Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C641E1B03CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 10:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDTIE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 04:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDTIEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA89C061A10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:04:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so9126109wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tc+S3HgfyfdxhrTS98UbamV+05nkl5d7bc/WuRwN1Qo=;
        b=qe6tvDXHpsvBdMw4xakoapBOVAqHRztAR8E3Dv9b9ZDWQtZb3TSehvqOmRCoak7AA3
         oKGHahL++03wcJN0vvAu3OdgnbN7Hh8KSlhssvZYObHwUSaiBO3wA5KYVUPlHs9fW9ur
         5JRbj/go9YzdH05Wpf030wTbNe6pmwkqOVR2fv+Bi3Rk2Eh18AHrOrih5JtMGVOawGUh
         tkECRyxcf3Z7PTk5ndycd0Aq6iMdmvbNp+14U0gdcO0+5htbNcpJ0Mb+Rm5ACRZxMQGf
         pfOSN8uI4cAcqKfYG+o7vmnAcEBekRN/r3lPIfoVh//QNALzgu/CV/tGhKvLxm+jhszE
         LYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tc+S3HgfyfdxhrTS98UbamV+05nkl5d7bc/WuRwN1Qo=;
        b=C7Uu4xH4bxVE6aTUXxqpayQ22AfQDnDtyteR9NdJsMBD17n2a0jvM2gdKWMeWVmUX5
         +9QDzoL6/1XTTMk8WW0dvLqSjibUaonABuYXEvwzPz0GXaPQqTkXO+ucScAfaLGLTlHy
         wy3sGJhyT5ur57Cvz409jpzocuZaL9OBPZZac3JdFq2snax5hgbOg46unCQXZYXfd4KF
         YNmMEC5nz/hqqxOKUroVC623dPF2g2jygDvh3QgQb/rDUop8WQLr2QPlQit+7pIup+vP
         mrPhzqylm62iiFHv2+/pRlnS0Lu2530pRA/HF03fphEaFEf6Mia3E1hJ066UlHPMxdTq
         32Iw==
X-Gm-Message-State: AGi0PuZOZaPmXGGbMP3ZE4fvfp/x9m6b5Ly3rQv805LmoFqp0mpZGnQL
        WGRHK1m9FAReomAUqyPi0ZxrYQ==
X-Google-Smtp-Source: APiQypKZxpuT5O3h01mQCUTLigkQ8Uq18mdWOYae4joVaZgmSxGWGFRAjQz76vnv12P3B5/8zRNZSg==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr17151119wmg.32.1587369888037;
        Mon, 20 Apr 2020 01:04:48 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a67sm335827wmc.30.2020.04.20.01.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:04:47 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 4/4] loop: Add LOOP_SET_FD_AND_STATUS ioctl.
Date:   Mon, 20 Apr 2020 10:04:09 +0200
Message-Id: <20200420080409.111693-5-maco@android.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420080409.111693-1-maco@android.com>
References: <20200420080409.111693-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows userspace to completely setup a loop device with a single
ioctl, removing the in-between state where the device can be partially
configured - eg the loop device has a backing file associated with it,
but is reading from the wrong offset.

Besides removing the intermediate state, another big benefit of this
ioctl is that LOOP_SET_STATUS can be slow; the main reason for this
slowness is that LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to
freeze the associated queue; this requires waiting for RCU
synchronization, which I've measured can take about 15-20ms on this
device on average.

Here's setting up ~70 regular loop devices with an offset on an x86
Android device, using LOOP_SET_FD and LOOP_SET_STATUS:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
    0m03.40s real     0m00.02s user     0m00.03s system

Here's configuring ~70 devices in the same way, but using a modified
losetup that uses the new LOOP_SET_FD_AND_STATUS ioctl:

vsoc_x86:/system/apex # time for i in `seq 30 100`;
do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
    0m01.94s real     0m00.01s user     0m00.01s system

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c      | 47 ++++++++++++++++++++++++++++++---------
 include/uapi/linux/loop.h |  6 +++++
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6e656390b285..e1dbd70d6d6e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1065,8 +1065,9 @@ loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
 	return 0;
 }
 
-static int loop_set_fd(struct loop_device *lo, fmode_t mode,
-		       struct block_device *bdev, unsigned int arg)
+static int loop_set_fd_and_status(struct loop_device *lo, fmode_t mode,
+				  struct block_device *bdev, unsigned int fd,
+				  const struct loop_info64 *info)
 {
 	struct file	*file;
 	struct inode	*inode;
@@ -1081,7 +1082,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	__module_get(THIS_MODULE);
 
 	error = -EBADF;
-	file = fget(arg);
+	file = fget(fd);
 	if (!file)
 		goto out;
 
@@ -1090,7 +1091,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
+		claimed_bdev = bd_start_claiming(bdev, loop_set_fd_and_status);
 		if (IS_ERR(claimed_bdev)) {
 			error = PTR_ERR(claimed_bdev);
 			goto out_putf;
@@ -1117,9 +1118,24 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
 	error = -EFBIG;
-	size = get_loop_size(lo, file);
+	if (info)
+		size = get_size(info->lo_offset, info->lo_sizelimit,
+				file);
+	else
+		size = get_loop_size(lo, file);
 	if ((loff_t)(sector_t)size != size)
 		goto out_unlock;
+
+	if (info) {
+		error = loop_set_from_status(lo, info);
+		if (error)
+			goto out_unlock;
+	} else {
+		lo->transfer = NULL;
+		lo->ioctl = NULL;
+		lo->lo_sizelimit = 0;
+		lo->lo_offset = 0;
+	}
 	error = loop_prepare_queue(lo);
 	if (error)
 		goto out_unlock;
@@ -1132,9 +1148,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
-	lo->transfer = NULL;
-	lo->ioctl = NULL;
-	lo->lo_sizelimit = 0;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
@@ -1172,14 +1185,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_and_status);
 	return 0;
 
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 out_bdev:
 	if (claimed_bdev)
-		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd);
+		bd_abort_claiming(bdev, claimed_bdev, loop_set_fd_and_status);
 out_putf:
 	fput(file);
 out:
@@ -1653,7 +1666,18 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch (cmd) {
 	case LOOP_SET_FD:
-		return loop_set_fd(lo, mode, bdev, arg);
+		return loop_set_fd_and_status(lo, mode, bdev, arg, NULL);
+	case LOOP_SET_FD_AND_STATUS: {
+		struct loop_fd_and_status fds;
+
+		if (copy_from_user(&fds,
+				   (struct loop_fd_and_status __user *) arg,
+				   sizeof(fds)))
+			return -EFAULT;
+
+		return loop_set_fd_and_status(lo, mode, bdev, fds.fd,
+					      &fds.info);
+	}
 	case LOOP_CHANGE_FD:
 		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
@@ -1827,6 +1851,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_CLR_FD:
 	case LOOP_GET_STATUS64:
 	case LOOP_SET_STATUS64:
+	case LOOP_SET_FD_AND_STATUS:
 		arg = (unsigned long) compat_ptr(arg);
 		/* fall through */
 	case LOOP_SET_FD:
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 080a8df134ef..fcc9a693b588 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -60,6 +60,11 @@ struct loop_info64 {
 	__u64		   lo_init[2];
 };
 
+struct loop_fd_and_status {
+	struct loop_info64	info;
+	__u32			fd;
+};
+
 /*
  * Loop filter types
  */
@@ -90,6 +95,7 @@ struct loop_info64 {
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
 #define LOOP_SET_BLOCK_SIZE	0x4C09
+#define LOOP_SET_FD_AND_STATUS	0x4C0A
 
 /* /dev/loop-control interface */
 #define LOOP_CTL_ADD		0x4C80
-- 
2.26.1.301.g55bc3eb7cb9-goog


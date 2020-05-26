Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0841B41E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgDVKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 06:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgDVKGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AFDC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:06:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so1663519wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THMN4kP405JoezGxug3/jLYghdWABJDJj1NIGrZsvzY=;
        b=MqLCjCBae6u/cisLXNU9BKKy5mlwl+lR89m3evzk5jHVdtgHECXawMzGDYv/IFKav8
         WMCsm2BD2btn6Wfk/aoY5GbFBkAlrORyWPQfYoP7lof3wmub/4P4yDYiNgMdrcjfNFPS
         ugaSWkaL6YfG3N/LS+fRU6NbOYiMlME6WDW1ahHUj5VW+hEP2NLytNtMVFIrutahMcfm
         gyh1nx5egQLK+7S5C+FBFUSw11TemEx3i7S57c+leiSSmWVnrn2CkiYjIPg9n/51iSZU
         /arZrXRjnpcxNCb9S19xJEuKU3cJ1FqyHYl7jldGiZ0a7lyAwUrdgrIW1rrfUcXuQomv
         LeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THMN4kP405JoezGxug3/jLYghdWABJDJj1NIGrZsvzY=;
        b=KbbcODbDvPelPMQH1vi07XZomlLto0jcT7COJB8xRBQxpM2VxEA+rZuIojvONLuTcC
         igA2E1Sf3+7GPDXUGpTrWWotTizB3SDzcsH2VovbWEQXAknethmVFlrvftWef42UA0nw
         7hibOGhyh7satF+YEU224yizPAMqjqqUwO7QIelAK0YOZa6TbYSO62G4pr9nbyEpGQ5T
         Ddyf9zEUzejPUf60q7nznrOcuzr96EjAgGYQibpJHriG9A9rYb80s+JutkUkwNescDFh
         hEHA/z4yz0iuzUHPhQXLOmYJkBAPZm5RjTxWzTs00rVUuXz9O2beO1KIBkKHiWzTDQIa
         9Gog==
X-Gm-Message-State: AGi0PubLrZYaatLgXL+kf7G6sOGDCBPdFmqbxuHhzTG6RJfOMBAofHI+
        ecgyZjXGbjO0xlQ+/cOw3Pq2LA==
X-Google-Smtp-Source: APiQypKEoEkeuuC3Cb8hP8uwpIT0HcCTtV5Fqb4J9R+piXg7Q4lFlJnRgP9KeP2Y3/l4DG4WebT/tg==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr9695075wmh.39.1587550008974;
        Wed, 22 Apr 2020 03:06:48 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id j13sm7812462wrq.24.2020.04.22.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:06:48 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v2 5/5] loop: Add LOOP_SET_FD_AND_STATUS ioctl
Date:   Wed, 22 Apr 2020 12:06:36 +0200
Message-Id: <20200422100636.46357-6-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200422100636.46357-1-maco@android.com>
References: <20200422100636.46357-1-maco@android.com>
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
 drivers/block/loop.c      | 45 ++++++++++++++++++++++++++++-----------
 include/uapi/linux/loop.h |  7 ++++++
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b10f1d5306a2..4df1f03de27e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1074,8 +1074,9 @@ loop_set_status_from_info(struct loop_device *lo,
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
@@ -1090,7 +1091,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	__module_get(THIS_MODULE);
 
 	error = -EBADF;
-	file = fget(arg);
+	file = fget(fd);
 	if (!file)
 		goto out;
 
@@ -1099,7 +1100,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bd_start_claiming(bdev, loop_set_fd);
+		claimed_bdev = bd_start_claiming(bdev, loop_set_fd_and_status);
 		if (IS_ERR(claimed_bdev)) {
 			error = PTR_ERR(claimed_bdev);
 			goto out_putf;
@@ -1126,9 +1127,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
 	error = -EFBIG;
-	size = get_loop_size(lo, file);
+	size = get_size(info->lo_offset, info->lo_sizelimit, file);
 	if ((loff_t)(sector_t)size != size)
 		goto out_unlock;
+
+	error = loop_set_status_from_info(lo, info);
+	if (error)
+		goto out_unlock;
+
 	error = loop_prepare_queue(lo);
 	if (error)
 		goto out_unlock;
@@ -1141,9 +1147,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	lo->lo_device = bdev;
 	lo->lo_flags = lo_flags;
 	lo->lo_backing_file = file;
-	lo->transfer = NULL;
-	lo->ioctl = NULL;
-	lo->lo_sizelimit = 0;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
 	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
@@ -1181,14 +1184,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
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
@@ -1662,8 +1665,25 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	int err;
 
 	switch (cmd) {
-	case LOOP_SET_FD:
-		return loop_set_fd(lo, mode, bdev, arg);
+	case LOOP_SET_FD: {
+		/* legacy case - pass in a zeroed out loop_info64, which
+		 * corresponds with the default parameters we'd have used
+		 * otherwise.
+		 */
+		struct loop_info64 info;
+
+		memset(&info, 0, sizeof(info));
+		return loop_set_fd_and_status(lo, mode, bdev, arg, &info);
+	}
+	case LOOP_SET_FD_AND_STATUS: {
+		struct loop_fd_and_status fds;
+
+		if (copy_from_user(&fds, argp, sizeof(fds)))
+			return -EFAULT;
+
+		return loop_set_fd_and_status(lo, mode, bdev, fds.fd,
+					      &fds.info);
+	}
 	case LOOP_CHANGE_FD:
 		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
@@ -1835,6 +1855,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_CLR_FD:
 	case LOOP_GET_STATUS64:
 	case LOOP_SET_STATUS64:
+	case LOOP_SET_FD_AND_STATUS:
 		arg = (unsigned long) compat_ptr(arg);
 		/* fall through */
 	case LOOP_SET_FD:
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 080a8df134ef..05ab625c40db 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -60,6 +60,12 @@ struct loop_info64 {
 	__u64		   lo_init[2];
 };
 
+struct loop_fd_and_status {
+	struct loop_info64	info;
+	__u32			fd;
+	__u32			__pad;
+};
+
 /*
  * Loop filter types
  */
@@ -90,6 +96,7 @@ struct loop_info64 {
 #define LOOP_SET_CAPACITY	0x4C07
 #define LOOP_SET_DIRECT_IO	0x4C08
 #define LOOP_SET_BLOCK_SIZE	0x4C09
+#define LOOP_SET_FD_AND_STATUS	0x4C0A
 
 /* /dev/loop-control interface */
 #define LOOP_CTL_ADD		0x4C80
-- 
2.26.2.303.gf8c07b1a785-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E41BDFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgD2OEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbgD2OD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F61C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so2680281wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSTM3Qi/4U9iaA1lz8BvS/1iZyuC1rKHgcM75ldZEu4=;
        b=CUy816SARBoL3Uki3aIIhK4RmGONTtkFUicVkdJGwEY79gT7qkVdXYcuhkWVB7hMOP
         dWvfwllgHNLuEmmFhBvTQztCjHJPyzkVpBQwTAPZBJB7/akeF4Sldi2OQRO6ZX37f1Vd
         P7HTOFl1gKJZN8is5CoOkKHL7BhFkubDw+V0nNNa8LPi1bebKXNAPAdeqrUd8aL5awjR
         9zG+o0v+2l0mOvQ8wsY0VJQhPbaEywfjlJU0sdx5fA7nW+sD2aFKBxdTC8Q8ItMmnWb0
         OtIurjg7erO3sU910m+PEr/BLGEVYhIAF3tI/ONoxIXSHwyXMztfzoc5naQyKcxaXP7L
         +1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSTM3Qi/4U9iaA1lz8BvS/1iZyuC1rKHgcM75ldZEu4=;
        b=fxGGt9v2VcIIlCcKLd6U6RGbWfeYPI1a7ZtY85xXSlHjodYUymVib1R9N6dAPWeEzO
         NCIoIuswAfq/6/Sne84h9mtRMKeOjkaKkj2UEjMGsR/qaWze1gW5zqbH3v9OuOh5qDG2
         AJIhOMCweKew/7mcQwC2FaU5E6bT6w1YpD6JZ/fHyM3LmCfWkjMQ0hCtywyycDDjj4Yg
         dSppyS5YkeuK1//Ou1EY1EIlE6f0ONK7jCc9BnloZg1CBsuk0PPqy671JzAqrcWrv42W
         wUFeHv8XniLddxnP3GOSwJpaCuHBBQMVYVnrSoviycdns1S/ajpoWq0Ou20ELEq9DCHM
         w6iA==
X-Gm-Message-State: AGi0Pubod3h/L+0gP3EqefOzvVYUViib2KR4JzeQYklAqir3i+7ETZRE
        oOv2K9AmnwtpksH7PRNI7ObtBQ==
X-Google-Smtp-Source: APiQypLh806kYCaic9QEG1Qzl0KzfPxn1oM3FQfGFXaXHMJCgdvQnOl9wOD92kYUKJ4GjvyTRpnrhQ==
X-Received: by 2002:adf:fa04:: with SMTP id m4mr38662555wrr.30.1588169037163;
        Wed, 29 Apr 2020 07:03:57 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:56 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 09/10] loop: Clean up LOOP_SET_STATUS lo_flags handling.
Date:   Wed, 29 Apr 2020 16:03:40 +0200
Message-Id: <20200429140341.13294-10-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LOOP_SET_STATUS(64) will actually allow some lo_flags to be modified; in
particular, LO_FLAGS_AUTOCLEAR can be set and cleared, whereas
LO_FLAGS_PARTSCAN can be set to request a partition scan. Make this
explicit by updating the UAPI to include the flags that can be
set/cleared using this ioctl.

The implementation can then blindly take over the passed in flags,
and use the previous flags for those flags that can't be set / cleared
using LOOP_SET_STATUS.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c      | 19 +++++++++++++------
 include/uapi/linux/loop.h | 10 ++++++++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f172a64333aa..cfbdd99fdb1a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1049,9 +1049,7 @@ loop_set_status_from_info(struct loop_device *lo,
 	lo->transfer = xfer->transfer;
 	lo->ioctl = xfer->ioctl;
 
-	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
-	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
-		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
+	lo->lo_flags = info->lo_flags;
 
 	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
 	lo->lo_init[0] = info->lo_init[0];
@@ -1338,6 +1336,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	int err;
 	struct block_device *bdev;
 	kuid_t uid = current_uid();
+	int prev_lo_flags;
 	bool partscan = false;
 	bool size_changed = false;
 	loff_t validated_size;
@@ -1381,10 +1380,19 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unfreeze;
 	}
 
+	prev_lo_flags = lo->lo_flags;
+
 	err = loop_set_status_from_info(lo, info);
 	if (err)
 		goto out_unfreeze;
 
+	/* Mask out flags that can't be set using LOOP_SET_STATUS. */
+	lo->lo_flags &= ~LOOP_SET_STATUS_SETTABLE_FLAGS;
+	/* For those flags, use the previous values instead */
+	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_SETTABLE_FLAGS;
+	/* For flags that can't be cleared, use previous values too */
+	lo->lo_flags |= prev_lo_flags & ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
+
 	if (size_changed)
 		loop_set_size(lo, validated_size);
 
@@ -1396,9 +1404,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	if (!err && (info->lo_flags & LO_FLAGS_PARTSCAN) &&
-	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
-		lo->lo_flags |= LO_FLAGS_PARTSCAN;
+	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
+	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
 		bdev = lo->lo_device;
 		partscan = true;
diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
index 080a8df134ef..6b32fee80ce0 100644
--- a/include/uapi/linux/loop.h
+++ b/include/uapi/linux/loop.h
@@ -25,6 +25,12 @@ enum {
 	LO_FLAGS_DIRECT_IO	= 16,
 };
 
+/* LO_FLAGS that can be set using LOOP_SET_STATUS(64) */
+#define LOOP_SET_STATUS_SETTABLE_FLAGS (LO_FLAGS_AUTOCLEAR | LO_FLAGS_PARTSCAN)
+
+/* LO_FLAGS that can be cleared using LOOP_SET_STATUS(64) */
+#define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR)
+
 #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
 #include <linux/types.h>	/* for __u64 */
 
@@ -37,7 +43,7 @@ struct loop_info {
 	int		   lo_offset;
 	int		   lo_encrypt_type;
 	int		   lo_encrypt_key_size; 	/* ioctl w/o */
-	int		   lo_flags;			/* ioctl r/o */
+	int		   lo_flags;
 	char		   lo_name[LO_NAME_SIZE];
 	unsigned char	   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
 	unsigned long	   lo_init[2];
@@ -53,7 +59,7 @@ struct loop_info64 {
 	__u32		   lo_number;			/* ioctl r/o */
 	__u32		   lo_encrypt_type;
 	__u32		   lo_encrypt_key_size;		/* ioctl w/o */
-	__u32		   lo_flags;			/* ioctl r/o */
+	__u32		   lo_flags;
 	__u8		   lo_file_name[LO_NAME_SIZE];
 	__u8		   lo_crypt_name[LO_NAME_SIZE];
 	__u8		   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
-- 
2.26.2.303.gf8c07b1a785-goog


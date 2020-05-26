Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525511D15E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbgEMNj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388403AbgEMNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:39:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B0C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k12so26539254wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POCEZLhOMyAYL79dmttqIcaXe8olR2uGKpnhJHwT9Bc=;
        b=k9uAgJrvSLqYqjlr/7FemhreMX5L8RfzI3k3jZMrTHzti+aqwlEj5LuLiXs0/j7C5t
         7o9Euo+zXbkXXdrhue3P/LypqUb9wN40SwJf+GO5fE/DX9iW13FGkDYG9gINTFKvquCv
         KjSkprs4rDMRRZeXbdm3Bz1hBTUrkij/dnfTGI6x2C/Ys3XrIKMlFkUJfOzi8cpWLsgN
         WesotT8PIdpI1Ad4Sw7uOZ5klj29YLKM+/Aysuc5oJ3kAH909pGWgeBWf/YH/zw4GqKC
         /crJaiM8nnYOLhEEV6ojaQME9NCUGr32QSTCxBGMOl5CHu47Wx9X41fuSfYlgPG4Am/Z
         aaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POCEZLhOMyAYL79dmttqIcaXe8olR2uGKpnhJHwT9Bc=;
        b=EUXg1FyIG2imIz4BfGQHDtuXkOXswE1lZOh6VvUv3X3jMgTJsmUB8NnwdTWJryN0ur
         a2hJcWZQROAb9v1z4n6gcQQCPBvB73Uc5D82KBZ8uLcW3BemQOnYBa9tcv4IBEtZwSck
         M0qcZ38TQM3E7STg7cSpUy5zDrgjPgaIELriZLmB40OZOJGsE8cM2vpKA+4tX3h4yfKQ
         884el4Y47Gp1fDk8iLdH92nFSq0nk7v4gHMZW0f4I1WML+9PnTyrAkyas6o07jJzZ1WN
         uqRLzarx42OVi1mmLn2ygA8Jxn9hMkPREf4NWzwBbx0hmnRql3MogLxoa3FCoCnHQPjE
         aDYA==
X-Gm-Message-State: AGi0PubtwZPXN8IaH64MBifGuACDoODk3b6yHXT3fO55LRw13frLnvuD
        lTsqsf5n95OICNSA3Y5T/roWWw==
X-Google-Smtp-Source: APiQypIQ8EMG0eQ2MileWb5d3BNe03CVQDjqnEtCDHpdaRXZv8NJbwfGqtVbjy9y6eDqGqENL63mNw==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr29617586wml.117.1589377141372;
        Wed, 13 May 2020 06:39:01 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:39:00 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 10/11] loop: Clean up LOOP_SET_STATUS lo_flags handling
Date:   Wed, 13 May 2020 15:38:44 +0200
Message-Id: <20200513133845.244903-11-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c      | 19 +++++++++++++------
 include/uapi/linux/loop.h | 10 ++++++++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 31f10da4945e..13518ba191f5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1036,9 +1036,7 @@ loop_set_status_from_info(struct loop_device *lo,
 	lo->transfer = xfer->transfer;
 	lo->ioctl = xfer->ioctl;
 
-	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
-	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
-		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
+	lo->lo_flags = info->lo_flags;
 
 	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
 	lo->lo_init[0] = info->lo_init[0];
@@ -1323,6 +1321,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	int err;
 	struct block_device *bdev;
 	kuid_t uid = current_uid();
+	int prev_lo_flags;
 	bool partscan = false;
 	bool size_changed = false;
 
@@ -1359,10 +1358,19 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
 	if (size_changed) {
 		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
 					   lo->lo_backing_file);
@@ -1377,9 +1385,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
2.26.2.645.ge9eca65c58-goog


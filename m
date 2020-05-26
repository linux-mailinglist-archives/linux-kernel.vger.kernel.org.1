Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C42C1B98E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 09:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgD0HnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgD0Hmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:42:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED16C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so19316006wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LlF9hQrtqAVkh9UpGKlmxEFlHX/UD9uxV1eHlcxAJ3U=;
        b=fnexYmogjOXup/e3tYS2gP/6MnVAfVxckYSj8bpFo/B7M3YWZgyo8m8WwEIDajR5bi
         crzfuWav0zcI76Y+F0wc3xFuRGtCWuxBTLfhPWoJKVDH+PAdMVwIIiTVapIEro0FTPTp
         lyFX2fVqx24UivdL9QiebFgeoriTR/NOp/wWnAbTDGXWyPuAmy7QJnph0uwo8C1EaWfs
         FcgV5HBMNtD9mjZekcaB3Y0NdMac/bg1hhyEblwD/+X3FtemNqJO3C/+udCIqsFakKRS
         4zO/cLKGFqu3EcorY5TXwjBtYzIw+AcepWUJdPa8UHZJwK8HjbZ76IyT6fqSYWhvdF4s
         yDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LlF9hQrtqAVkh9UpGKlmxEFlHX/UD9uxV1eHlcxAJ3U=;
        b=MLA5ny46qRfPu1GN1JtlsWNVMKscAET2gDgMKB0+Gbu/bPFD5cqF0aUSGtMDBq38xw
         0c3BkPA0vJLo2mvahB7p102cOr2UUGGRVGpv3j+3dlVl6h1eeISG3SwuzY0FBOYhSX2X
         3S13LzJReUhqW7scsffp3qAi3mhykRvvaYLzV7z/d+2uEbFN6NT4jNEPoDxhwKx4dqTl
         6bj8DGNvouxKhFQzfW24jgXazeOv5lit0kTJ70MogeDSBM29UzlUDrTsHbrpmj3tQqxM
         8JMYY/k6I+K94vtngMh7Nq0N0Auky5fY4nuXPoMGNHwgHf3/eT2DxiDy+RMOQLtLG7Te
         gIdw==
X-Gm-Message-State: AGi0PuYEswsJqvDUF7PZVpJutzZzXwpV9PlBP+5BxYDrw9FVu+KNvYMz
        Tey+Ie3Y9j17RbDCykOf+mEhpbSRZsYfyg==
X-Google-Smtp-Source: APiQypKxaIEIrAbS4VD6DPhHwA8Z9c0Iikjybz7Gls4+S+TFILJ5eZ7Rv3r3svM3sG1cy2rxDanIYg==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr24580948wmm.9.1587973358112;
        Mon, 27 Apr 2020 00:42:38 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id x132sm15091658wmg.33.2020.04.27.00.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:42:37 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v3 4/9] loop: Refactor loop_set_status() size calculation
Date:   Mon, 27 Apr 2020 09:42:17 +0200
Message-Id: <20200427074222.65369-5-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200427074222.65369-1-maco@android.com>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

figure_loop_size() calculates the loop size based on the passed in
parameters, but at the same time it updates the offset and sizelimit
parameters in the loop device configuration. That is a somewhat
unexpected side effect of a function with this name, and it is only only
needed by one of the two callers of this function - loop_set_status().

Move the lo_offset and lo_sizelimit assignment back into loop_set_status(),
and use the newly factored out functions to validate and apply the newly
calculated size. This allows us to get rid of figure_loop_size in a
follow-up commit.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2e2874318393..d0f17ee1e29b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1295,6 +1295,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool size_changed = false;
+	loff_t validated_size;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1316,6 +1318,13 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
+		loff_t size = get_size(info->lo_offset, info->lo_sizelimit,
+				       lo->lo_backing_file);
+		err = loop_validate_size(size);
+		if (err)
+			goto out_unlock;
+		size_changed = true;
+		validated_size = size;
 		sync_blockdev(lo->lo_device);
 		kill_bdev(lo->lo_device);
 	}
@@ -1323,6 +1332,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
+		/* If any pages were dirtied after kill_bdev(), try again */
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
 	err = loop_release_xfer(lo);
 	if (err)
 		goto out_unfreeze;
@@ -1346,22 +1364,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (err)
 		goto out_unfreeze;
 
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
-		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-			err = -EAGAIN;
-			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-				__func__, lo->lo_number, lo->lo_file_name,
-				lo->lo_device->bd_inode->i_mapping->nrpages);
-			goto out_unfreeze;
-		}
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
-			err = -EFBIG;
-			goto out_unfreeze;
-		}
-	}
-
+	lo->lo_offset = info->lo_offset;
+	lo->lo_sizelimit = info->lo_sizelimit;
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1385,6 +1389,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	if (size_changed)
+		loop_set_size(lo, validated_size);
+
 	loop_config_discard(lo);
 
 	/* update dio if lo_offset or transfer is changed */
-- 
2.26.2.303.gf8c07b1a785-goog


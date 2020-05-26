Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F2B1D15E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388378AbgEMNjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbgEMNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:38:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF5C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e26so26578547wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYHviJVahcwDhxjEt/fmtYPaGxNJX7zxM8/7Ab1/oKM=;
        b=dszfHefJ/6wPpOkY6yHlMPpo9u0aofe27dyNCu9H6WbQusflK/2g2i5DPVgxFkOE99
         3+xMxns/IcbHbuMCigFsUYpwDw3rX3sIp8ehscd/3v5p9G+BjI7C4VBeTK3gYMJk/KXW
         3MZ0KCwEl0sTVTbSC8NB+XaxGsXkuXOlBrdOHdPpIAjGSj1zY7wVL4cX/hEVxnB32xRc
         8c2r8d9oaMeZhUNRjTK9OSv2OHUim6+JSg+lVAnh5raV5l5cz3AKeJgWDhlb5gVq5gfR
         Ergx+pbIVnchLIcwK340dlB/WGU1+K0U/KkNSKgRnzjYCPNfvu0mbnBgqI4KXL4R9I2r
         95IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYHviJVahcwDhxjEt/fmtYPaGxNJX7zxM8/7Ab1/oKM=;
        b=IHCcpra8MvVUq4LO5vmL/2rSeUTDAtHSr51QR/yPkwxlcEjCsBNrhGYwxoIcr60het
         9vjiO3EE4+r+5ht3O9JSZtgwrGDazvvKhOQrV/EuMAIY5bmMnhNZNRaOI94LAG1K1HlE
         yhGT2om1TD2dx9UYNB+kGirJkgT0bWvyOeY7IQDK2OisvBR9/thbrDBeJYLntYfZao/T
         leNfaVF3cGEJuI80nLJwYmr4yZRRPSYqPHSjxTOXNukimm9PbcSCCxEI/8CB14kcfpxm
         Q5C3j2JtXJLgBItPQKx8+7Rc/jUOfifOnfhFpWtF6KFMTJv5aLNLkIXkyju+opmdHLya
         r/1w==
X-Gm-Message-State: AOAM530ic8KAYqayKAb/G2k0VyfR9mccUPe33yLi/9ulX55xbAaX9bWN
        ulHX1u+VfB4gVm4P33yrAKaiqw==
X-Google-Smtp-Source: ABdhPJwro6lOehGpNJwWlMkVkHMVfZV3Yl8YDIn16VxTnE16IUWiZ8ilQmJMXdZrKUOXcKp3g5E6+w==
X-Received: by 2002:a1c:3187:: with SMTP id x129mr1800080wmx.27.1589377135614;
        Wed, 13 May 2020 06:38:55 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:54 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 05/11] loop: Refactor loop_set_status() size calculation
Date:   Wed, 13 May 2020 15:38:39 +0200
Message-Id: <20200513133845.244903-6-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
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
calculated size. This allows us to get rid of figure_loop_size() in a
follow-up commit.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d9a756f8abd5..c134b3439483 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -250,11 +250,6 @@ figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
 
-	if (lo->lo_offset != offset)
-		lo->lo_offset = offset;
-	if (lo->lo_sizelimit != sizelimit)
-		lo->lo_sizelimit = sizelimit;
-
 	loop_set_size(lo, size);
 }
 
@@ -1272,6 +1267,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool size_changed = false;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1293,6 +1289,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
+		size_changed = true;
 		sync_blockdev(lo->lo_device);
 		kill_bdev(lo->lo_device);
 	}
@@ -1300,6 +1297,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
@@ -1323,19 +1329,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
-		figure_loop_size(lo, info->lo_offset, info->lo_sizelimit);
-	}
-
+	lo->lo_offset = info->lo_offset;
+	lo->lo_sizelimit = info->lo_sizelimit;
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1359,6 +1354,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	if (size_changed) {
+		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
+					   lo->lo_backing_file);
+		loop_set_size(lo, new_size);
+	}
+
 	loop_config_discard(lo);
 
 	/* update dio if lo_offset or transfer is changed */
-- 
2.26.2.645.ge9eca65c58-goog


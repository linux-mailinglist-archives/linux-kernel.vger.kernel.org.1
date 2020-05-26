Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146751BDFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 16:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgD2ODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgD2ODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75DC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so2699473wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoJQjkbDBTvS6CFNLYXBcb580Ir6qHsMYFIGsSVt/dk=;
        b=ITfmWJKKpQF4vwJQgg3vHBkXHE0SUBFXOnZzX6K2D+4GdAQYvyJzC5trVgkBo+K47+
         TIcQX1Z+K/C5s1TNPsk/8WPZBxGpRyuS2Ol79xxwdA/FObD3HukuPGqH+1DFB/DKMKF4
         Qyw8YmKJpXwYH/TcFDtiPJzVccGPqBKDesdZ1vZIAKPNiL4FJ/Atzo50cdCUIOoRprO7
         mKcoWEvW7NWEjdmKfZJkoevt82+TbbWRIMvuW0Xux+Tf3LV3L5jTUmJ8AfHIqCC1zDC/
         RfULXfIBWninskSu0MfXNW2zhxdSpn1oigOJF420HWBBoWfnOr/9hWeV2b7Sjc1geqBW
         Fb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoJQjkbDBTvS6CFNLYXBcb580Ir6qHsMYFIGsSVt/dk=;
        b=DRMVxWmlIQT7MPkGHDO9BzyhCEBf18mdk4HIbT/aUV0NhNgU1q8EwzTlPYdchQDmnR
         rzrOU59eNRruoA5QJFhufKYCgoK/4kxeMzEcFtqdfxQB96YtN6UjdIXnxjcVTjtbB5YU
         Vcrg6TlFK7iGV6VGP6CQPUYue1DJ053ohkSMbE/rKXulz3tJCvPydVE0kJi1LA109LAs
         +/YTferloufFq8MpfjuO3Ff+HvmJWEw34+g8JQyJdck4F00znG4b6QQRbQ5aycOA/Efo
         y+M5ZSKHUfNtIWl/rj9yoos3ESAe18kIA4Dl5ClP8caFnLynId053Ix+97f2rFG79lyt
         nCEQ==
X-Gm-Message-State: AGi0PubEiQxlh+VtWiUtK5d3tWur8gVny+GIb/kfHl6lKkYzdq9PHh3k
        6CZtXkvKqjXeIPudEl3F3fhM1A==
X-Google-Smtp-Source: APiQypLdGhK29pFXm0dZ/bi2Kip6HNq6NAOpBoOKsa7X/fOmZscDthU9nK3s9w7zqMH2en3DTmnWNA==
X-Received: by 2002:adf:e84f:: with SMTP id d15mr41411225wrn.296.1588169030446;
        Wed, 29 Apr 2020 07:03:50 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:49 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 04/10] loop: Refactor loop_set_status() size calculation
Date:   Wed, 29 Apr 2020 16:03:35 +0200
Message-Id: <20200429140341.13294-5-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
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

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8f3194c2b8aa..9f5913879921 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -268,11 +268,6 @@ figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 	if (err)
 		return err;
 
-	if (lo->lo_offset != offset)
-		lo->lo_offset = offset;
-	if (lo->lo_sizelimit != sizelimit)
-		lo->lo_sizelimit = sizelimit;
-
 	loop_set_size(lo, size);
 
 	return 0;
@@ -1294,6 +1289,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool size_changed = false;
+	loff_t validated_size;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1315,6 +1312,13 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
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
@@ -1322,6 +1326,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
@@ -1345,22 +1358,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
@@ -1384,6 +1383,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	if (size_changed)
+		loop_set_size(lo, validated_size);
+
 	loop_config_discard(lo);
 
 	/* update dio if lo_offset or transfer is changed */
-- 
2.26.2.303.gf8c07b1a785-goog


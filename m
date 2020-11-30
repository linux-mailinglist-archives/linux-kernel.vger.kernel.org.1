Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430AA2C8EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgK3UTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbgK3UTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:19:52 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3008DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:19:12 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so10748029pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VF8drDHlv00stVHsRpzs7BYn02Hde8RQ2jqQjTTCfSc=;
        b=HZCavNRjexMelt8ao5frcCPxnO85Uz+rLGt5Hwi6Erznlat6xQHehizjoZj60LlMxh
         pmWjeHiBruzMSekh4IVwfuyioENAGbLXHTSOKHNoFq/OZgeeAvpQ3EB0kE7hVp9bGs2l
         2b0h32losiqA8DY49TGq0iVnAIb5UBb7Xe3WsAYjc1xjERSFG+YZaj8avqiMmmjp49Yy
         jXNGcYOUhbGClkMF8lH4tHPYgoAhn3g6B9+ELb13B4Z5MnCwsg49rMOcKLOdeJjxa3NU
         WXu4IuYlTAMvXjrFePary0KBeah2beM2Og2yWVrwRoVZ88n4mNc+hChvZKiFYimmZo74
         AzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VF8drDHlv00stVHsRpzs7BYn02Hde8RQ2jqQjTTCfSc=;
        b=Vxntwps+kbmfRGewXAMJ4rNX0oocf28awT0Ns1/WYJ/8Xe5dYi/zfBmWKovtjVufeE
         p8fcw0y+xRaOD7ou68Sf2I6oZXsvLje9GnuhC/9C9c4eJkCgmubnxjX62zFELo2MAtwS
         NEgDLqj9joA7vrXNE0EdLNw2fG+8Id3kghEYVXJvVdDHvRhJazuvWpEVmxOg6crHZYdX
         lvN2YzwGB5uMnLgzJ4GAC6t2g+mr8iRJWohNTJeSAxzPAvvyTQqv0Pn4DOC4RblIGwbk
         3N1hHY+0ZV5y5tfFL3VVFf1iniXULXH1m+zpQMous3MkUVmfRwidiZ/0E+H75SNGSZTk
         R+FQ==
X-Gm-Message-State: AOAM530Liro2JCa1bMbbgURd3FWkuegn0bz+h3mPZkJEWjcnTGsdEIil
        z1J6SeIF2Pd+q+zwxVSghMpsBDspOzw=
X-Google-Smtp-Source: ABdhPJy91RVVxb+HbhIrvFxypcJY9tBbfc1V54sg7SGT4S/UixMOdU5buDXJOijz73owGeSIm2Uvyg==
X-Received: by 2002:a62:8244:0:b029:198:1f1:7384 with SMTP id w65-20020a6282440000b029019801f17384mr19906066pfd.27.1606767551709;
        Mon, 30 Nov 2020 12:19:11 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id q188sm18121610pfc.204.2020.11.30.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 12:19:10 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] zram: add stat to gather incompressible pages since zram set up
Date:   Mon, 30 Nov 2020 12:19:07 -0800
Message-Id: <20201130201907.1284910-1-minchan@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, zram supports the stat via /sys/block/zram/mm_stat to
represent how many of incompressible pages are stored at the
moment but it couldn't show how many times incompressible pages
were wrote down since zram set up. It's also good indication to
see how zram is effective in the system.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 1 +
 drivers/block/zram/zram_drv.c               | 6 ++++--
 drivers/block/zram/zram_drv.h               | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 8f3cfa42e443..03f1105b21b7 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -266,6 +266,7 @@ The mm_stat file represents the device's mm statistics. It consists of a single
                   No memory is allocated for such pages.
  pages_compacted  the number of pages freed during compaction
  huge_pages	  the number of incompressible pages
+ huge_pages_since the number of incompressible pages since zram set up
  ================ =============================================================
 
 File /sys/block/zram<id>/bd_stat
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 23350210a2a2..ac4d19f6571c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1084,7 +1084,7 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = scnprintf(buf, PAGE_SIZE,
-			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu\n",
+			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
 			mem_used << PAGE_SHIFT,
@@ -1092,7 +1092,8 @@ static ssize_t mm_stat_show(struct device *dev,
 			max_used << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.same_pages),
 			pool_stats.pages_compacted,
-			(u64)atomic64_read(&zram->stats.huge_pages));
+			(u64)atomic64_read(&zram->stats.huge_pages),
+			(u64)atomic64_read(&zram->stats.huge_pages_since));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1424,6 +1425,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	if (comp_len == PAGE_SIZE) {
 		zram_set_flag(zram, index, ZRAM_HUGE);
 		atomic64_inc(&zram->stats.huge_pages);
+		atomic64_inc(&zram->stats.huge_pages_since);
 	}
 
 	if (flags) {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f2fd46daa760..9cabcbb13fd9 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -78,6 +78,7 @@ struct zram_stats {
 	atomic64_t notify_free;	/* no. of swap slot free notifications */
 	atomic64_t same_pages;		/* no. of same element filled pages */
 	atomic64_t huge_pages;		/* no. of huge pages */
+	atomic64_t huge_pages_since;	/* no. of huge pages since zram set up */
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t writestall;		/* no. of write slow paths */
-- 
2.29.2.454.gaff20da3a2-goog


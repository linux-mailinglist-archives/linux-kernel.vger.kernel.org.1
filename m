Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDE72942B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437957AbgJTTFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437949AbgJTTFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:05:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CEFC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 12:05:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so1675510pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2ZqWow8HRIkJyo+W9SXArDFdNcU7b2V3YgBH9W/8Ko=;
        b=kH1F/IOZOat9tp+6kejh3wQLEnMUQ4JBLAt0+dqaGyGs+/+iRhidNUoBCEnuDGm0Te
         YrXHuscDljT1HnBa+SCaPoXJRh/9MopkVumzUnWKRuNkwmW3ljZTXBBM9lqJpDaHCbRL
         Nt0xKQEkR/x4fx/5Pq/XrwDx124EXXFLwyVCoD1WxUVTiVd68S0flh7CX/pH0XP5FJhR
         CUpPHJnCPLfDwfJWHeL7xOyXRfr8mN9KeCU/hYiUL8mgILHEeWOueaUKiSp9Akxw0Us5
         YtrPAX1H4BYbFVX4KXyAOcutDn2hgbH8BlxsN3Gy6X6WbYBbNE7m+5dapfBqdSPeuXIB
         n31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=N2ZqWow8HRIkJyo+W9SXArDFdNcU7b2V3YgBH9W/8Ko=;
        b=k/M6wo5ql1J0SenjkvZOZ6zC+7iJFJ+/y8kZriTZpDL0uC9e33ohscsr2AVncqk6px
         WiKx6jSm91//T4hnw6MSq/n5n4r2+tipKWh10MTkljT3FiyceU0RrnMWaIfJnQ3BFhOH
         rSskR5u+peAqhwsNtAY0lKStZD1odJ9VXis6skY3Fm5Tq8xgKnI6vhUkW1VhGtl2m1CE
         sNl5IYVLKH0ZsdVYbQzIEMo7MnxzR/raw+BFBT/zhFG1Z0J30gZZ4/udhAidC7MbLFWP
         Jsy3uPsltpBAsVZVlZmM2HDsGNbfWX1UTZsRMs2jnUprmCurNxjxpbrZVR7c5HQ/uKMK
         gkzg==
X-Gm-Message-State: AOAM532NL95nzWztWHJNp4gsLtqUmvSqJC3q9dk/IXkPRIyIv7TZgwu3
        DX9QcJ/xbt8Q23tjxoajETmm0u+WOr4=
X-Google-Smtp-Source: ABdhPJzegZvuGf39JTQUWxrDX5k717bkJCAvm7WGt9ISWneVy3YHSitAq8EvB0LtoeDRvxvwKKLJxA==
X-Received: by 2002:a63:cc08:: with SMTP id x8mr3819948pgf.229.1603220711829;
        Tue, 20 Oct 2020 12:05:11 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id 186sm2969879pfv.154.2020.10.20.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 12:05:10 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, rajekumar@google.com,
        amosbianchi@google.com, joaodias@google.com,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH v2] zram: support a page writeback
Date:   Tue, 20 Oct 2020 12:05:06 -0700
Message-Id: <20201020190506.3758660-1-minchan@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a demand to writeback specific pages on process to backing store
instead of all idles pages in the system due to storage wear out concern
and launching latency of apps which are most of time idle but critical
for resume latency.

This patch extends the writeback knob to support a specific page
writeback.

Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---

* from v1
  * use "page_index=" signature for future extension - Sergey

 Documentation/admin-guide/blockdev/zram.rst |  5 +++++
 drivers/block/zram/zram_drv.c               | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index a6fd1f9b5faf..8f3cfa42e443 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -334,6 +334,11 @@ IOW, unless there is access request, those pages are still idle pages.
 
 With the command, zram writeback idle pages from memory to the storage.
 
+If admin want to write a specific page in zram device to backing device,
+they could write a page index into the interface.
+
+	echo "page_index=1251" > /sys/block/zramX/writeback
+
 If there are lots of write IO with flash device, potentially, it has
 flash wearout problem so that admin needs to design write limitation
 to guarantee storage health for entire product life.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9100ac36670a..1e542008e798 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -618,15 +618,19 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 	return 1;
 }
 
+#define PAGE_WB_SIG "page_index="
+
+#define PAGE_WRITEBACK 0
 #define HUGE_WRITEBACK 1
 #define IDLE_WRITEBACK 2
 
+
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	unsigned long index;
+	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
 	struct page *page;
@@ -638,8 +642,17 @@ static ssize_t writeback_store(struct device *dev,
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
 		mode = HUGE_WRITEBACK;
-	else
-		return -EINVAL;
+	else {
+		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
+			return -EINVAL;
+
+		ret = kstrtol(buf + sizeof(PAGE_WB_SIG) - 1, 10, &index);
+		if (ret || index >= nr_pages)
+			return -EINVAL;
+
+		nr_pages = 1;
+		mode = PAGE_WRITEBACK;
+	}
 
 	down_read(&zram->init_lock);
 	if (!init_done(zram)) {
@@ -658,7 +671,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	for (index = 0; index < nr_pages; index++) {
+	while (nr_pages--) {
 		struct bio_vec bvec;
 
 		bvec.bv_page = page;
-- 
2.29.0.rc1.297.gfa9743e501-goog


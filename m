Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B783028AEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgJLHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgJLHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:14:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:14:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so12673530pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voHKNAssXNw9vnKZaykx1vJ0T4rWcYqgKRYhLJMv1IE=;
        b=ArUu/VtHIYUrkOZ2i/FyJKEKjN7S8A7QedOWhfig5cEkifdYWtZz3CQg4DXS8CvzR/
         /p5DeMQpUc+vy45GcGD5deuC37Vdm5ZHNVKGn2dXuGsd8xPjwmne65j8w3pb045K5UNh
         RRWRvqED7CZRI4Z6kRshAyo/U8sJor9jEFv84wl7lV16hnvUDRwyd1/tf5pM5LWscq9+
         crEHJttmxZL+CC65tcoj2Tj4+4u9fsGJ2BuprnfTOXSapDFEIiSGsW9ymNVugho5U2M6
         XGtizfzf4MO087SdfcclEENUw4RH2i1EypPCnKOstDgbyZOq6td5fGKvEbMTwVP2hOpf
         Vp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=voHKNAssXNw9vnKZaykx1vJ0T4rWcYqgKRYhLJMv1IE=;
        b=rGzH5YHlY1qV0aLYs+zFqlO7SVwFg/nLC6HQtnhAkAIav2ee9hzOxfMDARjHtmtt0M
         XZJC4wbJHHkmBSPxkYlrOFsp3GJI3ulSXoAV2XfOamsfqvHlPhbEeOak8la95K7pr7kQ
         TofXkr+fkEtDMsJwB+62M5zw258v1Kc17jVSsSR64kKYCyn1x8E1vGQfDGbJA4mtNWb5
         D93Tj+NkNyrGJD/AHZ8QLey71Ht3YMWAxoqsNEmX+b8T6g2ULNUelDI3NFYMQZ5c4kFB
         PpHpztpw9S/cnIgIpri6IQAMOe0taZ/6UJnSPzwnJ3Jq5V2ntp0eXmFFlYJMRedlNC7A
         hiGg==
X-Gm-Message-State: AOAM532lDOAW9UCc8LIma7zuLXsDnvXvmGGkX+lxxIL53G6RjdV2A1VU
        UG4qHqyVqHyoYEiKMKGbR2A=
X-Google-Smtp-Source: ABdhPJy6XT6jq/GzR2rgYJdMQHVLKNRq1wSwR1psr/cmh7RHnfJ385iJLxmPefPO9husbIY/L/AsZw==
X-Received: by 2002:a63:cf10:: with SMTP id j16mr2976029pgg.66.1602486897947;
        Mon, 12 Oct 2020 00:14:57 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id t10sm22112469pjr.37.2020.10.12.00.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:14:56 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rajekumar@google.com,
        amosbianchi@google.com, joaodias@google.com,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCH] zram: support a page writeback
Date:   Mon, 12 Oct 2020 00:14:52 -0700
Message-Id: <20201012071452.1613131-1-minchan@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a demand to writeback specific pages on process to backing store
instead of all idles pages in the system due to storage wear out concern
and launching latency of apps which are most of time idle but critical
for resume latency.

This patch extend writeback knob to support specific page writeback.

Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  5 +++++
 drivers/block/zram/zram_drv.c               | 14 ++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index a6fd1f9b5faf..f9ce26759906 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -334,6 +334,11 @@ IOW, unless there is access request, those pages are still idle pages.
 
 With the command, zram writeback idle pages from memory to the storage.
 
+If admin want to write a specific page in zram device to backing device,
+they could write the page index into the interface.
+
+	echo 1251 > /sys/block/zramX/writeback
+
 If there are lots of write IO with flash device, potentially, it has
 flash wearout problem so that admin needs to design write limitation
 to guarantee storage health for entire product life.
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9100ac36670a..00c194227d89 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -618,6 +618,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 	return 1;
 }
 
+#define PAGE_WRITEBACK 0
 #define HUGE_WRITEBACK 1
 #define IDLE_WRITEBACK 2
 
@@ -626,7 +627,7 @@ static ssize_t writeback_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	unsigned long index;
+	unsigned long index = 0;
 	struct bio bio;
 	struct bio_vec bio_vec;
 	struct page *page;
@@ -638,8 +639,13 @@ static ssize_t writeback_store(struct device *dev,
 		mode = IDLE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge"))
 		mode = HUGE_WRITEBACK;
-	else
-		return -EINVAL;
+	else {
+		ret = kstrtol(buf, 10, &index);
+		if (ret || index >= nr_pages)
+			return -EINVAL;
+		nr_pages = 1;
+		mode = PAGE_WRITEBACK;
+	}
 
 	down_read(&zram->init_lock);
 	if (!init_done(zram)) {
@@ -658,7 +664,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	for (index = 0; index < nr_pages; index++) {
+	while (nr_pages--) {
 		struct bio_vec bvec;
 
 		bvec.bv_page = page;
-- 
2.28.0.1011.ga647a8990f-goog


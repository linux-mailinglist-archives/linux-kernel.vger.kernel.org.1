Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E062743BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:00:03 -0400
Received: from verein.lst.de ([213.95.11.211]:44774 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgIVOAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:00:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2652968AFE; Tue, 22 Sep 2020 15:59:57 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:59:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200922135956.GA23437@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916153605.5253-1-ztong0001@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tong,

can you test this patch?

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c3148c..6473ae703789e4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -836,6 +836,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * so that it sticks around as long as @disk is there.
 	 */
 	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	disk->flags |= GENHD_FL_QUEUE_REF;
 
 	disk_add_events(disk);
 	blk_integrity_add(disk);
@@ -1567,7 +1568,7 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
 	hd_free_part(&disk->part0);
-	if (disk->queue)
+	if (disk->flags & GENHD_FL_QUEUE_REF)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff25..9441077ee10329 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -135,6 +135,7 @@ struct hd_struct {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_QUEUE_REF			0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */

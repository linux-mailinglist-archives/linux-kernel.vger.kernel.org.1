Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5A275083
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIWF5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:57:30 -0400
Received: from verein.lst.de ([213.95.11.211]:47272 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWF53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:57:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E41F668AFE; Wed, 23 Sep 2020 07:57:25 +0200 (CEST)
Date:   Wed, 23 Sep 2020 07:57:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200923055725.GA15442@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com> <20200922135956.GA23437@lst.de> <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com> <20200922164154.GA1894@lst.de> <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect the patch below might be better.  Can you send me a full dmesg
with this one applied?  Preferably on top of Jens' for-next branch?


diff --git a/block/genhd.c b/block/genhd.c
index 9d060e79eb31d8..ef2784c69d59ee 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -832,7 +832,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * Take an extra ref on queue which will be put on disk_release()
 	 * so that it sticks around as long as @disk is there.
 	 */
-	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	WARN_ON_ONCE(blk_queue_dying(disk->queue));
+	__blk_get_queue(disk->queue);
+	disk->flags |= GENHD_FL_QUEUE_REF;
 
 	disk_add_events(disk);
 	blk_integrity_add(disk);
@@ -1564,7 +1566,7 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
 	hd_free_part(&disk->part0);
-	if (disk->queue)
+	if (disk->flags & GENHD_FL_QUEUE_REF)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 1c97cf84f011a7..822a619924e3b5 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -133,6 +133,7 @@ struct hd_struct {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_QUEUE_REF			0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */


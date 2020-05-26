Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F431C3A93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 14:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEDM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729190AbgEDM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:57:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD9C061A0E;
        Mon,  4 May 2020 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yfeUTjXE/VV6zru1iWNQUFLr/Lkg8t0dzNP3qOAM3rQ=; b=cAfbTZsmeD3RDAa71g8xb62Vh7
        JJZHUDaed9xjSZPaDPumeJNdX/o636vf16EXoHZFhnSzLBrq6XjHvbfonX9sIDcc/lCBnXtaoYr6+
        F+7uoAWFx68ug+wKblLDWz42PCAhg0lUqAM6e3ROL7aZr9/a1kIjGYHEjQT4wtVlUf0HDE96bLOQr
        yFHYvnYjMuYtiW8fpzo8QAjbWd9Zz9mI6MBOK3ot1GGxjpFUxfA7t2aIIHXFWL+iaZQqVO3Sy0/Z4
        DoJ71SSpD6zP6T8qKLnjc5BInbJl8qbgtddpB+duBYyJvfryJn2pHyEBxSMqiUSI9kqyriZ95mB+z
        v49vwe9A==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaej-0007jh-Pq; Mon, 04 May 2020 12:57:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] bdi: remove the name field in struct backing_dev_info
Date:   Mon,  4 May 2020 14:48:01 +0200
Message-Id: <20200504124801.2832087-10-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name is only printed for a not registered bdi in writeback.  Use the
device name there as is more useful anyway for the unlike case that the
warning triggers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c                 | 1 -
 drivers/mtd/mtdcore.c            | 1 -
 fs/fs-writeback.c                | 2 +-
 fs/super.c                       | 2 --
 include/linux/backing-dev-defs.h | 2 --
 mm/backing-dev.c                 | 1 -
 6 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 285a2f8ee8d3a..538cbc725620b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -511,7 +511,6 @@ struct request_queue *__blk_alloc_queue(int node_id)
 
 	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
-	q->backing_dev_info->name = "block";
 	q->node = node_id;
 
 	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 39ec563d9a14b..fcb018ce17c3d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2040,7 +2040,6 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
 	if (!bdi)
 		return ERR_PTR(-ENOMEM);
 
-	bdi->name = name;
 	/*
 	 * We put '-0' suffix to the name to get the same name format as we
 	 * used to get. Since this is called only once, we get a unique name. 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec7..d85323607b49f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2320,7 +2320,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
 
 			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
 			     !test_bit(WB_registered, &wb->state),
-			     "bdi-%s not registered\n", wb->bdi->name);
+			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
 
 			inode->dirtied_when = jiffies;
 			if (dirtytime)
diff --git a/fs/super.c b/fs/super.c
index dd28fcd706ff5..4991f441988e0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1602,8 +1602,6 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	if (!bdi)
 		return -ENOMEM;
 
-	bdi->name = sb->s_type->name;
-
 	va_start(args, fmt);
 	err = bdi_register_va(bdi, fmt, args);
 	va_end(args);
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2849bdbb3acbe..011bb8ad0738a 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -194,8 +194,6 @@ struct backing_dev_info {
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
 	void *congested_data;	/* Pointer to aux data for congested func */
 
-	const char *name;
-
 	struct kref refcnt;	/* Reference counter for the structure */
 	unsigned int capabilities; /* Device capabilities */
 	unsigned int min_ratio;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 1f55d5b8269ff..d382272bcc310 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -15,7 +15,6 @@
 #include <trace/events/writeback.h>
 
 struct backing_dev_info noop_backing_dev_info = {
-	.name		= "noop",
 	.capabilities	= BDI_CAP_NO_ACCT_AND_WRITEBACK,
 };
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
-- 
2.26.2


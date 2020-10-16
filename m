Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E8A290658
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408070AbgJPNb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408054AbgJPNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:31:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE96C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+NkbxqmYZkb3NvJTMPdsdcushUdMVZQRBEUzMmtHWk8=; b=uQjZ6R/TzgscHJ8tmNGZKQJCHg
        eD7wfjH4jqdCszcLHnK7RLgnIyIFUmWoVF5Ergpqw1VS2gnc4m51BuaqTJ9F77AwaWl53TR9LtSsY
        OBd5nic8mwUHSu30wbMYWOWxR6vgHB46uDVASQN2TNe9VXBW1GJVrmyjvrdSKVi/o7Ua1/IThwtFA
        y37trwOis4fFELclJ6Q7/nB7iqVymZwwXjsggblzEUx7sn3XV0RuQPYvhTOM9VSzukD+GXsrbQrex
        kavZaG/12oaErh9ScSPnXaLNPedf8Tvsm7aaErFJvW1wL5Wos3pCsa+/5X3Ecrwu8zsHvSSG4NsP3
        6lZfYebw==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTPpj-0003ON-7X; Fri, 16 Oct 2020 13:31:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] pstore/blk: remove __unregister_pstore_blk
Date:   Fri, 16 Oct 2020 15:20:42 +0200
Message-Id: <20201016132047.3068029-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold __unregister_pstore_blk into its only caller, and merge the
two identical calls to __unregister_pstore_device that exist in the
caller now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/pstore/blk.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index 7f8368e94b3604..3a2214ecf942ae 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -388,19 +388,6 @@ static int __register_pstore_blk(void)
 	return ret;
 }
 
-static void __unregister_pstore_blk(unsigned int major)
-{
-	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
-	void *holder = blkdev;
-
-	lockdep_assert_held(&pstore_blk_lock);
-	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
-		__unregister_pstore_device(&dev);
-		psblk_put_bdev(psblk_bdev, holder);
-		psblk_bdev = NULL;
-	}
-}
-
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
 {
@@ -430,16 +417,14 @@ late_initcall(pstore_blk_init);
 
 static void __exit pstore_blk_exit(void)
 {
+	struct pstore_device_info dev = { };
+
 	mutex_lock(&pstore_blk_lock);
+	if (pstore_zone_info)
+		dev.read = pstore_zone_info->read;
+	__unregister_pstore_device(&dev);
 	if (psblk_bdev)
-		__unregister_pstore_blk(MAJOR(psblk_bdev->bd_dev));
-	else {
-		struct pstore_device_info dev = { };
-
-		if (pstore_zone_info)
-			dev.read = pstore_zone_info->read;
-		__unregister_pstore_device(&dev);
-	}
+		psblk_put_bdev(psblk_bdev, blkdev);
 	mutex_unlock(&pstore_blk_lock);
 }
 module_exit(pstore_blk_exit);
-- 
2.28.0


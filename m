Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3548E290678
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408358AbgJPNmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407357AbgJPNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:42:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB59C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dVC+oPNA4c4mlsDL++B4TVjVYz10iLER5z4ZQesiGIY=; b=eM5+C5kRXJ1pfqMo0qB9WLz0z5
        8dh75k//TeG5yIjspl6X93BYUz5CLSa9qfBJWZ3ma7NQJPp+xNm67JpmdMICr4sJ6iiQzyl9GD2Hq
        e9iJznKdcEopyPWYwulpYQ5WkxmVm3R/mgbAKqDLvHEMN7M0Tz+jUk3eKNPpUr8PhMekss2oyHOaK
        KAjfTQZDKnfCfoLFl8yLovCOABYZTdEJ7qqK1tXtSdhFMORb0foC6ryu9BS0AeQJSLDwVrGwxStHD
        afpFddoHmlo0aB5QiQWcNjlw3WU6ysnliFXf8taqpAuAXnH62oaEvU21X1FLCncYOZF69wjnPuGuD
        2W5996iA==;
Received: from 213-225-9-134.nat.highway.a1.net ([213.225.9.134] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTQ0K-00042I-JW; Fri, 16 Oct 2020 13:42:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] pstore/blk: don't depend on CONFIG_BLOCK
Date:   Fri, 16 Oct 2020 15:20:47 +0200
Message-Id: <20201016132047.3068029-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore-blk contains of two different layers:

 a) a tiny layer of sugar coating ontop of pstore-zone.  This part has
    no dependencies on the block layer, and can be used e.g. by mtd
 b) an implementation of a default fallback pstore zone backend for
    block devices

Add an ifdef for the latter so that pstore-blk itself does not have to
depend on CONFIG_BLOCK.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/pstore/Kconfig | 2 +-
 fs/pstore/blk.c   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index e16a49ebfe546d..6eadb538316e52 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -164,7 +164,7 @@ config PSTORE_ZONE
 config PSTORE_BLK
 	tristate "Log panic/oops to a block device"
 	depends on PSTORE
-	depends on BLOCK
+	depends on BLOCK || !BLOCK
 	select PSTORE_ZONE
 	default n
 	help
diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index bd4eadfc9bd795..d3d25edb943cdd 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -182,6 +182,7 @@ void unregister_pstore_device(const struct pstore_zone_ops *ops)
 }
 EXPORT_SYMBOL_GPL(unregister_pstore_device);
 
+#ifdef CONFIG_BLOCK
 static struct file *psblk_file;
 
 static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
@@ -269,6 +270,7 @@ void __init pstore_blk_early_init(void)
 	__pstore_blk_init(devname);
 }
 #endif /* MODULE */
+#endif /* CONFIG_BLOCK */
 
 /* get information of pstore/blk */
 int pstore_blk_get_config(struct pstore_blk_config *info)
-- 
2.28.0


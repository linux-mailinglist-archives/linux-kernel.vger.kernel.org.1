Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4663D2FDCF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 00:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbhATVaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 16:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732673AbhATU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 15:56:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79901C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Jq1AAcRji3sbt9HJxWuOiHht6rg3mfcahgRhwBI4yn8=; b=JIgRKiG/OQYN3hrSSsRSF+ijyL
        CGVR1TPnyT+bFfVTZgkirRWLJRrErV1D+kvJHUgee5RZmYqDBUynSbUB6MWdi+14ld68owH3HnsYp
        UWcX9DH8bdciQtloq+aGAOLai0y4nE7zyVcglyqVo+csUXWNiTfropiQD7x8EvqY3HwLT9O4qAoxs
        qb5eBJH9JOLd39fXQs6W06op1AA2hbHpXyiffQ9Am8v5azr4NzTQSF8VatjGx2AsxpI1LdjGXyYjN
        1qo1O0t3QRosHMLCjOvNK6j6Jc0TTzbMv3yrSy6Yu743eSCKt9fy6x/mI+BrI0dNahfqo6aoNksXb
        IUtKoXtQ==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2KVP-00GCon-LY; Wed, 20 Jan 2021 20:55:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kernfs: wire up ->splice_read and ->splice_write
Date:   Wed, 20 Jan 2021 21:46:31 +0100
Message-Id: <20210120204631.274206-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120204631.274206-1-hch@lst.de>
References: <20210120204631.274206-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the splice_read and splice_write methods to the default
helpers using ->read_iter and ->write_iter now that those are
implemented for kernfs.  This restores support to use splice and
sendfile on kernfs files.

Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Reported-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 fs/kernfs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index b1a5cccf189ec7..c7571931214751 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -949,6 +949,8 @@ const struct file_operations kernfs_file_fops = {
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 };
 
 /**
-- 
2.29.2


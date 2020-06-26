Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03B20ADB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgFZICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgFZICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:18 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE35C08C5C1;
        Fri, 26 Jun 2020 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ni2URhuc9te1qeMjNRucMQFs47oTeEDvY2kr+szm/Yg=; b=Tr0LpnC7W1v9s1FvHEZkSOLj0W
        NItkNofirCBDVRZ5XMw3Av7I6IdfdW8I9+n02PGXDDLCN+UFz3mG5DFSdSsQkoyOZ9Y+Rs9wXecOP
        eKH+GBFWgUWGxvbal5jSufk7DcCzzalQoA484KQUTuu4T2Ii3NS4ajO2+QeN/2WAZ57dqm43D1CbW
        oL12VARay11IIizloJRjw3oQHmBmQsG3WyB5S1bPF7dg73zAtR6bMP8DWF9u9vGfUi8OaNSzoaUC6
        Y/WvmZGPZ1RvIjxNuPfP7d2JJa58vRxiIDe6S57of3W1/WuHl3GMaH7LQM85F59XDNWj3Zl4TQxpT
        Fzfuu9Kg==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJB-0007UF-JD; Fri, 26 Jun 2020 08:02:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dcssblk: don't set bd_block_size in ->open
Date:   Fri, 26 Jun 2020 10:01:53 +0200
Message-Id: <20200626080158.1998621-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
References: <20200626080158.1998621-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bd_block_size contains a value that matches the logic block size when
opening, so the statement is redundant.  Even if it wasn't the dumb
assignment would cause a a mismatch with bd_inode->i_blkbits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dcssblk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 384edffe5cb4ae..9c22c6078a4662 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -833,7 +833,6 @@ dcssblk_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 	}
 	atomic_inc(&dev_info->use_count);
-	bdev->bd_block_size = 4096;
 	rc = 0;
 out:
 	return rc;
-- 
2.26.2


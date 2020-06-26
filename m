Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF920ADBD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgFZICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgFZICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:25 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7CFC08C5C1;
        Fri, 26 Jun 2020 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fikc6nDJBnapn/gvMFVI+fD2hAoS13bz5dg08VzBCZU=; b=Y9/ALGJUTvdXtWSkpKPJm6MmT9
        xrZ10E/+WGdPXyl4Q5xJ+RF2+E4+hF6zgCqLibmNbzY3o6S6BkUnKFxkM95p3g5GukPV7/LiizxJw
        CFkLFG8RFhW4wJ0K13YwbctmG0W6ZXit9ZO6dp/durhVredHL8JEUa4XPJ8V+sVUmBpy1BrNUtrLs
        6rGm/wi4HgxlwTvs+qP7n42rwJ3LT3fbtMamMS+s40qH4M3nRkzdpzAWWAFBPmVRrybRMOhhN1/cO
        GRAhqPPzS2cq3Xi7k11bPypzFt51fjxzYcX6OYAcArg/RgAmcv515e66oMM5Vt4U3ejmvgjOZ5lfU
        EnFgOUEw==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJG-0007Ue-6K; Fri, 26 Jun 2020 08:02:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] block: remove the unused bd_private field from struct block_device
Date:   Fri, 26 Jun 2020 10:01:57 +0200
Message-Id: <20200626080158.1998621-7-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk_types.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 667cd365fd048b..b5f7105806e492 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -41,13 +41,6 @@ struct block_device {
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
 	struct list_head	bd_list;
-	/*
-	 * Private data.  You must have bd_claim'ed the block_device
-	 * to use this.  NOTE:  bd_claim allows an owner to claim
-	 * the same device multiple times, the owner must take special
-	 * care to not mess up bd_private for that case.
-	 */
-	unsigned long		bd_private;
 
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D7C1AB983
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438750AbgDPHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438570AbgDPHPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:15:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86987C061A0C;
        Thu, 16 Apr 2020 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+5BINXK9PAjIhqU0RrpkNqj3CbzVmlQD+PhrrErxT6c=; b=QabuAhhghfUDIg53lru/d9Gcxz
        e18VSjg/kbDD9QduuaNz0nBUOZDFelrPQzIBX9UHtG76rt9cp0GNgdpKgeXHSM8CS115MJVt8YsTu
        IoNx/8b1Blk+teJmzcKeGvkA7qPpijKwhKohs/OPOUavhtjb1zMAtTFmCrc1RpndHMsTOudh8Ul3R
        Xepe9ViuR70Rs/IWFlCrNbM9NL9045/9z9wjDjBBp5nCapfr5JLOXOOddujB+1F4i0c9fBY9b5CcK
        ynH/NIouFtVEIZnz4La3FK6swhnsKmcKBNml/cX5HQr++TxMsfCZIbz/eGWSdsWbrcMh/uqTWZe8f
        QVR6VJNQ==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOykK-0003LJ-3g; Thu, 16 Apr 2020 07:15:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] bdi: unexport bdi_register_va
Date:   Thu, 16 Apr 2020 09:15:16 +0200
Message-Id: <20200416071519.807660-6-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416071519.807660-1-hch@lst.de>
References: <20200416071519.807660-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bdi_register_va is only used by super.c, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/backing-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4f6c05df72f9..a7eb91146c9c 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -969,7 +969,6 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	trace_writeback_bdi_register(bdi);
 	return 0;
 }
-EXPORT_SYMBOL(bdi_register_va);
 
 int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
 {
-- 
2.25.1


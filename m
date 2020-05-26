Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F51ACE26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbgDPQ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732738AbgDPQzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:55:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B9C061A0C;
        Thu, 16 Apr 2020 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KoJmgqHpmX6zU7KpciYmluiSy+75nxEhElP5EeA6Vu4=; b=cxq2jD2Yinw6l0Z2djBRqMtrMe
        heDCobTYc+L4izORZGT1OboHgGPPbbaLygtuYgR1elo5rJeb0fLD0qsk6EBfSQh6i61GgV8wWck5Z
        Dp+b1p1yt0bNEGEL+85mc99I7lRX3XPtpmFqTirg4RxEb3QsrY7TmtEUcXFr4dVjpQts7RM24xmAE
        b+5FURFVIqTAVduwNHxs7VsbiCPuB8OYTEwO3QP+eXN6xCmtJ1ArL0bRhUBwN+KDruUEn+aqi+GBz
        2M71wzewyuY3IJFUDbE/CXJeJE8oXW0X40K2Pdj2Lbp91fm6C1QMaSforYHdNwj7YLlCK4wN+bNsl
        tCexGoig==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP7nA-0003A1-1v; Thu, 16 Apr 2020 16:55:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] bdi: unexport bdi_register_va
Date:   Thu, 16 Apr 2020 18:54:50 +0200
Message-Id: <20200416165453.1080463-6-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416165453.1080463-1-hch@lst.de>
References: <20200416165453.1080463-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bdi_register_va is only used by fs/super.c, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/backing-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index efc5b83acd2d..eb6b51e49d11 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -964,7 +964,6 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	trace_writeback_bdi_register(bdi);
 	return 0;
 }
-EXPORT_SYMBOL(bdi_register_va);
 
 int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
 {
-- 
2.25.1


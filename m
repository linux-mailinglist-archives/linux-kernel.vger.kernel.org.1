Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E171C39EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgEDMwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:52:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA806C061A0E;
        Mon,  4 May 2020 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GfJuSGyXUClgvnKBcUK8rFK0n5oq7x9a4bEEtz7lf0Y=; b=AXmYz8lKvqUFtLzG6o8kRW/Mzq
        jriCqEH1FIVNyObxmika0sQ8O2waryQX35M1c8hSaux9HrAaZ2OJIuoxy5rTm/cl5SMHJmFYWO4kL
        B1g/E4bCcA9Uixf1oJ6aED3j6kw5rk77GZoh1775gphYGljGwF+3ykD9RLyHQ+90WtXuw697Ngs3v
        gEjxs/wy79Ldh2WkrhfkS/nDkNZUz4bWHzyYjzmrPq5ZmPVPGDMqDUOQTPGsrAHxG0kPLvlhJIkOT
        zCSUfABd7HuM1DRW3VoF8TT5bAsIohKBME708F/pIfCXM7BcOdM7HYxENeT71mnfNaVlka8MBqiv8
        aeSJM2mw==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaaA-0001oB-WF; Mon, 04 May 2020 12:52:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] vboxsf: don't use the source name in the bdi name
Date:   Mon,  4 May 2020 14:47:53 +0200
Message-Id: <20200504124801.2832087-2-hch@lst.de>
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

Simplify the bdi name to mirror what we are doing elsewhere, and
drop them name in favor of just using a number.  This avoids a
potentially very long bdi name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 fs/vboxsf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 675e269893765..8fe03b4a0d2b0 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -164,7 +164,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto fail_free;
 	}
 
-	err = super_setup_bdi_name(sb, "vboxsf-%s.%d", fc->source, sbi->bdi_id);
+	err = super_setup_bdi_name(sb, "vboxsf-%d", sbi->bdi_id);
 	if (err)
 		goto fail_free;
 
-- 
2.26.2


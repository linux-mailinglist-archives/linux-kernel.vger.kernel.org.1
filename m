Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32F71DE986
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgEVOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 10:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgEVOrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:47:53 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF072053B;
        Fri, 22 May 2020 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158873;
        bh=raIADVb+UkJizyoPCsxQYw2PqWtp3N/rKlscrbRCbvA=;
        h=From:To:Cc:Subject:Date:From;
        b=iAs/omKsTX5z+jiiD65a/OkLhPepFhPVXOx2g9S8IzcljenaPbcmpjB8cIfulkdSm
         EbBPQtg2cSC5B+rdA56mJgRkjrf3f+Fb4szcJjwV5gyKuEz+9g87jgcWHaInrf70cc
         q6RfPSavSO+bQgoELw3dQI9T8ZAu+e8dUj5JgmrE=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid inifinite loop to wait for flushing node pages at cp_error
Date:   Fri, 22 May 2020 07:47:52 -0700
Message-Id: <20200522144752.216197-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shutdown test is somtime hung, since dirty node pages weren't flushed out.
Let's drop dirty pages at umount after shutdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e632de10aedab..8c63964a82fd0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	trace_f2fs_writepage(page, NODE);
 
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
+			dec_page_count(sbi, F2FS_DIRTY_NODES);
+			up_read(&sbi->node_write);
+			unlock_page(page);
+			return 0;
+		}
 		goto redirty_out;
+	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
-- 
2.27.0.rc0.183.gde8f92d652-goog


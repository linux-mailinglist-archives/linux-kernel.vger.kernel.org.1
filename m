Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAA21E05B0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 05:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbgEYD44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 23:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388463AbgEYD44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 23:56:56 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32EE2071A;
        Mon, 25 May 2020 03:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590379015;
        bh=pJXil/bjairFKHX1SnFfq5T+nsjaMXt+4tISg0dvTY0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=UCAl+Oroosva071nrp8usT+/p6WVoQ/CuHuEjIKE0js6szr0kZhNuj8n+X/gSNSpx
         c4QjyzWg5jNvDeQdMjDmzZHw7QiayYFW5LWU9Y4glq+DIKWOYrtqUvknf/ydp3lbi8
         gI/iz7T+75No97u50X+pDE9jSiiVbZICQH5gmoZ8=
Date:   Sun, 24 May 2020 20:56:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [PATCH v3] f2fs: avoid inifinite loop to wait for flushing node
 pages at cp_error
Message-ID: <20200525035655.GA135148@google.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522233243.GA94020@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages
in an inifinite loop. Let's drop dirty pages at umount in that case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v3:
 - fix wrong unlock

v2:
 - fix typos

 fs/f2fs/node.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e632de10aedab..e0bb0f7e0506e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 
 	trace_f2fs_writepage(page, NODE);
 
-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
+			ClearPageUptodate(page);
+			dec_page_count(sbi, F2FS_DIRTY_NODES);
+			unlock_page(page);
+			return 0;
+		}
 		goto redirty_out;
+	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
-- 
2.27.0.rc0.183.gde8f92d652-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5B2EA45A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 05:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbhAEERX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 23:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbhAEERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 23:17:22 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B6AC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 20:16:42 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v19so20438712pgj.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 20:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKJkbK/0qA+AFIpsLjEXS6BAkzyO10SmGNn3wBUtxds=;
        b=vZHsRpHgkgF0zLNjP+xBufgtv7dHa1rQX/fu7pMroYBepvJoKeH0EEfEL7Kk92+qSb
         sSC7BPhPTxc8qh1+Mn5WGivBgcFgLBVFqZAhLsGVHMbmdQmCFExWsgwgesT6JxjUJHhN
         lM85YM6CAC9z3LXeZ28sfxWamikxJUHCEpoxEPiMyhj3H5XextGe1GlbOqGnbtmwGPdq
         +Yo2jpf1aCReEdc7eFgBkXVg/Qu9HNsQEjRzg6K8g4SpdEcGdCBudOZu2keZNJnssLeC
         7u1xTxxl1DlJveLHtiZubKGw94x/jA0EWks1tM0w4qasSKXokW9KMEv2Lqx14nH4bewU
         ENXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKJkbK/0qA+AFIpsLjEXS6BAkzyO10SmGNn3wBUtxds=;
        b=G2Qi5Ipyt6mGyVCK4Rq/TjJL5tE8ZstFyVoFBbIJbv/hWqb2c/VkWRQZU1tAde6NoV
         kkSOSVURYutAPhhaqy9/koKO1MD4LQ+0uL0K6wJ+ueL//f0JUk4JBocpcqs3kBka+Vxq
         TqMdhfwyNYijIDHFrmq2kZFNB/B5Wfd4hbByVs/gsb3JAovAN2D+WmqeVNe1zzaQLODf
         O5szivdk+Yawj7I7ENk3X+o3/2nHQzh0W5eFOrzAifub189FxghB8IqefUOQeKkkaoAI
         xJfzXxczbS8mKkT5UCsDhT/9g5zNcwgY4DCHMAG4AU6XnMtPHzydF5Bcyrf5xrIIPaPi
         IYKQ==
X-Gm-Message-State: AOAM533qx/Bgfzp6vVh3vKgDsv/A4geT1VpOAFroF+doi/csE5J5oYZF
        7EcG5p3C6XqZn+Wivi1XURFW0BSZ8QU=
X-Google-Smtp-Source: ABdhPJyuZyKbboWOveGvhjaA3osqPGnttsU+9vHA46r2c5H3DyYcaw0SWeZFljRHgwO3gYp+wF5rrw==
X-Received: by 2002:a62:e212:0:b029:19d:8cff:f179 with SMTP id a18-20020a62e2120000b029019d8cfff179mr68030607pfi.44.1609820201665;
        Mon, 04 Jan 2021 20:16:41 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id z23sm48634077pfj.143.2021.01.04.20.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:16:40 -0800 (PST)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH v2] f2fs: fix null page reference in redirty_blocks
Date:   Tue,  5 Jan 2021 13:16:30 +0900
Message-Id: <20210105041630.1393157-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Fixed null page reference when find_lock_page() fails in
redirty_blocks().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
---
v2: changed error value and break the loop when error occurs
---
 fs/f2fs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9e5275716be8..d27173c24391 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 
 	for (i = 0; i < page_len; i++, redirty_idx++) {
 		page = find_lock_page(mapping, redirty_idx);
-		if (!page)
-			ret = -ENOENT;
+		if (!page) {
+			ret = -ENOMEM;
+			break;
+		}
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
-- 
2.29.2.729.g45daf8777d-goog


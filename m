Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82F28AD6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 06:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgJLE74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 00:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgJLE74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 00:59:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE70CC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 21:59:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y1so4414387plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 21:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIyTJjrKnc7YAlTA+e8+0Y005mOhxECeaDQ+HPR9acY=;
        b=u+9c8REIOdyK2+u/SgztypQ/7EGMc14U/m9HHsxlS0czY+2FtTJlv+58hPxTLRC6Li
         80ObzNgT0y0VT9dS8kiKqTWlB/ECa6A1TC/FMLMlpKPRVqj/mACFl0KkfqKjjPEQZZdO
         2RQlWF86lxRluRsASiQyBKqFmzOPhRFqSinp67fNnPtelHG0DTU3D5RnHKmISmMpnKgO
         3TyzzRz48zGINGK1hpeoiKP5cT6G+Z7EMC4NXewNryMHuF9Syn6GoZwqJ+wwRXy9MbwD
         JzsT93W0zDp1y0+rxydd2EiUArWjuE3BXpHTMFA2uyxtDWKNNkVILQW8nLIK2WYZwaR2
         X1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dIyTJjrKnc7YAlTA+e8+0Y005mOhxECeaDQ+HPR9acY=;
        b=Uq/l6WJA/zDASurmyzvWlDYQpK9kceMzWgN9PzA+0zNGvM/Ce6NqX9CPbTWyxAOhxG
         934RyqO3ZpNrKE+vhVH5m444d8PbggVFR1XlegaV+gdMneYmTJT9ldI7kcfzBfmiBF70
         SAjDKDuWYlCk9klmUpb5HuVUti0I+rZOuSq75WUN/PooiUXkrlS5lZ6Se8Xyr5F7EA0/
         n8i9BetzUzJk6HmoZYqsJCEBb03RiPOaQrVg724vqd4ExWflbr6VfuOxajxHoJyjEhr8
         OLGAjNUU6eHQaEFchHMfytGlkqkmZF5Ugeg7C+RoAmKzNV69fCDFtEaRlwD8Z9c6n3C1
         q5SQ==
X-Gm-Message-State: AOAM53065v3fp15YCTFks8q0e80ym2ixxOt9ywZsJLK+qKDcdH9H19Is
        U/E0pwGxkBG97pxaIuRBxHvGCA3GUW0=
X-Google-Smtp-Source: ABdhPJyvFvRbObN4Qy1DMd+BVZo59q35cx/g7BtKo73dG2Zo7Gm5jWusAe+t9x0UOfcGCQeoKaYYAQ==
X-Received: by 2002:a17:902:7589:b029:d2:686a:4ede with SMTP id j9-20020a1709027589b02900d2686a4edemr22379964pll.45.1602478795165;
        Sun, 11 Oct 2020 21:59:55 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id n4sm18424118pjo.49.2020.10.11.21.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 21:59:54 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix writecount false positive in releasing compress blocks
Date:   Mon, 12 Oct 2020 13:59:47 +0900
Message-Id: <20201012045947.3622888-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

In current condition check, if it detects writecount, it return -EBUSY
regardless of f_mode of the file. Fixed it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0a958eef3d1f..ef5a844de53f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3509,7 +3509,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	inode_lock(inode);
 
 	writecount = atomic_read(&inode->i_writecount);
-	if ((filp->f_mode & FMODE_WRITE && writecount != 1) || writecount) {
+	if ((filp->f_mode & FMODE_WRITE && writecount != 1) ||
+			(!(filp->f_mode & FMODE_WRITE) && writecount)) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
2.28.0.1011.ga647a8990f-goog


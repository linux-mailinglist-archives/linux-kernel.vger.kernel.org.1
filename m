Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9691CC0E2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEILWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 07:22:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4383 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbgEILWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:22:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B12B76FC3B2A1C4C2794;
        Sat,  9 May 2020 19:22:14 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 19:22:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <hridya@google.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] f2fs: Fix wrong stub helper update_sit_info
Date:   Sat, 9 May 2020 19:21:35 +0800
Message-ID: <20200509112135.51960-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_sit_info should be f2fs_update_sit_info,
otherwise build fails while no CONFIG_F2FS_STAT_FS.

Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 747d09264147..b06a14ed218e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3686,7 +3686,7 @@ static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
 static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
 static inline void __init f2fs_create_root_stats(void) { }
 static inline void f2fs_destroy_root_stats(void) { }
-static inline void update_sit_info(struct f2fs_sb_info *sbi) {}
+static inline void f2fs_update_sit_info(struct f2fs_sb_info *sbi) {}
 #endif
 
 extern const struct file_operations f2fs_dir_operations;
-- 
2.17.1



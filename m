Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B78210EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgGAPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 11:19:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731765AbgGAPTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:19:00 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D35FE4C36A65060E5173;
        Wed,  1 Jul 2020 23:18:53 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 1 Jul 2020 23:18:43 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <hulkcommits@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] f2fs: make __allocate_new_segment() static
Date:   Wed, 1 Jul 2020 23:28:58 +0800
Message-ID: <20200701152858.50516-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hulk Robot <hulkci@huawei.com>

From: Hulk Robot <hulkci@huawei.com>

Fix sparse build warning:

fs/f2fs/segment.c:2736:6: warning:
 symbol '__allocate_new_segment' was not declared. Should it be static?

Signed-off-by: Hulk Robot <hulkci@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45e473508a9..c35614d255e1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2733,7 +2733,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 	up_read(&SM_I(sbi)->curseg_lock);
 }
 
-void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
+static void __allocate_new_segment(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	unsigned int old_segno;


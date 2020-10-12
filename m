Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9911828AC08
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJLC2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:28:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbgJLC2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:28:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 74CF3E6D2CE783295847;
        Mon, 12 Oct 2020 10:28:53 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 10:28:42 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't issue flush in f2fs_flush_device_cache() for nobarrier case
Date:   Mon, 12 Oct 2020 10:28:14 +0800
Message-ID: <20201012022814.73684-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes f2fs_flush_device_cache() to skip issuing flush for
nobarrier case.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 13ecd2c2c361..f14499632b45 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -759,6 +759,9 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 	if (!f2fs_is_multi_device(sbi))
 		return 0;
 
+	if (test_opt(sbi, NOBARRIER))
+		return 0;
+
 	for (i = 1; i < sbi->s_ndevs; i++) {
 		if (!f2fs_test_bit(i, (char *)&sbi->dirty_device))
 			continue;
-- 
2.26.2


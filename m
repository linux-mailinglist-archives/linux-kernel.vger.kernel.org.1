Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5628DA14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgJNGy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:54:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15285 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727622AbgJNGy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:54:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C64E4B931C5AF29CDE4B;
        Wed, 14 Oct 2020 14:54:51 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.50) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 14:54:45 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <dwmw2@infradead.org>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>,
        <chenjie6@huawei.com>, <qiuxi1@huawei.com>, <lizhe67@huawei.com>
Subject: [PATCH 1/2] jffs2: fix ignoring mounting options problem during remounting
Date:   Wed, 14 Oct 2020 14:54:42 +0800
Message-ID: <20201014065443.18512-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.50]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lizhe <lizhe67@huawei.com>

The jffs2 mount options will be ignored when remounting jffs2.
It can be easily reproduced with the steps listed below.
1. mount -t jffs2 -o compr=none /dev/mtdblockx /mnt
2. mount -o remount compr=zlib /mnt

Since ec10a24f10c8, the option parsing happens before fill_super and
then pass fc, which contains the options parsing results, to function
jffs2_reconfigure during remounting. But function jffs2_reconfigure do
not update c->mount_opts.

This patch add a function jffs2_update_mount_opts to fix this problem.

By the way, I notice that tmpfs use the same way to update remounting
options. If it is necessary to unify them?

Signed-off-by: lizhe <lizhe67@huawei.com>
---
 fs/jffs2/super.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 05d7878dfad1..4fd297bdf0f3 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -215,11 +215,28 @@ static int jffs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
+static inline void jffs2_update_mount_opts(struct fs_context *fc)
+{
+	struct jffs2_sb_info *new_c = fc->s_fs_info;
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(fc->root->d_sb);
+
+	mutex_lock(&c->alloc_sem);
+	if (new_c->mount_opts.override_compr) {
+		c->mount_opts.override_compr = new_c->mount_opts.override_compr;
+		c->mount_opts.compr = new_c->mount_opts.compr;
+	}
+	if (new_c->mount_opts.rp_size)
+		c->mount_opts.rp_size = new_c->mount_opts.rp_size;
+	mutex_unlock(&c->alloc_sem);
+}
+
 static int jffs2_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 
 	sync_filesystem(sb);
+	jffs2_update_mount_opts(fc);
+
 	return jffs2_do_remount_fs(sb, fc);
 }
 
-- 
2.12.3


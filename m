Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F692A8CF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKFCaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:30:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7150 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFCaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:30:16 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CS49W43j6z15Rm5;
        Fri,  6 Nov 2020 10:30:07 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.50) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 10:30:02 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <lizhe67@huawei.com>,
        <dwmw2@infradead.org>, <richard@nod.at>
CC:     <chenjie6@huawei.com>, <linux-kernel@vger.kernel.org>,
        <qiuxi1@huawei.com>, <wangfangpeng1@huawei.com>,
        <zhongjubin@huawei.com>
Subject: Re: [PATCH 1/2] jffs2: fix ignoring mounting options problem during remounting
Date:   Fri, 6 Nov 2020 10:30:02 +0800
Message-ID: <20201106023002.12752-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201014065443.18512-1-lizhe67@huawei.com>
References: <20201014065443.18512-1-lizhe67@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.50]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintainer ping?

	Zhe

On Tue, 13 Oct 2020 15:22:37 +0800, Zhe Li wrote:
>
>The jffs2 mount options will be ignored when remounting jffs2.
>It can be easily reproduced with the steps listed below.
>1. mount -t jffs2 -o compr=none /dev/mtdblockx /mnt
>2. mount -o remount compr=zlib /mnt
>
>Since ec10a24f10c8, the option parsing happens before fill_super and
>then pass fc, which contains the options parsing results, to function
>jffs2_reconfigure during remounting. But function jffs2_reconfigure do
>not update c->mount_opts.
>
>This patch add a function jffs2_update_mount_opts to fix this problem.
>
>By the way, I notice that tmpfs use the same way to update remounting
>options. If it is necessary to unify them?
>
>Signed-off-by: lizhe <lizhe67@huawei.com>
>---
> fs/jffs2/super.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
>index 05d7878dfad1..4fd297bdf0f3 100644
>--- a/fs/jffs2/super.c
>+++ b/fs/jffs2/super.c
>@@ -215,11 +215,28 @@ static int jffs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
> 	return 0;
> }
> 
>+static inline void jffs2_update_mount_opts(struct fs_context *fc)
>+{
>+	struct jffs2_sb_info *new_c = fc->s_fs_info;
>+	struct jffs2_sb_info *c = JFFS2_SB_INFO(fc->root->d_sb);
>+
>+	mutex_lock(&c->alloc_sem);
>+	if (new_c->mount_opts.override_compr) {
>+		c->mount_opts.override_compr = new_c->mount_opts.override_compr;
>+		c->mount_opts.compr = new_c->mount_opts.compr;
>+	}
>+	if (new_c->mount_opts.rp_size)
>+		c->mount_opts.rp_size = new_c->mount_opts.rp_size;
>+	mutex_unlock(&c->alloc_sem);
>+}
>+
> static int jffs2_reconfigure(struct fs_context *fc)
> {
> 	struct super_block *sb = fc->root->d_sb;
> 
> 	sync_filesystem(sb);
>+	jffs2_update_mount_opts(fc);
>+
> 	return jffs2_do_remount_fs(sb, fc);
> }
> 
>-- 
>2.12.3
>

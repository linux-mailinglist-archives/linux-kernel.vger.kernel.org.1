Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B95C2B8A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 03:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgKSCvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 21:51:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7652 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKSCvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 21:51:00 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cc41G35s5z15MtC;
        Thu, 19 Nov 2020 10:50:42 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.50) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 10:50:50 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <lizhe67@huawei.com>, <richard@nod.at>, <dwmw2@infradead.org>
CC:     <chenjie6@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <qiuxi1@huawei.com>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH 2/2] jffs2: fix can't set rp_size to zero during remounting
Date:   Thu, 19 Nov 2020 10:50:50 +0800
Message-ID: <20201119025050.38472-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20201014065443.18512-2-lizhe67@huawei.com>
References: <20201014065443.18512-2-lizhe67@huawei.com>
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

On Tue, 13 Oct 2020 19:41:30 +0800, Zhe Li wrote:
>
>Set rp_size to zero will be ignore during remounting.
>
>The method to identify whether we input a remounting option of
>rp_size is to check if the rp_size input is zero. It can not work
>well if we pass "rp_size=0".
>
>This patch add a bool variable "set_rp_size" to fix this problem.
>
>By the way, the problem of NULL pointer dereference in rp_size
>fs option parsing showed at
>https://lore.kernel.org/linux-mtd/20201012131204.59102-1-jamie@nuviainc.com/T/#u
>should be applyed before this patch to make sure it works well.
>
>Reported-by: Jubin Zhong <zhongjubin@huawei.com>
>Signed-off-by: lizhe <lizhe67@huawei.com>
>---
> fs/jffs2/jffs2_fs_sb.h | 1 +
> fs/jffs2/super.c       | 7 +++++--
> 2 files changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
>index 778275f48a87..5a7091746f68 100644
>--- a/fs/jffs2/jffs2_fs_sb.h
>+++ b/fs/jffs2/jffs2_fs_sb.h
>@@ -38,6 +38,7 @@ struct jffs2_mount_opts {
> 	 * users. This is implemented simply by means of not allowing the
> 	 * latter users to write to the file system if the amount if the
> 	 * available space is less then 'rp_size'. */
>+	bool set_rp_size;
> 	unsigned int rp_size;
> };
> 
>diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
>index 4fd297bdf0f3..c523adaca79f 100644
>--- a/fs/jffs2/super.c
>+++ b/fs/jffs2/super.c
>@@ -88,7 +88,7 @@ static int jffs2_show_options(struct seq_file *s, struct dentry *root)
> 
> 	if (opts->override_compr)
> 		seq_printf(s, ",compr=%s", jffs2_compr_name(opts->compr));
>-	if (opts->rp_size)
>+	if (opts->set_rp_size)
> 		seq_printf(s, ",rp_size=%u", opts->rp_size / 1024);
> 
> 	return 0;
>@@ -206,6 +206,7 @@ static int jffs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
> 		if (opt > c->mtd->size)
> 			return invalf(fc, "jffs2: Too large reserve pool specified, max is %llu KB",
> 				      c->mtd->size / 1024);
>+		c->mount_opts.set_rp_size = true;
> 		c->mount_opts.rp_size = opt;
> 		break;
> 	default:
>@@ -225,8 +226,10 @@ static inline void jffs2_update_mount_opts(struct fs_context *fc)
> 		c->mount_opts.override_compr = new_c->mount_opts.override_compr;
> 		c->mount_opts.compr = new_c->mount_opts.compr;
> 	}
>-	if (new_c->mount_opts.rp_size)
>+	if (new_c->mount_opts.set_rp_size) {
>+		c->mount_opts.set_rp_size = new_c->mount_opts.set_rp_size;
> 		c->mount_opts.rp_size = new_c->mount_opts.rp_size;
>+	}
> 	mutex_unlock(&c->alloc_sem);
> }
> 
>-- 
>2.12.3
>

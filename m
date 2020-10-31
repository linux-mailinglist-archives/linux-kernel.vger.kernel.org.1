Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24642A1415
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 08:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgJaHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 03:55:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7123 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgJaHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 03:55:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNWgy1NWyzLmZy;
        Sat, 31 Oct 2020 15:55:42 +0800 (CST)
Received: from DESKTOP-2DH7KI2.china.huawei.com (10.67.101.108) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 15:55:33 +0800
From:   Chengsong Ke <kechengsong@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>
Subject: [PATCH] ubifs: Fix the printing type of c->big_lpt
Date:   Sat, 31 Oct 2020 15:55:33 +0800
Message-ID: <20201031075533.30176-1-kechengsong@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ubifs uses %d to print c->big_lpt, but c->big_lpt is a variable
of type unsigned int and should be printed with %u.

Reviewed-by: Fangpeng Wang <wangfangpeng1@huawei.com>
Signed-off-by: Chengsong Ke <kechengsong@huawei.com>
---
 fs/ubifs/debug.c | 2 +-
 fs/ubifs/lpt.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index ebff43f8009c..ef1a02ee076f 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -764,7 +764,7 @@ void ubifs_dump_lpt_info(struct ubifs_info *c)
 	pr_err("\tnnode_sz:      %d\n", c->nnode_sz);
 	pr_err("\tltab_sz:       %d\n", c->ltab_sz);
 	pr_err("\tlsave_sz:      %d\n", c->lsave_sz);
-	pr_err("\tbig_lpt:       %d\n", c->big_lpt);
+	pr_err("\tbig_lpt:       %u\n", c->big_lpt);
 	pr_err("\tlpt_hght:      %d\n", c->lpt_hght);
 	pr_err("\tpnode_cnt:     %d\n", c->pnode_cnt);
 	pr_err("\tnnode_cnt:     %d\n", c->nnode_cnt);
diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 6e0a153b7194..778a22bf9a92 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -851,7 +851,7 @@ int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
 	dbg_lp("lsave_sz %d", c->lsave_sz);
 	dbg_lp("lsave_cnt %d", c->lsave_cnt);
 	dbg_lp("lpt_hght %d", c->lpt_hght);
-	dbg_lp("big_lpt %d", c->big_lpt);
+	dbg_lp("big_lpt %u", c->big_lpt);
 	dbg_lp("LPT root is at %d:%d", c->lpt_lnum, c->lpt_offs);
 	dbg_lp("LPT head is at %d:%d", c->nhead_lnum, c->nhead_offs);
 	dbg_lp("LPT ltab is at %d:%d", c->ltab_lnum, c->ltab_offs);
@@ -1824,7 +1824,7 @@ static int lpt_init_rd(struct ubifs_info *c)
 	dbg_lp("lsave_sz %d", c->lsave_sz);
 	dbg_lp("lsave_cnt %d", c->lsave_cnt);
 	dbg_lp("lpt_hght %d", c->lpt_hght);
-	dbg_lp("big_lpt %d", c->big_lpt);
+	dbg_lp("big_lpt %u", c->big_lpt);
 	dbg_lp("LPT root is at %d:%d", c->lpt_lnum, c->lpt_offs);
 	dbg_lp("LPT head is at %d:%d", c->nhead_lnum, c->nhead_offs);
 	dbg_lp("LPT ltab is at %d:%d", c->ltab_lnum, c->ltab_offs);
-- 
2.12.3


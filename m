Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32BB26BA34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIPC3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:29:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12295 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbgIPC14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:27:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CF0623DB4BD9E1241FC;
        Wed, 16 Sep 2020 10:27:50 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:44 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Alexei Starovoitov <ast@fb.com>, Josef Bacik <jbacik@fb.com>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] error-injection: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:20 +0800
Message-ID: <20200916025020.3992523-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 lib/error-inject.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/lib/error-inject.c b/lib/error-inject.c
index aa63751c916f..a93103488fdd 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -194,24 +194,14 @@ static int ei_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static const struct seq_operations ei_seq_ops = {
+static const struct seq_operations ei_sops = {
 	.start = ei_seq_start,
 	.next  = ei_seq_next,
 	.stop  = ei_seq_stop,
 	.show  = ei_seq_show,
 };
 
-static int ei_open(struct inode *inode, struct file *filp)
-{
-	return seq_open(filp, &ei_seq_ops);
-}
-
-static const struct file_operations debugfs_ei_ops = {
-	.open           = ei_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(ei);
 
 static int __init ei_debugfs_init(void)
 {
@@ -221,7 +211,7 @@ static int __init ei_debugfs_init(void)
 	if (!dir)
 		return -ENOMEM;
 
-	file = debugfs_create_file("list", 0444, dir, NULL, &debugfs_ei_ops);
+	file = debugfs_create_file("list", 0444, dir, NULL, &ei_fops);
 	if (!file) {
 		debugfs_remove(dir);
 		return -ENOMEM;
-- 
2.25.1


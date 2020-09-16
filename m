Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8306E26BA25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIPC2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:28:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgIPC2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:28:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B40F1EE6CC59AE4601;
        Wed, 16 Sep 2020 10:28:00 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:51 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] powerpc/pseries: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:26 +0800
Message-ID: <20200916025026.3992835-1-liushixin2@huawei.com>
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
 arch/powerpc/platforms/pseries/hvCall_inst.c | 23 +++-----------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index c40c62ec432e..2c59b4986ea5 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -70,31 +70,14 @@ static int hc_show(struct seq_file *m, void *p)
 	return 0;
 }
 
-static const struct seq_operations hcall_inst_seq_ops = {
+static const struct seq_operations hcall_inst_sops = {
         .start = hc_start,
         .next  = hc_next,
         .stop  = hc_stop,
         .show  = hc_show
 };
 
-static int hcall_inst_seq_open(struct inode *inode, struct file *file)
-{
-	int rc;
-	struct seq_file *seq;
-
-	rc = seq_open(file, &hcall_inst_seq_ops);
-	seq = file->private_data;
-	seq->private = file_inode(file)->i_private;
-
-	return rc;
-}
-
-static const struct file_operations hcall_inst_seq_fops = {
-	.open = hcall_inst_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(hcall_inst);
 
 #define	HCALL_ROOT_DIR		"hcall_inst"
 #define CPU_NAME_BUF_SIZE	32
@@ -149,7 +132,7 @@ static int __init hcall_inst_init(void)
 		snprintf(cpu_name_buf, CPU_NAME_BUF_SIZE, "cpu%d", cpu);
 		debugfs_create_file(cpu_name_buf, 0444, hcall_root,
 				    per_cpu(hcall_stats, cpu),
-				    &hcall_inst_seq_fops);
+				    &hcall_inst_fops);
 	}
 
 	return 0;
-- 
2.25.1


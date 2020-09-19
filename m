Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76488270A30
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgISCvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:51:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbgISCve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:51:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F32DBB5AB0891178E000;
        Sat, 19 Sep 2020 10:51:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:51:24 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
CC:     <linux-c6x-dev@linux-c6x.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] c6x: pll: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 19 Sep 2020 10:51:56 +0800
Message-ID: <20200919025156.17142-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 arch/c6x/platforms/pll.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/c6x/platforms/pll.c b/arch/c6x/platforms/pll.c
index 6fdf20d64..366c9fe6a 100644
--- a/arch/c6x/platforms/pll.c
+++ b/arch/c6x/platforms/pll.c
@@ -417,22 +417,12 @@ static int c6x_ck_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int c6x_ck_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, c6x_ck_show, NULL);
-}
-
-static const struct file_operations c6x_ck_operations = {
-	.open		= c6x_ck_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(c6x_ck);
 
 static int __init c6x_clk_debugfs_init(void)
 {
 	debugfs_create_file("c6x_clocks", S_IFREG | S_IRUGO, NULL, NULL,
-			    &c6x_ck_operations);
+			    &c6x_ck_fops);
 
 	return 0;
 }
-- 
2.23.0


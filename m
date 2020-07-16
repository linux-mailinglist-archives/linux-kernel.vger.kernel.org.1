Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF5A221F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgGPJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 05:03:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbgGPJDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:03:38 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CAB4D3798A5C3985B664;
        Thu, 16 Jul 2020 17:03:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 17:03:34 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
CC:     <linux-c6x-dev@linux-c6x.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] C6X: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 16 Jul 2020 17:07:30 +0800
Message-ID: <20200716090730.14495-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Huang <chenhuang5@huawei.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 arch/c6x/platforms/pll.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/c6x/platforms/pll.c b/arch/c6x/platforms/pll.c
index a952faff1..366c9fe6a 100644
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
-	.read_iter		= seq_read_iter,
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
2.17.1


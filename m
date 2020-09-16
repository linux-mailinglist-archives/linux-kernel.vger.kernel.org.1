Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C4026BA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIPC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:28:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58392 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgIPC2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:28:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0472D58BABBA9BC5833;
        Wed, 16 Sep 2020 10:28:00 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:54 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] s390/diag: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:29 +0800
Message-ID: <20200916025029.3992939-1-liushixin2@huawei.com>
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
 arch/s390/kernel/diag.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index ccba63aaeb47..b8b0cd7b008f 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -104,18 +104,7 @@ static const struct seq_operations show_diag_stat_sops = {
 	.show	= show_diag_stat,
 };
 
-static int show_diag_stat_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &show_diag_stat_sops);
-}
-
-static const struct file_operations show_diag_stat_fops = {
-	.open		= show_diag_stat_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
+DEFINE_SEQ_ATTRIBUTE(show_diag_stat);
 
 static int __init show_diag_stat_init(void)
 {
-- 
2.25.1


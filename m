Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42C32E769F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgL3GjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:39:10 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54901 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbgL3GjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:39:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UKCfVeh_1609310288;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UKCfVeh_1609310288)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Dec 2020 14:38:15 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     boris.ostrovsky@oracle.com
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] xen: fix: use WARN_ON instead of if condition followed by BUG.
Date:   Wed, 30 Dec 2020 14:38:06 +0800
Message-Id: <1609310286-77985-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use WARN_ON instead of if condition followed by BUG in
gnttab_batch_map() and gnttab_batch_copy().

This issue was detected with the help of coccicheck.

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 drivers/xen/grant-table.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 3729bea..db1770c 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1080,8 +1080,8 @@ void gnttab_batch_map(struct gnttab_map_grant_ref *batch, unsigned count)
 {
 	struct gnttab_map_grant_ref *op;
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, batch, count))
-		BUG();
+	WARN_ON(HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, batch, count));
+
 	for (op = batch; op < batch + count; op++)
 		if (op->status == GNTST_eagain)
 			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref, op,
@@ -1093,8 +1093,8 @@ void gnttab_batch_copy(struct gnttab_copy *batch, unsigned count)
 {
 	struct gnttab_copy *op;
 
-	if (HYPERVISOR_grant_table_op(GNTTABOP_copy, batch, count))
-		BUG();
+	WARN_ON(HYPERVISOR_grant_table_op(GNTTABOP_copy, batch, count));
+
 	for (op = batch; op < batch + count; op++)
 		if (op->status == GNTST_eagain)
 			gnttab_retry_eagain_gop(GNTTABOP_copy, op,
-- 
1.8.3.1


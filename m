Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDFB22D322
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 02:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGYANs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 20:13:48 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:12912 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgGYANs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:13:48 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 293BE2B005BEDCEC498C;
        Sat, 25 Jul 2020 08:13:46 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 06P0DiT0078475;
        Sat, 25 Jul 2020 08:13:44 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020072508142638-4388908 ;
          Sat, 25 Jul 2020 08:14:26 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] block: Fix reference count leak in blk_integrity_add
Date:   Sat, 25 Jul 2020 08:17:12 +0800
Message-Id: <1595636232-15297-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-07-25 08:14:26,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-25 08:13:50,
        Serialize complete at 2020-07-25 08:13:50
X-MAIL: mse-fl2.zte.com.cn 06P0DiT0078475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

kobject_init_and_add() takes reference even when it fails. If this
function returns an error, kobject_put() must be called to properly
clean up the memory associated with the object.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 block/blk-integrity.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index c03705c..118b2f2 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -436,8 +436,10 @@ EXPORT_SYMBOL(blk_integrity_unregister);
 void blk_integrity_add(struct gendisk *disk)
 {
 	if (kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
-				 &disk_to_dev(disk)->kobj, "%s", "integrity"))
+				 &disk_to_dev(disk)->kobj, "%s", "integrity")) {
+		kobject_put(&disk->integrity_kobj);
 		return;
+	}
 
 	kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
 }
--
2.9.5


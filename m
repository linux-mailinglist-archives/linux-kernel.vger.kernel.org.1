Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EF2A8F05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgKFFsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:48:37 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:35235 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgKFFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:48:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UEOSihB_1604641714;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEOSihB_1604641714)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 13:48:34 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nilfs2: remove some unused macros to tame gcc
Date:   Fri,  6 Nov 2020 13:48:33 +0800
Message-Id: <1604641713-6484-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There some macros are unused and cause gcc warning. Remove them.

fs/nilfs2/segment.c:137:0: warning: macro "nilfs_cnt32_gt" is not used
[-Wunused-macros]
fs/nilfs2/segment.c:144:0: warning: macro "nilfs_cnt32_le" is not used
[-Wunused-macros]
fs/nilfs2/segment.c:143:0: warning: macro "nilfs_cnt32_lt" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com> 
Cc: linux-nilfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/nilfs2/segment.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index e3726aca28ed..cd4da9535aed 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -134,14 +134,9 @@ struct nilfs_sc_operations {
 static void nilfs_segctor_do_immediate_flush(struct nilfs_sc_info *);
 static void nilfs_dispose_list(struct the_nilfs *, struct list_head *, int);
 
-#define nilfs_cnt32_gt(a, b)   \
-	(typecheck(__u32, a) && typecheck(__u32, b) && \
-	 ((__s32)(b) - (__s32)(a) < 0))
 #define nilfs_cnt32_ge(a, b)   \
 	(typecheck(__u32, a) && typecheck(__u32, b) && \
 	 ((__s32)(a) - (__s32)(b) >= 0))
-#define nilfs_cnt32_lt(a, b)  nilfs_cnt32_gt(b, a)
-#define nilfs_cnt32_le(a, b)  nilfs_cnt32_ge(b, a)
 
 static int nilfs_prepare_segment_lock(struct super_block *sb,
 				      struct nilfs_transaction_info *ti)
-- 
1.8.3.1


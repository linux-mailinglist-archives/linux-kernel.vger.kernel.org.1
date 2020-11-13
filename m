Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840F52B165D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgKMH0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:26:08 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45882 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbgKMH0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:26:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UFAU-7X_1605252365;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAU-7X_1605252365)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:26:05 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gcov: fix kernel-doc markup issue
Date:   Fri, 13 Nov 2020 15:25:52 +0800
Message-Id: <1605252352-63983-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following kernel-doc issue in gcov:
kernel/gcov/gcc_4_7.c:238: warning: Function parameter or member 'dst'
not described in 'gcov_info_add'
kernel/gcov/gcc_4_7.c:238: warning: Function parameter or member 'src'
not described in 'gcov_info_add'
kernel/gcov/gcc_4_7.c:238: warning: Excess function parameter 'dest'
description in 'gcov_info_add'
kernel/gcov/gcc_4_7.c:238: warning: Excess function parameter 'source'
description in 'gcov_info_add'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/gcov/gcc_4_7.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 53c67c87f141..789c2a8ba801 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -229,10 +229,10 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
 
 /**
  * gcov_info_add - add up profiling data
- * @dest: profiling data set to which data is added
- * @source: profiling data set which is added
+ * @dst: profiling data set to which data is added
+ * @src: profiling data set which is added
  *
- * Adds profiling counts of @source to @dest.
+ * Adds profiling counts of @src to @dst.
  */
 void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
 {
-- 
2.29.GIT


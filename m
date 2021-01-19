Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487022FB1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbhASGpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:45:42 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46452 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbhASGoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:44:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UMDPF7q_1611038596;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UMDPF7q_1611038596)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jan 2021 14:43:21 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     wufengguang@huawei.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH] usemem: Remove the duplicate do_access
Date:   Tue, 19 Jan 2021 14:43:13 +0800
Message-Id: <20210119064313.21627-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Zhu <teawaterz@linux.alibaba.com>

Got following error when build usemem:
gcc -O -c -Wall -g  usemem.c -o usemem.o
usemem.c:451:15: error: redefinition of ‘do_access’
 unsigned long do_access(unsigned long *p, unsigned long idx, int read)
               ^~~~~~~~~
usemem.c:332:15: note: previous definition of ‘do_access’ was here
 unsigned long do_access(unsigned long *p, unsigned long idx, int read)
               ^~~~~~~~~
make: *** [usemem.o] Error 1

Remove the duplicate do_access to fix this error.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 usemem.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/usemem.c b/usemem.c
index 48c3d65..e2c46ec 100644
--- a/usemem.c
+++ b/usemem.c
@@ -329,18 +329,6 @@ void detach(void)
 	}
 }
 
-unsigned long do_access(unsigned long *p, unsigned long idx, int read)
-{
-	volatile unsigned long *vp = p;
-
-	if (read)
-		return vp[idx];	/* read data */
-	else {
-		vp[idx] = idx;	/* write data */
-		return 0;
-	}
-}
-
 unsigned long * allocate(unsigned long bytes)
 {
 	unsigned long *p;
-- 
1.8.3.1


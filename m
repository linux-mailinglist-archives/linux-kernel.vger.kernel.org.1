Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D793020CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbhAYDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:21:09 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49532 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbhAYDUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:20:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UMka-xS_1611544806;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UMka-xS_1611544806)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Jan 2021 11:20:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap: Remove redundant variable's assignment
Date:   Mon, 25 Jan 2021 11:20:02 +0800
Message-Id: <08dc7237b44b9455ab095b44dc6969a1607b08db.1611544316.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've already set the variable 'i' 's initial value before using it,
thus remove redundant previous assignment of variable 'i'.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/filemap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e4906f5..07b02f3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2472,7 +2472,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if ((iocb->ki_flags & IOCB_WAITQ) && written)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
-		i = 0;
 		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
 							     pages, nr_pages);
 		if (pg_nr < 0) {
-- 
1.8.3.1


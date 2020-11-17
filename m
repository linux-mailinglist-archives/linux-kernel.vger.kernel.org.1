Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2ED2B5BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgKQJY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:24:57 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57223 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgKQJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:24:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UFh2-H3_1605605092;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFh2-H3_1605605092)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Nov 2020 17:24:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mapping_dirty_helpers: enhance the kernel-doc markups
Date:   Tue, 17 Nov 2020 17:24:47 +0800
Message-Id: <1605605088-30668-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1605605088-30668-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605605088-30668-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and change parameter explanation for wp_pte and clean_record_pte, to
avoid W1 warning:
mm/mapping_dirty_helpers.c:34: warning: Function parameter or member
'end' not described in 'wp_pte'
mm/mapping_dirty_helpers.c:88: warning: Function parameter or member
'end' not described in 'clean_record_pte'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mapping_dirty_helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 2c7d03675903..b59054ef2e10 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -23,7 +23,8 @@ struct wp_walk {
 /**
  * wp_pte - Write-protect a pte
  * @pte: Pointer to the pte
- * @addr: The virtual page address
+ * @addr: The start of protecting virtual address
+ * @end: The end of protecting virtual address
  * @walk: pagetable walk callback argument
  *
  * The function write-protects a pte and records the range in
@@ -74,7 +75,8 @@ struct clean_walk {
  * clean_record_pte - Clean a pte and record its address space offset in a
  * bitmap
  * @pte: Pointer to the pte
- * @addr: The virtual page address
+ * @addr: The start of virtual address to be clean
+ * @end: The end of virtual address to be clean
  * @walk: pagetable walk callback argument
  *
  * The function cleans a pte and records the range in
-- 
2.29.GIT


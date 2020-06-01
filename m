Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D741EA045
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 10:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgFAIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 04:44:55 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48738 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgFAIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:44:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U-C-4Id_1591001089;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0U-C-4Id_1591001089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Jun 2020 16:44:50 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/4] workqueue: slash half memory usage in 32bit system
Date:   Mon,  1 Jun 2020 08:44:42 +0000
Message-Id: <20200601084442.8284-5-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601084442.8284-1-laijs@linux.alibaba.com>
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The major memory ussage in workqueue is on the pool_workqueue.
The pool_workqueue has alignment requirement which often leads
to padding.

Reducing the memory usage for the pool_workqueue is valuable.

And 32bit system often has less memory, less workqueues,
less works, less concurrent flush_workqueue()s, so we can
slash the flush color on 32bit system to reduce memory usage

Before patch:
The sizeof the struct pool_workqueue is 256 bytes,
only 136 bytes is in use in 32bit system

After patch:
The sizeof the struct pool_workqueue is 128 bytes,
only 104 bytes is in use in 32bit system, there is still
room for future usage.

Setting WORK_STRUCT_COLOR_BITS to 3 can't reduce the sizeof
the struct pool_workqueue in 64bit system, unless combined
with big refactor for unbound pwq.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/workqueue.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 26de0cae2a0a..c0f311926d01 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -39,7 +39,11 @@ enum {
 	WORK_STRUCT_COLOR_SHIFT	= 4,	/* color for workqueue flushing */
 #endif
 
+#if BITS_PER_LONG == 32
+	WORK_STRUCT_COLOR_BITS	= 3,
+#else
 	WORK_STRUCT_COLOR_BITS	= 4,
+#endif
 
 	WORK_STRUCT_PENDING	= 1 << WORK_STRUCT_PENDING_BIT,
 	WORK_STRUCT_DELAYED	= 1 << WORK_STRUCT_DELAYED_BIT,
@@ -65,6 +69,8 @@ enum {
 	 * Reserve 8 bits off of pwq pointer w/ debugobjects turned off.
 	 * This makes pwqs aligned to 256 bytes and allows 15 workqueue
 	 * flush colors.
+	 * For 32 bit system, the numbers are 7 bits, 128 bytes, 7 colors
+	 * respectively.
 	 */
 	WORK_STRUCT_FLAG_BITS	= WORK_STRUCT_COLOR_SHIFT +
 				  WORK_STRUCT_COLOR_BITS,
-- 
2.20.1


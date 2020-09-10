Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096072640EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgIJJGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 05:06:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbgIJJGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:06:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9C3B8853F2AA88842628;
        Thu, 10 Sep 2020 17:06:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 17:06:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <viro@zeniv.linux.org.uk>,
        <mingo@kernel.org>, <keescook@chromium.org>, <ardb@kernel.org>,
        <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] lib: Fix some broken comments
Date:   Thu, 10 Sep 2020 05:05:24 -0400
Message-ID: <20200910090524.5147-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some weird and confusing comments.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 lib/checksum.c | 2 +-
 lib/refcount.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/checksum.c b/lib/checksum.c
index c7861e84c526..cd0175c6a355 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -146,7 +146,7 @@ __sum16 ip_compute_csum(const void *buff, int len)
 EXPORT_SYMBOL(ip_compute_csum);
 
 /*
- * copy from ds while checksumming, otherwise like csum_partial
+ * copy from src while checksumming, otherwise like csum_partial
  */
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
diff --git a/lib/refcount.c b/lib/refcount.c
index ebac8b7d15a7..39e179ed2c58 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
  *                                 interrupts if able to decrement refcount to 0
  * @r: the refcount
  * @lock: the spinlock to be locked
- * @flags: saved IRQ-flags if the is acquired
+ * @flags: saved IRQ-flags if the @lock is acquired
  *
  * Same as refcount_dec_and_lock() above except that the spinlock is acquired
  * with disabled interupts.
-- 
2.19.1


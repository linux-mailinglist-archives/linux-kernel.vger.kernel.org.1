Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62009272349
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIUMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:03:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbgIUMDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:03:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 091B21001579109E101;
        Mon, 21 Sep 2020 20:03:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 20:02:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <ardb@kernel.org>, <will@kernel.org>, <keescook@chromium.org>,
        <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3] lib: fix incomplete comment in refcount_dec_and_lock_irqsave()
Date:   Mon, 21 Sep 2020 08:01:31 -0400
Message-ID: <20200921120131.42303-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of arg flags is incomplete. The flags is saved IRQ-flags
when the @lock is acquired.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 lib/refcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/refcount.c b/lib/refcount.c
index ebac8b7d15a7..76e1e116ccd8 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
  *                                 interrupts if able to decrement refcount to 0
  * @r: the refcount
  * @lock: the spinlock to be locked
- * @flags: saved IRQ-flags if the is acquired
+ * @flags: saved IRQ-flags if @lock is acquired
  *
  * Same as refcount_dec_and_lock() above except that the spinlock is acquired
  * with disabled interupts.
-- 
2.19.1


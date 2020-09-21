Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A927225B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgIULZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:25:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgIULZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:25:27 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06F62FB140EB382425F7;
        Mon, 21 Sep 2020 19:25:26 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 19:25:17 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <ardb@kernel.org>, <will@kernel.org>, <keescook@chromium.org>,
        <mingo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] lib: fix incomplete comment in refcount_dec_and_lock_irqsave()
Date:   Mon, 21 Sep 2020 07:23:58 -0400
Message-ID: <20200921112358.14841-1-linmiaohe@huawei.com>
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

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 lib/refcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/refcount.c b/lib/refcount.c
index ebac8b7d15a7..dcfd092f66c7 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
  *                                 interrupts if able to decrement refcount to 0
  * @r: the refcount
  * @lock: the spinlock to be locked
- * @flags: saved IRQ-flags if the is acquired
+ * @flags: saved IRQ-flags if the is @lock acquired
  *
  * Same as refcount_dec_and_lock() above except that the spinlock is acquired
  * with disabled interupts.
-- 
2.19.1


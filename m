Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192B0268CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgINODi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:03:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45002 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbgINN7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:59:55 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8435B14FF54D1DCBCB5C;
        Mon, 14 Sep 2020 21:59:48 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 21:59:43 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/4] ubifs: Fix 'hash' kernel-doc warning in auth.c
Date:   Mon, 14 Sep 2020 21:56:51 +0800
Message-ID: <20200914135654.55120-2-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914135654.55120-1-wanghai38@huawei.com>
References: <20200914135654.55120-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/ubifs/auth.c:66: warning: Excess function parameter 'hash' description in 'ubifs_prepare_auth_node'

Rename hash to inhash.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/ubifs/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index cc5c0abfd536..b93b3cd10bfd 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -54,7 +54,7 @@ static int ubifs_hash_calc_hmac(const struct ubifs_info *c, const u8 *hash,
  * ubifs_prepare_auth_node - Prepare an authentication node
  * @c: UBIFS file-system description object
  * @node: the node to calculate a hash for
- * @hash: input hash of previous nodes
+ * @inhash: input hash of previous nodes
  *
  * This function prepares an authentication node for writing onto flash.
  * It creates a HMAC from the given input hash and writes it to the node.
-- 
2.17.1


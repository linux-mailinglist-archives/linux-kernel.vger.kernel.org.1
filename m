Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D52A13BE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 07:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgJaF7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 01:59:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6676 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJaF7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 01:59:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CNT6C0Y0wz15Ntk;
        Sat, 31 Oct 2020 13:59:47 +0800 (CST)
Received: from localhost (10.174.176.180) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 13:59:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <keescook@chromium.org>, <anton@enomsg.org>, <ccross@android.com>,
        <tony.luck@intel.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] pstore: Fix passing zero to 'PTR_ERR' warning
Date:   Sat, 31 Oct 2020 13:59:31 +0800
Message-ID: <20201031055931.42844-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:

fs/pstore/platform.c:320 allocate_buf_for_compression() warn: passing zero to 'PTR_ERR'

crypto_alloc_comp() never return NULL, use IS_ERR
instead of IS_ERR_OR_NULL to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/pstore/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 36714df37d5d..b7a2a2a31dee 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -315,7 +315,7 @@ static void allocate_buf_for_compression(void)
 	}
 
 	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
-	if (IS_ERR_OR_NULL(ctx)) {
+	if (IS_ERR(ctx)) {
 		kfree(buf);
 		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
 		       PTR_ERR(ctx));
-- 
2.17.1

